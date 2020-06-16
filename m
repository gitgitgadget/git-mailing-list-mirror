Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC5CC433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04F95208B3
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D42MtJ0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbgFPTVW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730609AbgFPTUy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 15:20:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E915C061795
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:20:54 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id p5so21934121wrw.9
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1g7xJNEHljtESnR5/L4oArBHPSBJu5a8+IEAIVDCwIk=;
        b=D42MtJ0d3tHka4B7WZnp0rIrNiFaItuNqBVFRAgpSVtGc7BVzOeP1S2XgewicCvv68
         jS+yJ+GmtBNuh+eHEBlf0kvx2JUHQQT3fcpipR7Vb3erWK1qPu0gqpMPh8GT5Z9OC+3f
         7xF/OnpdLD6tc5XV7LzfYYMjFLLhZzQe9neMIg6Jr1Pt0DYc/ykFfnMtfniK1L/iMI31
         Wf+RNzELwMwSdJwkEXttEPIEccVVz66OPZSyIltnZUUUBDiLfeYDkFzAZSE6Wzw2Fd4J
         zyzlJq3WLBLvO6cGQ5FLecQEiavgoQSU3ZZbK6GPGJpHLd/7zWR+jTExdOw9t3t119VU
         y8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1g7xJNEHljtESnR5/L4oArBHPSBJu5a8+IEAIVDCwIk=;
        b=dAcvbUfpysbnmB0hmYJh1KA4pqgTUZsYrFBwl3NeWjWtaHdjmh9j0QV9Rwd5sJwP0Q
         nnmIuMEzGgJmR5mlzjLhzLzdWcPgiu43T1kC2aEjlLaC+GzTvYKkAzWHo66xKbk1GKev
         cuooeladfFRo7hMxo8/g3opkOh1FLQtGbSiqMMQEWYIEwLGZ937SAkbaBybqtGdNT4rv
         8mYQmJVT/mE25Uq7HTYI+gGvC7gEEH7UENhDv+fYt7BaZw13EJB+BcKsMhejHX02fFbH
         068fo7bVhqYjwdik+/o0ur/RvAf+netUx79uaAD9KBLWqVJjeU621n8CaqTeyNU0EVST
         N7BQ==
X-Gm-Message-State: AOAM533ek/XpaJWFvK5eL+l2BF4Aq0usaExQgfsNi91z5F+6Za1xiXPW
        mbAffHSJfK2Hq/nRTM5LOlHzrEU5
X-Google-Smtp-Source: ABdhPJzEeZln3cGGiaB0pMGmSSf9Bsg13hQMM7MmlLpz92Tcw7AGApmANBPr5Zmp5RocVTrsoFj6qQ==
X-Received: by 2002:adf:eec2:: with SMTP id a2mr4409476wrp.136.1592335253205;
        Tue, 16 Jun 2020 12:20:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c68sm5217536wmd.12.2020.06.16.12.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 12:20:52 -0700 (PDT)
Message-Id: <1fa68d5d34f2df83d168f013030db792ebcad80c.1592335243.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
References: <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
        <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Jun 2020 19:20:35 +0000
Subject: [PATCH v17 10/17] Add .gitattributes for the reftable/ directory
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

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/.gitattributes | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 reftable/.gitattributes

diff --git a/reftable/.gitattributes b/reftable/.gitattributes
new file mode 100644
index 00000000000..f44451a3795
--- /dev/null
+++ b/reftable/.gitattributes
@@ -0,0 +1 @@
+/zlib-compat.c	whitespace=-indent-with-non-tab,-trailing-space
-- 
gitgitgadget

