Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65EFA1F770
	for <e@80x24.org>; Wed,  2 Jan 2019 04:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbfABEhh (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Jan 2019 23:37:37 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36270 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728432AbfABEhg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jan 2019 23:37:36 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so14661529pfc.3
        for <git@vger.kernel.org>; Tue, 01 Jan 2019 20:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3LbMrHGx3VgZT/uOhPjq5wZmwaTFU9qz6gIUEkXf3Jw=;
        b=vNf+kWgRQ2BYC1Qv/Ki2pNjPduVDgQvZAJzE4eu5mqukDZ9T7fIT1le337aFA8Asn/
         /DdwE4dC9lCu13QwNWQE7dUK4IByohByOirs6b2DUXaRTxgycvskuyrelM1xeDLxCc81
         5eu0LimBWFCgRmG8GthtNLCjdht2bEkF5abLn/QbsWhXPcItT0QvfVuOe3OC+dbm1FwL
         BYA23/rW3y2sigH/nvuR4W5wq177vIsvMWZmXGnUWLFOPeLSnwDDJb/3qUWVVlUnBf6n
         mH/FkX3RYLBlx/XFSbvXNK0GBdpI7z7ufWvtnLYDV14T8a/vZDlHROP4WvqOUCfRbMu5
         xq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3LbMrHGx3VgZT/uOhPjq5wZmwaTFU9qz6gIUEkXf3Jw=;
        b=PICPVsSeaaJAKx5BcItvkOT8Jl/IWkCxxzxdT/1Oe8ETLoSGQqEjwXFMebmjNlgMYB
         htDDkHpQdGbaYQorvXXYyZUPxTIMLty3ZmtOb8IsCL+xKAQqJDrVE7P9VON/RCOrSEQu
         3tQM3TUWT+DZW5JeukUe+dBmuLdzcoGQaoiJ2JutrsoPDdaLJzUVXuWTcpYDvgryyAQN
         MpsiEz08dOFNQp6AvpCjhM/bgSbf9A+7H9SwxeEwTiUtxFaY5ikCuza86JKzyzFvOE+1
         Hh3kbnYRSLcYGc1K5q25tCtpyNb0QBx8s5r7TlWFgbL+MJQU1v7hsddEEOAwxuhiFkQ1
         OPHw==
X-Gm-Message-State: AA+aEWbq4cn3B8irBWdiql6QkEH92FZOIx8K24U65BiJ3famapQ3ty7G
        C1OB+Sag0f3ybfpidy0yEzw=
X-Google-Smtp-Source: AFSGD/UmtGNbxxjww9b7WLpQbJWky/cUNYlvjNxkWSksvrfBjpk+6AUr3v8OkrKjZn9H4nwWxfAi0Q==
X-Received: by 2002:a62:75d1:: with SMTP id q200mr43061940pfc.254.1546403855016;
        Tue, 01 Jan 2019 20:37:35 -0800 (PST)
Received: from GotGit.hz.ali.com ([106.11.34.207])
        by smtp.gmail.com with ESMTPSA id b27sm75904397pfh.113.2019.01.01.20.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 20:37:34 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Sun Chao <sunchao9@huawei.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 2/3] pack-redundant: new algorithm to find min packs
Date:   Wed,  2 Jan 2019 12:34:55 +0800
Message-Id: <20190102043456.15652-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.0.3.gc45e608566
In-Reply-To: <20181219121451.21697-1-worldhello.net@gmail.com>
References: <20181219121451.21697-1-worldhello.net@gmail.com>
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
 builtin/pack-redundant.c | 109 +++++++++++++++++++++++++++++------------------
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
2.14.5.agit.2

