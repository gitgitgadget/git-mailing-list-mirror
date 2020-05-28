Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06A1C433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2E04207BC
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGwFkIbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgE1Tri (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 15:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406676AbgE1TrE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 15:47:04 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A97C0A88B4
        for <git@vger.kernel.org>; Thu, 28 May 2020 12:46:59 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x13so523577wrv.4
        for <git@vger.kernel.org>; Thu, 28 May 2020 12:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=o9vcJ73dXE7fO76RktXgm61AhF8amudgtEPjX0Aw3B8=;
        b=kGwFkIbu8YO45AkOOhdypW3jpT2Pq/7kYHw2JCZ9KfBTSq0ee6tn0GjBky7u9OqJi8
         uJnYkEnG9XiEQKQ21TNhtrJrwT7aUtust8dSKPtgzCXvV66BMQk7jaCuypYjKlKXM9Hc
         KtIcAXJUknpJObZz4kNJXQ9CoGeju50oybc2ed5fyxGdJqlZAdsoWc7rh4qik/odA4pR
         7yDxDTiulA/KtzGsKYMa1PIoSE0SwWFTIPaHi1BLpTGlzPkx6ZJ3hUyUABtHhglkXoLy
         xIK142y0VUlNSPdj6PcjEBblcESETmly92UyAeAsCUB8uqlTvMTrl/N14d9SDD0Tdp/m
         H+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=o9vcJ73dXE7fO76RktXgm61AhF8amudgtEPjX0Aw3B8=;
        b=Yh0G9SRAHVJORkMJiuSh/fdqxres8nwWGtYLB5S2WSxlS59Wx6+cqkn460Kl1/XcSt
         tRG3Lg/V2VxtQTen+DT2ttEdm6phzDEc8QimIEIXwWcSZNv8pN+o1IredioNmJk4P3LC
         shgOFh6pw+6BcQ6LbYCvxIyAnEcVznlytcTsWKyGuNb1/ZHolSPT1bQ0357G4GEyZvDW
         WrykZ2dhzPk8rFyKWuKxYEjKCy70fCpr//misXKpv6tOGtADVEL0A77R2NZxn5tgHfyP
         MHFuWIqKFKXKOobGimfEL5lgL54u8dfclxythVGtSB3z5AqO6Q7B5JW/Dc7AvjRv75bQ
         R/sw==
X-Gm-Message-State: AOAM532f14tqJDBHEYV8OqdzpKjPgE16POzUH/OUA+lTdSkT1Nwc6oCQ
        2xysO7RuuFGw5pnyEE4WRmUNG/21
X-Google-Smtp-Source: ABdhPJw/kcWL469u4iDBJO0VgT4VyNExN2+Steq7qm3ztshG5ufDu5RmtH8jHZJYTpmZ7kLF6lVhiQ==
X-Received: by 2002:adf:e588:: with SMTP id l8mr5321306wrm.255.1590695218325;
        Thu, 28 May 2020 12:46:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k14sm7038041wrq.97.2020.05.28.12.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 12:46:57 -0700 (PDT)
Message-Id: <27a980d1d9d56137cd799911073535fce7500b79.1590695210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
References: <pull.539.v14.git.1589833884.gitgitgadget@gmail.com>
        <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 May 2020 19:46:43 +0000
Subject: [PATCH v15 07/13] Iterate over the "refs/" namespace in
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
index 812fee47108..29e710a29e9 100644
--- a/refs.c
+++ b/refs.c
@@ -1450,7 +1450,7 @@ static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 
 int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, "", fn, 0, 0, cb_data);
+	return do_for_each_ref(refs, "refs/", fn, 0, 0, cb_data);
 }
 
 int for_each_ref(each_ref_fn fn, void *cb_data)
@@ -1510,8 +1510,8 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 
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

