Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C92BC433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 11:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbhLNLsS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 06:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbhLNLsE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 06:48:04 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02792C061574
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 03:48:04 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id y196so14020148wmc.3
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 03:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HOTpe9FNENotMYcACPCrU+33ZDetlyOQNtsGAWihsVI=;
        b=eCBQdLRx6Stfhrh5bZub6RjrrWnYoOuSuNaeBW1z7EnV1NkSmDCZkcGpTNf+NXM0Je
         hMrwp0YtYIcjVEg1N+BUbY3e1t3ii1in5NCRza8RZSGYZpYHvZAGAhEVgL+a6/tTT1YT
         y3yAADs2VJdDM+gyZnSPcwygdiMqjAjDfH/tGEQS8CbIwmPwoQliwOwsOyt1B/EvUvln
         1B1JaqJtg9IVlrxOcZ09HMlwuJVJh2VDV0M7nibnmDu1roX4M61A1sh77Hr6In7xtuH4
         7P72L3jqYC5NTP3VRlfakqQRbOPEZWyOyUgnnb65NPQE7PYLffDVAl44c099YncWJOJK
         RzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HOTpe9FNENotMYcACPCrU+33ZDetlyOQNtsGAWihsVI=;
        b=7ekgmBxpiA45NceP0mTWhI+ur5h2+p/+rjOGS8SgXlGu+N+9h5/qmNOZcz8DaWVpSR
         w6nCU1cFsb4GJf1cRqlAGoVshOLupCaCxA3zLMp8bj6OAbcaFCsQP40THLFiINkL9j4V
         sbdSEhmT+BU+SrsBW0SWJwW5RNV/Jz48Aq+kKiDWS6NFsdIz7j/5uUXECfS7wLvCqmnx
         /uSN4OjKvy6T2+ciLMtsg9oPM3Sx+dgWym2N6/ElhPOx017djuLSYnXoEhfx4eFnL46m
         mHMiH8oeBtyrZGPSzgEdNVys2b8Hnp8YkNH2prjPh3WdH/oPR12fFREWq5sDe01s5cYa
         rOHQ==
X-Gm-Message-State: AOAM5306QOtUnTcjcG5mcFVLhWVzjjf8BvLKRzODzusRoJuu2s/Oxhaf
        kOL6n6rS+5Cq+6nI9X0ZNc0Uc8Q5JIY=
X-Google-Smtp-Source: ABdhPJy+9KPcUm9PIJpcLRkVjhQF9PJKFlrKbztuuGJUtJtCk38zpfpXFuOYy66PFxjcNFvT/h13rw==
X-Received: by 2002:a05:600c:8a7:: with SMTP id l39mr3073797wmp.138.1639482482426;
        Tue, 14 Dec 2021 03:48:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w8sm11157161wre.106.2021.12.14.03.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 03:48:01 -0800 (PST)
Message-Id: <1c7f15d811c4a73f1fd7b24de52fcd1869126982.1639482477.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
References: <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
        <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Dec 2021 11:47:51 +0000
Subject: [PATCH v4 06/11] reftable: fix resource warning
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

This would trigger in the unlikely event that we are compacting, and the next
available file handle is 0.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/stack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index df5021ebf08..10dfd370e8e 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -877,7 +877,7 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 	struct strbuf new_table_path = STRBUF_INIT;
 	int err = 0;
 	int have_lock = 0;
-	int lock_file_fd = 0;
+	int lock_file_fd = -1;
 	int compact_count = last - first + 1;
 	char **listp = NULL;
 	char **delete_on_success =
@@ -911,7 +911,7 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 	}
 	/* Don't want to write to the lock for now.  */
 	close(lock_file_fd);
-	lock_file_fd = 0;
+	lock_file_fd = -1;
 
 	have_lock = 1;
 	err = stack_uptodate(st);
@@ -932,7 +932,7 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 
 		sublock_file_fd = open(subtab_lock.buf,
 				       O_EXCL | O_CREAT | O_WRONLY, 0644);
-		if (sublock_file_fd > 0) {
+		if (sublock_file_fd >= 0) {
 			close(sublock_file_fd);
 		} else if (sublock_file_fd < 0) {
 			if (errno == EEXIST) {
@@ -1013,7 +1013,7 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 		goto done;
 	}
 	err = close(lock_file_fd);
-	lock_file_fd = 0;
+	lock_file_fd = -1;
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
 		unlink(new_table_path.buf);
@@ -1050,9 +1050,9 @@ done:
 		listp++;
 	}
 	free_names(subtable_locks);
-	if (lock_file_fd > 0) {
+	if (lock_file_fd >= 0) {
 		close(lock_file_fd);
-		lock_file_fd = 0;
+		lock_file_fd = -1;
 	}
 	if (have_lock) {
 		unlink(lock_file_name.buf);
-- 
gitgitgadget

