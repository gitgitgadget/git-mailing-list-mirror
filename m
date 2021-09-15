Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679D5C433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 09:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F1D361244
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 09:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbhIOJKq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 05:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbhIOJKp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 05:10:45 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AA0C061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 02:09:26 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t18so2776825wrb.0
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 02:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nu2LyjWwZAgUf1WAF7NkIAip5e/hmAdGRtIBXtEQ9XI=;
        b=f68/fqg//iE7pyM0rftsC+cZ9X2UYAwlBa7lN6rtwh7HQ90VwMHcw/TcdRfNr0OpIy
         VNsKRldGJdZvw5Tj/pjlt2lpe/XTKog6C460LSSYacOucm08rqI/aihofY6ZxxQsCLbC
         gwHmsmBWwDC6SvSf+qL5sME3LOxt3mVmxWEGcO74p1UxnIXCR2YPDvnHgxmOzH5LwC2q
         HwW8wVHediAHxnxNElGkXEr1bFZWzGXuaZP8k+wLZETrQkq9jrWm/hcEdISOx8IJOqds
         aDOj4REI21sBNwkfnECdtuql8YozBJFTk61yX8lAQodZVFr9/hyPlIMwLldE5aBPmTwC
         Lp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nu2LyjWwZAgUf1WAF7NkIAip5e/hmAdGRtIBXtEQ9XI=;
        b=SlN9b4nQLpXjMX8ylGPfQlVtIQo6WF7yZikID0wBfR8gtkaH3uHK8UCAuPn95y3Qwh
         Ot5VqpvSHCxFRu/BysfsAQ4/OlG+pxxf6Zy7U6LRmPx+jDUOeo+AxX0C7PMblnaOrSP6
         2BJ5cdElRD+jC6Kj3hzktms+4XmwBzvW2JU/vHlDFf2JGQhvvcnVPY7Rp9A1MzOLrsNm
         YhUPzPmSy8hjCZsufaKc7+noPEqOXGBlerDa1mWn1P9PR861KIxGjGtEzNerY0qIniZZ
         8aVkJKPuKimr5JNKT22cXHQz508F0SQFal/eVUVx6Old3LHRFpVM6VwI0RrI/NzMoWQ0
         eh4w==
X-Gm-Message-State: AOAM5328z99vB/QiEJtNvNW6zadQ1jFbUDga1m4EjbC5eINmODodaB3H
        BahuB62U31mVZjJpumsl1cuDBGdsU2c=
X-Google-Smtp-Source: ABdhPJygjly90kOFvrYe80gWeAMbI4YNKXjxFUevMMgipGPO+/BuBaWy0h3iXeOm1zhQArvZ2poAzA==
X-Received: by 2002:a5d:4285:: with SMTP id k5mr3902521wrq.131.1631696965127;
        Wed, 15 Sep 2021 02:09:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n66sm3609827wmn.2.2021.09.15.02.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 02:09:24 -0700 (PDT)
Message-Id: <pull.1039.v2.git.1631696964072.gitgitgadget@gmail.com>
In-Reply-To: <pull.1039.git.1631695337775.gitgitgadget@gmail.com>
References: <pull.1039.git.1631695337775.gitgitgadget@gmail.com>
From:   "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Sep 2021 09:09:23 +0000
Subject: [PATCH v2] pack-revindex.h: correct the time complexity descriptions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Kyle Zhao <keyu98@qq.com>, kylezhao <kylezhao@tencent.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: kylezhao <kylezhao@tencent.com>

Time complexities for pack_pos_to_midx and midx_to_pack_pos are swapped,
correct it.

Signed-off-by: kylezhao <kylezhao@tencent.com>
---
    pack-revindex.h: correct the time complexity descriptions
    
    It looks like the time complexity descriptions were written wrong.
    
    Regards, Kyle
    
    Changes since v1:
    
     * changed the commit message

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1039%2Fkeyu98%2Fkz%2Ffix-pack-revindex-typo-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1039/keyu98/kz/fix-pack-revindex-typo-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1039

Range-diff vs v1:

 1:  8915a8f55ba ! 1:  a2e9df25ac9 pack-revindex.h: fix typos of time complexity
     @@ Metadata
      Author: kylezhao <kylezhao@tencent.com>
      
       ## Commit message ##
     -    pack-revindex.h: fix typos of time complexity
     +    pack-revindex.h: correct the time complexity descriptions
     +
     +    Time complexities for pack_pos_to_midx and midx_to_pack_pos are swapped,
     +    correct it.
      
          Signed-off-by: kylezhao <kylezhao@tencent.com>
      


 pack-revindex.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pack-revindex.h b/pack-revindex.h
index 479b8f2f9c9..74f4eae668d 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -109,7 +109,7 @@ off_t pack_pos_to_offset(struct packed_git *p, uint32_t pos);
  * If the reverse index has not yet been loaded, or the position is out of
  * bounds, this function aborts.
  *
- * This function runs in time O(log N) with the number of objects in the MIDX.
+ * This function runs in constant time.
  */
 uint32_t pack_pos_to_midx(struct multi_pack_index *m, uint32_t pos);
 
@@ -120,7 +120,7 @@ uint32_t pack_pos_to_midx(struct multi_pack_index *m, uint32_t pos);
  * If the reverse index has not yet been loaded, or the position is out of
  * bounds, this function aborts.
  *
- * This function runs in constant time.
+ * This function runs in time O(log N) with the number of objects in the MIDX.
  */
 int midx_to_pack_pos(struct multi_pack_index *midx, uint32_t at, uint32_t *pos);
 

base-commit: 8b7c11b8668b4e774f81a9f0b4c30144b818f1d1
-- 
gitgitgadget
