Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B905520899
	for <e@80x24.org>; Wed, 23 Aug 2017 18:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932533AbdHWSTs (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 14:19:48 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34134 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932111AbdHWSTq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 14:19:46 -0400
Received: by mail-pg0-f65.google.com with SMTP id p14so238615pgd.1
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 11:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FLDGPxde/0BxZ9FTmt5wTGqJgp/TSTv43g7Q5hj6G9c=;
        b=eu18pj5XRjbAUFwhsSzO6Zn62GSIuMhbs7VRVRrgqISeYmdOL0HO3zbBJy7Tx7XMCM
         m7+bCq/tBSH3BVDML6BBrceHu3y9QuYUe+eOo61+tjaqucisncbtNKRia+NMyfinQDU6
         lLUVH7EFE21dJduraQEVikZ0qgZJP0CZDalKWTuTBAvmNRpL4ogrKHDvaXZuuNgYpRV8
         p2rPSM3u+LGkqkJcCie1tp6JLuOeC4MNG/OLCu0wypVc0Z5m4w5RZrrpjnxh0ceXk740
         EfWxoXFA34s9oarS11vK5SakGDl7hHNItEItZCpvq53MXgcJ8sbaeHDA6Qncz3odlI7r
         qZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FLDGPxde/0BxZ9FTmt5wTGqJgp/TSTv43g7Q5hj6G9c=;
        b=UbxtirbOnIq/lVLEX24XzMKMqMOCgYCOgnqjOLfgDTaG7rIhOAUMaoBiOUQSou5iXj
         6QYJoGmUgu57Shfd8BS4KFiPiVRl85AwxF0YSMWUg3JVSP/X95Zou2HY45y9gQM+pLbb
         PdKnOY9qaTOadJeKtYOxTHTCZLi5XxUJyfBjgkvOpPUWIvCiJ/M5UfY++eYSiQajiVLW
         ND03vsOFFADU2eyLjoweYNdbaDv+7SvVmb+mhUw0mqGT14HqGNtr2EgXIV0kgkcOGf8O
         RDGy2KaHgw23dV3LwntzY9eUSq6vE22qVyDRXlwPaFALCcbvozFGte2n1qaPIP8kEqLd
         sTlQ==
X-Gm-Message-State: AHYfb5jYOJWZhN5AdKNd0AwsIPDbUArMekEp+3pidOlpueM6NRWW5yHV
        6aq65L2MbubTEA==
X-Received: by 10.84.167.2 with SMTP id c2mr4105671plb.365.1503512386184;
        Wed, 23 Aug 2017 11:19:46 -0700 (PDT)
Received: from localhost.localdomain ([27.63.165.170])
        by smtp.gmail.com with ESMTPSA id 74sm5007812pfk.58.2017.08.23.11.19.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Aug 2017 11:19:45 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     gitster@pobox.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, pc44800@gmail.com,
        sbeller@google.com
Subject: [GSoC][PATCH v2 3/4] submodule: port set_name_rev() from shell to C
Date:   Wed, 23 Aug 2017 23:45:05 +0530
Message-Id: <20170823181506.8557-4-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170823181506.8557-1-pc44800@gmail.com>
References: <xmqqinhf1bjf.fsf@gitster.mtv.corp.google.com>
 <20170823181506.8557-1-pc44800@gmail.com>
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
index 847fba854..6ae93ce38 100644
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

