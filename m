Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F77C43333
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FFF6235F8
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbhANCFh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 21:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729323AbhAMW1B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 17:27:01 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1786C0617BC
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:24:57 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id et9so1549611qvb.10
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zCb37iXSFsX9rFmR1LLC+H3EPGfQdLbpmMxbI4AJd3g=;
        b=acFaaTczZiwXK7pvUFhoCQYnPCw/FUSr3TnJLBMWrlTxp7LDGkL0t8zUZaNx2/cM50
         /JiwdfOUmC86MZo8ho1TNi6S68uK3cuTwAMD8PBiNszAqyQd+7DOVdVQjn57AMdqVD5d
         GlmLqaaDl5Lg6MmkqAijHkbWyAdLOnwNtjEJdpL2q00GvnlmKuDaZ07m07J2G/H4FxrP
         rvtdMczKOgxVC8S2m9Y2io33dFceA5wtnjMiQ/SmG6/qdB79ccHfpsezLCZ2tk/1sdrW
         jY5tYXCBrPW6p6mELAschXtlb/bt52CVGIdiFa9ztgNZdhM3FjR4m2Z6btoYaKu6jiQV
         SDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zCb37iXSFsX9rFmR1LLC+H3EPGfQdLbpmMxbI4AJd3g=;
        b=gluNkG8/iXzeeEpdoioZt/94J+r2+Wf3FCnHt+/VkzAhZr+Fml/aG3xp7afKebo4im
         H7fJOdzdQVQprqROQK4Y+RJiWJvOvf7w72IxB+VwRcQKwFsX5GS3MW+O7hZE0uiaLuNb
         r+pZ1i/q0GnyACE+NyxGzrHi0bDkiP/p6XBiL1ylPuQilexo8LAT1mPma3BE0DKZ330p
         iGHtsTUb5oC1/nlEYEDAlCO/zGs84ECC1+AMhKt4T/ir8BTXy9J42Jq8Ts+Je5/cf+tN
         xiVw5hRz1q55V9ePd9FtSyooZQlRwgDDlFhPNB5Q8x/q8fMlwAKk9bdF9xUtx36iN6Ed
         t+oA==
X-Gm-Message-State: AOAM531b000LuzvSp1YzkmmZqIH1VTA/5zE6dog/T1mos6W5cxJTGEMk
        z8aa16ZM/sA22Zls/lqkzUpmAK1VZHtK6A==
X-Google-Smtp-Source: ABdhPJy9Apfghf30sKN+Vx0wEssRs3KA6qz6UN+iw6S/hl+HJsUxZglSXW/1fn7sNe4qbEwpltNUPA==
X-Received: by 2002:a05:6214:370:: with SMTP id t16mr4705154qvu.22.1610576696682;
        Wed, 13 Jan 2021 14:24:56 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id v5sm1967777qkv.64.2021.01.13.14.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:24:56 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:24:54 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v2 16/20] builtin/gc.c: guess the size of the revindex
Message-ID: <a500311e33a2f7e11a539dd0718ed946f4bd6bc8.1610576604.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610576604.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'estimate_repack_memory()' takes into account the amount of memory
required to load the reverse index in memory by multiplying the assumed
number of objects by the size of the 'revindex_entry' struct.

Prepare for hiding the definition of 'struct revindex_entry' by removing
a 'sizeof()' of that type from outside of pack-revindex.c. Instead,
guess that one off_t and one uint32_t are required per object. Strictly
speaking, this is a worse guess than asking for 'sizeof(struct
revindex_entry)' directly, since the true size of this struct is 16
bytes with padding on the end of the struct in order to align the offset
field.

But, this is an approximation anyway, and it does remove a use of the
'struct revindex_entry' from outside of pack-revindex internals.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 4c24f41852..c60811f212 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -301,7 +301,7 @@ static uint64_t estimate_repack_memory(struct packed_git *pack)
 	/* and then obj_hash[], underestimated in fact */
 	heap += sizeof(struct object *) * nr_objects;
 	/* revindex is used also */
-	heap += sizeof(struct revindex_entry) * nr_objects;
+	heap += (sizeof(off_t) + sizeof(uint32_t)) * nr_objects;
 	/*
 	 * read_sha1_file() (either at delta calculation phase, or
 	 * writing phase) also fills up the delta base cache
-- 
2.30.0.138.g6d7191ea01

