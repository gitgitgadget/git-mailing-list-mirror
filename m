Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D01BC433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 12:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73ED86108E
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 12:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239004AbhJOMmC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 08:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238908AbhJOMlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 08:41:25 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8886C061764
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 05:39:18 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id o24-20020a05600c511800b0030d9da600aeso2288060wms.4
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 05:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=USV2T8yeQmmdybpyE+LdasDpxHgmsVaHAYePfWSNvRY=;
        b=mqG8OQlkIpjjx40qGLjqbVdMlWwW579/cKYSm6m/vcLkNANOMp7DBFyH+6ljxj5Jb+
         p3Q+AGluqGqs4gA2WwRAoBjedkstug0PSOBlMh/PH4tWQo67gb0x6kww/5WlZQgbECVL
         0PmGo1qoORtttumY5CD/s0id9IqcnzKR9PauW5VTGiqHEIEmAW+noJEqAAzuRZW7cn93
         l3bd0ONAOkXJYAM91fjH13qMCfEKtApeFpOgjYCb5y62KiqW3uk/FGyW11GliDj8p6cH
         d/CTji8y58YDGSCbgHzh6Xf8+9dG05tpXnjzUNjop4brDM0v2jTmZ28+ItKOLkylkTAx
         glaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=USV2T8yeQmmdybpyE+LdasDpxHgmsVaHAYePfWSNvRY=;
        b=wFI5KEQICdSaybeigIUlUipmC9jv27Ci9aCFjp6hH6yph/t2UrKlSlu6DI+/WsHVAF
         jJ9zkLFcdmOqiHp1HgEZeAH9Daf3943BFDplny3O1TX23dGIWkAbB8jAo3q5lpL5GyBw
         lPDvKfwnPCkDfeI18uPZC+NEWG2XO3glVZ62dKysU2RKEBpbSxC+5dGQFClMctYS9icS
         wT+W6/bM3PUMYx5pITD0tSTcf8LWYViO5QGuvmqKGPzUnaEplFQHDMgdGIOk1xUeMd+r
         QlnKrclpvRNVSB/Umujv2Ubl1X4lBHw4gKvEtejWot/vt34zg9ok1SydopJWOAZJxTh0
         5zfQ==
X-Gm-Message-State: AOAM531zfI8ZfSfSVHJ6PeITAjyvZMCwOfPa0adk1Ja69juYc2/dJmoR
        zikhjKAdk8yTpoY9lE6jalJD2If75x/z9Q==
X-Google-Smtp-Source: ABdhPJxWe/JF8k4H7KCLM7c6q4Sy0lFxQ0V/oxX3GakkED0EAnuG4h7im6y7NIZpH1EkUsn26F/qOg==
X-Received: by 2002:a05:600c:5128:: with SMTP id o40mr25904779wms.91.1634301557077;
        Fri, 15 Oct 2021 05:39:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d1sm5388824wrr.72.2021.10.15.05.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 05:39:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/4] doc lint: fix error-hiding regression
Date:   Fri, 15 Oct 2021 14:39:11 +0200
Message-Id: <patch-1.4-a6461f6e486-20211015T123619Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-0.4-00000000000-20211015T123619Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20211015T123619Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the broken "make lint-docs" (or "make check-docs" at the
top-level) target, which has been broken since my cafd9828e89 (doc
lint: lint and fix missing "GIT" end sections, 2021-04-09).

The CI for "seen" is emitting an error about a broken gitlink, but due
to there being 3x scripts chained via ";" instead of "&&" we're not
carrying forward the non-zero exit code.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index f5605b7767f..78324934d9f 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -461,9 +461,9 @@ lint-docs::
 		$(HOWTO_TXT) $(DOC_DEP_TXT) \
 		--section=1 $(MAN1_TXT) \
 		--section=5 $(MAN5_TXT) \
-		--section=7 $(MAN7_TXT); \
-	$(PERL_PATH) lint-man-end-blurb.perl $(MAN_TXT); \
-	$(PERL_PATH) lint-man-section-order.perl $(MAN_TXT);
+		--section=7 $(MAN7_TXT) && \
+	$(PERL_PATH) lint-man-end-blurb.perl $(MAN_TXT) && \
+	$(PERL_PATH) lint-man-section-order.perl $(MAN_TXT)
 
 ifeq ($(wildcard po/Makefile),po/Makefile)
 doc-l10n install-l10n::
-- 
2.33.1.1338.g20da966911a

