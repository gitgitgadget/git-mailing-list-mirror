From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] completion: split __git_ps1 into a separate script
Date: Tue, 22 May 2012 22:46:40 +0200
Message-ID: <1337719600-7361-3-git-send-email-felipe.contreras@gmail.com>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Ted Pavlic <ted@tedpavlic.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Kerrick Staley <mail@kerrickstaley.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	=?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>,
	Dan McGee <dan@archlinux.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 22 22:47:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWvz2-00009C-Nw
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 22:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534Ab2EVUrB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 May 2012 16:47:01 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:40690 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932240Ab2EVUq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 16:46:59 -0400
Received: by mail-ee0-f46.google.com with SMTP id t10so1847774eei.19
        for <git@vger.kernel.org>; Tue, 22 May 2012 13:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qTfBojsYLEzYKEdPV8OWNrQKqsN+ruFm8CfWcafMBcw=;
        b=WSlXsmaEAK10b/iVQA5YYnEhjRCQqYuc/uwRY3Phkt2aydLbR9OaVTE+aWkZXIfooI
         GMOOgLbR5znrEeKr6aMbnCgPLM+6vW87Fk4mixbQgiDxVMaUTPvQjltMmCuRB++XkRIs
         +E+C3M1OwJO+C5+dO2ONtax7EJvT+xwyp24nycniJl+8k66E5FUbaaoXTHOq5mXVGi8S
         C+m5Ps9ET+feNwOdkUqjftDZeggE78jjUidGT8a0ngAgo2ffcycyyWrELSIzmlAiEvEN
         yJOqlG43GkPbuwgF1YoQAn5fMAahAgZMC8oNsj5PoBHTUSJkFz8kUXlbzhTmbgtKnFIQ
         wW8A==
Received: by 10.14.95.196 with SMTP id p44mr4682347eef.15.1337719619054;
        Tue, 22 May 2012 13:46:59 -0700 (PDT)
Received: from localhost ([46.115.34.169])
        by mx.google.com with ESMTPS id v46sm112237487eef.11.2012.05.22.13.46.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 May 2012 13:46:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2
In-Reply-To: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198251>

bash-completion 1.90 shipped with support to load completions
dynamically[1], which means the git completion script wouldn't be loade=
d
until the user types 'git <tab>'--this creates a problem to people usin=
g
__git_ps1(); that function won't be available when the shell is first
created.

=46or now distributions have workarounded this issue by moving the git
completion to the "compatdir"[2]; this of course is not ideal.

The solution, proposed by Kerrick Staley[3], is to split the git script
in two; the part that deals with __git_ps1() in one (i.e.
git-prompt.sh), and everything else in another (i.e.
git-completion.bash).

Another benefit of this is that zsh user that are not interested in the
bash completion can use it for their prompts, which has been tried
before[4].

The only slight issue is that __gitdir() would be duplicated, but this
is probably not a big deal.

So let's go ahead and move __git_ps1() to a new file.

While at this, I took the liberty to reformat the help text in the new
file.

 [1] http://anonscm.debian.org/gitweb/?p=3Dbash-completion/bash-complet=
ion.git;a=3Dcommitdiff;h=3D99c4f7f25f50a7cb2fce86055bddfe389effa559
 [2] http://projects.archlinux.org/svntogit/packages.git/commit/trunk?h=
=3Dpackages/git&id=3D974380fabb8f9f412990b17063bf578d98c44a82
 [3] http://mid.gmane.org/CANaWP3w9KDu57aHquRRYt8td_haSWTBKs7zUHy-xu0B6=
1gmr9A@mail.gmail.com
 [4] http://mid.gmane.org/1303824288-15591-1-git-send-email-mstormo@gma=
il.com

Cc: Kerrick Staley <mail@kerrickstaley.com>
Cc: Marius Storm-Olsen <mstormo@gmail.com>
Cc: Ville Skytt=C3=A4 <ville.skytta@iki.fi>
Cc: Dan McGee <dan@archlinux.org>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |  257 +-----------------------=
----
 contrib/completion/git-prompt.sh       |  287 ++++++++++++++++++++++++=
++++++++
 t/t9903-bash-prompt.sh                 |    2 +-
 3 files changed, 290 insertions(+), 256 deletions(-)
 create mode 100644 contrib/completion/git-prompt.sh

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 44af124..59e4b5f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -20,46 +20,8 @@
 #    1) Copy this file to somewhere (e.g. ~/.git-completion.sh).
 #    2) Add the following line to your .bashrc/.zshrc:
 #        source ~/.git-completion.sh
