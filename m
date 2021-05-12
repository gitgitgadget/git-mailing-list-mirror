Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10593C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 08:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8981613C9
	for <git@archiver.kernel.org>; Wed, 12 May 2021 08:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhELIqX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 04:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhELIqU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 04:46:20 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17BEC061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 01:45:11 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q5so3290915wrs.4
        for <git@vger.kernel.org>; Wed, 12 May 2021 01:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uaxz/Ph376cOwdcyhQVUjYs6MUELYpvJZseTEzqx/cY=;
        b=KjSUs3X2umeiyLf/ojS0FIh9bFDKbyyMrH6sd3PVOfz6kkdb3U5L/mjsImc6g6mRXb
         FWWo26iESEOv6VnyGW02yu2JGA6NnKEUAa3WAIO9Wihlp9frS5CNlCydVnGv1HCcRqdj
         qcYdwU9wPd/m93xSokUR+K8+BBgG40nrmESBbj+R2z+q4jPR7mKfvMnDPEr1LDE+0f2C
         qumFuBZ+Ybgs9fUoBUgBE8e53d/jAEIq/hv0lp3JPX9PskKip7mfeG7U7VMt2/0sYZ7s
         SOpDT5kq1YPlqFJjXz2eupxyrC0IyAN+WsSnS1O5oJkw8vEIZiGy3S7mm6KX00h7IS9r
         1gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uaxz/Ph376cOwdcyhQVUjYs6MUELYpvJZseTEzqx/cY=;
        b=mOWOlhMy71sv+U8jzjSajkSefGclvsi9TrCaiRfjyXd+GB1h4iCMy9DziVIewa6okv
         gwNVV7R81o+SgQs2nD/IGDc9iaLwMzeOZeUb7SI4NC43dEoVvvC58JSC8iqTmO/hFTzm
         dP4PSMQZ34pbgmL0HWmUVlUvrVh5eWK6Ib3IdB2BvIfBNG1Pt6NR0n/1XRV8YGpreOC3
         8Dl/TNkJFkTTrNA9X8Q1kCFdQM8IqSbMX78sIXCZA8DW+anU6qzm8Gl+idCciLjmWvaC
         dZFrZTpr8GYH6ytF+lhsDjPYkJ2GRHm9mKKHy6vuddhBcue5Ue20hpCR2ribgMJr/F3J
         gZIg==
X-Gm-Message-State: AOAM532XRlk/Oyxn39dZY7KEm0Xh3lrs/WSjOSRrn0fZGH6uRL45lDp6
        o5NeAEo6vWyTbvEkKwJSEQ6NuQTR3MULZg==
X-Google-Smtp-Source: ABdhPJzqvrL2Mi+aV0P/sRRnSaCQL2jZLgQQVppLH/+UNk3cATwL6xOfLlRREBXeuTvE2Fh1xvJfBw==
X-Received: by 2002:a5d:5306:: with SMTP id e6mr6856373wrv.324.1620809110391;
        Wed, 12 May 2021 01:45:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p17sm30284051wru.1.2021.05.12.01.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 01:45:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Dave Huseby <dwh@linuxprogrammer.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] SubmittingPatches: remove pine-specific hints from MUA hints
Date:   Wed, 12 May 2021 10:45:02 +0200
Message-Id: <patch-3.3-9da5bc4a0c-20210512T084137Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.909.g789bb6d90e
In-Reply-To: <cover-0.3-0000000000-20210512T084137Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210512T084137Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the whole section about configuring pine with
no-strip-whitespace-before-send.

There hasn't been a release of Pine since late 2005, in Alpine the
no-strip-whitespace-before-send switch is already the default.

This documentation was initially added in 9740d289ee7 (Update
SubmittingPatches to add MUA specific notes., 2005-08-26), at this
point it's safe to say that it's not useful to anyone anymore, let's
remove it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/SubmittingPatches | 56 ---------------------------------
 1 file changed, 56 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 2aa217da9c..e616d20556 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -498,62 +498,6 @@ first patch.\n", if you really want to put in the patch e-mail,
 should come after the three-dash line that signals the end of the
 commit message.
 
-
-=== Pine
-
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
-
 === Thunderbird, KMail, GMail
 
 See the MUA-SPECIFIC HINTS section of linkgit:git-format-patch[1].
-- 
2.31.1.909.g789bb6d90e

