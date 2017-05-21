Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56CC3201CF
	for <e@80x24.org>; Sun, 21 May 2017 12:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754047AbdEUM10 (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 May 2017 08:27:26 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36716 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753471AbdEUM1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 May 2017 08:27:24 -0400
Received: by mail-pg0-f66.google.com with SMTP id h64so14638492pge.3
        for <git@vger.kernel.org>; Sun, 21 May 2017 05:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rKmPEKCg6Eu1AzEkUJicxJkrM0ajEa6Iz1Gcn8cekD0=;
        b=MzgtzDjN7nqbg+0uLyxtnbT3v6dhqEI0PvAZZ6qSAkHkSIRJ9v+wI9/LwEp9EQxFxB
         KT2iq/ltzTkfddG8xrLR2IuRsa4womHkgtrTyuJF/BJGberJJz3186nRWoSWzOqdIs+B
         BKeFWJiyCN3dTVcnjqqeuJ9WikBDpurnVZo0QFm5+PBRzJFbflfEwZE5HZMmWo1ZLays
         Uj5Xz3FQSHnyHA5CsE+nBdQctaJ7dooVEUbbcBcJbxQDyoPUaCHtv0kwQCYjPjtOeli8
         MeCkJxcCrgFe0DSV0WncZCq1ZbCCuwp6BcIIcIzklNoPFSL5xawW1sLz33tGFzXXkny6
         lfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rKmPEKCg6Eu1AzEkUJicxJkrM0ajEa6Iz1Gcn8cekD0=;
        b=kKehaX0CMIHQSWWWKDxRTpQfxKZLnc7CTlrGrjV2OKMu9LHv8agCXpSKmZFmQs/Fty
         iCq+dmfX15q3NLoeGDl3R7Cgs+oSp/cYUOTnoH/9X7hEjXDLrTJH0GF6bDk+lLADwitq
         GJG+xltR2J3WIJGQU1ztwmcMZ+bM7VSaksAUyARlID10xN/85F8tlPMb9AmYVu1ThbCj
         6ujqddvDP5N98rqPSIYDCuSM402wQJXmbwNKEKlwjBMBhBdLy0haEmLO0NtVxozmo6IV
         Nr5oFWbm0fddkJHMyrolJEUc7CCL3tdxo9MRwKY+/nhw6Jd9GWvMBxWg2OCm+ga7GLlv
         kD0g==
X-Gm-Message-State: AODbwcAJ4jdHfN6bNYFSZq8KcYotSENIFy1Cmhe8KLi95exykT9f7/2H
        lU/EL6PAknky1w==
X-Received: by 10.99.169.10 with SMTP id u10mr19434670pge.26.1495369643310;
        Sun, 21 May 2017 05:27:23 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.73.225])
        by smtp.gmail.com with ESMTPSA id p3sm25420225pgd.36.2017.05.21.05.27.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 May 2017 05:27:22 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com, peff@peff.net,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH v1 1/2] submodule: port set_name_rev from shell to C
Date:   Sun, 21 May 2017 17:57:10 +0530
Message-Id: <20170521122711.22021-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since later on we want to port submodule subcommand status, and since
set_name_rev is part of cmd_status, hence this function is ported. It
has been ported to function set_name_rev in C, which calls get_name_rev
to get the revname, and after formatting it, set_name_prints it. And
hence in this way, the command `git submodule--helper set-name-rev
"sm_path" "sha1"` sets value of revname in git-submodule.sh

The function get_name_rev returns the stdout of the git describe
commands. Since there are four different git-describe commands used for
generating the name rev, four child_process are introduced, each successive
child process running only when previous has no stdout. The order of these
four git-describe commands is maintained the same as it was in the function
set_name_rev() before porting.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
This series of patch is based on gitster/jk/bug-to-abort for untilizing its
BUG() macro.

Since submodule subcommand used set_name_rev function, first this function
was ported before porting the subcommand to C.

Complete build report for this patch is available at:
https://travis-ci.org/pratham-pc/git/builds/
Branch: status
Build #64

Also, I have updated my Github and pushed this work. It can be seen at:
https://github.com/pratham-pc/git/commits/status

 builtin/submodule--helper.c | 65 +++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 16 ++---------
 2 files changed, 67 insertions(+), 14 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 566a5b6a6..5f0ddd8ad 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -219,6 +219,70 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
 	return 0;
 }
 
+enum describe_step {
+	step_bare = 0,
+	step_tags,
+	step_contains,
+	step_all_always,
+	step_end
+};
+
+static char *get_name_rev(int argc, const char **argv, const char *prefix)
+{
+	struct child_process cp;
+	struct strbuf sb = STRBUF_INIT;
+	enum describe_step cur_step;
+
+	for (cur_step = step_bare; cur_step < step_end; cur_step++) {
+		child_process_init(&cp);
+		prepare_submodule_repo_env(&cp.env_array);
+		cp.dir = argv[1];
+		cp.no_stderr = 1;
+
+		switch (cur_step) {
+			case step_bare:
+				argv_array_pushl(&cp.args, "git", "describe", argv[2], NULL);
+				break;
+			case step_tags:
+				argv_array_pushl(&cp.args, "git", "describe", "--tags",
+						 argv[2], NULL);
+				break;
+			case step_contains:
+				argv_array_pushl(&cp.args, "git", "describe",
+						 "--contains", argv[2], NULL);
+				break;
+			case step_all_always:
+				argv_array_pushl(&cp.args, "git", "describe", "--all",
+						 "--always", argv[2], NULL);
+				break;
+			default:
+				BUG("unknown describe step '%d'", cur_step);
+		}
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
+
+static int set_name_rev(int argc, const char **argv, const char *prefix)
+{
+	char *namerev;
+	if (argc != 3)
+		die("set-name-rev only accepts two arguments: <path> <sha1>");
+
+	namerev = get_name_rev(argc, argv, prefix);
+	if (namerev[0])
+		printf(" (%s)\n", namerev);
+
+	return 0;
+}
+
 struct module_list {
 	const struct cache_entry **entries;
 	int alloc, nr;
@@ -1212,6 +1276,7 @@ static struct cmd_struct commands[] = {
 	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
+	{"set-name-rev", set_name_rev, 0},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index c0d0e9a4c..b6eb5bcce 100755
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
+			revname=$(git submodule--helper set-name-rev "$sm_path" "$sha1")
 			say " $sha1 $displaypath$revname"
 		else
 			if test -z "$cached"
 			then
 				sha1=$(sanitize_submodule_env; cd "$sm_path" && git rev-parse --verify HEAD)
 			fi
-			set_name_rev "$sm_path" "$sha1"
+			revname=$(git submodule--helper set-name-rev "$sm_path" "$sha1")
 			say "+$sha1 $displaypath$revname"
 		fi
 
-- 
2.11.0

