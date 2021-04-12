Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4A1C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 19:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E0A660200
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 19:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245261AbhDLT0W (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 15:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237203AbhDLT0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 15:26:16 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DBEC061756
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 12:25:57 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w4so10344100wrt.5
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 12:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oXi/N9DSW/IziE7+rn5DRY0PQ9Yy11dXZEetirpqj/0=;
        b=Vp4KyYw0jwcKKTA6wqUwBJDp6bk6U2bPcDFTEc1twhqU6sy+sBZDAqxLco/8KMITBb
         4TdknJiaDjcr/20iM5S+HpeOzC7d1KmLJOSYLN+VkJscLeXc47AtXqNtY0+Ba0D/z4AM
         MG369a/TEvH28urp2Qwbyz7tUJOp6jQ6SSFWQZjvXzh1u0FiRLMaaWVtVLoRFyoKa7t6
         LK5BJS5R9CWNCteuiSX4Zds5F2t2WZnTPoZWq1udFRCUGV0COgrTkytNG0OsgVFaXkFp
         OBE7YnzHM/O2ih+jhdjSp2MaFo4h7hwSEbJ42/H3Be+VpwVc+CAFUBcBVTuvknOgHj/s
         RUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oXi/N9DSW/IziE7+rn5DRY0PQ9Yy11dXZEetirpqj/0=;
        b=MiQwMqHEt/kbjdR70TZJqS0WAou7Ig9x+Gb+gE8FXZxop5Ll60OGrZlMxbw/XP44EL
         PXkQhwiryJdnlbEY9KB/Ozty0YJAclRlDHAIuf/WyrokmN6jVAif1Qa57fHA7yIepXTQ
         wAleW20HA8IWhemuzu+hJxswbKbUbxsjBlGP3QwOfpRAXJIfsubdZLPm/3N4HrwLv33r
         k1ZS/Z4T27YQDitPNiI67qDqFjUPIlT73Pos1Lu0OvTn7rIg6mo5Fq9vhThx3Jc8+oQs
         nNsP8XkRwN/STSPR4ynlFIU+PVZkAoOcvmPx7yTzUXllY5i45KXEuoCd7s+nm1IUGpi6
         UrIw==
X-Gm-Message-State: AOAM530l+SqBr7yZrkU0/kSDu44tXnm3eTbcra/PUs/ZXs309HAKXB4W
        bboITkipcLA1gW8ny0V67mlaw9MG1Eg=
X-Google-Smtp-Source: ABdhPJwTYTdTOxlby90FlGM02s+7Y/q5Tp4aYSZGRfyB57kpnxUFGwkmsAa8Gx1L7KL50TUUoIC1pw==
X-Received: by 2002:a05:6000:1204:: with SMTP id e4mr16355273wrx.424.1618255556378;
        Mon, 12 Apr 2021 12:25:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e11sm6643494wrt.41.2021.04.12.12.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 12:25:56 -0700 (PDT)
Message-Id: <02bd1f40fa4e281f878d0b9ba4a8b5f8eb21c8ff.1618255552.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
References: <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
        <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 19:25:34 +0000
Subject: [PATCH v6 02/20] reftable: add LICENSE
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

