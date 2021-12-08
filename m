Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC6CC433FE
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 21:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240582AbhLHVxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 16:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240358AbhLHVxk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 16:53:40 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829D3C0698C8
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 13:49:58 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d9so6471310wrw.4
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 13:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IY/CPJQ0Q+sLVf7jURIMds3wahY4HaQuVDcXfMmDpdE=;
        b=fkxddrRnYKSqvAFy0bHm04B90J6lUIXARzrshRRCarAxljnBeDPf58EavcXgjkhO70
         GnO1uRLznLCkQc8q79joT8dfF2v0JC5auNHZ9kD+TbfLPQTiwh5SBqQ9yaQAdmN7ItT4
         R3YrChh+gWI7P/S2/npxmPBuxvk9cfHalCBgSBjxBkyO2tbxmy3gL7PMOIoZBqv+xTC9
         YkctGwTsVVBOPsPhzJmid87kQGl3bRcZgExJwPTserXTJuoyfnwoD1BZwrErnnY8cq1P
         I6bwjULSLSYn41QJGM/6BqJm/gDIYPzvkzeREWjm0lT3mkaIpKclS87EFbpvCh/E9APY
         faWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IY/CPJQ0Q+sLVf7jURIMds3wahY4HaQuVDcXfMmDpdE=;
        b=onmKmcqWoBUTrnG/o/kd4krITpGHH0knM5uGMn99hGH+Y2WBGoG1SzUq8tj1Uaa+WF
         AL2dMZz8GdfP+EkBn+DiVlC2MuVC2XTaq9JPrzH6TgL/FNm8HfCzent5vIuGfZzOW+zS
         MKizqEfr9MWhpYMYjfnaRBVXhaVKIUnwj4w1VtCtWJdmioZB8cSmGR6Sj/ShasE+wpjh
         VEEToJOIcxjYfXhOuG+I8G/jciv6fhMRAGmw68F/gI/LUpH4w+vnl+WoZksN+c1zjzSu
         xq4ueIDYzuNTOb0YY8la5Y5J/TngeLb5OJvVyZT+g7uotY0QU+jLVSYsBThsC3mNZar5
         g0nA==
X-Gm-Message-State: AOAM533H9YIC4qmkOg7FOZB2DzK1MhovjeR15oIVJUXuKZVjInhXo2C+
        JSXUB55KHRZNmPQdd8ZjpfMwaGxuRAw=
X-Google-Smtp-Source: ABdhPJzP9Fmq6Wu/28HyA0GLeLoabi/VfS4UGBS9874Ht0NV4BfLxP0lFnnxZtAsGJb3+KjZjvGpSw==
X-Received: by 2002:adf:cc8d:: with SMTP id p13mr1583875wrj.274.1639000196688;
        Wed, 08 Dec 2021 13:49:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p12sm3816586wro.33.2021.12.08.13.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 13:49:56 -0800 (PST)
Message-Id: <a0f83eff19f0e594601c96971f5968fbf4543536.1639000187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
        <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 21:49:45 +0000
Subject: [PATCH v2 10/11] reftable: handle null refnames in
 reftable_ref_record_equal
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

Spotted by Coverity.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/record.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index 8536bd03aa9..8bbcbff1e69 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -1154,9 +1154,11 @@ int reftable_ref_record_equal(struct reftable_ref_record *a,
 			      struct reftable_ref_record *b, int hash_size)
 {
 	assert(hash_size > 0);
-	if (!(0 == strcmp(a->refname, b->refname) &&
-	      a->update_index == b->update_index &&
-	      a->value_type == b->value_type))
+	if (!null_streq(a->refname, b->refname))
+		return 0;
+
+	if (a->update_index != b->update_index ||
+	    a->value_type != b->value_type)
 		return 0;
 
 	switch (a->value_type) {
-- 
gitgitgadget

