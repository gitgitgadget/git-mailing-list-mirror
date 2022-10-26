Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AADBFA373E
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 14:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbiJZO47 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbiJZO4y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 10:56:54 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611DF105349
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:56:53 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso1726559wma.1
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Swt+MOs31FvqgWRyhn+9o3+Ad1nvEaqzb/Of8gQbUA4=;
        b=A4xKqRFz5DvNVpKXl031oGJo+K6fbTMk+Bh0Pr70J5yshMzBuRrqSqFd1flF5DBfqP
         21s299U1NGknjhb6/OSdS/a23Gk8OCFq21qqUeMSTowGp45o/F5GGWyHOnJYK4Y9PTkW
         cE2JflUFuHYBUVHwK2jlQZe7H4Rw6pdp4MZO6pKjfzUJ7bAyWKjWCjTXh8riw0Wl/ejn
         q139fw43/St5zzcPt2esbYkllhp9EBmAUMjDnmIPxefKBIbi4Y2ac+IB3H2Oi4+614Gi
         WAgcs8YXjtrqw4QHW+dqTWD5kT2EvBBjf+cgpbuhyiXgYYyNUb4ZhhzZzEWRGQHzQm/F
         Vv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Swt+MOs31FvqgWRyhn+9o3+Ad1nvEaqzb/Of8gQbUA4=;
        b=ZV9SHm4TkKGivIp36IssAnhBsuVW/OMTwc9tJu4u9i6JszJlhfWkG4W4inx8Ec6bvH
         UNmkKwSWfQq+8ZWI5vs04QdFoEmDeisIyRLHeHTIId1FHgixtO7z0wXOKBHyFXowN4/q
         swiekj1hiDK0xVhn0Z6B1ETAayaSOC+TA5KtDccxF1IIqc/uNVBxUs9nN8MsPzhWhUgN
         hODtNXQabFX5Y62ECUrc0Iiis2uK44Y9nbg0g4fd/OWzueJsCbQQI+ki1ieZ8CasZCgI
         6K/cSg+SQ6Gi5nZBQfFH1wZ70TtqK7FoMtZtKIQadRbPlmMMNFjAAUcdAXxXogHeZrrJ
         giMQ==
X-Gm-Message-State: ACrzQf0fXxSzNVPx761vbrO2NM0Goz7KGc4zmJNkMC+JZpDLzFN4xJPZ
        SxT4tbZrwn2Ty4qudzgHD1R7tZr5/RyTAg==
X-Google-Smtp-Source: AMsMyM7hkf3Mf/cW2SIE/ftQ/E+4nJcUu/0pkRWt1mBt7nen1FqjsTRZ/cNz2za2z1LPA7qu0GWJrg==
X-Received: by 2002:a05:600c:3d18:b0:3cf:4c1e:5812 with SMTP id bh24-20020a05600c3d1800b003cf4c1e5812mr2352918wmb.192.1666796211327;
        Wed, 26 Oct 2022 07:56:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i25-20020a1c5419000000b003c7084d072csm2180351wmb.28.2022.10.26.07.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 07:56:50 -0700 (PDT)
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
Subject: [PATCH v4 1/9] Makefile: always (re)set DC_SHA1 on fallback
Date:   Wed, 26 Oct 2022 16:56:39 +0200
Message-Id: <patch-v4-1.9-11e92d15616-20221026T145255Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix an edge case introduced in in e6b07da2780 (Makefile: make DC_SHA1
the default, 2017-03-17), when DC_SHA1 was made the default fallback
we started unconditionally adding to BASIC_CFLAGS and LIB_OBJS, so
we'd use the sha1collisiondetection by default.

But the "DC_SHA1" variable remained unset, so e.g.:

	make test DC_SHA1= T=t0013*.sh

Would skip the sha1collisiondetection tests, as we'd write
"DC_SHA1=''" to "GIT-BUILD-OPTIONS", but if we manually removed that
test prerequisite we'd pass the test (which we couldn't if we weren't
using sha1collisiondetection).

So let's have the fallback assignment use the 'override' directive
instead of the ":=" simply expanded variable introduced in
e6b07da2780. In this case we explicitly want to override the user's
choice.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 85f03c6aed1..744bd4344f4 100644
--- a/Makefile
+++ b/Makefile
@@ -1823,7 +1823,7 @@ ifdef APPLE_COMMON_CRYPTO
 	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
 	BASIC_CFLAGS += -DSHA1_APPLE
 else
-	DC_SHA1 := YesPlease
+	override DC_SHA1 = YesPlease
 	BASIC_CFLAGS += -DSHA1_DC
 	LIB_OBJS += sha1dc_git.o
 ifdef DC_SHA1_EXTERNAL
-- 
2.38.0.1251.g3eefdfb5e7a

