Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 493651F453
	for <e@80x24.org>; Fri,  1 Feb 2019 16:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfBAQWN (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 11:22:13 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41550 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfBAQWN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 11:22:13 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so3148702pgq.8
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 08:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XQr5M6/Lfrtb01iOgyGkQJvUkhLQy7Toyh6cgUypxPc=;
        b=Bzy2raZzhCmEWFfTQpuWO5WcRKANhKcInsX5R0Jfc1VA5DwgsVeZcv3tJmf+IarN3n
         6B8nh3TeeAEJ2BDRjYUqdcPXhFj5skgPjmuap8KgO6YyCc8v6EgsAmdlTBFjW99QM+9S
         peBUfhvnffA50v1Lfj+D/yQg4GtjR2R7F3FxRZ2i/uuC4cGNIJdZ669qYuNHj7kM5Sx/
         YdcP3G8dwLwQdYN5hjlyeH/B6zvcxwRGu1IaXPDXLPAjec/rT4k6oH4EWZSiK9j89ISC
         uEkJkyx3Sn2r0NuAyBfuvQtsQzokUt3wkEkIELvxltbrHDcjcT5gJqads06PUwfCN3wk
         ZjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XQr5M6/Lfrtb01iOgyGkQJvUkhLQy7Toyh6cgUypxPc=;
        b=n7ZimysmgjwZqwAUjzCW4njhUb9lXQbWxQnGlzdYJ8g+Bh2aZGV1gn4bBahCHrRXU/
         zoeweoKC0ry/Y70DhdSm5fuLpSt+fYPeQJVlrOCA5tpoPRu/IrZdXLdwyhYinXfy53ir
         s206J9EwABGb1817WHtHH+qKPxJ3Tb7paOnr/BkRP5uDgWjwpS5GUp85a3QoGhjz6nmS
         CzxuvnEIdg8cAKBbwNVtfSEMAaFH9P+5tGQQgRXixU9Ftb0obSe8RzJisoahdFljkfkv
         KDNzgbajWnr0OOyk0KsPSh27DbF431tAaKpeb5oaICYjQEIt1b1TDgMU1RuzHh+LZa1T
         FkgA==
X-Gm-Message-State: AHQUAuZxsTZr3SN4JAsrKE2UB74bmqYOOFq6UqxNiQAELoyB9tKUGJv+
        2Va/d9lROz/LTqvw9cpie9A=
X-Google-Smtp-Source: AHgI3IYelyEaCMwUT9cDUmImjcg+U8LMiGlvxm3qqVAN/x5fdtp+1jsvgmGUo7Ojr22o1Volha85SA==
X-Received: by 2002:a63:2c0e:: with SMTP id s14mr2895410pgs.132.1549038132188;
        Fri, 01 Feb 2019 08:22:12 -0800 (PST)
Received: from localhost.localdomain ([2408:84e1:1:ce70:7c5c:7512:51d2:8f91])
        by smtp.gmail.com with ESMTPSA id x2sm11872694pfx.78.2019.02.01.08.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 08:22:11 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Sun Chao <sunchao9@huawei.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v9 0/6] pack-redundant: new algorithm to find min packs
Date:   Sat,  2 Feb 2019 00:21:46 +0800
Message-Id: <20190201162152.31136-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.1.103.ged0fc2ca7b
In-Reply-To: <20190130114736.30357-1-worldhello.net@gmail.com>
References: <20190130114736.30357-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sun Chao (my former colleague at Huawei) found a bug of
git-pack-redundant.  If there are too many packs and many of them
overlap each other, running `git pack-redundant --all` will
exhaust all memories and the process will be killed by kernel.

There is a script in commit log of commit 3/6, which can be used to
create a repository with lots of redundant packs. Running `git
pack-redundant --all` in it can reproduce this issue.

## Changes since reroll v7

1. Rewrite [PATCH v9 1/6] (t5323: test cases for git-pack-redundant)

   * Add many tables for relationship of packs and objects.
   * Change dir in subshell and fixed other issues.

2. New patch file from Sun Chao: [PATCH v9 3/6] (pack-redundant: delete redundant code)

3. Squash patches (remove unused functions) to patch 4/6 (new algorithm to find min packs).

## Range diff

