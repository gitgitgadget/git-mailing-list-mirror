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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F221C433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 08:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEF4261178
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 08:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbhIOInj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 04:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhIOIni (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 04:43:38 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD53C061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 01:42:20 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b6so2539161wrh.10
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 01:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=5dUvIHMVOAlV1y/081FL+5gbjWge1c8a3/RQCKsT7Vs=;
        b=E69tQBTtj9FelVmlyCOBr3RRlUMO6a7YYTXiZ0hVJteYBa7H5Q1/aoFCz8Z0Lx+OqO
         2Lmi/0Jvrnq/WAreWf5He458c2OFmyYyK718VKFcm8ZvcUB4gCWVBovQqd0WUufrv3K/
         fzJ3UxiCHQReXeLZ08NFEkf4qmp9nzomctMyW63xSDl7em7nMptuJVlPgwd0w8SgNoYo
         E/GK3ma0C9WzqE/WLU/XPccvwJ4hbMYFDi6wDNzrnEnRu8Bdk8e28qFM1k1OWQkVZBbO
         Em7CpPGyRZqfvl7d6evogprw7kH3qPhgmUHm20gppXW8ogQoT7BbRK4Xqn66BuPQNf1z
         ccuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5dUvIHMVOAlV1y/081FL+5gbjWge1c8a3/RQCKsT7Vs=;
        b=63uoOZBnY7CKc1HiAcJm80peHPNJMIu1WjC0RkwpbXInee9bCl0IyqaFjawUi4Dej5
         dOm4QcMRQK4maR+CkGFnYLtDTIQczSyUKZsqoiu9YuiNOisaYVMDbmJm/ehl43AzjaOp
         oAYQEi8D1ZAqvRU1gWXpEc5gwS5NR06JMPuqwEi3NVQcnXGJo/spGDUePhj/2NWUi+wC
         TgUkJY3+oO18o0Yq/B7sQIkZ4Q70dHrUkz6s3E+ESS86VSdt9CVUv8Vk0H6+2RtmKNNC
         6LSVTyAY85wz3o+dl6V07emTwNgy9cTxlfnetjFZ3cpvjXCgOTiNpSgUyGydBPIK2/kk
         qong==
X-Gm-Message-State: AOAM533ncp6a44n7Bz2K3N1FqREUzWwAtQgMPPgCQisVgkyKmGGb1CTn
        UPL/W+zpcrBKrYdHA9gv8A3XTgFYwh8=
X-Google-Smtp-Source: ABdhPJzHIYehi5/jsAVnhrbwAQwKXSMgn81Edpq2TARTG6HCAxYLJ8YSYIJJFpBRQbNDVztGiKpN/A==
X-Received: by 2002:adf:f805:: with SMTP id s5mr3498802wrp.259.1631695338821;
        Wed, 15 Sep 2021 01:42:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r5sm9393053wrm.79.2021.09.15.01.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 01:42:18 -0700 (PDT)
Message-Id: <pull.1039.git.1631695337775.gitgitgadget@gmail.com>
From:   "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Sep 2021 08:42:17 +0000
Subject: [PATCH] pack-revindex.h: fix typos of time complexity
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Kyle Zhao <keyu98@qq.com>,
        kylezhao <kylezhao@tencent.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: kylezhao <kylezhao@tencent.com>

Signed-off-by: kylezhao <kylezhao@tencent.com>
---
    pack-revindex.h: fix typos of time complexity
    
    It looks like the time complexity descriptions were written wrong.
    
    Regards, Kyle

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1039%2Fkeyu98%2Fkz%2Ffix-pack-revindex-typo-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1039/keyu98/kz/fix-pack-revindex-typo-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1039

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
