Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FE8D1FAFE
	for <e@80x24.org>; Fri,  3 Feb 2017 02:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752327AbdBCCty (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:49:54 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36424 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752310AbdBCCts (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:49:48 -0500
Received: by mail-wm0-f67.google.com with SMTP id r18so1169442wmd.3
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0czGgJLCFiiT+VQFIR5EUNoS/heM2ayn+IDfu1S4Ee0=;
        b=RYJ8yO6EtxeKKKayAEfEfDqRdhH+yh+dtLJ7rNvBFiK4p9djV+ukSqN06unQBQF/X4
         HYGgUiwd+qnFoesmntj7vHZFdVc7zHMR4PcPTf8VSCoYljUY25eG2yOXnDfr7sPsBA3a
         zdaoJOVZqs9A8ndTtoM0i/OpzDON2OmeRrhGi1XoCjIDBUw8hrBUiDP1qlDfZkWvGM9N
         9cKx4k2Wv5K3IlJ+D3vqlGTQDN4oj8a86HDL4INaCRADAOmiezRWfDJeyzIYzEh4jpu9
         bmYv9NWs08kAPtLdO5/yZvuCkhwz9IsD35cq4A+c7lDWK8uh2A85zRg+p61JYNviiEnZ
         3jUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0czGgJLCFiiT+VQFIR5EUNoS/heM2ayn+IDfu1S4Ee0=;
        b=YegGy1WtK+Qd58MEL9OFPVC+qI519xVVz/FXEDq4YiJVDdNeB6JwwXy3h//JBeDpr+
         lenpvLWVRSNdqq6j0AoSyjqee/5BuGVdNvwj6XrZ3JhXlBBa0xTkQNMxK9BGPcMzNfB9
         EIu7QJKq6CSKvG8RPTTssm2zrNUBItpmhPkiRKESOXZ8g6IdCvVyoYySLVedQPGgEB4V
         OBQBV2D4mYRekPHo8ph96hiaqbU9BonHRPVgh1qta3SpVbdikui9ohD6EiNSjEuu59N/
         MAkLlr7rXE/U3AwzSNo4+gwDHHSw17dLMevfIaABO3mA3QK0w6PIZiHUjOWUbhZurk2/
         SyfA==
X-Gm-Message-State: AIkVDXIs1Mo0/MCQ8P+UPpG8KmZJxPI8/Qgia9HrTK5bo9rAQEBIhIZL9CJpVZkTqAI3SA==
X-Received: by 10.223.135.146 with SMTP id b18mr9849414wrb.189.1486090171879;
        Thu, 02 Feb 2017 18:49:31 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id k43sm42867464wrc.46.2017.02.02.18.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:49:31 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 20/21] completion: extract repository discovery from __gitdir()
Date:   Fri,  3 Feb 2017 03:48:28 +0100
Message-Id: <20170203024829.8071-21-szeder.dev@gmail.com>
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

To prepare for caching the path to the repository in the following
commit, extract the repository discovering part of __gitdir() into the
__git_find_repo_path() helper function, which stores the found path in
the $__git_repo_path variable instead of printing it.  Make __gitdir()
a wrapper around this new function.  Declare $__git_repo_path local in
the toplevel completion functions __git_main() and __gitk_main() to
ensure that it never leaks into the environment and influences
subsequent completions (though this isn't necessary right now, as
__gitdir() is still only executed in subshells, but will matter for
the following commit).

Adjust tests checking __gitdir() or any other completion function
calling __gitdir() to perform those checks in a subshell to prevent
$__git_repo_path from leaking into the test environment.  Otherwise
leave the tests unchanged to demonstrate that this change doesn't
alter __gitdir()'s behavior.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 42 +++++++++++++++++++++-------------
 t/t9902-completion.sh                  | 22 +++++++++++++-----
 2 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1c7493ff2..7775411cd 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -34,26 +34,35 @@ case "$COMP_WORDBREAKS" in
 *)   COMP_WORDBREAKS="$COMP_WORDBREAKS:"
 esac
 
