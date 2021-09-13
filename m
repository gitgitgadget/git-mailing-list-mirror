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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC99C433FE
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D9FB60249
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244296AbhIMPiQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 11:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243017AbhIMPiE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 11:38:04 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB9DC020E79
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 07:51:39 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t8so10110767wrq.4
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 07:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OYQ3u3y0aqBXRCQJhJY4sT0NBMqrrZoDEk1VGU9rFT8=;
        b=DmhBfJetC0lCJnwvtrV1eCX+4/er7MD/mkmmnNHKlu6aSYpFO/CzWn6tX0nMICirlB
         JkdnryRW4A+s9docQa6VGw3L+Tjb9fy7ImflOkFn5lwkzEodXDGiTponxnfyXNVaeZ8T
         ABGaegQ5p8CQbrr9tkKpAxrkm/1K979cmGrdH5qXPsPvitIuxspn3f7+x1p7f+7HTC87
         ikofCDdNEWhtRZ3yOTfjj4OcEQhBgIzuGOt+AIpncu1leX0OplGfgam4BSZ4ftkGyG5o
         x2TBatdKf7+8MxqTVbNe9aog/hxSITZAr8UCotCUk6vfN0jotqLHJebYMCnXRssiZ0Bs
         NrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OYQ3u3y0aqBXRCQJhJY4sT0NBMqrrZoDEk1VGU9rFT8=;
        b=pd+k0ymCOvYDldHVP7FsZXQjNVUKOuEC1Qt20NPxv7WwPNnTChW306ySDH2NPj5UuJ
         ruCmHW2N/EVKyqUy/BQJQdpwChoZLrXyHzjYpVt3z08/hWy7kmoMKc8P3VIiDNeeCpNT
         ftEmb5e/M2lr6CrMtreBe8CcexXIFe2YxjUJPxc9Dyh/zoALbWhiAZJWoXGKyz9CE8m0
         5HqZ4U49BFGuzsGXF6+i3/KCYXdcRKPyyXXIpMdzEG1pDLDQLJwLdZwU1aO7GK2I7g+1
         s6trgrk1kSdYLEC1gg3BJ9ZZA63MZh0GvGX2mit+bzojSFaFQwDkZ92/jC7ah8/D3zyH
         gjuQ==
X-Gm-Message-State: AOAM532HDKTbioWPUKzpmWRYWFAVOL8XYhyG4fsHEfQVenl/dqmCunVD
        80Clmh0+9033TBYQ+Rm1LDhtyN6E2Nvu6g==
X-Google-Smtp-Source: ABdhPJzrRDDAmIsJo2WwtU7SCKi76rCIvrkixRhRWGZQ3GikX8qPZPXOB754GKoFX/Ny4RYofaEixQ==
X-Received: by 2002:a5d:44c8:: with SMTP id z8mr12747336wrr.332.1631544697783;
        Mon, 13 Sep 2021 07:51:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o24sm3638854wmm.11.2021.09.13.07.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 07:51:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Daniel Stenberg <daniel@haxx.se>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 4/9] Makefile: drop support for curl < 7.9.8 (again)
Date:   Mon, 13 Sep 2021 16:51:24 +0200
Message-Id: <patch-v4-4.9-6edd01ad125-20210913T144846Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1013.ge8323766266
In-Reply-To: <cover-v4-0.9-00000000000-20210913T144846Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20210913T144846Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 1119a15b5c8 (http: drop support for curl < 7.11.1, 2021-07-30)
support for curl versions older than 7.11.1 was removed, and we
currently require at least version 7.19.4, see 644de29e220 (http: drop
support for curl < 7.19.4, 2021-07-30).

In those changes this Makefile-specific check added in
0890098780f (Decide whether to build http-push in the Makefile,
2005-11-18) was missed, now that we're never going to use such an
ancient curl version we don't need to check that we have at least
7.9.8 here. I have no idea what in http-push.c broke on versions older
than that.

This does not impact "NO_CURL" setups, as this is in the "else" branch
after that check.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 429c276058d..378f58b950d 100644
--- a/Makefile
+++ b/Makefile
@@ -1436,15 +1436,8 @@ else
 	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
 	PROGRAM_OBJS += http-fetch.o
 	PROGRAMS += $(REMOTE_CURL_NAMES)
-	curl_check := $(shell (echo 070908; $(CURL_CONFIG) --vernum | sed -e '/^70[BC]/s/^/0/') 2>/dev/null | sort -r | sed -ne 2p)
-	ifeq "$(curl_check)" "070908"
-		ifndef NO_EXPAT
-			PROGRAM_OBJS += http-push.o
-		else
-			EXCLUDED_PROGRAMS += git-http-push
-		endif
-	else
-		EXCLUDED_PROGRAMS += git-http-push
+	ifndef NO_EXPAT
+		PROGRAM_OBJS += http-push.o
 	endif
 	curl_check := $(shell (echo 072200; $(CURL_CONFIG) --vernum | sed -e '/^70[BC]/s/^/0/') 2>/dev/null | sort -r | sed -ne 2p)
 	ifeq "$(curl_check)" "072200"
-- 
2.33.0.1013.ge8323766266

