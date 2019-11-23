Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96AFC432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 20:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18CE20672
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 20:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEnsogQ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfKWUur (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 15:50:47 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:41930 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfKWUur (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 15:50:47 -0500
Received: by mail-wr1-f49.google.com with SMTP id b18so12736446wrj.8
        for <git@vger.kernel.org>; Sat, 23 Nov 2019 12:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kIXFQcF2Cta2d/eFqE+hPZgfiH8zk0bQDUv2HPh35mc=;
        b=BEnsogQ0x6eMNKXOj2QL4efYSuy0UswsZJ+WtOoNIYSMXPPl+sRBrcnj0QF1COvdwg
         hM24RNSzt+my20/xb4EkeksZtupvMFQqR9EJxAmDjKT7xoZhUswLfrJEQBrgG9vs/eT5
         wi/VQb3ALXX5aUmBjue5MpIvo2pdXiTocRWzB7MYrANIhyABlxNT4zTZ3YcWA+MXDdI9
         Gutzr/pXuQF3IpY/VA8sJr8WgrLAfkFWf6lW+cpeTRYyBlaH+nvHsibpVKkCoAdgrdAR
         Y9kvn9G4JmyLHE9eRcoKc/ZJolD8Q5rACJzs8K+bO5XvMvw8KtIspvniFhdsbcxP1c0w
         u35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kIXFQcF2Cta2d/eFqE+hPZgfiH8zk0bQDUv2HPh35mc=;
        b=sHVrtb7H2LescfeGbavMeiBEP6k0czY9UHm4q8GI75vwA7qwaCt8kx9Wn1kTTfXqLo
         6AB5PVT96vICQhX5gedVE1URbh7biX0FF2ZM3Yf6oOj3+cNG/1qJ0OU7X4R39121Fmmc
         uk9YpwMrwuQGlEvSsW8f/AtejkMt9Bib64exgFGmZE1K4F+u0+pwlV5F+knHsR09XfnY
         aOiH2bHVrpHbxCg6qzTnSBs7XNJskvqI3GbAISvADtCPVNbjb+GCM90/uy+2MnIUdLz7
         AOhPDqk/zLaYKMRFwWknb8lMzuA2kxV8OBS1GoWsXZC1GTXbmFmZYr/NDqX8VCwkyEVx
         skZg==
X-Gm-Message-State: APjAAAUA3TNgrReel44ZkmKJu2U6SPodIO2sxEbuJaTD+PNCZla8L3qZ
        dXBuLOctjYhAQWZr/tuINGKwOUJn
X-Google-Smtp-Source: APXvYqxzQ8eBxqVCJx1d+fsaTVaHg/JwKJkZSqe0mCxP4Xn1uTxg/wPUfDpznn2uhTecOH0BHo4LpA==
X-Received: by 2002:adf:f9c4:: with SMTP id w4mr23309487wrr.88.1574542244973;
        Sat, 23 Nov 2019 12:50:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b15sm3279257wrx.77.2019.11.23.12.50.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Nov 2019 12:50:44 -0800 (PST)
Message-Id: <662e16dbc1246ac5737723134471f47e4f582fc1.1574542242.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.195.git.1574542242.gitgitgadget@gmail.com>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Nov 2019 20:50:35 +0000
Subject: [PATCH 1/8] t5520: do not use `pull.rebase=preserve`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Even if those tests try to override that setting, let's not use it
because it is deprecated: let's use `merges` instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5520-pull.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index cf4cc32fd0..41b799e336 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -509,7 +509,7 @@ test_expect_success '--rebase=false create a new merge commit' '
 
 test_expect_success '--rebase=true rebases and flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
-	test_config pull.rebase preserve &&
+	test_config pull.rebase merges &&
 	git pull --rebase=true . copy &&
 	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
 	test file3 = "$(git show HEAD:file3.t)"
@@ -529,9 +529,9 @@ test_expect_success '--rebase=invalid fails' '
 	! git pull --rebase=invalid . copy
 '
 
-test_expect_success '--rebase overrides pull.rebase=preserve and flattens keep-merge' '
+test_expect_success '--rebase overrides pull.rebase=merges and flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
-	test_config pull.rebase preserve &&
+	test_config pull.rebase merges &&
 	git pull --rebase . copy &&
 	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
 	test file3 = "$(git show HEAD:file3.t)"
-- 
gitgitgadget

