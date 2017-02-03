Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C6831F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 02:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752315AbdBCCtt (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:49:49 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33388 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752258AbdBCCtg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:49:36 -0500
Received: by mail-wm0-f68.google.com with SMTP id v77so1190020wmv.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WGuj5CwyDvBbH5hW9nV0lD/l1FqB3Wl7+1AOTRXYcJ8=;
        b=kL9EK02fLzB5MWkoOc78C4L3hNYF1vMk0t6IODw61Sllg7R7dvqGubCOrOVtLeq7jC
         0msUxf10Jzn/P3Sd75YE9UXl7C4lMtstr88FrCMNJTkyYiKQXXsH6AeaJux/DJRj2m/P
         l1dv0W8awM2diW4KlpZONmeDmfUtkqAsiZz7HTnDoM4Fzta8tCr4sKI3eOPo1JslEt0L
         YM8E5srRbPR2upHiVpIWnAKZdJC0bgQldEerg+ggdhkl85IOcUZZTw7fDzlgsJl8/OmV
         Tgi8Kw+e6JoN08Nqdj1VZySp1NlmugC/L6vT1s3IZwm1IZqhc9q8gbUXYgc+5zvbw/F+
         TsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WGuj5CwyDvBbH5hW9nV0lD/l1FqB3Wl7+1AOTRXYcJ8=;
        b=Re2aKjNnLpGWdk3HRkNyPlC7yWUO24GxgpUMbBZDi+i30lAUBjFrk8SYHVX5CwPQBI
         dC4OCecaLHs11xCQyU6nomajPkk1D1HWf5U7t0nRshSqoUIdB7QwvIL6kp0L205dovVM
         /nm+e76fm4PvqUpDhD5BySedZx4ZmabFc0yiOcY7HcQYV06nf31nt3IQUV2r7w7zXsqE
         LsdGrBPbPIUGlDHpRTd8xpUYrfQsNWu8ThLmv9P+F3mhBrnYAotv/yVZOjV1M9SS2obM
         7Hivv5lSWtHtSzUCHRJCGgzpd00sqZQUOKlrbRcTCV9yWjf/OGOYV4UhXcfx244Q74f+
         ej1A==
X-Gm-Message-State: AIkVDXIS+Rh3yJdct09JafnrwAMr6vA4eAOcqtrJhPb1K4/Gs4CRUVrOU1nEmAZ1YqvV1Q==
X-Received: by 10.223.136.50 with SMTP id d47mr12028725wrd.167.1486090169334;
        Thu, 02 Feb 2017 18:49:29 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id k43sm42867464wrc.46.2017.02.02.18.49.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:49:28 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 17/21] completion: don't use __gitdir() for git commands
Date:   Fri,  3 Feb 2017 03:48:25 +0100
Message-Id: <20170203024829.8071-18-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170203024829.8071-1-szeder.dev@gmail.com>
References: <20170203024829.8071-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several completion functions contain the following pattern to run git
commands respecting the path to the repository specified on the
command line:

  git --git-dir="$(__gitdir)" <cmd> <options>

This imposes the overhead of fork()ing a subshell for the command
substitution and potentially fork()+exec()ing 'git rev-parse' inside
__gitdir().

Now, if neither '--gitdir=<path>' nor '-C <path>' options are
specified on the command line, then those git commands are perfectly
capable to discover the repository on their own.  If either one or
both of those options are specified on the command line, then, again,
the git commands could discover the repository, if we pass them all of
those options from the command line.

This means we don't have to run __gitdir() at all for git commands and
can spare its fork()+exec() overhead.

Use Bash parameter expansions to check the $__git_dir variable and
$__git_C_args array and to assemble the appropriate '--git-dir=<path>'
and '-C <path>' options if either one or both are present on the
command line.  These parameter expansions are, however, rather long,
so instead of changing all git executions and make already long lines
even longer, encapsulate running git with '--git-dir=<path> -C <path>'
options into the new __git() wrapper function.  Furthermore, this
wrapper function will also enable us to silence error messages from
git commands uniformly in one place in a later commit.

There's one tricky case, though: in __git_refs() local refs are listed
with 'git for-each-ref', where "local" is not necessarily the
repository we are currently in, but it might mean a remote repository
in the filesystem (e.g. listing refs for 'git fetch /some/other/repo
<TAB>').  Use one-shot variable assignment to override $__git_dir with
the path of the repository where the refs should come from.  Although
one-shot variable assignments in front of shell functions are to be
avoided in our scripts in general, in the Bash completion script we
can do that safely.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 60 ++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e003afd54..e7c0b56ea 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -61,6 +61,14 @@ __gitdir ()
 	fi
 }
 
