Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D0912079C
	for <e@80x24.org>; Sat, 12 Nov 2016 02:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965201AbcKLCP5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 21:15:57 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35705 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935102AbcKLCP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 21:15:57 -0500
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Nov 2016 21:15:56 EST
Received: by mail-pg0-f68.google.com with SMTP id p66so3154881pga.2
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 18:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S5EYVzSvKcTy8sOJjxsqjPlD1wT2KA17fP4RdRfQdq4=;
        b=X9AvvCNocSwMpe860rfLWS7L1X5knfh4C50pP00j0H0gOkY2vbhCPzyqR9+oXAxK7t
         E59pMQIs0Czzvedxc2a8nNndpFs+g7c4VcPsJ5IbeegdnS9XIB/iIHw4gVi5kmTAGNu9
         JQl+DijcP667H+bNG6nRZSPxFGfSHEBFxv48188bSm2quNoox2L078gwqRTL2uqqXvRA
         y7k4ozhrSd3KdE+8HPXTNYQj2Aia+IxDOdTt9ybFw9FrehdppY+TfwHYQDhjvb5feTQC
         TAzEuU3VgPoT/w6uZVMwEXZmp3UiBeKnfRHD8gPwL8DT/BnNpo9bu5LAF8PWWywbN+Fq
         1kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S5EYVzSvKcTy8sOJjxsqjPlD1wT2KA17fP4RdRfQdq4=;
        b=asN+bYqg/3WAcAIwBXJcH6kiE+F2ynU+pTYqo+FwEiWXWqrcoh6Ei9OQ5sAgimaueF
         dMjkPpgJmziN6W6cqxS8YsUSZIJ4RjDC1I4IFB5a40czvXGy6bRWd0qv81JB7rOrg4/V
         NSHNVzl8g4/SfYqP7ZhD+oGCg7ZOg8sXYMRf/HqDP5xK6iDPzDXtN3zAfNWS/XksxgqI
         iQHzORcv99Umz7bUDDtmzATUgyd3OiUBZu3KDA7rXSpw90RYzlZ3UgTkVY5gUCOCrc4y
         DmqhXc4Un/ykOWmdo992LqRNrrU1haMiuGN46mvPDY4lTtUCMXhs3wg0dH5BlqTAWQR1
         Y8Qw==
X-Gm-Message-State: ABUngvdSBOWweOPNww4JvrpEHHstUepjR8baegCS7LXuFFYtud+aHjLb7D0KUHhouYnvEQ==
X-Received: by 10.99.173.3 with SMTP id g3mr9616163pgf.12.1478916049513;
        Fri, 11 Nov 2016 18:00:49 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id r194sm17863790pfr.94.2016.11.11.18.00.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Nov 2016 18:00:48 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 12 Nov 2016 09:00:44 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3] rebase: add --forget to cleanup rebase, leave everything else untouched
Date:   Sat, 12 Nov 2016 09:00:41 +0700
Message-Id: <20161112020041.2335-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161109091131.17933-1-pclouds@gmail.com>
References: <20161109091131.17933-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are occasions when you decide to abort an in-progress rebase and
move on to do something else but you forget to do "git rebase --abort"
first. Or the rebase has been in progress for so long you forgot about
it. By the time you realize that (e.g. by starting another rebase)
it's already too late to retrace your steps. The solution is normally

    rm -r .git/<some rebase dir>

and continue with your life. But there could be two different
directories for <some rebase dir> (and it obviously requires some
knowledge of how rebase works), and the ".git" part could be much
longer if you are not at top-dir, or in a linked worktree. And
"rm -r" is very dangerous to do in .git, a mistake in there could
destroy object database or other important data.

Provide "git rebase --forget" for this exact use case.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 v3 rewrote the desscription of --forget in git-rebase.txt to be more
 or less along the same line as --abort. What happens to the index and
 worktree is also stated to avoid misunderstanding.

 Documentation/git-rebase.txt           |  7 ++++++-
 contrib/completion/git-completion.bash |  4 ++--
 git-rebase.sh                          |  6 +++++-
 t/t3407-rebase-abort.sh                | 24 ++++++++++++++++++++++++
 4 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index de222c8..1e16c70 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 	[<upstream> [<branch>]]
 'git rebase' [-i | --interactive] [options] [--exec <cmd>] [--onto <newbase>]
 	--root [<branch>]
-'git rebase' --continue | --skip | --abort | --edit-todo
+'git rebase' --continue | --skip | --abort | --forget | --edit-todo
 
 DESCRIPTION
 -----------
@@ -252,6 +252,11 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 	will be reset to where it was when the rebase operation was
 	started.
 
+--forget::
+	Abort the rebase operation but HEAD is not reset back to the
+	original branch. The index and working tree are also left
+	unchanged as a result.
+
 --keep-empty::
 	Keep the commits that do not change anything from its
 	parents in the result.
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 21016bf..3143cb0 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1734,10 +1734,10 @@ _git_rebase ()
 {
 	local dir="$(__gitdir)"
 	if [ -f "$dir"/rebase-merge/interactive ]; then
-		__gitcomp "--continue --skip --abort --edit-todo"
+		__gitcomp "--continue --skip --abort --forget --edit-todo"
 		return
 	elif [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; then
-		__gitcomp "--continue --skip --abort"
+		__gitcomp "--continue --skip --abort --forget"
 		return
 	fi
 	__git_complete_strategy && return
diff --git a/git-rebase.sh b/git-rebase.sh
index 04f6e44..de712b7 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -43,6 +43,7 @@ continue!          continue
 abort!             abort and check out the original branch
 skip!              skip current patch and continue
 edit-todo!         edit the todo list during an interactive rebase
+forget!            abort but keep HEAD where it is
 "
 . git-sh-setup
 set_reflog_action rebase
@@ -241,7 +242,7 @@ do
 	--verify)
 		ok_to_skip_pre_rebase=
 		;;
-	--continue|--skip|--abort|--edit-todo)
+	--continue|--skip|--abort|--forget|--edit-todo)
 		test $total_argc -eq 2 || usage
 		action=${1##--}
 		;;
@@ -399,6 +400,9 @@ abort)
 	finish_rebase
 	exit
 	;;
+forget)
+	exec rm -rf "$state_dir"
+	;;
 edit-todo)
 	run_specific_rebase
 	;;
diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index a6a6c40..6bc5e71 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -99,4 +99,28 @@ testrebase() {
 testrebase "" .git/rebase-apply
 testrebase " --merge" .git/rebase-merge
 
+test_expect_success 'rebase --forget' '
+	cd "$work_dir" &&
+	# Clean up the state from the previous one
+	git reset --hard pre-rebase &&
+	test_must_fail git rebase master &&
+	test_path_is_dir .git/rebase-apply &&
+	head_before=$(git rev-parse HEAD) &&
+	git rebase --forget &&
+	test $(git rev-parse HEAD) = $head_before &&
+	test ! -d .git/rebase-apply
+'
+
+test_expect_success 'rebase --merge --forget' '
+	cd "$work_dir" &&
+	# Clean up the state from the previous one
+	git reset --hard pre-rebase &&
+	test_must_fail git rebase --merge master &&
+	test_path_is_dir .git/rebase-merge &&
+	head_before=$(git rev-parse HEAD) &&
+	git rebase --forget &&
+	test $(git rev-parse HEAD) = $head_before &&
+	test ! -d .git/rebase-merge
+'
+
 test_done
-- 
2.8.2.524.g6ff3d78

