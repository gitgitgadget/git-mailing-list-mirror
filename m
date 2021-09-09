Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C516C433FE
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B2561108
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244821AbhIIStC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 14:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242059AbhIISs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 14:48:58 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE32C061757
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 11:47:48 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so2125884wms.4
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 11:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yj9tx1HJN1gjVb7BbFdzwGzB8sZO/EgnY23zy/aVzOc=;
        b=eI1EYohSzVG1rQPVjXAS9p+Ridub4zfq42lo/lAzSDI83jwk8tgeCrEKbWhrC+P7dI
         owyqkyhDfIUFdT6I9NyERn5/El7GIstmjIJCuTAUNVQZwrseFPl7Vi0FOiQwYMlzem2p
         gWL/1YUi+Ch8ncd4Xs6h61gMCzSo0cSnGmexfHOF8Muoq2Zr9sTU99Y0ILlggLvfpsFh
         dFAIHcYPyasvaTyi8dDTbmkr2kV0KQpljVTKSMgxjjCVnbMKkFcVVDGnkMYfuWymkJsJ
         423FVyNjWoPoa/ZIARdF0BgaxJMhAeAP2ALpvWHTw9+z4AP0xhHE+EtW2DKacGc0sqNL
         c2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yj9tx1HJN1gjVb7BbFdzwGzB8sZO/EgnY23zy/aVzOc=;
        b=hJSUnUVJAmYAu5Ni+uTXvCDBlXN69kUARwBplik01ZyO8XkPdnmsm7mrD3Fy/tWfbL
         sS7Svn5UyGzEmkBbWpYTObmHk1TSq150hPkclFtNHZ/jPV2VqcQTo5OrOtOVyKTpcs5M
         7qpZADBKBb2ji6ZR6qLnWe2ALjOYKV6Wh7mR2QzkKk0GrGeqx6n5wYCFsXENxcSRVBVq
         W9FEpsMdnTX2EfB5QeFuQ271ubGSgO4mZ0nwiwJMb3kC+TdhxY9Wj+8IzDHDsbYw0wkL
         pWxdUdNT9qNJ5nCohJkdB/k/MmloyxbWje43NAbbg9jLYaKcDj9LgXs/8ksOFeVzewOr
         7Pcg==
X-Gm-Message-State: AOAM530ugb01oWUVS820SIBELgvs4bANxDqfsosaRWNWzfGZ1KqP58F7
        ze+DnNTY6HVUcmt2TWRDVTZJXgytCk4=
X-Google-Smtp-Source: ABdhPJzBRUPFNGiOUm6KWYQpe9rf0Y82sA8pcPmsE2eNZ+1/Go3Ghm1SnezAElBhQHrydpJm/gNwIw==
X-Received: by 2002:a05:600c:1990:: with SMTP id t16mr4537728wmq.45.1631213267569;
        Thu, 09 Sep 2021 11:47:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v9sm2197238wml.46.2021.09.09.11.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:47:47 -0700 (PDT)
Message-Id: <52968d8e83f392d3a12a6fb8483206aecb3ccf1c.1631213265.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
References: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
        <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Sep 2021 18:47:27 +0000
Subject: [PATCH v2 02/19] reftable: RFC: add LICENSE
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
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

