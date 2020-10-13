Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A00C43457
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 19:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE7B220BED
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 19:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1MQl8Yc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgJMTTx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 15:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgJMTTw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 15:19:52 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D24C0613D0
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 12:19:51 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x7so716909wrl.3
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 12:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CzrCPnbUvNSakWF2bvkdGZ4dwzkAgsYCMdLnhb7Mw8c=;
        b=s1MQl8Ych1cC/+P/Q1ZS70dxV0QWPf/KLmBllYbJoGF1Z0QRuPVK0gNVL3ZdxVsRmf
         nd89Hfjt8kge238V4EL5uOaaVlvNJS9gDZ/5cY9QFEPmml84k/jZc5tFXHYxuXgBhe31
         Le2U5POI40N7YDJVMpgbiPbnXg15GbnAY8pFmxkR146+Ln6IjnLPIiN8X1irEhh2LhEI
         3tSX6+WDuEvWuayGSXYftOPQsxaTGLPmrjV2Fto74kG/vaFoDd7h6H10lHhV3mNswqBp
         IWCOyE6LpBYLdTgaqZVx+DALQRtTBFknBUcAw/saG+WW6xuuFCU9vRvo52tciRyIkTrc
         /oDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CzrCPnbUvNSakWF2bvkdGZ4dwzkAgsYCMdLnhb7Mw8c=;
        b=RKGgX/QO+GYfdpCS6pssFpkVoCZDe6hYOuLxr2ZwmLG65qEiukrz2WJQE+d3/xgGlr
         L9QoClHkbSX5TUKRMefq67S95t2MHZU6EfC8R0IJ4Nut+BugPPyJ51Jd/9gGARNX/zZR
         uy34/wV15lbYeqXMIeceuxjVpXBWLduAfQ/hkW98t8n4Mvf3QaP5fw8E41x2lx6qXXJq
         EHF7QRlqGLSVEqVckvmZDjKbECrbDceCcb47KwSAwjwsQKbemb3urK014EzvfdW7twsA
         ZawRqaRN0Vxbzcdc51Z+ZpuFr9f7UIk/CYdMZvAn0x6V+jqdpuXC4S1lAdQT2F2RVUML
         fs3A==
X-Gm-Message-State: AOAM532C1gRsfJAcSTMVjsLslEZITTzfZ/72bDkDPT876J7T3iVfLClX
        Ab6dRR3v0b257tb2vIdmwhk0+sdVECY=
X-Google-Smtp-Source: ABdhPJy00aR+2uOCzjwkm7Fe2mz8f72Xk6QTytFjPJZfSO4Uz0YPH187NVv7N/YAKiS1hGqIwaJEvw==
X-Received: by 2002:adf:e70f:: with SMTP id c15mr1304263wrm.239.1602616790086;
        Tue, 13 Oct 2020 12:19:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r3sm680061wrm.51.2020.10.13.12.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 12:19:49 -0700 (PDT)
Message-Id: <8f1a4420f4eca64dece1cc40e20134001eb1dd74.1602616786.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
        <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Oct 2020 19:19:45 +0000
Subject: [PATCH v2 2/3] t6006, t6012: adjust tests to use 'setup' instead of
 synonyms
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

With the new ability to pass --run=setup to select which tests to run,
it is more convenient if tests use the term "setup" instead of synonyms
like 'prepare' or 'rebuild'.  There are undoubtedly many other tests in
our testsuite that could be changed over too, these are just a couple
that I ran into.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6006-rev-list-format.sh   | 2 +-
 t/t6012-rev-list-simplify.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index bc95da8a5f..99a1eaf332 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -339,7 +339,7 @@ commit $head1
 .. (hinzugef${added_utf8_part_iso88591}gt) foo
 EOF
 
-test_expect_success 'prepare expected messages (for test %b)' '
+test_expect_success 'setup expected messages (for test %b)' '
 	cat <<-EOF >expected.utf-8 &&
 	commit $head3
 	This commit message is much longer than the others,
diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
index b6fa43ace0..7254060240 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -168,7 +168,7 @@ test_expect_success '--full-diff is not affected by --parents' '
 #
 # This example is explained in Documentation/rev-list-options.txt
 
-test_expect_success 'rebuild repo' '
+test_expect_success 'setup rebuild repo' '
 	rm -rf .git * &&
 	git init &&
 	git switch -c main &&
-- 
gitgitgadget

