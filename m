Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2512C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9560A61BF8
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbhKQKX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbhKQKX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 05:23:26 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F547C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:27 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id b184-20020a1c1bc1000000b0033140bf8dd5so1648482wmb.5
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=40S6S/BMOHW3QtyzgL7+16+Y+ocb6rw3M1oaASEmn4A=;
        b=NtnsB2cJ2pN73Xmrfom+NeSSlyM6KGr8hhq/qvBQRQOQKaJyOHMpgJuoLr4B9OezAI
         Z1FJ301OAb5vRh6HDY6atSQWRYMwGERa//P+Q8EpDHYvW2SlqoC3ZSMTSErwWy6uoXTR
         UDU4p1LuN/Dir8lvEiEzQD7THMZxIZE7oY98bicR1t6e809ZaI0Q9NvdPbym8XITmIhQ
         PPIsMsznSf10vUVE76+hvRdZ+3Vhb83aeUnrNC/QBWIaA0eogwnlakGF9eo93ypO1Vsu
         VODkAcFxzwQDE1Pjo8uTJnASGKN9QRx6jjLe8rNKgrPvY4RY/mIXHcXVW6QOoDhqueqz
         cz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=40S6S/BMOHW3QtyzgL7+16+Y+ocb6rw3M1oaASEmn4A=;
        b=jFPLkBuap5cloqUhutFOSLNCCR9bL3a6k8pvkJPKhq4hQWUbJyLTP79FfQMq4XZdJv
         uQow6qdly1y17tBTXuGqKNrXPQ+OcXo5sLGpD5kxuwJG7bJ/urEpATCVntc+LCu8E1HV
         Rwc5P8Nte9Rt0z/uuFrhqRV/v9+V5Bb71ccBDQLNkFAJw7N/yYewcewrSHZjJKdX47lW
         rwQLOeH10xZReMA0V0LssQDlB+uoh3zhlIL4QAP+/Bk+XP/YcnSsbaj1i/yCm3C3/7Qn
         1atUy6YlXDf6dPd4poxfWtEI1d1ClRbCg7t36wfhaS8X++7+Am8a8O8ac3JbfVAk94RJ
         9SIw==
X-Gm-Message-State: AOAM533jTCDi3PUGLfR9YYc1BHdOFxO2YKPg/eCdRiskxk6zQ3yD5vwU
        diBtKvAE5K9eEqlGx6AplDZ+gYgXUbrKeA==
X-Google-Smtp-Source: ABdhPJyOiw/WZQ0oy4REks14WMJjxHehU54phJqxEBFQh0F4iP6TC4SW0QuQJ7GRR4KwsQ/oFHtlsw==
X-Received: by 2002:a05:600c:4ed2:: with SMTP id g18mr75654199wmq.18.1637144425982;
        Wed, 17 Nov 2021 02:20:25 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n32sm6456256wms.1.2021.11.17.02.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 02:20:25 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 01/23] Makefile: don't invoke msgfmt with --statistics
Date:   Wed, 17 Nov 2021 11:20:00 +0100
Message-Id: <patch-v4-01.23-1621ca72c1d-20211117T101807Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.796.g2c87ed6146a
In-Reply-To: <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
References: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com> <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the --statistics flag that I added in 5e9637c6297 (i18n: add
infrastructure for translating Git with gettext, 2011-11-18). Our
Makefile output is good about reducing verbosity by default, except in
this case:

    $ rm -rf po/build/locale/e*; time make -j $(nproc) all
        SUBDIR templates
        MKDIR -p po/build/locale/el/LC_MESSAGES
        MSGFMT po/build/locale/el/LC_MESSAGES/git.mo
        MKDIR -p po/build/locale/es/LC_MESSAGES
        MSGFMT po/build/locale/es/LC_MESSAGES/git.mo
    1038 translated messages, 3325 untranslated messages.
    5230 translated messages.

I didn't have any good reason for using --statistics at the time other
than ad-hoc eyeballing of the output. We don't need to spew out
exactly how many messages we've got translated every time. Now we'll
instead emit:

    $ rm -rf po/build/locale/e*; time make -j $(nproc) all
        SUBDIR templates
        MKDIR -p po/build/locale/el/LC_MESSAGES
        MSGFMT po/build/locale/el/LC_MESSAGES/git.mo
        MKDIR -p po/build/locale/es/LC_MESSAGES
        MSGFMT po/build/locale/es/LC_MESSAGES/git.mo

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index d56c0e4aadc..11da97de233 100644
--- a/Makefile
+++ b/Makefile
@@ -1870,7 +1870,7 @@ ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
 endif
 
 ifndef NO_MSGFMT_EXTENDED_OPTIONS
-	MSGFMT += --check --statistics
+	MSGFMT += --check
 endif
 
 ifdef HAVE_CLOCK_GETTIME
-- 
2.34.0.796.g2c87ed6146a

