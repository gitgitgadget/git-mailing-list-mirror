Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CB501F405
	for <e@80x24.org>; Tue, 18 Dec 2018 09:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeLRJ6j (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 04:58:39 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39590 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeLRJ6j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 04:58:39 -0500
Received: by mail-ot1-f65.google.com with SMTP id n8so15089425otl.6
        for <git@vger.kernel.org>; Tue, 18 Dec 2018 01:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=doJL7dT9HVq9KeAiuQ7Q3TuWeUn5HnclFmLDES3lZfM=;
        b=TPZvUpzkECo4dPH3Hif7fSgQQoJDB6w7Pv1S6uVYziR+1EUKvktV+xXB0hfKkKdZhc
         DXcj1xcTpJXiswOn6w9nxnbboKDW9iJEdy4ESeVOxEPxHR3D7KsvN56Lh8b6pfHXqXlo
         VhUKXk216JypSSt4RiShqvbloDSH/llsXkU3KtCCVj7gFxzNL2bV0gJEd99Tv9zyuWxr
         lM+bRFQoLRe8VYTobFfNAjnDA0dxQ/Sdhw5XiISytntA3PltoWlQ2W/19c2qmR2v/QVM
         sszxtq3WsLnZCUUG88DYiu0t95f5iiJOfd4jIXd8g6uQ7cPgviBOPoFRnTY4tmm6pny8
         obKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=doJL7dT9HVq9KeAiuQ7Q3TuWeUn5HnclFmLDES3lZfM=;
        b=jnYYGzTdwboSej7qG9dnh/Zo7xq6EZYeJzitS+hddogTlR7Ih5UH7lPwYDI/5Viv4A
         ZZGdEwg618QvgGvs9aPGzuYtZr1/71DRkmuZrYLRIyCHzxNjQLoyEvB+CRI5tZAf8nMG
         lhMX1t1Q09XmX4YwCMB2Cj7wc0wG9wj5WuScI0zN70cfQYUl88L/V5lk1tjzZHr2zMma
         0D6EPf5xowcr0iWcd3NUToOyUV8Ey8edorY3hm5reqaYl1080Vo86VYmTKjq005OqUK7
         F716sIS2R1Zd4nPXXumOIL2Fng/vUwWO9bEMVclEB5H2WGsYrOcZspfCDh6Yl4NbDDM9
         t8Qg==
X-Gm-Message-State: AA+aEWbXFxCKUXh7QYQuTFbl1AO+7d+q+ahwwZD9fWLmgo9up3O8laPx
        zejDhbkWekLFcXFcRo4u4/nid5ft
X-Google-Smtp-Source: AFSGD/XjrtBbCkVFo422i/U8ygUlckEFPjU6nW5cyTm6oPj9Rw+RbKyE7saIo94gy/btt7ZeMl8aIg==
X-Received: by 2002:a9d:6f95:: with SMTP id h21mr12216333otq.66.1545127117580;
        Tue, 18 Dec 2018 01:58:37 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.9])
        by smtp.gmail.com with ESMTPSA id p203sm11286075oic.49.2018.12.18.01.58.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 01:58:36 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Sun Chao <sunchao9@huawei.com>,
        =?UTF-8?q?Lukas=20Sandstr=C3=B6m?= <lukass@etek.chalmers.se>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH 1/2] pack-redundant: new algorithm to find min packs
Date:   Tue, 18 Dec 2018 17:58:28 +0800
Message-Id: <20181218095829.20092-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.0.2.g660e9286fc
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sun Chao <sunchao9@huawei.com>

When calling `git pack-redundant --all`, if there are too many local
packs and too many redundant objects within them, the too deep iteration
of `get_permutations` will exhaust all the resources, and the process of
`git pack-redundant` will be killed.

