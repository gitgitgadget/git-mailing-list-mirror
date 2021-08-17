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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C5CC4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF6CB60FA0
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240110AbhHQNma (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 09:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239977AbhHQNmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 09:42:09 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E01C0617AD
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:40:15 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h13so28757450wrp.1
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yj9tx1HJN1gjVb7BbFdzwGzB8sZO/EgnY23zy/aVzOc=;
        b=SbDdKNDbm64XiI5jqfIN3byHrplAqdlJXNDsn+TASt5G+7Z0vtXJGseUtIcvG6n4aZ
         Z72Y87VmcvJANDfm5vKX/2ABGGSUCjBEgychrWbptVIgLSIDozrK47+5p0nrYPlLOD0v
         TSvrdJmLRpVOBWqkl5vw0Gmychq09DG4gSU16PT2TDHj3m4fVz9ZmH9emhW66gGTb8pg
         z9E71CpHzxlYDStRCZP7NgDw5aUVfs+WwqRT+bzIXp0mD3cbGHlNrdZpvvKJncYOemnw
         UEc8LmG/GFRLXPkBSBElZZBS+LZ/1haSyIrQuHQ5l7XEo/W3gfJpmR0Ees3O2tpxNBoq
         YglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yj9tx1HJN1gjVb7BbFdzwGzB8sZO/EgnY23zy/aVzOc=;
        b=ofTXs0vCmsIAGfqkkYTY9B3Lq04FS6qbbpq6tzIw5ciXTmy2BhxMDr2D7e0fiaQbzP
         6KEZmhgRozvqVPSdbJ6qBA8XjclVY4Et3ob/u1CbuXNUSEQfITKp8OnXHnMC1H5nPcCB
         E+XSaNxU51VYgUiLpug6O64ffwk5MR7xsX3Y/m+NLo9VqgHCxIKNse4bQN6dI0CktzuY
         5rKi12u2TddNQRPhL79OfUeMsz3byQbIqbOfwHLDYQHRPbN9dEJ0rxWf+3Vo1DBKH/Rl
         DgKuUOuxRSZ9oVTfobKXyRQYy5gemkBUmf4jUZSf3J0RYyXpuuuFuxIh9NmuoH/FivHQ
         6osA==
X-Gm-Message-State: AOAM533AdYjHNOPyqDARR8/SJystrTfoMeunfGUBJlBinhPcY4+zD5vZ
        eN7oSB5Gy7DqD3IYxE8tMCT1otUW5ck=
X-Google-Smtp-Source: ABdhPJyOItIjUvj5Y/YJCIXEO5tF+4k5RnJ08U9NM8AZUueQ981r0FF1wozOUNNKM7TNMuT/3mK4hQ==
X-Received: by 2002:adf:f282:: with SMTP id k2mr4199123wro.255.1629207613839;
        Tue, 17 Aug 2021 06:40:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k14sm2512177wri.46.2021.08.17.06.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 06:40:12 -0700 (PDT)
Message-Id: <fca162dd67644bdc0945d015e5018f9371f40a7d.1629207607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
References: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
        <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 13:39:45 +0000
Subject: [PATCH v3 03/25] reftable: RFC: add LICENSE
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
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

