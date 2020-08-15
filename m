Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93691C433E3
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B43520639
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAgwMp+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgHOWHb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbgHOVun (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:50:43 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFFCC0F26D6
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 10:38:00 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f1so11043135wro.2
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 10:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JN0XG4SH9Q+Mx7tQscEwp7Puync+1/gM+KJGF6f8RhA=;
        b=FAgwMp+mucHgl1m1lfMyn2RyamgeKtIYFaoah4q9D/opVBurhMj+4xGFcUz18spOwH
         jZhnxpKjji1Xy5RfzCWscclr4Q8woMQXZfJ8352qkZvGXxgwxOkS10qknsSTbkYhPtLZ
         HoZMdg2hurEUak6W1926c8/3HYPkJRHX0+dgTa4OCyQyeQp42j4lhwHhikSvD6PJ6sl/
         MdpGNpj8zq6oLwagusTvO+27UVMYMfXzEBBChlriGFUGqyIGBmYkdMi4hudIEYfxkK2J
         FEGP827zDYrL5oLvFsItvB2bUQAcvFfuaFjvzEz4M8KiOa09u78H1HYBG3fd9Qyv6E0f
         eoRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JN0XG4SH9Q+Mx7tQscEwp7Puync+1/gM+KJGF6f8RhA=;
        b=axH2gYCZaKxJ3DtJIA6yITFW5B2Hp2+Qllca0hQrL4O2FyF2anVkahlCB/fcElaKon
         ZS3MapAdtR7tfvxPXrq9Os53+MZDkX9TOzC0v0wb8z82CRgJpzBR4u2hLpy2mLcS3IuG
         oC0uMGeabgskTjvwihgDx8kID7xR2Y8/D3sWSP2lXDOuDaTUei7kWO7OAStRJ+xSkcdX
         d87Dc7ipjSLtmnGmyCFcYsPjPoq4HEF6Tz026/G+YmFOwC1WFu/aS3Gjc1F3dg0rCxvn
         VfO/EMqC9iB2N3MWX3rv+4V3WevqpDj/n7tDoGFKvYhhm4aJq9PSMsQaDgpoN576WgRw
         ZT/g==
X-Gm-Message-State: AOAM530GMI+r9bxQNNAd8BEvqsFzflYbAtgILPIB5MA19hMB2H4GQCsy
        knfMLrlsiR6qyoOUttFAnaRlLuzUuBg=
X-Google-Smtp-Source: ABdhPJzmmY+n/sgqvIdsAjN0zQEX0PZ77799F7eubgufejAfUwjMjvw2sisDdXE7aCdUJuI/TBKujw==
X-Received: by 2002:a5d:56c9:: with SMTP id m9mr7549475wrw.311.1597513079356;
        Sat, 15 Aug 2020 10:37:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p3sm21384988wma.44.2020.08.15.10.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 10:37:58 -0700 (PDT)
Message-Id: <pull.830.v3.git.git.1597513078.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v2.git.git.1597384820.gitgitgadget@gmail.com>
References: <pull.830.v2.git.git.1597384820.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Aug 2020 17:37:54 +0000
Subject: [PATCH v3 0/3] Extend and add a little more generalization to the mem_pool API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In my new merge algorithm, I made use of the mem_pool API in a few
places...but I also needed to add a few more functions and also needed to
make the API a bit more general.

Changes since v2:

 * Remove 'x' from mem_pool_xstr[n]?dup() names and remove check for NULL
   since mem_pool_alloc() already handles that (via xmalloc), as suggested
   by René
 * Rewrite mem_pool_strndup() to not rely on strnlen(), since that may be
   too new from some systems (comes from POSIX 2008 ). Also pointed out by
   René

Elijah Newren (3):
  mem-pool: add convenience functions for strdup and strndup
  mem-pool: use more standard initialization and finalization
  mem-pool: use consistent pool variable name

 fast-import.c | 12 ++-------
 mem-pool.c    | 69 ++++++++++++++++++++++++++++++---------------------
 mem-pool.h    | 14 ++++++++---
 read-cache.c  | 21 ++++++++++------
 split-index.c |  6 +++--
 5 files changed, 70 insertions(+), 52 deletions(-)


base-commit: 7814e8a05a59c0cf5fb186661d1551c75d1299b5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-830%2Fnewren%2Fmem_pool_api-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-830/newren/mem_pool_api-v3
Pull-Request: https://github.com/git/git/pull/830

Range-diff vs v2:

 1:  6d679c5b46 ! 1:  e7f6bf8a8c mem-pool: add convenience functions for xstrdup and xstrndup
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    mem-pool: add convenience functions for xstrdup and xstrndup
     +    mem-pool: add convenience functions for strdup and strndup
      
     -    fast-import had a special mem_pool_xstrdup() convenience function that I
     +    fast-import had a special mem_pool_strdup() convenience function that I
          want to be able to use from the new merge algorithm I am writing.  Move
     -    it from fast-import to mem-pool, and also add a mem_pool_xstrndup()
     +    it from fast-import to mem-pool, and also add a mem_pool_strndup()
          while at it that I also want to use.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     @@ fast-import.c: static struct branch *new_branch(const char *name)
       
       	b = mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct branch));
      -	b->name = pool_strdup(name);
     -+	b->name = mem_pool_xstrdup(&fi_mem_pool, name);
     ++	b->name = mem_pool_strdup(&fi_mem_pool, name);
       	b->table_next_branch = branch_table[hc];
       	b->branch_tree.versions[0].mode = S_IFDIR;
       	b->branch_tree.versions[1].mode = S_IFDIR;
     @@ fast-import.c: static void parse_new_tag(const char *arg)
       	t = mem_pool_alloc(&fi_mem_pool, sizeof(struct tag));
       	memset(t, 0, sizeof(struct tag));
      -	t->name = pool_strdup(arg);
     -+	t->name = mem_pool_xstrdup(&fi_mem_pool, arg);
     ++	t->name = mem_pool_strdup(&fi_mem_pool, arg);
       	if (last_tag)
       		last_tag->next_tag = t;
       	else
     @@ mem-pool.c: void *mem_pool_calloc(struct mem_pool *mem_pool, size_t count, size_
       	return r;
       }
       
     -+char *mem_pool_xstrdup(struct mem_pool *pool, const char *str)
     ++char *mem_pool_strdup(struct mem_pool *pool, const char *str)
      +{
      +	size_t len = strlen(str) + 1;
      +	char *ret = mem_pool_alloc(pool, len);
      +
     -+	if (!ret)
     -+		die(_("mem_pool_xstrdup: out of memory"));
     -+
      +	return memcpy(ret, str, len);
      +}
      +
     -+char *mem_pool_xstrndup(struct mem_pool *pool, const char *str, size_t len)
     ++char *mem_pool_strndup(struct mem_pool *pool, const char *str, size_t len)
      +{
     -+	size_t minlen = strnlen(str, len);
     -+	char *ret = mem_pool_alloc(pool, minlen+1);
     -+
     -+	if (!ret)
     -+		die(_("mem_pool_xstrndup: out of memory"));
     ++	char *p = memchr(str, '\0', len);
     ++	size_t actual_len = (p ? p - str : len);
     ++	char *ret = mem_pool_alloc(pool, actual_len+1);
      +
     -+	ret[minlen] = '\0';
     -+	return memcpy(ret, str, minlen);
     ++	ret[actual_len] = '\0';
     ++	return memcpy(ret, str, actual_len);
      +}
      +
       int mem_pool_contains(struct mem_pool *mem_pool, void *mem)
     @@ mem-pool.h: void *mem_pool_alloc(struct mem_pool *pool, size_t len);
      +/*
      + * Allocate memory from the memory pool and copy str into it.
      + */
     -+char *mem_pool_xstrdup(struct mem_pool *pool, const char *str);
     -+char *mem_pool_xstrndup(struct mem_pool *pool, const char *str, size_t len);
     ++char *mem_pool_strdup(struct mem_pool *pool, const char *str);
     ++char *mem_pool_strndup(struct mem_pool *pool, const char *str, size_t len);
      +
       /*
        * Move the memory associated with the 'src' pool to the 'dst' pool. The 'src'
 2:  e04ba96b22 = 2:  65f334f5cf mem-pool: use more standard initialization and finalization
 3:  616402c64e ! 3:  09976779c3 mem-pool: use consistent pool variable name
     @@ mem-pool.c: void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
       	memset(r, 0, len);
       	return r;
       }
     -@@ mem-pool.c: char *mem_pool_xstrndup(struct mem_pool *pool, const char *str, size_t len)
     - 	return memcpy(ret, str, minlen);
     +@@ mem-pool.c: char *mem_pool_strndup(struct mem_pool *pool, const char *str, size_t len)
     + 	return memcpy(ret, str, actual_len);
       }
       
      -int mem_pool_contains(struct mem_pool *mem_pool, void *mem)

-- 
gitgitgadget
