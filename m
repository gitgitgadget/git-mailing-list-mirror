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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EF0C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 23:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C77E460F90
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 23:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbhGZXEP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 19:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbhGZXEK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 19:04:10 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDFFC061764
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 16:44:38 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id c16so3145706wrp.13
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 16:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yHUkIzinW0ExtWvjDbLMDXh3JzdcggswOPlGuAal3mQ=;
        b=EL7dIfHIMVBx/EjJiLEgTwWKGwARMzTvdTx1W0HWmPO5KZCWJJL1ib2m+kfmDJT5Yy
         8P0m+m5S0s4ZXD/uPe4AbKsWXWWux5oH8uyJLxZU72kpuFcK6dQWpTHns1oLRynzvMUr
         Res7V5WyxmCEJaT3rdQBUYIHJ1TKtrtlecn5OhdJm3VzDs4PNGQEk3cOXxNwUPNYJWGj
         j3L8szJN8axlBKwAF623SA7LGASXm5Jplhq5QydZ/K/a+BfFiHEAgTy7QrlNHfPrHLKq
         iOrKRNfRCprf8wCUg2eD9+oL0qjvzwYoi+oj/+YNGYmFoz4s4YfwJr85t7lNSTN/m6TP
         mKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yHUkIzinW0ExtWvjDbLMDXh3JzdcggswOPlGuAal3mQ=;
        b=BwaYdnnD1IN11vewpUSsTxF+MtgPkXyE5vuolCZp1Z/y3OEif7oQeu4pk+mFpW9tbJ
         SrHVQNl3ZshorKnadHW1AK+O7ZT8MtVZOjYZUrzk+l7RyD4vTmYaBvdLtXDXuivv310J
         hIS+dPtxP9qdbAigQnmqaSiQgAgtoOAwijZwSX5X8X2etd9HdQZ828dmUL5o2L35dkB0
         5jxolzSdzpVH7E67DnMF2UNdif6kj5Z7uy+Api8GkjoaYcagYLhrQIZb08Ok8dY5xQWj
         vvRGvd8WndjOkbAWB9nOZybmnKELl9UmgNXK9xdbkOyfSbo9Y7lMdf2JMEL8XOSDyI+k
         dm8A==
X-Gm-Message-State: AOAM533nrbun+8GzbBoBHeGLvPSZ1LfOIlyj0fAbsy46TLFm+tukD2SH
        NIl5h9QXhZxHYcBR/bCZe0YiFitMn7a4pQ==
X-Google-Smtp-Source: ABdhPJwFHEwCqh0NbbyNMKiNRrVIDk4XVVDf9kjdUXXQJV67p3ovL1vQgovJh0K3bQCUDiypYBFiwg==
X-Received: by 2002:adf:f446:: with SMTP id f6mr8853906wrp.361.1627343076441;
        Mon, 26 Jul 2021 16:44:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n18sm1214545wrt.89.2021.07.26.16.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 16:44:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 07/11] refs/files: add a comment about refs_reflog_exists() call
Date:   Tue, 27 Jul 2021 01:44:23 +0200
Message-Id: <patch-07.11-7fe6c9bd92-20210726T234237Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.988.g1a6a4b2c5f
In-Reply-To: <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com> <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a comment about why it is that we need to check for the the
existence of a reflog we're deleting after we've successfully acquired
the lock in files_reflog_expire(). As noted in [1] the lock protocol
for reflogs is somewhat intuitive.

This early exit code the comment applies to dates all the way back to
4264dc15e19 (git reflog expire, 2006-12-19).

1. https://lore.kernel.org/git/54DCDA42.2060800@alum.mit.edu/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index af332fa8fe..5415306416 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3068,6 +3068,19 @@ static int files_reflog_expire(struct ref_store *ref_store,
 		strbuf_release(&err);
 		return -1;
 	}
+
+	/*
+	 * When refs are deleted, their reflog is deleted before the
+	 * ref itself is deleted. This is because there is no separate
+	 * lock for reflog; instead we take a lock on the ref with
+	 * lock_ref_oid_basic().
+	 *
+	 * If a race happens and the reflog doesn't exist after we've
+	 * acquired the lock that's OK. We've got nothing more to do;
+	 * We were asked to delete the reflog, but someone else
+	 * deleted it! The caller doesn't care that we deleted it,
+	 * just that it is deleted. So we can return successfully.
+	 */
 	if (!refs_reflog_exists(ref_store, refname)) {
 		unlock_ref(lock);
 		return 0;
-- 
2.32.0.956.g6b0c84ceda8

