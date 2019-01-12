Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBA42211B4
	for <e@80x24.org>; Sat, 12 Jan 2019 09:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbfALJTv (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Jan 2019 04:19:51 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45688 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfALJTu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jan 2019 04:19:50 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so8070008pfd.12
        for <git@vger.kernel.org>; Sat, 12 Jan 2019 01:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ik9lSPDsFjV9J1JhXkYVKzxZhotOXFquUTj0qAXM7Ks=;
        b=Gri6V07CMQH+z4k4I3LOZplZmn3YOi1A+qHFGsz7MgV9Ykcff7jJm0cpAnTvCzWtIB
         O5ln3lHnNpvP2QqU0PcMN99I5iKtbVksMoXqU1WmwvCn0NfDBS015nkDBmelYSy4/+Kh
         HiOhk2hcJ5b+CVlUbXZ6olLZ7dTSlDaHlKomdCCmt7FX/UvA3ZzbCUaA1+ngJqgdZw8m
         XJiMnp9MZCQaKehY5En8GymQsAUO/5WKNsS0meFUeVH7cBdOqOvo/L5uFA/1s7LiIPUX
         OvQX45TH/G8mAmpXn6J4Kf9JHYgxM9sbsddgefmsnHiP2w7/iyHbsgfN6+jE2JpisC38
         wTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ik9lSPDsFjV9J1JhXkYVKzxZhotOXFquUTj0qAXM7Ks=;
        b=EpY2z96Vkn9P682cxUPkkXT7R4MA9pLNH86PZ6s513/Hys5yQNgk5419/SbtYfZTwD
         caZR5crhf7tf7wPD78Y/2cnN/VUITrZMBuEh6URSXpKCA5Vqu1+s6yZ7kyjBZxC0uh6a
         0bFhrvGhzk7oFh00qXxo5aBG2JqufvPwpIt9mGrxZEn7VXVaEjSd4nh5h4nDCMc/3HDH
         fR/z66kFWatfBGPTohg76DLRPMsXueYLsllxaDG72Z+rq88cWydabUfgTXwMZqUL6LVE
         g4v7zNTJwAi9lY0NVkjPpJszNpXblKrWW2G21P9RpGPiXRJNorcCuYLQHfr1b2lzRJTA
         EAcw==
X-Gm-Message-State: AJcUukegiuZebPG6y+d7MAg0SnOF9+OS7+LRB5ybFN9AWvOIV7c/vQrQ
        gX3/FDbYmiSUalxVOfdEq/g=
X-Google-Smtp-Source: ALg8bN44pztrpKyx5cMYgG3HIPEe+DI8mihx3BtO6JAC3OwAJhAH/TlSA0s5tsusXeOcwZPISEMJWA==
X-Received: by 2002:aa7:8354:: with SMTP id z20mr17659585pfm.81.1547284788088;
        Sat, 12 Jan 2019 01:19:48 -0800 (PST)
Received: from localhost.localdomain ([221.222.155.87])
        by smtp.gmail.com with ESMTPSA id i5sm27685510pfg.34.2019.01.12.01.19.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 01:19:47 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Sun Chao <sunchao9@huawei.com>
Subject: [PATCH v6 0/5] pack-redundant: new algorithm to find min packs
Date:   Sat, 12 Jan 2019 17:17:49 +0800
Message-Id: <20190112091754.30985-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.0.3.gc45e608566
In-Reply-To: <20190110120142.22271-1-worldhello.net@gmail.com>
References: <20190110120142.22271-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Sun Chao (my former colleague at Huawei) found a bug of
> git-pack-redundant.  If there are too many packs and many of them
> overlap each other, running `git pack-redundant --all` will
> exhaust all memories and the process will be killed by kernel.
> 
> There is a script in commit log of commit 2/5, which can be used to
> create a repository with lots of redundant packs. Running `git
> pack-redundant --all` in it can reproduce this issue.


Junio C Hamano <gitster@pobox.com> 于2019年1月12日周六 上午2:00写道：
> >> Yikes.  Can't "git pack-objects" get the input directly without
> >> overlong printf, something along the lines of...
> >>
> >>         P1=$(git -C .git/objects/pack pack-objects pack <<-EOF
> >>                 $A
> >>                 $B
> >>                 $C
> >>                 ...
> >>                 $R
> >>                 EOF
> >>         )
> >
> > Find that no space before <OID>,  because git-pack-objects not allow that,
> > and mached parentheses should in the same line.
> > So Will write like this:
> >
> >     create_pack_1() {
> >             P1=$(git -C .git/objects/pack pack-objects pack <<-EOF) &&
> >     $T
>
> Isn't the whole point of <<-EOF (notice the leading dash) to allow
> us to indent the here-doc with horizontal tab?

The reason that indents are not stripped even with `<<-EOF` is I mixed
tabs and spaces to make a better align.

If put the heredoc outside the parentheses, it will failed on MacOS, so
use the syntax Junio previously suggested.


SZEDER Gábor <szeder.dev@gmail.com> 于2019年1月11日周五 上午9:19写道：
> I see that the last patch in this series removes those three
> unused functions, but that patch should be squashed into this one to
> keep Git buildable with '-Werror' or DEVELOPER=1.
>
> Furthermore, after building this patch (without '-Werror'), several
> tests in 't5323-pack-redundant.sh' fail.  To avoid the test failure I
> think the fourth patch ensuring a consistent sort order should be
> squashed in as well.
Patch 3/5 to 5/5 can be squashed to patch 2/5.


## Changes since reroll v5


1:  40fea5d67f ! 1:  7e4e703083 t5323: test cases for git-pack-redundant
    @@ -22,8 +22,7 @@
     +
     +. ./test-lib.sh
     +
    -+create_commits()
    -+{
    ++create_commits() {
     +	parent=
     +	for name in A B C D E F G H I J K L M N O P Q R
     +	do
    @@ -39,54 +38,98 @@
     +		parent=$oid ||
     +		return 1
     +	done
    -+	git update-ref refs/heads/master $M
    ++	git update-ref refs/heads/master $R
     +}
     +
    -+create_pack_1()
    -+{
    -+	P1=$(cd .git/objects/pack; printf "$T\n$A\n$B\n$C\n$D\n$E\n$F\n$R\n" | git pack-objects pack 2>/dev/null) &&
    ++create_pack_1() {
    ++	P1=$(git -C .git/objects/pack pack-objects -q pack <<-EOF
    ++		$T
    ++		$A
    ++		$B
    ++		$C
    ++		$D
    ++		$E
    ++		$F
    ++		$R
    ++		EOF
    ++	) &&
     +	eval P$P1=P1:$P1
     +}
     +
    -+create_pack_2()
    -+{
    -+	P2=$(cd .git/objects/pack; printf "$B\n$C\n$D\n$E\n$G\n$H\n$I\n" | git pack-objects pack 2>/dev/null) &&
    ++create_pack_2() {
    ++	P2=$(git -C .git/objects/pack pack-objects -q pack <<-EOF
    ++		$B
    ++		$C
    ++		$D
    ++		$E
    ++		$G
    ++		$H
    ++		$I
    ++		EOF
    ++	) &&
     +	eval P$P2=P2:$P2
     +}
     +
    -+create_pack_3()
    -+{
    -+	P3=$(cd .git/objects/pack; printf "$F\n$I\n$J\n$K\n$L\n$M\n" | git pack-objects pack 2>/dev/null) &&
    ++create_pack_3() {
    ++	P3=$(git -C .git/objects/pack pack-objects -q pack <<-EOF
    ++		$F
    ++		$I
    ++		$J
    ++		$K
    ++		$L
    ++		$M
    ++		EOF
    ++	) &&
     +	eval P$P3=P3:$P3
     +}
     +
    -+create_pack_4()
    -+{
    -+	P4=$(cd .git/objects/pack; printf "$J\n$K\n$L\n$M\n$P\n" | git pack-objects pack 2>/dev/null) &&
    ++create_pack_4() {
    ++	P4=$(git -C .git/objects/pack pack-objects -q pack <<-EOF
    ++		$J
    ++		$K
    ++		$L
    ++		$M
    ++		$P
    ++		EOF
    ++	) &&
     +	eval P$P4=P4:$P4
     +}
     +
    -+create_pack_5()
    -+{
    -+	P5=$(cd .git/objects/pack; printf "$G\n$H\n$N\n$O\n" | git pack-objects pack 2>/dev/null) &&
    ++create_pack_5() {
    ++	P5=$(git -C .git/objects/pack pack-objects -q pack <<-EOF
    ++		$G
    ++		$H
    ++		$N
    ++		$O
    ++		EOF
    ++	) &&
     +	eval P$P5=P5:$P5
     +}
     +
    -+create_pack_6()
    -+{
    -+	P6=$(cd .git/objects/pack; printf "$N\n$O\n$Q\n" | git pack-objects pack 2>/dev/null) &&
    ++create_pack_6() {
    ++	P6=$(git -C .git/objects/pack pack-objects -q pack <<-EOF
    ++		$N
    ++		$O
    ++		$Q
    ++		EOF
    ++	) &&
     +	eval P$P6=P6:$P6
     +}
     +
    -+create_pack_7()
    -+{
    -+	P7=$(cd .git/objects/pack; printf "$P\n$Q\n" | git pack-objects pack 2>/dev/null) &&
    ++create_pack_7() {
    ++	P7=$(git -C .git/objects/pack pack-objects -q pack <<-EOF
    ++		$P
    ++		$Q
    ++		EOF
    ++	) &&
     +	eval P$P7=P7:$P7
     +}
     +
    -+create_pack_8()
    -+{
    -+	P8=$(cd .git/objects/pack; printf "$A\n" | git pack-objects pack 2>/dev/null) &&
    ++create_pack_8() {
    ++	P8=$(git -C .git/objects/pack pack-objects -q pack <<-EOF
    ++		$A
    ++		EOF
    ++	) &&
     +	eval P$P8=P8:$P8
     +}
     +
    @@ -110,10 +153,12 @@
     +
     +test_expect_success 'one of pack-2/pack-3 is redundant' '
     +	git pack-redundant --all >out &&
    -+	sed -E -e "s#.*/pack-(.*)\.(idx|pack)#\1#" out | \
    -+		sort -u | \
    -+		while read p; do eval echo "\${P$p}"; done | \
    -+		sort >actual && \
    ++	sed \
    ++		-e "s#.*/pack-\(.*\)\.idx#\1#" \
    ++		-e "s#.*/pack-\(.*\)\.pack#\1#" out |
    ++		sort -u |
    ++		while read p; do eval echo "\${P$p}"; done |
    ++		sort >actual &&
     +	test_cmp expected actual
     +'
     +
    @@ -121,6 +166,7 @@
     +	create_pack_6 && create_pack_7
     +'
     +
    ++# Only after calling create_pack_6, we can use $P6 variable.
     +cat >expected <<EOF
     +P2:$P2
     +P4:$P4
    @@ -129,10 +175,12 @@
     +
     +test_expect_success 'pack 2, 4, and 6 are redundant' '
     +	git pack-redundant --all >out &&
    -+	sed -E -e "s#.*/pack-(.*)\.(idx|pack)#\1#" out | \
    -+		sort -u | \
    -+		while read p; do eval echo "\${P$p}"; done | \
    -+		sort >actual && \
    ++	sed \
    ++		-e "s#.*/pack-\(.*\)\.idx#\1#" \
    ++		-e "s#.*/pack-\(.*\)\.pack#\1#" out |
    ++		sort -u |
    ++		while read p; do eval echo "\${P$p}"; done |
    ++		sort >actual &&
     +	test_cmp expected actual
     +'
     +
    @@ -147,24 +195,26 @@
     +P8:$P8
     +EOF
     +
    -+test_expect_success 'pack-8, subset of pack-1, is also redundant' '
    ++test_expect_success 'pack-8 (subset of pack-1) is also redundant' '
     +	git pack-redundant --all >out &&
    -+	sed -E -e "s#.*/pack-(.*)\.(idx|pack)#\1#" out | \
    -+		sort -u | \
    -+		while read p; do eval echo "\${P$p}"; done | \
    -+		sort >actual && \
    ++	sed \
    ++		-e "s#.*/pack-\(.*\)\.idx#\1#" \
    ++		-e "s#.*/pack-\(.*\)\.pack#\1#" out |
    ++		sort -u |
    ++		while read p; do eval echo "\${P$p}"; done |
    ++		sort >actual &&
     +	test_cmp expected actual
     +'
     +
    -+test_expect_success 'clear loose objects' '
    ++test_expect_success 'clean loose objects' '
     +	git prune-packed &&
     +	find .git/objects -type f | sed -e "/objects\/pack\//d" >out &&
     +	test_must_be_empty out
     +'
     +
    -+test_expect_success 'remove redundant packs' '
    ++test_expect_success 'remove redundant packs and pass fsck' '
     +	git pack-redundant --all | xargs rm &&
    -+	git fsck &&
    ++	git fsck --no-progress &&
     +	git pack-redundant --all >out &&
     +	test_must_be_empty out
     +'
2:  50cd5a5b47 ! 2:  51a9c2d8a5 pack-redundant: new algorithm to find min packs
    @@ -67,7 +67,7 @@
         Original PR and discussions: https://github.com/jiangxin/git/pull/25
     
         Signed-off-by: Sun Chao <sunchao9@huawei.com>
    -    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
    +    Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
5:  b7ccdea1ad ! 3:  c5eb21c23c pack-redundant: remove unused functions
    @@ -6,14 +6,14 @@
         `pll_free`, etc.
     
         Signed-off-by: Sun Chao <sunchao9@huawei.com>
    -    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
    +    Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
      --- a/builtin/pack-redundant.c
      +++ b/builtin/pack-redundant.c
     @@
    - 	size_t all_objects_size;
    + 	struct llist *all_objects;
      } *local_packs = NULL, *altodb_packs = NULL;
      
     -struct pll {
    @@ -105,7 +105,7 @@
     -	diff = llist_copy(list);
     -
     -	while (pl) {
    --		llist_sorted_difference_inplace(diff, pl->remaining_objects);
    +-		llist_sorted_difference_inplace(diff, pl->all_objects);
     -		if (diff->size == 0) { /* we're done */
     -			llist_free(diff);
     -			return 1;
3:  6338c6fad4 ! 4:  1acdd0af1e pack-redundant: rename pack_list.all_objects
    @@ -18,16 +18,7 @@
     +	struct llist *remaining_objects;
      } *local_packs = NULL, *altodb_packs = NULL;
      
    - struct pll {
    -@@
    - 	diff = llist_copy(list);
    - 
    - 	while (pl) {
    --		llist_sorted_difference_inplace(diff, pl->all_objects);
    -+		llist_sorted_difference_inplace(diff, pl->remaining_objects);
    - 		if (diff->size == 0) { /* we're done */
    - 			llist_free(diff);
    - 			return 1;
    + static struct llist_item *free_nodes;
     @@
      {
      	struct pack_list *pl_a = *((struct pack_list **)a);
4:  734f4d8a8b ! 5:  306d515cda pack-redundant: consistent sort method
    @@ -26,7 +26,7 @@
     +	size_t all_objects_size;
      } *local_packs = NULL, *altodb_packs = NULL;
      
    - struct pll {
    + static struct llist_item *free_nodes;
     @@
      	return ret;
      }
    @@ -42,20 +42,24 @@
     -	if (sz_a == sz_b)
     -		return 0;
     -	else if (sz_a < sz_b)
    -+	/* if have the same remaining_objects, big pack first */
    -+	if (pl_a->remaining_objects->size == pl_b->remaining_objects->size)
    ++	if (pl_a->remaining_objects->size == pl_b->remaining_objects->size) {
    ++		/* have the same remaining_objects, big pack first */
     +		if (pl_a->all_objects_size == pl_b->all_objects_size)
     +			return 0;
     +		else if (pl_a->all_objects_size < pl_b->all_objects_size)
     +			return 1;
     +		else
     +			return -1;
    -+
    -+	/* sort according to remaining objects, more remaining objects first */
    -+	if (pl_a->remaining_objects->size < pl_b->remaining_objects->size)
    ++	} else if (pl_a->remaining_objects->size < pl_b->remaining_objects->size) {
    ++		/* sort by remaining objects, more objects first */
      		return 1;
    - 	else
    +-	else
    ++	} else {
      		return -1;
    ++	}
    + }
    + 
    + /* Sort pack_list, greater size of remaining_objects first */
     @@
      	for (n = 0, p = *pl; p; p = p->next)
      		ary[n++] = p;

## This reroll has the following commits:

Jiang Xin (3):
  t5323: test cases for git-pack-redundant
  pack-redundant: rename pack_list.all_objects
  pack-redundant: consistent sort method

Sun Chao (2):
  pack-redundant: new algorithm to find min packs
  pack-redundant: remove unused functions

 builtin/pack-redundant.c  | 221 +++++++++++++++-----------------------
 t/t5323-pack-redundant.sh | 207 +++++++++++++++++++++++++++++++++++
 2 files changed, 292 insertions(+), 136 deletions(-)
 create mode 100755 t/t5323-pack-redundant.sh

-- 
2.20.0.3.gc45e608566

