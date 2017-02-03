Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EE641F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 02:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752281AbdBCCti (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:49:38 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36407 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752241AbdBCCtb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:49:31 -0500
Received: by mail-wm0-f66.google.com with SMTP id r18so1169334wmd.3
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zEtAacUhDe2a5yMELk0Pd2vSOWK2I+3sL0OK8243frE=;
        b=RcsxHr6NHTOwloeN2n/M8FTuDymCmbrwuGagjMUwyutBKd/XQm+lM90UWoHLgn3RUQ
         xYwgvuQUTdpWQ0upq0Mmo9tEwjXN9VeC2at52mZvQ47DQwucD2z7Mqc3XvlQgdExxis6
         QGKMr68H4o3SxJaiI3TPxEjFvP6XOd2C7E+a5+CRgiPrCyRdG42lvYybKGL9vHVDqclU
         S/fdNQEzsClWYxybBjbfVfZ8jr9ofzm3kCBGhtC+Eaa4ulF7cv6f4EXjp4uaaK52JzZ+
         ALNLhTEjp90B8Kk1S1I0gJ7RXA+QfwYepU8Ynxjw8K7hdVsH0bIHui33FNNTXOhrE4/r
         Y2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zEtAacUhDe2a5yMELk0Pd2vSOWK2I+3sL0OK8243frE=;
        b=ODWqPGI/eaqIId4lz03nXx7u20tGr07RU1e4BnM/gphCEpwUFj9ETNrtLMsz4T7cHd
         3q+RmrsPrmpNJR1oECglT+57BBTJmFXJ0YMT0x8V57M1oWFKqrAwqIN64hSN8eJ9XZa2
         oruWFnb2+yvMcv9yuv3ukiO+j6VtpPJaJoYIUK0k1Fn1C42wE3ZeHcb9Jn5ftd/sUdI7
         4m0Im5rqSH2BfpEUQY8gd1pgZ5KzgtNlGf903VXIACBmRl5iWYXWuSf79QVv/FAAf4RI
         UK3f2xR3Xw8qu7GsPAJZ1X8Xl8Hm0ce6KCs1p6RNChMek8ZkzQVIcuCL91yEl4/YAybC
         JgRQ==
X-Gm-Message-State: AIkVDXKR0KmAfjWOrkwv8LVMoUPFK4hIuuBlN0W5C0SbI2QqEoXpEyJtrakaURK718Lvsw==
X-Received: by 10.223.146.228 with SMTP id 91mr9974972wrn.203.1486090170101;
        Thu, 02 Feb 2017 18:49:30 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id k43sm42867464wrc.46.2017.02.02.18.49.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:49:29 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 18/21] completion: consolidate silencing errors from git commands
Date:   Fri,  3 Feb 2017 03:48:26 +0100
Message-Id: <20170203024829.8071-19-szeder.dev@gmail.com>
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

Outputting error messages during completion is bad: they disrupt the
command line, can't be deleted, and the user is forced to Ctrl-C and
start over most of the time.  We already silence stderr of many git
commands in our Bash completion script, but there are still some in
there that can spew error messages when something goes wrong.

We could add the missing stderr redirections to all the remaining
places, but instead let's leverage that git commands are now executed
through the previously introduced __git() wrapper function, and
redirect standard error to /dev/null only in that function.  This way
we need only one redirection to take care of errors from almost all
git commands.  Redirecting standard error of the __git() wrapper
function thus became redundant, remove them.

The exceptions, i.e. the repo-independent git executions and those in
the __gitdir() function that don't go through __git() already have
their standard error silenced.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e7c0b56ea..1a849761f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -66,7 +66,7 @@ __gitdir ()
 __git ()
 {
 	git ${__git_C_args:+"${__git_C_args[@]}"} \
-		${__git_dir:+--git-dir="$__git_dir"} "$@"
+		${__git_dir:+--git-dir="$__git_dir"} "$@" 2>/dev/null
 }
 
 # The following function is based on code from:
