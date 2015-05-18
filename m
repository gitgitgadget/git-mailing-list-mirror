From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 2/2] work in progress
Date: Mon, 18 May 2015 21:30:46 +0800
Message-ID: <1431955855-16228-2-git-send-email-pyokagan@gmail.com>
References: <1431955855-16228-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 15:31:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuL8s-0008UR-3K
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 15:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbbERNbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 09:31:33 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33351 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbbERNbb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 09:31:31 -0400
Received: by padbw4 with SMTP id bw4so152551330pad.0
        for <git@vger.kernel.org>; Mon, 18 May 2015 06:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MbMQRplTfjF1bUstU8XaBoQIkh7uLhDmSk0xlU5sVl8=;
        b=sA/+KgCoJf4nyz9V5D2OjG3NjAzgDT1oRmVzlG1guQataHo7bPiH4AJGGgDeB2NOMN
         BKkSalu//6mEMOkdDlNPn3nQkf0Vp1b2s/ML7kdxwteVvUpdsbQPnnSPGzhGIyyIyWKt
         hq9jdiNyRuMP2ZYYOTZ9F2FgdUlzlShgqA4bxNTI+cCB8oh7gKxdWwseclLZWESVkfkm
         BoFVcMtJTvE5OgKDV89y3Tb0OcKyM5cuzoLuYYpTnFb97icuZQsQSSX8ehlJr0Rg+YBD
         8ycvPhVinwtc30l8mX0ub9Rx1g1muitOe4Al0xHS3B14V4mLR7fWgOxG0mGuZ+0bOiMr
         F0CA==
X-Received: by 10.70.36.176 with SMTP id r16mr34532505pdj.22.1431955890879;
        Mon, 18 May 2015 06:31:30 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id jz10sm10118688pbc.48.2015.05.18.06.31.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 06:31:29 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431955855-16228-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269234>

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 git-pull.sh | 102 +++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 57 insertions(+), 45 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 28d49ab..18f5210 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -4,13 +4,53 @@
 #
 # Fetch one or more remote refs and merge it/them into the current HEAD.
 
-USAGE='[-n | --no-stat] [--[no-]commit] [--[no-]squash] [--[no-]ff|--ff-only] [--[no-]rebase|--rebase=preserve] [-s strategy]... [<fetch-options>] <repo> <head>...'
-LONG_USAGE='Fetch one or more remote refs and integrate it/them with the current HEAD.'
 SUBDIRECTORY_OK=Yes
-OPTIONS_SPEC=
+OPTIONS_KEEPDASHDASH=Yes
+OPTIONS_STUCKLONG=Yes
+OPTIONS_SPEC="\
+git pull [options] [<repo> [<refspec>...]]
+
+Fetch one or more remote refs and integrate it/them with the current HEAD.
+--
+v,verbose                  be more verbose
+q,quiet                    be more quiet
+progress                   force progress reporting
+
+  Options related to merging
+r,rebase?false|true|preserve incorporate changes by rebasing rather than merging
+n!                         do not show a diffstat at the end of the merge
+stat                       show a diffstat at the end of the merge
+summary                    (synonym to --stat)
+log?n                      add (at most <n>) entries from shortlog to merge commit message
+squash                     create a single commit instead of doing a merge
+commit                     perform a commit if the merge succeeds (default)
+e,edit                       edit message before committing
+ff                         allow fast-forward
+ff-only!                   abort if fast-forward is not possible
+verify-signatures          verify that the named commit has a valid GPG signature
+s,strategy=strategy        merge strategy to use
+X,strategy-option=option   option for selected merge strategy
+S,gpg-sign?key-id          GPG sign commit
+
+  Options related to fetching
+all                        fetch from all remotes
+a,append                   append to .git/FETCH_HEAD instead of overwriting
+upload-pack=path           path to upload pack on remote end
+f,force                    force overwrite of local branch
+t,tags                     fetch all tags and associated objects
+p,prune                    prune remote-tracking branches no longer on remote
+recurse-submodules?on-demand control recursive fetching of submodules
+dry-run                    dry run
+k,keep                     keep downloaded pack
+depth=depth                deepen history of shallow clone
+unshallow                  convert to a complete repository
+update-shallow             accept refs that update .git/shallow
+refmap=refmap              specify fetch refmap
+"
+args="$*"
 . git-sh-setup
 . git-sh-i18n
-set_reflog_action "pull${1+ $*}"
+set_reflog_action "pull${args:+ $args}"
 require_work_tree_exists
 cd_to_toplevel
 
@@ -83,17 +123,15 @@ do
 		diffstat=--stat ;;
 	--log|--no-log)
 		log_arg=$1 ;;
-	--no-c|--no-co|--no-com|--no-comm|--no-commi|--no-commit)
-		no_commit=--no-commit ;;
-	--c|--co|--com|--comm|--commi|--commit)
-		no_commit=--commit ;;
+	--commit|--no-commit)
+		no_commit="$1" ;;
 	-e|--edit)
 		edit=--edit ;;
 	--no-edit)
 		edit=--no-edit ;;
-	--sq|--squ|--squa|--squas|--squash)
+	--squash)
 		squash=--squash ;;
-	--no-sq|--no-squ|--no-squa|--no-squas|--no-squash)
+	--no-squash)
 		squash=--no-squash ;;
 	--ff)
 		no_ff=--ff ;;
@@ -101,39 +139,19 @@ do
 		no_ff=--no-ff ;;
 	--ff-only)
 		ff_only=--ff-only ;;
-	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
-		--strateg=*|--strategy=*|\
-	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
-		case "$#,$1" in
-		*,*=*)
-			strategy=$(expr "z$1" : 'z-[^=]*=\(.*\)') ;;
-		1,*)
-			usage ;;
-		*)
-			strategy="$2"
-			shift ;;
-		esac
-		strategy_args="${strategy_args}-s $strategy "
+	--strategy=*)
+		strategy_args="$strategy_args $1"
 		;;
-	-X*)
-		case "$#,$1" in
-		1,-X)
-			usage ;;
-		*,-X)
-			xx="-X $(git rev-parse --sq-quote "$2")"
-			shift ;;
-		*,*)
-			xx=$(git rev-parse --sq-quote "$1") ;;
-		esac
-		merge_args="$merge_args$xx "
+	--strategy-option=*)
+		merge_args="$merge_args $1"
 		;;
-	-r=*|--r=*|--re=*|--reb=*|--reba=*|--rebas=*|--rebase=*)
+	--rebase=*)
 		rebase="${1#*=}"
 		;;
-	-r|--r|--re|--reb|--reba|--rebas|--rebase)
+	-r|--rebase)
 		rebase=true
 		;;
-	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
+	--no-rebase)
 		rebase=false
 		;;
 	--recurse-submodules)
@@ -157,10 +175,7 @@ do
 	--gpg-sign=*)
 		gpg_sign_args=$(git rev-parse --sq-quote "-S${1#--gpg-sign=}")
 		;;
-	-S*)
-		gpg_sign_args=$(git rev-parse --sq-quote "$1")
-		;;
-	--d|--dr|--dry|--dry-|--dry-r|--dry-ru|--dry-run)
+	--dry-run)
 		dry_run=--dry-run
 		;;
 	--all|--no-all)
@@ -192,11 +207,8 @@ do
 		shift
 		break
 		;;
-	-*)
-		usage
-		;;
 	*)
-		break
+		usage
 		;;
 	esac
 	shift
-- 
2.1.4
