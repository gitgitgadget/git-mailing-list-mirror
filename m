Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A1E31F4DD
	for <e@80x24.org>; Mon, 28 Aug 2017 11:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751250AbdH1L4d (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Aug 2017 07:56:33 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38059 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751225AbdH1L4c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2017 07:56:32 -0400
Received: by mail-pg0-f68.google.com with SMTP id t3so195346pgt.5
        for <git@vger.kernel.org>; Mon, 28 Aug 2017 04:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TgLxGLxmeVoixgUNfb8Q+UYCEfTN3xhE7OEEBvlwoNk=;
        b=h+xoJ6ded1x4waoG9hEc46geu0l0tzxjQhbrFpM57PUr6j1jZaYud1p44hjgcqYg2H
         nb5ljFMduxSY+KBmMvjeoqSt1p8mAOEmRzPV0nmroDrHuIZIqyviJtQ690PilIKb+wqA
         6DBsxDHl4+3Fg80jQiCYoZRZ2tQvX/LqrfYZdmCN8Rr5UONyyDBTEhuovxr7k/4gZ+dw
         OVM+YCqFVejZeG/LGcZvrey2K2p7R56/dyxaO/PdEiHI1Lg2n4QwK+AwUONmEC/wOn7G
         gJRBHxcL7XfhrOJRwHQrKb6blZGxWsO3+/OXsZ+AzKP2fFMir5Oy5rehVad76wrOuh4N
         7vMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TgLxGLxmeVoixgUNfb8Q+UYCEfTN3xhE7OEEBvlwoNk=;
        b=DOiaBNWcitfCbG2W1Wg7dc4MbHPGBbLCfWNZCtGM+Mea8EH+/eqb975CUBTQJWF81F
         e2+4f5vXhBZZota6ZmHX3R8lDiQ+Kgxn0Y5aTsYQfFS6thrd4AkwPaG/FywR1FLwuNLs
         81NEvYtrAAaDMcbuYZnQEl4qyQo4U5JLOb05YrVtmkeKqmnPXDEYBsAqEs9j0V3AV2yf
         dVy0dmCJljibuJETEHUvJaQL6P/i7/mMsgPajadgtJx0DjA/vpSGzXhJkeRK7+Gof3qo
         CYFBsBXNBaA4pDpdwuhO+ttXLzScWKA6YHdul66gjIKqMSGF315zP0WtRIqt9QGXtxBz
         Kd9g==
X-Gm-Message-State: AHYfb5i+AIFfd7IWs+SGm2ui9EuFBSlbR94mGvd/uErR0A8dZzzxUWYU
        FCqm+cvwa9LRbTZ6/EOMzg==
X-Received: by 10.84.210.200 with SMTP id a66mr265493pli.161.1503921391945;
        Mon, 28 Aug 2017 04:56:31 -0700 (PDT)
Received: from localhost.localdomain ([223.176.49.60])
        by smtp.gmail.com with ESMTPSA id h70sm748608pfc.92.2017.08.28.04.56.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Aug 2017 04:56:29 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     gitster@pobox.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, pc44800@gmail.com,
        sbeller@google.com
Subject: [GSoC][PATCH v4 3/4] submodule: port set_name_rev() from shell to C
Date:   Mon, 28 Aug 2017 17:25:57 +0530
Message-Id: <20170828115558.28297-4-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170828115558.28297-1-pc44800@gmail.com>
References: <xmqqlgm7scpm.fsf@gitster.mtv.corp.google.com>
 <20170828115558.28297-1-pc44800@gmail.com>
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
index ea99d8e39..85df11129 100644
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
@@ -1292,6 +1354,7 @@ static struct cmd_struct commands[] = {
 	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
+	{"get-rev-name", get_rev_name, 0},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index 66d1ae8ef..5211361c5 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -758,18 +758,6 @@ cmd_update()
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
@@ -1041,14 +1029,14 @@ cmd_status()
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

