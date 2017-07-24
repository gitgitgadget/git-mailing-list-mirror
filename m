Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38CAE203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 20:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754325AbdGXUf2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 16:35:28 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37932 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753543AbdGXUf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 16:35:26 -0400
Received: by mail-pg0-f65.google.com with SMTP id s4so12684224pgr.5
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 13:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hlat7bOXO0eKgOm27s73DQ7V+wBTBs6+fPEcRaHvN+k=;
        b=rmoR0NKBuKoO1pRZtj9X+378l58UM8RgHD32ArRMlhmnc3Ul7O2oOWEMVYeFJF6Ve4
         LUIUL6L1Mx9H6PNQJnvGH5eJKGA7huXDPd+N4ofnJeoUEhL+wgw6IU5aDIeVIs9UpLsR
         T1X5HZuWJqr7LMBMa/QkjN+RHfWZFFuPQ6ABdpTzKqRTHaW1pNEcD/e/5rPD5MRSts6H
         +fN/yuvoxVDUeVNF+1ddK+J5vmMfVmkn1H1pEC+8IAvxxHqYVCsBJDBYFWh378m1qbxC
         x0fJreDEyA+RoJJr/YTFw8Xqrz2NXWHqU8SndL5M1c6ykdPc3Io+bsE9f4LglXcUo04H
         Ae3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hlat7bOXO0eKgOm27s73DQ7V+wBTBs6+fPEcRaHvN+k=;
        b=kfIyNLIpuw3BvOm0j0XVNyZga/VVRzPagXQU4MjC7dYQwP83/32x2AHjijVwTjgPNK
         3CGKR/ZmKwE9XhkaKU9x5nxQVkRISk+AzpERvZbFew4OzWft9gK8fAEXat0ZdzLt0BsL
         Ca0fMLV5MH5ujvQNUYovxx3nWqkYN+i78l+j/UOgvaT7Z2+RJPbHrCTFTSi8+sucKoxL
         NMM29eO21psmkTUUp7RzajH0pA5cceOvFMI5js4QeTsex+1xqTb+T/gtIHncYGNNduZb
         2UUUzH1e4jPqBVpPtv6r4YQSlM1rP6nr9DRF6O/V3/NlYyicmtMu8PQ2FeSDgNQT0hOf
         b3hg==
X-Gm-Message-State: AIVw111N2Xf9EYQJz33rCTf5QrmIpIt5Rdn592P+S3qMyPCGAt/Kc/pC
        wm+Cym5/BZetBxFVWvQ=
X-Received: by 10.99.45.194 with SMTP id t185mr17606924pgt.386.1500928525500;
        Mon, 24 Jul 2017 13:35:25 -0700 (PDT)
Received: from localhost.localdomain ([47.11.10.170])
        by smtp.gmail.com with ESMTPSA id d19sm24313984pfe.24.2017.07.24.13.35.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jul 2017 13:35:24 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 03/13] submodule: port set_name_rev() from shell to C
Date:   Tue, 25 Jul 2017 02:04:44 +0530
Message-Id: <20170724203454.13947-4-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170724203454.13947-1-pc44800@gmail.com>
References: <20170724203454.13947-1-pc44800@gmail.com>
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

