Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E009C433E1
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C4762073E
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTShkPxp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730765AbgFVVzb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730747AbgFVVz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 17:55:26 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F094C061573
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 14:55:25 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g75so1054526wme.5
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 14:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=T+voneQ0Whz61s3+JQuey70k8Ow9ROVzOJ6Axj3DAC0=;
        b=pTShkPxpujV8H++wAOEGUJVF2zzugEkE0egcvoDIASRRovfRSUEH9mn+veIRxadh0G
         AA2lh04NHRNhOKxl3vSj68UIERhl+jg5EJ8hAQS4eoACzb1nQTP7OQvSpOEWKz4F1B+/
         EX5Pa0T57mFb++FQfnu6JToK+TV8RYNEgT2VwCukUFApWJxq/93fkvyXuPKzZPfDCjpE
         25Pp9+r/MtzTQ4QQ8xr9gKTt/wKtOfE4ytrGR8PDofPibme1b+gmEvVZ1J/oksXr1TIT
         Cn9eeG7e3Cq0HDcHFAMg8oiQGI5U9pq7Ye+niKPg7afVEMBZxrPd51af8dNpQgz1Ps6C
         jL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=T+voneQ0Whz61s3+JQuey70k8Ow9ROVzOJ6Axj3DAC0=;
        b=dKkhQVTZSA/iurfAF6iBtSpye1HocfUhEgKfPxt8mfvmQgCGKW1mCm1iyDDfH2bYqf
         EDywYY4DW8fQXcQHzofpPu0BPVKylKQPRZf69udgSlkWc1UWzBitKVvLUmSWTLL85KP3
         BNGEGurvlEfPeaDr6MKV0vSguMur9Fa+gqx3/eyBEc2ylYLZSUUWAyK0WFOf/m6UWpuG
         BKEAvitXzb8Rp2HjXKysEiGays6CdeGrfQzyOUz3HnbPnovp+tI/3IM4GOmCKzH2G51J
         FJ399ben1GOExqmrv1CX4/8fcCHEROjmp2td/GVbC0yxaeLBoqqlfMMDmTDnBbZOkF5i
         1ibw==
X-Gm-Message-State: AOAM532Z14DSpll48tMKC3Oy92g2LgQbf6DiHEissU26tr2nfhsAr1FM
        ivNZ+jFU1QHs+HE0tGGqbpRX/YZr
X-Google-Smtp-Source: ABdhPJyiocC8pA1dyA0mRVBza7/F8ROgGPrHiZ1ZoY8YJoK6AzZnFxUd6K08t8L4eGort2ji2pksBg==
X-Received: by 2002:a7b:cd09:: with SMTP id f9mr10711440wmj.160.1592862923894;
        Mon, 22 Jun 2020 14:55:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d13sm5612647wrn.61.2020.06.22.14.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 14:55:23 -0700 (PDT)
Message-Id: <b968b795af9acf0ea05bc37f6b80bfd40570bb4c.1592862920.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
References: <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
        <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Jun 2020 21:55:02 +0000
Subject: [PATCH v18 01/19] lib-t6000.sh: write tag using git-update-ref
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
 t/lib-t6000.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/lib-t6000.sh b/t/lib-t6000.sh
index b0ed4767e32..fba6778ca35 100644
--- a/t/lib-t6000.sh
+++ b/t/lib-t6000.sh
@@ -1,7 +1,5 @@
 : included from 6002 and others
 
-mkdir -p .git/refs/tags
-
 >sed.script
 
 # Answer the sha1 has associated with the tag. The tag must exist under refs/tags
@@ -26,7 +24,8 @@ save_tag () {
 	_tag=$1
 	test -n "$_tag" || error "usage: save_tag tag commit-args ..."
 	shift 1
-	"$@" >".git/refs/tags/$_tag"
+
+	git update-ref "refs/tags/$_tag" $("$@")
 
 	echo "s/$(tag $_tag)/$_tag/g" >sed.script.tmp
 	cat sed.script >>sed.script.tmp
-- 
gitgitgadget

