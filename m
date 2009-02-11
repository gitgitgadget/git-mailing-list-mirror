From: Ted Pavlic <ted@tedpavlic.com>
Subject: [PATCH 2/3] completion: Change "if [...]" to "if test ..." to match git convention
Date: Wed, 11 Feb 2009 10:37:13 -0500
Message-ID: <1234366634-17900-3-git-send-email-ted@tedpavlic.com>
References: <1234366634-17900-1-git-send-email-ted@tedpavlic.com>
 <1234366634-17900-2-git-send-email-ted@tedpavlic.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Ted Pavlic <ted@tedpavlic.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Feb 11 16:39:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXHBK-0002IF-Lb
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 16:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756043AbZBKPhh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 10:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755925AbZBKPhf
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 10:37:35 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:35902 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757531AbZBKPh1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2009 10:37:27 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 1B34A80D8036;
	Wed, 11 Feb 2009 10:30:55 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yhNdetOBreaa; Wed, 11 Feb 2009 10:30:55 -0500 (EST)
Received: from localhost.localdomain (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id EDBBC80D8065;
	Wed, 11 Feb 2009 10:30:54 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.390.gba743
In-Reply-To: <1234366634-17900-2-git-send-email-ted@tedpavlic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109428>

In the single case of:

    if [...] || [...]

changed to:

    if test ... || test ...

However,

    if test ... -o ...

might be favorable (although arguably less readable).

Also changed:

    if test ...
    then

to:

    if test ...; then

Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
---
 contrib/completion/git-completion.bash |   91 ++++++++++++++-----------------
 1 files changed, 41 insertions(+), 50 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6bbe09a..6772be7 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -61,15 +61,15 @@ esac
 # returns location of .git repo
 __gitdir ()
 {
-	if [ -z "${1-}" ]; then
-		if [ -n "$__git_dir" ]; then
+	if test -z "${1-}"; then
+		if test -n "$__git_dir"; then
 			echo "$__git_dir"
-		elif [ -d .git ]; then
+		elif test -d .git; then
 			echo .git
 		else
 			git rev-parse --git-dir 2>/dev/null
 		fi
-	elif [ -d "$1/.git" ]; then
+	elif test -d "$1/.git"; then
 		echo "$1/.git"
 	else
 		echo "$1"
@@ -81,42 +81,33 @@ __gitdir ()
 __git_ps1 ()
 {
 	local g="$(__gitdir)"
-	if [ -n "$g" ]; then
+	if test -n "$g"; then
 		local r
 		local b
-		if [ -d "$g/rebase-apply" ]
-		then
-			if test -f "$g/rebase-apply/rebasing"
-			then
+		if test -d "$g/rebase-apply"; then
+			if test -f "$g/rebase-apply/rebasing"; then
 				r="|REBASE"
-			elif test -f "$g/rebase-apply/applying"
-			then
+			elif test -f "$g/rebase-apply/applying"; then
 				r="|AM"
 			else
 				r="|AM/REBASE"
 			fi
 			b="$(git symbolic-ref HEAD 2>/dev/null)"
-		elif [ -f "$g/rebase-merge/interactive" ]
-		then
+		elif test -f "$g/rebase-merge/interactive"; then
 			r="|REBASE-i"
 			b="$(cat "$g/rebase-merge/head-name")"
-		elif [ -d "$g/rebase-merge" ]
-		then
+		elif test -d "$g/rebase-merge"; then
 			r="|REBASE-m"
 			b="$(cat "$g/rebase-merge/head-name")"
-		elif [ -f "$g/MERGE_HEAD" ]
-		then
+		elif test -f "$g/MERGE_HEAD"; then
 			r="|MERGING"
 			b="$(git symbolic-ref HEAD 2>/dev/null)"
 		else
-			if [ -f "$g/BISECT_LOG" ]
-			then
+			if test -f "$g/BISECT_LOG"; then
 				r="|BISECTING"
 			fi
-			if ! b="$(git symbolic-ref HEAD 2>/dev/null)"
-			then
-				if ! b="$(git describe --exact-match HEAD 2>/dev/null)"
-				then
+			if ! b="$(git symbolic-ref HEAD 2>/dev/null)"; then
+				if ! b="$(git describe --exact-match HEAD 2>/dev/null)"; then
 					b="$(cut -c1-7 "$g/HEAD")..."
 				fi
 			fi
@@ -138,7 +129,7 @@ __git_ps1 ()
 			fi
 		fi
 
-		if [ -n "${1-}" ]; then
+		if test -n "${1-}"; then
 			printf "$1" "${b##refs/heads/}$w$i$r"
 		else
 			printf " (%s)" "${b##refs/heads/}$w$i$r"
@@ -164,7 +155,7 @@ __gitcomp_1 ()
 __gitcomp ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
-	if [ $# -gt 2 ]; then
+	if test $# -gt 2; then
 		cur="$3"
 	fi
 	case "$cur" in
@@ -184,7 +175,7 @@ __gitcomp ()
 __git_heads ()
 {
 	local cmd i is_hash=y dir="$(__gitdir "${1-}")"
-	if [ -d "$dir" ]; then
+	if test -d "$dir"; then
 		git --git-dir="$dir" for-each-ref --format='%(refname:short)' \
 			refs/heads
 		return
@@ -203,7 +194,7 @@ __git_heads ()
 __git_tags ()
 {
 	local cmd i is_hash=y dir="$(__gitdir "${1-}")"
-	if [ -d "$dir" ]; then
+	if test -d "$dir"; then
 		git --git-dir="$dir" for-each-ref --format='%(refname:short)' \
 			refs/tags
 		return
@@ -223,14 +214,14 @@ __git_refs ()
 {
 	local i is_hash=y dir="$(__gitdir "${1-}")"
 	local cur="${COMP_WORDS[COMP_CWORD]}" format refs
-	if [ -d "$dir" ]; then
+	if test -d "$dir"; then
 		case "$cur" in
 		refs|refs/*)
 			format="refname"
 			refs="${cur%/*}"
 			;;
 		*)
-			if [ -e "$dir/HEAD" ]; then echo HEAD; fi
+			if test -e "$dir/HEAD"; then echo HEAD; fi
 			format="refname:short"
 			refs="refs/tags refs/heads refs/remotes"
 			;;
@@ -299,7 +290,7 @@ __git_remotes ()
 
 __git_merge_strategies ()
 {
-	if [ -n "$__git_merge_strategylist" ]; then
+	if test -n "$__git_merge_strategylist"; then
 		echo "$__git_merge_strategylist"
 		return
 	fi
@@ -385,7 +376,7 @@ __git_complete_revlist ()
 
 __git_all_commands ()
 {
-	if [ -n "$__git_all_commandlist" ]; then
+	if test -n "$__git_all_commandlist"; then
 		echo "$__git_all_commandlist"
 		return
 	fi
@@ -403,7 +394,7 @@ __git_all_commandlist="$(__git_all_commands 2>/dev/null)"
 
 __git_porcelain_commands ()
 {
-	if [ -n "$__git_porcelain_commandlist" ]; then
+	if test -n "$__git_porcelain_commandlist"; then
 		echo "$__git_porcelain_commandlist"
 		return
 	fi
@@ -511,7 +502,7 @@ __git_aliased_command ()
 	local word cmdline=$(git --git-dir="$(__gitdir)" \
 		config --get "alias.$1")
 	for word in $cmdline; do
-		if [ "${word##-*}" ]; then
+		if test "${word##-*}"; then
 			echo $word
 			return
 		fi
@@ -526,7 +517,7 @@ __git_find_subcommand ()
 	while [ $c -lt $COMP_CWORD ]; do
 		word="${COMP_WORDS[c]}"
 		for subcommand in $1; do
-			if [ "$subcommand" = "$word" ]; then
+			if test "$subcommand" = "$word"; then
 				echo "$subcommand"
 				return
 			fi
@@ -539,7 +530,7 @@ __git_has_doubledash ()
 {
 	local c=1
 	while [ $c -lt $COMP_CWORD ]; do
-		if [ "--" = "${COMP_WORDS[c]}" ]; then
+		if test "--" = "${COMP_WORDS[c]}"; then
 			return 0
 		fi
 		c=$((++c))
@@ -552,7 +543,7 @@ __git_whitespacelist="nowarn warn error error-all fix"
 _git_am ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}" dir="$(__gitdir)"
-	if [ -d "$dir"/rebase-apply ]; then
+	if test -d "$dir"/rebase-apply; then
 		__gitcomp "--skip --resolved --abort"
 		return
 	fi
@@ -636,7 +627,7 @@ _git_bisect ()
 
 	local subcommands="start bad good skip reset visualize replay log run"
 	local subcommand="$(__git_find_subcommand "$subcommands")"
-	if [ -z "$subcommand" ]; then
+	if test -z "$subcommand"; then
 		__gitcomp "$subcommands"
 		return
 	fi
@@ -672,7 +663,7 @@ _git_branch ()
 			"
 		;;
 	*)
-		if [ $only_local_ref = "y" -a $has_r = "n" ]; then
+		if test $only_local_ref = "y" -a $has_r = "n"; then
 			__gitcomp "$(__git_heads)"
 		else
 			__gitcomp "$(__git_refs)"
@@ -830,7 +821,7 @@ _git_fetch ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 
-	if [ "$COMP_CWORD" = 2 ]; then
+	if test "$COMP_CWORD" = 2; then
 		__gitcomp "$(__git_remotes)"
 	else
 		case "$cur" in
@@ -1088,7 +1079,7 @@ _git_pull ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 
-	if [ "$COMP_CWORD" = 2 ]; then
+	if test "$COMP_CWORD" = 2; then
 		__gitcomp "$(__git_remotes)"
 	else
 		__gitcomp "$(__git_refs "${COMP_WORDS[2]}")"
@@ -1099,7 +1090,7 @@ _git_push ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 
-	if [ "$COMP_CWORD" = 2 ]; then
+	if test "$COMP_CWORD" = 2; then
 		__gitcomp "$(__git_remotes)"
 	else
 		case "$cur" in
@@ -1125,7 +1116,7 @@ _git_push ()
 _git_rebase ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}" dir="$(__gitdir)"
-	if [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; then
+	if test -d "$dir"/rebase-apply || test -d "$dir"/rebase-merge; then
 		__gitcomp "--continue --skip --abort"
 		return
 	fi
@@ -1416,7 +1407,7 @@ _git_remote ()
 {
 	local subcommands="add rename rm show prune update"
 	local subcommand="$(__git_find_subcommand "$subcommands")"
-	if [ -z "$subcommand" ]; then
+	if test -z "$subcommand"; then
 		__gitcomp "$subcommands"
 		return
 	fi
@@ -1546,7 +1537,7 @@ _git_stash ()
 {
 	local subcommands='save list show apply clear drop pop create branch'
 	local subcommand="$(__git_find_subcommand "$subcommands")"
-	if [ -z "$subcommand" ]; then
+	if test -z "$subcommand"; then
 		__gitcomp "$subcommands"
 	else
 		local cur="${COMP_WORDS[COMP_CWORD]}"
@@ -1576,7 +1567,7 @@ _git_submodule ()
 	__git_has_doubledash && return
 
 	local subcommands="add status init update summary foreach sync"
-	if [ -z "$(__git_find_subcommand "$subcommands")" ]; then
+	if test -z "$(__git_find_subcommand "$subcommands")"; then
 		local cur="${COMP_WORDS[COMP_CWORD]}"
 		case "$cur" in
 		--*)
@@ -1598,7 +1589,7 @@ _git_svn ()
 		proplist show-ignore show-externals
 		"
 	local subcommand="$(__git_find_subcommand "$subcommands")"
-	if [ -z "$subcommand" ]; then
+	if test -z "$subcommand"; then
 		__gitcomp "$subcommands"
 	else
 		local remote_opts="--username= --config-dir= --no-auth-cache"
@@ -1690,7 +1681,7 @@ _git_tag ()
 		COMPREPLY=()
 		;;
 	-*|tag)
-		if [ $f = 1 ]; then
+		if test $f = 1; then
 			__gitcomp "$(__git_tags)"
 		else
 			COMPREPLY=()
@@ -1718,7 +1709,7 @@ _git ()
 		c=$((++c))
 	done
 
-	if [ -z "$command" ]; then
+	if test -z "$command"; then
 		case "${COMP_WORDS[COMP_CWORD]}" in
 		--*)   __gitcomp "
 			--paginate
@@ -1799,7 +1790,7 @@ _gitk ()
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	local g="$(__gitdir)"
 	local merge=""
-	if [ -f $g/MERGE_HEAD ]; then
+	if test -f $g/MERGE_HEAD; then
 		merge="--merge"
 	fi
 	case "$cur" in
@@ -1820,7 +1811,7 @@ complete -o bashdefault -o default -o nospace -F _gitk gitk 2>/dev/null \
 # when the user has tab-completed the executable name and consequently
 # included the '.exe' suffix.
 #
-if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
+if test Cygwin = "$(uname -o 2>/dev/null)"; then
 complete -o bashdefault -o default -o nospace -F _git git.exe 2>/dev/null \
 	|| complete -o default -o nospace -F _git git.exe
 fi
-- 
1.6.1.2.390.gba743
