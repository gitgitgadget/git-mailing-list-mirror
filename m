Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.1 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 682751F667
	for <e@80x24.org>; Mon, 21 Aug 2017 10:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753179AbdHUKpo (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 06:45:44 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38460 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753165AbdHUKpn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 06:45:43 -0400
Received: by mail-pg0-f65.google.com with SMTP id t3so2885212pgt.5
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 03:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lmUf6aKX7uVxpp5JDBhzFKOt/LAzusBfUgt/xMv9ukc=;
        b=iM1iN5g5IXZmRDaWKn11KI/q9BbJoyUnjYepMoJewY3pgliN8BQlCyrgj/8Utr+eNT
         4MFnHZZdPSOZOvQhcUp7bxGHPAcCFynJOZ8ZijfFTz5Fg8bYzERrsOqJ7jDEryjCSOXb
         VgCle7zTmB9H7XtHWVWNzg7fYUjqKwNP8b1Fr0U8I/lF3KwXR6Dzr13Zsnlk4iX5Tw+K
         q3OWYefkjv9tSXK6D0rFgDLO8BJIS04rNAC7ZKdNBZgjrt7ehx8oKV50vPLoZ0KS1PRZ
         LyJWatw/XnQHYHnht/PF3fTa88uFzoGPcTXilDmaVj1rr/3g8Rdh1g97VxR3lkQqehj2
         2Scg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lmUf6aKX7uVxpp5JDBhzFKOt/LAzusBfUgt/xMv9ukc=;
        b=rVkfK3qDaq6MOH04ZBkxQG7FOkWtZVXxKd6nDYuhdoMCkRrheEYNiV06sxOaL0ypjV
         IdZTatb1vRDaJxShxwwlC5SqDh/mbkeCfwjRsOux1dfmedIF6s5c/cfs/7EVCFot5wz4
         SZw9L+TLIAq7rGqAUxVfBhcmIkIFxdtgEunmU8zwfjjvTwyOSYXblBMQrn5JvHxquo63
         gIxkCpPv5qmNhWCYMyFfNlXv32aSi2I73zIohy5AhVrKgIi36aaLaj1iffMlGM1c6e0N
         yFkbFyC9mmPo/6amQdTyyaZnsVsVqlMBj11M3S1F8ejPaBIYzpf12EHrb5sAFaZ90xwY
         Ug+A==
X-Gm-Message-State: AHYfb5irPo+DqylpH5kJTGxHOUsgi/r33KdtswLaZdp1BW/fq2Bshl4C
        c+PkmjCqoGjz3CPB84w=
X-Received: by 10.98.16.203 with SMTP id 72mr16504725pfq.290.1503312342785;
        Mon, 21 Aug 2017 03:45:42 -0700 (PDT)
Received: from localhost.localdomain ([223.191.53.21])
        by smtp.gmail.com with ESMTPSA id l24sm20445785pgo.43.2017.08.21.03.45.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Aug 2017 03:45:42 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com, gitster@pobox.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 3/4] submodule: port set_name_rev() from shell to C
Date:   Mon, 21 Aug 2017 21:45:14 +0530
Message-Id: <20170821161515.23775-3-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170821161515.23775-1-pc44800@gmail.com>
References: <20170821161515.23775-1-pc44800@gmail.com>
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
index 7803457ba..a4bff3f38 100644
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
+	free(namerev);
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