-#
-#    3) Consider changing your PS1 to also show the current branch:
-#         Bash: PS1=3D'[\u@\h \W$(__git_ps1 " (%s)")]\$ '
-#         ZSH:  PS1=3D'[%n@%m %c$(__git_ps1 " (%s)")]\$ '
-#
-#       The argument to __git_ps1 will be displayed only if you
-#       are currently in a git repository.  The %s token will be
-#       the name of the current branch.
-#
-#       In addition, if you set GIT_PS1_SHOWDIRTYSTATE to a nonempty
-#       value, unstaged (*) and staged (+) changes will be shown next
-#       to the branch name.  You can configure this per-repository
-#       with the bash.showDirtyState variable, which defaults to true
-#       once GIT_PS1_SHOWDIRTYSTATE is enabled.
-#
-#       You can also see if currently something is stashed, by setting
-#       GIT_PS1_SHOWSTASHSTATE to a nonempty value. If something is st=
ashed,
-#       then a '$' will be shown next to the branch name.
-#
-#       If you would like to see if there're untracked files, then you=
 can
-#       set GIT_PS1_SHOWUNTRACKEDFILES to a nonempty value. If there'r=
e
-#       untracked files, then a '%' will be shown next to the branch n=
ame.
-#
-#       If you would like to see the difference between HEAD and its
-#       upstream, set GIT_PS1_SHOWUPSTREAM=3D"auto".  A "<" indicates
-#       you are behind, ">" indicates you are ahead, and "<>"
-#       indicates you have diverged.  You can further control
-#       behaviour by setting GIT_PS1_SHOWUPSTREAM to a space-separated
-#       list of values:
-#           verbose       show number of commits ahead/behind (+/-) up=
stream
-#           legacy        don't use the '--count' option available in =
recent
-#                         versions of git-rev-list
-#           git           always compare HEAD to @{upstream}
-#           svn           always compare HEAD to your SVN upstream
-#       By default, __git_ps1 will compare HEAD to your SVN upstream
-#       if it can find one, or @{upstream} otherwise.  Once you have
-#       set GIT_PS1_SHOWUPSTREAM, you can override it on a
-#       per-repository basis by setting the bash.showUpstream config
-#       variable.
-#
+#    3) Consider changing your PS1 to also show the current branch,
+#       see git-prompt.sh for details.
=20
 if [[ -n ${ZSH_VERSION-} ]]; then
 	autoload -U +X bashcompinit && bashcompinit
@@ -92,221 +54,6 @@ __gitdir ()
 	fi
 }
