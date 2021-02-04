Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F41C433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 21:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 659F464FA7
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 21:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhBDVHN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 16:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhBDVG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 16:06:56 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33C9C06178B
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 13:06:15 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id 7so5277244wrz.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 13:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LDnOFW7p/ky7+KVyj8lT1tPoESnNZ9bzBGmd+kLhGR4=;
        b=clMWBvHxP8PByXcof+P2od5q2Hkt17niVHDbTESnbNMu0dGjrasGB9L6zMffp50Evv
         1tUQGBciDqsvPuVtm+8Ay/gGRruPmPfKPwfQupWeg/6QcTNdH3hAVJvv9IQ/P0YiRDfj
         mjNwaMoaBDYmeYOjkJAkaFjEaHcddq8YjU2Gno0bNcgXxLrOioOLQ2ccoPAVcNBKDBI8
         Kx+yttXifQV7n7a7bwwOLzFy7qlJXo5dgpQE49N6iiVnFCAW86pvaa14+OTF0oIh5Thg
         j+E0A1GRz49DMZTmpalsEJUtwc/y9MqrWnzq/EAh3Mzj4WIR9/09bykfux7CjVgjJ6w9
         E7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LDnOFW7p/ky7+KVyj8lT1tPoESnNZ9bzBGmd+kLhGR4=;
        b=KWYeMQaeCNjznb0y3dl8IfmshH8bNerVtCXznxqfMaTG0FriHmCAfVUpTU/K1+9EJo
         trx+s0yP/x86yGAyXnlRgh9Ubh2lsGz4olX830i4UK52j7FPozpJ97Fc4eiMTLs9oASM
         fWEujcpwszi+KAvrDbpDt+n8AjQ9xJFgyk+K4yKdOYJJZoVDUosTwQyBkZC+xCZlBaS2
         xsdBL5r3x8VfGmToUe6llGKuoXOkxJEkptXDFShr8IkdvhWT1MEZjTXfhDPxTbnnz7On
         AJJyFw3LBsGxJKY+DXyuKIKNyQ7aJXHLiTM4eWi2TvWnrU31oic07WybXEEG6dshBOWU
         a4Kw==
X-Gm-Message-State: AOAM531JKadlqsx1aEp35GQ/jgSVcjfzS8gXHaWQPCPgkZzaZzZ9hTju
        NBNpS/9dieb0XL7xb1UEVRdkwRRxZ4SNlQ==
X-Google-Smtp-Source: ABdhPJyLhkIi5XT0SdRbvhK1BETT/cGi5H3j+phCzMf3x8kCZFfWB2foxg9q13tFdK7GUz/5jxqK2A==
X-Received: by 2002:a5d:690b:: with SMTP id t11mr1371640wru.12.1612472774351;
        Thu, 04 Feb 2021 13:06:14 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n5sm6779318wmq.7.2021.02.04.13.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 13:06:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/10] grep/pcre2: prepare to add debugging to pcre2_malloc()
Date:   Thu,  4 Feb 2021 22:05:50 +0100
Message-Id: <20210204210556.25242-5-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <191d3a2280232ff98964fd42bfe0bc85ee3708f5.1571227824.git.gitgitgadget@gmail.com>
References: <191d3a2280232ff98964fd42bfe0bc85ee3708f5.1571227824.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change pcre2_malloc() in a way that'll make it easier for a debugging
fprintf() to spew out the allocated pointer. This doesn't introduce
any functional change, it just makes a subsequent commit's diff easier
to read. Changes code added in 513f2b0bbd4 (grep: make PCRE2 aware of
custom allocator, 2019-10-16).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index b9adcd83e7..f96d86c929 100644
--- a/grep.c
+++ b/grep.c
@@ -45,7 +45,8 @@ static pcre2_general_context *pcre2_global_context;
 
 static void *pcre2_malloc(PCRE2_SIZE size, MAYBE_UNUSED void *memory_data)
 {
-	return malloc(size);
+	void *pointer = malloc(size);
+	return pointer;
 }
 
 static void pcre2_free(void *pointer, MAYBE_UNUSED void *memory_data)
-- 
2.30.0.284.gd98b1dd5eaa7