+# Runs git with all the options given as argument, respecting any
+# '--git-dir=<path>' and '-C <path>' options present on the command line
+__git ()
+{
+	git ${__git_C_args:+"${__git_C_args[@]}"} \
+		${__git_dir:+--git-dir="$__git_dir"} "$@"
+}
+
 # The following function is based on code from:
 #
 #   bash_completion - programmable completion functions for bash 3.2+
@@ -287,13 +295,11 @@ __gitcomp_file ()
 # argument, and using the options specified in the second argument.
 __git_ls_files_helper ()
 {
-	local dir="$(__gitdir)"
-
 	if [ "$2" == "--committable" ]; then
-		git ${__git_C_args:+"${__git_C_args[@]}"} --git-dir="$dir" -C "$1" diff-index --name-only --relative HEAD
+		__git -C "$1" diff-index --name-only --relative HEAD
 	else
 		# NOTE: $2 is not quoted in order to support multiple options
-		git ${__git_C_args:+"${__git_C_args[@]}"} --git-dir="$dir" -C "$1" ls-files --exclude-standard $2
+		__git -C "$1" ls-files --exclude-standard $2
 	fi 2>/dev/null
 }
 
@@ -323,8 +329,7 @@ __git_heads ()
 {
 	local dir="$(__gitdir)"
 	if [ -d "$dir" ]; then
-		git --git-dir="$dir" for-each-ref --format='%(refname:short)' \
-			refs/heads
+		__git for-each-ref --format='%(refname:short)' refs/heads
 		return
 	fi
 }
@@ -333,8 +338,7 @@ __git_tags ()
 {
 	local dir="$(__gitdir)"
 	if [ -d "$dir" ]; then
-		git --git-dir="$dir" for-each-ref --format='%(refname:short)' \
-			refs/tags
+		__git for-each-ref --format='%(refname:short)' refs/tags
 		return
 	fi
 }
@@ -385,14 +389,14 @@ __git_refs ()
 			refs="refs/tags refs/heads refs/remotes"
 			;;
 		esac
-		git --git-dir="$dir" for-each-ref --format="$pfx%($format)" \
+		__git_dir="$dir" __git for-each-ref --format="$pfx%($format)" \
 			$refs
 		if [ -n "$track" ]; then
 			# employ the heuristic used by git checkout
 			# Try to find a remote branch that matches the completion word
 			# but only output if the branch name is unique
 			local ref entry
-			git --git-dir="$dir" for-each-ref --shell --format="ref=%(refname:short)" \
+			__git for-each-ref --shell --format="ref=%(refname:short)" \
 				"refs/remotes/" | \
 			while read -r entry; do
 				eval "$entry"
