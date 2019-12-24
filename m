Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D97AC2D0C3
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57259206D3
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJYLicRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfLXTzO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 14:55:14 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42504 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfLXTzL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 14:55:11 -0500
Received: by mail-ed1-f67.google.com with SMTP id e10so18671631edv.9
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 11:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GIfeYd8rHefjwmUR6xdd2aWhIeIwROqlPqBkSmCLbuI=;
        b=gJYLicRewnR931Ih1pryEdxVfOqPekSj1cUyNmnOqhaDV3K4kz7AE6EF/bcXFIH1mN
         pxHYVF6sqyshAiPfADr/ZSkjjVp8x1gLID3h38VCRYyEu0DFw9HJ36o1IPc4omoXzZvR
         rdBTTUFTLwAVbKkyvD7Mcl8XLuGV1qV8NJXZp+fZNOjn5TMbvXUBNS2vX9eLMM9aPJFI
         uHSPt8WF3E+RA/AFh8dnLrEeZWMYyeYHgkYF4uLx3AUUSJCxNxMqwyrPU01jrgDCa/VJ
         o3gzjDeMF3fZFMwz1kmprMwaN3b4J7SK28F1jDWYxmh/SkUSmn5MIrfIDi7vw+p0/VNs
         dmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GIfeYd8rHefjwmUR6xdd2aWhIeIwROqlPqBkSmCLbuI=;
        b=QUVPaedZZTY6fM3NUG0dID2W/REZlA9InopelhuQueilW0Dw8rB+riU5mVt1Gn6cdm
         KSHPWcRc278wjoINxEGv00yJ6hExFm1xCQG1zfui8Pexoc6CSS3Sq0yZluI4B6WlX/oR
         eMIi7YaH8ngJ2apHFxqp/r4G5mNTWIdhgZRcdZWcnsIlF23hTXAQv87hq1TDhskd8mEj
         Epkqg9WkYKSXlCL4jOgReXx+gR9N69B6PMCtTyrAXIeGrdB1SgUDSY1QAbhyBj/c3zlk
         rStDFjFc8sesc3BVnIyH60+VjWRLD3yFEnkx5w6j8BtNInlPqqkTOTgpkprD5fQ9IvzY
         6P2A==
X-Gm-Message-State: APjAAAXguqr0cf730FndkzmRmDvGXTWDvIhVjzvbYVJFCnykuYrgT4ZR
        p+KowwmmEuQWy80sU8PTPsah+XII
X-Google-Smtp-Source: APXvYqz5BzIYXh3njmwk/BOnM83e4vvjfJOvFUoAYjSsUi5cxgLPXF39CN+TBKidUC+WxVtSjmxXRQ==
X-Received: by 2002:a17:906:1fc2:: with SMTP id e2mr39681478ejt.26.1577217309781;
        Tue, 24 Dec 2019 11:55:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w5sm2803281eje.14.2019.12.24.11.55.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Dec 2019 11:55:09 -0800 (PST)
Message-Id: <ff43593211fe913bfab4890ec3c7a60c4c4015cb.1577217299.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
        <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Dec 2019 19:54:55 +0000
Subject: [PATCH v3 11/15] git-prompt: change the prompt for interactive-based
 rebases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
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
index 1d510cd47b..014cd7c3cf 100644
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
index 88bc733ad6..7ca35d358d 100755
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

