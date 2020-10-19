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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D18BC43467
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 19:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1145F223EA
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 19:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Og5lDO98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbgJSTb6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 15:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731223AbgJSTb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 15:31:57 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF34CC0613D0
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 12:31:56 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t9so970788wrq.11
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 12:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+G9Ybvk3PdGH/bvSc2WcFyK357mlVRLtv839GOt1vvE=;
        b=Og5lDO98ev/sMASUJEL0oSAtYzz1SNhUv5R2kOIV7ZmMPXFckIkt26STzyLUAa79QX
         Rv38jbeOfufLsQMg4U5pFrtgPRWrOZV5T+ak47/VFCLEZcHiQlLnfDR1e3OqpQKH/b3C
         hF+WEU0F3MVhcMAc/pCdY5iZRho1aJwJZ/WK7maMk+jx8Q/tOJONVehi213uVt7Lq8vR
         cCCw+ErfXrwC1MJNc3cG547mZUz07HjoBcEec/GjmHKzCuU9bFNoOdKxpIjhNCjt8Bqh
         6cM23Cx3NELW3K+0ijUrEccanaW6XXF7CRS8Ef+h5g1F29NB3zCtObSNWsYrGH2TvVop
         7ORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+G9Ybvk3PdGH/bvSc2WcFyK357mlVRLtv839GOt1vvE=;
        b=Oj3S8XhQTso/1COOoQkDvTphu0cgjjndCLL0aN6nVJNSBbfUvEpiX1cqw6J/vCnDjk
         9JUruTBWH900rglEHK/zNbeHG1YcKLl+XimKEHsoWLd+y35d5410uZ1defMziGnEky5o
         UNqdW5Q72dDP3vUTN+fJIanFzB7ZyzjBZyBxwNQ52g5ReZBVZAW506RFIqlnjYZhnWAk
         3GOp7DaCCBFaNI9Uq71WvN2McvGfOVB3PBRxmwZdbB4dREVhqdF5tsNkXQ0pj85nJC/J
         8vtPjuqQpY6k9cqG8p2MRxJfODB6ENecmFbYSGJ3SjEMMAVZHUuOFCXZyALtUtpRMn3s
         BS5g==
X-Gm-Message-State: AOAM533Vt+2DeqLgwJ/jB0Bfli3tWihlxEZavX+rUVmEhM1nsDqov4YQ
        t3hJZ10idYydELFbHWtNF1wgyBbsCgY=
X-Google-Smtp-Source: ABdhPJyyxGBVw/KCtkcjK7Iu1uEH/aHbdAJz9l9gLGqAh5KE0unTVKDLXo/GI6yeS8E28d9GwWVNYQ==
X-Received: by 2002:a5d:4c4f:: with SMTP id n15mr805640wrt.137.1603135915374;
        Mon, 19 Oct 2020 12:31:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e5sm832307wrw.93.2020.10.19.12.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:31:55 -0700 (PDT)
Message-Id: <66365bce55d6d64d1a67851955a302fcc899d12c.1603135903.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.758.git.1603135902.gitgitgadget@gmail.com>
References: <pull.758.git.1603135902.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Oct 2020 19:31:41 +0000
Subject: [PATCH 10/10] t1400: prepare for `main` being default branch name
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

In addition to the trivial search-and-replace, there are three
non-trivial adjustments necessary.

Mark the respective test cases with the transitional prereq and make
those non-trivial adjustments early, to make this change easier to
review.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1400-update-ref.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 770e7be363..4c01e08551 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -585,10 +585,10 @@ test_expect_success 'stdin fails on unbalanced quotes' '
 	grep "fatal: badly quoted argument: \\\"master" err
 '
 
-test_expect_success 'stdin fails on invalid escape' '
-	echo "create $a \"ma\zter\"" >stdin &&
+test_expect_success PREPARE_FOR_MAIN_BRANCH 'stdin fails on invalid escape' '
+	echo "create $a \"ma\zn\"" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: badly quoted argument: \\\"ma\\\\zter\\\"" err
+	grep "fatal: badly quoted argument: \\\"ma\\\\zn\\\"" err
 '
 
 test_expect_success 'stdin fails on junk after quoted argument' '
@@ -704,9 +704,9 @@ test_expect_success 'stdin succeeds with quoted argument' '
 	test_cmp expect actual
 '
 
-test_expect_success 'stdin succeeds with escaped character' '
+test_expect_success PREPARE_FOR_MAIN_BRANCH 'stdin succeeds with escaped character' '
 	git update-ref -d $a &&
-	echo "create $a \"ma\\163ter\"" >stdin &&
+	echo "create $a \"ma\\151n\"" >stdin &&
 	git update-ref --stdin <stdin &&
 	git rev-parse $m >expect &&
 	git rev-parse $a >actual &&
-- 
gitgitgadget
