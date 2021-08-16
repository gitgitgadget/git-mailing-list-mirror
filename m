Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C928C432BE
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 016AE60F39
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbhHPUSI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 16:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbhHPUR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 16:17:56 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E157BC061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 13:17:23 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id a201-20020a1c7fd2000000b002e6d33447f9so592731wmd.0
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 13:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yj9tx1HJN1gjVb7BbFdzwGzB8sZO/EgnY23zy/aVzOc=;
        b=TyGm1N1WzFAXs+epwChTB8s+wWnaxwmuFfjKbfwbHAdGUbooo18Dn15w2WDMxeXRFC
         0/zCrnARmFjc3Iv9BnMIuv3Yv2hyTsYqq5LWNJk4qiAstgEqwkpg76nvKgi09B8BEAvn
         KWRZhNhJcb07uy5GlLUR6kiSnreOLD+hvEnkReS86UbPOlnGwiAQql6UnK+QGN/RCLRz
         ded8RzLqZplo1IJhgRQIF5+imCcTSx4RnhBJEK0cZrA07gCvVhAzNi5o2Jhh+DNhBWuE
         urN3Lm32O5fbW3LFYN5KD0xdgOoVM6uToCU1M7jaOz4mc/qj5zD6e661twgEFxA9J5em
         HtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yj9tx1HJN1gjVb7BbFdzwGzB8sZO/EgnY23zy/aVzOc=;
        b=rncC/qeWmT49W63PM4OLXTr4/7Yv4PGSgkjijSyI0mhTWr0XOWO7AG7HVKEghAoKk2
         pC0D4DdU+seffHve1RX5Vy/yli81Dv3pnPy6IXayMe6K9vcuZSHwXs/UmedUGCyIzWX6
         2SUAdXeXtV35OwoflXhOIJ8lCpeX4AFs63OdfA8F3YbxetVDDUyU/AMHvgJA5COmlw3q
         VIiq9kvSDnbRu1rmptu9CaA+wmAE0/Rx40LEIWbzKaSrhNagcLqPIDryWl7tvCZu7VzB
         d83XTsGVPqC+Unr8GiqWzMUxz2Duizm+uCITZdRkTch5YoQ3ypcs/uE3ag1pQCQ7Uvb5
         c2gg==
X-Gm-Message-State: AOAM533yc2iouwV3rDe3D2KPY0haYx9XOgpntWErDfCzXoH++fZjWGzP
        uMGRqiG+LtosKgJ506lfGyANAxpcvrE=
X-Google-Smtp-Source: ABdhPJzSHqHJfqOTdZ3dwC5OaOUzSs+nkpneqw7xlsbDUSB3xFuFn5MCgq0Gk+GYbKCVovgi3LKDVg==
X-Received: by 2002:a05:600c:c2:: with SMTP id u2mr21706wmm.106.1629145042582;
        Mon, 16 Aug 2021 13:17:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r10sm301795wrq.32.2021.08.16.13.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 13:17:21 -0700 (PDT)
Message-Id: <dba354eca12a53b4d76d0d7475a4128843c7f70d.1629145036.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
References: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
        <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Aug 2021 20:16:54 +0000
Subject: [PATCH v2 03/25] reftable: RFC: add LICENSE
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The objective of this code is to be usable as a C library, so it can be reused
in libgit2.

This is currently using a BSD license as it is the liberal license I could find,
but this could be changed to whatever fits the stated goal above.

This code is currently imported from github.com/hanwen/reftable. Once this code
lands in git.git, the C code will be removed from github.com/hanwen/reftable,
and the git.git code will be the source of truth.

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

