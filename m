Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F862C4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 20:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03052206F7
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 20:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kboX3Fx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgJGURB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 16:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgJGURB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 16:17:01 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9170AC061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 13:17:01 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id x24so2060912pfi.18
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 13:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=mhB/cbDRiSSbxGaqLHRoOcRF4GDZlvLSHVHAm/zYwLg=;
        b=kboX3Fx0FCV+R8DhHqY7UoIMOEDF8pjVl2Fc4pDqAMDqBeCKD8ckk28irnF0lSbU3t
         H3DAw3DXG85phVQyIY5G+Yldge6OXuNZaLLfe7p2LbK9EgLcLpmnwDovBwEjqfFET8PV
         EmsTv/dJGrpd0mRBWMoPmyE5OjMGZfLQsf8hg4a+ugQVxv8eZ4ewRXQb/YlJbyMSLZcc
         0f1DvSCPezIipR5xCHM8mIa9mCAEoh8Ymsd+KeglfW6zw6A58Z3bF4DBgDIvvogrbwZ5
         WIfQQZAvhNMSGphKhy3h+obfGBPWSIqoSkoCReynHlSAwhI/HOdFEJh1B2LbkS1a0K+t
         1kCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mhB/cbDRiSSbxGaqLHRoOcRF4GDZlvLSHVHAm/zYwLg=;
        b=RUTNGmMAIfKZj6RW3v5QRCwCFOlBxRlRYE06iujtKdphpCBDFPpQWSAYh2+zzap4+1
         AmF9O8SjjjZzSH31GhmhVW5yPGr0o9VKFBlKsRux6tyiYQrwobHtaNGfxrBWlmj/Vs+U
         1EH7hbM5AAWDDT3H5i0vp6bgtQiYErEZhlSuh0m3vpDgn1rc7NQBaoOzySbyT1AiYMaJ
         Wb98+rbU1MnLHqiWMCWUxDJIOiSOxTlLjsMkduFS67AbK5D+MHcnVNzyAFZf0SIPZ+v9
         piozJobz8OO6RELZ5q+tko/Y2lzLiQSkpZzV8/wcpLEH8JSgN6gic0rBmV/QCcvySfvN
         8oTw==
X-Gm-Message-State: AOAM533/iXZX7zER/sYpAEtjkxipq8LLLZe2J/Z9xT4GFhWouLu9tNbn
        ZRioI6rDgGj8Ppl/6jvDQ10JtlKjkhBx3JGjUQKycuzY3sGmDL+3JZVfGzgpubVjdrxuTNqQW6h
        t5H3aJQHsIWok/89jZLhAazQ3qBWays6wvjNcK5o3hlL2htkhrJzZR8iHM9dntQNorHpFlrxzIA
        Fz
X-Google-Smtp-Source: ABdhPJwHFpz0uYB6Nb00+PvdJ7mArUlVqSQd3iCEcyqHLrQJR1AfwqnwJUIQRqpo1Wta0RkMCfHPMFplgZXV/FJ13QZF
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:3fcd:: with SMTP id
 u13mr1832074pjm.85.1602101820834; Wed, 07 Oct 2020 13:17:00 -0700 (PDT)
Date:   Wed,  7 Oct 2020 13:16:58 -0700
In-Reply-To: <20201007184852.GB222564@coredump.intra.peff.net>
Message-Id: <20201007201658.1322116-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201007184852.GB222564@coredump.intra.peff.net>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH] index-pack: make get_base_data() comment clearer
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A comment mentions that we may free cached delta bases via
find_unresolved_deltas(), but that function went away in f08cbf60fe
(index-pack: make quantum of work smaller, 2020-09-08). Since we need to
rewrite that comment anyway, make the entire comment clearer.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
OK - here it is, with "reconstruct" instead of "uncompress". This
replaces patch 3 of Peff's patch set.
---
 builtin/index-pack.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 8acd078aa0..53e8a1a022 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -894,18 +894,15 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 }
 
 /*
- * Walk from current node up
- * to top parent if necessary to deflate the node. In normal
- * situation, its parent node would be already deflated, so it just
- * needs to apply delta.
+ * Ensure that this node has been reconstructed and return its contents.
  *
- * In the worst case scenario, parent node is no longer deflated because
- * we're running out of delta_base_cache_limit; we need to re-deflate
- * parents, possibly up to the top base.
- *
- * All deflated objects here are subject to be freed if we exceed
- * delta_base_cache_limit, just like in find_unresolved_deltas(), we
- * just need to make sure the last node is not freed.
+ * In the typical and best case, this node would already be reconstructed
+ * (through the invocation to resolve_delta() in threaded_second_pass()) and it
+ * would not be pruned. However, if pruning of this node was necessary due to
+ * reaching delta_base_cache_limit, this function will find the closest
+ * ancestor with reconstructed data that has not been pruned (or if there is
+ * none, the ultimate base object), and reconstruct each node in the delta
+ * chain in order to generate the reconstructed data for this node.
  */
 static void *get_base_data(struct base_data *c)
 {
-- 
2.28.0.806.g8561365e88-goog

