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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051D6C07E9E
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E68EC61178
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbhGKQdu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 12:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbhGKQdp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 12:33:45 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A0AC0613E5
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:30:57 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i94so21116201wri.4
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0CzOF3oPc5FYJ+HpgSDbzr0Y8ARY09LQZWdRTgdKbgA=;
        b=ewUV/CqumwL1xrtD/igmSh0GOvqS1WobllNDtL0xRMjKSLIxP1HgDND5VwuR1AsbVs
         ziSD/sbwC+uzHJOt7u/CHhoBiI1ZbZeJCg5MDwNjduVVA+2mPchYWY3WPEgsv9JR8dfC
         xjq6uyrDJkfDxNErBlxUctVbIEw6kLKUFvdyyzQ3Yw3gyGLQ//MzEufgijcB1Ve4B+yk
         MWTrBne9dRZTY8VNqkCZjtbgDYoMl+P3iQnR5NhTrmJTbWX8o/RTQIMRo6yY3DzdpDnA
         MIx5470JK4GDySSOeX6jQuoMHZ+RjvGBMHJQoCWp8zQpMOII2D5+gw6EV15h0kkfemWa
         w1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0CzOF3oPc5FYJ+HpgSDbzr0Y8ARY09LQZWdRTgdKbgA=;
        b=ahdcBrPgpW/iThDCad0yc9iCDYW5hxGxAh2vJqvZEfgi5kv0yEkQje6r5UEA6U3AdW
         s4Le2QalSWr/jkd2fYmbAduFWglRCp03bB+IUDlxrLay5ntJRksZ6wbBi6am6qgSu4PS
         5w4TLCXSS+q7fmOP6Dq+BFfpMqXxyBG5H6IPfgxdeoncS65mnSYrwVvaqhBA1XcfQW8W
         tvjmYFZ21EOkYpzTjnvIsnRZZQeb/98VIffik9oENrueXZQ0illuElW/x3WgLhyZ3c0q
         ZqVvlwOyZ9Qx3e3PnH7QAHxpXt9c92z+QS1K/etLBRXkvnDIzv55LuNBefXkj2g+a7Vw
         XyfA==
X-Gm-Message-State: AOAM530acCIZuCQVRofnbgrRShmLYkMntmuQ4d5x3yRRpo/ogf277g17
        lQNpiy4+VMjn5R4FjjvQKEU9fFiuF99Dqg==
X-Google-Smtp-Source: ABdhPJyGwqkNkaaNfFodaW1Ake/06llMaXfAqKaSl8AV8UasOB6fhfn5Aq1J4If4fAbMueODFgfVYQ==
X-Received: by 2002:adf:fb51:: with SMTP id c17mr55233562wrs.106.1626021056345;
        Sun, 11 Jul 2021 09:30:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w3sm678091wrt.55.2021.07.11.09.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 09:30:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6? 13/17] refs API: make refs_resolve_refdup() not set errno
Date:   Sun, 11 Jul 2021 18:30:37 +0200
Message-Id: <patch-13.17-73b70491515-20210711T162803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
References: <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com> <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move refs_resolve_refdup() from the legacy refs_resolve_ref_unsafe()
to the new refs_resolve_ref_unsafe_with_errno(). I have read its
callers and determined that they don't care about errno being set.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 214f3f4f79f..45b51c0a532 100644
--- a/refs.c
+++ b/refs.c
@@ -287,9 +287,11 @@ char *refs_resolve_refdup(struct ref_store *refs,
 			  struct object_id *oid, int *flags)
 {
 	const char *result;
+	int ignore_errno;
 
-	result = refs_resolve_ref_unsafe(refs, refname, resolve_flags,
-					 oid, flags);
+	result = refs_resolve_ref_unsafe_with_errno(refs, refname,
+						    resolve_flags, oid, flags,
+						    &ignore_errno);
 	return xstrdup_or_null(result);
 }
 
-- 
2.32.0-dev

