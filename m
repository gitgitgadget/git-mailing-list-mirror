Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 127291F437
	for <e@80x24.org>; Fri, 27 Jan 2017 21:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751375AbdA0VUO (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 16:20:14 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:24622 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751382AbdA0VTO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 16:19:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 1675D1E2FE7;
        Fri, 27 Jan 2017 22:19:12 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id J2c3l6jBr15u; Fri, 27 Jan 2017 22:19:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 8CBDC1E2FBA;
        Fri, 27 Jan 2017 22:19:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lPsI14JHgjxy; Fri, 27 Jan 2017 22:19:11 +0100 (CET)
Received: from localhost.localdomain (aftr-185-17-206-252.dynamic.mnet-online.de [185.17.206.252])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 16C871E2FE7;
        Fri, 27 Jan 2017 22:19:11 +0100 (CET)
From:   cornelius.weig@tngtech.com
To:     j6t@kdbg.org
Cc:     szeder.dev@gmail.com, spearce@spearce.org, git@vger.kernel.org,
        Cornelius Weig <cornelius.weig@tngtech.com>
Subject: [PATCH v2 7/7] completion: recognize more long-options
Date:   Fri, 27 Jan 2017 22:17:03 +0100
Message-Id: <20170127211703.24910-2-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170127211703.24910-1-cornelius.weig@tngtech.com>
References: <74ecd09c-55da-3858-5187-52c286a6bf62@kdbg.org>
 <20170127211703.24910-1-cornelius.weig@tngtech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

Recognize several new long-options for bash completion in the following
commands:

 - apply: --recount --directory=
 - archive: --output
 - branch: --column --no-column --sort= --points-at
 - clone: --no-single-branch --shallow-submodules
 - commit: --patch --short --date --allow-empty
 - describe: --first-parent
 - fetch, pull: --unshallow --update-shallow
 - fsck: --name-objects
 - grep: --break --heading --show-function --function-context
         --untracked --no-index
 - mergetool: --prompt --no-prompt
 - reset: --keep
 - revert: --strategy= --strategy-option=
 - rm: --force
 - shortlog: --email
 - tag: --merged --no-merged --create-reflog

Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
Helped-by: Johannes Sixt <j6t@kdbg.org>
---
 contrib/completion/git-completion.bash | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0e09519..933bb6e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -936,6 +936,7 @@ _git_apply ()
 			--apply --no-add --exclude=
 			--ignore-whitespace --ignore-space-change
 			--whitespace= --inaccurate-eof --verbose
+			--recount --directory=
 			"
 		return
 	esac
@@ -974,7 +975,7 @@ _git_archive ()
 	--*)
 		__gitcomp "
 			--format= --list --verbose
-			--prefix= --remote= --exec=
+			--prefix= --remote= --exec= --output
 			"
 		return
 		;;
@@ -1029,6 +1030,7 @@ _git_branch ()
 			--track --no-track --contains --merged --no-merged
 			--set-upstream-to= --edit-description --list
 			--unset-upstream --delete --move --remotes
+			--column --no-column --sort= --points-at
 			"
 		;;
 	*)
@@ -1142,6 +1144,8 @@ _git_clone ()
 			--single-branch
 			--branch
 			--recurse-submodules
+			--no-single-branch
+			--shallow-submodules
 			"
 		return
 		;;
@@ -1183,6 +1187,7 @@ _git_commit ()
 			--reset-author --file= --message= --template=
 			--cleanup= --untracked-files --untracked-files=
 			--verbose --quiet --fixup= --squash=
+			--patch --short --date --allow-empty
 			"
 		return
 	esac
@@ -1201,7 +1206,7 @@ _git_describe ()
 	--*)
 		__gitcomp "
 			--all --tags --contains --abbrev= --candidates=
-			--exact-match --debug --long --match --always
+			--exact-match --debug --long --match --always --first-parent
 			"
 		return
 	esac
@@ -1284,6 +1289,7 @@ __git_fetch_recurse_submodules="yes on-demand no"
 __git_fetch_options="
 	--quiet --verbose --append --upload-pack --force --keep --depth=
 	--tags --no-tags --all --prune --dry-run --recurse-submodules=
+	--unshallow --update-shallow
 "
 
 _git_fetch ()
@@ -1333,7 +1339,7 @@ _git_fsck ()
 	--*)
 		__gitcomp "
 			--tags --root --unreachable --cache --no-reflogs --full
-			--strict --verbose --lost-found
+			--strict --verbose --lost-found --name-objects
 			"
 		return
 		;;
@@ -1377,6 +1383,8 @@ _git_grep ()
 			--max-depth
 			--count
 			--and --or --not --all-match
+			--break --heading --show-function --function-context
+			--untracked --no-index
 			"
 		return
 		;;
@@ -1576,7 +1584,7 @@ _git_mergetool ()
 		return
 		;;
 	--*)
-		__gitcomp "--tool="
+		__gitcomp "--tool= --prompt --no-prompt"
 		return
 		;;
 	esac
@@ -2456,7 +2464,7 @@ _git_reset ()
 
 	case "$cur" in
 	--*)
-		__gitcomp "--merge --mixed --hard --soft --patch"
+		__gitcomp "--merge --mixed --hard --soft --patch --keep"
 		return
 		;;
 	esac
@@ -2472,7 +2480,10 @@ _git_revert ()
 	fi
 	case "$cur" in
 	--*)
-		__gitcomp "--edit --mainline --no-edit --no-commit --signoff"
+		__gitcomp "
+			--edit --mainline --no-edit --no-commit --signoff
+			--strategy= --strategy-option=
+			"
 		return
 		;;
 	esac
@@ -2483,7 +2494,7 @@ _git_rm ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "--cached --dry-run --ignore-unmatch --quiet"
+		__gitcomp "--cached --dry-run --ignore-unmatch --quiet --force"
 		return
 		;;
 	esac
@@ -2500,7 +2511,7 @@ _git_shortlog ()
 		__gitcomp "
 			$__git_log_common_options
 			$__git_log_shortlog_options
-			--numbered --summary
+			--numbered --summary --email
 			"
 		return
 		;;
@@ -2778,8 +2789,8 @@ _git_tag ()
 	--*)
 		__gitcomp "
 			--list --delete --verify --annotate --message --file
-			--sign --cleanup --local-user --force --column --sort
-			--contains --points-at
+			--sign --cleanup --local-user --force --column --sort=
+			--contains --points-at --merged --no-merged --create-reflog
 			"
 		;;
 	esac
-- 
2.10.2