@@ -406,7 +410,7 @@ __git_refs ()
 	fi
 	case "$cur" in
 	refs|refs/*)
-		git --git-dir="$dir" ls-remote "$remote" "$cur*" 2>/dev/null | \
+		__git ls-remote "$remote" "$cur*" 2>/dev/null | \
 		while read -r hash i; do
 			case "$i" in
 			*^{}) ;;
@@ -417,10 +421,10 @@ __git_refs ()
 	*)
 		if [ "$list_refs_from" = remote ]; then
 			echo "HEAD"
-			git --git-dir="$dir" for-each-ref --format="%(refname:short)" \
+			__git for-each-ref --format="%(refname:short)" \
 				"refs/remotes/$remote/" 2>/dev/null | sed -e "s#^$remote/##"
 		else
-			git --git-dir="$dir" ls-remote "$remote" HEAD \
+			__git ls-remote "$remote" HEAD \
 				"refs/tags/*" "refs/heads/*" "refs/remotes/*" 2>/dev/null |
 			while read -r hash i; do
 				case "$i" in
@@ -447,7 +451,7 @@ __git_refs2 ()
 __git_refs_remotes ()
 {
 	local i hash
-	git --git-dir="$(__gitdir)" ls-remote "$1" 'refs/heads/*' 2>/dev/null | \
+	__git ls-remote "$1" 'refs/heads/*' 2>/dev/null | \
 	while read -r hash i; do
 		echo "$i:refs/remotes/$1/${i#refs/heads/}"
 	done
@@ -457,7 +461,7 @@ __git_remotes ()
 {
 	local d="$(__gitdir)"
 	test -d "$d/remotes" && ls -1 "$d/remotes"
-	git --git-dir="$d" remote
+	__git remote
 }
 
 # Returns true if $1 matches the name of a configured remote, false otherwise.
@@ -523,7 +527,7 @@ __git_complete_revlist_file ()
 		*)   pfx="$ref:$pfx" ;;
 		esac
 
-		__gitcomp_nl "$(git ${__git_C_args:+"${__git_C_args[@]}"} --git-dir="$(__gitdir)" ls-tree "$ls" 2>/dev/null \
+		__gitcomp_nl "$(__git ls-tree "$ls" 2>/dev/null \
 				| sed '/^100... blob /{
 				           s,^.*	,,
 				           s,$, ,
@@ -801,7 +805,7 @@ __git_compute_porcelain_commands ()
 __git_get_config_variables ()
 {
 	local section="$1" i IFS=$'\n'
-	for i in $(git --git-dir="$(__gitdir)" config --name-only --get-regexp "^$section\..*" 2>/dev/null); do
+	for i in $(__git config --name-only --get-regexp "^$section\..*" 2>/dev/null); do
 		echo "${i#$section.}"
 	done
 }
@@ -819,8 +823,7 @@ __git_aliases ()
 # __git_aliased_command requires 1 argument
 __git_aliased_command ()
 {
-	local word cmdline=$(git --git-dir="$(__gitdir)" \
-		config --get "alias.$1" 2>/dev/null)
+	local word cmdline=$(__git config --get "alias.$1" 2>/dev/null)
 	for word in $cmdline; do
 		case "$word" in
 		\!gitk|gitk)
@@ -896,7 +899,7 @@ __git_get_option_value ()
 	done
 
 	if [ -n "$config_key" ] && [ -z "$result" ]; then
-		result="$(git --git-dir="$(__gitdir)" config "$config_key")"
+		result="$(__git config "$config_key")"
 	fi
 
 	echo "$result"
@@ -1237,7 +1240,7 @@ _git_commit ()
 		return
 	esac
 
-	if git --git-dir="$(__gitdir)" rev-parse --verify --quiet HEAD >/dev/null; then
+	if __git rev-parse --verify --quiet HEAD >/dev/null; then
 		__git_complete_index_file "--committable"
 	else
 		# This is the first commit
@@ -1839,7 +1842,7 @@ _git_send_email ()
 	case "$prev" in
 	--to|--cc|--bcc|--from)
 		__gitcomp "
-		$(git --git-dir="$(__gitdir)" send-email --dump-aliases 2>/dev/null)
+		$(__git send-email --dump-aliases 2>/dev/null)
 		"
 		return
 		;;
@@ -1871,7 +1874,7 @@ _git_send_email ()
 		;;
 	--to=*|--cc=*|--bcc=*|--from=*)
 		__gitcomp "
-		$(git --git-dir="$(__gitdir)" send-email --dump-aliases 2>/dev/null)
+		$(__git send-email --dump-aliases 2>/dev/null)
 		" "" "${cur#--*=}"
 		return
 		;;
@@ -1966,7 +1969,7 @@ __git_config_get_set_variables ()
 		c=$((--c))
 	done
 
-	git --git-dir="$(__gitdir)" config $config_file --name-only --list 2>/dev/null
+	__git config $config_file --name-only --list 2>/dev/null
 }
 
 _git_config ()
@@ -2001,9 +2004,8 @@ _git_config ()
 	remote.*.push)
 		local remote="${prev#remote.}"
 		remote="${remote%.push}"
-		__gitcomp_nl "$(git --git-dir="$(__gitdir)" \
-			for-each-ref --format='%(refname):%(refname)' \
-			refs/heads)"
+		__gitcomp_nl "$(__git for-each-ref
+			--format='%(refname):%(refname)' refs/heads)"
 		return
 		;;
 	pull.twohead|pull.octopus)
@@ -2591,12 +2593,12 @@ _git_stash ()
 			if [ $cword -eq 3 ]; then
 				__gitcomp_nl "$(__git_refs)";
 			else
-				__gitcomp_nl "$(git --git-dir="$(__gitdir)" stash list \
+				__gitcomp_nl "$(__git stash list \
 						| sed -n -e 's/:.*//p')"
 			fi
 			;;
 		show,*|apply,*|drop,*|pop,*)
-			__gitcomp_nl "$(git --git-dir="$(__gitdir)" stash list \
+			__gitcomp_nl "$(__git stash list \
 					| sed -n -e 's/:.*//p')"
 			;;
 		*)
-- 
2.11.0.555.g967c1bcb3

