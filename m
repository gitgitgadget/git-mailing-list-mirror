Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5101FC433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3100E61B31
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbhKPMJU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 07:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbhKPMFb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 07:05:31 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6DDC0797B9
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:52 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso1678684wmh.0
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JYU6ZqdBylyp/LlzABrbBEiDt9aT91KV5lqC0sjQkNY=;
        b=gkt7K+8e9O3sZTywgzqWcrolW3iPcnF13St7LKZbRQ6oX2v2V8D9+SCD8Jl0wiFu0L
         Z7ofryLyg9v9oNMrT05pRKCSi31QZKI8Rc291evi0gSLtGZ0MdKLpr5jNT3vHg0bGp1k
         DbHw0aOwyNsZIA8OjK9onbLLBf3CcsnzleBnMlrl0DYCaHjWlG+2qxMOxjeZPXz0GBeh
         cWuwVRKqv3qZh3kWxb5wPi0yq27b1unh9CNRq880WoHxcMHLn2u4fKh/GeeAsV4MrQPA
         +0Qxlfw8OVyxF/XGLVTUfRsFwb7MW+oDnAwuYXOPadzOcdhaAQoAZI9ss31r6Ttnx2qj
         nRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JYU6ZqdBylyp/LlzABrbBEiDt9aT91KV5lqC0sjQkNY=;
        b=7da74iqzlae/ZoZmjlLgayogTZpDULfI/lDFtTycDjRYGLqTVolfcoYRTEumySvxQE
         jvnwBS/1NBaTsQ3URPAo/I5riimB1ys01u7qAKacCL3qgy865P0tNhZnhT9p+QlpO1vs
         zFruyOlcqCMiMEN0QSspR9FHv+rRbTWXE2PlfSuFq1FtSj0UiNP/cHrCktPJAFMh+smK
         pJ6V/B3h99mP31rmJxU5I+lWZExFyolmJWB9CV7o91jMuDyoPVby5BhSF8xI9C1wkklw
         ZlHQnn5YQQK2gt5STsy4sxky5w906gJvcRIeYQoLPlLiBTd4e9b+OZAJYpuGJPIi3FU4
         JjkQ==
X-Gm-Message-State: AOAM532snE4y4mmfWh1x1xhgzRp4/JyoeEF0dqORet3Wq45Ny3RWxwOa
        jU4Jlh7ysB6l1BH9d9fyyGlxlmzIRybxMA==
X-Google-Smtp-Source: ABdhPJwYxVdLo9azKxbBwz9iTJT1Y9EmSOA3fBWyBObVCOPmRwP5anlIYfWzZ5dLttEZWz0AA9rviw==
X-Received: by 2002:a7b:cd93:: with SMTP id y19mr6948263wmj.190.1637064050963;
        Tue, 16 Nov 2021 04:00:50 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k37sm2427922wms.21.2021.11.16.04.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:00:50 -0800 (PST)
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
Subject: [PATCH v3 19/23] Makefile: correct the dependency graph of hook-list.h
Date:   Tue, 16 Nov 2021 13:00:19 +0100
Message-Id: <patch-v3-19.23-234b4eb613c-20211116T114334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.795.g1e9501ab396
In-Reply-To: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com> <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix an issue in my cfe853e66be (hook-list.h: add a generated list of
hooks, like config-list.h, 2021-09-26), the builtin/help.c was
inadvertently made to depend on hook-list.h, but it's used by
builtin/bugreport.c.

Reported-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 0a3f292bf82..bae20eb1b40 100644
--- a/Makefile
+++ b/Makefile
@@ -2162,8 +2162,9 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 
 help.sp help.s help.o: command-list.h
 hook.sp hook.s hook.o: hook-list.h
+builtin/bugreport.sp builtin/bugreport.s builtin/bugreport.o: hook-list.h
 
-builtin/help.sp builtin/help.s builtin/help.o: config-list.h hook-list.h GIT-PREFIX
+builtin/help.sp builtin/help.s builtin/help.o: config-list.h GIT-PREFIX
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
 	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
-- 
2.34.0.795.g1e9501ab396

