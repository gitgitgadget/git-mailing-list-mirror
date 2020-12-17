Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0979C0018C
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC607233F9
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731825AbgLQBIh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 20:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbgLQBIf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 20:08:35 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9455BC061282
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 17:07:17 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id a12so24883767wrv.8
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 17:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=e1aYPUeZjYhucSYPBW1QQtqRTPWqnRACjXwG2b865HA=;
        b=n/jyk4xWbkZb4eN9yCpKEu6LL/oztZZogMXVXKqUBQBhqKoRVNHj7VszN7vPmwtreX
         dTKygJ53UgINf0xG3TgTuogwlWWzESJiF1znUjYsxk8g5BjOE2eOqkfz69ejh9LR7Ru1
         Cz8mElSo/pez+byaC9zkOL0gWkvqQJoFvBVEklN4q4Or2m4UhHB5n3Qn3qU7VRRmhvd6
         pOwVryByZ8mplUReCsc7OO8GiAzvpx/onW3JpLKUzIEQtEu3VE05KYplZpRhiv03G8qe
         EM4GitOSrXvaXuBgO4T0etWgywjZXK246tEMqz9q+UY1GCy2xvnpc491l4z/beufvSBe
         Y+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=e1aYPUeZjYhucSYPBW1QQtqRTPWqnRACjXwG2b865HA=;
        b=NTVHR0rVh8RjAMMyEZSbSgS9I0uLZ3XAL+Yz7ThFVj2GndECXFx33MKpC3SHICyG4q
         adQnnwdHuMfNWdZx9X4alRqKj8aPx20AQ15IvpEGwOJuAR8RNn46jyPueaOcRFbrCNSR
         sZhealkc4LWDLD7Aq5Gd2E0REVqqxESXbc77YcnQEYjtM7EREpMUcRsmNKBojAfwpsHp
         LNjAREkTVCqgdP7shzdncOk+IpYPgHM7fQo5SYG06DzgjcjLKpu8emNBjJ7gJ3QV4EOx
         e7KfcHiNgP9mXWS6oo80LVXBBRcK4Iqb1BK7UqzxssOxCo9SpqyRNiX3vzbva8UFGdAG
         Fy5g==
X-Gm-Message-State: AOAM531aL92zmn0H2JH3Tzx6WD22vdxi2K+OPCI1rgtcX6QQZN/xkmzN
        3WgI1bt54n4Klnu/Urmtmi+9dLuwEtE=
X-Google-Smtp-Source: ABdhPJxQs3TVIHEAY4X7sAi+3uGeDTWtIkd6a5p1+i71dysr7daZ6Sz6EgPfrH7baa4JmBKHTjqc8w==
X-Received: by 2002:a5d:5401:: with SMTP id g1mr40454211wrv.93.1608167236250;
        Wed, 16 Dec 2020 17:07:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k1sm5791657wrn.46.2020.12.16.17.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 17:07:15 -0800 (PST)
Message-Id: <fa4063cf9feed180a8f4869680d13b51823306a2.1608167230.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.816.git.1608167230.gitgitgadget@gmail.com>
References: <pull.816.git.1608167230.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Dec 2020 01:07:04 +0000
Subject: [PATCH 05/11] t3205: finalize transitioning to using the branch name
 `main`
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

In 66713e84e71 (tests: prepare aligned mentions of the default branch
name, 2020-10-23), we started that transition, trying to prepare for a
time when `git init` would use that name for the initial branch.

Even if that time has not arrived, we can complete the transition by
making the test script independent of the default branch name. This also
allows us to drop the `PREPARE_FOR_MAIN_BRANCH` prereq from one test
case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3205-branch-color.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/t3205-branch-color.sh b/t/t3205-branch-color.sh
index 289625c4646..da1c202fa71 100755
--- a/t/t3205-branch-color.sh
+++ b/t/t3205-branch-color.sh
@@ -5,7 +5,8 @@ test_description='basic branch output coloring'
 
 test_expect_success 'set up some sample branches' '
 	test_commit foo &&
-	git update-ref refs/remotes/origin/master HEAD &&
+	git branch -M main &&
+	git update-ref refs/remotes/origin/main HEAD &&
 	git update-ref refs/heads/other HEAD
 '
 
@@ -19,16 +20,16 @@ test_expect_success 'set up some color config' '
 
 test_expect_success 'regular output shows colors' '
 	cat >expect <<-\EOF &&
-	* <CYAN>master<RESET>
+	* <CYAN>main<RESET>
 	  <BLUE>other<RESET>
-	  <YELLOW>remotes/origin/master<RESET>
+	  <YELLOW>remotes/origin/main<RESET>
 	EOF
 	git branch --color -a >actual.raw &&
 	test_decode_color <actual.raw >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'verbose output shows colors' '
+test_expect_success 'verbose output shows colors' '
 	oid=$(git rev-parse --short HEAD) &&
 	cat >expect <<-EOF &&
 	* <CYAN>main               <RESET> $oid foo
-- 
gitgitgadget