+# Discovers the path to the git repository taking any '--git-dir=<path>' and
+# '-C <path>' options into account and stores it in the $__git_repo_path
+# variable.
+__git_find_repo_path ()
+{
+	if [ -n "${__git_C_args-}" ]; then
+		__git_repo_path="$(git "${__git_C_args[@]}" \
+			${__git_dir:+--git-dir="$__git_dir"} \
+			rev-parse --absolute-git-dir 2>/dev/null)"
+	elif [ -n "${__git_dir-}" ]; then
+		test -d "$__git_dir" &&
+		__git_repo_path="$__git_dir"
+	elif [ -n "${GIT_DIR-}" ]; then
+		test -d "${GIT_DIR-}" &&
+		__git_repo_path="$GIT_DIR"
+	elif [ -d .git ]; then
+		__git_repo_path=.git
+	else
+		__git_repo_path="$(git rev-parse --git-dir 2>/dev/null)"
+	fi
+}
+
 # __gitdir accepts 0 or 1 arguments (i.e., location)
 # returns location of .git repo
 __gitdir ()
 {
 	if [ -z "${1-}" ]; then
-		if [ -n "${__git_C_args-}" ]; then
-			git "${__git_C_args[@]}" \
-				${__git_dir:+--git-dir="$__git_dir"} \
-				rev-parse --absolute-git-dir 2>/dev/null
-		elif [ -n "${__git_dir-}" ]; then
-			test -d "$__git_dir" || return 1
-			echo "$__git_dir"
-		elif [ -n "${GIT_DIR-}" ]; then
-			test -d "${GIT_DIR-}" || return 1
-			echo "$GIT_DIR"
-		elif [ -d .git ]; then
-			echo .git
-		else
-			git rev-parse --git-dir 2>/dev/null
-		fi
+		__git_find_repo_path || return 1
+		echo "$__git_repo_path"
 	elif [ -d "$1/.git" ]; then
 		echo "$1/.git"
 	else
@@ -2783,7 +2792,7 @@ _git_worktree ()
 
 __git_main ()
 {
-	local i c=1 command __git_dir
+	local i c=1 command __git_dir __git_repo_path
 	local __git_C_args C_args_count=0
 
 	while [ $c -lt $cword ]; do
@@ -2855,6 +2864,7 @@ __gitk_main ()
 {
 	__git_has_doubledash && return
 
+	local __git_repo_path
 	local g="$(__gitdir)"
 	local merge=""
 	if [ -f "$g/MERGE_HEAD" ]; then
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 984df05b2..1816ed2e0 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -147,19 +147,25 @@ test_expect_success '__gitdir - from command line (through $__git_dir)' '
 
 test_expect_success '__gitdir - repo as argument' '
 	echo "otherrepo/.git" >expected &&
-	__gitdir "otherrepo" >"$actual" &&
+	(
+		__gitdir "otherrepo" >"$actual"
+	) &&
 	test_cmp expected "$actual"
 '
 
 test_expect_success '__gitdir - remote as argument' '
 	echo "remote" >expected &&
-	__gitdir "remote" >"$actual" &&
+	(
+		__gitdir "remote" >"$actual"
+	) &&
 	test_cmp expected "$actual"
 '
 
 test_expect_success '__gitdir - .git directory in cwd' '
 	echo ".git" >expected &&
-	__gitdir >"$actual" &&
+	(
+		__gitdir >"$actual"
+	) &&
 	test_cmp expected "$actual"
 '
 
@@ -450,7 +456,9 @@ test_expect_success '__git_remotes - list remotes from $GIT_DIR/remotes and from
 	git remote add remote_in_config_1 git://remote_1 &&
 	test_when_finished "git remote remove remote_in_config_2" &&
 	git remote add remote_in_config_2 git://remote_2 &&
-	__git_remotes >actual &&
+	(
+		__git_remotes >actual
+	) &&
 	test_cmp expect actual
 '
 
@@ -459,8 +467,10 @@ test_expect_success '__git_is_configured_remote' '
 	git remote add remote_1 git://remote_1 &&
 	test_when_finished "git remote remove remote_2" &&
 	git remote add remote_2 git://remote_2 &&
-	verbose __git_is_configured_remote remote_2 &&
-	test_must_fail __git_is_configured_remote non-existent
+	(
+		verbose __git_is_configured_remote remote_2 &&
+		test_must_fail __git_is_configured_remote non-existent
+	)
 '
 
 test_expect_success 'setup for ref completion' '
-- 
2.11.0.555.g967c1bcb3

