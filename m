Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C171C3524F
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 20:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5C72082E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 20:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReQpkPfT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgBDU1q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 15:27:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42395 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbgBDU1q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 15:27:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id k11so24752615wrd.9
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 12:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Fpn6hCrJlQcifPaFjwglcZbzUR3UF156xucJLSb/KRs=;
        b=ReQpkPfTSivVFkM4WXcwcGM5Y1Rhg8RVJN3anUV6dw5y0K2ImzF2e39mwmRN36HJY0
         Ijq476YM8vJk8WWxIuZX2nEQr2yoUCm1Mci5AxNEZAd+Ar0uWwReoVREjb6UjdNJrErl
         +KjdBt6M8df7ijPDP3UNziHy6to6oJQU3smKWPEjsmwvCR0K9NKkbgEO3vEU7pMBidKK
         2AttRv7PNFSQyj9aWRhl+L3nCZA/65YNhheXDwMJQ84MIXWumyx450JKXPnb8xO/sv8m
         pQSVgYU6ZFBalXHFFLlTr5Bmf/udfS9DbK/I1Lnrhe+3cCuGeSinszUL0S8zlGQMX2q8
         DCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Fpn6hCrJlQcifPaFjwglcZbzUR3UF156xucJLSb/KRs=;
        b=C4d/VIJCeTxudmWlwRTkEFc/ttCnhguDoSVVaBJCDMHDjmSMmm5Zlg31P3ZBgqOJ3T
         cMJqw4hBe1dna7mywlHFTezpWg+QjTm8VvzTVFEhG8dtk46pZ6ZYpb56t+5wiigfRupG
         VqldZU9Tu0+Ibyap9X1TTh1Jf5oqCyuWDkPfE0+q6UUaE3J9o9x690+LyezDBIp6f+KM
         KjRLo0juPdIgev5dAK/5OdzgeZEMSlYBcgD3oAJ0RQ554tXvKPK58MmjIdj21R4mGVt6
         ViSybMKw2cZoQJC1fETQbBIgsHBKG55t12AA7XFsGoS6YxuROnxqp7xZ5hUJMQToPwMG
         q9Bw==
X-Gm-Message-State: APjAAAWwSg5IUSN0ubwct7iCx2fAQjUxuj/s5fvW48PrSJ+9Boap+NUW
        rB9kpi1gW5A6hfQ/8bXkI6HVQ5Wt
X-Google-Smtp-Source: APXvYqzySL+tdX1cXL7iOw7HjKPaGp3BJOPMF06KCybT/43eAcmij2RdBMAwyaBzbhL2HCA71ZWkJw==
X-Received: by 2002:adf:f581:: with SMTP id f1mr24038077wro.264.1580848062171;
        Tue, 04 Feb 2020 12:27:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h13sm20566483wrw.54.2020.02.04.12.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 12:27:41 -0800 (PST)
Message-Id: <c00403c94dec866dd3aa3c128d866217efb767ff.1580848060.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v3.git.1580848060.gitgitgadget@gmail.com>
References: <pull.539.v2.git.1580134944.gitgitgadget@gmail.com>
        <pull.539.v3.git.1580848060.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Feb 2020 20:27:35 +0000
Subject: [PATCH v3 1/6] refs.h: clarify reflog iteration order
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

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/refs.h b/refs.h
index 545029c6d8..87c9ec921b 100644
--- a/refs.h
+++ b/refs.h
@@ -444,18 +444,21 @@ int delete_refs(const char *msg, struct string_list *refnames,
 int refs_delete_reflog(struct ref_store *refs, const char *refname);
 int delete_reflog(const char *refname);
 
-/* iterate over reflog entries */
+/* Iterate over reflog entries. */
 typedef int each_reflog_ent_fn(
 		struct object_id *old_oid, struct object_id *new_oid,
 		const char *committer, timestamp_t timestamp,
 		int tz, const char *msg, void *cb_data);
 
+/* Iterate in over reflog entries, oldest entry first. */
 int refs_for_each_reflog_ent(struct ref_store *refs, const char *refname,
 			     each_reflog_ent_fn fn, void *cb_data);
 int refs_for_each_reflog_ent_reverse(struct ref_store *refs,
 				     const char *refname,
 				     each_reflog_ent_fn fn,
 				     void *cb_data);
+
+/* Call a function for each reflog entry, oldest entry first. */
 int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data);
 int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void *cb_data);
 
-- 
gitgitgadget

