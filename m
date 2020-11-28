Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D25EC8302C
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4FC12224B
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/B1UBLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388931AbgK1Vtr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Nov 2020 16:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731707AbgK1SzN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Nov 2020 13:55:13 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D5AC09424B
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 22:44:45 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id g185so228259wmf.3
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 22:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GjRDj2Bo70S22H0AIBtEElGxzT1vN/EQIzALHBausfA=;
        b=d/B1UBLm/qMJRBnGBzrLv5DFMed/TBNdQ/O3G7cLSIETUV7cIA+r09aIIQ9SE3a8t0
         Ezz+PizJ+KZlZJ3fqykN1tfAB7eLh5PWKjYb1p8UyjpRl+DXjz3hgd6c7jveOZoR7Bju
         NjawOgCikGWDAtPAZfDpXnSysv7zKKvEmXOcFtwnjR1V/2038TNIIdUJtHqh46JfqgXb
         zmr2H5vcbXrbvOn/suflhULcf5zZDESyPiiQno2j48oCDo0jbOKWSA5Y6PH7q7rePdTa
         c+ikiPOq3dcc9wOxnYz+jveS/BiOyleU6Enio96z2FqkmQW5erqNq5YHolpatDCPJM7F
         /aCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GjRDj2Bo70S22H0AIBtEElGxzT1vN/EQIzALHBausfA=;
        b=P2pT8KbKr/i2wHoeBy83acKYaVqEeCDxHKPYc5raycgMTgqH2c3Dr6217qZFPz5Yxy
         6nVHXXZC6FC7W01/NTCVNlISe4mp0NStjxL7llQ1LCIRDdp4/n3ntoRnbhEgfP1QwPei
         3Zmu2rq5nt28LB3+czTWvzCo8ozF/b/SD6R7+m2Ewp4tMsdJnKzJoL2nT7r8uWlhFOmJ
         6PRC7qbLvGmdmL3DL0vFlLH6HhGPOZkzNCYKe/n34HeV8rwmEUy0jI02ql4U29t2hhoL
         Pvvky1cwU4yzuHND/p+dUAd2YgRQtgfWfzYeWmscEEfbyP+CrVG4KQqWxw+eXIJ77lct
         P/zw==
X-Gm-Message-State: AOAM530uaHX+Nh7kdY8pOfq+PSrnoEzDC/QAGJ8iTj+WIqLmEXwe8KX+
        rK31M+6JemWZorMr3ecc2HyyWy4X35o=
X-Google-Smtp-Source: ABdhPJwE78H/HEBZ/N3U1qSkof0JHkg8pYAYKESIkV09ZTFOiHd2mwQz1qbwFM9sEb4aj2is+qqJ0Q==
X-Received: by 2002:a7b:cd11:: with SMTP id f17mr12804661wmj.127.1606545884226;
        Fri, 27 Nov 2020 22:44:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v20sm15410454wmh.44.2020.11.27.22.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 22:44:43 -0800 (PST)
Message-Id: <8d2ae6771b6584965920f5d21829b42b7fdba80f.1606545878.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.801.git.1606545878.gitgitgadget@gmail.com>
References: <pull.801.git.1606545878.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 28 Nov 2020 06:44:37 +0000
Subject: [PATCH 5/6] fixup! reftable: rest of library
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Yet another instance of `= {}` initialization.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 reftable/dump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/reftable/dump.c b/reftable/dump.c
index e990bffe0c..7d620a3cf0 100644
--- a/reftable/dump.c
+++ b/reftable/dump.c
@@ -82,7 +82,7 @@ static int dump_table(const char *tablename)
 static int compact_stack(const char *stackdir)
 {
 	struct reftable_stack *stack = NULL;
-	struct reftable_write_options cfg = {};
+	struct reftable_write_options cfg = { 0 };
 
 	int err = reftable_new_stack(&stack, stackdir, cfg);
 	if (err < 0)
@@ -101,7 +101,7 @@ static int compact_stack(const char *stackdir)
 static int dump_stack(const char *stackdir)
 {
 	struct reftable_stack *stack = NULL;
-	struct reftable_write_options cfg = {};
+	struct reftable_write_options cfg = { 0 };
 	struct reftable_iterator it = { NULL };
 	struct reftable_ref_record ref = { NULL };
 	struct reftable_log_record log = { NULL };
-- 
gitgitgadget

