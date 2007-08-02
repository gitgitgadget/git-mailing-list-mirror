From: David Kastrup <dak@gnu.org>
Subject: Shell script cleanups/style changes?
Date: Thu, 02 Aug 2007 12:44:22 +0200
Message-ID: <86bqdqkygp.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 12:45:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGYBF-0007Wd-D7
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 12:45:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698AbXHBKov (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 06:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753562AbXHBKou
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 06:44:50 -0400
Received: from main.gmane.org ([80.91.229.2]:47736 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751594AbXHBKot (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 06:44:49 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IGYAb-0000Lm-CQ
	for git@vger.kernel.org; Thu, 02 Aug 2007 12:44:41 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 12:44:41 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 12:44:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:4UzY46GtJov9KYe0eV8Ib05rKTc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54539>

--=-=-=


Hi, I wanted to ask what the general stance towards shell script
cleanups and simplifications would be.  For example, I find the expr
usage quite inscrutable in commit, and there is no necessity of
putting "shift" in every case branch instead of once behind it, and a
lot of conditionals and other manipulations can be made much easier on
the eye by using parameter expansion patterns that are, as far as I
can see, available with every reasonable Bourne Shell and clones.

Here is an example context diff (in this case, I find it more readable
than unified) to illustrate (untested!, please don't apply without a
regular formatted git patch).

Should I bother doing such cleanups as I read up on code, or should I
just leave things alone?


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline

diff --git a/git-commit.sh b/git-commit.sh
index d7e7028..bdf20be 100755
*** a/git-commit.sh
--- b/git-commit.sh
***************
*** 97,101 ****
  		no_edit=t
  		log_given=t$log_given
  		logfile="$1"
- 		shift
  		;;
--- 97,100 ----
***************
*** 102,107 ****
  	-F*|-f*)
  		no_edit=t
  		log_given=t$log_given
! 		logfile=`expr "z$1" : 'z-[Ff]\(.*\)'`
! 		shift
  		;;
--- 101,105 ----
  	-F*|-f*)
  		no_edit=t
  		log_given=t$log_given
! 		logfile="${1#-?}"
  		;;
***************
*** 108,113 ****
  	--F=*|--f=*|--fi=*|--fil=*|--file=*)
  		no_edit=t
  		log_given=t$log_given
! 		logfile=`expr "z$1" : 'z-[^=]*=\(.*\)'`
! 		shift
  		;;
--- 106,110 ----
  	--F=*|--f=*|--fi=*|--fil=*|--file=*)
  		no_edit=t
  		log_given=t$log_given
! 		logfile="${1#*=}"
  		;;
***************
*** 114,117 ****
  	-a|--a|--al|--all)
  		all=t
- 		shift
  		;;
--- 111,113 ----
***************
*** 118,127 ****
  	--au=*|--aut=*|--auth=*|--autho=*|--author=*)
! 		force_author=`expr "z$1" : 'z-[^=]*=\(.*\)'`
! 		shift
  		;;
  	--au|--aut|--auth|--autho|--author)
  		case "$#" in 1) usage ;; esac
  		shift
  		force_author="$1"
- 		shift
  		;;
--- 114,121 ----
  	--au=*|--aut=*|--auth=*|--autho=*|--author=*)
! 		force_author="${1#*=}"
  		;;
  	--au|--aut|--auth|--autho|--author)
  		case "$#" in 1) usage ;; esac
  		shift
  		force_author="$1"
  		;;
***************
*** 128,144 ****
  	-e|--e|--ed|--edi|--edit)
  		edit_flag=t
- 		shift
  		;;
  	-i|--i|--in|--inc|--incl|--inclu|--includ|--include)
  		also=t
- 		shift
  		;;
  	--int|--inte|--inter|--intera|--interac|--interact|--interacti|\
  	--interactiv|--interactive)
  		interactive=t
- 		shift
  		;;
  	-o|--o|--on|--onl|--only)
  		only=t
