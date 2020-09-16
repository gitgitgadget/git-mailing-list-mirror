Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99979C433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 19:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C2B020708
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 19:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Va7XDSbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgIPTKt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 15:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbgIPTKW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 15:10:22 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7882C061756
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 12:10:19 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j2so8019162wrx.7
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 12:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HcHNjBh+LHS08DtT9nU5o2hzC6PC18QgYDDpPua43xc=;
        b=Va7XDSbW2qCKPSXjTVb2qLRYLctCbtt3xL9iRF7OTKkZVQzR7uFu/xgn0wSgw66Et6
         qnV558RTiLK6cMrK7WDy/Xz+Y4J8KcUdSuZF0g82trXWDApDQB5T5LxU2VzKZU+x4nzt
         6waz2W8S6PWJU/Q33Hk8f2Nl4BDy565P9AwjBGiu6kX9U/AJCdXGCBtIYPDHpQj1YRE6
         K1S7UTtDe4mH3xJXj/8Ie/g/U8ME+soQGVGJEzLDfJIGS/BUSPzDtRGsR882r7HQGtUA
         jSgBUyKhJINdxFYD8vOWV4pv1xtwBsxrzTMqqPpLS/JeIl1fLXPlbU7B71XSoWo/0bs/
         l1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HcHNjBh+LHS08DtT9nU5o2hzC6PC18QgYDDpPua43xc=;
        b=ITUFWpskXa13+uifrwLDoqXumt/a/ZP5WorR01Y3Q79RUyc3aln7pjJK9OirCKzu3B
         oLrmVNkFNDFlPigzZwte+zSVA+GKEt8KnLALp6eIAv857K7goAXsYqehbOjUaVR6IoyD
         LTZXYQynciSa52Y9HpGJhn87GE5hSlr15DFC0RQgsaklfORWdZAoX6tp3Q9kAIc0Rm6L
         zaqZ7eVGmcyB4WsWHsNPK947inqFFFJDHtNqgYHN70eWOAqQfCFVMoQ7pLxwoFWxxmZA
         a1P1WoNJt6KnqN4OTJPL/9c1hr2vqMETTlqybWnTq+TQwLEsfs3W71YP4URjM0B+Uq5z
         Ltew==
X-Gm-Message-State: AOAM532ir925a2QAtSTQ+ewAd7PpOR+ie078C5k2MoKT7rr3XhGyD6NH
        onxd4mm6PjJTOR2KXJoyQuTm3LP55gw=
X-Google-Smtp-Source: ABdhPJzqRzcxnojK7MQ2ZhjVI/vGeXJVtSiHaHqMqb4c+y+Cy4XQAnX7OTpZF0A2gMr929gYhTHQRQ==
X-Received: by 2002:a5d:674c:: with SMTP id l12mr28125728wrw.325.1600283418338;
        Wed, 16 Sep 2020 12:10:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z11sm35138944wru.88.2020.09.16.12.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 12:10:17 -0700 (PDT)
Message-Id: <f697eac2286a37ff8d01e94102af3ce869fba3ff.1600283416.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Sep 2020 19:10:04 +0000
Subject: [PATCH 01/13] reftable: add LICENSE
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
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
index 0000000000..402e0f9356
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

