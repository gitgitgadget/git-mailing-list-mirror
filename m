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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41DCC07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC07D610D2
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbhGTQZS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 12:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbhGTQYO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 12:24:14 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674C8C061767
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:04:51 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l17-20020a05600c1d11b029021f84fcaf75so1918039wms.1
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yj9tx1HJN1gjVb7BbFdzwGzB8sZO/EgnY23zy/aVzOc=;
        b=VsikkGaegfIacPNimQGuYnYnduJhQ8mFBg9xALNt6ZpQTBL6iJ56FgLRYKkICfo4bo
         Kz9Dp34Us36we8Mj/L5+XSH/fM6vFT9b42w75NAs3MTmqIU0rR0guSn64v9Sx0YIPrG+
         eFXIzP3PpQQ4wuI7xLkc3FMpNdRs3Mc/Tvur436CROYcmrK5sjK3vXGPOY/nb7ONp5pb
         E3OOuqZJh1W3iPiKhafyqepMVsqlrZ4Jzjgw20XMymJ+Dbb4zzdXyPbEFEasU+3VSays
         nhOHZCEyAItVxpeJr+4SrXZChKS9d4jMrPzJzujyrnXUETvDYQU0i/4y9jskh0bS+WTY
         LlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yj9tx1HJN1gjVb7BbFdzwGzB8sZO/EgnY23zy/aVzOc=;
        b=TR2iTfDnTYauLM3FZxEmdHjJfUz3UEHKCiNdl8MbSBuGoB4LN3rpoOx7gFynMS8D6B
         sYSxrrcQVsoRo5HDblU4tAuap+wkRwZqNmbRkWxxDiJCvt10sCAkSOhmlfw+9/MhMLop
         RUlnUOYjO0ACpxyni3uhfp4GDpzu7sryEG6iNRGUEAcw+jkvMKNaCUobmJF9nXveFZOc
         iziKGXkhiJRjCgUJSbSoHisA0rOwfcTFi73JnLZrTqWcrn2fza18mF+zIhDelS30TpOJ
         EgdzC6tlv+KEbx5Mluytc4G6FID5P/shKwNR6PeK1IYwcGRa+0mvsweblBbxVbtwJ9mN
         4GuQ==
X-Gm-Message-State: AOAM532OQb9gATUICHhBhvUKMo+rBVWdlPG7aVyo7i1hpQ71e13J1TzG
        KKvTPJkqvlIfO/yDx+QbGJ6tK4SvlP8=
X-Google-Smtp-Source: ABdhPJySlmstCPR4lRDuR//HdHhxPH8owA8PJMWJz/nUNrZcN8hnrtDya8l9wVqb28DqurWNB8U1JA==
X-Received: by 2002:a1c:7dcf:: with SMTP id y198mr25154280wmc.140.1626800689988;
        Tue, 20 Jul 2021 10:04:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g3sm24394268wru.95.2021.07.20.10.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 10:04:49 -0700 (PDT)
Message-Id: <76c2a1005da68babc292eedf05daa29d7f236fcf.1626800686.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
References: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 17:04:23 +0000
Subject: [PATCH 03/26] reftable: RFC: add LICENSE
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