1:  799e804d5e < -:  ---------- t5323: test cases for git-pack-redundant
-:  ---------- > 1:  c8dbf8cef2 t5323: test cases for git-pack-redundant
2:  520f6277fb = 2:  a6300516d7 pack-redundant: delay creation of unique_objects
-:  ---------- > 3:  fb71973df5 pack-redundant: delete redundant code
3:  ab1c2c4950 ! 4:  9963d1c49f pack-redundant: new algorithm to find min packs
    @@ -76,6 +76,113 @@
      diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
      --- a/builtin/pack-redundant.c
      +++ b/builtin/pack-redundant.c
    +@@
    + 	struct llist *all_objects;
    + } *local_packs = NULL, *altodb_packs = NULL;
    + 
    +-struct pll {
    +-	struct pll *next;
    +-	struct pack_list *pl;
    +-};
    +-
    + static struct llist_item *free_nodes;
    + 
    + static inline void llist_item_put(struct llist_item *item)
    +@@
    + 	return new_item;
    + }
    + 
    +-static void llist_free(struct llist *list)
    +-{
    +-	while ((list->back = list->front)) {
    +-		list->front = list->front->next;
    +-		llist_item_put(list->back);
    +-	}
    +-	free(list);
    +-}
    +-
    + static inline void llist_init(struct llist **list)
    + {
    + 	*list = xmalloc(sizeof(struct llist));
    +@@
    + 	}
    + }
    + 
    +-static void pll_free(struct pll *l)
    +-{
    +-	struct pll *old;
    +-	struct pack_list *opl;
    +-
    +-	while (l) {
    +-		old = l;
    +-		while (l->pl) {
    +-			opl = l->pl;
    +-			l->pl = opl->next;
    +-			free(opl);
    +-		}
    +-		l = l->next;
    +-		free(old);
    +-	}
    +-}
    +-
    +-/* all the permutations have to be free()d at the same time,
    +- * since they refer to each other
    +- */
    +-static struct pll * get_permutations(struct pack_list *list, int n)
    +-{
    +-	struct pll *subset, *ret = NULL, *new_pll = NULL;
    +-
    +-	if (list == NULL || pack_list_size(list) < n || n == 0)
    +-		return NULL;
    +-
    +-	if (n == 1) {
    +-		while (list) {
    +-			new_pll = xmalloc(sizeof(*new_pll));
    +-			new_pll->pl = NULL;
    +-			pack_list_insert(&new_pll->pl, list);
    +-			new_pll->next = ret;
    +-			ret = new_pll;
    +-			list = list->next;
    +-		}
    +-		return ret;
    +-	}
    +-
    +-	while (list->next) {
    +-		subset = get_permutations(list->next, n - 1);
    +-		while (subset) {
    +-			new_pll = xmalloc(sizeof(*new_pll));
    +-			new_pll->pl = subset->pl;
    +-			pack_list_insert(&new_pll->pl, list);
    +-			new_pll->next = ret;
    +-			ret = new_pll;
    +-			subset = subset->next;
    +-		}
    +-		list = list->next;
    +-	}
    +-	return ret;
    +-}
    +-
    +-static int is_superset(struct pack_list *pl, struct llist *list)
    +-{
    +-	struct llist *diff;
    +-
    +-	diff = llist_copy(list);
    +-
    +-	while (pl) {
    +-		llist_sorted_difference_inplace(diff, pl->all_objects);
    +-		if (diff->size == 0) { /* we're done */
    +-			llist_free(diff);
    +-			return 1;
    +-		}
    +-		pl = pl->next;
    +-	}
    +-	llist_free(diff);
    +-	return 0;
    +-}
    +-
    + static size_t sizeof_union(struct packed_git *p1, struct packed_git *p2)
    + {
    + 	size_t ret = 0;
     @@
      	return ret;
      }
    @@ -221,56 +328,56 @@
      --- a/t/t5323-pack-redundant.sh
      +++ b/t/t5323-pack-redundant.sh
     @@
    - P2:$P2
    - EOF
    - 
    + #     ALL | x x x x x x x x x x x x x x x x x   x
    + #
    + #############################################################################
     -test_expect_success 'one of pack-2/pack-3 is redundant' '
    -+test_expect_failure 'one of pack-2/pack-3 is redundant' '
    - 	git pack-redundant --all >out &&
    - 	format_packfiles <out >actual &&
    - 	test_cmp expected actual
    ++test_expect_failure 'one of pack-2/pack-3 is redundant (failed on Mac)' '
    + 	(
    + 		cd "$master_repo" &&
    + 		cat >expect <<-EOF &&
     @@
    - P6:$P6
    - EOF
    - 
    + #     ALL | x x x x x x x x x x x x x x x x x x x
    + #
    + #############################################################################
     -test_expect_success 'pack 2, 4, and 6 are redundant' '
    -+test_expect_failure 'pack 2, 4, and 6 are redundant' '
    - 	git pack-redundant --all >out &&
    - 	format_packfiles <out >actual &&
    - 	test_cmp expected actual
    ++test_expect_failure 'pack 2, 4, and 6 are redundant (failed on Mac)' '
    + 	(
    + 		cd "$master_repo" &&
    + 		cat >expect <<-EOF &&
     @@
    - P8:$P8
    - EOF
    - 
    + #     ALL | x x x x x x x x x x x x x x x x x x x
    + #
    + #############################################################################
     -test_expect_success 'pack-8 (subset of pack-1) is also redundant' '
    -+test_expect_failure 'pack-8 (subset of pack-1) is also redundant' '
    - 	git pack-redundant --all >out &&
    - 	format_packfiles <out >actual &&
    - 	test_cmp expected actual
    ++test_expect_failure 'pack-8 (subset of pack-1) is also redundant (failed on Mac)' '
    + 	(
    + 		cd "$master_repo" &&
    + 		cat >expect <<-EOF &&
     @@
    - 	test_must_be_empty out
    + 	)
      '
      
     -test_expect_success 'remove redundant packs and pass fsck' '
    -+test_expect_failure 'remove redundant packs and pass fsck' '
    - 	git pack-redundant --all | xargs rm &&
    - 	git fsck --no-progress &&
    - 	git pack-redundant --all >out &&
    ++test_expect_failure 'remove redundant packs and pass fsck (failed on Mac)' '
    + 	(
    + 		cd "$master_repo" &&
    + 		git pack-redundant --all | xargs rm &&
     @@
    - 	printf "../../master.git/objects" >objects/info/alternates
    + 	)
      '
      
     -test_expect_success 'no redundant packs without --alt-odb' '
    -+test_expect_failure 'no redundant packs without --alt-odb' '
    - 	git pack-redundant --all >out &&
    - 	test_must_be_empty out
    - '
    ++test_expect_failure 'no redundant packs without --alt-odb (failed on Mac)' '
    + 	(
    + 		cd "$shared_repo" &&
    + 		git pack-redundant --all >out &&
     @@
    - P7:$P7
    - EOF
    - 
    + #     ALL | x x x x x x x x x x x x x x x x x x x
    + #
    + #############################################################################
     -test_expect_success 'pack-redundant --verbose: show duplicate packs in stderr' '
    -+test_expect_failure 'pack-redundant --verbose: show duplicate packs in stderr' '
    - 	git pack-redundant --all --verbose >out 2>out.err &&
    - 	test_must_be_empty out &&
    - 	grep "pack$" out.err | format_packfiles >actual &&
    ++test_expect_failure 'pack-redundant --verbose: show duplicate packs in stderr (failed on Mac)' '
    + 	(
    + 		cd "$shared_repo" &&
    + 		cat >expect <<-EOF &&
4:  3c3a7ea40f < -:  ---------- pack-redundant: remove unused functions
5:  bc4b681f40 ! 5:  b8f80ad454 pack-redundant: rename pack_list.all_objects
    @@ -115,11 +115,7 @@
     +							alt->remaining_objects);
      			local = local->next;
      		}
    --		llist_sorted_difference_inplace(all_objects, alt->all_objects);
    -+		llist_sorted_difference_inplace(all_objects, alt->remaining_objects);
      		alt = alt->next;
    - 	}
    - }
     @@
      		return NULL;
      