@@ -300,7 +300,7 @@ __git_ls_files_helper ()
 	else
 		# NOTE: $2 is not quoted in order to support multiple options
 		__git -C "$1" ls-files --exclude-standard $2
-	fi 2>/dev/null
+	fi
 }
 
 
@@ -410,7 +410,7 @@ __git_refs ()
 	fi
 	case "$cur" in
 	refs|refs/*)
-		__git ls-remote "$remote" "$cur*" 2>/dev/null | \
+		__git ls-remote "$remote" "$cur*" | \
 		while read -r hash i; do
 			case "$i" in
 			*^{}) ;;
@@ -422,10 +422,10 @@ __git_refs ()
 		if [ "$list_refs_from" = remote ]; then
 			echo "HEAD"
 			__git for-each-ref --format="%(refname:short)" \
-				"refs/remotes/$remote/" 2>/dev/null | sed -e "s#^$remote/##"
+				"refs/remotes/$remote/" | sed -e "s#^$remote/##"
 		else
 			__git ls-remote "$remote" HEAD \
-				"refs/tags/*" "refs/heads/*" "refs/remotes/*" 2>/dev/null |
+				"refs/tags/*" "refs/heads/*" "refs/remotes/*" |
 			while read -r hash i; do
 				case "$i" in
 				*^{})	;;
@@ -451,7 +451,7 @@ __git_refs2 ()
 __git_refs_remotes ()
 {
 	local i hash
-	__git ls-remote "$1" 'refs/heads/*' 2>/dev/null | \
+	__git ls-remote "$1" 'refs/heads/*' | \
 	while read -r hash i; do
 		echo "$i:refs/remotes/$1/${i#refs/heads/}"
 	done
@@ -527,7 +527,7 @@ __git_complete_revlist_file ()
 		*)   pfx="$ref:$pfx" ;;
 		esac
 
-		__gitcomp_nl "$(__git ls-tree "$ls" 2>/dev/null \
+		__gitcomp_nl "$(__git ls-tree "$ls" \
 				| sed '/^100... blob /{
 				           s,^.*	,,
 				           s,$, ,
@@ -805,7 +805,7 @@ __git_compute_porcelain_commands ()
 __git_get_config_variables ()
 {
 	local section="$1" i IFS=$'\n'
-	for i in $(__git config --name-only --get-regexp "^$section\..*" 2>/dev/null); do
+	for i in $(__git config --name-only --get-regexp "^$section\..*"); do
 		echo "${i#$section.}"
 	done
 }
@@ -823,7 +823,7 @@ __git_aliases ()
 # __git_aliased_command requires 1 argument
 __git_aliased_command ()
 {
-	local word cmdline=$(__git config --get "alias.$1" 2>/dev/null)
+	local word cmdline=$(__git config --get "alias.$1")
 	for word in $cmdline; do
 		case "$word" in
 		\!gitk|gitk)
@@ -1841,9 +1841,7 @@ _git_send_email ()
 {
 	case "$prev" in
 	--to|--cc|--bcc|--from)
-		__gitcomp "
-		$(__git send-email --dump-aliases 2>/dev/null)
-		"
+		__gitcomp "$(__git send-email --dump-aliases)"
 		return
 		;;
 	esac
@@ -1873,9 +1871,7 @@ _git_send_email ()
 		return
 		;;
 	--to=*|--cc=*|--bcc=*|--from=*)
-		__gitcomp "
-		$(__git send-email --dump-aliases 2>/dev/null)
-		" "" "${cur#--*=}"
+		__gitcomp "$(__git send-email --dump-aliases)" "" "${cur#--*=}"
 		return
 		;;
 	--*)
@@ -1969,7 +1965,7 @@ __git_config_get_set_variables ()
 		c=$((--c))
 	done
 
-	__git config $config_file --name-only --list 2>/dev/null
+	__git config $config_file --name-only --list
 }
 
 _git_config ()
-- 
2.11.0.555.g967c1bcb3

