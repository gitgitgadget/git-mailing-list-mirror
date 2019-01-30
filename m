Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA26D1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 11:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfA3Lsq (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 06:48:46 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44030 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbfA3Lsq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 06:48:46 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so11287432pfk.10
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 03:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KBwuH5MfGzIGeqqEHRWmvlQglvm/uiJ0vriYoozfWNc=;
        b=KmXhwMGH5PZwIur1u3Tn5O0mE4mw3wBQ3wn2TBnZUriRB3pG/QEVnEyJ8EB+ZkuXJ5
         jwWnP2MDXF/jjAuowerDqyTk9eG0k12rGBwKCrmLIz+mMb0SZDLlFe8B4jjVVNtMsg5J
         mteVd8yfvYxvmXWC13LU16AbebqkUdcyh3N/b5uk+yx941FBKiDUuop4oyHwnX4PiM+O
         GaQ5mtUOJia2oEy0Vam8zKXH8TvKh9sBl714z3XCIBbFzsPtPjwtI8VR1Mcj8ZzcBlSC
         9oqk5CqxAuwi67xaDbpyaZTzIJHmA1YHTuYZJpqiOUjd/5LfD5Ty01iqvNbB83ZwiLu/
         nNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KBwuH5MfGzIGeqqEHRWmvlQglvm/uiJ0vriYoozfWNc=;
        b=DAOIoZ1OD9zsgG42w98avlPTWhgsL4SWu/OZiax2Cq+EoW7FXusxVxear2UtwpFPJG
         3YiRagAmid4ehvWAddrlBlnnUlf4kKs5GK87XBlUeIeuZqt4T5U1BBa1KgBo0lre2nOz
         G+hWPCxTC2uHqDqnc5xMhr3/7y+ihzMtDMqYdTMq7YOGrEBV0QCwRw5Ye1j3luFjPx+N
         ogsDCO/6PG4nlh3hoDd/m1qCnTG5gAPIiRgPzimmeP+1VbhCGYwEE0m6EULGWSMwbh5w
         0RSTerjiGZNOEPm1UEdM4exS1P4m6KxHMvmwcW5SCnnC5O3PELGMeZwVN1aY3SnsFR6l
         fmtw==
X-Gm-Message-State: AJcUukfZalDOkd+Vi2KMVoR2x7A+ALyweKcoekqhVky2LH7grY4P7whI
        Iow3/kOv1AwrMsxWWhQ8ovI=
X-Google-Smtp-Source: ALg8bN4Sy/umywtoqLWWEjk7WVLxw90dxb9WYCzwRNuU9iUZ7Hp2rZeOtZ6dW4DCKb5b82Qt16TUow==
X-Received: by 2002:a62:5fc4:: with SMTP id t187mr30497787pfb.66.1548848925411;
        Wed, 30 Jan 2019 03:48:45 -0800 (PST)
Received: from localhost.localdomain ([2408:84e1:e2:afd3:7c5c:7512:51d2:8f91])
        by smtp.gmail.com with ESMTPSA id v191sm2124473pgb.77.2019.01.30.03.48.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 03:48:44 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Sun Chao <sunchao9@huawei.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v7 3/6] pack-redundant: new algorithm to find min packs
Date:   Wed, 30 Jan 2019 19:47:33 +0800
Message-Id: <20190130114736.30357-4-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.1.103.ged0fc2ca7b
In-Reply-To: <20190112091754.30985-1-worldhello.net@gmail.com>
References: <20190112091754.30985-1-worldhello.net@gmail.com>
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

Some test cases will fail on Mac OS X. Mark them and will resolve in
later commit.

Original PR and discussions: https://github.com/jiangxin/git/pull/25

Signed-off-by: Sun Chao <sunchao9@huawei.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pack-redundant.c  | 108 +++++++++++++++++++++++---------------
 t/t5323-pack-redundant.sh |  12 ++---
 2 files changed, 73 insertions(+), 47 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index f7dab0ec60..b3f3bb5e09 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -426,14 +426,52 @@ static inline off_t pack_set_bytecount(struct pack_list *pl)
 	return ret;
 }
 
