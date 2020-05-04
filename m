Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7967BC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 13:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5999B2078C
	for <git@archiver.kernel.org>; Mon,  4 May 2020 13:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrmCaqpm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgEDNbi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 09:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728425AbgEDNbc (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 09:31:32 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6076DC061A10
        for <git@vger.kernel.org>; Mon,  4 May 2020 06:31:32 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id h4so8463881wmb.4
        for <git@vger.kernel.org>; Mon, 04 May 2020 06:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=21bNQwZFoud3OvpB7fEuY//SE9GjjgzN5iPbXAGVMt0=;
        b=GrmCaqpm8cO/wiOAqXRegwYfwf5/V4jB1XK9qNDU/8TRRgdcoGn32L5ispmVLR5SxF
         OexosNV6Vex6YllEeyJSm7uF+Gu3XWGhkEsa68wAStgaOiIZozdAOAaqXEt7smegGhRD
         Vksh2cBrQCD0DsZ9bpKGBUDeaPhGu9M4MsceJpB2ybop+n/WzE6vmyU4tZTwrYDIe3je
         hDWK+7GJ7UevW98mHx/Fc/rh2wFv375obIUjYfKaUhNJev5/QLTB0iJHWNt4+RL7teTY
         x3UPsEwgaL6mTE8px+pzJctUsYISdDCeNZxt9DPN/bn1D+bXNcuW7n2IeUoG4Ldctvkw
         fKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=21bNQwZFoud3OvpB7fEuY//SE9GjjgzN5iPbXAGVMt0=;
        b=HkK2rr7v1RpRbISBdbVhOjLQ7VYgqEu6RqioucpYtl/OxJl4DXHoFYGAOxYomvuUnw
         tFaAXWFm+K2yjDzCfqCmLmZ09giUd1WFKi6t7FS0lgL42t3UeGK36/q38xUqfdTaAlvq
         G4W96RMfC5tfGf/4QqPy/x8yRCY7uMmhtNDa8lTulBIldRFwcmwVEnjOfzMYDzwIjTSd
         KE12rL5b87l1mroDqsluwzmPqDc7g3rYRYwuE5tAF9Ix9sDIDHywcQh7DKVju2HirE4K
         xE3xdenLwvggB8f+UGKc0MrUIHU0j2kM3dYh+2e3XIF9iZTHb6Yb4sdbEGqF1Ju8408K
         wgVw==
X-Gm-Message-State: AGi0PuZvNu1YbPx06HYxbIDxvvZdGWxifNgdIXeLmbe7ix3iJeQdaN4Y
        LuM7J6GRz6XHksLUNmGWc9F/q8yM
X-Google-Smtp-Source: APiQypK9ojsrExOWf3qu0tZ5tkI/c1g/yLm3xi06z8+KgyhuK7gHcbRmTSRzUGgQJP37gnfGluVgkQ==
X-Received: by 2002:a1c:4603:: with SMTP id t3mr14517492wma.103.1588599091053;
        Mon, 04 May 2020 06:31:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i13sm18279130wro.50.2020.05.04.06.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 06:31:30 -0700 (PDT)
Message-Id: <36616471d4afea57ca90825389e896e6c71013e2.1588599086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.623.git.1588599086.gitgitgadget@gmail.com>
References: <pull.623.git.1588599086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 May 2020 13:31:25 +0000
Subject: [PATCH 5/6] fixup! Add reftable library
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

Yet another instance of `= {}` initialization.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 reftable/stack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 2d0b831dda1..2f3dfd51861 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -19,7 +19,7 @@ int reftable_new_stack(struct reftable_stack **dest, const char *dir,
 {
 	struct reftable_stack *p =
 		reftable_calloc(sizeof(struct reftable_stack));
-	struct slice list_file_name = {};
+	struct slice list_file_name = { 0 };
 	int err = 0;
 
 	if (config.hash_id == 0) {
@@ -417,7 +417,7 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
 void reftable_addition_close(struct reftable_addition *add)
 {
 	int i = 0;
-	struct slice nm = {};
+	struct slice nm = { 0 };
 	for (i = 0; i < add->new_tables_len; i++) {
 		slice_set_string(&nm, add->stack->list_file);
 		slice_append_string(&nm, "/");
-- 
gitgitgadget

