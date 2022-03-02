Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC2FC433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 12:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241939AbiCBMuZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 07:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241922AbiCBMuY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 07:50:24 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A738E1B6
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 04:49:40 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id m6so2601007wrr.10
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 04:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yxF2ctB/dW7tJ/PQKKAgWSEOtTqEBxa8IHyKVEWvxHo=;
        b=d3/g7zFcBYzNChWCDM61BFnwNud3rYSHtwZHlBnrY6THU3v3pc/OkL25GlACY23eOr
         AxiY0D3lZKYaxYACTPV0sU5R+GzMGCSQIR2SBkwjVImTaAqGPl+ySibiUQot8mbvDVZU
         vTBy1wkfqV3DdzVlzYDfpKxra+AC6GAo4zKw+lTOux7YRXBeM3QCTu/l2CjwDZg4GEbB
         TQ7I7R7AyNibtArLFUHlH5FZuDCBkrL2UGSx9FuvPO2P4bHssStgD6fBy6TxdEyowvDF
         AKIiJvtR7pqn1KANz4EnlPdjQNCw6Jixm4cZJsUYkgDdj0g41Yl//8uF6HD/rgSlR6Mw
         jm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yxF2ctB/dW7tJ/PQKKAgWSEOtTqEBxa8IHyKVEWvxHo=;
        b=8IdCl0AJXEgNkrJBVnxrg2e+45CZa1h6yRERL/MQ7lBTiMU9jviYJFlY0i7GUPukfw
         1pBjWSda2llGT5+E2B/n/hluNTCL+oyTl9rHS/T+a1zG/+hdrPGh5kz9iE3vP3FOBQQQ
         0cUrSfa9EalCBP6tq5kfGef5IIhP2SkpiAtcuO3Gxcpdo/qCd5hVZNU4cnkBiQT98s6V
         xBLyfLWF8bmUjZKblTypq0TQTl/iILpPRAvTIwkkoE6toSa/gQDjxl39W94pElDMiGoG
         H/xec5JIi6ywHuMDVRWkC9voKPSKn7eEsHIbk2nFIkhT5xsxiXeBvcXNmCjkb41UmQJu
         hruA==
X-Gm-Message-State: AOAM530sqQVOi8z7LFLH/t6Ez/tnTKjjC1f1pPkzNmeuoBDHtB6mXo+a
        MnnIb45SaDARu5C392bpq+QKqBkBRnD2zQ==
X-Google-Smtp-Source: ABdhPJzjdeKMLdV4J9gVfpggeNlBFaw2AhNdipE5dyHfLXR5bJeMfA2Z+B0AF8hlpKKhOL4tcRnZ8A==
X-Received: by 2002:a5d:61cb:0:b0:1f0:2598:88ff with SMTP id q11-20020a5d61cb000000b001f0259888ffmr2850933wrv.444.1646225378876;
        Wed, 02 Mar 2022 04:49:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p30-20020a1c545e000000b003811f9102c0sm8210107wmi.32.2022.03.02.04.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 04:49:37 -0800 (PST)
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
Subject: [PATCH v4 1/9] scalar Makefile: use "The default target of..." pattern
Date:   Wed,  2 Mar 2022 13:49:09 +0100
Message-Id: <patch-v4-1.9-26c6bb897cf-20220302T124320Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make have the "contrib/scalar/Makefile" be stylistically consistent
with the top-level "Makefile" in first declaring "all" to be the
default rule, follwed by including other Makefile snippets.

This adjusts code added in 0a43fb22026 (scalar: create a rudimentary
executable, 2021-12-03), it's a style-only change, in a subsequent
commit the "QUIET" boilerplate at the beginning of this file will be
retrieved via an include, and having an "all:" between the two set of
"include"'s after that change would look odd.

As noted in [1] using ".DEFAULT_GOAL = all" is another way to do this
in more modern GNU make versions, which we already have a hard
dependency on, but let's leave any such change for a future
improvement and go with using our established pattern consistently for
now.

1. https://lore.kernel.org/git/220226.861qzq7d2r.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/scalar/Makefile | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/contrib/scalar/Makefile b/contrib/scalar/Makefile
index 231b1ee1796..1e9b969f3df 100644
--- a/contrib/scalar/Makefile
+++ b/contrib/scalar/Makefile
@@ -1,3 +1,10 @@
+# The default target of this Makefile is...
+all::
+
+include ../../config.mak.uname
+-include ../../config.mak.autogen
+-include ../../config.mak
+
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
 QUIET_SUBDIR1  =
 
@@ -12,12 +19,6 @@ else
 endif
 endif
 
-all:
-
-include ../../config.mak.uname
--include ../../config.mak.autogen
--include ../../config.mak
-
 TARGETS = scalar$(X) scalar.o
 GITLIBS = ../../common-main.o ../../libgit.a ../../xdiff/lib.a
 
-- 
2.35.1.1228.g56895c6ee86

