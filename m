Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5E9620387
	for <e@80x24.org>; Tue, 18 Jul 2017 20:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbdGRUtg (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 16:49:36 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33170 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752060AbdGRUtf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 16:49:35 -0400
Received: by mail-pf0-f196.google.com with SMTP id e199so3925831pfh.0
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 13:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hlat7bOXO0eKgOm27s73DQ7V+wBTBs6+fPEcRaHvN+k=;
        b=HZ6KOcfrNGTGEIb3I8iMzHbWetUp/6fhT9TIaBixqvzHx9Dwq+AkCZ9VVJZYyLvlV5
         MYtyH+IjezYjjVkf5B9fra2zmab0BYE1vsg08vFgkdEDyxZKDq/36fbErp8Y1AKLxwBq
         DGekEXtzHtyfZlpUOJPIYtsSM9Z2BBML2P0zlu0+d/wW+O1luVCruNy/4dDVt9CsjqxG
         ur8IOpNY67KVxeufgdAUooh0MLFUbhDEh4up7Cg64yjx6GnjLpfzZozh+4s40DpD4BiE
         CLiabDGsfWkkNoQKwvS8Ujou3h1864fkRCrxVMoV94jbxCd7MPUMNybbi3enS8iNnH+H
         VJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hlat7bOXO0eKgOm27s73DQ7V+wBTBs6+fPEcRaHvN+k=;
        b=c1ZV5dhbXs58fwB+4jcgK3yASVkXe/c8UGgQpueT1irVC/l1hZlhwIFgHMgJ8eiNI9
         yuIqzL1YHeHKlhD7kcuRzbSMWrqRiqi9UcT5KZ5tQOGEQVXAkEMqlXbPtt7wL5GUcRx1
         D3Y3rtKHa7pxLhq3L7JTDRjo+YOvwvhypSwz6r2yZhn458osknxHyYov1yjeNIaXmmMo
         GXz6pELBkCz72rs+jZcled84Cv09HnbbyIlWMPBqVRU0Iy9B3tJZgnuCH8L2cGMkJCSw
         Ai6l+SPgXjGevdK+0l5Ym8lNLBlGlUuD7aYycz9DWAuhb172wZSPjdjPsPZ/A0NfAd7a
         mKWA==
X-Gm-Message-State: AIVw110d/pHIUWLlDttRPN19x+xAgkfdktAeVCzBZnbIJfmF8PRfqLll
        CkfsCEvc8FOJRz65tUE=
X-Received: by 10.84.218.66 with SMTP id f2mr3854578plm.206.1500410975100;
        Tue, 18 Jul 2017 13:49:35 -0700 (PDT)
Received: from localhost.localdomain ([47.11.2.197])
        by smtp.gmail.com with ESMTPSA id e5sm402742pfd.41.2017.07.18.13.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Jul 2017 13:49:34 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 3/8] submodule: port set_name_rev() from shell to C
Date:   Wed, 19 Jul 2017 02:18:59 +0530
Message-Id: <20170718204904.3768-4-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170718204904.3768-1-pc44800@gmail.com>
References: <20170718204904.3768-1-pc44800@gmail.com>
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
 builtin/submodule--helper.c | 63 +++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 16 ++----------
 2 files changed, 65 insertions(+), 14 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e41572f7a..80f744407 100644
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

