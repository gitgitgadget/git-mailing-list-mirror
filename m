Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBF542047F
	for <e@80x24.org>; Sun, 24 Sep 2017 12:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752241AbdIXMJZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Sep 2017 08:09:25 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34293 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751868AbdIXMJX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2017 08:09:23 -0400
Received: by mail-pg0-f67.google.com with SMTP id u18so3372918pgo.1
        for <git@vger.kernel.org>; Sun, 24 Sep 2017 05:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1RA88v/0+6Keyu200/yYPBc0+mHQsS2AzF6n1n3/qO8=;
        b=JXZQ7V5NbwdjLzupiEzPk9zM/gNtAIZRAPk09PVp8o++VMUgqk3PmI0uUUgaBw+iV3
         etRxE8vPqRvpRKPIdiKWAnjZmKf0eAWREnGj4skYu9XmiJvZdtOIBip0iZ9tiKco7HN0
         A3Ecr1+SmkybYneadZZVJBk50GtL2AC5N9/LwlZJb47PrsovY0PQYNPP2tih7H29MKT5
         njZYLO73WyzsQnrJ8Cc1vcb+S2ieV05V9bsc+PX7fWuMsEWbC+KEcgrb9U3h/CyUuDnM
         5kbECDCtAmdY2NoHRxDCyihZzNm/UvB2+o/itmXzlTiR7AjFIHxOvNTNgjLm726BYelQ
         dF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1RA88v/0+6Keyu200/yYPBc0+mHQsS2AzF6n1n3/qO8=;
        b=JAGi9VFN+i5gTAoSTLSUjbmYVsyWSoN9dbRBKuGEED9dEBeqBY21aiaf1JyfMY0IUr
         1ABxoiA80GGm9f4XPFhzFdtWfQ9Ho2ZvqAgYtGSTPEVC6EvdksQhTj7kD2zM+XAakDQn
         o8fEQ6ynjwn1scEdQLmXQwMZvEReEZBd237hBwnXy+yCFNNPetUSVz595sOFVTNKaa7+
         PHkkMYBgMScjnTwaiPjDdsy3HYDo1KK7TVcT8bmN7SlYbcVx66tc36jP9Z9yEd+X1qK9
         SRR1d5BEyexuWSKO/fR0ppcoVrFE1as+ENRPqgm0BQ49m0i4FzByukcGfAefMiprUfJt
         Uztw==
X-Gm-Message-State: AHPjjUj1nOG59rqIHRQeJxHvNZ3sJZ/i223z7w6lUR2MUqgHhjS2We0q
        ooTNqJXtsPv6P8U/O7XAghw=
X-Google-Smtp-Source: AOwi7QCKT4a39C/2A18TubcdJLmuwmspn0hLW+sofpRwefgewZhRufsXV4YvHP/d78Zt9S9yvQDCfA==
X-Received: by 10.159.194.129 with SMTP id y1mr4459471pln.367.1506254962794;
        Sun, 24 Sep 2017 05:09:22 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.87])
        by smtp.gmail.com with ESMTPSA id 65sm6908123pgh.31.2017.09.24.05.09.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Sep 2017 05:09:22 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     hanwen@google.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        pc44800@gmail.com, sbeller@google.com
Subject: [PATCH v5 3/4] submodule: port set_name_rev() from shell to C
Date:   Sun, 24 Sep 2017 17:38:57 +0530
Message-Id: <20170924120858.26813-4-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170924120858.26813-1-pc44800@gmail.com>
References: <20170921161059.11750-1-hanwen@google.com>
 <20170924120858.26813-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Function set_name_rev() is ported from git-submodule to the
submodule--helper builtin. The function compute_rev_name() generates the
value of the revision name as required.
The function get_rev_name() calls compute_rev_name() and receives the
revision name, and later handles its formatting and printing.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 builtin/submodule--helper.c | 63 +++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 16 ++----------
 2 files changed, 65 insertions(+), 14 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d12790b5c..7ca8e8153 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -246,6 +246,68 @@ static char *get_submodule_displaypath(const char *path, const char *prefix)
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
@@ -1293,6 +1355,7 @@ static struct cmd_struct commands[] = {
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

