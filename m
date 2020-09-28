Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B9DC2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 16:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C21922074A
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 16:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="YwuH7odh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgI1QvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 12:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgI1QvL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 12:51:11 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A1BC061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 09:51:11 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id di5so769892qvb.13
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 09:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I9CKy8MeuENzQBrWoei2KikT+xhgjkuwc0rkDO+pb9g=;
        b=YwuH7odhdOG+CZwarqXLxvCQDgIUL9d+aLAGp5tSGzI5pc24wpg9I4S1jMkjynG+ps
         a07RF3LN6RvdHPQZ5/VJUQVwCclEofAEC/8Fh4f1Lu9QQevZkgou43PNcvwr6+aMnUOs
         EM3VfxeQ6/FFNPIyxW3mg/Ybzmqcsb09EScy4E7mXTm46guYk7imPYlfudIW72E6bSoQ
         u7DYLxYEtMwFogACcx7PkPnYj5/AUCmJYKthUVZ4cpfOsfyhUU9aR2YgefzPE/0Y2DbT
         8GCEaIZsaeEZmfpW4spDAek2SRuvbMQO0VT8liErpNN5unMBkjEmGyIp1n4wg2SQvLVB
         m9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I9CKy8MeuENzQBrWoei2KikT+xhgjkuwc0rkDO+pb9g=;
        b=nky5mlkEQcfNesemitoKIDHFfybe7IEQeHzkYKpaq6NowN1jTJCtq8TuSFK54evesW
         0zA1lhj2UC0oLfFt8klHyE6kJ81lhTtk2Yy7bUyJ4CWPfATPX0R+DWja1ImdNKcsOYk8
         zeVDNNJZzAmTDxoFhLlcKDglhYOqs83zsv1taoqIuylI/MiLdhw6hVBDDXFQJrjohvdS
         DhksEfLjlDK4v+cACbEt3bsVtIL9zmRrealUtsPlQGdP/LWX5GiJaJJFlJzpUFNo28KY
         7d3K1YQfXJN+mN0lbqKt8TtCU/VZG6T/f9J6NHxdY5V9Vr8AZfNAbXJYxtIq78wQg2k2
         i6lw==
X-Gm-Message-State: AOAM532RBc+FsWeo/w2NlGZFRTavajBZ6+2uc+zG6Zc0zVliknObu2Cf
        hijgN3TCCfrby/r2Kq88E653bzpo1N47qw==
X-Google-Smtp-Source: ABdhPJxOD0nbRSMcVs39f2nqX5VN3h9Gkx1EvSsQfYsG0tINvbvpFFMN4iWVZhh5FTgxuDp+PRFCAQ==
X-Received: by 2002:a05:6214:903:: with SMTP id dj3mr496107qvb.14.1601311870042;
        Mon, 28 Sep 2020 09:51:10 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.96.45])
        by smtp.gmail.com with ESMTPSA id u18sm1908358qtk.61.2020.09.28.09.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:51:08 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     phil.hord@gmail.com, dstolee@microsoft.com,
        jonathantanmy@google.com, stefanbeller@gmail.com
Subject: [PATCH 2/2] packfile: fix memory leak in add_delta_base_cache()
Date:   Mon, 28 Sep 2020 13:50:35 -0300
Message-Id: <5b6e3019e08c6bccdee29018e99b0c6933fe05e0.1601311803.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1601311803.git.matheus.bernardino@usp.br>
References: <cover.1601311803.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When add_delta_base_cache() is called with a base that is already in the
cache, no operation is performed. But the check is done after allocating
space for a new entry, so we end up leaking memory on the early return.
Also, the caller always expect that the base will be inserted, so it
never free()'s it. To fix both of these memory leaks, let's move the
allocation of a new entry further down in add_delta_base_cache(), and
make the function return an integer to indicate whether the insertion
was performed or not. Then, make the caller free() the base when needed.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 packfile.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/packfile.c b/packfile.c
index 0319418d88..177793e01a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1471,10 +1471,10 @@ void clear_delta_base_cache(void)
 	}
 }
 
-static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
+static int add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	void *base, unsigned long base_size, enum object_type type)
 {
-	struct delta_base_cache_entry *ent = xmalloc(sizeof(*ent));
+	struct delta_base_cache_entry *ent;
 	struct list_head *lru, *tmp;
 
 	/*
@@ -1483,7 +1483,7 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	 * and III might run concurrently across multiple threads).
 	 */
 	if (in_delta_base_cache(p, base_offset))
-		return;
+		return 0;
 
 	delta_base_cached += base_size;
 
@@ -1495,6 +1495,7 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 		release_delta_base_cache(f);
 	}
 
+	ent = xmalloc(sizeof(*ent));
 	ent->key.p = p;
 	ent->key.base_offset = base_offset;
 	ent->type = type;
@@ -1506,6 +1507,7 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 		hashmap_init(&delta_base_cache, delta_base_cache_hash_cmp, NULL, 0);
 	hashmap_entry_init(&ent->ent, pack_entry_hash(p, base_offset));
 	hashmap_add(&delta_base_cache, &ent->ent);
+	return 1;
 }
 
 int packed_object_info(struct repository *r, struct packed_git *p,
@@ -1841,8 +1843,10 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 		 * thread could free() it (e.g. to make space for another entry)
 		 * before we are done using it.
 		 */
-		if (!external_base)
-			add_delta_base_cache(p, base_obj_offset, base, base_size, type);
+		if (!external_base && !add_delta_base_cache(p, base_obj_offset,
+						base, base_size, type)) {
+			free(base);
+		}
 
 		free(delta_data);
 		free(external_base);
-- 
2.28.0

