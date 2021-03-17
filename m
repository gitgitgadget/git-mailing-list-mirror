Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589BBC4360C
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 269DE64F30
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbhCQV2e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 17:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbhCQV2P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 17:28:15 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B97C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:28:15 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x16so3313124wrn.4
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=X/O9ei5Y/8+fu/a0CsKzzM5LD1f+vsoxe0VE60ZU1dc=;
        b=Hs50xW88zNoEJDKG+utEpqSuW/yt5jhp+kCaeDg+TGwo7Ze4eTsEY6ZFsyzb7xLnf1
         pDb8IMkmKuZMzgMzZRI6WFBFl8NI5kRf5cdQxhj6+1slZnV0w9GsPTfXbrb38pl8NwPK
         GVg8QjHuFBWxrw7WJ9U/OWnbJGGdcXAQj+1yPC+ow7vSx4J1jMuYz3pjEZqKWyFVrCtl
         23uDjxvyaIaiFywY+Vx70OPKnODaA2B56Ovy5CBlF3cST2KUC6PVK4SK2naNk3pGtUBT
         fW2A5KnKl2zoafgLtFFWov81K3j+iVyEOHW/FR+MLYqIVuAOZm1AivAR7yzaTpk/m/S9
         fJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=X/O9ei5Y/8+fu/a0CsKzzM5LD1f+vsoxe0VE60ZU1dc=;
        b=c01cCwLZko0Z/zCVwvho+OvAjG4XjzLHV9sSIxz1UYyrli7+D2kNAGTZa7E3aCUXfZ
         psdxd17mpQrVzUux4VyOZxKDCcckp9dy0qxIqa0HpPENfW53M7kCp1iaR7aZSFghmtiI
         y/MaXARtl7rKE4EZpXR0xNnziV7ryvrMo1OrVbgMgirVoIscf1FsY2yIT+C6v0adgJMq
         x6d2Dp0cmOb+x1me9ufvlOBrI0j2ohMoo2U/gTR8m5lqLESQ3591cjIgs19AsSFGbaUk
         smzXY4+DGPsoB5+0bwDs0makHdeyJFoFc7tubz4q9pUo6nK2qtaG3wpdpXGmhXwGpbmB
         QhKA==
X-Gm-Message-State: AOAM533H4w3cE0oJHB8wwlQxRKDukH2I5gFnq+k9DTECnDYNo0XaKxxi
        xqfHa8LtxLo0yZBT8bD0yC1VFZJIAm0=
X-Google-Smtp-Source: ABdhPJzmGwFPWyw8qePfH4QdVXLenEeymJHyD8+z6AdilfO9XPFyzfSnnapM9q98isba94ALSQGXZA==
X-Received: by 2002:adf:ef4a:: with SMTP id c10mr6168366wrp.427.1616016493869;
        Wed, 17 Mar 2021 14:28:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6sm257578wrw.63.2021.03.17.14.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 14:28:13 -0700 (PDT)
Message-Id: <1c6361c9b88ac5f970054989bae0845ef3b6baee.1616016485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
References: <pull.905.git.1615867503.gitgitgadget@gmail.com>
        <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Mar 2021 21:28:04 +0000
Subject: [PATCH v2 12/13] t6423: mark remaining expected failure under
 merge-ort as such
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When we started on merge-ort, thousands of tests failed when run with
the GIT_TEST_MERGE_ALGORITHM=ort flag; with so many, it didn't make
sense to flip all their test expectations.  The ones in t6409, t6418,
and the submodule tests are being handled by an independent in-flight
topic ("Complete merge-ort implemenation...almost").  The ones in
t6423 were left out of the other series because other ongoing series
that this commit depends upon were addressing those.  Now that we only
have one remaining test failure in t6423, let's mark it as such.

This remaining test will be fixed by a future optimization series, but
since merge-recursive doesn't pass this test either, passing it is not
necessary for declaring merge-ort ready for general use.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6423-merge-rename-directories.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 4c568050dd27..4c3d0b95dc5c 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -4797,7 +4797,7 @@ test_setup_12f () {
 	)
 }
 
-test_expect_merge_algorithm failure success '12f: Trivial directory resolve, caching, all kinds of fun' '
+test_expect_merge_algorithm failure failure '12f: Trivial directory resolve, caching, all kinds of fun' '
 	test_setup_12f &&
 	(
 		cd 12f &&
-- 
gitgitgadget

