Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686CFC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 12:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F77D61076
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 12:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240663AbhHZMXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 08:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242524AbhHZMXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 08:23:16 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAB8C0613D9
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 05:22:29 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h13so4793778wrp.1
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 05:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ykrDvlTosMAM0/o9ae8k+S+F6gOG7Zpz4IBbaGqbQ30=;
        b=jk7ZMh0faR2mwoTXQ4uJjMSW1vaWr7iyYPPSvvvyQW8Fxe7XIwKzfGzryncb/1eFlP
         hNx1Zb8j40Ww7J9miAdtSLCMP1u3CIdK1Ey6NrXhClpjU80NfyoS4al3tcSfOg6KUXh7
         8PxbpzlnxNn4iKZwEgz1psr4LMpDFISEbaGk5d4wg07vfqAqc4+nDhKMVhqQL2YPGE2I
         TaK1aywXDKOCiBltrrxWoIu49DD0/zvY4VcaCCvTy7DfW7GyAszdrW0129g3E27BSdR1
         86zFAEEHg7LprWWWRLLyE/5i6LlU2Dn5r6VyfIDJfX500rX8k9BUx313QprOr5yO1pXq
         N7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ykrDvlTosMAM0/o9ae8k+S+F6gOG7Zpz4IBbaGqbQ30=;
        b=RAbPHjG0RFqN8sZYNeL9YMnQYpbOVWcsY7A3wuk2Lpo7fGHt77wjboq/FAopTnW9Py
         YYL2BCFqPgyPg4xj9Iadqum4lLIwLnci7AWGQ4rvX/nd2hccrzkhcikicb86fMAQ2Cvq
         6ny9pM5Ek0ntv1DL9o/OULbOguYx1ooqun2qtDawDuY8AbmL6CYDxIcSAh1ckgIp6pq7
         FLMCnQI76ClZ1nz1wllZwt2nNOnflMSN5ZEsPvFiG7C7397Cp35g1XzLtJqeO+/M9X9h
         W/KcuqtXrrhZ4g44GVQLKwEMrUJJBY8KrRNnXtGAZe8KXyYSDGu9PeN152htoYWtMzyr
         pK7g==
X-Gm-Message-State: AOAM530kenN3kuKZNJ3HUvMOJ2YLZo1ffs76ST8EYg7nRyTx6EhNz9sh
        VvHwzJ40dhFibK32clz8hWGgDnXec4FQlg==
X-Google-Smtp-Source: ABdhPJz9JuKm9Cf/qCBJEwTPJA3rLWEwZXHb7Ujgf0XfxgeRDpzLviur9BXQXvhrafYXZLH1WnsYuw==
X-Received: by 2002:a5d:4142:: with SMTP id c2mr3711198wrq.340.1629980547800;
        Thu, 26 Aug 2021 05:22:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z17sm2969885wrr.66.2021.08.26.05.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 05:22:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/6] tr2: remove NEEDSWORK comment for "non-procfs" implementations
Date:   Thu, 26 Aug 2021 14:22:19 +0200
Message-Id: <patch-v2-1.6-8c649ce3b49-20210826T121820Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.733.ga72a4f1c2e1
In-Reply-To: <cover-v2-0.6-00000000000-20210826T121820Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210825T231400Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20210826T121820Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm fairly sure that there is no way on Linux to inspect the process
tree without using procfs, any tool such as ps(1), top(1) etc. that
shows this sort of information ultimately looks the information up in
procfs.

So let's remove this comment added in 2f732bf15e6 (tr2: log parent
process name, 2021-07-21), it's setting us up for an impossible task.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 compat/linux/procinfo.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/compat/linux/procinfo.c b/compat/linux/procinfo.c
index 578fed4cd31..15a89676c7a 100644
--- a/compat/linux/procinfo.c
+++ b/compat/linux/procinfo.c
@@ -25,7 +25,6 @@ static void get_ancestry_names(struct strvec *names)
 	}
 
 	return;
-	/* NEEDSWORK: add non-procfs-linux implementations here */
 }
 
 void trace2_collect_process_info(enum trace2_process_info_reason reason)
-- 
2.33.0.733.ga72a4f1c2e1