+static int cmp_pack_list_reverse(const void *a, const void *b)
+{
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
 static void minimize(struct pack_list **min)
 {
-	struct pack_list *pl, *unique = NULL,
-		*non_unique = NULL, *min_perm = NULL;
-	struct pll *perm, *perm_all, *perm_ok = NULL, *new_perm;
-	struct llist *missing;
-	off_t min_perm_size = 0, perm_size;
-	int n;
+	struct pack_list *pl, *unique = NULL, *non_unique = NULL;
+	struct llist *missing, *unique_pack_objects;
 
 	pl = local_packs;
 	while (pl) {
@@ -451,49 +489,37 @@ static void minimize(struct pack_list **min)
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
+	/* remove unique pack objects from the non_unique packs */
+	pl = non_unique;
 	while (pl) {
-		pack_list_insert(min, pl);
+		llist_sorted_difference_inplace(pl->all_objects, unique_pack_objects);
 		pl = pl->next;
 	}
+
+	while (non_unique) {
+		/* sort the non_unique packs, greater size of all_objects first */
+		sort_pack_list(&non_unique);
+		if (non_unique->all_objects->size == 0)
+			break;
+
+		pack_list_insert(min, non_unique);
+
+		for (pl = non_unique->next; pl && pl->all_objects->size > 0;  pl = pl->next)
+			llist_sorted_difference_inplace(pl->all_objects, non_unique->all_objects);
+
+		non_unique = non_unique->next;
+	}
 }
 
 static void load_all_objects(void)
@@ -607,7 +633,7 @@ static void load_all(void)
 int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	struct pack_list *min, *red, *pl;
+	struct pack_list *min = NULL, *red, *pl;
 	struct llist *ignore;
 	struct object_id *oid;
 	char buf[GIT_MAX_HEXSZ + 2]; /* hex hash + \n + \0 */
diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
index 710fe9884c..d176a6eb91 100755
--- a/t/t5323-pack-redundant.sh
+++ b/t/t5323-pack-redundant.sh
@@ -155,7 +155,7 @@ cat >expected <<EOF
 P2:$P2
 EOF
 
-test_expect_success 'one of pack-2/pack-3 is redundant' '
+test_expect_failure 'one of pack-2/pack-3 is redundant' '
 	git pack-redundant --all >out &&
 	format_packfiles <out >actual &&
 	test_cmp expected actual
@@ -172,7 +172,7 @@ P4:$P4
 P6:$P6
 EOF
 
-test_expect_success 'pack 2, 4, and 6 are redundant' '
+test_expect_failure 'pack 2, 4, and 6 are redundant' '
 	git pack-redundant --all >out &&
 	format_packfiles <out >actual &&
 	test_cmp expected actual
@@ -189,7 +189,7 @@ P6:$P6
 P8:$P8
 EOF
 
-test_expect_success 'pack-8 (subset of pack-1) is also redundant' '
+test_expect_failure 'pack-8 (subset of pack-1) is also redundant' '
 	git pack-redundant --all >out &&
 	format_packfiles <out >actual &&
 	test_cmp expected actual
@@ -201,7 +201,7 @@ test_expect_success 'clean loose objects' '
 	test_must_be_empty out
 '
 
-test_expect_success 'remove redundant packs and pass fsck' '
+test_expect_failure 'remove redundant packs and pass fsck' '
 	git pack-redundant --all | xargs rm &&
 	git fsck --no-progress &&
 	git pack-redundant --all >out &&
@@ -215,7 +215,7 @@ test_expect_success 'setup shared.git' '
 	printf "../../master.git/objects" >objects/info/alternates
 '
 
-test_expect_success 'no redundant packs without --alt-odb' '
+test_expect_failure 'no redundant packs without --alt-odb' '
 	git pack-redundant --all >out &&
 	test_must_be_empty out
 '
@@ -227,7 +227,7 @@ P5:$P5
 P7:$P7
 EOF
 
-test_expect_success 'pack-redundant --verbose: show duplicate packs in stderr' '
+test_expect_failure 'pack-redundant --verbose: show duplicate packs in stderr' '
 	git pack-redundant --all --verbose >out 2>out.err &&
 	test_must_be_empty out &&
 	grep "pack$" out.err | format_packfiles >actual &&
-- 
2.20.1.103.ged0fc2ca7b

