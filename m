Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAAFC71155
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 02:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B38A221EB
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 02:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fR9sa/Zk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgJMAlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 20:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgJMAlA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 20:41:00 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047AFC0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 17:41:00 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j136so19781160wmj.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 17:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Muujgt417JEkdvHe28Rt9c6zu2G+4ovZmfbKD5m49hc=;
        b=fR9sa/ZkqOpe0nba5BPZM01hiFgBmBj/u98L/Qa2emL+IXieVsy1xoG4QsX1e40X0w
         pxsRhlJN85H9FGdstLkPDPj51RMO+fPCJ56UHvYyA07O/l8uqdEWo/9ElSJpmqePDUfe
         o/+dMWvU5YBfoQHYKRafodMZxoE4iL2BZTOCnNmoL3HpWXLyk/NXR1mRWBow8oAPxQCA
         HrH5B0f2k/EhTcBZZ6QQbJ7+Qtr8cs7mbk36sxsK1mHe9MWDyGcvxl+qll3ZuBjHIZj/
         /OhhYhE4Fn1kgJrFv2lYxR15m6WaaYAjyvbKQ5DwLyh7QGh18XXleJoDRnMyxuqangV1
         SxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Muujgt417JEkdvHe28Rt9c6zu2G+4ovZmfbKD5m49hc=;
        b=ezZvtTlTYRfQiGOGhMoAREayCE/yfrYPfV/+XvIMC3DbQymVMWZIJR6UZlPqbe3pKy
         EXOuwfHwVRvih3bkHcDJQBI31CHCPYtOaPetcfhhrEItgTFyJ4ZEPU3ABlMKYDBlTEbj
         vtOk4Eukea/nyn3AYJJeVeuZfV3gz0esXRg47dmWV4/rWycZlonyMMG952Q61gcfOFyI
         k14qfRrJEgh7ajeqQoIfsoI88IXELkYDSPioipgKkob7OBs0N+lknKpWM3q5d7lJVhti
         mGsw0oTz335CAEEcUDNktUOYwZ1P7YYlEmhoaSPd280HSALYQlOcO8UJfZbAtWx8yRg2
         nfAw==
X-Gm-Message-State: AOAM530GEgWWsddLxjCwHmMZagunSDpnE6t9jKy6jjmH5PINWAsKinKz
        X5rry0daXr9bXHFV9oS2C/hT6kvGP+Q=
X-Google-Smtp-Source: ABdhPJzthn+kBSvj9zbR6R1FQfeoK5XQPhz78WJLkDWnAXbaqDuoe2EQYjCImzlk8yYGfNRH0i4/ww==
X-Received: by 2002:a05:600c:4147:: with SMTP id h7mr12508951wmm.45.1602549658618;
        Mon, 12 Oct 2020 17:40:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o4sm8313049wrv.8.2020.10.12.17.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 17:40:58 -0700 (PDT)
Message-Id: <2ebce0c5d82b87fa9c9ef5dcefc0ac2701654f3b.1602549650.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
        <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Oct 2020 00:40:47 +0000
Subject: [PATCH v2 07/10] strmap: enable faster clearing and reusing of
 strmaps
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When strmaps are used heavily, such as is done by my new merge-ort
algorithm, and strmaps need to be cleared but then re-used (because of
e.g. picking multiple commits to cherry-pick, or due to a recursive
merge having several different merges while recursing), free-ing and
reallocating map->table repeatedly can add up in time, especially since
it will likely be reallocated to a much smaller size but the previous
merge provides a good guide to the right size to use for the next merge.

Introduce strmap_partial_clear() to take advantage of this type of
situation; it will act similar to strmap_clear() except that
map->table's entries are zeroed instead of map->table being free'd.
Making use of this function reduced the cost of reset_maps() by about
20% in mert-ort, and dropped the overall runtime of my rebase testcase
by just under 2%.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 strmap.c | 6 ++++++
 strmap.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/strmap.c b/strmap.c
index 909b9fbedf..47cbf11ec7 100644
--- a/strmap.c
+++ b/strmap.c
@@ -64,6 +64,12 @@ void strmap_clear(struct strmap *map, int free_util)
 	hashmap_free(&map->map);
 }
 
+void strmap_partial_clear(struct strmap *map, int free_util)
+{
+	strmap_free_entries_(map, free_util);
+	hashmap_partial_clear(&map->map);
+}
+
 void *strmap_put(struct strmap *map, const char *str, void *data)
 {
 	struct strmap_entry *entry = find_strmap_entry(map, str);
diff --git a/strmap.h b/strmap.h
index e49d020970..5bb7650d65 100644
--- a/strmap.h
+++ b/strmap.h
@@ -34,6 +34,12 @@ void strmap_ocd_init(struct strmap *map,
  */
 void strmap_clear(struct strmap *map, int free_values);
 
+/*
+ * Similar to strmap_clear() but leaves map->map->table allocated and
+ * pre-sized so that subsequent uses won't need as many rehashings.
+ */
+void strmap_partial_clear(struct strmap *map, int free_values);
+
 /*
  * Insert "str" into the map, pointing to "data".
  *
-- 
gitgitgadget

