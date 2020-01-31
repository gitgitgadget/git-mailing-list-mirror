Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E1EC35240
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDAE214D8
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEPZ8xeF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgAaUQ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:16:26 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37194 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgAaUQW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 15:16:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so10156854wru.4
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 12:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pl9kK0IVJdtZMHXu52/f8Sm0g3stqkcV9VxPh4NkuJo=;
        b=EEPZ8xeFyYou1KWb/VFQ2u2oo5MFcbwAoPvHKBT33WqtQ5mN7t8eaX6J9Xgt9+WULU
         jZhXA0Mte2zKqxOobG2IqvfLpXR0ruCsRuVwxMULh1svWPK8dRSOZ9hUTkPZXAgN4QX+
         0jL3RUWYa0QWwfBtJC8pt3w2VC76EYjcoqFWOv56C/hPYraazwkxUNf9kJK1Xjr8Ljy7
         4KcFCu29EO0IC5FXTaCEuud6jP5cIrEFXiWzRwTjNq/P5qFN8GDr4gl65uFfXRWLyJx1
         NITXadUWRm0WgtxQOqf0T7abevCzFV00xAKQOiMKdeUIW1ji2XbYMAuTyGNgT8ZMpf1I
         psoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pl9kK0IVJdtZMHXu52/f8Sm0g3stqkcV9VxPh4NkuJo=;
        b=QMLRr3KipTPf24E+X4WtFBjU/KZpAhy0Be2N4agIRyqfRBYfQ8NJyx574DMjephUCj
         Pb9tQ17ncrTTa0CJzlS6WKrlKVlfT3A/4KoYm6PU8eIRY4k8eLMhjE9Y/AoMvWKuWtDx
         VE5Wu9V0tE4kcfBdd/Hcke5miQq8w3tcxk3aGE5pg+4MKjraTn19u+JOsRZV5FzutnbB
         NscVwS7udatU3v9GsLOonBFUmydbL1eiI0vMA1gDeh3L4AvkAoq86uADMPqqlnkzVQ7x
         ScUV28AyZDp2VeF3BVoYPzqV/sQIPF1QR3Xutb0pdTFNMPrf8ck7I3F5q89fr/+0/S41
         Ptpg==
X-Gm-Message-State: APjAAAWQl8al2RhBA5rmkYzW0uaRYZkp9pg4KFFwfeQreUn2RR77S/xP
        Pnj+O576ytGaIt8VWW8C/U3g0/Gq
X-Google-Smtp-Source: APXvYqxFekZlbH4BRvyGXGtCCBl8KkZuPRsIusEjDc/DGaEpI6ijWLWq6uLW0AjDJg6NAeZGAqJhQg==
X-Received: by 2002:a5d:6b82:: with SMTP id n2mr136028wrx.153.1580501780131;
        Fri, 31 Jan 2020 12:16:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w20sm12141555wmk.34.2020.01.31.12.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 12:16:19 -0800 (PST)
Message-Id: <ae78c3069b08557e3acc544601c71ee932ace19d.1580501775.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
References: <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
        <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
From:   "Jeff King via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jan 2020 20:16:05 +0000
Subject: [PATCH v4 05/15] sparse-checkout: fix documentation typo for
 core.sparseCheckoutCone
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-sparse-checkout.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 3b341cf0fc..4834fb434d 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -106,7 +106,7 @@ The full pattern set allows for arbitrary pattern matches and complicated
 inclusion/exclusion rules. These can result in O(N*M) pattern matches when
 updating the index, where N is the number of patterns and M is the number
 of paths in the index. To combat this performance issue, a more restricted
-pattern set is allowed when `core.spareCheckoutCone` is enabled.
+pattern set is allowed when `core.sparseCheckoutCone` is enabled.
 
 The accepted patterns in the cone pattern set are:
 
-- 
gitgitgadget

