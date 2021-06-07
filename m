Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29120C4743F
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 11:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F16F61159
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 11:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhFGLGm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 07:06:42 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:40803 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhFGLGk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 07:06:40 -0400
Received: by mail-wm1-f52.google.com with SMTP id b145-20020a1c80970000b029019c8c824054so12373130wmd.5
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 04:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KClYEXae5N7hD2b7hUdZp+Lm6O3jRxtifDTVjWsH9Vs=;
        b=e1LFBF2LX1481bDPb/gBfU23pPWofhSt0bEh2CgDONJGjioTKVc5b8SPufHuQAAvc9
         AsOAVLlClfQ3BTg0BLDfr8OzDvvKKYsa9R2l+OTAcTcsmGU8KayUCaXk4KmAAfYd8tyQ
         WGacx6sHs12TXG8+0kE9QMQF4Hk6fpGTR/oWLG5BTdi6/owNDkOIl38fa3+g/gKpCpBu
         jYYU9E/1EfQsPVsQjDddZU7PVmhA9v+clolLp7CSuXEKidIFNKaOK46WcQieWNzxbPZr
         a4VOvQfmSi1NVVe5G1bNohGDzBvNF7+DEigr4AFq84eTMKt9hRqvkzrwYAasE6FmSDDl
         QJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KClYEXae5N7hD2b7hUdZp+Lm6O3jRxtifDTVjWsH9Vs=;
        b=tz3bq5gZMKez58sXall540GGP3AqFeCTTGou+GjsoBBNNV4PKi8m2i/GmC2OxlvAww
         geDrTO5lCk/InDZyyq3hZZ9xk/8Vr3oxb3bgwzDI8hV8wkq5M/+fnBQXc3BdLQ3t0at/
         WDkfj96bCRANlDeya6vNtR+R6TGeWk1NKH8iCNZGElMIdJqxnCU1kGl1f+ebsBnK3B87
         Kc+DTqgdKqloLB5lWwdWUD/j6TZN3Vm1ItVwKciXlDDCDap9mQnLuHQF2cx6d/oUfUHX
         FGGIJ/QUl1+xwBv0K+Iz1HXKQKV4fkr5X0OYuGVHpWPW85ndxcgbfb6M10/BTNIDcSaI
         RJfw==
X-Gm-Message-State: AOAM532YsU1yl6ZmoCvFKh/gjsgO1ELq83M8ceK+eg8t7jq31SUtFfjc
        mBRqmK1ravJrIU48pplCg8VLOARbS1pwAw==
X-Google-Smtp-Source: ABdhPJycW/TNyCQyOBVGJy0VYjyATXz6tzaEmSP3QXQsVcjdsi8DSouAWB/QZndHWJasmDNzwKIQAA==
X-Received: by 2002:a7b:c2e8:: with SMTP id e8mr11632901wmk.41.1623063828706;
        Mon, 07 Jun 2021 04:03:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c64sm17230575wma.15.2021.06.07.04.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 04:03:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Dave Huseby <dwh@linuxprogrammer.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/3] SubmittingPatches: remove pine-specific hints from MUA hints
Date:   Mon,  7 Jun 2021 13:03:43 +0200
Message-Id: <patch-3.3-a61885a198-20210607T110044Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-0.3-0000000000-20210607T110044Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210512T084137Z-avarab@gmail.com> <cover-0.3-0000000000-20210607T110044Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the whole section about configuring pine with
no-strip-whitespace-before-send with a note that users should use
another MUA instead.

There hasn't been a release of Pine since late 2005, in Alpine the
no-strip-whitespace-before-send switch is already the default.

This documentation was initially added in 9740d289ee7 (Update
SubmittingPatches to add MUA specific notes., 2005-08-26). At this
point it's safe to say that it's not useful to anyone anymore, let's
remove it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/SubmittingPatches | 54 ++-------------------------------
 1 file changed, 2 insertions(+), 52 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index e372d17673..9c859dcfef 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -501,58 +501,8 @@ commit message.
 
 === Pine
 
-(Johannes Schindelin)
-
-....
-I don't know how many people still use pine, but for those poor
-souls it may be good to mention that the quell-flowed-text is
-needed for recent versions.
-
-... the "no-strip-whitespace-before-send" option, too. AFAIK it
-was introduced in 4.60.
-....
-
-(Linus Torvalds)
-
-....
-And 4.58 needs at least this.
-
-diff-tree 8326dd8350be64ac7fc805f6563a1d61ad10d32c (from e886a61f76edf5410573e92e38ce22974f9c40f1)
-Author: Linus Torvalds <torvalds@g5.osdl.org>
-Date:   Mon Aug 15 17:23:51 2005 -0700
-
-    Fix pine whitespace-corruption bug
-
-    There's no excuse for unconditionally removing whitespace from
-    the pico buffers on close.
-
-diff --git a/pico/pico.c b/pico/pico.c
---- a/pico/pico.c
-+++ b/pico/pico.c
-@@ -219,7 +219,9 @@ PICO *pm;
-	    switch(pico_all_done){	/* prepare for/handle final events */
-	      case COMP_EXIT :		/* already confirmed */
-		packheader();
-+#if 0
-		stripwhitespace();
-+#endif
-		c |= COMP_EXIT;
-		break;
-....
-
-(Daniel Barkalow)
-
-....
-> A patch to SubmittingPatches, MUA specific help section for
-> users of Pine 4.63 would be very much appreciated.
-
-Ah, it looks like a recent version changed the default behavior to do the
-right thing, and inverted the sense of the configuration option. (Either
-that or Gentoo did it.) So you need to set the
-"no-strip-whitespace-before-send" option, unless the option you have is
-"strip-whitespace-before-send", in which case you should avoid checking
-it.
-....
+Abandoned by its uptsream and has known flowed text bugs, use its
+successor alpine or another MUA instead.
 
 === Thunderbird, KMail, GMail
 
-- 
2.32.0.rc3.434.gd8aed1f08a7