6:  6cfba5b4b2 ! 6:  8a12ad699e pack-redundant: consistent sort method
    @@ -83,60 +83,71 @@
      --- a/t/t5323-pack-redundant.sh
      +++ b/t/t5323-pack-redundant.sh
     @@
    - '
    - 
    - cat >expected <<EOF
    --P2:$P2
    -+P3:$P3
    - EOF
    - 
    --test_expect_failure 'one of pack-2/pack-3 is redundant' '
    + #         | T A B C D E F G H I J K L M N O P Q R
    + #     ----+--------------------------------------
    + #     P1  | x x x x x x x                       x
    +-#     P2* |     ! ! ! !   ! ! !
    +-#     P3  |             x     x x x x x
    ++#     P2  |     x x x x   x x x
    ++#     P3* |             !     ! ! ! ! !
    + #     P4  |                     x x x x     x
    + #     P5  |               x x           x x
    + #     ----+--------------------------------------
    + #     ALL | x x x x x x x x x x x x x x x x x   x
    + #
    + #############################################################################
    +-test_expect_failure 'one of pack-2/pack-3 is redundant (failed on Mac)' '
     +test_expect_success 'one of pack-2/pack-3 is redundant' '
    - 	git pack-redundant --all >out &&
    - 	format_packfiles <out >actual &&
    - 	test_cmp expected actual
    + 	(
    + 		cd "$master_repo" &&
    + 		cat >expect <<-EOF &&
    +-			P2:$P2
    ++			P3:$P3
    + 			EOF
    + 		git pack-redundant --all >out &&
    + 		format_packfiles <out >actual &&
     @@
    - P6:$P6
    - EOF
    - 
    --test_expect_failure 'pack 2, 4, and 6 are redundant' '
    + #     ALL | x x x x x x x x x x x x x x x x x x x
    + #
    + #############################################################################
    +-test_expect_failure 'pack 2, 4, and 6 are redundant (failed on Mac)' '
     +test_expect_success 'pack 2, 4, and 6 are redundant' '
    - 	git pack-redundant --all >out &&
    - 	format_packfiles <out >actual &&
    - 	test_cmp expected actual
    + 	(
    + 		cd "$master_repo" &&
    + 		cat >expect <<-EOF &&
     @@
    - P8:$P8
    - EOF
    - 
    --test_expect_failure 'pack-8 (subset of pack-1) is also redundant' '
    + #     ALL | x x x x x x x x x x x x x x x x x x x
    + #
    + #############################################################################
    +-test_expect_failure 'pack-8 (subset of pack-1) is also redundant (failed on Mac)' '
     +test_expect_success 'pack-8 (subset of pack-1) is also redundant' '
    - 	git pack-redundant --all >out &&
    - 	format_packfiles <out >actual &&
    - 	test_cmp expected actual
    + 	(
    + 		cd "$master_repo" &&
    + 		cat >expect <<-EOF &&
     @@
    - 	test_must_be_empty out
    + 	)
      '
      
    --test_expect_failure 'remove redundant packs and pass fsck' '
    +-test_expect_failure 'remove redundant packs and pass fsck (failed on Mac)' '
     +test_expect_success 'remove redundant packs and pass fsck' '
    - 	git pack-redundant --all | xargs rm &&
    - 	git fsck --no-progress &&
    - 	git pack-redundant --all >out &&
    + 	(
    + 		cd "$master_repo" &&
    + 		git pack-redundant --all | xargs rm &&
     @@
    - 	printf "../../master.git/objects" >objects/info/alternates
    + 	)
      '
      
    --test_expect_failure 'no redundant packs without --alt-odb' '
    +-test_expect_failure 'no redundant packs without --alt-odb (failed on Mac)' '
     +test_expect_success 'no redundant packs without --alt-odb' '
    - 	git pack-redundant --all >out &&
    - 	test_must_be_empty out
    - '
    + 	(
    + 		cd "$shared_repo" &&
    + 		git pack-redundant --all >out &&
     @@
    - P7:$P7
    - EOF
    - 
    --test_expect_failure 'pack-redundant --verbose: show duplicate packs in stderr' '
    + #     ALL | x x x x x x x x x x x x x x x x x x x
    + #
    + #############################################################################
    +-test_expect_failure 'pack-redundant --verbose: show duplicate packs in stderr (failed on Mac)' '
     +test_expect_success 'pack-redundant --verbose: show duplicate packs in stderr' '
    - 	git pack-redundant --all --verbose >out 2>out.err &&
    - 	test_must_be_empty out &&
    - 	grep "pack$" out.err | format_packfiles >actual &&
    + 	(
    + 		cd "$shared_repo" &&
    + 		cat >expect <<-EOF &&


Jiang Xin (4):
  t5323: test cases for git-pack-redundant
  pack-redundant: delay creation of unique_objects
  pack-redundant: rename pack_list.all_objects
  pack-redundant: consistent sort method

Sun Chao (2):
  pack-redundant: delete redundant code
  pack-redundant: new algorithm to find min packs

 builtin/pack-redundant.c  | 232 +++++++----------
 t/t5323-pack-redundant.sh | 510 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 602 insertions(+), 140 deletions(-)
 create mode 100755 t/t5323-pack-redundant.sh

-- 
2.20.1.103.ged0fc2ca7b