- 		shift
  		;;
--- 122,134 ----
***************
*** 145,159 ****
  	-m|--m|--me|--mes|--mess|--messa|--messag|--message)
  		case "$#" in 1) usage ;; esac
- 		shift
  		log_given=m$log_given
! 		if test "$log_message" = ''
! 		then
! 		    log_message="$1"
! 		else
! 		    log_message="$log_message
  
! $1"
! 		fi
  		no_edit=t
- 		shift
  		;;
--- 135,142 ----
  	-m|--m|--me|--mes|--mess|--messa|--messag|--message)
  		case "$#" in 1) usage ;; esac
  		log_given=m$log_given
! 		log_message="${log_message}${log_message:+
  
! }$1"
  		no_edit=t
  		;;
***************
*** 160,172 ****
  	-m*)
  		log_given=m$log_given
! 		if test "$log_message" = ''
! 		then
! 		    log_message=`expr "z$1" : 'z-m\(.*\)'`
! 		else
! 		    log_message="$log_message
  
! `expr "z$1" : 'z-m\(.*\)'`"
! 		fi
  		no_edit=t
- 		shift
  		;;
--- 143,149 ----
  	-m*)
  		log_given=m$log_given
! 		log_message="${log_message}${log_message:+
  
! }${1#-m}"
  		no_edit=t
  		;;
***************
*** 173,185 ****
  	--m=*|--me=*|--mes=*|--mess=*|--messa=*|--messag=*|--message=*)
  		log_given=m$log_given
! 		if test "$log_message" = ''
! 		then
! 		    log_message=`expr "z$1" : 'z-[^=]*=\(.*\)'`
! 		else
! 		    log_message="$log_message
  
! `expr "z$1" : 'zq-[^=]*=\(.*\)'`"
! 		fi
  		no_edit=t
- 		shift
  		;;
--- 150,156 ----
  	--m=*|--me=*|--mes=*|--mess=*|--messa=*|--messag=*|--message=*)
  		log_given=m$log_given
! 		log_message="${log_message}${log_message:+
  
! }${1#*=}"
  		no_edit=t
  		;;
***************
*** 186,197 ****
  	-n|--n|--no|--no-|--no-v|--no-ve|--no-ver|--no-veri|--no-verif|\
  	--no-verify)
  		verify=
- 		shift
  		;;
  	--a|--am|--ame|--amen|--amend)
  		amend=t
  		use_commit=HEAD
- 		shift
  		;;
  	-c)
  		case "$#" in 1) usage ;; esac
--- 157,166 ----
***************
*** 199,203 ****
  		log_given=t$log_given
  		use_commit="$1"
  		no_edit=
- 		shift
  		;;
--- 168,171 ----
***************
*** 204,213 ****
  	--ree=*|--reed=*|--reedi=*|--reedit=*|--reedit-=*|--reedit-m=*|\
  	--reedit-me=*|--reedit-mes=*|--reedit-mess=*|--reedit-messa=*|\
  	--reedit-messag=*|--reedit-message=*)
  		log_given=t$log_given
! 		use_commit=`expr "z$1" : 'z-[^=]*=\(.*\)'`
  		no_edit=
- 		shift
  		;;
  	--ree|--reed|--reedi|--reedit|--reedit-|--reedit-m|--reedit-me|\
  	--reedit-mes|--reedit-mess|--reedit-messa|--reedit-messag|\
--- 172,180 ----
  	--ree=*|--reed=*|--reedi=*|--reedit=*|--reedit-=*|--reedit-m=*|\
  	--reedit-me=*|--reedit-mes=*|--reedit-mess=*|--reedit-messa=*|\
  	--reedit-messag=*|--reedit-message=*)
  		log_given=t$log_given
! 		use_commit="${1#*=}"
  		no_edit=
  		;;
  	--ree|--reed|--reedi|--reedit|--reedit-|--reedit-m|--reedit-me|\
  	--reedit-mes|--reedit-mess|--reedit-messa|--reedit-messag|\
