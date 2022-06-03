Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9955C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 18:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347612AbiFCSjg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347534AbiFCSjD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 14:39:03 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21ED13F1F
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 11:38:08 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso4753292wmn.4
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 11:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/fGAJYhyHSfcmSlYQArD7fG/6FhVph4XUP7NNo8Iewk=;
        b=GN2AO5ZWxiMpQZYWkg+sB8fVC49L1MdU52ULpzHMfO84iUVsnsf3d8cZLyhIqxj8+9
         sB/KgY10t/8QRXW4uPoGzQsERahiinJDpM6bB4tNbAUNyuZPeJ+L/lnDWFkRHParFAKA
         u7QACdTmmh3CjXM3267b+4szMzfUJUotroVeuCpuNBjd2M72G12jbz2DGnPWA/EOLneB
         3UbcEokbJfvSD53vAxxNs8s+VRuj2lp2app+Kutwga6el+UZ2hok5YD37tcq8dgvXOlj
         e3Y5hVpeCm5xQ6fDq+IsWMKXGbqb2FZHKaYTteeyfpT9yG7RWXYcS45OkyU1pk4zWGR7
         Nkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/fGAJYhyHSfcmSlYQArD7fG/6FhVph4XUP7NNo8Iewk=;
        b=f2Tiqa8+isDX/TyD2LEgJ7gNCnJ/ymaIJyej9nCDwf5VR1qFGyuFU5zpzNi6RAnZFw
         QiLgUlOpadlDmihZ1Uz6Hnz4c/8Bqjo0l5rmJpay7MB1vDlSEkNDWiO7mIBXA2+9XrSw
         s3Q8FBMSCBpVPfveCbYIzD2Z78iEAT9MbMlTYyC3bOQRoGzVPMmWaR6QOB6/xyjgVAHM
         6s27Zuo4FxS3val7XJoweOVopYfUmOqw+uux+6/3i2KTj351Uh+EjxSwZcoAEEtNtOV4
         9dcnf6ruWzesQ+z+RcWTUFrZ3a2FeajCQFKsKZ32CjxGa5LxQk52pCmi6xARGPKsMLoh
         rODA==
X-Gm-Message-State: AOAM532nLOV9IwGxzP52RH1kDdzaQ1FRU6pyZPjF7M3UBkf4z42YrnBT
        sHSQ9G0zb7Kr/DSYFV1CT1KS13c30mbtdw==
X-Google-Smtp-Source: ABdhPJxiJnJvK20pbeCQ5OR8RqdFqX713rAe2lKEchW+TU3OiQmriipAP3++Cu3Moco+tzw+NaBNmg==
X-Received: by 2002:a1c:5444:0:b0:39c:3761:ac37 with SMTP id p4-20020a1c5444000000b0039c3761ac37mr6687316wmi.144.1654281487244;
        Fri, 03 Jun 2022 11:38:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y5-20020adff6c5000000b0020c5253d926sm8232636wrp.114.2022.06.03.11.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 11:38:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 07/15] strbuf.c: placate -fanalyzer in strbuf_grow()
Date:   Fri,  3 Jun 2022 20:37:44 +0200
Message-Id: <RFC-patch-07.15-cf1a5f3ed0f-20220603T183608Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1124.g577fa9c2ebd
In-Reply-To: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the strbuf_grow() function so that GCC v12's -fanalyze doesn't
yell at us about sb->buf[0] dereferencing NULL, this also makes this
code easier to follow.

This BUG() should be unreachable since the state of our "sb->buf" and
"sb->alloc" goes hand-in-hand, but -fanalyzer isn't smart enough to
know that, and adding the BUG() also makes it clearer to human readers
that that's what happens here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 strbuf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index dd9eb85527a..61c4630aeeb 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -97,6 +97,8 @@ void strbuf_grow(struct strbuf *sb, size_t extra)
 	if (new_buf)
 		sb->buf = NULL;
 	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
+	if (new_buf && !sb->buf)
+		BUG("for a new buffer ALLOC_GROW() should always do work!");
 	if (new_buf)
 		sb->buf[0] = '\0';
 }
-- 
2.36.1.1124.g577fa9c2ebd

