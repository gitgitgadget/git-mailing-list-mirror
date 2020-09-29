Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C122C2D0A8
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 00:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 514542100A
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 00:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="i8bVLRUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgI2ACF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 20:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgI2ACF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 20:02:05 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0CFC0613D3
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 17:02:03 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id b2so2245092qtp.8
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 17:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x57YHKcn10Df4XhLLxpZuvC1zT6MVCZ0oCQk76ikuao=;
        b=i8bVLRUxmSxm60CaUgMwfujeAB/RbEucQK2u7M5GcWxxGxTKXVI5ZVgZyBHnAo50Dq
         UpY1R32pgurpgnCpEzrl1TPcA9RZ8wteSqxENW8ZGoinnbEZ2yodOWUWatGkEO79D591
         yFCRQHPcOSPrSkJvhoZiM9p2jd0iL45rWH5SpS5gJXhCM8KLE3Yi9NEq8+0pqbHBPizO
         8GcMe08eIFEBCD/YGXswnMNtO7tuomP/iGMNKC1uTUODz/JmTgN23xfMO5Kp5AOLoZEE
         4mILzY/UoTyi3WJysdXpZkziB0luRTEZVTmmgMack5EqLaND7c8tsJbZISh9y/gGGEKf
         eH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x57YHKcn10Df4XhLLxpZuvC1zT6MVCZ0oCQk76ikuao=;
        b=tWTcJlym8c8BCHwg6SC7ii5bX35He92FEdl32ftrO7cPNJIR6mNGgtEvoHYZlcGe07
         o6s8cZWBU/8VDYzrkGfiXj7X6ykD9p2UIrUeLFEJgM6bKff+ShIDCWBlXiw5g4Ae1BaU
         UJhIan5eOgOJKnQp233k2zlTJ+l+ceQ4rj0IXdN2ucpLAO1UY5Jx54YbEP6HqszZPDeb
         2Xzrk5EdJpMwzUDCwAVVwhzjkte3NN5xk8VgVyeTF0VVP1ZpjN4ZOqihP9LzNwGGJhYE
         5GA+0TcdWo2ULE+zt3l6um5kMDvtJcCswDuviTvmR7w8FjVXWfe3TDeFiS53sfb2O4bR
         ysSg==
X-Gm-Message-State: AOAM533KdIFM7cWZwNzIyaH+5IpUMi0zMXu/PChVZVnmq7viI7TcLXgv
        dqqcEmG989oIRfCDQAMsx1lV8UV6j8m73g==
X-Google-Smtp-Source: ABdhPJywtk2syydacd9k2xZKjNQo215tr0o1GCoWUk0md7plsmc2eDyZDa0nrxncmDC7g6vhl7MeTw==
X-Received: by 2002:aed:34c1:: with SMTP id x59mr679877qtd.374.1601337721893;
        Mon, 28 Sep 2020 17:02:01 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.96.45])
        by smtp.gmail.com with ESMTPSA id f14sm2567545qkh.134.2020.09.28.17.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 17:02:01 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     phil.hord@gmail.com, dstolee@microsoft.com,
        jonathantanmy@google.com, stefanbeller@gmail.com, gitster@pobox.com
Subject: [PATCH v2 0/2] Fix race condition and memory leak in delta base cache
Date:   Mon, 28 Sep 2020 21:01:51 -0300
Message-Id: <cover.1601337543.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1601311803.git.matheus.bernardino@usp.br>
References: <cover.1601311803.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v1:

- Reworded patch one to remove misleading sentence about the locking
  during step 2.
- In patch two, let add_delta_base_cache() take full ownership of the
  base, properly releasing it when the insertion is skipped.

Matheus Tavares (2):
  packfile: fix race condition on unpack_entry()
  packfile: fix memory leak in add_delta_base_cache()

 packfile.c | 48 +++++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 19 deletions(-)

