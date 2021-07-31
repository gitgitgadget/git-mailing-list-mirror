Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B33C4338F
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 17:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB90C61042
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 17:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhGaR1u (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Jul 2021 13:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhGaR1u (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Jul 2021 13:27:50 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5223DC0613D3
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 10:27:43 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id d131-20020a1c1d890000b02902516717f562so8426353wmd.3
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 10:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=AXse4muAeaYC3gLbixhZ8tneVeIz+kqzyPqgyg820Pk=;
        b=nS0VXZ5ujYoNb5Thi+kNXBD+9FGjqSBYNfZTR/CKsGtfl3ySCYGOpXvBwcFNNoJtRP
         aTqCUnSQthZLbeakcyBa5zOW8BNoy/BUGcrE/EPUBCj4cEAyRK+fknZLQ6yqeLR55ZaY
         H5kICoedd3ne5UeSbVsKoTzvWNmmEKXANq/Q0JBrL80dL2yKGNZkR/0jlbp7ElC6RPzG
         PM4r+I5m/Zyp+2Y0JZFb/oSrewlmWk0l1AFF5A6w7Hau2I4llpouT75cLrXlqDw4fK4E
         sD9MMI2AxXkC/+GNUmWF00ppBqgOBSHs1FtyksXjWStrnUe1wYCbCJ45usS4Wkdpg6un
         +f8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=AXse4muAeaYC3gLbixhZ8tneVeIz+kqzyPqgyg820Pk=;
        b=MnkbgU2JuGdeYrUYszKboM60x2z55pwVpbb1CBqBvn7VVCmDJ6k0Fps0Kb+yG3Iv8J
         mU6NmC11aooNpt00o9/9n0e2XW4wb1Ia/AqadlAL3qqivEjUFQegil+TorWGrttx9YKw
         R/oB42+36332DCdcFQxzDacN45/SReEKYcuMYKOMngOLfEru8XMuXKPfeqw2naUTIboD
         ezWZUPcJlAh44D28tl8HzzAi/dQBi5sM1ASD1+2CPzlmoyHEhib8DFCcUfLIK3YxvqmC
         o0/WEFFo9Iin+wMNschM5kQ8b9jOrhFLPQ3A8sNBMYgsVISNyzp4RCrlVjwoWVEVHT8a
         UK+g==
X-Gm-Message-State: AOAM533ZSGTIeNYauMN1f3ZFtPsZAQ1X/x4u129yRqlf7wAW1e1CkJ67
        VTEKyJ3d8Uyx6xuHQ4A09SUzUuQvpNk=
X-Google-Smtp-Source: ABdhPJxDJ2+9Ml5m11uyZs05Yd4DPWE4sQ656pFXUOnaFoo0P0CPmFPpwyd1OP8XrePAZGd1yBjCnA==
X-Received: by 2002:a05:600c:154d:: with SMTP id f13mr8928188wmg.0.1627752461976;
        Sat, 31 Jul 2021 10:27:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v6sm5491361wru.50.2021.07.31.10.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 10:27:41 -0700 (PDT)
Message-Id: <8416afa89fb9d1e638bf6f52403f113c82de7424.1627752458.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.990.v4.git.1627752458.gitgitgadget@gmail.com>
References: <pull.990.v3.git.1627645664.gitgitgadget@gmail.com>
        <pull.990.v4.git.1627752458.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 31 Jul 2021 17:27:31 +0000
Subject: [PATCH v4 2/9] diffcore-rename: use a mem_pool for exact rename
 detection's hashmap
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Exact rename detection, via insert_file_table(), uses a hashmap to store
files by oid.  Use a mem_pool for the hashmap entries so these can all be
allocated and deallocated together.

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28),
this change improves the performance as follows:

                            Before                  After
    no-renames:      204.2  ms ±  3.0  ms   202.5  ms ±  3.2  ms
    mega-renames:      1.076 s ±  0.015 s     1.072 s ±  0.012 s
    just-one-mega:   364.1  ms ±  7.0  ms   357.3  ms ±  3.9  ms

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 4ef0459cfb5..73d884099eb 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -317,10 +317,11 @@ static int find_identical_files(struct hashmap *srcs,
 }
 
 static void insert_file_table(struct repository *r,
+			      struct mem_pool *pool,
 			      struct hashmap *table, int index,
 			      struct diff_filespec *filespec)
 {
-	struct file_similarity *entry = xmalloc(sizeof(*entry));
+	struct file_similarity *entry = mem_pool_alloc(pool, sizeof(*entry));
 
 	entry->index = index;
 	entry->filespec = filespec;
@@ -336,7 +337,8 @@ static void insert_file_table(struct repository *r,
  * and then during the second round we try to match
  * cache-dirty entries as well.
  */
-static int find_exact_renames(struct diff_options *options)
+static int find_exact_renames(struct diff_options *options,
+			      struct mem_pool *pool)
 {
 	int i, renames = 0;
 	struct hashmap file_table;
@@ -346,7 +348,7 @@ static int find_exact_renames(struct diff_options *options)
 	 */
 	hashmap_init(&file_table, NULL, NULL, rename_src_nr);
 	for (i = rename_src_nr-1; i >= 0; i--)
-		insert_file_table(options->repo,
+		insert_file_table(options->repo, pool,
 				  &file_table, i,
 				  rename_src[i].p->one);
 
@@ -354,8 +356,8 @@ static int find_exact_renames(struct diff_options *options)
 	for (i = 0; i < rename_dst_nr; i++)
 		renames += find_identical_files(&file_table, i, options);
 
-	/* Free the hash data structure and entries */
-	hashmap_clear_and_free(&file_table, struct file_similarity, entry);
+	/* Free the hash data structure (entries will be freed with the pool) */
+	hashmap_clear(&file_table);
 
 	return renames;
 }
@@ -1341,6 +1343,7 @@ void diffcore_rename_extended(struct diff_options *options,
 	int num_destinations, dst_cnt;
 	int num_sources, want_copies;
 	struct progress *progress = NULL;
+	struct mem_pool local_pool;
 	struct dir_rename_info info;
 	struct diff_populate_filespec_options dpf_options = {
 		.check_binary = 0,
@@ -1409,11 +1412,18 @@ void diffcore_rename_extended(struct diff_options *options,
 		goto cleanup; /* nothing to do */
 
 	trace2_region_enter("diff", "exact renames", options->repo);
+	mem_pool_init(&local_pool, 32*1024);
 	/*
 	 * We really want to cull the candidates list early
 	 * with cheap tests in order to avoid doing deltas.
 	 */
-	rename_count = find_exact_renames(options);
+	rename_count = find_exact_renames(options, &local_pool);
+	/*
+	 * Discard local_pool immediately instead of at "cleanup:" in order
+	 * to reduce maximum memory usage; inexact rename detection uses up
+	 * a fair amount of memory, and mem_pools can too.
+	 */
+	mem_pool_discard(&local_pool, 0);
 	trace2_region_leave("diff", "exact renames", options->repo);
 
 	/* Did we only want exact renames? */
-- 
gitgitgadget

