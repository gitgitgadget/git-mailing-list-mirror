Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CE1C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 21:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbhLHVxY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 16:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbhLHVxW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 16:53:22 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7746FC0617A1
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 13:49:50 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id t9so6465553wrx.7
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 13:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4caTpC3+u83vTS7zkUHAtzr+4yoHPBYES+caC91RmF4=;
        b=OB+CDOyrxKNWyetGQkSPP8KzYXqK/12B8IKMFPLDCcnHrBMdFnHj2+q97bV1VZ9Ox9
         IXBCYDRsPwBhzArIocnn1q8nw3Zq5HFiw1Fy3Oi7nvg5Bmb7RGb/H/bxg8juY9EPJHoW
         9tye7lKh2N3k70m+2c/O/jE0lhUWHX+yWeWsYmaygH+uDsfEBM1XOKG75NWOZZBsg7rd
         Du1Z4lkVLqRc1ksLjal25TdmajbkCOUxQA52wP+V4Lw2BCE1yk5QuUMlCJF3+2oRW2S4
         F2ew7VbTjdEQ/KoEjO1Guc1wBgtAi3acxILNU+yxDwDpFlklqeg9toP8F/SchNrfU5dT
         qvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4caTpC3+u83vTS7zkUHAtzr+4yoHPBYES+caC91RmF4=;
        b=E5M0BOyfinGgdEXSXcL2tPMXTD53m6XAfQRnEwizcxI0fSi1aNroYeJdyFPtFcvJxl
         26+Sl0461RSl3SiPWQdt2kv599AOSpUcqZFJ8b5P4tNM6gSHx9i+lZAMaEDN308YYuUG
         l+q86BXN1tSRcPPsPSt4RS000ASfvkAD2ffI3DptJQ9T2BdTtvjeH4cF++eIeOYPMJyJ
         si0x7uD0MOpqy0T/F5y98aG3x5KCrp2nBAuI5kMXi1kGqcYDIgDVkjXMJ0UCsuXLoIk5
         H+V3tJacSsh3jtPOlenVpOTxl53VYKOru/E+UNxr6phVsywElplTXPhv775s9lR03G23
         APzw==
X-Gm-Message-State: AOAM533eiKRvZT965dst1v1e/X37zH/e9pHYHMROdRyL+Eo2UtV0/cmL
        tSnOGCN2d2KtWaDrAc8oNcw/NOs4NFM=
X-Google-Smtp-Source: ABdhPJyacIO6Y0Sg4PEG2n0F3MUs6e9SCrZUA8cv7PjYg9oBJlVW7dPNzpSwmoUKJi4VeqTTa9/zNw==
X-Received: by 2002:adf:aa08:: with SMTP id p8mr1538238wrd.572.1639000188964;
        Wed, 08 Dec 2021 13:49:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h27sm7833232wmc.43.2021.12.08.13.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 13:49:48 -0800 (PST)
Message-Id: <7c033815183cc8ad7a76bc2b9456b17041107c2c.1639000187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
        <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 21:49:36 +0000
Subject: [PATCH v2 01/11] reftable: fix OOB stack write in print functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/record.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index 6a5dac32dc6..8536bd03aa9 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -254,7 +254,7 @@ static void hex_format(char *dest, uint8_t *src, int hash_size)
 void reftable_ref_record_print(struct reftable_ref_record *ref,
 			       uint32_t hash_id)
 {
-	char hex[2 * GIT_SHA256_RAWSZ + 1] = { 0 }; /* BUG */
+	char hex[GIT_MAX_HEXSZ + 1] = { 0 }; /* BUG */
 	printf("ref{%s(%" PRIu64 ") ", ref->refname, ref->update_index);
 	switch (ref->value_type) {
 	case REFTABLE_REF_SYMREF:
@@ -586,7 +586,7 @@ static struct reftable_record_vtable reftable_obj_record_vtable = {
 void reftable_log_record_print(struct reftable_log_record *log,
 			       uint32_t hash_id)
 {
-	char hex[GIT_SHA256_RAWSZ + 1] = { 0 };
+	char hex[GIT_MAX_HEXSZ + 1] = { 0 };
 
 	switch (log->value_type) {
 	case REFTABLE_LOG_DELETION:
-- 
gitgitgadget

