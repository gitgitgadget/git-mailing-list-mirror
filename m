Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7856C1F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 11:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753127AbdBCLC2 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 3 Feb 2017 06:02:28 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:42407 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753112AbdBCLC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 06:02:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 4BA381E3856;
        Fri,  3 Feb 2017 12:02:23 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id fjNWWC3dXkeq; Fri,  3 Feb 2017 12:02:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 973291E3855;
        Fri,  3 Feb 2017 12:02:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Go4NzZRHonzf; Fri,  3 Feb 2017 12:02:22 +0100 (CET)
Received: from localhost.localdomain (46.128.140.114.dynamic.cablesurf.de [46.128.140.114])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 432751E3844;
        Fri,  3 Feb 2017 12:02:22 +0100 (CET)
From:   cornelius.weig@tngtech.com
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, j6t@kdbg.org,
        Cornelius Weig <cornelius.weig@tngtech.com>
Subject: [PATCH v2 7/7] completion: recognize more long-options
Date:   Fri,  3 Feb 2017 12:01:59 +0100
Message-Id: <20170203110159.377-8-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170203110159.377-1-cornelius.weig@tngtech.com>
References: <20170203110159.377-1-cornelius.weig@tngtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

Command completion only recognizes a subset of the available options for
the various git commands. The set of recognized options needs to balance
between having all useful options and to not clutter the terminal.

This commit adds all long-options that are mentioned in the man-page
synopsis of the respective git command. Possibly dangerous options are
not included in this set, to avoid accidental data loss. The added
options are:

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
 - shortlog: --email
 - tag: --merged --no-merged --create-reflog

Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
Helped-by: Johannes Sixt <j6t@kdbg.org>
Reviewed-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d8960cf..3545f6a 100644
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
@@ -2465,7 +2473,7 @@ _git_reset ()
 
 	case "$cur" in
 	--*)
-		__gitcomp "--merge --mixed --hard --soft --patch"
+		__gitcomp "--merge --mixed --hard --soft --patch --keep"
 		return
 		;;
 	esac
@@ -2481,7 +2489,10 @@ _git_revert ()
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
@@ -2509,7 +2520,7 @@ _git_shortlog ()
 		__gitcomp "
 			$__git_log_common_options
 			$__git_log_shortlog_options
-			--numbered --summary
+			--numbered --summary --email
 			"
 		return
 		;;
@@ -2787,8 +2798,8 @@ _git_tag ()
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

