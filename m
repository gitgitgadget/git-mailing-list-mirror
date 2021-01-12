Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392B1C433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 15:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 089B923134
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 15:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391244AbhALPcS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 10:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729960AbhALPcR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 10:32:17 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91F5C061794
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 07:31:36 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id y23so2496783wmi.1
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 07:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dC0KoIHQvhm8J47Vm0IzlYw1O+q7nQGRN86/FlomuAg=;
        b=u40BtLExshAXL0ksnIm7tJxlC5hGgob1bERjZVyms0VB3pFUhU4TU/tvziiV1AKBK0
         OhxdejW5X23wXL+F7CgdO6CspxIvrpcjdEc3rnO6kDiFNv4de77jR35hmGMcs1RJ1H5l
         XqUhqLtVaWNucVnynp2sOw3Ac2hmBEBfopXvzsnWt97Sz6+imxCbC8qNaUM6O6pSUW3J
         yhTDhperZTrNTjxHXZ52bX2pvg0MNpwLmiv3APuW6Cr96jmjr2hfUJQWU46JXNg3GtC6
         wgNK/u0PovJX1tal0G6MVJWhQ8CqRMA0AgoT4G3B1XjUWimHXqF7ccCq1ylDK9v/FkKk
         XNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dC0KoIHQvhm8J47Vm0IzlYw1O+q7nQGRN86/FlomuAg=;
        b=LSUvr0r6beZnuXO60RCgWAWmW6VyvBfXewVlHVtwuFwnZD2B7a9XOtQyjjF8crQYfJ
         KVn1AzBoauCXiXCqeaxOe6joudtcCcNla7ZY3gvkae54rDFlyH8wmNfv83Cm+BvdI4gd
         EHgvfH0P7rCnsJ/fcOtxgvxALGE0PJDbKXereqbR6mJUuRL5RdmYtWDYLWq1rsHlEjdt
         gqYVwp61il7hF6zhYg+xAFOZgsuyklJZqQaJI8c9SgKcXKrO5Uj5paCrBoR4VTaC1lkh
         DjYHksaKSmYtesIKTdB+/jII7pKi09iKssDas1D81A6Slpq9lWaAL6onAI0jRfVczdb7
         ekGw==
X-Gm-Message-State: AOAM533k6prtdqSnxroOFCxQydSqflTmJPy4OSSjD0sYy8cV1fE9xAk4
        GAnZXwK3+3SxcvjelMwFmYNIsFOdELY=
X-Google-Smtp-Source: ABdhPJx589bdHr+aVd8EMOi5cPLvn14s8VMMp2b8tpZ3VDm6M49YA4NhyMyvTYmJ2tOuBNTF3RXe2A==
X-Received: by 2002:a1c:7c09:: with SMTP id x9mr4147650wmc.98.1610465495384;
        Tue, 12 Jan 2021 07:31:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8sm5613178wru.50.2021.01.12.07.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 07:31:34 -0800 (PST)
Message-Id: <1155a45cf64afb237204429cd4ff2e74f5f7602a.1610465492.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.git.1610465492.gitgitgadget@gmail.com>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jan 2021 15:31:23 +0000
Subject: [PATCH 01/10] pkt-line: use stack rather than static buffer in
 packet_write_gently()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach packet_write_gently() to use a stack buffer rather than a static
buffer when composing the packet line message.  This helps get us ready
for threaded operations.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 pkt-line.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pkt-line.c b/pkt-line.c
index d633005ef74..98439a2fed0 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -196,7 +196,7 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...)
 
 static int packet_write_gently(const int fd_out, const char *buf, size_t size)
 {
-	static char packet_write_buffer[LARGE_PACKET_MAX];
+	char packet_write_buffer[LARGE_PACKET_MAX];
 	size_t packet_size;
 
 	if (size > sizeof(packet_write_buffer) - 4)
-- 
gitgitgadget

