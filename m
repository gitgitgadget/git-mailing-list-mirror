From: David Kastrup <dak@gnu.org>
Subject: [PATCH] git-commit.sh: Shell script cleanup
Date: Mon, 17 Sep 2007 22:56:44 +0200
Organization: Organization?!?
Message-ID: <85ejgx104z.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 22:56:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXNeK-0003eZ-21
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 22:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756787AbXIQU4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 16:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756825AbXIQU4x
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 16:56:53 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:54073 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756661AbXIQU4v (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Sep 2007 16:56:51 -0400
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 5BE0E31EA25
	for <git@vger.kernel.org>; Mon, 17 Sep 2007 22:56:50 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id 45D5D345BE8
	for <git@vger.kernel.org>; Mon, 17 Sep 2007 22:56:50 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-087-038.pools.arcor-ip.net [84.61.87.38])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id E129B30ABD2
	for <git@vger.kernel.org>; Mon, 17 Sep 2007 22:56:45 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id CEE7B1CDAC0C; Mon, 17 Sep 2007 22:56:44 +0200 (CEST)
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4312/Mon Sep 17 20:03:23 2007 on mail-in-03.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58481>

This moves "shift" out of the argument processing "case".  It also
replaces quite a bit of expr calls with ${parameter#word} constructs,
and uses ${parameter:+word} for avoiding conditionals where possible.

Signed-off-by: David Kastrup <dak@gnu.org>
---
Actually, this is almost the same patch as the one posted during the
1.5.3 semi-freeze.  I just checked that it still applies and works,
and that nothing has been changed incompatibly in the mean time.

Some might argue that git-commit.sh could be implemented in C soon,
anyway.  Well, exactly that would be an excellent reason to do this
sort of cleanup, since then this file would get moved to
contrib/examples, and of course we want the examples to look as clean
and understandable as possible, don't we?

At more than 4 times as many deletions than insertions, this is a nice
cleanup, and quite more readable.

 git-commit.sh |   72 +++++++++++---------------------------------------------
 1 files changed, 14 insertions(+), 58 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index bb113e8..3e46dbb 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -98,101 +98,71 @@ do
 		no_edit=t
 		log_given=t$log_given
 		logfile="$1"
-		shift
 		;;
 	-F*|-f*)
 		no_edit=t
 		log_given=t$log_given
-		logfile=`expr "z$1" : 'z-[Ff]\(.*\)'`
-		shift
+		logfile="${1#-[Ff]}"
 		;;
 	--F=*|--f=*|--fi=*|--fil=*|--file=*)
 		no_edit=t
 		log_given=t$log_given
-		logfile=`expr "z$1" : 'z-[^=]*=\(.*\)'`
-		shift
+		logfile="${1#*=}"
 		;;
 	-a|--a|--al|--all)
 		all=t
-		shift
 		;;
 	--au=*|--aut=*|--auth=*|--autho=*|--author=*)
-		force_author=`expr "z$1" : 'z-[^=]*=\(.*\)'`
-		shift
+		force_author="${1#*=}"
 		;;
 	--au|--aut|--auth|--autho|--author)
 		case "$#" in 1) usage ;; esac
 		shift
 		force_author="$1"
-		shift
 		;;
 	-e|--e|--ed|--edi|--edit)
 		edit_flag=t
-		shift
 		;;
 	-i|--i|--in|--inc|--incl|--inclu|--includ|--include)
 		also=t
-		shift
 		;;
 	--int|--inte|--inter|--intera|--interac|--interact|--interacti|\
 	--interactiv|--interactive)
 		interactive=t
-		shift
 		;;
 	-o|--o|--on|--onl|--only)
 		only=t
-		shift
 		;;
 	-m|--m|--me|--mes|--mess|--messa|--messag|--message)
 		case "$#" in 1) usage ;; esac
 		shift
 		log_given=m$log_given
-		if test "$log_message" = ''
-		then
-		    log_message="$1"
-		else
-		    log_message="$log_message
+		log_message="${log_message:+${log_message}
 
-$1"
-		fi
+}$1"
 		no_edit=t
-		shift
 		;;
 	-m*)
 		log_given=m$log_given
-		if test "$log_message" = ''
-		then
-		    log_message=`expr "z$1" : 'z-m\(.*\)'`
-		else
-		    log_message="$log_message
+		log_message="${log_message:+${log_message}
 
-`expr "z$1" : 'z-m\(.*\)'`"
-		fi
+}${1#-m}"
 		no_edit=t
-		shift
 		;;
 	--m=*|--me=*|--mes=*|--mess=*|--messa=*|--messag=*|--message=*)
 		log_given=m$log_given
