Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BFEC201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 20:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752882AbdGCUcv (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 16:32:51 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34725 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdGCUcs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2017 16:32:48 -0400
Received: by mail-pf0-f193.google.com with SMTP id c24so12334029pfe.1
        for <git@vger.kernel.org>; Mon, 03 Jul 2017 13:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8tAIhMwlVJ8p7tWZUndynvyo8D14zksAGB2joS3+hMI=;
        b=IDFMPdLNdh3EYMG/Qy4+8NOFp2maehXsSfXKzaTTIie32rEFP/BFH6PRR2CvNAfeto
         fndrM/7rc177wK6EoNBLNxFpPmR7LcW/1x7jqOX6QfnX/TFRSXxLUfFEYDXI23ajHlzi
         kMB3ioha0x8eHgiSBzxBGoPo8Hvdd2wOoZjW6N9PetpM272bTUE9lfIfOK/FbR81pZJf
         OGbT/wCz+tRWzjiedhRMJE5xTISusFh8puu/fd/IUOIxR7PoeDzCP8lMTLeeMU5iFQud
         09oVve7D67r0RUDuiF7M3WA58Mt3iFxl9JZuQ8fzV3dRcSKsBkQCXWTeSPp1/Yd6P3DW
         otjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8tAIhMwlVJ8p7tWZUndynvyo8D14zksAGB2joS3+hMI=;
        b=Cq4uwXk+YDx73SYiVXlS4VW9ccHwb5nqq0FjSDNO6ok5bA6rhq+jn21khbsEhAhMNf
         7V3Y5xmXKCxfn0yU1B7+GYYo/zuUyUmhZWYSMom+uT80V8wrdxFNWuZMhLHKDOjZBllf
         /cB20w7YYbyhovzbpWCLTYM0iBjSb4fzaDIwSUdSX3q5IlOblb6dJIPN8EzDZv1znurc
         6PrVZXtF9R1ezXMgCPCG4Q/rnnWi0KjC/DFckOTXoU0fCMokMK4OYBNERwlDAbUg9/2/
         oqZDYcquqbplstW0pOY6ieUVZ/fDKfb88gUp/XyFJxwcBQcd3bHdbXGjQ6DP9C6JbsT/
         tkkQ==
X-Gm-Message-State: AIVw110DvwghcpDkoH0jPy2ayuebGh6IyKyzvE5EU9vEfn8M+9S5rzw9
        UVJV+LiY4REVz8aA
X-Received: by 10.99.105.4 with SMTP id e4mr9562908pgc.228.1499113967584;
        Mon, 03 Jul 2017 13:32:47 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.60])
        by smtp.gmail.com with ESMTPSA id y192sm28558594pgd.38.2017.07.03.13.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Jul 2017 13:32:47 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com, gitster@pobox.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 3/5 v4] submodule: port set_name_rev() from shell to C
Date:   Tue,  4 Jul 2017 02:02:20 +0530
Message-Id: <20170703203222.14051-3-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170703203222.14051-1-pc44800@gmail.com>
References: <CAME+mvVRSovmXLDUzz8dNiruvLrXFv3iUifqXDm+HwQDu1mJpQ@mail.gmail.com>
 <20170703203222.14051-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Function set_name_rev() is ported from git-submodule to the
submodule--helper builtin. The function get_name_rev() generates the
value of the revision name as required, and the function
print_name_rev() handles the formating and printing of the obtained
revision name.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
As suggested the unnecessary enum present was removed.

 builtin/submodule--helper.c | 63 +++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 16 ++----------
 2 files changed, 65 insertions(+), 14 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c4286aac5..5884a9725 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -244,6 +244,68 @@ static char *get_submodule_displaypath(const char *path, const char *prefix)
 	}
 }
 
+static char *get_name_rev(const char *sub_path, const char* object_id)
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
+
+	}
+
+	strbuf_release(&sb);
+	return NULL;
+}
+
+static int print_name_rev(int argc, const char **argv, const char *prefix)
+{
+	char *namerev;
+	if (argc != 3)
+		die("print-name-rev only accepts two arguments: <path> <sha1>");
+
+	namerev = get_name_rev(argv[1], argv[2]);
+	if (namerev && namerev[0])
+		printf(" (%s)", namerev);
+	printf("\n");
+
+	return 0;
+}
+
 struct module_list {
 	const struct cache_entry **entries;
 	int alloc, nr;
@@ -1242,6 +1304,7 @@ static struct cmd_struct commands[] = {
 	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
+	{"print-name-rev", print_name_rev, 0},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index e131760ee..e988167e0 100755
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
+			revname=$(git submodule--helper print-name-rev "$sm_path" "$sha1")
 			say " $sha1 $displaypath$revname"
 		else
 			if test -z "$cached"
 			then
 				sha1=$(sanitize_submodule_env; cd "$sm_path" && git rev-parse --verify HEAD)
 			fi
-			set_name_rev "$sm_path" "$sha1"
+			revname=$(git submodule--helper print-name-rev "$sm_path" "$sha1")
 			say "+$sha1 $displaypath$revname"
 		fi
 
-- 
2.13.0

