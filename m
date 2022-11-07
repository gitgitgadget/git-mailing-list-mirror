Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F43C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 21:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbiKGVXc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 16:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbiKGVXW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 16:23:22 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF883AE4D
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 13:23:20 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id a5so19607384edb.11
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 13:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfYDONUCt6F2NVMIJZ5pckxWEUBHo6CgnIRDORJyycQ=;
        b=XT1p88P6f5qZbegDmk6m1CFun+WV/nihD7JjR8um0SMP4pFi3VgqkQPxHo+ahay7DN
         ISooWfwDP9m0agZUD6wgRD/Gx7cAorBWdk/W3O7zdKBKzdKTKktRZd9SuXGOtwz24j/M
         uVMz9rmkBcL+5Tnkx9fIu/n59Vv5ESVCxZuJiMWoVFc7kdsKzuOEClZuH2KGi+VcI8+c
         jt5XBGcA2XXDkzC/qky+IenkV6o6FqE9f61sDGqaVEJIgTGfabetoUGniAipqDJPO6OU
         ukTZUo1TQJxWg8b6B2q+ph0bCtXHR0UNVy1IbLCfCuC3TPjnJHJDLV1hXNTDCRedq7u7
         t1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfYDONUCt6F2NVMIJZ5pckxWEUBHo6CgnIRDORJyycQ=;
        b=L8uCBKJL3wA36J0yjNKRzixrgTBqsI69JaLwISzNOcUitDFzz7udPgWPSvQ2gPl3Cx
         Y8GWdGsTzUiQrALjkvOzFbDJaGsJcViKOv0T4M9DmpEhxpqfG+EwvnoKaUCuybYBZO0a
         S6gY5haI4ntHS63bXRJwKO4DA6lNw8CpDssaiZzt2vn5yjrXK4eZawqoO5x6wToTzTJ8
         0gleJFz2brfqor6q/QBhspgwtT1mR5OL/xyz2nmoZ9gNb3f934jd3m5jc2q1LglksFag
         lf6Aaph58jixiTSpwbkv7DmR5gAvh37qxsIrxbIFxrYvdAdvbkdIesrnJyUXmhQcP1uj
         FNng==
X-Gm-Message-State: ANoB5pmRJgcMfR2V8j2KUUDvXK6OzJ28Sxeo61WKg+w+eAgzh2L3HQJ1
        o7ht0GG/P6Av01xBmh7WtHIis/fe3FKQrg==
X-Google-Smtp-Source: AA0mqf5fI2nsD0iwsJeI55hUijYusnPPUBQo1HdM0Tq6WhwGO2iaLmMjKF42b0H9JUK36JJ1juQwJA==
X-Received: by 2002:aa7:d1d3:0:b0:466:539:4654 with SMTP id g19-20020aa7d1d3000000b0046605394654mr15891053edp.309.1667856198673;
        Mon, 07 Nov 2022 13:23:18 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id gg3-20020a170906e28300b0077d6f628e14sm3834418ejb.83.2022.11.07.13.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:23:17 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Eric DeCosta <edecosta@mathworks.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 03/10] Makefile: correct DC_SHA1 documentation
Date:   Mon,  7 Nov 2022 22:23:05 +0100
Message-Id: <patch-v5-03.10-d05fbf8c6d8-20221107T211736Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1464.gea6794aacbc
In-Reply-To: <cover-v5-00.10-00000000000-20221107T211736Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com> <cover-v5-00.10-00000000000-20221107T211736Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The claim that DC_SHA1 takes priority over other *_SHA1 knobs was true
when it was added in [1], But that hasn't been the case since it was
made the fallback default in [2].

We should be making it not only the default, but something that takes
priority over other *_SHA1 knobs, but that's outside the scope of this
change. For now let's correct the documentation to match reality.

Let's also remove the "unconditionally enable" wording, per the above
the enabling of "DC_SHA1" is conditional on these other flags.

The "Define DC_SHA1" here is also a lie, actually it's "we don't care
if you define DC_SHA1, just don't define anything else", but that's a
more general issue that'll be addressed in a subsequent commit. Let's
first stop pretending that this setting (which we actually don't even
use) takes priority over anything else.

1. 8325e43b82d (Makefile: add DC_SHA1 knob, 2017-03-16)
2. e6b07da2780 (Makefile: make DC_SHA1 the default, 2017-03-17)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 0ad9a6c5bc1..489327ecd9b 100644
--- a/Makefile
+++ b/Makefile
@@ -155,9 +155,8 @@ include shared.mak
 # Define BLK_SHA1 environment variable to make use of the bundled
 # optimized C SHA1 routine.
 #
-# Define DC_SHA1 to unconditionally enable the collision-detecting sha1
+# Define DC_SHA1 to enable the collision-detecting sha1
 # algorithm. This is slower, but may detect attempted collision attacks.
-# Takes priority over other *_SHA1 knobs.
 #
 # Define DC_SHA1_EXTERNAL in addition to DC_SHA1 if you want to build / link
 # git with the external SHA1 collision-detect library.
-- 
2.38.0.1464.gea6794aacbc