***************
*** 217,223 ****
  		log_given=t$log_given
  		use_commit="$1"
  		no_edit=
- 		shift
  		;;
  	-C)
  		case "$#" in 1) usage ;; esac
--- 184,189 ----
***************
*** 225,229 ****
  		log_given=t$log_given
  		use_commit="$1"
  		no_edit=t
- 		shift
  		;;
--- 191,194 ----
***************
*** 230,239 ****
  	--reu=*|--reus=*|--reuse=*|--reuse-=*|--reuse-m=*|--reuse-me=*|\
  	--reuse-mes=*|--reuse-mess=*|--reuse-messa=*|--reuse-messag=*|\
  	--reuse-message=*)
  		log_given=t$log_given
! 		use_commit=`expr "z$1" : 'z-[^=]*=\(.*\)'`
  		no_edit=t
- 		shift
  		;;
  	--reu|--reus|--reuse|--reuse-|--reuse-m|--reuse-me|--reuse-mes|\
  	--reuse-mess|--reuse-messa|--reuse-messag|--reuse-message)
--- 195,203 ----
  	--reu=*|--reus=*|--reuse=*|--reuse-=*|--reuse-m=*|--reuse-me=*|\
  	--reuse-mes=*|--reuse-mess=*|--reuse-messa=*|--reuse-messag=*|\
  	--reuse-message=*)
  		log_given=t$log_given
! 		use_commit="${1#*=}"
  		no_edit=t
  		;;
  	--reu|--reus|--reuse|--reuse-|--reuse-m|--reuse-me|--reuse-mes|\
  	--reuse-mess|--reuse-messa|--reuse-messag|--reuse-message)
***************
*** 242,273 ****
  		log_given=t$log_given
  		use_commit="$1"
  		no_edit=t
- 		shift
  		;;
  	-s|--s|--si|--sig|--sign|--signo|--signof|--signoff)
  		signoff=t
- 		shift
  		;;
  	-t|--t|--te|--tem|--temp|--templ|--templa|--templat|--template)
  		case "$#" in 1) usage ;; esac
  		shift
  		templatefile="$1"
  		no_edit=
- 		shift
  		;;
  	-q|--q|--qu|--qui|--quie|--quiet)
  		quiet=t
- 		shift
  		;;
  	-v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
  		verbose=t
- 		shift
  		;;
  	-u|--u|--un|--unt|--untr|--untra|--untrac|--untrack|--untracke|\
  	--untracked|--untracked-|--untracked-f|--untracked-fi|--untracked-fil|\
  	--untracked-file|--untracked-files)
  		untracked_files=t
- 		shift
  		;;
  	--)
  		shift
--- 206,231 ----
***************
*** 280,285 ****
--- 238,244 ----
  		break
  		;;
  	esac
+ 	shift
  done
  case "$edit_flag" in t) no_edit= ;; esac
  
***************
*** 437,448 ****
  
  if test t = "$verify" && test -x "$GIT_DIR"/hooks/pre-commit
  then
! 	if test "$TMP_INDEX"
! 	then
! 		GIT_INDEX_FILE="$TMP_INDEX" "$GIT_DIR"/hooks/pre-commit
! 	else
! 		GIT_INDEX_FILE="$USE_INDEX" "$GIT_DIR"/hooks/pre-commit
! 	fi || exit
  fi
  
  if test "$log_message" != ''
--- 396,403 ----
  
  if test t = "$verify" && test -x "$GIT_DIR"/hooks/pre-commit
  then
!     GIT_INDEX_FILE="${TMP_INDEX:-${USE_INDEX}}" "$GIT_DIR"/hooks/pre-commit \
!     || exit
  fi
  
  if test "$log_message" != ''

--=-=-=



-- 
David Kastrup

--=-=-=--
