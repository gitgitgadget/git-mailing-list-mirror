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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3347C433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2F8061166
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbhDSLjH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238650AbhDSLif (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 07:38:35 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C601C061761
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:04 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n10-20020a05600c4f8ab0290130f0d3cba3so4786569wmq.1
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oXi/N9DSW/IziE7+rn5DRY0PQ9Yy11dXZEetirpqj/0=;
        b=TYa223lu7W8o/ZMOq5xFXLJAMNaxH5GfZj1wKEe9gjlUP7iQvkAb+Zlm1HNZyoabLC
         eHdJR5AZOxRptPEygNu8aLB7iBROknXCf3qdaEw1mkZ6F2hbfFMrG6wGWiqeBh1+bExN
         2hpusPX/m7vLNpnRfo6Rf37MYPcBaYUD6HWlkRG6tZeBBmxeS41Y9fQEcxN8WeynD1Kd
         gv3QDhMxdLptNTcE5OyvMUeqJAEHp6KClZNCmB0f2RNG0ET7yb9chYTL3mkAyO4bmdAE
         ooh6G6wreBqhhQUqfoJgnfq+DnwlbFgLtS0PXjlrUP9UaF5HkcrzItTZ3ozj1eyw3XFZ
         wznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oXi/N9DSW/IziE7+rn5DRY0PQ9Yy11dXZEetirpqj/0=;
        b=uEbpNtqD9CEs0E0QzeGarHVqTOPdWfB5ErAl86P3rpkl/7otcatx/jwIU82KrW2KZ1
         UfSEAxpPuwzb9s2ddWFJ3njPSwxLJAwwI0shlsEXuHS6gEZbOTLU81lKvBzuDoeOApRh
         +R4lZqMZ3zxEc9QY+TexjLyu1bf1Z62hKwlJhf/sqqSGgBJUKVKeoe0PXPbeJ14FqHxj
         HX0Vfu5rICAfBJhh8aNeY7MgH1Up+98zHY+8C+8ODEiFp8tzSDQoMSIegoTqDBJzR/SN
         tIA0xw+LY46/Y/slP+U3wXUV7kRhHeAZhAzPYGdjf6vUlBSYMDsISiW8cV6/xQmjXszP
         GhuQ==
X-Gm-Message-State: AOAM533mzCSaezzcI5OKdQk0fM2sZPIAkKx5EKGM2rDZS6m+FcIC1ysV
        RR+K4qlKLSdOBuC49MPLUcCTGnBXOzU=
X-Google-Smtp-Source: ABdhPJzzXatMlmSWnEGfqGod4I8FMaFMD/i8n6qUhlJBXy6HVjn2fwSOZrlkKYRpcQju2Fq4FemZAg==
X-Received: by 2002:a05:600c:4148:: with SMTP id h8mr9757933wmm.19.1618832283400;
        Mon, 19 Apr 2021 04:38:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3sm19551558wmi.7.2021.04.19.04.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 04:38:03 -0700 (PDT)
Message-Id: <8a960fb77fa9117009119ce37aaa9885749bd1a5.1618832277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
        <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 11:37:34 +0000
Subject: [PATCH v7 06/28] reftable: add LICENSE
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
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys g <hanwen@google.com>,
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

