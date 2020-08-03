Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1687C433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A562922BF3
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+k21TWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgHCSl2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbgHCSlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 14:41:25 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB34C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 11:41:25 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id y3so35142264wrl.4
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 11:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CF4fAwlJ+8DIgBxeicBGpMmXwcNi7ioibGZ5lOkqXUA=;
        b=F+k21TWjZOoi9fMrXtQ9b1sP/RwhAS4qftKHIA/IAtLXZIDOOFzwjl9iI/ksWU8EZx
         Jezso4FSShWggvbafu1Ihwz8WimmlsnVSqV2/xKs7/LOz+8IbrXnK3ccNZ+9p7WK6Lk3
         JNCvzmDdei9c85p2EFcoqKjxpxc2oW1h+3A+jQl/Km1HlX512TyupoXBLmX6hcFpE1in
         fGM72YNrYGgtHSHm3QMJJ6P6EJSUzQfj2Bj5D0iqMubYrrVxybU5i2OZIP9Uu9lrZm/J
         YV6wbe2snz5x9kocicvhDyg8syq5zWNc7AvfZoBXFkcneJLzqpylscP2TeWrhI4ruxOm
         zmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CF4fAwlJ+8DIgBxeicBGpMmXwcNi7ioibGZ5lOkqXUA=;
        b=ABZAn0DhijLsqAjIuU3+8ylj7Njk5zAWUk3RFODnNG7MtBKFz9GJiBCXToEVrTRqC5
         c9Y5wIM72DR506/RcaMEN8m7EXSl0pjwMrbdwTI2GeLKRr3hLaAm5B7g8o9QyfIqonAT
         apOZwW6WQJVA2j0Hj80UzlJMOo1qSPdBqFbfGXCP7AZInW5gb8EHtZzsWB8xVmnSRTVM
         9Mf0KCMgH1dPfqLSb5YqQM3M46mJcrqb/szegj0hcIxWpv+sXY05xkLwVnhVCCfRYYLl
         1EbgB4WMpeRCgJSH9GaMePzxIPOBpyzRvRqvF9zkc7tuYdH4W3XLzQCYJh6Z+42v/eR+
         vejw==
X-Gm-Message-State: AOAM531N8DxiuEG1BJIlM15Yf+m3GOFZRS7sDzgjdxidI99SjobGQcyl
        sOkQPH+8w30hAmwDQDEufpkp9txG
X-Google-Smtp-Source: ABdhPJzPRLtIIEDbOZibVfAdBBHuNSQDXFWVGHmGiw+tmJw2WbOhlvDiOe5q4LPftc7ftPJgSLSrRg==
X-Received: by 2002:adf:ec10:: with SMTP id x16mr15597491wrn.74.1596480083591;
        Mon, 03 Aug 2020 11:41:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i82sm829236wmi.10.2020.08.03.11.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 11:41:23 -0700 (PDT)
Message-Id: <305fe534c5543cd71559ed2dca7e1657b0b8554c.1596480080.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.825.v2.git.git.1596480080.gitgitgadget@gmail.com>
References: <pull.825.git.git.1596349986.gitgitgadget@gmail.com>
        <pull.825.v2.git.git.1596480080.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 Aug 2020 18:41:18 +0000
Subject: [PATCH v2 2/4] t6038: remove problematic test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

t6038.11, 'cherry-pick patch from after text=auto' was a test of
undefined behavior.  To make matters worse, while there are a couple
possible correct answers, this test was coded to only check for an
obviously incorrect answer.  And the final cherry on top is that the
test is marked test_expect_failure, meaning it can't provide much value,
other than possibly confusing future folks who come along and try to
work on attributes and look at existing tests.  Because of all these
problems, just remove the test.

But for any future code spelunkers, here's my understanding of the two
possible correct answers:

This test was set up so that on a branch with no .gitattributes file,
you cherry-picked a patch from a branch that had a .gitattributes file
(containing '* text=auto').  Further, the two branches had a file which
differed only in line endings.  In this situation, correct behavior is
not well defined: should the .gitattributes file affect the merge or
not?

If the .gitattributes file on the other branch should not affect the
merge, then we would have a content conflict with all three stages
different (the merge base didn't match either side).

If the .gitattributes file from the other branch should affect the
merge, then we would expect the line endings to be normalized to LF for
the version to be recorded in the repository.  This would mean that when
doing a three-way content merge on the file that differed in line
endings, that the three-way content merge would see that the versions on
both sides matched and so the cherry-pick has no conflicts and can
succeed.  The line endings in the file as recorded in the repository
will change from CRLF to LF.  The version checked out in the working
copy will depend on the platform (since there's no eol attribute defined
for the file).

Also, as a final side note, this test expected an error message that was
built assuming cherry-pick was the old scripted version, because
cherry-pick no longer uses the error message that was encoded in this
test.  So it was wrong for yet another reason.

Given that the handling of .gitattributes is not well defined and this
test was obviously broken and could do nothing but confuse future
readers, just remove it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6038-merge-text-auto.sh | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
index 27cea15533..9337745793 100755
--- a/t/t6038-merge-text-auto.sh
+++ b/t/t6038-merge-text-auto.sh
@@ -188,20 +188,6 @@ test_expect_failure 'checkout -m addition of text=auto' '
 	git diff --no-index --ignore-cr-at-eol expected file
 '
 
-test_expect_failure 'cherry-pick patch from after text=auto was added' '
-	append_cr <<-\EOF >expected &&
-	first line
-	same line
-	EOF
-
-	git config merge.renormalize true &&
-	git rm -fr . &&
-	git reset --hard b &&
-	test_must_fail git cherry-pick a >err 2>&1 &&
-	grep "[Nn]othing added" err &&
-	compare_files expected file
-'
-
 test_expect_success 'Test delete/normalize conflict' '
 	git checkout -f side &&
 	git rm -fr . &&
-- 
gitgitgadget

