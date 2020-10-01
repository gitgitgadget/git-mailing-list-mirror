Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CBDC4727E
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 16:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6E6E20759
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 16:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9mk58LF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732527AbgJAQLJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 12:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732048AbgJAQLI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 12:11:08 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A073C0613D0
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 09:11:08 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id q9so3513169wmj.2
        for <git@vger.kernel.org>; Thu, 01 Oct 2020 09:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HcHNjBh+LHS08DtT9nU5o2hzC6PC18QgYDDpPua43xc=;
        b=L9mk58LFdYam4Xj3a6toG35sYmfV4PdBdFb1JSjmyYOiK19re0b9B8Ov9/rvQhmDMd
         xo7sQOWSRezL6TlkcTfBKcs6VpnzMUPUNwC+VEjN1FtRs9o9GaC0IyT0y6V0igXDaftD
         hyyrEsZGjwM3iLhSPRCiuMdT17++HAmi9rrFOZqygSRLS5eDvB4i9p/z103tZpY5UBOt
         u+WxQNJIPwacm5WoBPodtf1h+cewQxtgt/Vp9zT3Ia9qQ4sktZCIGZ19oYI9+dglDs6U
         pl+YQOnpa4BEutcqnB8VP3vGaMNcqKOxNxn8/Vc72ubSdUwLbcpFvO7d1c5C5BIv4d2W
         llUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HcHNjBh+LHS08DtT9nU5o2hzC6PC18QgYDDpPua43xc=;
        b=UndmF1Wf1Lpk+IRVDRNJ78N144gx2wrML1ldhqZzDObNzGNkVlqq2RQBO2Uxg4fMQp
         rNs+2LT6QjP00+cNyH03CN72Emb28tOph14Yjp+Lxu/OjAh4dPEV8C5CWWfQOQtUH/zG
         Yaqky4h6zEADD55jz4czln67kY+RgK6laynfxL16qIClal+GB66+m/IBZPxduSFuDn4Z
         THK6FRdKeBBGoYrYjYS4PcJmUVehHA93RP90d9e/ewI/TZvrkVlIFg6ABCHQyIvFhwfp
         5aTGrzFMGNMfOhOsVBtpxfGvslhmxVdUpnsybyKtwxV/yST9ytOTq7Va5bJn/ZXtV/Mb
         2vog==
X-Gm-Message-State: AOAM532pGH0m3CwCqtwI+/EB/k6Sugh+/8mmn/JOWb2tQid9nOhKa8On
        nrBOGGkvqa8CDtMiqnjEafeFumHTomQ=
X-Google-Smtp-Source: ABdhPJwVo6p3prf8tUjW2VxClb5v0K+sNfGzJoz49/w1eXWIqbjfj7AftZrYby4pQt/4JE48vVOi/Q==
X-Received: by 2002:a1c:4683:: with SMTP id t125mr805816wma.110.1601568666976;
        Thu, 01 Oct 2020 09:11:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w2sm9497152wrs.15.2020.10.01.09.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 09:11:06 -0700 (PDT)
Message-Id: <6228103b4a6dab23ce3a4498eada8ff649909ff0.1601568663.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
        <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Oct 2020 16:10:51 +0000
Subject: [PATCH v2 01/13] reftable: add LICENSE
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
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

