Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D60C433B4
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 10:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E6ED6145C
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 10:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbhDVKBs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 06:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235735AbhDVKBp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 06:01:45 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC73C06138B
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 03:01:08 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g1-20020a17090adac1b0290150d07f9402so678349pjx.5
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 03:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4AjfO5qTjdDZZ61yrdxNL4RoAuDFhMXQ7me7ET0YY3I=;
        b=q7on7goYq1rGfhBMDL6XMDzs1Ec0WN0aOQAYrQG1GFXwS6kT9U/tx4BAB54x/l9P+H
         5Z18Z8VzfOeyV9w52AFoVedYaRWryez59PVECb/lUix92qvXTJs6oYGJqyPEfo49jzqM
         8Ugszq1KRrhf+uO4hKqL/4eXDMmvnNO+6c2wZh4JMjcDk9weWWwnK5rWevObh7qPEkqd
         8qEdv3bCssc6JqCGhz/WRQk91/TepJgOFNlVFDT5E+FHP6URsBDzgo7Uxvoe0r8KZMV2
         NX2Xx5jMkGo07ZfbP/265NoDNr4maxzFdbgN5moRG4PtvtZ1OU8YB/IU0kYPtbCFofUd
         f8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4AjfO5qTjdDZZ61yrdxNL4RoAuDFhMXQ7me7ET0YY3I=;
        b=QnfFnKTxS4tM19NGP7xueAO1ABglvQmtfe2v0YsHXwlhcDQjf3Lpu7b1yIOwsL0tk5
         pQHtaO6DXn3XKWzVnc43CNGhCfwwnKz8j2dQbcrSnXXd3NyxEljY1tQcHrqoB11BIwRi
         /woRuntun+M0920Ek3O29vPjRiNeSWAUNV/iWxBfdh86NWG/TgThL0aW4RVvmVw6U2+K
         Nb2bFDpaUPBTzIkQQ6L4BzVw6TT/5PApY9MUZe7cA2HHPtaCq6o1G0AvHRngJ+iCAaX3
         OCrxfubmmLXaCe4Dy5mJbKlMRAz22wVZi7HltH5YlHM3vsM7tX2y6tOyhyEeVpRyW0k1
         qFvg==
X-Gm-Message-State: AOAM533jZciHfTEhCyaAVTR0xdfoZwLFxWz2ygGb21T8sTeGH6YUn69Y
        MP2piQUOU3xgAlJrY3wwkQoQJy1H/mI=
X-Google-Smtp-Source: ABdhPJwM1+JuZB9rSr1rirpvolucUwkLEBoAlB+bg2XPKz+2xnErFQmFO9S4nWo247kzn5uzqeWx4w==
X-Received: by 2002:a17:90a:dc13:: with SMTP id i19mr16449580pjv.194.1619085668112;
        Thu, 22 Apr 2021 03:01:08 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id r3sm1741314pfl.159.2021.04.22.03.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 03:01:07 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/4] git-completion.bash: use $__git_cmd_idx in more places
Date:   Thu, 22 Apr 2021 03:00:51 -0700
Message-Id: <70fda62db198ad4a25702861565a47ee8f1dd62e.1619085387.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.1.499.g90b4fd31cd
In-Reply-To: <cover.1619085387.git.liu.denton@gmail.com>
References: <cover.1618910364.git.liu.denton@gmail.com> <cover.1619085387.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the introduction of the $__git_cmd_idx variable in e94fb44042
(git-completion.bash: pass $__git_subcommand_idx from __git_main(),
2021-03-24), completion functions were able to know the index at which
the git command is listed, allowing them to skip options that are given
to the underlying git itself, not the corresponding command (e.g.
`-C asdf` in `git -C asdf branch`).

While most of the changes here are self-explanatory, some bear further
explanation.

For the __git_find_on_cmdline() and __git_find_last_on_cmdline() pair of
functions, these functions are only ever called in the context of a git
command completion function. These functions will only care about words
after the command so we can safely ignore the words before this.

