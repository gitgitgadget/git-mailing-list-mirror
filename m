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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A98C4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 14:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D28A323B31
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 14:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgLIOBe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 09:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728577AbgLIOBP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 09:01:15 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3D1C061794
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 06:00:34 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id t4so1841090wrr.12
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 06:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4NpTQf32ICA7a2lk50sbT+lka4vzTh1Zlu0nYbV/8/o=;
        b=DOoeFNIrJlTYMzORyF7UaPIY4TdnaujAfjRT+vEu24g3oaKVdtM8z+cNsL5+DRgJ28
         KBKcJiiQg8eJziZ7mPIqo9lnxW/fsU1Ht1KCgoecb10LOHgCCaaFfcYGTCSz0cJW4lFb
         smv0uikbYO5rWbW9MyVaTbo3dOi/0Ws5UG0rv+xOVSUXAcBJd04ejkx80eILIaiK6Sun
         mOmQZ1aqHyEzxtaYX7XGcDIUXc1GVfstKNnVgvB3GPT9vCxd/L7oFAI3LAwev+VTi+Vz
         eIsdEycI9vzJdgCHVSfpsPInpZBo/1jc0MIi7MsK0qRiq90rWCoijiFJ1vnzvJi9r/n4
         LXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4NpTQf32ICA7a2lk50sbT+lka4vzTh1Zlu0nYbV/8/o=;
        b=ZZ58hsJWQVCbbUXM2UP9yMk9lZS/2q+BkdOGXo3nDtMwKJBGWjkT0RGZoTqPdVAwzB
         kOLoxxrnI6kkSDgMu/xjTtEynCxSQM0moHEJFv1QI2ma+yOep7jw3HUgtZ0Un6gsNjuT
         0AnovY96pkHmoUddI86/xqdJByEaksKMzSgsVx7Jb+ZsuBTq1qtejZal8CzCkB0M0COW
         EF96U54VVt0yae0KTQTLCokyM64mImVoQPW1cG8B8JJ7kv+/qPhzqh/Hvy6HAfP0JQGG
         VnvHo4BQrZpJTFJSv/CT00eeb5tZKuyH2eWg/assSH0RpS641eXNFjdDoLbonpY2mFjx
         nrZg==
X-Gm-Message-State: AOAM532ktgc8+AFGTnWyO4GWG1RqiXmI3TnWAo9RkaGkTsSyIWinRE1l
        sUzlz7OUTbHuMswiC5/HzhGwV9J4gnQ=
X-Google-Smtp-Source: ABdhPJzPXycv8OynKmg4KmMeXDP1sCWhDn+vAUFyLnjem2HA0IEsuMPoATD05IF8jxmLru7LhRfrqw==
X-Received: by 2002:a5d:5005:: with SMTP id e5mr2800942wrt.279.1607522433466;
        Wed, 09 Dec 2020 06:00:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2sm3909816wml.23.2020.12.09.06.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 06:00:32 -0800 (PST)
Message-Id: <cc0fe58bd3337d63377949db9dd4c754db660774.1607522429.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com>
References: <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
        <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 14:00:16 +0000
Subject: [PATCH v4 02/15] reftable: add LICENSE
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
index 00000000000..402e0f9356b
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

