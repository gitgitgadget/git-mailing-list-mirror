Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3B3C388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 14:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C016A20FC3
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 14:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPfQWpwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750252AbgJWOAU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 10:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750241AbgJWOAP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 10:00:15 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC590C0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 07:00:14 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id n18so1965813wrs.5
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 07:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZlzAgyGASMbYFnFR5+2+MvZ1EbifMmRSAJol5V2gPT4=;
        b=QPfQWpwAeMRJ7pvgPM2+7ZoxMokZVrS59eEs4nVHshsnK5cONFb6ixRPBcCRtrtPSP
         1mDBhNvAOU6YmxqBFZEveFUund+OoniWRNvWA0N4YyLZHpRLrDwJ4q7EOR0P1iD59pey
         tNBFKDKLmvgseZnsEcSX0T61tERRNaTaawOEljNBAQuqY4paGp4duvcZ+9HpKzoyyz6u
         LMSmQ1CyCXR+2IJDYtNhQBdGpYOMVPi3kFmbI4ayq6ll6QIJkkp6pgHtwbiPLwDt9a0v
         MFFiWDcRk0NO7W/c9+QSRfw/2TYXhGLEqXuC0wOtUVfTub/kA7EKe1RmRBqZ8TMSr/3p
         Ht1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZlzAgyGASMbYFnFR5+2+MvZ1EbifMmRSAJol5V2gPT4=;
        b=oOR73GK61+DFQm9Nm+loUPPUNhwCub7rm7oQPL1n4F6CPHA2SKXp86BGHHSolKkxW8
         +c6RueFkBtfDWF9uH8ytnVB0yxNd0nIPoJLERuLxmmkgbPO9iEcjIF0ksyyAbatgpImh
         A+Mpwt2oahG1P7bW/Hhw2RKGXlwSDAzjxeTAaPCjW4ZPJ9NxTC8gXYvpmxbOyTDspvyL
         8saEHk5m5/IMy9pZHiZxQzzeT+9xsJ1fR5P3OqQ2yisrRxnhz6O3uR8eBIfG57q1L2Yk
         kxwZDBJt1gY8EjbavgU+bPiEVI87VC4S5+1DReIZvyvp9beqxjp2zXJ5VGMDx1+g/Tw3
         mRcw==
X-Gm-Message-State: AOAM533q+GTgH0KywZTK3NPxEqQPE3l0jVgOMJxN3zwmDiWAu4qfs+mP
        il4ztHXkqWJyCLWzJvIZFJ1tFHzeVmE=
X-Google-Smtp-Source: ABdhPJwq3T/5JWZPddyPPRCBmDNlR73CEVwNkF2Bz1zxFg8yP9kUYtas7LJt3STWxJ3rTBgVLg1J8w==
X-Received: by 2002:a5d:4b49:: with SMTP id w9mr2909427wrs.41.1603461613449;
        Fri, 23 Oct 2020 07:00:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s11sm3343414wrm.56.2020.10.23.07.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 07:00:12 -0700 (PDT)
Message-Id: <959a770c2372ed68fdeb127bf794e0c158eefa81.1603461606.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.758.v2.git.1603461606.gitgitgadget@gmail.com>
References: <pull.758.git.1603135902.gitgitgadget@gmail.com>
        <pull.758.v2.git.1603461606.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Oct 2020 14:00:03 +0000
Subject: [PATCH v2 6/9] t3200: prepare for `main` being shorter than `master`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the test case adjusted by this patch, we want to cut just after the
longest shown ref name. Since `main` is shorter than `master`, we need
to decrease the number of characters. Since `topic` is shown, too, and
since that is only one character shorter than `master`, we decrement the
length by one instead of two.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3200-branch.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 6efe7a44bc..55b24b76ce 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -375,9 +375,9 @@ test_expect_success 'git branch --column -v should fail' '
 	test_must_fail git branch --column -v
 '
 
-test_expect_success 'git branch -v with column.ui ignored' '
+test_expect_success PREPARE_FOR_MAIN_BRANCH 'git branch -v with column.ui ignored' '
 	git config column.ui column &&
-	COLUMNS=80 git branch -v | cut -c -9 | sed "s/ *$//" >actual &&
+	COLUMNS=80 git branch -v | cut -c -8 | sed "s/ *$//" >actual &&
 	git config --unset column.ui &&
 	cat >expect <<\EOF &&
   a/b/c
-- 
gitgitgadget

