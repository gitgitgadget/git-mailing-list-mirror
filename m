Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF9AE20285
	for <e@80x24.org>; Thu, 24 Aug 2017 19:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753492AbdHXTvt (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 15:51:49 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38545 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753025AbdHXTvt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 15:51:49 -0400
Received: by mail-pg0-f66.google.com with SMTP id t3so635528pgt.5
        for <git@vger.kernel.org>; Thu, 24 Aug 2017 12:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=35F7N3VA4JxXipgyyUuJ0wJ/w9k3UUcIJ8Elaat3tzY=;
        b=CIFrhRyN3faosa16YPRoeHWTvzc+K9wPt6baLXIq95UAXU7uHMirAYC7cdhNqmMzuk
         mXJUdVIf1SmwsBI+6Aq4rX3cPXZoDfn991yhpHjRod+RT0UT6jWSW5VNYUdTR8Y2QDFl
         LI5aKzNDzxrLesvPVeweHN4zw9p/AZHsNjNgOuJ9BvySl3+SeKfWgfmwqr5wyjDNO44B
         le4Jq8IxHB4uIYCpcb1Sjfgv3ShRdskeWgkAij/hgSgw/ZKD9MY1H/CpQwwuWu5qhfp9
         k6TiFVCu4/FMiXUkW+Rt8JABrVbLRiVa1GCjoFd3YaF4Dpy4l0tcLZexNSrTQVMa4Yrl
         DtOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=35F7N3VA4JxXipgyyUuJ0wJ/w9k3UUcIJ8Elaat3tzY=;
        b=N5t1uOF5ae707g135+rQeQfx1Tmrfw2nLGRSAYGoYVxMw9Nvc37EKaXEUhs7VwnnSJ
         GGcHqnUUVdEwp6GSlVpNtA9nzUM38JJPimYpuYWFTj7HMEbws/CjwL+U5VNAZRWeFbbH
         /JrCrRJ4TFAWTBhZukSLcHcDGb54IyGHKnv2uP2iNiGjoEO7Y49JeN/6YQLhGGaK5Stj
         y+jYA1ndlBQLaMfJUgw7ceImbpbn4+cYggZ33sWqA9q97bb6gaJ2S6UyKFC+YJmrtWZm
         k5VurIPSGOevx32gNqaKzF+uvvuCfyVYitZ551152Trw7EcIKcn4k22aiHMq5EPH66qj
         Tr+Q==
X-Gm-Message-State: AHYfb5hCARIjWKpsjuC/8UZV7YH3haBz3Job/162n/m4195hwZMedAkw
        eb065XoAzZFbrA==
X-Received: by 10.84.231.131 with SMTP id g3mr7918835plk.283.1503604308487;
        Thu, 24 Aug 2017 12:51:48 -0700 (PDT)
Received: from localhost.localdomain ([27.63.191.1])
        by smtp.gmail.com with ESMTPSA id v2sm9074270pfl.21.2017.08.24.12.51.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Aug 2017 12:51:47 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     gitster@pobox.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, pc44800@gmail.com,
        sbeller@google.com
Subject: [GSoC][PATCH v3 3/4] submodule: port set_name_rev() from shell to C
Date:   Fri, 25 Aug 2017 01:20:50 +0530
Message-Id: <20170824195051.30900-4-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170824195051.30900-1-pc44800@gmail.com>
References: <xmqq7exuysc7.fsf@gitster.mtv.corp.google.com>
 <20170824195051.30900-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Function set_name_rev() is ported from git-submodule to the
submodule--helper builtin. The function compute_rev_name() generates the
value of the revision name as required.
The function get_rev_name() calls compute_rev_name() and receives the
revision name, and later handles its formating and printing.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 builtin/submodule--helper.c | 63 +++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 16 ++----------
 2 files changed, 65 insertions(+), 14 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 8cd81b144..6ea6408c2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -245,6 +245,68 @@ static char *get_submodule_displaypath(const char *path, const char *prefix)
 	}
 }
 
+static char *compute_rev_name(const char *sub_path, const char* object_id)
+{
+	struct strbuf sb = STRBUF_INIT;
+	const char ***d;
+
+	static const char *describe_bare[] = {
+		NULL
+	};
+
+	static const char *describe_tags[] = {
+		"--tags", NULL
+	};
+
+	static const char *describe_contains[] = {
+		"--contains", NULL
+	};
+
+	static const char *describe_all_always[] = {
+		"--all", "--always", NULL
+	};
+
+	static const char **describe_argv[] = {
+		describe_bare, describe_tags, describe_contains,
+		describe_all_always, NULL
+	};
+
+	for (d = describe_argv; *d; d++) {
+		struct child_process cp = CHILD_PROCESS_INIT;
+		prepare_submodule_repo_env(&cp.env_array);
+		cp.dir = sub_path;
+		cp.git_cmd = 1;
+		cp.no_stderr = 1;
+
+		argv_array_push(&cp.args, "describe");
+		argv_array_pushv(&cp.args, *d);
+		argv_array_push(&cp.args, object_id);
+
+		if (!capture_command(&cp, &sb, 0) && sb.len) {
+			strbuf_strip_suffix(&sb, "\n");
+			return strbuf_detach(&sb, NULL);
+		}
+	}
+
+	strbuf_release(&sb);
+	return NULL;
+}
+
+static int get_rev_name(int argc, const char **argv, const char *prefix)
+{
+	char *revname;
+	if (argc != 3)
+		die("get-rev-name only accepts two arguments: <path> <sha1>");
+
+	revname = compute_rev_name(argv[1], argv[2]);
+	if (revname && revname[0])
+		printf(" (%s)", revname);
+	printf("\n");
+
+	free(revname);
+	return 0;
+}
+
 struct module_list {
 	const struct cache_entry **entries;
 	int alloc, nr;
@@ -1243,6 +1305,7 @@ static struct cmd_struct commands[] = {
 	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
+	{"get-rev-name", get_rev_name, 0},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index e131760ee..91f043ec6 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -759,18 +759,6 @@ cmd_update()
 	}
 }
 
-set_name_rev () {
-	revname=$( (
-		sanitize_submodule_env
-		cd "$1" && {
-			git describe "$2" 2>/dev/null ||
-			git describe --tags "$2" 2>/dev/null ||
-			git describe --contains "$2" 2>/dev/null ||
-			git describe --all --always "$2"
-		}
-	) )
-	test -z "$revname" || revname=" ($revname)"
-}
 #
 # Show commit summary for submodules in index or working tree
 #
@@ -1042,14 +1030,14 @@ cmd_status()
 		fi
 		if git diff-files --ignore-submodules=dirty --quiet -- "$sm_path"
 		then
-			set_name_rev "$sm_path" "$sha1"
+			revname=$(git submodule--helper get-rev-name "$sm_path" "$sha1")
 			say " $sha1 $displaypath$revname"
 		else
 			if test -z "$cached"
 			then
 				sha1=$(sanitize_submodule_env; cd "$sm_path" && git rev-parse --verify HEAD)
 			fi
-			set_name_rev "$sm_path" "$sha1"
+			revname=$(git submodule--helper get-rev-name "$sm_path" "$sha1")
 			say "+$sha1 $displaypath$revname"
 		fi
 
-- 
2.13.0