The following script could create a repository with too many redundant
packs, and running `git pack-redundant --all` in the `test.git` repo
will die soon.

    #!/bin/sh

    repo="$(pwd)/test.git"
    work="$(pwd)/test"
    i=1
    max=199

    if test -d "$repo" || test -d "$work"; then
    	echo >&2 "ERROR: '$repo' or '$work' already exist"
    	exit 1
    fi

    git init -q --bare "$repo"
    git --git-dir="$repo" config gc.auto 0
    git --git-dir="$repo" config transfer.unpackLimit 0
    git clone -q "$repo" "$work" 2>/dev/null

    while :; do
        cd "$work"
        echo "loop $i: $(date +%s)" >$i
        git add $i
        git commit -q -sm "loop $i"
        git push -q origin HEAD:master
        printf "\rCreate pack %4d/%d\t" $i $max
        if test $i -ge $max; then break; fi

        cd "$repo"
        git repack -q
        if test $(($i % 2)) -eq 0; then
            git repack -aq
            pack=$(ls -t $repo/objects/pack/*.pack | head -1)
            touch "${pack%.pack}.keep"
        fi
        i=$((i+1))
    done
    printf "\ndone\n"

To get the `min` unique pack list, we can replace the iteration in
`minimize` function with a new algorithm, and this could solve this
issue:

1. Get the unique and non_uniqe packs, add the unique packs to the
   `min` list.

2. Remove the objects of unique packs from non_unique packs, then each
   object left in the non_unique packs will have at least two copies.

3. Sort the non_unique packs by the objects' size, more objects first,
   and add the first non_unique pack to `min` list.

4. Drop the duplicated objects from other packs in the ordered
   non_unique pack list, and repeat step 3.

Original PR and discussions: https://github.com/jiangxin/git/pull/25

Signed-off-by: Sun Chao <sunchao9@huawei.com>
Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/pack-redundant.c | 116 ++++++++++++++++++++++++---------------
 1 file changed, 73 insertions(+), 43 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index cf9a9aabd4..19dcf74750 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -421,14 +421,52 @@ static inline off_t pack_set_bytecount(struct pack_list *pl)
 	return ret;
 }
 
-static void minimize(struct pack_list **min)
+static int cmp_pack_list_reverse(const void *a, const void *b)
 {
-	struct pack_list *pl, *unique = NULL,
-		*non_unique = NULL, *min_perm = NULL;
-	struct pll *perm, *perm_all, *perm_ok = NULL, *new_perm;
-	struct llist *missing;
-	off_t min_perm_size = 0, perm_size;
-	int n;
+	struct pack_list *pl_a = *((struct pack_list **)a);
+	struct pack_list *pl_b = *((struct pack_list **)b);
+	size_t sz_a = pl_a->all_objects->size;
+	size_t sz_b = pl_b->all_objects->size;
+
+	if (sz_a == sz_b)
+		return 0;
+	else if (sz_a < sz_b)
+		return 1;
+	else
+		return -1;
+}
+
+/* Sort pack_list, greater size of all_objects first */
+static void sort_pack_list(struct pack_list **pl)
+{
+	struct pack_list **ary, *p;
+	int i;
+	size_t n = pack_list_size(*pl);
+
+	if (n < 2)
+		return;
+
+	/* prepare an array of packed_list for easier sorting */
+	ary = xcalloc(n, sizeof(struct pack_list *));
+	for (n = 0, p = *pl; p; p = p->next)
+		ary[n++] = p;
+
+	QSORT(ary, n, cmp_pack_list_reverse);
+
+	/* link them back again */
+	for (i = 0; i < n - 1; i++)
+		ary[i]->next = ary[i + 1];
+	ary[n - 1]->next = NULL;
+	*pl = ary[0];
+
+	free(ary);
+}
+
+
+static void minimize(struct pack_list **min, struct llist *ignore)
+{
+	struct pack_list *pl, *unique = NULL, *non_unique = NULL;
+	struct llist *missing, *unique_pack_objects;
 
 	pl = local_packs;
 	while (pl) {
@@ -446,49 +484,41 @@ static void minimize(struct pack_list **min)
 		pl = pl->next;
 	}
 
+	*min = unique;
+
 	/* return if there are no objects missing from the unique set */
 	if (missing->size == 0) {
-		*min = unique;
 		free(missing);
 		return;
 	}
 
-	/* find the permutations which contain all missing objects */
-	for (n = 1; n <= pack_list_size(non_unique) && !perm_ok; n++) {
-		perm_all = perm = get_permutations(non_unique, n);
-		while (perm) {
-			if (is_superset(perm->pl, missing)) {
-				new_perm = xmalloc(sizeof(struct pll));
-				memcpy(new_perm, perm, sizeof(struct pll));
-				new_perm->next = perm_ok;
-				perm_ok = new_perm;
-			}
-			perm = perm->next;
-		}
-		if (perm_ok)
-			break;
-		pll_free(perm_all);
-	}
-	if (perm_ok == NULL)
-		die("Internal error: No complete sets found!");
-
-	/* find the permutation with the smallest size */
-	perm = perm_ok;
-	while (perm) {
-		perm_size = pack_set_bytecount(perm->pl);
-		if (!min_perm_size || min_perm_size > perm_size) {
-			min_perm_size = perm_size;
-			min_perm = perm->pl;
-		}
-		perm = perm->next;
-	}
-	*min = min_perm;
-	/* add the unique packs to the list */
-	pl = unique;
+	unique_pack_objects = llist_copy(all_objects);
+	llist_sorted_difference_inplace(unique_pack_objects, missing);
+
+	/* remove all the ignored objects and unique pack objects from the non_unique packs */
+	pl = non_unique;
 	while (pl) {
-		pack_list_insert(min, pl);
+		llist_sorted_difference_inplace(pl->all_objects, ignore);
+		llist_sorted_difference_inplace(pl->all_objects, unique_pack_objects);
 		pl = pl->next;
 	}
+
+	while ((pl = non_unique)) {
+		/* sort the non_unique packs, greater size of all_objects first */
+		sort_pack_list(&non_unique);
+		if (non_unique->all_objects->size == 0)
+			break;
+
+		pack_list_insert(min, non_unique);
+
+		while ((pl = pl->next)) {
+			if (pl->all_objects->size == 0)
+				break;
+			llist_sorted_difference_inplace(pl->all_objects, non_unique->all_objects);
+		}
+
+		non_unique = non_unique->next;
+	}
 }
 
 static void load_all_objects(void)
@@ -603,7 +633,7 @@ static void load_all(void)
 int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	struct pack_list *min, *red, *pl;
+	struct pack_list *min = NULL, *red, *pl;
 	struct llist *ignore;
 	struct object_id *oid;
 	char buf[GIT_MAX_HEXSZ + 2]; /* hex hash + \n + \0 */
@@ -667,7 +697,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 		pl = pl->next;
 	}
 
-	minimize(&min);
+	minimize(&min, ignore);
 
 	if (verbose) {
 		fprintf(stderr, "There are %lu packs available in alt-odbs.\n",
-- 
2.20.0.2.g660e9286fc