For _git_worktree(), this change is technically a no-op (once the
__git_find_last_on_cmdline change is also applied). It was in poor style
to have hard-coded on the index right after `worktree`. In case
`git worktree` were to ever learn to accept options, the current
situation would be inflexible.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/completion/git-completion.bash | 26 ++++++++++++++------------
 t/t9902-completion.sh                  | 19 +++++++++++++++++++
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c29c129f87..30c9a97616 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1006,8 +1006,8 @@ __git_complete_revlist ()
 
 __git_complete_remote_or_refspec ()
 {
-	local cur_="$cur" cmd="${words[1]}"
-	local i c=2 remote="" pfx="" lhs=1 no_complete_refspec=0
+	local cur_="$cur" cmd="${words[__git_cmd_idx]}"
+	local i c=$((__git_cmd_idx+1)) remote="" pfx="" lhs=1 no_complete_refspec=0
 	if [ "$cmd" = "remote" ]; then
 		((c++))
 	fi
@@ -1176,7 +1176,7 @@ __git_aliased_command ()
 # --show-idx: Optionally show the index of the found word in the $words array.
 __git_find_on_cmdline ()
 {
-	local word c=1 show_idx
+	local word c="$__git_cmd_idx" show_idx
 
 	while test $# -gt 1; do
 		case "$1" in
@@ -1221,7 +1221,7 @@ __git_find_last_on_cmdline ()
 	done
 	local wordlist="$1"
 
-	while [ $c -gt 1 ]; do
+	while [ $c -gt "$__git_cmd_idx" ]; do
 		((c--))
 		for word in $wordlist; do
 			if [ "$word" = "${words[c]}" ]; then
@@ -1306,7 +1306,7 @@ __git_count_arguments ()
 	local word i c=0
 
 	# Skip "git" (first argument)
-	for ((i=1; i < ${#words[@]}; i++)); do
+	for ((i="$__git_cmd_idx"; i < ${#words[@]}; i++)); do
 		word="${words[i]}"
 
 		case "$word" in
@@ -1442,7 +1442,7 @@ __git_ref_fieldlist="refname objecttype objectsize objectname upstream push HEAD
 
 _git_branch ()
 {
-	local i c=1 only_local_ref="n" has_r="n"
+	local i c="$__git_cmd_idx" only_local_ref="n" has_r="n"
 
 	while [ $c -lt $cword ]; do
 		i="${words[c]}"
@@ -2474,7 +2474,7 @@ _git_switch ()
 __git_config_get_set_variables ()
 {
 	local prevword word config_file= c=$cword
-	while [ $c -gt 1 ]; do
+	while [ $c -gt "$__git_cmd_idx" ]; do
 		word="${words[c]}"
 		case "$word" in
 		--system|--global|--local|--file=*)
@@ -3224,7 +3224,7 @@ _git_svn ()
 
 _git_tag ()
 {
-	local i c=1 f=0
+	local i c="$__git_cmd_idx" f=0
 	while [ $c -lt $cword ]; do
 		i="${words[c]}"
 		case "$i" in
@@ -3276,9 +3276,11 @@ __git_complete_worktree_paths ()
 _git_worktree ()
 {
 	local subcommands="add list lock move prune remove unlock"
-	local subcommand
+	local subcommand subcommand_idx
 
-	subcommand="$(__git_find_on_cmdline "$subcommands")"
+	subcommand="$(__git_find_on_cmdline --show-idx "$subcommands")"
+	subcommand_idx="${subcommand% *}"
+	subcommand="${subcommand#* }"
 
 	case "$subcommand,$cur" in
 	,*)
@@ -3303,7 +3305,7 @@ _git_worktree ()
 			# be either the 'add' subcommand, the unstuck
 			# argument of an option (e.g. branch for -b|-B), or
 			# the path for the new worktree.
-			if [ $cword -eq $((__git_cmd_idx+2)) ]; then
+			if [ $cword -eq $((subcommand_idx+1)) ]; then
 				# Right after the 'add' subcommand: have to
 				# complete the path, so fall back to Bash
 				# filename completion.
@@ -3327,7 +3329,7 @@ _git_worktree ()
 		__git_complete_worktree_paths
 		;;
 	move,*)
-		if [ $cword -eq $((__git_cmd_idx+2)) ]; then
+		if [ $cword -eq $((subcommand_idx+1)) ]; then
 			# The first parameter must be an existing working
 			# tree to be moved.
 			__git_complete_worktree_paths
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 04ce884ef5..9439fec8f0 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1879,6 +1879,7 @@ test_expect_success '__git_find_on_cmdline - single match' '
 	(
 		words=(git command --opt list) &&
 		cword=${#words[@]} &&
+		__git_cmd_idx=1 &&
 		__git_find_on_cmdline "add list remove" >actual
 	) &&
 	test_cmp expect actual
@@ -1889,6 +1890,7 @@ test_expect_success '__git_find_on_cmdline - multiple matches' '
 	(
 		words=(git command -o --opt remove list add) &&
 		cword=${#words[@]} &&
+		__git_cmd_idx=1 &&
 		__git_find_on_cmdline "add list remove" >actual
 	) &&
 	test_cmp expect actual
@@ -1898,6 +1900,7 @@ test_expect_success '__git_find_on_cmdline - no match' '
 	(
 		words=(git command --opt branch) &&
 		cword=${#words[@]} &&
+		__git_cmd_idx=1 &&
 		__git_find_on_cmdline "add list remove" >actual
 	) &&
 	test_must_be_empty actual
@@ -1908,6 +1911,7 @@ test_expect_success '__git_find_on_cmdline - single match with index' '
 	(
 		words=(git command --opt list) &&
 		cword=${#words[@]} &&
+		__git_cmd_idx=1 &&
 		__git_find_on_cmdline --show-idx "add list remove" >actual
 	) &&
 	test_cmp expect actual
@@ -1918,6 +1922,7 @@ test_expect_success '__git_find_on_cmdline - multiple matches with index' '
 	(
 		words=(git command -o --opt remove list add) &&
 		cword=${#words[@]} &&
+		__git_cmd_idx=1 &&
 		__git_find_on_cmdline --show-idx "add list remove" >actual
 	) &&
 	test_cmp expect actual
@@ -1927,11 +1932,23 @@ test_expect_success '__git_find_on_cmdline - no match with index' '
 	(
 		words=(git command --opt branch) &&
 		cword=${#words[@]} &&
+		__git_cmd_idx=1 &&
 		__git_find_on_cmdline --show-idx "add list remove" >actual
 	) &&
 	test_must_be_empty actual
 '
 
+test_expect_success '__git_find_on_cmdline - ignores matches before command with index' '
+	echo "6 remove" >expect &&
+	(
+		words=(git -C remove command -o --opt remove list add) &&
+		cword=${#words[@]} &&
+		__git_cmd_idx=3 &&
+		__git_find_on_cmdline --show-idx "add list remove" >actual
+	) &&
+	test_cmp expect actual
+'
+
 test_expect_success '__git_get_config_variables' '
 	cat >expect <<-EOF &&
 	name-1
@@ -2275,6 +2292,7 @@ do
 		(
 			words=(git push '$flag' other ma) &&
 			cword=${#words[@]} cur=${words[cword-1]} &&
+			__git_cmd_idx=1 &&
 			__git_complete_remote_or_refspec &&
 			print_comp
 		) &&
@@ -2288,6 +2306,7 @@ do
 		(
 			words=(git push other '$flag' ma) &&
 			cword=${#words[@]} cur=${words[cword-1]} &&
+			__git_cmd_idx=1 &&
 			__git_complete_remote_or_refspec &&
 			print_comp
 		) &&
-- 
2.31.1.499.g90b4fd31cd