Range-diff against v1:
1:  42a7948f94 ! 1:  948d07673f packfile: fix race condition on unpack_entry()
    @@ Commit message
         objects.
     
         To fix the race condition (and later segmentation fault), let's reorder
    -    the aforementioned steps so that the lock is not released between 1.
    -    and 3. An alternative solution which would not require the reordering
    -    would be to duplicate `base` before inserting it in the cache.
    -    However, as Phil Hord mentioned, memcpy()'ing large bases can negatively
    -    affect performance: in his experiments, this alternative approach slowed
    -    git-grep down by 10% to 20%.
    +    the aforementioned steps so that `base` is only added to the cache at
    +    the end. This will prevent the buffer from being released by another
    +    thread while it is still in use. An alternative solution which would not
    +    require the reordering would be to duplicate `base` before inserting it
    +    in the cache. However, as Phil Hord mentioned, memcpy()'ing large bases
    +    can negatively affect performance: in his experiments, this alternative
    +    approach slowed git-grep down by 10% to 20%.
     
         Reported-by: Phil Hord <phil.hord@gmail.com>
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
2:  5b6e3019e0 ! 2:  f15f0c82fd packfile: fix memory leak in add_delta_base_cache()
    @@ Commit message
         When add_delta_base_cache() is called with a base that is already in the
         cache, no operation is performed. But the check is done after allocating
         space for a new entry, so we end up leaking memory on the early return.
    -    Also, the caller always expect that the base will be inserted, so it
    -    never free()'s it. To fix both of these memory leaks, let's move the
    +    In addition, the caller never free()'s the base as it expects the
    +    function to take ownership of it. But the base is not released when we
    +    skip insertion, so it also gets leaked. To fix these problems, move the
         allocation of a new entry further down in add_delta_base_cache(), and
    -    make the function return an integer to indicate whether the insertion
    -    was performed or not. Then, make the caller free() the base when needed.
    +    free() the base on early return.
     
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
      ## packfile.c ##
     @@ packfile.c: void clear_delta_base_cache(void)
    - 	}
    - }
    - 
    --static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
    -+static int add_delta_base_cache(struct packed_git *p, off_t base_offset,
    + static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
      	void *base, unsigned long base_size, enum object_type type)
      {
     -	struct delta_base_cache_entry *ent = xmalloc(sizeof(*ent));
    @@ packfile.c: void clear_delta_base_cache(void)
      
      	/*
     @@ packfile.c: static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
    + 	 * is unpacking the same object, in unpack_entry() (since its phases I
      	 * and III might run concurrently across multiple threads).
      	 */
    - 	if (in_delta_base_cache(p, base_offset))
    --		return;
    -+		return 0;
    +-	if (in_delta_base_cache(p, base_offset))
    ++	if (in_delta_base_cache(p, base_offset)) {
    ++		free(base);
    + 		return;
    ++	}
      
      	delta_base_cached += base_size;
      
    @@ packfile.c: static void add_delta_base_cache(struct packed_git *p, off_t base_of
      	ent->key.p = p;
      	ent->key.base_offset = base_offset;
      	ent->type = type;
    -@@ packfile.c: static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
    - 		hashmap_init(&delta_base_cache, delta_base_cache_hash_cmp, NULL, 0);
    - 	hashmap_entry_init(&ent->ent, pack_entry_hash(p, base_offset));
    - 	hashmap_add(&delta_base_cache, &ent->ent);
    -+	return 1;
    - }
    - 
    - int packed_object_info(struct repository *r, struct packed_git *p,
    -@@ packfile.c: void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
    - 		 * thread could free() it (e.g. to make space for another entry)
    - 		 * before we are done using it.
    - 		 */
    --		if (!external_base)
    --			add_delta_base_cache(p, base_obj_offset, base, base_size, type);
    -+		if (!external_base && !add_delta_base_cache(p, base_obj_offset,
    -+						base, base_size, type)) {
    -+			free(base);
    -+		}
    - 
    - 		free(delta_data);
    - 		free(external_base);
-- 
2.28.0

