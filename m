Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C617C71153
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643BD20718
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uIfg+xac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgBOVhJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Feb 2020 16:37:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32930 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgBOVg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Feb 2020 16:36:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id u6so15184227wrt.0
        for <git@vger.kernel.org>; Sat, 15 Feb 2020 13:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4t0VPzSVYXvPuRAW0ZaeZTwxYoTXZVffuGhwliznBmI=;
        b=uIfg+xacZO+oTG0tgLsORAk4vaCm4giccupS4abB3WmADfsphuFKkkeR2ZFygi2v+o
         cLd1ub0f8rEdiAjvAPgEUoOkWG4z16eGYvIT+jDVxS3Hqyci3O0EncqUU/zotesWSMvS
         T6OPB0gsfnxP5YghBZtLU/mzB5FmkejqkTNs1yxoLFY3M1mGke2kYMk6muPERlhcNYpn
         pmbV9fCw1ZfpszNcCP36a1H/puiP5qiBcHweCGK2A7j1GNZIqDz0gzVHdgViIQaPOKJZ
         FTCw+JJEA6brPKB71VAKZCR4lLM2melDtXzDahQPklzvhGFZnyvfaHVw1vLNZ8mkV/Uv
         8k7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4t0VPzSVYXvPuRAW0ZaeZTwxYoTXZVffuGhwliznBmI=;
        b=k9dg0BvFw13UMDutDsSFo0n70nobiKhUiusru9ku06wyF9xy5rDnnPbkNEhK5JSxbM
         /Bi3Y3m5f+E7JU5nfTMd1BxXYL5gpqjdMvm6dzjdIww0TZ+hqQQrOdsRPsE19bv4pPdJ
         cWj6urqty1ZP1SE9lZ53nYkVX17t4hARAekn3qEewJFUYe7xJzdYsuRtvMe/YzVH/npX
         74s0WzMidpEJ1xOIuZw5/byuDS+c9+o5PPfIBV9FPMU/DyoMlAZy8J3+ptdp97p6Oh9Y
         6WqEiRE4mf8sDpOiFGFZCNoWO7lDmUFoBvIYTS+/I92Z7wy6p5rLj1zjV7DlG8rqQqDS
         pZ3g==
X-Gm-Message-State: APjAAAWHdt9FfJyvvrxgFh2ikaUXXee7cfZJ/Y9gEaw6tFc/7Gs38b/m
        BPKz72cFstzM+SRVUkYiIu5+m6Tu
X-Google-Smtp-Source: APXvYqxAF6gNywMCUu8wgf1qFe7TIwWpWhfdEoN9b4zTRSU+WcBJtr8BaP0wwC1kauowRrNRBIz/AQ==
X-Received: by 2002:adf:dd4d:: with SMTP id u13mr12424682wrm.394.1581802613670;
        Sat, 15 Feb 2020 13:36:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y185sm13852895wmg.2.2020.02.15.13.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 13:36:53 -0800 (PST)
Message-Id: <e4c04d3cf8b0c6a459bf192bfb34aca9733870c5.1581802602.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
        <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Feb 2020 21:36:35 +0000
Subject: [PATCH v5 14/20] git-prompt: change the prompt for interactive-based
 rebases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In the past, we had different prompts for different types of rebases:
   REBASE: for am-based rebases
   REBASE-m: for merge-based rebases
   REBASE-i: for interactive-based rebases

It's not clear why this distinction was necessary or helpful; when the
prompt was added in commit e75201963f67 ("Improve bash prompt to detect
various states like an unfinished merge", 2007-09-30), it simply added
these three different types.  Perhaps there was a useful purpose back
then, but there have been some changes:

  * The merge backend was deleted after being implemented on top of the
    interactive backend, causing the prompt for merge-based rebases to
    change from REBASE-m to REBASE-i.
  * The interactive backend is used for multiple different types of
    non-interactive rebases, so the "-i" part of the prompt doesn't
    really mean what it used to.
  * Rebase backends have gained more abilities and have a great deal of
    overlap, sometimes making it hard to distinguish them.
  * Behavioral differences between the backends have also been ironed
    out.
  * We want to change the default backend from am to interactive, which
    means people would get "REBASE-i" by default if we didn't change
    the prompt, and only if they specified --am or --whitespace or -C
    would they get the "REBASE" prompt.
  * In the future, we plan to have "--whitespace", "-C", and even "--am"
    run the interactive backend once it can handle everything the
    am-backend can.

For all these reasons, make the prompt for any type of rebase just be
"REBASE".

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 contrib/completion/git-prompt.sh | 6 +-----
 t/t9903-bash-prompt.sh           | 8 ++++----
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 1d510cd47be..014cd7c3cfc 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -429,11 +429,7 @@ __git_ps1 ()
 		__git_eread "$g/rebase-merge/head-name" b
 		__git_eread "$g/rebase-merge/msgnum" step
 		__git_eread "$g/rebase-merge/end" total
-		if [ -f "$g/rebase-merge/interactive" ]; then
-			r="|REBASE-i"
-		else
-			r="|REBASE-m"
-		fi
+		r="|REBASE"
 	else
 		if [ -d "$g/rebase-apply" ]; then
 			__git_eread "$g/rebase-apply/next" step
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 88bc733ad69..7ca35d358d6 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -163,7 +163,7 @@ test_expect_success 'prompt - inside bare repository' '
 '
 
 test_expect_success 'prompt - interactive rebase' '
-	printf " (b1|REBASE-i 2/3)" >expected &&
+	printf " (b1|REBASE 2/3)" >expected &&
 	write_script fake_editor.sh <<-\EOF &&
 		echo "exec echo" >"$1"
 		echo "edit $(git log -1 --format="%h")" >>"$1"
@@ -180,7 +180,7 @@ test_expect_success 'prompt - interactive rebase' '
 '
 
 test_expect_success 'prompt - rebase merge' '
-	printf " (b2|REBASE-i 1/3)" >expected &&
+	printf " (b2|REBASE 1/3)" >expected &&
 	git checkout b2 &&
 	test_when_finished "git checkout master" &&
 	test_must_fail git rebase --merge b1 b2 &&
@@ -189,11 +189,11 @@ test_expect_success 'prompt - rebase merge' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - rebase' '
+test_expect_success 'prompt - rebase am' '
 	printf " (b2|REBASE 1/3)" >expected &&
 	git checkout b2 &&
 	test_when_finished "git checkout master" &&
-	test_must_fail git rebase b1 b2 &&
+	test_must_fail git rebase --am b1 b2 &&
 	test_when_finished "git rebase --abort" &&
 	__git_ps1 >"$actual" &&
 	test_cmp expected "$actual"
-- 
gitgitgadget

