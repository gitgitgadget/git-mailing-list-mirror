Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 009B8207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 23:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbdFZXLb (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 19:11:31 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36560 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbdFZXL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 19:11:29 -0400
Received: by mail-pf0-f195.google.com with SMTP id z6so2130725pfk.3
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 16:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5RZLxYSfIjGJUtua1Lmqk5jkpFQXpxAsFQgUA2GWgDs=;
        b=FlCCGMRou/RHTdTEw5gg/gdlvcAY5EiIYBlTgfYQgswIIwcubvtZiDnMbbMpKTFREk
         AmVPke7/QvwD/zEzjVMR2iPA7CPT2LYmMiUvFDln1fS9+38GfAHRe40+2iTtJo1qPPkK
         H+cDxCmu9uSB2J/PUec+EAbltbdsjdUxJo05s1xI+YDM6OdwRbmAK4siU2a/ZXsBc4tM
         3eD3+zU/cdhmKwyaQ0ufhC9SbOXMGPuWcC0ORaZPJ0Zc/wQtz5WSYOfLJbA99Q5kD8cx
         rYSUmN8M3OTKBhkzwEoEk8mmMq3reqIRe/V2lz+Z50ct3xB5D4Md1AKkzDrJUan3mpj0
         JLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5RZLxYSfIjGJUtua1Lmqk5jkpFQXpxAsFQgUA2GWgDs=;
        b=ekygBsRPyDVC4h9xG8KT4AOITxbwXi9/sz6if0sitHl0C/n78tVE8ejwMZyM6bSowx
         PTIm5o1IkBSa/gSUlymXOUVDC9i/hkaBlLWP9d4tPQeVISZU4KpKmULYXHJKHV4agpvc
         CvsdTggHPbxAzRueCNEYeE4RAAExiOS/FfWdUa2ysTN9rm4UQI7qJGynWatGTe0rHihw
         DTINhIS0kU67K7sW+e2usBi/2KPzNObKpgx1B0ZHg9OnvVT3GFk2tSuvF2TJsbSmMGt8
         5yTneO4pvyoc9zMwotEJigzmieDFsNf4u/VzKhSTjnHDPyMGamF89gMFe40LgomaBWLS
         dRKQ==
X-Gm-Message-State: AKS2vOxwq8VLw7qu86eLaCdp1IGMoNNG4E78OkatNQEmDBRxZzxpiB3O
        vWN1IPjCg/8/tpsN
X-Received: by 10.84.229.79 with SMTP id d15mr2648500pln.4.1498518687456;
        Mon, 26 Jun 2017 16:11:27 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.60])
        by smtp.gmail.com with ESMTPSA id p5sm1701339pgf.50.2017.06.26.16.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Jun 2017 16:11:27 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     pc44800@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, sbeller@google.com
Subject: [GSoC][PATCH 3/6 v2] submodule: port set_name_rev from shell to C
Date:   Tue, 27 Jun 2017 04:41:05 +0530
Message-Id: <20170626231108.23640-3-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170626231108.23640-1-pc44800@gmail.com>
References: <CAME+mvUrr8EA-6jbCZdpB7dMZ5CN3RyY7yoRoUBoiZw=sH6Ysw@mail.gmail.com>
 <20170626231108.23640-1-pc44800@gmail.com>
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
index 5180659fd..86112ac92 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -244,6 +244,74 @@ static char *get_submodule_displaypath(const char *path, const char *prefix)
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
@@ -1405,6 +1473,7 @@ static struct cmd_struct commands[] = {
 	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
+	{"print-name-rev", print_name_rev, 0},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index c88e0ff7e..b28a6ba8e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -722,18 +722,6 @@ cmd_update()
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
@@ -1005,14 +993,14 @@ cmd_status()
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

