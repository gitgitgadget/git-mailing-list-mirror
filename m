Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FBDC43457
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 19:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAD11223FB
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 19:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmYzUECV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbgJSTb6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 15:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731238AbgJSTbz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 15:31:55 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430E8C0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 12:31:55 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j136so671527wmj.2
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 12:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WacbeA7HEoF6yYPhnvR0GMDR3Bko+fpf0Jw246MFhU0=;
        b=nmYzUECVLdypJQt9lxDfj7izua41LYf4vOA4DSeDT39+fh0czZLvBpSyvYR1u5V/H3
         DMwkNNDzpYhWF2pqXf78ejxb9sO33dQpBOSBZFjQaKHN+1A21l5wyxAcssvltBXHLrJR
         lXJBnI4ynSKYDq9/VQVQKjnd9iLPPPqJUFI782Q6xqVivpMoeNnc0kG6b0V/zte3UYm8
         fEflh/A93z9UGSjipyZOeqgTpCIUP/nH21aUQQ2Lyi80xmGbndaZ+s/m3SlGhHVibl88
         2dbl8+kK5k2SPXD44TexMX62EaMpanQ4Foq/5IvJhR77C6eU6eBzj8IjfuNezKz5KEab
         Nzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WacbeA7HEoF6yYPhnvR0GMDR3Bko+fpf0Jw246MFhU0=;
        b=jQ45Xbse0+dUq6bFRmjNcJCwINzuoiBCA3msVIBS7fH1Ln22pYwAhZeCSvsuo96Ub6
         Ev59jf+V52oaF+M2cQm42IYifenh6yPrqat8+gdYBViqQlfVcIA+KIXHWLHGOLutY9pZ
         09HjlYkdx1O6dEKU+/JGN5Q1Rfwzncern46IQasR/OlaYVJzcg+G4MOqhpuk4URKVWMh
         QoY6QPY89qqdr1bA9F3iTk0hln+kd8UIrcd9uZJ7wU75fVhYU5wwBwsUkOHN57kQ4DOY
         ccCtmXT6x/vMrQ6ot1L0Su8A4YXiAprkfdfgFrA9j5izAV5Zi8CRBcyvcTrUummMQD87
         o/DQ==
X-Gm-Message-State: AOAM5339f6zqiUaSQbziKtN0mUn3mEOdQapcrow5KkIKTGRuBLYI8fG+
        RuGOyA+VSgSPPnDH42MJa0ugFE+SC9s=
X-Google-Smtp-Source: ABdhPJybKnXgjn2kCmnaXy4+rr02rGLI4WA3VjjyNJoyMX6+HptcJ7suElfyNPDPF7DBg2v91jl8Lg==
X-Received: by 2002:a1c:9ed8:: with SMTP id h207mr744596wme.75.1603135913893;
        Mon, 19 Oct 2020 12:31:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a82sm665000wmc.44.2020.10.19.12.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:31:53 -0700 (PDT)
Message-Id: <1641d1950d01cc565ee54c9d642bd7079056b5c0.1603135903.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.758.git.1603135902.gitgitgadget@gmail.com>
References: <pull.758.git.1603135902.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Oct 2020 19:31:39 +0000
Subject: [PATCH 08/10] t9902: prepare a test for the upcoming default branch
 name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We need to adjust a test that uses a prefix of the default branch name,
to accommodate for `main` being used soon.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9902-completion.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 7b7bc6e4bd..0badcf829b 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1055,13 +1055,13 @@ test_expect_success 'teardown after filtering matching refs' '
 	git -C otherrepo branch -D matching/branch-in-other
 '
 
-test_expect_success '__git_refs - for-each-ref format specifiers in prefix' '
+test_expect_success PREPARE_FOR_MAIN_BRANCH '__git_refs - for-each-ref format specifiers in prefix' '
 	cat >expected <<-EOF &&
 	evil-%%-%42-%(refname)..master
 	EOF
 	(
-		cur="evil-%%-%42-%(refname)..mas" &&
-		__git_refs "" "" "evil-%%-%42-%(refname).." mas >"$actual"
+		cur="evil-%%-%42-%(refname)..mai" &&
+		__git_refs "" "" "evil-%%-%42-%(refname).." mai >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
-- 
gitgitgadget

