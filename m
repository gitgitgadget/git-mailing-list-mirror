Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD5BC43457
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 19:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EE8720EDD
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 19:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVxosDJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411031AbgJPT3B (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 15:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408086AbgJPT27 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 15:28:59 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A62C061755
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 12:28:59 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e17so4188711wru.12
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 12:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ow+/NiC5LPtUcWqbRrL35jbgCSi7RxYdbnk1PlDpvqU=;
        b=CVxosDJCVD2J7ojF/ty9eRgt0nNjSF72vIFP0EAnO4OmgPay9FGEWBIThyQ3gKx+9A
         /ToTn0g769R+AUhChNQBVX3P5/99ZxRvLKYuavbgMEAF8BipLo+Ho19XTMziXUjwCGji
         MEAvUUO9bG6h0jP+OZW2DhXvSggfGTgsOjdy56ZarEsvoyRMKR+iz3FKnNr7rYojiqNN
         BP8hesDbKfrGxzeaWQaLyC04Of9Pc6KsGA8yk7gvOzMlORJiSw39iu+n7ih3rvQf8ctv
         u4NjIW9dJo3sOrm8WK/l/yY0F9Pc6xUELHS7ev6v6+rWUVZtyIabQe/nzsZB5v+PIxSy
         E7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ow+/NiC5LPtUcWqbRrL35jbgCSi7RxYdbnk1PlDpvqU=;
        b=G0GpMYXlC3iopEkVX6iR14PV54N/X3A/r6W/zFKDM3o6NdUZgIkk6jq6Y1pE+yVUI4
         sjDuo8h4/g2YcEdeB4G6MXLG3ccs72unR6htopTX0dsQ1inyYQCx/y9V7PsdJCGSmNWg
         IQOs9EaRGBrywEWX85uJNWri1HwacBb3DjiL6tzV4BDa7tRVqzl9Kr/B75AOrJRIavmb
         0IHQ5bxQ76nlDdVSo+s96Kj0dbYqevuJRgbmx1tsxJNWIvC/PPaSDB6EQsS0BHXLaBGD
         ygcmTGMXn8uQsvAtXlAxvMwzDXdwBM0YJi1wq/ytGxZQJR0TVOtPrsMbXwCmyZ+BEmS5
         KiQw==
X-Gm-Message-State: AOAM533Ix0x+9cdGbu0AhsawiXSW/FTh80BSXamMeH22CwUyaFWGa9Lb
        Wk+Ec4hFURo5aesUO/vaIk7n3UeTqns=
X-Google-Smtp-Source: ABdhPJyoF9B3N7UmyuL0ZZe9+vtsShbgjwWDjsHqr+T9SHC0QTt/UlCLRhaRD1XLTjC7d9pmT4/G2g==
X-Received: by 2002:adf:fa01:: with SMTP id m1mr6051048wrr.220.1602876538255;
        Fri, 16 Oct 2020 12:28:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v9sm3650199wmh.23.2020.10.16.12.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 12:28:57 -0700 (PDT)
Message-Id: <0e1a1125f7ffc4d97e470474c2c3ee05a25efdeb.1602876532.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.v4.git.git.1602876532.gitgitgadget@gmail.com>
References: <pull.878.v3.git.git.1602710025.gitgitgadget@gmail.com>
        <pull.878.v4.git.git.1602876532.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Oct 2020 19:28:52 +0000
Subject: [PATCH v4 3/3] test-lib: reduce verbosity of skipped tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When using the --run flag to run just two or three tests from a test
file which contains several dozen tests, having every skipped test print
out dozens of lines of output for the test code for that skipped test
(in addition to the TAP output line) adds up to hundreds or thousands of
lines of irrelevant output that make it very hard to fish out the
relevant results you were looking for.  Simplify the output for skipped
tests to remove this extra output, leaving only the TAP output line
(i.e. the line reading "ok <number> # skip <test-description>", which
already mentions that the test was "skip"ped).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/test-lib.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index a040d54a76..3f8c404335 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1062,7 +1062,6 @@ test_skip () {
 				"      <skipped message=\"$message\" />"
 		fi
 
-		say_color skip >&3 "skipping test: $@"
 		say_color skip "ok $test_count # skip $1 ($skipped_reason)"
 		: true
 		;;
-- 
gitgitgadget
