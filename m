Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A53DC433E6
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 20:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE60A64F84
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 20:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbhCLUUN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 15:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbhCLUUC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 15:20:02 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7784AC061762
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 12:20:01 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c76-20020a1c9a4f0000b029010c94499aedso16547026wme.0
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 12:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oXi/N9DSW/IziE7+rn5DRY0PQ9Yy11dXZEetirpqj/0=;
        b=PwbfCREb0wc197IsX7AXb9yyV3oBAbDoEvF0Uezjgc/3NfZAfbK+Fp1JpqMfWsOVan
         Z61tG/kNmnAWlbeTQ6gD9xEOjg95l8Ay930Xzk9Q0Yh3TXpRmibsI4GqT0O89lHD8qpc
         PQefoUcTWYuhjCoYHCHdRz/PvXzk1xb96FfVIstddrln/1wF2q12yn944yvSowGHJKwy
         gSa1Ac8iiBEfQyOjWx7Z+LkY12RVvmCh2D6A7IrYs7WyPPLeIYltHzOo8Q5q1iNPXOHm
         5WpgbFRzBpNCI9pfO4GZft7UdaVqBXyhB7S0hFpAfTLO935jKuS3L2DwSvFXjoMUl/lb
         oiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oXi/N9DSW/IziE7+rn5DRY0PQ9Yy11dXZEetirpqj/0=;
        b=fV/nMV7eShWEc3pyiBiy4clIwAubiD11zIVTQdmH3SIxQtgNN+epzurGSG1ZDm9eoW
         3AcbCyqpwmfLO4wwGmBZPxq/3dS0Z/zNkOr1QznRnWvUWTvROXlkhCNPhtsEDpX8QejL
         MhjkRETrCo7uxDi7vm197d7tyAzr+VIrTmtlXeCO9dt2CcmMiKvu94DVSKDjkFIeXl9t
         p8I1EhtTj4l4kafhSGa8Nib82nQfFQ571Ga4btQchIpE9eb/Qtak48HU9lARe1XWYdbq
         eDBO1fQoeuItdUVOBX6sy8SDWD+rylij96uISNHgfC4MjLwds28Q0dBB6pH+qRyEnrwD
         gqLg==
X-Gm-Message-State: AOAM530n32ZaVcNRZyQaT2oRsJlPc4y/ROs65SbCQ8+UKnlbf1/H1a6o
        0X9cbe1jnO5ISwCXCGI/32QvPY+sHgY=
X-Google-Smtp-Source: ABdhPJwelZ7vMmZ65G9BBlrmr62aYWd1PdWHEyEdNRpgJsmNOdZ2hr2SaRtFwv+r/yYuqfEroU6j/Q==
X-Received: by 2002:a05:600c:6d4:: with SMTP id b20mr14788374wmn.142.1615580400246;
        Fri, 12 Mar 2021 12:20:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j4sm3165471wmo.10.2021.03.12.12.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:19:59 -0800 (PST)
Message-Id: <502a66befabe1b7c616e9bc0f0ef4843ab4bdf77.1615580397.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
References: <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com>
        <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Mar 2021 20:19:43 +0000
Subject: [PATCH v5 02/15] reftable: add LICENSE
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

TODO: relicense?

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/LICENSE | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 reftable/LICENSE

diff --git a/reftable/LICENSE b/reftable/LICENSE
new file mode 100644
index 000000000000..402e0f9356ba
--- /dev/null
+++ b/reftable/LICENSE
@@ -0,0 +1,31 @@
+BSD License
+
+Copyright (c) 2020, Google LLC
+All rights reserved.
+
+Redistribution and use in source and binary forms, with or without
+modification, are permitted provided that the following conditions are
+met:
+
+* Redistributions of source code must retain the above copyright notice,
+this list of conditions and the following disclaimer.
+
+* Redistributions in binary form must reproduce the above copyright
+notice, this list of conditions and the following disclaimer in the
+documentation and/or other materials provided with the distribution.
+
+* Neither the name of Google LLC nor the names of its contributors may
+be used to endorse or promote products derived from this software
+without specific prior written permission.
+
+THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-- 
gitgitgadget

