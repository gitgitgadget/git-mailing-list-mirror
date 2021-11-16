Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F26C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A570861040
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbhKPMFk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 07:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235810AbhKPMEd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 07:04:33 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2009C06120F
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:37 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso1724399wmr.4
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TeX5ZS2MPeBvASt8okmPtbmwlr3s2ozk2p9IRJvpas4=;
        b=NwQ7P1afSuV+h019DlzIN3RKhdhd/b2k6yCfvkbXP0ch1bd8FvX8zrUh+AVntdnhxi
         nV01R5uGE3Isix+xCotc6FPbzgC3n+JkT1E7HkYNT1RrXnK/VevmYMxgVmSjqh+u9bdr
         +CK0fcG0U2Zf9wrcVM2Mz6gj8WJex/jaN0HcIHLEOWGW69PDEf4/qWxzrpMbRa4LkGrL
         6jm8HG3R9uX4nJ6IPiaDALdDoO4U/L0han/AgWv7NbK7s9RxMequrFWoN1uqs2xyrbGJ
         byYOzLLtJvXrWvPC8njP5olSHoSSccCVWpQna9fGUeCi6mUUrG6pK/jw0P+OXk2bdStI
         WsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TeX5ZS2MPeBvASt8okmPtbmwlr3s2ozk2p9IRJvpas4=;
        b=LD8l3sxpfUS/7Nbf6qj+waCaKW8ceIWiDo37frUCiBgUyesjJTUgM6aEK1F0sGK3je
         QfPTVXorLtxpGSzAAkGygAXYue7teUcLmCieNunZD4qWrludkMpMSiJ5b+cPTmfXaapw
         oJ10RKgNa0NSQpkKuUMpoTWFkJ5BArdkm2SeAHs/k9nZGpYeju6rtH/di6ADEGFBWGOv
         Dc7XZzBFuN6wRjibwsGU0K73/eG7KqBm+Idzl3hTXOjVVLHxBzPEEzkEobjOyQPbDZFd
         VZo/0wVFES8kmKldTxq94gzMH7xS3PztUW1EZgY9m3LHcIi33gFFR1u9nsDTfrrQVJHY
         1hmw==
X-Gm-Message-State: AOAM530FrXfubUX6Ma4zROWJXRtWUlA6w7RUkfvc22YxanegxmHChdr6
        j3WZKSYijCg+OnsS7xKm0xAKUU/yqrsvhg==
X-Google-Smtp-Source: ABdhPJyjeJ9INLIg50rx9httPwOz3f5RTekvv3FKkBrSx6OAiB0kA5JLrrKz+FdsG/zdk7Tm8bJwuA==
X-Received: by 2002:a1c:c917:: with SMTP id f23mr4932274wmb.10.1637064035932;
        Tue, 16 Nov 2021 04:00:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k37sm2427922wms.21.2021.11.16.04.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:00:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 01/23] Makefile: don't invoke msgfmt with --statistics
Date:   Tue, 16 Nov 2021 13:00:01 +0100
Message-Id: <patch-v3-01.23-1621ca72c1d-20211116T114334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.795.g1e9501ab396
In-Reply-To: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com> <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
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
2.34.0.795.g1e9501ab396

