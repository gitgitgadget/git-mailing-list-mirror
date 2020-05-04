Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA922C47254
	for <git@archiver.kernel.org>; Mon,  4 May 2020 13:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8C262075E
	for <git@archiver.kernel.org>; Mon,  4 May 2020 13:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uu1gRiiX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgEDNba (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 09:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728129AbgEDNb3 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 09:31:29 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CB9C061A0F
        for <git@vger.kernel.org>; Mon,  4 May 2020 06:31:29 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i10so20916919wrv.10
        for <git@vger.kernel.org>; Mon, 04 May 2020 06:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aeSBgPiwecB74eIEA2su9V/0DIgEGdltBHIMD4/NCQA=;
        b=Uu1gRiiXgGw9kPT3m5M12Mk2KaSVifov0/dxvd13kzmI1Wdc+Kmt14DxI0NwesBpR8
         m3ooZWdAIBBFmDUCe4zk0tllGotShe8aeBfycTEK22YlxAvsQ2LkkhkK8K9QAE0VC+fV
         Q3ZHMejPE2aHB712aPv1dTA9tR0bXlqjia/vebV3ZxCS0JSLrv1JRoNE/dslK1gLZ1mM
         M7OSYolskVGQepR4gI/QrvMz5ROI62gysvWHh/MXTQSoRsB4g3FAd2WvsXb7aLFGLCN8
         Znx6kN+YY0XaRsfWdQ5l1u7nqZcG/hIOW9vFxyAArbSonG9/G0QWlnNfzhxNHnkn7bzD
         tfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aeSBgPiwecB74eIEA2su9V/0DIgEGdltBHIMD4/NCQA=;
        b=DTJFzIHJxIof2dFwCui/deCiwYYhWdoa7pp5ySk4ijJg9auoH3wo7VPG5lk/UZ/rVl
         DWnbd4J+NVNUbLzh8sH2yYI8LQdnkAqS29Q9IqDC8KAVuGD/ads2VecgyWRSsBMkA39W
         BQHzUry07hXF9uVmYinC8vP5IfUAFirFmJdi+jvhJtcVUTtI78+T9/lzvNBqqsq1HL36
         LWTi36o5dNvEPyPg1brAyvqZHQe+lZVblGjPKg2+yuPJwHPxzPuB6ljtFeCDSVD1X0aT
         N4No55gR2eZXbj//qSh2wJLNpykmUfhkAhAINmGuh1EVSr6WC3bndfvjHUsUyS6AYhx7
         13AA==
X-Gm-Message-State: AGi0PubI7VGeYAnSxY7Q+qrWugZS/S7dVHFcTULC661mBpwML7lJkGV3
        fmJvMvds4OFgNWP3Bh1iwXdJ+YGd
X-Google-Smtp-Source: APiQypLsBeOKC+iz+/pQqiEfVTGt8PTPQD4h78KYscNy4GatxDYY9+uqikM0mQtzxxff8NKiNpmVvQ==
X-Received: by 2002:adf:fe51:: with SMTP id m17mr18815326wrs.414.1588599088012;
        Mon, 04 May 2020 06:31:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q4sm12505706wrx.9.2020.05.04.06.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 06:31:27 -0700 (PDT)
Message-Id: <a11d1cd304153718363f18c33d1ae87f38b3fb21.1588599086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.623.git.1588599086.gitgitgadget@gmail.com>
References: <pull.623.git.1588599086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 May 2020 13:31:21 +0000
Subject: [PATCH 1/6] fixup! Add reftable library
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Close files before trying to unlink them. This is actually required on
Windows.

Note: this is probably not the only part of the code that requires this
type of fix, but it seems to be enough to let the _current_ version of
t0031 pass.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 reftable/stack.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/reftable/stack.c b/reftable/stack.c
index e7b625d924a..2e32f7671c2 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -852,6 +852,10 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 		}
 	}
 
+	if (lock_file_fd > 0) {
+		close(lock_file_fd);
+		lock_file_fd = 0;
+	}
 	err = unlink(slice_as_string(&lock_file_name));
 	if (err < 0) {
 		goto exit;
-- 
gitgitgadget

