Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 137781F453
	for <e@80x24.org>; Wed, 30 Jan 2019 11:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfA3LsT (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 06:48:19 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38730 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbfA3LsS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 06:48:18 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so10952076plb.5
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 03:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+glsXfSGMebvR3/8FGEn9REITTJztu3pNiQvAkxb8bg=;
        b=CT8smFJcyDjNZ98UKVUuoTjmJczuaOR4p0UZpuu+mXHEUIh5QUe/vSJnf6J7TAaabb
         peqAgY7v+eXRryH61c7sDbCM0iWVgvn/55nmuu6YY7fWK0D5es7UqkoGYMFQX3AHLvnf
         MVYzha143NEQQRX0u98hWc5UIrdijIavb55KH72pYzw/dF7DlV6K6E1a7dzoaN3vULLw
         7L+NZusVfKHi+DMdN8uiZwP3BdZR9c9MDm25uF/YygtkCZqSK0OuGzXdEHSPNdlq6y7T
         mmelTP0peYvzMtkSh3ybIbrBMT0BBy+yYe1jfoZRSUzihG1aC1dPQm0KFoFLTGl2aLyQ
         nUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+glsXfSGMebvR3/8FGEn9REITTJztu3pNiQvAkxb8bg=;
        b=Ikoo9j/rH/+plkO9eeTXAgs1EcDUcNboAGP7UhgbCPP6/2cteJ/tgJxvw1mSHM93nD
         rxtntBwr7uXGAkY0AGjlu70cbJP6Dl/tTJmYVPT5KChe8vMHBrItSSotdoR9pbrnDcjD
         iyG3ycvPq7I9wtsYrPDxQSzsWEeScZID5tt44GIUwOOZY4tA5qlAE/OoFWs9+eSzdfER
         PNwbmCDnS2Dg+DnNbCEFP9EeO2mzTn0PeW4TkGGQmVugk6u0vJcGkL1LOeQDpi13WBnH
         u/peLPG55GeCx8dZEbjAZ3gMW9RyjmRj6aktfHbQeNVlJKLA6caV7qNsN7DXU10+0Z2a
         M0Mg==
X-Gm-Message-State: AJcUukffpw8wBYFvV1g4f7aARJUt4KLUo47hIne+zSEfevkyNB25QRED
        LgLzhS9he2vEtjOESVEVGCz2+K4Nr7Fkew==
X-Google-Smtp-Source: ALg8bN7/GHOhKEkZZpB/+TYRDUI3QZkN9jke00OD1o/v+sSHFTvPPf0QG2J7Zew4fu3K8gdBT1W5Ag==
X-Received: by 2002:a17:902:a6:: with SMTP id a35mr30061746pla.201.1548848897028;
        Wed, 30 Jan 2019 03:48:17 -0800 (PST)
Received: from localhost.localdomain ([2408:84e1:e2:afd3:7c5c:7512:51d2:8f91])
        by smtp.gmail.com with ESMTPSA id v191sm2124473pgb.77.2019.01.30.03.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 03:48:16 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Sun Chao <sunchao9@huawei.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v7 0/6] pack-redundant: new algorithm to find min packs
Date:   Wed, 30 Jan 2019 19:47:30 +0800
Message-Id: <20190130114736.30357-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.1.103.ged0fc2ca7b
In-Reply-To: <20190112091754.30985-1-worldhello.net@gmail.com>
References: <20190112091754.30985-1-worldhello.net@gmail.com>
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

Derrick Stolee <stolee@gmail.com> 于2019年1月20日周日 上午9:08写道：
>
> Here is today's test coverage report.
>
> builtin/pack-redundant.c
> a338d10395 builtin/pack-redundant.c 339) static int cmp_remaining_objects(const void *a, const void *b)
> e4e2c2884e builtin/pack-redundant.c 341) struct pack_list *pl_a = *((struct pack_list **)a);
> e4e2c2884e builtin/pack-redundant.c 342) struct pack_list *pl_b = *((struct pack_list **)b);
> ...

Add new test cases in t5323 for better test coverage.

## Changes since reroll v6

* Add new test cases in t5323.

* Add new patch 2/6 (pack-redundant: delay creation of unique_objects), 
  which will fix a bug which fail to find redundant packs if turn on alt-odb
  searching with `--alt-odb` option.  This is because alt-odb objects are
  only remove in unique_objects fields but not in all_objects fields of
  pack_list.

## Range diff

