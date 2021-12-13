Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03398C4332F
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 16:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbhLMQB4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 11:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbhLMQBy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 11:01:54 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAB5C06173F
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:01:53 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id k9so10078942wrd.2
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4caTpC3+u83vTS7zkUHAtzr+4yoHPBYES+caC91RmF4=;
        b=at/6TLSrElkgJ3c4nZQZs7vltdFbQ7kQ6prWLqAT9GH7BZzLUEE2SQG9r0dq3/GpLU
         v7pFi/MLeBCQ+Y+klAxSjCiPWz8g/Wf4HixP9Ie65LnYN6dl6G0DzwA8CdY6cl8PMGDi
         m7cwT1GQNecrWbEYsCYwtHdMm1kxuLBDCtBBUrFVOSVtbLEJt7aIFhYsJwZ/+gePJCsu
         wKtQRsNlpDhLfpo7ILqen34OjOANCa1o5GCjrxBWQRIORKwXS7y5WxR4Qh5FIShzF2/k
         I2zx65LcSzBIxkWd0jf2yolpXzSTepeHQ2JZbQsjtusD4Gdfifm//NDX32Bo7H5J37OG
         9EfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4caTpC3+u83vTS7zkUHAtzr+4yoHPBYES+caC91RmF4=;
        b=vqDXhjgU1QRYaS0UzrCqvsgXM8zr6Thv0A0BA1EEoXjHqdFm+1Z/vCwHx6TKhimQ2Q
         CHNweCD7Fr8Sjw4ehzgTJEpOrrb6+wISEA06VCM8PMxUge4yOQQM/o07sZ6L3GzFdsZb
         xsB5K3FAd0kZA+pDAGWZw1JmTLfOtVg5DeJPDN1SEBA8BNzb+pGGLMx2ngwK7R6DC/1Y
         HeEUidmJmj8NPciMFiN7wGp4nyfny5Eg+6q/NxbL7Kijh8ChVs5dX4ecJTqR3TB8tRSP
         IkLvxjC0ZBjuU4Z+kRzDvMChGE8rT0AFwb9luQ66Vd8h26ugcPfIDwJ1Ky3MjXJiKY63
         BLYg==
X-Gm-Message-State: AOAM533zbr01Ia7h4euWdfAvJHp5JALoRG5feVAeTwY5hpfXv0UPYKsr
        5pBAqXXJYMnHgsV6yvLT5Q/qR4G3lIQ=
X-Google-Smtp-Source: ABdhPJzBJOpUqibdjPtvmPMO8uXOZ2UrRdn1gUhIqkyTUHcykKY1UT9QUulrYhp4MkdmIZckDMNk2g==
X-Received: by 2002:a05:6000:1568:: with SMTP id 8mr11698403wrz.79.1639411312329;
        Mon, 13 Dec 2021 08:01:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg12sm9080072wmb.5.2021.12.13.08.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:01:51 -0800 (PST)
Message-Id: <1c1a3ff92bd24f7c588ce480983cecb3508a0add.1639411309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
References: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
        <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Dec 2021 16:01:39 +0000
Subject: [PATCH v3 01/11] reftable: fix OOB stack write in print functions
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

