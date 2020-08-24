Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE06C433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 21:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1223E20706
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 21:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="TGpLVC7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgHXV16 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 17:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgHXV16 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 17:27:58 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1540C061574
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 14:27:57 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id y185so6848229pfb.3
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 14:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=CGWnVazwejIbLc8Ubq9G2wAUW1yheiYg7z44VNSLw18=;
        b=TGpLVC7JDZ1YUUyUJKA63xvgZzqX60gmbxAYMziJr1b5ofAGibYNCYlO+5lB/eqjDs
         +4z4Lfrhd9UxPie32ClNDhglXtimCczBbEYqyz+XcV2zj4YLiogdVOuJ9Y+VkFN5mGCo
         KJdnNh55yVXoWpd8cnC+zo6xhvTCmwmQelKSCcahKN1b0afs2q04KTGK1mzjUB+rkg05
         GKeStA66vLCRb0FVonoP1AfnBwUQGR3i58c1MI6Floz5D/XnAuS0Eci0l907LOM/T6cI
         iozrBIOzhzc26stry7xmaah8S/OzajdIlstI4eBFPMLANUP8Mq00mRvWypXMOhVxV1WJ
         fk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CGWnVazwejIbLc8Ubq9G2wAUW1yheiYg7z44VNSLw18=;
        b=eY6Ok3kp6VI8QmvysL1Ig2JIBuXCIIzR6WV73PCYK0NO04skoWuBbOZWs/nZsW/pQn
         c0UC8sffsvBz395/RnT6AR7rw3xCeZG3SRmPPDyiALb0OaqqDi2mQrfM76c5OyoOdWzJ
         WZ/p1cq9pjjTi6MOFFGRCgkEuAReQn/4xXdKhmhRaVND1GoNHgGyrvA/Nz5Vddgqotvq
         8MarNJkEh5wYLRBMsSo71hRVb4a6EI8w0Rg8bQzxjN7i93002Ej/tKJAON5nMPO6yccl
         ttUkp//6IgWhD/PoFcKCdjzd2v4mqiKaakKt2iAV2EMGnJJJPFEzqjq9X8tahO0p9S1T
         +pmA==
X-Gm-Message-State: AOAM532omF89QNiUHVGk8xROrT8d8TERJUgJW1PPhijll3zzONXJJffq
        udtPJAJSjEFMPhpSNfSTsV6ZHVMPQ917CWeoTA3ELuPzWE+wNpYk5sR2c9/gkuCn0GIyOb6c1eF
        PhKka74smLUoo1j3czWzX5qSd8X9XTNVJVdNdCZSH4VXlJXTCGMz9NbEgEah6dJ4rJ2d9r0ZTVd
        8L
X-Google-Smtp-Source: ABdhPJyNhyhu7JG+qFuAkST5sNUIiCUq4JFacDD2LUknAtWbBMKBPLQ9wPNHqskLkiSPrDUFZ0aZ9SHYoQ3ddvGyugiv
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:4595:: with SMTP id
 hd21mr142743pjb.0.1598304476775; Mon, 24 Aug 2020 14:27:56 -0700 (PDT)
Date:   Mon, 24 Aug 2020 14:27:51 -0700
In-Reply-To: <cover.1598296530.git.jonathantanmy@google.com>
Message-Id: <20200824212751.3907181-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1598296530.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH] fixup! index-pack: make quantum of work smaller
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
> Josh did not list
> out specific improvements to commit messages but I have taken his
> suggestions for comments.

...and somehow I forgot to commit them before sending out this patch
set, so here they are.

 builtin/index-pack.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 0a5b938e1e..4fa9127c35 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -62,6 +62,8 @@ struct base_data {
  * Stack of struct base_data that have unprocessed children.
  * threaded_second_pass() uses this as a source of work (the other being the
  * objects array).
+ *
+ * Guarded by work_mutex.
  */
 LIST_HEAD(work_head);
 
@@ -70,11 +72,16 @@ LIST_HEAD(work_head);
  * processed or are being processed, and at least one child is being processed.
  * These struct base_data must be kept around until the last child is
  * processed.
+ *
+ * Guarded by work_mutex.
  */
 LIST_HEAD(done_head);
 
 /*
  * All threads share one delta base cache.
+ *
+ * base_cache_used is guarded by work_mutex, and base_cache_limit is read-only
+ * in a thread.
  */
 size_t base_cache_used;
 size_t base_cache_limit;
-- 
2.28.0.297.g1956fa8f8d-goog

