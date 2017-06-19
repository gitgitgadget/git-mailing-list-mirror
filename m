Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C66511FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 21:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752676AbdFSVu5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 17:50:57 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34938 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752665AbdFSVuy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 17:50:54 -0400
Received: by mail-pg0-f65.google.com with SMTP id f127so18208802pgc.2
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 14:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/0kw1O0CvQgAbp/LvP8ALH02v3kQVlmnnD76AEwGDUw=;
        b=fdNr/JPESjgzUZ2nSsopwKf4roGTaBd56dFkn9ZF17OUvp77qgCRy0fDiRWqNNOnUe
         f6oqjSvENcnwz9HJ8jYmeHU5HLpESJu6DG5Vu5dGqIlscOG3EcS/x6hH2MYxygx1cHcD
         4HRCDtdnK1RP4+copOJfk4wWPMGMNv7c3yNZ7Cy0QMmATaF/Hu6YrvmJw2RPQrXmYEUk
         i8+gmuTwuSBFdsGltQvXEDhzFOZCqjIcSsgr5RLDeSTQLjxAoaXDIDxmfoz6hbKmZjOm
         Sk7Y777YVr5Z7HXX96l0jTkkc0ebV2Z/dbJd7nkQaIogDX71+qJCYXfmRBi84ui2W3dD
         FBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/0kw1O0CvQgAbp/LvP8ALH02v3kQVlmnnD76AEwGDUw=;
        b=SivzKLxJYeVZ76ubkaZ+VPYhJXFtqaT/WEiVwufhEmqekVENRU26lN3iPBv9leKqlz
         pZwovCR4btz7pqP0qwH0oWHaVs4yuK5tQ382oC+FvCPVINM1Yvu5Iy4u6d1lJ+m/Lp4z
         ubdjisF/Y7Q23mBf33Xcpoc2WFD2wk/C9MPeGm7b93X+uusIPhjofWCxHauxl3z7jBAT
         9JoLXmmWv5CsHIHiveMbiO3HK6ORaaAIMXP2m5gGY9DZ7rO8qae4DlbkeOEFGJ2LpuIA
         ThBxDGjwXRsdQK3gj2NwurlBvwaE84GQAA09OKVA2tjvt7XbZ1luo8tY3RpvVjL+ODio
         Uiaw==
X-Gm-Message-State: AKS2vOxgp40c0rl12iVSeYDLIsb3Gugz18slY99dQS4bNZw7BDqIq2kL
        PmWKN81whnO5Sqio
X-Received: by 10.101.69.207 with SMTP id m15mr27586996pgr.242.1497909052017;
        Mon, 19 Jun 2017 14:50:52 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.60])
        by smtp.gmail.com with ESMTPSA id 5sm20744309pfe.60.2017.06.19.14.50.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 14:50:51 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 3/6] submodule: port set_name_rev from shell to C
Date:   Tue, 20 Jun 2017 03:20:22 +0530
Message-Id: <20170619215025.10086-3-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170619215025.10086-1-pc44800@gmail.com>
References: <CAME+mvUQJFneV7b1G7zmAidP-5L=nimvY43V0ug-Gtesr83tzg@mail.gmail.com>
 <20170619215025.10086-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since later on we want to port submodule subcommand status, and since
set_name_rev is part of cmd_status, hence this function is ported. It
has been ported to function print_name_rev in C, which calls get_name_rev
to get the revname, and after formatting it, print_name_rev prints it.
And hence in this way, the command `git submodule--helper print-name-rev
"sm_path" "sha1"` sets value of revname in git-submodule.sh

The function get_name_rev returns the stdout of the git describe
commands. Since there are four different git-describe commands used for
generating the name rev, four child_process are introduced, each successive
child process running only when previous has no stdout. The order of these
four git-describe commands is maintained the same as it was in the function
set_name_rev() in shell script.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 builtin/submodule--helper.c | 69 +++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 16 ++---------
 2 files changed, 71 insertions(+), 14 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f7adca95b..6fd861e42 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -243,6 +243,74 @@ static char *get_submodule_displaypath(const char *path, const char *prefix)
 	}
 }
 
+enum describe_step {
+	step_bare,
+	step_tags,
+	step_contains,
+	step_all_always,
+	step_end
+};
+
+static char *get_name_rev(const char *sub_path, const char* object_id)
+{
+	struct strbuf sb = STRBUF_INIT;
+	enum describe_step cur_step;
+
+	for (cur_step = step_bare; cur_step < step_end; cur_step++) {
+		struct child_process cp = CHILD_PROCESS_INIT;
+		prepare_submodule_repo_env(&cp.env_array);
+		cp.dir = sub_path;
+		cp.git_cmd = 1;
+		cp.no_stderr = 1;
+
+		switch (cur_step) {
+			case step_bare:
+				argv_array_pushl(&cp.args, "describe",
+						 object_id, NULL);
+				break;
+			case step_tags:	
+				argv_array_pushl(&cp.args, "describe",
+						 "--tags", object_id, NULL);
+				break;
+			case step_contains:
+				argv_array_pushl(&cp.args, "describe",
+						 "--contains", object_id,
+						 NULL);
+				break;
+			case step_all_always:
+				argv_array_pushl(&cp.args, "describe",
+						 "--all", "--always",
+						 object_id, NULL);
+				break;
+			default:
+				BUG("unknown describe step '%d'", cur_step);
+		}
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
@@ -1242,6 +1310,7 @@ static struct cmd_struct commands[] = {
 	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
+	{"print-name-rev", print_name_rev, 0},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index c0d0e9a4c..091051891 100755
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