=20
-# stores the divergence from upstream in $p
-# used by GIT_PS1_SHOWUPSTREAM
-__git_ps1_show_upstream ()
-{
-	local key value
-	local svn_remote svn_url_pattern count n
-	local upstream=3Dgit legacy=3D"" verbose=3D""
-
-	svn_remote=3D()
-	# get some config options from git-config
-	local output=3D"$(git config -z --get-regexp '^(svn-remote\..*\.url|b=
ash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
-	while read -r key value; do
-		case "$key" in
-		bash.showupstream)
-			GIT_PS1_SHOWUPSTREAM=3D"$value"
-			if [[ -z "${GIT_PS1_SHOWUPSTREAM}" ]]; then
-				p=3D""
-				return
-			fi
-			;;
-		svn-remote.*.url)
-			svn_remote[ $((${#svn_remote[@]} + 1)) ]=3D"$value"
-			svn_url_pattern+=3D"\\|$value"
-			upstream=3Dsvn+git # default upstream is SVN if available, else git
-			;;
-		esac
-	done <<< "$output"
-
-	# parse configuration values
-	for option in ${GIT_PS1_SHOWUPSTREAM}; do
-		case "$option" in
-		git|svn) upstream=3D"$option" ;;
-		verbose) verbose=3D1 ;;
-		legacy)  legacy=3D1  ;;
-		esac
-	done
-
-	# Find our upstream
-	case "$upstream" in
-	git)    upstream=3D"@{upstream}" ;;
-	svn*)
-		# get the upstream from the "git-svn-id: ..." in a commit message
-		# (git-svn uses essentially the same procedure internally)
-		local svn_upstream=3D($(git log --first-parent -1 \
-					--grep=3D"^git-svn-id: \(${svn_url_pattern#??}\)" 2>/dev/null))
-		if [[ 0 -ne ${#svn_upstream[@]} ]]; then
-			svn_upstream=3D${svn_upstream[ ${#svn_upstream[@]} - 2 ]}
-			svn_upstream=3D${svn_upstream%@*}
-			local n_stop=3D"${#svn_remote[@]}"
-			for ((n=3D1; n <=3D n_stop; n++)); do
-				svn_upstream=3D${svn_upstream#${svn_remote[$n]}}
-			done
-
-			if [[ -z "$svn_upstream" ]]; then
-				# default branch name for checkouts with no layout:
-				upstream=3D${GIT_SVN_ID:-git-svn}
-			else
-				upstream=3D${svn_upstream#/}
-			fi
-		elif [[ "svn+git" =3D "$upstream" ]]; then
-			upstream=3D"@{upstream}"
-		fi
-		;;
-	esac
-
-	# Find how many commits we are ahead/behind our upstream
-	if [[ -z "$legacy" ]]; then
-		count=3D"$(git rev-list --count --left-right \
-				"$upstream"...HEAD 2>/dev/null)"
-	else
-		# produce equivalent output to --count for older versions of git
-		local commits
-		if commits=3D"$(git rev-list --left-right "$upstream"...HEAD 2>/dev/=
null)"
-		then
-			local commit behind=3D0 ahead=3D0
-			for commit in $commits
-			do
-				case "$commit" in
-				"<"*) ((behind++)) ;;
-				*)    ((ahead++))  ;;
-				esac
-			done
-			count=3D"$behind	$ahead"
-		else
-			count=3D""
-		fi
-	fi
-
-	# calculate the result
-	if [[ -z "$verbose" ]]; then
-		case "$count" in
-		"") # no upstream
-			p=3D"" ;;
-		"0	0") # equal to upstream
-			p=3D"=3D" ;;
-		"0	"*) # ahead of upstream
-			p=3D">" ;;
-		*"	0") # behind upstream
-			p=3D"<" ;;
-		*)	    # diverged from upstream
-			p=3D"<>" ;;
-		esac
-	else
-		case "$count" in
-		"") # no upstream
-			p=3D"" ;;
-		"0	0") # equal to upstream
-			p=3D" u=3D" ;;
-		"0	"*) # ahead of upstream
-			p=3D" u+${count#0	}" ;;
-		*"	0") # behind upstream
-			p=3D" u-${count%	0}" ;;
-		*)	    # diverged from upstream
-			p=3D" u+${count#*	}-${count%	*}" ;;
-		esac
-	fi
-
-}
-
-
-# __git_ps1 accepts 0 or 1 arguments (i.e., format string)
-# returns text to add to bash PS1 prompt (includes branch name)
-__git_ps1 ()
-{
-	local g=3D"$(__gitdir)"
-	if [ -n "$g" ]; then
-		local r=3D""
-		local b=3D""
-		if [ -f "$g/rebase-merge/interactive" ]; then
-			r=3D"|REBASE-i"
-			b=3D"$(cat "$g/rebase-merge/head-name")"
-		elif [ -d "$g/rebase-merge" ]; then
-			r=3D"|REBASE-m"
-			b=3D"$(cat "$g/rebase-merge/head-name")"
-		else
-			if [ -d "$g/rebase-apply" ]; then
-				if [ -f "$g/rebase-apply/rebasing" ]; then
-					r=3D"|REBASE"
-				elif [ -f "$g/rebase-apply/applying" ]; then
-					r=3D"|AM"
-				else
-					r=3D"|AM/REBASE"
-				fi
-			elif [ -f "$g/MERGE_HEAD" ]; then
-				r=3D"|MERGING"
-			elif [ -f "$g/CHERRY_PICK_HEAD" ]; then
-				r=3D"|CHERRY-PICKING"
-			elif [ -f "$g/BISECT_LOG" ]; then
-				r=3D"|BISECTING"
-			fi
-
-			b=3D"$(git symbolic-ref HEAD 2>/dev/null)" || {
-
-				b=3D"$(
-				case "${GIT_PS1_DESCRIBE_STYLE-}" in
-				(contains)
-					git describe --contains HEAD ;;
-				(branch)
-					git describe --contains --all HEAD ;;
-				(describe)
-					git describe HEAD ;;
-				(* | default)
-					git describe --tags --exact-match HEAD ;;
-				esac 2>/dev/null)" ||
-
-				b=3D"$(cut -c1-7 "$g/HEAD" 2>/dev/null)..." ||
-				b=3D"unknown"
-				b=3D"($b)"
-			}
-		fi
-
-		local w=3D""
-		local i=3D""
-		local s=3D""
-		local u=3D""
-		local c=3D""
-		local p=3D""
-
-		if [ "true" =3D "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]=
; then
-			if [ "true" =3D "$(git rev-parse --is-bare-repository 2>/dev/null)"=
 ]; then
-				c=3D"BARE:"
-			else
-				b=3D"GIT_DIR!"
-			fi
-		elif [ "true" =3D "$(git rev-parse --is-inside-work-tree 2>/dev/null=
)" ]; then
-			if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
-				if [ "$(git config --bool bash.showDirtyState)" !=3D "false" ]; th=
en
-					git diff --no-ext-diff --quiet --exit-code || w=3D"*"
-					if git rev-parse --quiet --verify HEAD >/dev/null; then
-						git diff-index --cached --quiet HEAD -- || i=3D"+"
-					else
-						i=3D"#"
-					fi
-				fi
-			fi
-			if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]; then
-				git rev-parse --verify refs/stash >/dev/null 2>&1 && s=3D"$"
-			fi
-
-			if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ]; then
-				if [ -n "$(git ls-files --others --exclude-standard)" ]; then
-					u=3D"%"
-				fi
-			fi
-
-			if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
-				__git_ps1_show_upstream
-			fi
-		fi
-
-		local f=3D"$w$i$s$u"
-		printf -- "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
-	fi
-}
-
 __gitcomp_1 ()
 {
 	local c IFS=3D$' \t\n'
diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-=
prompt.sh
new file mode 100644
index 0000000..8e2e9f3
--- /dev/null
+++ b/contrib/completion/git-prompt.sh
@@ -0,0 +1,287 @@
+# bash/zsh git prompt support
+#
+# Copyright (C) 2006,2007 Shawn O. Pearce <spearce@spearce.org>
+# Distributed under the GNU General Public License, version 2.0.
+#
+# This script allows you to see the current branch in your prompt.
+#
+# To enable:
+#
+#    1) Copy this file to somewhere (e.g. ~/.git-prompt.sh).
+#    2) Add the following line to your .bashrc/.zshrc:
+#        source ~/.git-prompt.sh
+#    3) Change your PS1 to also show the current branch:
+#         Bash: PS1=3D'[\u@\h \W$(__git_ps1 " (%s)")]\$ '
+#         ZSH:  PS1=3D'[%n@%m %c$(__git_ps1 " (%s)")]\$ '
+#
+# The argument to __git_ps1 will be displayed only if you are currentl=
y
+# in a git repository.  The %s token will be the name of the current
+# branch.
+#
+# In addition, if you set GIT_PS1_SHOWDIRTYSTATE to a nonempty value,
+# unstaged (*) and staged (+) changes will be shown next to the branch
+# name.  You can configure this per-repository with the
+# bash.showDirtyState variable, which defaults to true once
+# GIT_PS1_SHOWDIRTYSTATE is enabled.
+#
+# You can also see if currently something is stashed, by setting
+# GIT_PS1_SHOWSTASHSTATE to a nonempty value. If something is stashed,
+# then a '$' will be shown next to the branch name.
+#
+# If you would like to see if there're untracked files, then you can s=
et
+# GIT_PS1_SHOWUNTRACKEDFILES to a nonempty value. If there're untracke=
d
+# files, then a '%' will be shown next to the branch name.
+#
+# If you would like to see the difference between HEAD and its upstrea=
m,
+# set GIT_PS1_SHOWUPSTREAM=3D"auto".  A "<" indicates you are behind, =
">"
+# indicates you are ahead, and "<>" indicates you have diverged.  You
+# can further control behaviour by setting GIT_PS1_SHOWUPSTREAM to a
+# space-separated list of values:
+#
+#     verbose       show number of commits ahead/behind (+/-) upstream
+#     legacy        don't use the '--count' option available in recent
+#                   versions of git-rev-list
+#     git           always compare HEAD to @{upstream}
+#     svn           always compare HEAD to your SVN upstream
+#
+# By default, __git_ps1 will compare HEAD to your SVN upstream if it c=
an
+# find one, or @{upstream} otherwise.  Once you have set
+# GIT_PS1_SHOWUPSTREAM, you can override it on a per-repository basis =
by
+# setting the bash.showUpstream config variable.
+
+# __gitdir accepts 0 or 1 arguments (i.e., location)
+# returns location of .git repo
+__gitdir ()
+{
+	if [ -z "${1-}" ]; then
+		if [ -n "${__git_dir-}" ]; then
+			echo "$__git_dir"
+		elif [ -n "${GIT_DIR-}" ]; then
+			test -d "${GIT_DIR-}" || return 1
+			echo "$GIT_DIR"
+		elif [ -d .git ]; then
+			echo .git
+		else
+			git rev-parse --git-dir 2>/dev/null
+		fi
+	elif [ -d "$1/.git" ]; then
+		echo "$1/.git"
+	else
+		echo "$1"
+	fi
+}
+
+# stores the divergence from upstream in $p
+# used by GIT_PS1_SHOWUPSTREAM
+__git_ps1_show_upstream ()
+{
+	local key value
+	local svn_remote svn_url_pattern count n
+	local upstream=3Dgit legacy=3D"" verbose=3D""
+
+	svn_remote=3D()
+	# get some config options from git-config
+	local output=3D"$(git config -z --get-regexp '^(svn-remote\..*\.url|b=
ash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
+	while read -r key value; do
+		case "$key" in
+		bash.showupstream)
+			GIT_PS1_SHOWUPSTREAM=3D"$value"
+			if [[ -z "${GIT_PS1_SHOWUPSTREAM}" ]]; then
+				p=3D""
+				return
+			fi
+			;;
+		svn-remote.*.url)
+			svn_remote[ $((${#svn_remote[@]} + 1)) ]=3D"$value"
+			svn_url_pattern+=3D"\\|$value"
+			upstream=3Dsvn+git # default upstream is SVN if available, else git
+			;;
+		esac
+	done <<< "$output"
+
+	# parse configuration values
+	for option in ${GIT_PS1_SHOWUPSTREAM}; do
+		case "$option" in
+		git|svn) upstream=3D"$option" ;;
+		verbose) verbose=3D1 ;;
+		legacy)  legacy=3D1  ;;
+		esac
+	done
+
+	# Find our upstream
+	case "$upstream" in
+	git)    upstream=3D"@{upstream}" ;;
+	svn*)
+		# get the upstream from the "git-svn-id: ..." in a commit message
+		# (git-svn uses essentially the same procedure internally)
+		local svn_upstream=3D($(git log --first-parent -1 \
+					--grep=3D"^git-svn-id: \(${svn_url_pattern#??}\)" 2>/dev/null))
+		if [[ 0 -ne ${#svn_upstream[@]} ]]; then
+			svn_upstream=3D${svn_upstream[ ${#svn_upstream[@]} - 2 ]}
+			svn_upstream=3D${svn_upstream%@*}
+			local n_stop=3D"${#svn_remote[@]}"
+			for ((n=3D1; n <=3D n_stop; n++)); do
+				svn_upstream=3D${svn_upstream#${svn_remote[$n]}}
+			done
+
+			if [[ -z "$svn_upstream" ]]; then
+				# default branch name for checkouts with no layout:
+				upstream=3D${GIT_SVN_ID:-git-svn}
+			else
+				upstream=3D${svn_upstream#/}
+			fi
+		elif [[ "svn+git" =3D "$upstream" ]]; then
+			upstream=3D"@{upstream}"
+		fi
+		;;
+	esac
+
+	# Find how many commits we are ahead/behind our upstream
+	if [[ -z "$legacy" ]]; then
+		count=3D"$(git rev-list --count --left-right \
+				"$upstream"...HEAD 2>/dev/null)"
+	else
+		# produce equivalent output to --count for older versions of git
+		local commits
+		if commits=3D"$(git rev-list --left-right "$upstream"...HEAD 2>/dev/=
null)"
+		then
+			local commit behind=3D0 ahead=3D0
+			for commit in $commits
+			do
+				case "$commit" in
+				"<"*) ((behind++)) ;;
+				*)    ((ahead++))  ;;
+				esac
+			done
+			count=3D"$behind	$ahead"
+		else
+			count=3D""
+		fi
+	fi
+
+	# calculate the result
+	if [[ -z "$verbose" ]]; then
+		case "$count" in
+		"") # no upstream
+			p=3D"" ;;
+		"0	0") # equal to upstream
+			p=3D"=3D" ;;
+		"0	"*) # ahead of upstream
+			p=3D">" ;;
+		*"	0") # behind upstream
+			p=3D"<" ;;
+		*)	    # diverged from upstream
+			p=3D"<>" ;;
+		esac
+	else
+		case "$count" in
+		"") # no upstream
+			p=3D"" ;;
+		"0	0") # equal to upstream
+			p=3D" u=3D" ;;
+		"0	"*) # ahead of upstream
+			p=3D" u+${count#0	}" ;;
+		*"	0") # behind upstream
+			p=3D" u-${count%	0}" ;;
+		*)	    # diverged from upstream
+			p=3D" u+${count#*	}-${count%	*}" ;;
+		esac
+	fi
+
+}
+
+
+# __git_ps1 accepts 0 or 1 arguments (i.e., format string)
+# returns text to add to bash PS1 prompt (includes branch name)
+__git_ps1 ()
+{
+	local g=3D"$(__gitdir)"
+	if [ -n "$g" ]; then
+		local r=3D""
+		local b=3D""
+		if [ -f "$g/rebase-merge/interactive" ]; then
+			r=3D"|REBASE-i"
+			b=3D"$(cat "$g/rebase-merge/head-name")"
+		elif [ -d "$g/rebase-merge" ]; then
+			r=3D"|REBASE-m"
+			b=3D"$(cat "$g/rebase-merge/head-name")"
+		else
+			if [ -d "$g/rebase-apply" ]; then
+				if [ -f "$g/rebase-apply/rebasing" ]; then
+					r=3D"|REBASE"
+				elif [ -f "$g/rebase-apply/applying" ]; then
+					r=3D"|AM"
+				else
+					r=3D"|AM/REBASE"
+				fi
+			elif [ -f "$g/MERGE_HEAD" ]; then
+				r=3D"|MERGING"
+			elif [ -f "$g/CHERRY_PICK_HEAD" ]; then
+				r=3D"|CHERRY-PICKING"
+			elif [ -f "$g/BISECT_LOG" ]; then
+				r=3D"|BISECTING"
+			fi
+
+			b=3D"$(git symbolic-ref HEAD 2>/dev/null)" || {
+
+				b=3D"$(
+				case "${GIT_PS1_DESCRIBE_STYLE-}" in
+				(contains)
+					git describe --contains HEAD ;;
+				(branch)
+					git describe --contains --all HEAD ;;
+				(describe)
+					git describe HEAD ;;
+				(* | default)
+					git describe --tags --exact-match HEAD ;;
+				esac 2>/dev/null)" ||
+
+				b=3D"$(cut -c1-7 "$g/HEAD" 2>/dev/null)..." ||
+				b=3D"unknown"
+				b=3D"($b)"
+			}
+		fi
+
+		local w=3D""
+		local i=3D""
+		local s=3D""
+		local u=3D""
+		local c=3D""
+		local p=3D""
+
+		if [ "true" =3D "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]=
; then
+			if [ "true" =3D "$(git rev-parse --is-bare-repository 2>/dev/null)"=
 ]; then
+				c=3D"BARE:"
+			else
+				b=3D"GIT_DIR!"
+			fi
+		elif [ "true" =3D "$(git rev-parse --is-inside-work-tree 2>/dev/null=
)" ]; then
+			if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
+				if [ "$(git config --bool bash.showDirtyState)" !=3D "false" ]; th=
en
+					git diff --no-ext-diff --quiet --exit-code || w=3D"*"
+					if git rev-parse --quiet --verify HEAD >/dev/null; then
+						git diff-index --cached --quiet HEAD -- || i=3D"+"
+					else
+						i=3D"#"
+					fi
+				fi
+			fi
+			if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]; then
+				git rev-parse --verify refs/stash >/dev/null 2>&1 && s=3D"$"
+			fi
+
+			if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ]; then
+				if [ -n "$(git ls-files --others --exclude-standard)" ]; then
+					u=3D"%"
+				fi
+			fi
+
+			if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
+				__git_ps1_show_upstream
+			fi
+		fi
+
+		local f=3D"$w$i$s$u"
+		printf -- "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
+	fi
+}
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 96468ce..f17c1f8 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -7,7 +7,7 @@ test_description=3D'test git-specific bash prompt funct=
ions'
=20
 . ./lib-bash.sh
=20
-. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"
+. "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
=20
 actual=3D"$TRASH_DIRECTORY/actual"
=20
--=20
1.7.10.2
