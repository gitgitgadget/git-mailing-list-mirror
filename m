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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EADC43214
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 14:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECC8A60E77
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 14:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbhH3O7A (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 10:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbhH3O6x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 10:58:53 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D66DC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 07:58:00 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id x2-20020a1c7c02000000b002e6f1f69a1eso14943091wmc.5
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 07:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yj9tx1HJN1gjVb7BbFdzwGzB8sZO/EgnY23zy/aVzOc=;
        b=if0SGIjbkJbImrL+ij2IAjiVq1ZOE6F0/C/yf15ZIcS1Pf4kYZOZGZAmUF1G8WLRWR
         9aHPLCbdHQQ+RkTpeQI1Q9dMBWq9OHKZLULdiWvAx+rlR71gJMEMl6HMS1QizKv77Yas
         cKCydOpX/RuabGAeg3Do05VztLHhjfkCwss70CjGY2xfkdlyCOhT7kiiRnPoax5vwD7f
         D0KtD6SR3SAUWQpgoE8LPj+RnwfSOP7+kkU/1yqLynLs7zWrp74lGLaYq3ZbdM2vfOXT
         umPwmnDQciexoIYOYTmrfO4UZSvkh5ikhoxDdVCDsWhBaCVsvS1ofSwDC4xGBoC/e0th
         w4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yj9tx1HJN1gjVb7BbFdzwGzB8sZO/EgnY23zy/aVzOc=;
        b=AsXVhb6f2JwAUZLDvLg/Y5BNWqQWTUN6EnHQG+iSD2UEHkaLrG4G7nUkmE6W5Gc4C2
         Js8oajDvCGf+Iq1lu53Jq4DavUV7Rc4o5RRbyQeG6u8BgdeFHvcSBOBLsy+Tq3ZXBeGu
         q2/KpoAY4yeUz6buOQ8rYDI55H1TLhpMwpheC/+brWUjRhAVGSYaQ0C42CzMPT4kaQkv
         vmd2JD4vGZpp6jPbs2vZGql4Q6FojQs2yn0kHxLwDkxqrqrpFuOAPjiqgm2pQSdOxdsN
         4jBSflOcbbVONA5oHwer8zW/WUt3jZbETdivuRHAceyQWssMy+BG657zeLNIMt7gqW6c
         aGPg==
X-Gm-Message-State: AOAM531b+9Q/qLdqFV436KzDz1gAmasGTM9EykJCs5CA/KNxAc9q3N+v
        5/y73kyhWpoPeOYzN2QbYWVAqWeqthQ=
X-Google-Smtp-Source: ABdhPJxrNJj5ObhTYx7YIn801xfIQVykKhTa8xNN2yJz/4KD92t8dBUQISs1R8J2rrcBZGFXjR1l2A==
X-Received: by 2002:a05:600c:a08:: with SMTP id z8mr34401030wmp.165.1630335478734;
        Mon, 30 Aug 2021 07:57:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i20sm4295263wml.37.2021.08.30.07.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 07:57:58 -0700 (PDT)
Message-Id: <2d31c783fb5624a8dcbd4fedda9b7687ed784690.1630335476.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
References: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Aug 2021 14:57:38 +0000
Subject: [PATCH 02/19] reftable: RFC: add LICENSE
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

