Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FE1C433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 12:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241949AbiCBMu2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 07:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241938AbiCBMuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 07:50:25 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41028E1A8
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 04:49:42 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t11so2621305wrm.5
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 04:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O3iX4FUEQsCU5uTXpr3FqvL4+abbvYDN7DuEsGmCqzw=;
        b=LA3H8DUZOFQ0o2R5J+F7N7APIH7zGHEMpQeNvQ9mGSne0htPf0bq8215R/7b/Zks6W
         Hp2Fb7eu9O07hp1I/H4NKsGi53ft0jPiPL0cls5FdHFQ3MGEhjRrhx9AEEUHV1bqTyXb
         BcnxnjXH8iS++a4DGkBlUKUhccNo2+OlVtW1RborHNQHs/z/9jtr/SJkEqlt5m0JaJT2
         tRG8RucwVkFooeydLWBoEez92F8kXymy8Q5jWRi9SUxorN2pSL3GuvdYNOeM9v68IXk2
         nTvh3Wfb3xVi1rMM7uTQtMvG1+dzHktpPZ7Jntkl9eK2YoaPPAiNgAvBzQwx6AGCXjUY
         uZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O3iX4FUEQsCU5uTXpr3FqvL4+abbvYDN7DuEsGmCqzw=;
        b=MdhjjCOfeiutzjUKNfV55wFzu82qVrGaYJ7kWhYsecUjTdxCbP2vE6TTnv45YkReXo
         ynmvHIPme4azF45IVqnytJJ5S//Y4o0xcUnN5tfh6c/re+ulFNXM5I/sXHXDGvHn+a7p
         YlVum/8/AE8dIyFRYJNpJa4Yz4pQpJP5aubxewT/6sCP7M4AEQbRNnxBBkd1XIQwo5XW
         0zt3w6R/HlU4XRQ1y5YHVX8RQONUVzU+5LaLpowmnd2qgMkp4rm4IeyJ0s3Z+QklG6vI
         Is092z1FMi2PuGYGrI8uqPife+cU2fwzKNQUloOwuhoO+GPcQ2TlbxVJAQ3OV00n7133
         RPEg==
X-Gm-Message-State: AOAM532bm4BI08DZ0uIHFY0PeFERGQHobK6tolfzcPpfDY7IdWDDEJ2m
        F4XF6mO/Iubx1kWL/AUvdfWLxRiJZQ9IDQ==
X-Google-Smtp-Source: ABdhPJwBeW8TNLNKG9ZRxJuna9IBV2moKwqFCL/JnAaEaRdl60+e6gzjYkMdBciAzsmrGtyq+N6aow==
X-Received: by 2002:a05:6000:c8:b0:1ef:7e4a:e3a1 with SMTP id q8-20020a05600000c800b001ef7e4ae3a1mr16439602wrx.452.1646225381056;
        Wed, 02 Mar 2022 04:49:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p30-20020a1c545e000000b003811f9102c0sm8210107wmi.32.2022.03.02.04.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 04:49:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/9] Makefile: disable GNU make built-in wildcard rules
Date:   Wed,  2 Mar 2022 13:49:11 +0100
Message-Id: <patch-v4-3.9-0fbdeeffc7b-20220302T124320Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Override built-in rules of GNU make that use a wildcard target. This
can speeds things up significantly as we don't need to stat() so many
files. GNU make does that by default to see if it can retrieve their
contents from RCS or SCCS. See [1] for an old mailing list discussion
about how to disable these.

The speed-up may vary. I've seen 1-10% depending on the speed of the
local disk, caches, -jN etc. Running:

    strace -f -c -S calls make -j1 NO_TCLTK=Y

Shows that we reduce the number of syscalls we make, mostly in "stat"
calls.

We could also invoke make with "-r" by setting "MAKEFLAGS = -r"
early. Doing so might make us a bit faster still. But doing so is a
much bigger hammer, since it will disable all built-in rules,
some (all?) of which can be seen with:

    make -f/dev/null -p | grep -v -e ^# -e ^$

We may have something that relies on them, so let's go for the more
isolated optimization here that gives us most or all of the wins.

1. https://lists.gnu.org/archive/html/help-make/2002-11/msg00063.html

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 shared.mak | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/shared.mak b/shared.mak
index 0170bb397ae..29f0e69ecb9 100644
--- a/shared.mak
+++ b/shared.mak
@@ -1,3 +1,14 @@
+### Remove GNU make implicit rules
+
+## This speeds things up since we don't need to look for and stat() a
+## "foo.c,v" every time a rule referring to "foo.c" is in play. See
+## "make -p -f/dev/null | grep ^%::'".
+%:: %,v
+%:: RCS/%,v
+%:: RCS/%
+%:: s.%
+%:: SCCS/s.%
+
 ### Flags affecting all rules
 
 # A GNU make extension since gmake 3.72 (released in late 1994) to
-- 
2.35.1.1228.g56895c6ee86

