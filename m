Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEEAC433FE
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 15:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346176AbiATPMT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 10:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiATPMS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 10:12:18 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC6FC061574
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:12:18 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so14599637wme.0
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4caTpC3+u83vTS7zkUHAtzr+4yoHPBYES+caC91RmF4=;
        b=ih9NAlm1rMb0Vzhh4c4q0PUQamAlV3ZmTzG7KjxsaA0ExXF8oiiug4aYKqFteMgW2r
         YVEngFAqltY2XO1qflfkMnEkmj+z8IMJjxc6XxzavrNQYF8ws0spTBkrM76Va+r0hOFO
         qmuaJgC2KcRA7Q9ido3ggC2Tmug5F7GasiZUvkcQbXQ6Y1bx/4nuDzjeLzyJ4pjDrouF
         G/Sr8aaoJ43qwsoXqttm2FTcWlSdifMgH+UV5jnoJJ1lbEiNuy0hJS8AT6eQBPUrWm1u
         jx7/bKWFqIYwe05wwRfce7a7f/E47WTmFA619bjdPJyhVE//J28SI+4eLvgSvPYCXaW1
         Tfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4caTpC3+u83vTS7zkUHAtzr+4yoHPBYES+caC91RmF4=;
        b=schZHj5ExFUESP08EF2GT9BEn5UH6TeXxZTzXa+GKnEhoOToBl3Cg809YjFEZOx8QC
         z7+1mKEB9uhlNYLRHdjUwyGuCQvO4wR7I4wnECX02d4QsEPhFVBRQWCyAjQfUgImgoge
         KRvfvD4v9ySPfdJg+Yv1IqO41piVXpFYnJcql17lXtDTCp/oESY9ynUJGCcnHpRzgLwF
         Wgy05gVZBKRqNfIepZckm8iCLgWKw3RAPJdcX/zBGDl0+H7SxE+E9CT1cAYdu7B7wk3G
         n06on8F3zT/jXVaISvs0g1eO9g/28rkeqUgp4dDTKTquxyPCs7zlKWj6eTc/vil2Cf+t
         QFQA==
X-Gm-Message-State: AOAM5303sMJ7mUc7+rPPwthoR/Ux1YPuTmdFJBXs29WFi3E7MmgohMhN
        7ubC6xFt0UBGpevUQzKMSu0YhBl4AJY=
X-Google-Smtp-Source: ABdhPJzK6kwfaRb/jPCRS1J9i6PAXQ8aZhvSn26tAvSsh4NDB1ykUJe+thiy1l3p3tYBqDy096a2bA==
X-Received: by 2002:a5d:6d8b:: with SMTP id l11mr24842072wrs.234.1642691536752;
        Thu, 20 Jan 2022 07:12:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t5sm2933428wrw.92.2022.01.20.07.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 07:12:16 -0800 (PST)
Message-Id: <9218bd59b2570ab08f3a2e5c0b590656d00482c4.1642691534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
References: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
        <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Jan 2022 15:12:00 +0000
Subject: [PATCH v6 01/15] reftable: fix OOB stack write in print functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
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

