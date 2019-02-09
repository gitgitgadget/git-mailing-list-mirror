Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 875711F453
	for <e@80x24.org>; Sat,  9 Feb 2019 11:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfBILXi (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 06:23:38 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36819 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfBILXi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 06:23:38 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so2960784plo.3
        for <git@vger.kernel.org>; Sat, 09 Feb 2019 03:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vaeKaNk+P8dqyIlDmS8jxk0Z8L/asmEnesFvqetIIhA=;
        b=gkNGh4tPgd2vMeprWlr7bQMEP7rHKQO9ZsH+sV5spgzhho9AwAR5i+P6KGP2Vhu8Cl
         EshCSMMsY5gOXoNX/GEm28vdAU8HZ4mFiwKRNfhHP8+xYJ5OkLjQMiZZWiIDf4hEWC1S
         wtwb01JbvtTT5FFYAGg4Qf2xxdL6IxmZN6uyr/dlih85WHfrt3YVloctFycABqwF99Fe
         f/v0D+e8Jy5rpSOVsWPoMEoEnoKoq5V7HY5czI/yQ+X8WS5K8xvh8ckAuOkrLIfY0gyn
         wcLvAhCsaGi/9GJA1NkBH5MgHnzYoQxpgQ3OyDE9ANmnWX4upcHUfP7QehVaB7LgAf0u
         X6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vaeKaNk+P8dqyIlDmS8jxk0Z8L/asmEnesFvqetIIhA=;
        b=FUc0FdmcR7f/uxTK40nM5YKLqCBflRrfMUekJXIynX5DbtgQSNOVg2LG1dLBHtvXbr
         wK6iDMm8Ee8E8C/4IXMoceDialz4VQB0oxvWnHACm+3m1tnS9p4HvYZlVEcTly72XIJr
         NDSIcp5BVebEi0vgbEMNqH9N9DtW8OCR3JQaG4dWrKQ0NPDihjfitggMsqXhluH25ZQU
         GOLpHQOXFQHoLJdR12Y9JPg0udvd88dy3dJuxB5Eson2cFBXQFS3yh/nWgXyoLv5VBpg
         bmzWhdJTLjP3q5EZw/Lb5rM6FnGz3ijdbizhKNVQe2DNKaacouRCwW5bGeJnIus55pWu
         c0iA==
X-Gm-Message-State: AHQUAuYCyaJs5NZSqENw33bCgo0LpnTHMzpOqsnAnqNhzNeZNBikTsau
        keQr9gbH8KkAOeqzbYyqrDk=
X-Google-Smtp-Source: AHgI3IZjm76xQ+m9ORqmjnRnebjcFakPuIK18rRGKvt2NtYt7kAuj1RUEW1VfBfP6mC30xTfj4lbNA==
X-Received: by 2002:a17:902:4025:: with SMTP id b34mr28223335pld.181.1549711416962;
        Sat, 09 Feb 2019 03:23:36 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id g136sm8161684pfb.154.2019.02.09.03.23.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 03:23:35 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 09 Feb 2019 18:23:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     luke@diamand.org
Cc:     christian.couder@gmail.com, git@vger.kernel.org, newren@gmail.com,
        pclouds@gmail.com, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] unpack-trees.c: fix writing "link" index ext with null base oid
Date:   Sat,  9 Feb 2019 18:23:28 +0700
Message-Id: <20190209112328.26317-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <CAE5ih79JYrcV9cxMBU88Hq=HHQOOyzpkq+kT2zAgDzs=ao+PMg@mail.gmail.com>
References: <CAE5ih79JYrcV9cxMBU88Hq=HHQOOyzpkq+kT2zAgDzs=ao+PMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since commit 7db118303a (unpack_trees: fix breakage when o->src_index !=
o->dst_index - 2018-04-23) and changes in merge code to use separate
index_state for source and destination, when doing a merge with split
index activated, we may run into this line in unpack_trees():

    o->result.split_index = init_split_index(&o->result);

