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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBB7C6379D
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 19:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D49C21D7E
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 19:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2zyUWHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404611AbgKZTmj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 14:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404550AbgKZTmj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 14:42:39 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BDCC061A04
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 11:42:38 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id s8so3316825wrw.10
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 11:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HcHNjBh+LHS08DtT9nU5o2hzC6PC18QgYDDpPua43xc=;
        b=m2zyUWHqr2ze5hFPmxuTSssoZpCAOsloyojNQ6wRYGNTyKuECHdciO94i6YH/TmxO6
         vRxGn8bVFHK2nyfg8lqw79SfAApepA72fbbqrfYHD8fCmlA862KoxzEfxL2vhpTZqLnt
         Y7agH9zhLywbkRUtLJ+kHbAqIKd43l4DFmdirw49Lw7jGn5W7CU0O7NMjZEQ5p7y2Xaq
         181TrCn7D20XAQuJCcvmVtv8aT+WKJymky86Fh65S9zGU24HsGbdAaBdZUxWrp8UbsBw
         TcxkQFPGwHD0Eopg50FD6bkyohQmWw4KJus4rC71QkQmRMNjFyBrXrZgIOLuIpS3jqUl
         EVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HcHNjBh+LHS08DtT9nU5o2hzC6PC18QgYDDpPua43xc=;
        b=S0C7E2l6d31SCv0LHQQzzUbXGQhmU6TWg2d3SZJovQ/tRbFKZgKM9xld5Iri4jYioa
         rhXXObPEouGXo+MdCeJzYX/Wk3Z1BQf6e6h543qPrl4CDalEhMBTeffowuv1V5K/GRIC
         FLQ9uN6ofVoAr/LWFH1xuf19c6cun4hu1JYGI4oO00wB2Z1nw5QPz2YwafW2h4IYLhho
         rdHhZWJ/UNM7ojM7/Fk2bYq3RgJdBHXVTIxoQw8fe6upH8pMlZEV8nkHbxcRvCgndSlg
         2ZQzFhZNtE6WMYfitqoMPJOiyQRIf786IL3EQ66cESWwy1rZDMsxCbaFqZnn8db2BnEz
         6HXA==
X-Gm-Message-State: AOAM533tx/m+PRnop5QY0ba8R8Fiamenl6WjWKcfmSrmQY27NII/KJOK
        nEuaNFR+AdxRJA5GIbfOeeZQnZVkezw=
X-Google-Smtp-Source: ABdhPJzNwkvuFlgjyTG/5ZTQseC9BKPQG6GKNsS/SjhUwinsZDh+RMOvnDOz3Ib8fWi9cFHFHEt5Eg==
X-Received: by 2002:a5d:634c:: with SMTP id b12mr5741187wrw.130.1606419756877;
        Thu, 26 Nov 2020 11:42:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j8sm10541395wrx.11.2020.11.26.11.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 11:42:36 -0800 (PST)
Message-Id: <91c3ac2449edc45db643b0ba6cba66ef31176600.1606419752.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
References: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
        <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Nov 2020 19:42:18 +0000
Subject: [PATCH v3 03/16] reftable: add LICENSE
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
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
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

