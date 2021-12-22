Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2921C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 18:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344947AbhLVS4k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 13:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344925AbhLVS4j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 13:56:39 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575D2C06173F
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:56:39 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id e5so1815949wmq.1
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4caTpC3+u83vTS7zkUHAtzr+4yoHPBYES+caC91RmF4=;
        b=lCux+Z1kzOm6YqFTPAy10jS1g4vd6/lZlHiy7y6MBc/KuNcOyrvlZ6ruqEFzCDAqT9
         VSA+pC0sNnVD1u6JyP0NZNK5NUmoDZ4qqrhTToCkXD7xu12Ew/qghffvLsUvaCTrem0h
         v0COfvWG7rmcn7+83Twxc4grpJQ/Qb2sbV9vpAxUGmTxcVe6mNRc0WuSR72ktPyWva7X
         eVdN6qt9gnZ5fovz23g57hDVvw35C0yskv27PuLMYI7IKAYFyOPKduTtrMqYsCeeyc+O
         /KwyHDAr07P2avNZxnw65Eprw0pxTp2Bh5EE3uigMazEgNnWYoyVaeLb7bvGS2fIExvZ
         B37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4caTpC3+u83vTS7zkUHAtzr+4yoHPBYES+caC91RmF4=;
        b=Vm0kUjOMZWnT2yBLIv4uZ8UrCe0nUWTZqT4XhkaCjUQELUV+z7j9wUMQFG2fDP+gF2
         uGMH7sbm16xghYySe+WJrXFYWn5ezPTca+eJSOUdWZ4jh5ylCu6wyuk2TMcJaEEhIusL
         6lGr80vL6Ynq4Nl1H+WjN7bMttO+PsXKExnigMTsnBAKzf0xIsahQLZAAk7jHOZvgwCc
         bLRJJUujHca3L3Fsiz+w2UjwN1rkywBqAzzgN0aiUvLE+FMippNK/JRTIF9V0OBvZeLI
         VV4mTNvyxU2ybMbI+Y5fAoASpSX47kYyGQ0xFZjS3mLPbjerIjt3HyVqlc+FBxbsttX5
         VZlA==
X-Gm-Message-State: AOAM533QNsKo+qONgQrys5foHQlGMmS5RJ05+lu/XR1t+c7bw7vucRL8
        Rrkmshc7va/URZry0taHGs6x1jc/WYg=
X-Google-Smtp-Source: ABdhPJyoaBU921E/udNconIqyWPSa05rok4Y8oelZ6s7gDM+Zc+yOmqKEIsPGZBu4jmsNL2uv0G+zw==
X-Received: by 2002:a7b:cb51:: with SMTP id v17mr1794412wmj.185.1640199397817;
        Wed, 22 Dec 2021 10:56:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w25sm5804672wmk.20.2021.12.22.10.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:56:37 -0800 (PST)
Message-Id: <e7f1be7bbec0427d5c10453631c3486936ed2bf0.1640199396.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
        <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 18:56:21 +0000
Subject: [PATCH v5 01/16] reftable: fix OOB stack write in print functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
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