This is by itself not wrong. But this split index information is not
fully populated (and it's only so when move_cache_to_base_index() is
called, aka force splitting the index, or loading index_state from a
file). Both "base_oid" and "base" in this case remain null.

So when writing the main index down, we link to this index with null
oid (default value after init_split_index()), which also means "no split
index" internally. This triggers an incorrect base index refresh:

    warning: could not freshen shared index '.../sharedindex.0{40}'

This patch makes sure we will not refresh null base_oid (because the
file is never there). It also makes sure not to write "link" extension
with null base_oid in the first place (no point having it at
all). Read code already has protection against null base_oid.

There is also another side fix in remove_split_index() that causes a
crash when doing "git update-index --no-split-index" when base_oid in
the index file is null. In this case we will not load
istate->split_index->base but we dereference it anyway and are rewarded
with a segfault. This should not happen anymore, but it's still wrong to
dereference a potential NULL pointer, especially when we do check for
NULL pointer in the next code.

Reported-by: Luke Diamand <luke@diamand.org>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 I considered adding a test, but since the problem is a warning, not
 sure how to catch that. And a test would not be able to verify all
 changes in this patch anyway.

 read-cache.c  |  5 +++--
 split-index.c | 34 ++++++++++++++++++----------------
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 0e0c93edc9..d6fb09984f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2894,7 +2894,8 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 			return -1;
 	}
 
-	if (!strip_extensions && istate->split_index) {
+	if (!strip_extensions && istate->split_index &&
+	    !is_null_oid(&istate->split_index->base_oid)) {
 		struct strbuf sb = STRBUF_INIT;
 
 		err = write_link_extension(&sb, istate) < 0 ||
@@ -3189,7 +3190,7 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 	ret = write_split_index(istate, lock, flags);
 
 	/* Freshen the shared index only if the split-index was written */
-	if (!ret && !new_shared_index) {
+	if (!ret && !new_shared_index && !is_null_oid(&si->base_oid)) {
 		const char *shared_index = git_path("sharedindex.%s",
 						    oid_to_hex(&si->base_oid));
 		freshen_shared_index(shared_index, 1);
diff --git a/split-index.c b/split-index.c
index 5820412dc5..a9d13611a4 100644
--- a/split-index.c
+++ b/split-index.c
@@ -440,24 +440,26 @@ void add_split_index(struct index_state *istate)
 void remove_split_index(struct index_state *istate)
 {
 	if (istate->split_index) {
-		/*
-		 * When removing the split index, we need to move
-		 * ownership of the mem_pool associated with the
-		 * base index to the main index. There may be cache entries
-		 * allocated from the base's memory pool that are shared with
-		 * the_index.cache[].
-		 */
-		mem_pool_combine(istate->ce_mem_pool, istate->split_index->base->ce_mem_pool);
+		if (istate->split_index->base) {
+			/*
+			 * When removing the split index, we need to move
+			 * ownership of the mem_pool associated with the
+			 * base index to the main index. There may be cache entries
+			 * allocated from the base's memory pool that are shared with
+			 * the_index.cache[].
+			 */
+			mem_pool_combine(istate->ce_mem_pool,
+					 istate->split_index->base->ce_mem_pool);
 
-		/*
-		 * The split index no longer owns the mem_pool backing
-		 * its cache array. As we are discarding this index,
-		 * mark the index as having no cache entries, so it
-		 * will not attempt to clean up the cache entries or
-		 * validate them.
-		 */
-		if (istate->split_index->base)
+			/*
+			 * The split index no longer owns the mem_pool backing
+			 * its cache array. As we are discarding this index,
+			 * mark the index as having no cache entries, so it
+			 * will not attempt to clean up the cache entries or
+			 * validate them.
+			 */
 			istate->split_index->base->cache_nr = 0;
+		}
 
 		/*
 		 * We can discard the split index because its
-- 
2.20.1.682.gd5861c6d90

