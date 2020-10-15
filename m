Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E370EC433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 16:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85D3F22240
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 16:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzymzcZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389578AbgJOQ2j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 12:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388811AbgJOQ2j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 12:28:39 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AFDC061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 09:28:39 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id e2so4430730wme.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 09:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QXjIAgQnwXQH/YilOhngCUd7C3Qd4gLco0mGMKt4aXQ=;
        b=ZzymzcZV/MWRxinHNtMsnpFAFRZgCfRdpvT+Suk/d4Rumg0iFNnd+dRC8BFZklPw2M
         2Zd+YmCLrrKwSas+69BY0PYeMXMBUi44nI/jq/LjIjWmAFarvl4yUJ/w0UiUdOJiJJQu
         aNvW6l3NWiW23sN3wXULyLXoMzhtdDOPrF5r+ZjQmk+ExFvD1zv5+jbjCMhKYXA9428h
         v/842V2PQCaFYs+vZtBP6xwiqOXVpxCVti4nfPGCyFVo+oneuSIMg6oiwxocg18TzsV1
         zul8c+EpDD4TxCbOKRN6es2JYsjaVidyJAxnWQEq+khSoKQTXPZ/LA1XdpOKb11uD9gT
         TP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QXjIAgQnwXQH/YilOhngCUd7C3Qd4gLco0mGMKt4aXQ=;
        b=ZMDAG+x6lj4OaANrTmA+LIXVflZr1IaJYoXraP4/CSr+JD3H481nBQ6s+akjak03VI
         eFJDUI1oam/O5aJW3s957BqEFVqBupVzteDZtI+BiWcKTxrB4ou+vOSjyCUf66LjWlll
         E/9TlAAM/IC6QNlVS5+tKnYOslEBmyzMFVyUTF2eIqOBLVit2Y0/d/rZZBX43nEonkzm
         nndrTxC9v6jtGz6KxXOOC0b+5BKWUdrXf0jcxWtxDIj9lgWpCUOtxsulc6G/lYmSdVqh
         L5bYp1qCn2LaaTalZuIXZA2XYPvKQznCNY2OpHJfNMCAFTBK/YrsR6SCaXedEueLWv95
         fgRg==
X-Gm-Message-State: AOAM531PqeRJhqJsZSaayI68/4KJ1rWOFwqZ0Db7AQGwvnyeVCsu6+E1
        FNWSOzhHmNRxe18KtbFT40gsma/5OyM=
X-Google-Smtp-Source: ABdhPJyoYvhbWVzKE2LZCh3mWzxMNJPraA2uyHRXmqwmY//yUP7JtQYWyPLUrAR2Ve2+fPsKcj6dqQ==
X-Received: by 2002:a05:600c:28c1:: with SMTP id h1mr4879074wmd.30.1602779317710;
        Thu, 15 Oct 2020 09:28:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h206sm5515549wmf.47.2020.10.15.09.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 09:28:37 -0700 (PDT)
Message-Id: <pull.757.v2.git.1602779316760.gitgitgadget@gmail.com>
In-Reply-To: <pull.757.git.1602766160815.gitgitgadget@gmail.com>
References: <pull.757.git.1602766160815.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Oct 2020 16:28:36 +0000
Subject: [PATCH v2] dir.c: fix comments to agree with argument name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Nipunn Koorapati <nipunn1313@gmail.com>,
        Alex Vandiver <alexmv@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alex Vandiver <alexmv@dropbox.com>

Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
    dir.c: Fix comments to agree with argument name
    
    Comments are out of date with the variable names.
    
    Update since v1
    
     * Change "SHA1" to "oid" for consistency as suggested by Peff

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-757%2Fnipunn1313%2Fcomments-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-757/nipunn1313/comments-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/757

Range-diff vs v1:

 1:  08ad8fe7af ! 1:  571fa7dd3d dir.c: fix comments to agree with argument name
     @@ dir.c: static int add_patterns_from_buffer(char *buf, size_t size,
        * exclude rules in "pl".
        *
      - * If "ss" is not NULL, compute SHA-1 of the exclude file and fill
     -+ * If "oid_stat" is not NULL, compute SHA-1 of the exclude file and fill
     ++ * If "oid_stat" is not NULL, compute oid of the exclude file and fill
        * stat data from disk (only valid if add_patterns returns zero). If
      - * ss_valid is non-zero, "ss" must contain good value as input.
      + * oid_stat.valid is non-zero, "oid_stat" must contain good value as input.


 dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 78387110e6..ebea5f1f91 100644
--- a/dir.c
+++ b/dir.c
@@ -1040,9 +1040,9 @@ static int add_patterns_from_buffer(char *buf, size_t size,
  * an index if 'istate' is non-null), parse it and store the
  * exclude rules in "pl".
  *
- * If "ss" is not NULL, compute SHA-1 of the exclude file and fill
+ * If "oid_stat" is not NULL, compute oid of the exclude file and fill
  * stat data from disk (only valid if add_patterns returns zero). If
- * ss_valid is non-zero, "ss" must contain good value as input.
+ * oid_stat.valid is non-zero, "oid_stat" must contain good value as input.
  */
 static int add_patterns(const char *fname, const char *base, int baselen,
 			struct pattern_list *pl, struct index_state *istate,
@@ -1090,7 +1090,7 @@ static int add_patterns(const char *fname, const char *base, int baselen,
 			int pos;
 			if (oid_stat->valid &&
 			    !match_stat_data_racy(istate, &oid_stat->stat, &st))
-				; /* no content change, ss->sha1 still good */
+				; /* no content change, oid_stat->oid still good */
 			else if (istate &&
 				 (pos = index_name_pos(istate, fname, strlen(fname))) >= 0 &&
 				 !ce_stage(istate->cache[pos]) &&

base-commit: d4a392452e292ff924e79ec8458611c0f679d6d4
-- 
gitgitgadget