1:  be6555ae60 ! 1:  799e804d5e t5323: test cases for git-pack-redundant
    @@ -43,7 +43,7 @@
     +}
     +
     +create_pack_1 () {
    -+	P1=$(git -C .git/objects/pack pack-objects -q pack <<-EOF
    ++	P1=$(git -C objects/pack pack-objects -q pack <<-EOF
     +		$T
     +		$A
     +		$B
    @@ -58,7 +58,7 @@
     +}
     +
     +create_pack_2 () {
    -+	P2=$(git -C .git/objects/pack pack-objects -q pack <<-EOF
    ++	P2=$(git -C objects/pack pack-objects -q pack <<-EOF
     +		$B
     +		$C
     +		$D
    @@ -72,7 +72,7 @@
     +}
     +
     +create_pack_3 () {
    -+	P3=$(git -C .git/objects/pack pack-objects -q pack <<-EOF
    ++	P3=$(git -C objects/pack pack-objects -q pack <<-EOF
     +		$F
     +		$I
     +		$J
    @@ -85,7 +85,7 @@
     +}
     +
     +create_pack_4 () {
    -+	P4=$(git -C .git/objects/pack pack-objects -q pack <<-EOF
    ++	P4=$(git -C objects/pack pack-objects -q pack <<-EOF
     +		$J
     +		$K
     +		$L
    @@ -97,7 +97,7 @@
     +}
     +
     +create_pack_5 () {
    -+	P5=$(git -C .git/objects/pack pack-objects -q pack <<-EOF
    ++	P5=$(git -C objects/pack pack-objects -q pack <<-EOF
     +		$G
     +		$H
     +		$N
    @@ -108,7 +108,7 @@
     +}
     +
     +create_pack_6 () {
    -+	P6=$(git -C .git/objects/pack pack-objects -q pack <<-EOF
    ++	P6=$(git -C objects/pack pack-objects -q pack <<-EOF
     +		$N
     +		$O
     +		$Q
    @@ -118,7 +118,7 @@
     +}
     +
     +create_pack_7 () {
    -+	P7=$(git -C .git/objects/pack pack-objects -q pack <<-EOF
    ++	P7=$(git -C objects/pack pack-objects -q pack <<-EOF
     +		$P
     +		$Q
     +		EOF
    @@ -127,18 +127,37 @@
     +}
     +
     +create_pack_8 () {
    -+	P8=$(git -C .git/objects/pack pack-objects -q pack <<-EOF
    ++	P8=$(git -C objects/pack pack-objects -q pack <<-EOF
     +		$A
     +		EOF
     +	) &&
     +	eval P$P8=P8:$P8
     +}
     +
    -+test_expect_success 'setup' '
    ++format_packfiles () {
    ++	sed \
    ++		-e "s#.*/pack-\(.*\)\.idx#\1#" \
    ++		-e "s#.*/pack-\(.*\)\.pack#\1#" |
    ++	sort -u |
    ++	while read p
    ++	do
    ++		if test -z "$(eval echo \${P$p})"
    ++		then
    ++			echo $p
    ++		else
    ++			eval echo "\${P$p}"
    ++		fi
    ++	done |
    ++	sort
    ++}
    ++
    ++test_expect_success 'setup master.git' '
    ++	git init --bare master.git &&
    ++	cd master.git &&
     +	create_commits
     +'
     +
    -+test_expect_success 'no redundant packs' '
    ++test_expect_success 'no redundant for pack 1, 2, 3' '
     +	create_pack_1 && create_pack_2 && create_pack_3 &&
     +	git pack-redundant --all >out &&
     +	test_must_be_empty out
    @@ -154,12 +173,7 @@
     +
     +test_expect_success 'one of pack-2/pack-3 is redundant' '
     +	git pack-redundant --all >out &&
    -+	sed \
    -+		-e "s#.*/pack-\(.*\)\.idx#\1#" \
    -+		-e "s#.*/pack-\(.*\)\.pack#\1#" out |
    -+		sort -u |
    -+		while read p; do eval echo "\${P$p}"; done |
    -+		sort >actual &&
    ++	format_packfiles <out >actual &&
     +	test_cmp expected actual
     +'
     +
    @@ -176,12 +190,7 @@
     +
     +test_expect_success 'pack 2, 4, and 6 are redundant' '
     +	git pack-redundant --all >out &&
    -+	sed \
    -+		-e "s#.*/pack-\(.*\)\.idx#\1#" \
    -+		-e "s#.*/pack-\(.*\)\.pack#\1#" out |
    -+		sort -u |
    -+		while read p; do eval echo "\${P$p}"; done |
    -+		sort >actual &&
    ++	format_packfiles <out >actual &&
     +	test_cmp expected actual
     +'
     +
    @@ -198,18 +207,13 @@
     +
     +test_expect_success 'pack-8 (subset of pack-1) is also redundant' '
     +	git pack-redundant --all >out &&
    -+	sed \
    -+		-e "s#.*/pack-\(.*\)\.idx#\1#" \
    -+		-e "s#.*/pack-\(.*\)\.pack#\1#" out |
    -+		sort -u |
    -+		while read p; do eval echo "\${P$p}"; done |
    -+		sort >actual &&
    ++	format_packfiles <out >actual &&
     +	test_cmp expected actual
     +'
     +
     +test_expect_success 'clean loose objects' '
     +	git prune-packed &&
    -+	find .git/objects -type f | sed -e "/objects\/pack\//d" >out &&
    ++	find objects -type f | sed -e "/objects\/pack\//d" >out &&
     +	test_must_be_empty out
     +'
     +
    @@ -220,4 +224,115 @@
     +	test_must_be_empty out
     +'
     +
    ++test_expect_success 'setup shared.git' '
    ++	cd "$TRASH_DIRECTORY" &&
    ++	git clone -q --mirror master.git shared.git &&
    ++	cd shared.git &&
    ++	printf "../../master.git/objects" >objects/info/alternates
    ++'
    ++
    ++test_expect_success 'no redundant packs without --alt-odb' '
    ++	git pack-redundant --all >out &&
    ++	test_must_be_empty out
    ++'
    ++
    ++cat >expected <<EOF
    ++P1:$P1
    ++P3:$P3
    ++P5:$P5
    ++P7:$P7
    ++EOF
    ++
    ++test_expect_success 'pack-redundant --verbose: show duplicate packs in stderr' '
    ++	git pack-redundant --all --verbose >out 2>out.err &&
    ++	test_must_be_empty out &&
    ++	grep "pack$" out.err | format_packfiles >actual &&
    ++	test_cmp expected actual
    ++'
    ++
    ++cat >expected <<EOF
    ++fatal: Zero packs found!
    ++EOF
    ++
    ++test_expect_success 'remove redundant packs by alt-odb, no packs left' '
    ++	git pack-redundant --all --alt-odb | xargs rm &&
    ++	git fsck --no-progress &&
    ++	test_must_fail git pack-redundant --all --alt-odb >actual 2>&1 &&
    ++	test_cmp expected actual
    ++'
    ++
    ++create_commits_others () {
    ++	parent=$(git rev-parse HEAD)
    ++	for name in X Y Z
    ++	do
    ++		test_tick &&
    ++		T=$(git write-tree) &&
    ++		if test -z "$parent"
    ++		then
    ++			oid=$(echo $name | git commit-tree $T)
    ++		else
    ++			oid=$(echo $name | git commit-tree -p $parent $T)
    ++		fi &&
    ++		eval $name=$oid &&
    ++		parent=$oid ||
    ++		return 1
    ++	done
    ++	git update-ref refs/heads/master $Z
    ++}
    ++
    ++create_pack_x1 () {
    ++	Px1=$(git -C objects/pack pack-objects -q pack <<-EOF
    ++		$X
    ++		$Y
    ++		$Z
    ++		$A
    ++		$B
    ++		$C
    ++		EOF
    ++	) &&
    ++	eval P${Px1}=Px1:${Px1}
    ++}
    ++
    ++create_pack_x2 () {
    ++	Px2=$(git -C objects/pack pack-objects -q pack <<-EOF
    ++		$X
    ++		$Y
    ++		$Z
    ++		$D
    ++		$E
    ++		$F
    ++		EOF
    ++	) &&
    ++	eval P${Px2}=Px2:${Px2}
    ++}
    ++
    ++test_expect_success 'new objects and packs in shared.git' '
    ++	create_commits_others &&
    ++	create_pack_x1 &&
    ++	create_pack_x2 &&
    ++	git pack-redundant --all >out &&
    ++	test_must_be_empty out
    ++'
    ++
    ++test_expect_success 'one pack is redundant' '
    ++	git pack-redundant --all --alt-odb >out &&
    ++	format_packfiles <out >actual &&
    ++	test_line_count = 1 actual
    ++'
    ++
    ++cat >expected <<EOF
    ++Px1:$Px1
    ++Px2:$Px2
    ++EOF
    ++
    ++test_expect_success 'set ignore objects and all two packs are redundant' '
    ++	git pack-redundant --all --alt-odb >out <<-EOF &&
    ++		$X
    ++		$Y
    ++		$Z
    ++		EOF
    ++	format_packfiles <out >actual &&
    ++	test_cmp expected actual
    ++'
    ++
     +test_done
-:  ---------- > 2:  520f6277fb pack-redundant: delay creation of unique_objects
2:  e4e2c2884e ! 3:  ab1c2c4950 pack-redundant: new algorithm to find min packs
    @@ -64,6 +64,9 @@
         4. Drop the duplicated objects from other packs in the ordered
            non_unique pack list, and repeat step 3.
     
    +    Some test cases will fail on Mac OS X. Mark them and will resolve in
    +    later commit.
    +
         Original PR and discussions: https://github.com/jiangxin/git/pull/25
     
         Signed-off-by: Sun Chao <sunchao9@huawei.com>
    @@ -213,11 +216,61 @@
      	struct llist *ignore;
      	struct object_id *oid;
      	char buf[GIT_MAX_HEXSZ + 2]; /* hex hash + \n + \0 */
    +
    + diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
    + --- a/t/t5323-pack-redundant.sh
    + +++ b/t/t5323-pack-redundant.sh
     @@
    - 	pl = local_packs;
    - 	while (pl) {
    - 		llist_sorted_difference_inplace(pl->unique_objects, ignore);
    -+		llist_sorted_difference_inplace(pl->all_objects, ignore);
    - 		pl = pl->next;
    - 	}
    + P2:$P2
    + EOF
    + 
    +-test_expect_success 'one of pack-2/pack-3 is redundant' '
    ++test_expect_failure 'one of pack-2/pack-3 is redundant' '
    + 	git pack-redundant --all >out &&
    + 	format_packfiles <out >actual &&
    + 	test_cmp expected actual
    +@@
    + P6:$P6
    + EOF
    + 
    +-test_expect_success 'pack 2, 4, and 6 are redundant' '
    ++test_expect_failure 'pack 2, 4, and 6 are redundant' '
    + 	git pack-redundant --all >out &&
    + 	format_packfiles <out >actual &&
    + 	test_cmp expected actual
    +@@
    + P8:$P8
    + EOF
    + 
    +-test_expect_success 'pack-8 (subset of pack-1) is also redundant' '
    ++test_expect_failure 'pack-8 (subset of pack-1) is also redundant' '
    + 	git pack-redundant --all >out &&
    + 	format_packfiles <out >actual &&
    + 	test_cmp expected actual
    +@@
    + 	test_must_be_empty out
    + '
    + 
    +-test_expect_success 'remove redundant packs and pass fsck' '
    ++test_expect_failure 'remove redundant packs and pass fsck' '
    + 	git pack-redundant --all | xargs rm &&
    + 	git fsck --no-progress &&
    + 	git pack-redundant --all >out &&
    +@@
    + 	printf "../../master.git/objects" >objects/info/alternates
    + '
    + 
    +-test_expect_success 'no redundant packs without --alt-odb' '
    ++test_expect_failure 'no redundant packs without --alt-odb' '
    + 	git pack-redundant --all >out &&
    + 	test_must_be_empty out
    + '
    +@@
    + P7:$P7
    + EOF
      
    +-test_expect_success 'pack-redundant --verbose: show duplicate packs in stderr' '
    ++test_expect_failure 'pack-redundant --verbose: show duplicate packs in stderr' '
    + 	git pack-redundant --all --verbose >out 2>out.err &&
    + 	test_must_be_empty out &&
    + 	grep "pack$" out.err | format_packfiles >actual &&
3:  e60b134e66 = 4:  3c3a7ea40f pack-redundant: remove unused functions
4:  cb7e0336fc ! 5:  bc4b681f40 pack-redundant: rename pack_list.all_objects
    @@ -20,6 +20,18 @@
      } *local_packs = NULL, *altodb_packs = NULL;
      
      static struct llist_item *free_nodes;
    +@@
    + 	const unsigned int hashsz = the_hash_algo->rawsz;
    + 
    + 	if (!p1->unique_objects)
    +-		p1->unique_objects = llist_copy(p1->all_objects);
    ++		p1->unique_objects = llist_copy(p1->remaining_objects);
    + 	if (!p2->unique_objects)
    +-		p2->unique_objects = llist_copy(p2->all_objects);
    ++		p2->unique_objects = llist_copy(p2->remaining_objects);
    + 
    + 	p1_base = p1->pack->index_data;
    + 	p2_base = p2->pack->index_data;
     @@
      {
      	struct pack_list *pl_a = *((struct pack_list **)a);
    @@ -94,10 +106,12 @@
      	}
      }
     @@
    + 	while (alt) {
      		local = local_packs;
      		while (local) {
    - 			llist_sorted_difference_inplace(local->unique_objects,
    +-			llist_sorted_difference_inplace(local->all_objects,
     -							alt->all_objects);
    ++			llist_sorted_difference_inplace(local->remaining_objects,
     +							alt->remaining_objects);
      			local = local->next;
      		}
    @@ -123,16 +137,11 @@
     +		llist_insert_back(l.remaining_objects, (const struct object_id *)(base + off));
      		off += step;
      	}
    - 	/* this list will be pruned in cmp_two_packs later */
    --	l.unique_objects = llist_copy(l.all_objects);
    -+	l.unique_objects = llist_copy(l.remaining_objects);
    - 	if (p->pack_local)
    - 		return pack_list_insert(&local_packs, &l);
    - 	else
    + 	l.unique_objects = NULL;
     @@
    + 	llist_sorted_difference_inplace(all_objects, ignore);
      	pl = local_packs;
      	while (pl) {
    - 		llist_sorted_difference_inplace(pl->unique_objects, ignore);
     -		llist_sorted_difference_inplace(pl->all_objects, ignore);
     +		llist_sorted_difference_inplace(pl->remaining_objects, ignore);
      		pl = pl->next;
5:  a338d10395 ! 6:  6cfba5b4b2 pack-redundant: consistent sort method
    @@ -75,9 +75,9 @@
      		off += step;
      	}
     +	l.all_objects_size = l.remaining_objects->size;
    - 	/* this list will be pruned in cmp_two_packs later */
    - 	l.unique_objects = llist_copy(l.remaining_objects);
    + 	l.unique_objects = NULL;
      	if (p->pack_local)
    + 		return pack_list_insert(&local_packs, &l);
     
      diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
      --- a/t/t5323-pack-redundant.sh
    @@ -90,4 +90,53 @@
     +P3:$P3
      EOF
      
    - test_expect_success 'one of pack-2/pack-3 is redundant' '
    +-test_expect_failure 'one of pack-2/pack-3 is redundant' '
    ++test_expect_success 'one of pack-2/pack-3 is redundant' '
    + 	git pack-redundant --all >out &&
    + 	format_packfiles <out >actual &&
    + 	test_cmp expected actual
    +@@
    + P6:$P6
    + EOF
    + 
    +-test_expect_failure 'pack 2, 4, and 6 are redundant' '
    ++test_expect_success 'pack 2, 4, and 6 are redundant' '
    + 	git pack-redundant --all >out &&
    + 	format_packfiles <out >actual &&
    + 	test_cmp expected actual
    +@@
    + P8:$P8
    + EOF
    + 
    +-test_expect_failure 'pack-8 (subset of pack-1) is also redundant' '
    ++test_expect_success 'pack-8 (subset of pack-1) is also redundant' '
    + 	git pack-redundant --all >out &&
    + 	format_packfiles <out >actual &&
    + 	test_cmp expected actual
    +@@
    + 	test_must_be_empty out
    + '
    + 
    +-test_expect_failure 'remove redundant packs and pass fsck' '
    ++test_expect_success 'remove redundant packs and pass fsck' '
    + 	git pack-redundant --all | xargs rm &&
    + 	git fsck --no-progress &&
    + 	git pack-redundant --all >out &&
    +@@
    + 	printf "../../master.git/objects" >objects/info/alternates
    + '
    + 
    +-test_expect_failure 'no redundant packs without --alt-odb' '
    ++test_expect_success 'no redundant packs without --alt-odb' '
    + 	git pack-redundant --all >out &&
    + 	test_must_be_empty out
    + '
    +@@
    + P7:$P7
    + EOF
    + 
    +-test_expect_failure 'pack-redundant --verbose: show duplicate packs in stderr' '
    ++test_expect_success 'pack-redundant --verbose: show duplicate packs in stderr' '
    + 	git pack-redundant --all --verbose >out 2>out.err &&
    + 	test_must_be_empty out &&
    + 	grep "pack$" out.err | format_packfiles >actual &&

--
Jiang Xin (4):
  t5323: test cases for git-pack-redundant
  pack-redundant: delay creation of unique_objects
  pack-redundant: rename pack_list.all_objects
  pack-redundant: consistent sort method

Sun Chao (2):
  pack-redundant: new algorithm to find min packs
  pack-redundant: remove unused functions

 builtin/pack-redundant.c  | 233 +++++++++++----------------
 t/t5323-pack-redundant.sh | 322 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 415 insertions(+), 140 deletions(-)
 create mode 100755 t/t5323-pack-redundant.sh

-- 
2.20.1.103.ged0fc2ca7b