-		if test "$log_message" = ''
-		then
-		    log_message=`expr "z$1" : 'z-[^=]*=\(.*\)'`
-		else
-		    log_message="$log_message
+		log_message="${log_message:+${log_message}
 
-`expr "z$1" : 'zq-[^=]*=\(.*\)'`"
-		fi
+}${1#*=}"
 		no_edit=t
-		shift
 		;;
 	-n|--n|--no|--no-|--no-v|--no-ve|--no-ver|--no-veri|--no-verif|\
 	--no-verify)
 		verify=
-		shift
 		;;
 	--a|--am|--ame|--amen|--amend)
 		amend=t
 		use_commit=HEAD
-		shift
 		;;
 	-c)
 		case "$#" in 1) usage ;; esac
@@ -200,15 +170,13 @@ $1"
 		log_given=t$log_given
 		use_commit="$1"
 		no_edit=
-		shift
 		;;
 	--ree=*|--reed=*|--reedi=*|--reedit=*|--reedit-=*|--reedit-m=*|\
 	--reedit-me=*|--reedit-mes=*|--reedit-mess=*|--reedit-messa=*|\
 	--reedit-messag=*|--reedit-message=*)
 		log_given=t$log_given
-		use_commit=`expr "z$1" : 'z-[^=]*=\(.*\)'`
+		use_commit="${1#*=}"
 		no_edit=
-		shift
 		;;
 	--ree|--reed|--reedi|--reedit|--reedit-|--reedit-m|--reedit-me|\
 	--reedit-mes|--reedit-mess|--reedit-messa|--reedit-messag|\
@@ -218,7 +186,6 @@ $1"
 		log_given=t$log_given
 		use_commit="$1"
 		no_edit=
-		shift
 		;;
 	-C)
 		case "$#" in 1) usage ;; esac
@@ -226,15 +193,13 @@ $1"
 		log_given=t$log_given
 		use_commit="$1"
 		no_edit=t
-		shift
 		;;
 	--reu=*|--reus=*|--reuse=*|--reuse-=*|--reuse-m=*|--reuse-me=*|\
 	--reuse-mes=*|--reuse-mess=*|--reuse-messa=*|--reuse-messag=*|\
 	--reuse-message=*)
 		log_given=t$log_given
-		use_commit=`expr "z$1" : 'z-[^=]*=\(.*\)'`
+		use_commit="${1#*=}"
 		no_edit=t
-		shift
 		;;
 	--reu|--reus|--reuse|--reuse-|--reuse-m|--reuse-me|--reuse-mes|\
 	--reuse-mess|--reuse-messa|--reuse-messag|--reuse-message)
@@ -243,32 +208,26 @@ $1"
 		log_given=t$log_given
 		use_commit="$1"
 		no_edit=t
-		shift
 		;;
 	-s|--s|--si|--sig|--sign|--signo|--signof|--signoff)
 		signoff=t
-		shift
 		;;
 	-t|--t|--te|--tem|--temp|--templ|--templa|--templat|--template)
 		case "$#" in 1) usage ;; esac
 		shift
 		templatefile="$1"
 		no_edit=
-		shift
 		;;
 	-q|--q|--qu|--qui|--quie|--quiet)
 		quiet=t
-		shift
 		;;
 	-v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
 		verbose=t
-		shift
 		;;
 	-u|--u|--un|--unt|--untr|--untra|--untrac|--untrack|--untracke|\
 	--untracked|--untracked-|--untracked-f|--untracked-fi|--untracked-fil|\
 	--untracked-file|--untracked-files)
 		untracked_files=t
-		shift
 		;;
 	--)
 		shift
@@ -281,6 +240,7 @@ $1"
 		break
 		;;
 	esac
+	shift
 done
 case "$edit_flag" in t) no_edit= ;; esac
 
@@ -441,12 +401,8 @@ esac
 
 if test t = "$verify" && test -x "$GIT_DIR"/hooks/pre-commit
 then
-	if test "$TMP_INDEX"
-	then
-		GIT_INDEX_FILE="$TMP_INDEX" "$GIT_DIR"/hooks/pre-commit
-	else
-		GIT_INDEX_FILE="$USE_INDEX" "$GIT_DIR"/hooks/pre-commit
-	fi || exit
+    GIT_INDEX_FILE="${TMP_INDEX:-${USE_INDEX}}" "$GIT_DIR"/hooks/pre-commit \
+    || exit
 fi
 
 if test "$log_message" != ''
-- 
1.5.3.1.96.g4568
