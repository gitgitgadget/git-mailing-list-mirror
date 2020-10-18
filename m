Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A3DC43457
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 00:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAB9B208E4
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 00:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpTLNB56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439994AbgJRAXy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 20:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439985AbgJRAXx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 20:23:53 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989AFC061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 17:23:52 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d81so6924240wmc.1
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 17:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CzrCPnbUvNSakWF2bvkdGZ4dwzkAgsYCMdLnhb7Mw8c=;
        b=JpTLNB56bUB4jBvK4wfi+1eUYk1v9TPXdBsvG22iLDTboG65sTmBFkXrgZkrvJYeXT
         jdEl084F4Ce0czmAOCxJP/LmCMllElFWBkTMTlTinLQVenOPNs8kga05260PTshfqas3
         KyaftN01DFQknQzsywbCPCl20qOkW5dceLymQa27XnBQTInG182F2ioZMONqmPVdi6zb
         mUV6K3z0Kppa/MzFoQMlUstCSMtzQU5shqUZZQ+f5qJPpU3ImgznVGQw/bEfAbcdNdoC
         bl2DRI1NoCBbytu0drzctnObJqBBNthCwarjKREw6K2Mm7I8TUMLMalpHIB9yocs9iLR
         AhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CzrCPnbUvNSakWF2bvkdGZ4dwzkAgsYCMdLnhb7Mw8c=;
        b=fAaj7cN+rLZDh+bytdGGo6IbGpqO1IocoVWsubEBliZVfeYbfnSRHbaK2v2BSTaX85
         6OPQvAbCF/WohP+mwhalhw61iDp5+4I8KaCA0ucGLC7RoBaQ4p2JSwi6c14hW1NEKhWI
         kOZMkasUIcyLEpg7nvitsQs7EE2Btvmkw5NW7dirbOXr2mdW8p8fBFbDVeFHtK668cYh
         Hl47yq78LGVm9rxcIr7AhKgj3L0PKtyEkXCvNNeh95qnU1R3fD3Ut1swtRVD23O4278z
         9iM/QgwaAtnul3mVMZdTjP87TJ9oCwpnpMwUB3F5B8gkvqKdne3NrKAqtqPzcplnVW2M
         mCGg==
X-Gm-Message-State: AOAM530auPQomVNqcVTIkCsMTgDKR/A6+bThcNTCvZS9j0yqzrtZ+huY
        JSVDk6tWchNatBwBNYW0yP0bwyaQhnQ=
X-Google-Smtp-Source: ABdhPJyGiBo0+4DfAYm+2LmAPH4c//QIwNo9LesmBrWDg5j8q2Cfkgt8ICJCfABUHuDBYoT9+cqXLg==
X-Received: by 2002:a1c:4c13:: with SMTP id z19mr10407337wmf.121.1602980631192;
        Sat, 17 Oct 2020 17:23:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i9sm9816242wma.47.2020.10.17.17.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 17:23:50 -0700 (PDT)
Message-Id: <3cc9abf461e54857aba87ce98b6c64d6b5e76c91.1602980628.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.v6.git.git.1602980628.gitgitgadget@gmail.com>
References: <pull.878.v5.git.git.1602888652.gitgitgadget@gmail.com>
        <pull.878.v6.git.git.1602980628.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 18 Oct 2020 00:23:46 +0000
Subject: [PATCH v6 2/3] t6006, t6012: adjust tests to use 'setup' instead of
 synonyms
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
        Andrei Rybak <rybak.a.v@gmail.com>,
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

