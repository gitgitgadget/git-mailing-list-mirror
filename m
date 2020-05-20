Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2180C433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 17:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B15F5207D3
	for <git@archiver.kernel.org>; Wed, 20 May 2020 17:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4bhOXXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgETRgU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 13:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgETRgS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 13:36:18 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F27CC061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 10:36:18 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k13so4041010wrx.3
        for <git@vger.kernel.org>; Wed, 20 May 2020 10:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1n9IICFmbibIlnP+lPOlX2QEwP0lm207zOFhSneCIS8=;
        b=B4bhOXXDPKFhYUji21aF9suBR7BKlPEOgb7HKujOhz4lzc+zqmpZg2RzweeSJGH79X
         i4FhACTWe6bBf9mLRt6T+sqcTcN2mmxTj3dt4n8ovuMQ+VJqUt81oRS7n6Rj8/DhQFq6
         iG+fH8AUscPQfA/bpth4JjP1aAj2JQ4m4Cz2Wyn7uuaBc9AKbcycV9ekzxCIjHKGixRD
         Mha/aLLWYK+v4//to0EA8+KDZeTp3PBDzHATkG/g1yn1PKP2v1jDGnJSyhEtM5wR3wK3
         Pxygan8qLKrP3dSOgdyF/w8/bM0HQu9NmBo8maW0pHRPknVH/UfotCyG/HtWiiWkfjGj
         i/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1n9IICFmbibIlnP+lPOlX2QEwP0lm207zOFhSneCIS8=;
        b=fgX7cV4LjdTrZIMgchwkB3va62TRQY5Cv7QjPgGeYKdlE+MaaXvjGyLZxIIGrDUxZM
         KmvPjTcpolYi2UzFmcKBRLHF9Rbsvow4aXMOsHUHDGEksXiRyYk1qdFnCxrPYMX/l5Fy
         hJhZEkqkzhQjt5Z1j5xJ66umMnRm1KCWnQYaUUk4mdtYqH539DlZT5tbBIKDnTyPYBJa
         inhe67HDC35AWjUK0h69rfsvPnuBC2zeYvanPhNFg3WnOY6mu+9jOgUSOELoHzVyL+1f
         3bu0FFE+7SXI7gizv1JrNybX76aLchq5H8qzHcHZf31ByqbxgqNAdNeBpXwZ1sUhPQxx
         bUxA==
X-Gm-Message-State: AOAM53025ezcDW3ryV5w6KyYbZxXduT7fo9L5clQ+//A/HuzBAxD5Hix
        Ij++FrWxBPceRD4H2p/3BYHcgZIg
X-Google-Smtp-Source: ABdhPJwmI/4ukdDV7LoRTdX4goBaY8du1vtuliRohALx4GA+PLIy+c8nK7M14H94zIQsqaZUBGsKMQ==
X-Received: by 2002:adf:df8f:: with SMTP id z15mr3896175wrl.369.1589996176916;
        Wed, 20 May 2020 10:36:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w15sm3436682wrl.73.2020.05.20.10.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 10:36:16 -0700 (PDT)
Message-Id: <2a0f428a91060e0014086d0018d6887538299143.1589996173.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.638.git.1589996173.gitgitgadget@gmail.com>
References: <pull.638.git.1589996173.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 May 2020 17:36:09 +0000
Subject: [PATCH 3/6] refs: improve documentation for ref iterator
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Document some of the flag options in refs_ref_iterator_begin, and explain how
ref_iterator_advance_fn should handle them.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs/refs-internal.h | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index ff2436c0fb7..4271362d264 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -347,9 +347,13 @@ int is_empty_ref_iterator(struct ref_iterator *ref_iterator);
 /*
  * Return an iterator that goes over each reference in `refs` for
  * which the refname begins with prefix. If trim is non-zero, then
- * trim that many characters off the beginning of each refname. flags
- * can be DO_FOR_EACH_INCLUDE_BROKEN to include broken references in
- * the iteration. The output is ordered by refname.
+ * trim that many characters off the beginning of each refname.
+ * The output is ordered by refname. The following flags are supported:
+ *
+ * DO_FOR_EACH_INCLUDE_BROKEN: include broken references in
+ *         the iteration.
+ *
+ * DO_FOR_EACH_PER_WORKTREE_ONLY: only produce REF_TYPE_PER_WORKTREE refs.
  */
 struct ref_iterator *refs_ref_iterator_begin(
 		struct ref_store *refs,
@@ -438,6 +442,14 @@ void base_ref_iterator_free(struct ref_iterator *iter);
 
 /* Virtual function declarations for ref_iterators: */
 
+/*
+ * backend-specific implementation of ref_iterator_advance. For symrefs, the
+ * function should set REF_ISSYMREF, and it should also dereference the symref
+ * to provide the OID referent. If DO_FOR_EACH_INCLUDE_BROKEN is set, symrefs
+ * with non-existent referents and refs pointing to non-existent object names
+ * should also be returned. If DO_FOR_EACH_PER_WORKTREE_ONLY, only
+ * REF_TYPE_PER_WORKTREE refs should be returned.
+ */
 typedef int ref_iterator_advance_fn(struct ref_iterator *ref_iterator);
 
 typedef int ref_iterator_peel_fn(struct ref_iterator *ref_iterator,
-- 
gitgitgadget

