Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77E8C433E0
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 18:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90B1020663
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 18:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bm4EI0Nf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbgF2S5S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729568AbgF2S5K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:10 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC83C031C40
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:10 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g10so2917587wmc.1
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=x3gkwfDyVATxmVwJQ1kKlzmJzZlPPHDOc3pXYQtKRhc=;
        b=Bm4EI0Nf3J9Fd3QHRvyxkGK/lsz3rzsL1B3p/TM4UO9SQoAFk5ydOH3Jc6JYq5j6dm
         n9hD/9mEgEty0YWzg+ma1JLG4wpke7RcNDjZJZGZqdd1s+IweuieyY2ukYcIlGYkLOOY
         aqRTGDnYZ6G0z4uhHtu2li62z9KtcLsnKYdKKJuNuCGyMmia6e3fnWyLZvIwyoxn3aA6
         JIhvMaB+KYzWovzWO1z8icvCVHUfKU4NZrqa1MKirOFOUvVxinuZc1eNYEHA9k9dwaRw
         1pvmAGaOIaWZohkR6hFCcp2W40eOqMo3SR+4ujYMNrJJG8vywPWru7wLjRaPlpqV91T4
         8HAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=x3gkwfDyVATxmVwJQ1kKlzmJzZlPPHDOc3pXYQtKRhc=;
        b=OraUf8R9+WkvaVXjzLoIVe4L48d1NiHQjeEtx4R6q2pd35AGhdG7g2HGjPDi3gWXYk
         yQExuOQVCT91z+vWfnkOE5E2Ryb/s3u1QYvc+nLfZcoIT3Abh1ngF01ZHN3ejt85oqth
         GBfia1+0KbK6njtlay6+LfzgM4RN1sZHzYZ2tB4nxnXzEmYavkjtKevwG9DIJBQ6W7Oh
         MAWpmEzMZaKVL7NTMNasd1NqK901eEKjEA24ayJk5wde2ldh8fzjNZHQ/b+LINfTncap
         h42xjD5bcyBIN7vokLTSwE/aKL1PGdlCwU5feoHJijo3lKiMe5B2vIdPL9lXVd7o9yS8
         1acg==
X-Gm-Message-State: AOAM530oLLR2mn+pxszi+aSDPfCO7fIEsuNlR9f2kTLExvmZb8YqEa//
        QXPqdMAvI7olqykOG0IDGqW1q4RkHQw=
X-Google-Smtp-Source: ABdhPJyT2Oe66xScOjlq96BfXBLbbEgi01BlCEiMRdzm9eLoHTwIN0CoQvNXZ5IKmezrsE0PPWwB8g==
X-Received: by 2002:a1c:9ac2:: with SMTP id c185mr17603866wme.24.1593457028733;
        Mon, 29 Jun 2020 11:57:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g195sm837998wme.38.2020.06.29.11.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 11:57:08 -0700 (PDT)
Message-Id: <a116aebe110fc1023b7b0dce8ae5a94f5d3d4d28.1593457018.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
References: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
        <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Jun 2020 18:56:48 +0000
Subject: [PATCH v19 10/20] Iterate over the "refs/" namespace in
 for_each_[raw]ref
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

This happens implicitly in the files/packed ref backend; making it
explicit simplifies adding alternate ref storage backends, such as
reftable.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 0363ddbeeb..36c0e76256 100644
--- a/refs.c
+++ b/refs.c
@@ -1482,7 +1482,7 @@ static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 
 int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, "", fn, 0, 0, cb_data);
+	return do_for_each_ref(refs, "refs/", fn, 0, 0, cb_data);
 }
 
 int for_each_ref(each_ref_fn fn, void *cb_data)
@@ -1542,8 +1542,8 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 
 int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, "", fn, 0,
-			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
+	return do_for_each_ref(refs, "refs/", fn, 0, DO_FOR_EACH_INCLUDE_BROKEN,
+			       cb_data);
 }
 
 int for_each_rawref(each_ref_fn fn, void *cb_data)
-- 
gitgitgadget

