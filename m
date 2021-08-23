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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D745C432BE
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8D5A611EF
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbhHWLhD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 07:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbhHWLhC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 07:37:02 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B03DC061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:36:19 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i6so2048674wrv.2
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VhNqIBszNvSCOXeaL1Rm/NBqUYjjXw/gS1D9bFIVE3c=;
        b=pqzvNoEFC9NFcO2KJicAYTEx736z3pZH3HIzmQsbpvzZP/4vwH0BtxKpo7dY4TUCQi
         UZ9Zto06dbHfCyl8VzmFdAfqwDuybXl4LxHiw/N9GB4XvV3zwITiEpkBFTxPO4DHTqzE
         5xEj9JHi9MQaIgC5PpfnTboSQWm6xhB9HeY2f7uWMNy0rXWQna310Aml1IOYkbhUewjr
         VaSsQ/Q+GV432i7aEU6w9SK+I+NNRkh7tZpx4Yub8TFBU5YpGoNwWHSmH3aBq8Zg4CJO
         +T0AiRqbwU6K58g/inh7lMS1L1viyLNwcQeZKx+QBFipS8poAjcZGSppesz0sIpYgjBq
         dBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VhNqIBszNvSCOXeaL1Rm/NBqUYjjXw/gS1D9bFIVE3c=;
        b=cHaQ9uze0ftlOp64ByYGgKzJkYc3S+wxNT4Oh09e/1fSLbFFAAYGtxNPvMuHJ2eize
         Dj8jwofniM1CJywjnWNV1r0W3tpxB1Y8WRDmkurX0SosddZpf//aSiZHQwVWHmDoHxFn
         71zKJ26LAVi1knhUHl3gs4tYjACTvlaFF8NRfioYgtWCoRSU069XEIV74oLsK8NTaCvn
         G+eR8gw9LgYWXjaygMj7ZYPs8NT2Zi3Fs6sa7vl1AlYyWcTldtnyFAkT201KB/NunPa9
         W3KkpCwwEqLSmfghOII+XduiMBrBInUREAgTUFyjjrcRUB9xgnJGWn7o1xBXh7Ht9tXh
         U1tw==
X-Gm-Message-State: AOAM531BwPzsh58A2Mxee2UIWYEgZbe4Uj4EIL6bVo1X7eebwmsyu6X0
        ovN96f8H0DcEYNp3tcVicZRHX2G7/qGN3EKf
X-Google-Smtp-Source: ABdhPJyfKdIrMpOXkg2eytqsV3L1Dd7XZ8iGAqYQ9fhXZ8qRrYpo3DtITef/n/VFNO9WO/tsiEPHSA==
X-Received: by 2002:adf:e389:: with SMTP id e9mr13241661wrm.304.1629718578013;
        Mon, 23 Aug 2021 04:36:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g35sm20555313wmp.9.2021.08.23.04.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:36:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 01/13] refs/packet: add missing BUG() invocations to reflog callbacks
Date:   Mon, 23 Aug 2021 13:36:02 +0200
Message-Id: <patch-v5-01.13-61cf49b9582-20210823T113115Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.g438caf9576d
In-Reply-To: <cover-v5-00.13-00000000000-20210823T113115Z-avarab@gmail.com>
References: <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com> <cover-v5-00.13-00000000000-20210823T113115Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In e0cc8ac8202 (packed_ref_store: make class into a subclass of
`ref_store`, 2017-06-23) a die() was added to packed_create_reflog(),
but not to any of the other reflog callbacks, let's do that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/packed-backend.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index f8aa97d7998..24a360b719f 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1600,6 +1600,7 @@ static int packed_for_each_reflog_ent(struct ref_store *ref_store,
 				      const char *refname,
 				      each_reflog_ent_fn fn, void *cb_data)
 {
+	BUG("packed reference store does not support reflogs");
 	return 0;
 }
 
@@ -1608,12 +1609,14 @@ static int packed_for_each_reflog_ent_reverse(struct ref_store *ref_store,
 					      each_reflog_ent_fn fn,
 					      void *cb_data)
 {
+	BUG("packed reference store does not support reflogs");
 	return 0;
 }
 
 static int packed_reflog_exists(struct ref_store *ref_store,
 			       const char *refname)
 {
+	BUG("packed reference store does not support reflogs");
 	return 0;
 }
 
@@ -1627,6 +1630,7 @@ static int packed_create_reflog(struct ref_store *ref_store,
 static int packed_delete_reflog(struct ref_store *ref_store,
 			       const char *refname)
 {
+	BUG("packed reference store does not support reflogs");
 	return 0;
 }
 
@@ -1638,6 +1642,7 @@ static int packed_reflog_expire(struct ref_store *ref_store,
 				reflog_expiry_cleanup_fn cleanup_fn,
 				void *policy_cb_data)
 {
+	BUG("packed reference store does not support reflogs");
 	return 0;
 }
 
-- 
2.33.0.662.g438caf9576d

