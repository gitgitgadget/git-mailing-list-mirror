Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE20BC47257
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADFE0206B8
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/xsHBVB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgEDTDy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 15:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725981AbgEDTDy (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 15:03:54 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8B8C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 12:03:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id d15so415554wrx.3
        for <git@vger.kernel.org>; Mon, 04 May 2020 12:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XTW+S1tjt/UjHTmSLUWWzSNcFWS/aoQftFrdnmqTgX8=;
        b=B/xsHBVBGXUSnFUxKw7EzqjTV+Aq8JVhHw/v0HelxxGO8meonG0Bw5OOdqkWnJqc6p
         ptRtWpKFVIdCzPyIT9HPpVhsTWcCZvEeM7F+J4gjwVhBGPFBhUR0+toQZv1Ec5BcRrDq
         ocIa8nBfYLMelbUy7tZBZU38AAfYOtwHKBgrSlnIt1WkkChxfCgtU4XhDfyjbRiA+e6z
         MaLA1EpWVbhb+tXVI1XGM+hFrMs2thIAdB1sInyEwqscrxCguWILKhsLsBRgd6/EqDuU
         ajHwJaAcyQoXufFTy11Ms/LzSNhQmfib0hBUcrwS+Qwi8dqsMREXTcBZae2aO/SrQxDe
         /IbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XTW+S1tjt/UjHTmSLUWWzSNcFWS/aoQftFrdnmqTgX8=;
        b=bgGJH3sc6e62wgR6Za+SAVwG0gV1nRL9nDNeB5TQptk1CHInYxOOx+wYFf+vQBpOIE
         UJxocmulvT5kqCdlYlbox/KLIhNHfRvvpQuDxN8k8fcYnHBM9y623Lp+79n5deRZQ2sD
         naBq0gJ8RJHkn2GEtXpl6PVZybTuRmjalGD5FdUYnw4ZEA5zqACxE1b3Z93Fbo/tVIt6
         vm8L2+OZbckLlaPOu81OOIG5aNeYMWK/aqhAIsPe4LgXYk/wrbDis0VgmrnXZw1EhQWf
         C1vIgDCt6vh5J2pwId9XI3a+tZzb1EHyGwNQXALRr6Bl375vZA8DhUmg45nDyPqC2byc
         SIKQ==
X-Gm-Message-State: AGi0PuYgFrsVSPc6HA28aJsnpmKO6oJ6DkRT/jN2C8NTNC8OhRfI6OWt
        WxO/UYGrvUSQeww9euokSJzL5awR
X-Google-Smtp-Source: APiQypI1uEHZP/AqH57+5HQEa1aZ8UXJivrsB+i08G32gymz6aGtbnp0x9DuI9QZ/nagd2gHRQJCkA==
X-Received: by 2002:a5d:4704:: with SMTP id y4mr871464wrq.96.1588619032259;
        Mon, 04 May 2020 12:03:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a125sm588409wme.3.2020.05.04.12.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 12:03:51 -0700 (PDT)
Message-Id: <340c5c415e17a957b8a38932215b1179fbe68dbd.1588619028.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
References: <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
        <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 May 2020 19:03:38 +0000
Subject: [PATCH v11 02/12] Iterate over the "refs/" namespace in
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
index 224ff66c7bb..4db27379661 100644
--- a/refs.c
+++ b/refs.c
@@ -1525,7 +1525,7 @@ static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 
 int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, "", fn, 0, 0, cb_data);
+	return do_for_each_ref(refs, "refs/", fn, 0, 0, cb_data);
 }
 
 int for_each_ref(each_ref_fn fn, void *cb_data)
@@ -1585,8 +1585,8 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 
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

