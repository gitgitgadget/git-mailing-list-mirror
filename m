Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5BE7211B4
	for <e@80x24.org>; Sat, 12 Jan 2019 09:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbfALJTy (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Jan 2019 04:19:54 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34880 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfALJTy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jan 2019 04:19:54 -0500
Received: by mail-pf1-f194.google.com with SMTP id z9so8097337pfi.2
        for <git@vger.kernel.org>; Sat, 12 Jan 2019 01:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N7JE46uug/VspiDKymkumoj1W2/FboMY8mjvK+Yoits=;
        b=FFfgnohd0haDgRQvO2NsvuO0lBAK6WiNDuM6hdyqwRA21eTZHv8ZDnLaqXwJhdzn2B
         pawShIWhtK4+i2p5zaLp0u2ZTOI7DIWgF3g+5OaFUtEMlVcG6EhwpIU6blc2k92dvBap
         mfZ5Gg4IZBPdz1t1ZZ4NwFAeqNvDtmw2w9NuH3FprV56dEV3a9KiCnk98Hn7VLQ4WmG6
         i4kNgathx25E2Z+4lCmNSWXQN+6gri2tyJuAerfRZRlG1A0w4He6GLA5vHHA4Ahjg8UZ
         NTPs5H/7/8eACTrBJr1PV6L11kBpmegjUY3ADm1e3y5mU7l5SpqoESm+pMlHTLO/TA5R
         JlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N7JE46uug/VspiDKymkumoj1W2/FboMY8mjvK+Yoits=;
        b=XJR5RJO2VCmmiN8iLqhKIa7VsOYkiUivbCwtXwopv/MXDW7OZD8QPxsWNYYtOHxxpe
         ZU6xWyvS0HkHDUf9oI/FD+SjNAzfFAv0C2+SnVKnln79Co9M4y6V51ONl6Vm+qhJgdJ2
         b/KsWgw/vfsfykZ/SLck0DxzWYVolsQbAhs2aMNk1wNuKlmztg9K+b7z8ioho+6EWLe3
         esURr09/J/lHo5oEkYqa6t99ReqxZNoz2IXqxCTYV3sVIr75P2HoLNPosT80ZbftbLuy
         Aq0z1m1MVTp86wIlmFo0boCThikbmY1u+MGDrB7W8McDe6M4HQNf29JBJalJuMxf2uVU
         WSWg==
X-Gm-Message-State: AJcUukelw4fs8xywrv+i7mjjmhV5xgrThABn+YsXBjrp5xRy5+EndZiE
        N8I0HgO2e2lESuxSFA+TBJk=
X-Google-Smtp-Source: ALg8bN5k1UFUxSNhC77MyGFx1iWkgp6pz/fkdQ6yjF4ya5wSedM+HkjdIFN0VQdyN9JPV9LMUh5dqg==
X-Received: by 2002:a63:f658:: with SMTP id u24mr16411051pgj.267.1547284793347;
        Sat, 12 Jan 2019 01:19:53 -0800 (PST)
Received: from localhost.localdomain ([221.222.155.87])
        by smtp.gmail.com with ESMTPSA id i5sm27685510pfg.34.2019.01.12.01.19.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 01:19:52 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Sun Chao <sunchao9@huawei.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v6 2/5] pack-redundant: new algorithm to find min packs
Date:   Sat, 12 Jan 2019 17:17:51 +0800
Message-Id: <20190112091754.30985-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.0.3.gc45e608566
In-Reply-To: <20190110120142.22271-1-worldhello.net@gmail.com>
References: <20190110120142.22271-1-worldhello.net@gmail.com>
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
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pack-redundant.c | 109 ++++++++++++++++++++++++---------------
 1 file changed, 68 insertions(+), 41 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index cf9a9aabd4..3655cc7dc6 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -421,14 +421,52 @@ static inline off_t pack_set_bytecount(struct pack_list *pl)
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
@@ -446,49 +484,37 @@ static void minimize(struct pack_list **min)
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
@@ -603,7 +629,7 @@ static void load_all(void)
 int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	struct pack_list *min, *red, *pl;
+	struct pack_list *min = NULL, *red, *pl;
 	struct llist *ignore;
 	struct object_id *oid;
 	char buf[GIT_MAX_HEXSZ + 2]; /* hex hash + \n + \0 */
@@ -664,6 +690,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 	pl = local_packs;
 	while (pl) {
 		llist_sorted_difference_inplace(pl->unique_objects, ignore);
+		llist_sorted_difference_inplace(pl->all_objects, ignore);
 		pl = pl->next;
 	}
 
-- 
2.20.0.3.gc45e608566

