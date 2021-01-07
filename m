Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6CFC433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 15:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7847423406
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 15:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbhAGPiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 10:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbhAGPiB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 10:38:01 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF473C0612F4
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 07:37:20 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id b5so4017830pjl.0
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 07:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=teEuy2B0aBrg3iPy+fus0pnSjz66kAtlCXXipGFNHBk=;
        b=M1M+KFoihjEbnZTPk3vUbYGAa9BZ/7Bm9xcoU8iuzoMrDfpM5ejujNDKEhsRm0+JqE
         i5QR5rbZjrZGKehU4n8tcMH/WnPBcMSZ4yQ6rllQjXZHhzjc6AYeMEBtEdFqQkrmO/yE
         YNa7go1B8E5R1i+YFbrtFJxcTbVlyIQJE9qgvveT6jS16RTu9rVNy6W+l/36orgPC8Tg
         patZ1NIfoYTocQee0Fqf6BnBIDZZGmbq8ljWgsTYr1AMgfkTnCI8UUQ90KMCu9d6RW3B
         Wy6lc0vArQ5THVHNJQ0wILDtyC0BW5ouhJDLv4buY0RDn3jBk6FB6xI/GKgoHt/KDRnT
         u6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=teEuy2B0aBrg3iPy+fus0pnSjz66kAtlCXXipGFNHBk=;
        b=gE8ll1RWrK+6WIJite17/4InV76w35E2CpSahEZUhdsT1OqOxCAeKHe+KEtCbDl4Oa
         Bcz+ZENvSaW2bmJ4aqzCDlbzdSM7frS8ldvxMxNWjE91pg6zkcoI/7QyL8gzrEpTMVqh
         /w5nqTPOADsFvBQ0Sg/YGkK7TGwGo8DmGqGmOA4LzWRb+rVAHmBw9iu45RFh1C8VrkK2
         JgTz8C+00LJY5qebgpqWSqLiVyusR4MvE4asTE/hV7AAcYqnKZUspfvRWL76ISvoTvjf
         1qXjDcMIo5LpUpKIOsAF5u6rjElEuHfvJ2KfM5jWPx1lipIA11MbP66UDUPDAtBbLx5F
         qiVA==
X-Gm-Message-State: AOAM530GEJKcQCe3QERPz+ySo2OVV2booVs7dVRW+64JDy3Wqlwop2RZ
        gFRSYGl9dZOy0ZPALsfmkaQ=
X-Google-Smtp-Source: ABdhPJw+8L05v1s/lOkKkZ5TLzR3ArQIpdMKJBMtTMBnVdWX+B3StAFyG1/OP6h2S2CbjMWFqdF5lA==
X-Received: by 2002:a17:90b:943:: with SMTP id dw3mr9495075pjb.97.1610033840239;
        Thu, 07 Jan 2021 07:37:20 -0800 (PST)
Received: from localhost ([2402:800:63a8:f5bb:2516:717f:2f37:c4c0])
        by smtp.gmail.com with ESMTPSA id w9sm5825500pfj.128.2021.01.07.07.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 07:37:19 -0800 (PST)
Date:   Thu, 7 Jan 2021 22:37:17 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v3 1/2] bundle: lost objects when removing duplicate
 pendings
Message-ID: <X/cqrTgilKAW9P9G@danh.dev>
References: <xmqqft3g6ziz.fsf@gitster.c.googlers.com>
 <20210107135025.2682-2-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107135025.2682-2-worldhello.net@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-01-07 08:50:24-0500, Jiang Xin <worldhello.net@gmail.com> wrote:
> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> 
> `git rev-list` will list one commit for the following command:
> 
>     $ git rev-list 'main^!'
>     <tip-commit-of-main-branch>
> 
> But providing the same rev-list args to `git bundle`, fail to create
> a bundle file.
> 
>     $ git bundle create - 'main^!'
>     # v2 git bundle
>     -<OID> <one-line-message>
> 
>     fatal: Refusing to create empty bundle.
> 
> This is because when removing duplicate objects in function
> `object_array_remove_duplicates()`, one unique pending object which has
> the same name is deleted by mistake.  The revision arg 'main^!' in the
> above example is parsed by `handle_revision_arg()`, and at lease two
> different objects will be appended to `revs.pending`, one points to the
> parent commit of the "main" branch, and the other points to the tip
> commit of the "main" branch.  These two objects have the same name
> "main".  Only one object is left with the name "main" after calling the
> function `object_array_remove_duplicates()`.
> 
> And what's worse, when adding boundary commits into pending list, we use
> one-line commit message as names, and the arbitory names may surprise
> git-bundle.
> 
> Only comparing objects themselves (".item") is also not good enough,
> because user may want to create a bundle with two identical objects but
> with different reference names, such as: "HEAD" and "refs/heads/main".
> 
> Add new function `contains_object()` which compare both the address and
> the name of the object.
> 
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  object.c               |  10 +-
>  t/t6020-bundle-misc.sh | 488 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 494 insertions(+), 4 deletions(-)
>  create mode 100755 t/t6020-bundle-misc.sh
> 
> diff --git a/object.c b/object.c
> index 68f80b0b3d..98017bed8e 100644
> --- a/object.c
> +++ b/object.c
> @@ -412,15 +412,16 @@ void object_array_clear(struct object_array *array)
>  }
>  
>  /*
> - * Return true iff array already contains an entry with name.
> + * Return true if array already contains an entry.
>   */
> -static int contains_name(struct object_array *array, const char *name)
> +static int contains_object(struct object_array *array,
> +			   const struct object *item, const char *name)
>  {
>  	unsigned nr = array->nr, i;
>  	struct object_array_entry *object = array->objects;
>  
>  	for (i = 0; i < nr; i++, object++)
> -		if (!strcmp(object->name, name))
> +		if (item == object->item && !strcmp(object->name, name))

I think the comparison of `item == object->item` is a bit too fragile.
Yes, we all know `item` must be an entry of array.
However, it's separated from its usage may lead to misuse in the
future. Perhaps using `oidcmp` or adding a comment to indicate that
`item` must be an entry of `array`.

>  			return 1;
>  	return 0;
>  }
> @@ -432,7 +433,8 @@ void object_array_remove_duplicates(struct object_array *array)
>  
>  	array->nr = 0;
>  	for (src = 0; src < nr; src++) {
> -		if (!contains_name(array, objects[src].name)) {
> +		if (!contains_object(array, objects[src].item,
> +				     objects[src].name)) {
>  			if (src != array->nr)
>  				objects[array->nr] = objects[src];
>  			array->nr++;
> diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
> new file mode 100755
> index 0000000000..d15e67c8f7
> --- /dev/null
> +++ b/t/t6020-bundle-misc.sh
> @@ -0,0 +1,488 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2021 Jiang Xin
> +#
> +
> +test_description='Test git-bundle'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +
> +test_bundle_object_count () {
> +	bundle=$1 &&
> +	pack=${bundle%.bdl}.pack &&
> +	convert_bundle_to_pack <"$bundle" >"$pack" &&
> +	git index-pack "$pack" &&
> +	git verify-pack -v "$pack" >verify.out &&
> +	count=$(grep "^$OID_REGEX " verify.out | wc -l) &&

I think we can use 'grep -c' instead of `grep .. | wc -l`.

Or

	grep "^$OID_REGEX " verify.out >verify.filtered &&
	test_line_count = $2 verify.filtered

The same comment applied to test_thin_bundle_object_count

> +	test $2 = $count && return 0
> +	echo object count for $bundle is $count, not $2
> +	return 1
> +}
> +
> +
> +test_thin_bundle_object_count () {
> +	bundle=$1 &&
> +	pack=${bundle%.bdl}.pack &&
> +	convert_bundle_to_pack <"$bundle" |
> +		test_must_fail git index-pack --stdin "$pack" &&
> +	rm -f "$pack" &&
> +	convert_bundle_to_pack <"$bundle" |
> +		git index-pack --stdin --fix-thin "$pack" &&
> +	git verify-pack -v "$pack" >verify.out &&
> +	count=$(grep "^$OID_REGEX " verify.out | wc -l) &&
> +	test $2 = $count && return 0
> +	echo object count for $bundle is $count, not $2
> +	return 1
> +}
> +
> +convert_bundle_to_pack () {
> +	while read x && test -n "$x"
> +	do
> +		:;
> +	done
> +	cat

I'm not sure what you would expect in this case,
but in my experience, I replace this whole block with

	sed '1,/^$/d'

also works.

IOW, I would apply this on top of your change:

----8<-----
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 1f60fe180e..3a428454d7 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -16,10 +16,8 @@ test_bundle_object_count () {
 	convert_bundle_to_pack <"$bundle" >"$pack" &&
 	git index-pack "$pack" &&
 	git verify-pack -v "$pack" >verify.out &&
-	count=$(grep "^$OID_REGEX " verify.out | wc -l) &&
-	test $2 = $count && return 0
-	echo object count for $bundle is $count, not $2
-	return 1
+	grep "^$OID_REGEX " verify.out >verify.filtered &&
+	test_line_count = $2 verify.filtered
 }
 
 
@@ -32,18 +30,12 @@ test_thin_bundle_object_count () {
 	convert_bundle_to_pack <"$bundle" |
 		git index-pack --stdin --fix-thin "$pack" &&
 	git verify-pack -v "$pack" >verify.out &&
-	count=$(grep "^$OID_REGEX " verify.out | wc -l) &&
-	test $2 = $count && return 0
-	echo object count for $bundle is $count, not $2
-	return 1
+	grep "^$OID_REGEX " verify.out >verify.filtered &&
+	test_line_count = $2 verify.filtered
 }
 
 convert_bundle_to_pack () {
-	while read x && test -n "$x"
-	do
-		:;
-	done
-	cat
+	sed '1,/^$/d'
 }
 
 # Format the output of git commands to make a user-friendly and stable
----->8-----

For the below change, I haven't checked but I think test_commit should work, no?

-- Danh

> +}
> +
> +# Format the output of git commands to make a user-friendly and stable
> +# text.  We can easily prepare the expect text without having to worry
> +# about future changes of the commit ID and spaces of the output.
> +make_user_friendly_and_stable_output () {
> +	sed \
> +		-e "s/ *\$//" \
> +		-e "s/$A/<COMMIT-A>/g" \
> +		-e "s/$B/<COMMIT-B>/g" \
> +		-e "s/$C/<COMMIT-C>/g" \
> +		-e "s/$D/<COMMIT-D>/g" \
> +		-e "s/$E/<COMMIT-E>/g" \
> +		-e "s/$F/<COMMIT-F>/g" \
> +		-e "s/$G/<COMMIT-G>/g" \
> +		-e "s/$H/<COMMIT-H>/g" \
> +		-e "s/$I/<COMMIT-I>/g" \
> +		-e "s/$J/<COMMIT-J>/g" \
> +		-e "s/$K/<COMMIT-K>/g" \
> +		-e "s/$L/<COMMIT-L>/g" \
> +		-e "s/$M/<COMMIT-M>/g" \
> +		-e "s/$N/<COMMIT-N>/g" \
> +		-e "s/$O/<COMMIT-O>/g" \
> +		-e "s/$P/<COMMIT-P>/g" \
> +		-e "s/$(echo $A | cut -c1-7)[0-9a-f]*/<OID-A>/g" \
> +		-e "s/$(echo $B | cut -c1-7)[0-9a-f]*/<OID-B>/g" \
> +		-e "s/$(echo $C | cut -c1-7)[0-9a-f]*/<OID-C>/g" \
> +		-e "s/$(echo $D | cut -c1-7)[0-9a-f]*/<OID-D>/g" \
> +		-e "s/$(echo $E | cut -c1-7)[0-9a-f]*/<OID-E>/g" \
> +		-e "s/$(echo $F | cut -c1-7)[0-9a-f]*/<OID-F>/g" \
> +		-e "s/$(echo $G | cut -c1-7)[0-9a-f]*/<OID-G>/g" \
> +		-e "s/$(echo $H | cut -c1-7)[0-9a-f]*/<OID-H>/g" \
> +		-e "s/$(echo $I | cut -c1-7)[0-9a-f]*/<OID-I>/g" \
> +		-e "s/$(echo $J | cut -c1-7)[0-9a-f]*/<OID-J>/g" \
> +		-e "s/$(echo $K | cut -c1-7)[0-9a-f]*/<OID-K>/g" \
> +		-e "s/$(echo $L | cut -c1-7)[0-9a-f]*/<OID-L>/g" \
> +		-e "s/$(echo $M | cut -c1-7)[0-9a-f]*/<OID-M>/g" \
> +		-e "s/$(echo $N | cut -c1-7)[0-9a-f]*/<OID-N>/g" \
> +		-e "s/$(echo $O | cut -c1-7)[0-9a-f]*/<OID-O>/g" \
> +		-e "s/$(echo $P | cut -c1-7)[0-9a-f]*/<OID-P>/g" \
> +		-e "s/$TAG1/<TAG-1>/g" \
> +		-e "s/$TAG2/<TAG-2>/g" \
> +		-e "s/$TAG3/<TAG-3>/g" \
> +		-e "s/$(echo $TAG1 | cut -c1-7)[0-9a-f]*/<OID-TAG-1>/g" \
> +		-e "s/$(echo $TAG2 | cut -c1-7)[0-9a-f]*/<OID-TAG-2>/g" \
> +		-e "s/$(echo $TAG3 | cut -c1-7)[0-9a-f]*/<OID-TAG-3>/g" \
> +		-e "s/$ZERO_OID/<ZERO-OID>/g"
> +}
> +
> +#            (C)   (D, pull/1/head, topic/1)
> +#             o --- o
> +#            /       \                              (L)
> +#           /         \        o (H, topic/2)             (M, tag:v2)
> +#          /    (F)    \      /                                 (N, tag:v3)
> +#         /      o --------- o (G, pull/2/head)      o --- o --- o (release)
> +#        /      /        \    \                      /       \
> +#  o --- o --- o -------- o -- o ------------------ o ------- o --- o (main)
> +# (A)   (B)  (E, tag:v1) (I)  (J)                  (K)       (O)   (P)
> +#
> +test_expect_success 'setup' '
> +	# commit A & B
> +	cat >main.txt <<-EOF &&
> +		Commit A
> +		EOF
> +	git add main.txt &&
> +	test_tick &&
> +	git commit -m "Commit A" &&
> +
> +	cat >main.txt <<-EOF &&
> +		Commit B
> +		EOF
> +	git add main.txt &&
> +	test_tick &&
> +	git commit -m "Commit B" &&
> +	A=$(git rev-parse HEAD~) &&
> +	B=$(git rev-parse HEAD) &&
> +
> +	# branch topic/1
> +	git checkout -b topic/1 &&
> +	cat >topic-1.txt <<-EOF &&
> +		Commit C
> +		EOF
> +	git add topic-1.txt &&
> +	test_tick &&
> +	git commit -m "Commit C" &&
> +
> +	cat >topic-1.txt <<-EOF &&
> +		Commit D
> +		EOF
> +	git add -u &&
> +	test_tick &&
> +	git commit -m "Commit D" &&
> +	git update-ref refs/pull/1/head HEAD &&
> +	C=$(git rev-parse topic/1~) &&
> +	D=$(git rev-parse topic/1) &&
> +
> +	# commit E
> +	git checkout main &&
> +	cat >main.txt <<-EOF &&
> +		Commit E
> +		EOF
> +	git add main.txt &&
> +	test_tick &&
> +	git commit -m "Commit E" &&
> +	E=$(git rev-parse HEAD) &&
> +	test_tick &&
> +	git tag -m "v1" v1 HEAD &&
> +	TAG1=$(git rev-parse refs/tags/v1) &&
> +
> +	# branch topic/2
> +	git checkout -b topic/2 &&
> +	cat >topic-2.txt <<-EOF &&
> +		Commit F
> +		EOF
> +	git add topic-2.txt &&
> +	test_tick &&
> +	git commit -m "Commit F" &&
> +
> +	cat >topic-2.txt <<-EOF &&
> +		Commit G
> +		EOF
> +	git add -u &&
> +	test_tick &&
> +	git commit -m "Commit G" &&
> +	git update-ref refs/pull/2/head HEAD &&
> +
> +	cat >topic-2.txt <<-EOF &&
> +		Commit H
> +		EOF
> +	git add -u &&
> +	test_tick &&
> +	git commit -m "Commit H" &&
> +	F=$(git rev-parse topic/2~2) &&
> +	G=$(git rev-parse topic/2~) &&
> +	H=$(git rev-parse topic/2) &&
> +
> +	# merge commit I & J
> +	git checkout main &&
> +	test_tick &&
> +	git merge --no-ff --no-edit topic/1 &&
> +	test_tick &&
> +	git merge --no-ff --no-edit refs/pull/2/head &&
> +	I=$(git rev-parse HEAD~) &&
> +	J=$(git rev-parse HEAD) &&
> +
> +	# commit K
> +	git checkout main &&
> +	cat >main.txt <<-EOF &&
> +		Commit K
> +		EOF
> +	git add main.txt &&
> +	test_tick &&
> +	git commit -m "Commit K" &&
> +	K=$(git rev-parse HEAD) &&
> +
> +	# branch release
> +	git checkout -b release &&
> +	cat >release.txt <<-EOF &&
> +		Commit L
> +		EOF
> +	git add release.txt &&
> +	test_tick &&
> +	git commit -m "Commit L" &&
> +
> +	cat >release.txt <<-EOF &&
> +		Commit M
> +		EOF
> +	git add -u &&
> +	test_tick &&
> +	git commit -m "Commit M" &&
> +	test_tick &&
> +	git tag -m "v2" v2 HEAD &&
> +
> +	cat >release.txt <<-EOF &&
> +		Commit N
> +		EOF
> +	git add -u &&
> +	test_tick &&
> +	git commit -m "Commit N" &&
> +	test_tick &&
> +	git tag -m "v3" v3 HEAD &&
> +	L=$(git rev-parse HEAD~2) &&
> +	M=$(git rev-parse HEAD~) &&
> +	N=$(git rev-parse HEAD) &&
> +	TAG2=$(git rev-parse refs/tags/v2) &&
> +	TAG3=$(git rev-parse refs/tags/v3) &&
> +
> +	# merge commit O
> +	git checkout main &&
> +	test_tick &&
> +	git merge --no-ff --no-edit tags/v2 &&
> +	O=$(git rev-parse HEAD) &&
> +
> +	# commit P
> +	git checkout main &&
> +	cat >main.txt <<-EOF &&
> +		Commit P
> +		EOF
> +	git add main.txt &&
> +	test_tick &&
> +	git commit -m "Commit P" &&
> +	P=$(git rev-parse HEAD)
> +'
> +
> +test_expect_success 'create bundle from special rev: main^!' '
> +	git bundle create special-rev.bdl "main^!" &&
> +
> +	git bundle list-heads special-rev.bdl |
> +		make_user_friendly_and_stable_output >actual &&
> +	cat >expect <<-EOF &&
> +		<COMMIT-P> refs/heads/main
> +		EOF
> +	test_i18ncmp expect actual &&
> +
> +	git bundle verify special-rev.bdl |
> +		make_user_friendly_and_stable_output >actual &&
> +	cat >expect <<-EOF &&
> +		The bundle contains this ref:
> +		<COMMIT-P> refs/heads/main
> +		The bundle requires this ref:
> +		<COMMIT-O>
> +		EOF
> +	test_i18ncmp expect actual &&
> +
> +	test_bundle_object_count special-rev.bdl 3
> +'
> +
> +test_expect_success 'create bundle with --max-count option' '
> +	git bundle create max-count.bdl --max-count 1 \
> +		main \
> +		"^release" \
> +		refs/tags/v1 \
> +		refs/pull/1/head \
> +		refs/pull/2/head &&
> +
> +	git bundle list-heads max-count.bdl |
> +		make_user_friendly_and_stable_output >actual &&
> +	cat >expect <<-EOF &&
> +		<COMMIT-P> refs/heads/main
> +		<TAG-1> refs/tags/v1
> +		EOF
> +	test_i18ncmp expect actual &&
> +
> +	git bundle verify max-count.bdl |
> +		make_user_friendly_and_stable_output >actual &&
> +	cat >expect <<-EOF &&
> +		The bundle contains these 2 refs:
> +		<COMMIT-P> refs/heads/main
> +		<TAG-1> refs/tags/v1
> +		The bundle requires this ref:
> +		<COMMIT-O>
> +		EOF
> +	test_i18ncmp expect actual &&
> +
> +	test_bundle_object_count max-count.bdl 4
> +'
> +
> +test_expect_success 'create bundle with --since option' '
> +	git bundle create since.bdl \
> +		--since "Thu Apr 7 15:26:13 2005 -0700" \
> +		--all &&
> +
> +	git bundle list-heads since.bdl |
> +		make_user_friendly_and_stable_output >actual &&
> +	cat >expect <<-EOF &&
> +		<COMMIT-P> refs/heads/main
> +		<COMMIT-N> refs/heads/release
> +		<TAG-2> refs/tags/v2
> +		<TAG-3> refs/tags/v3
> +		<COMMIT-P> HEAD
> +		EOF
> +	test_i18ncmp expect actual &&
> +
> +	git bundle verify since.bdl |
> +		make_user_friendly_and_stable_output >actual &&
> +	cat >expect <<-EOF &&
> +		The bundle contains these 5 refs:
> +		<COMMIT-P> refs/heads/main
> +		<COMMIT-N> refs/heads/release
> +		<TAG-2> refs/tags/v2
> +		<TAG-3> refs/tags/v3
> +		<COMMIT-P> HEAD
> +		The bundle requires these 2 refs:
> +		<COMMIT-L>
> +		<COMMIT-K>
> +		EOF
> +	test_i18ncmp expect actual &&
> +
> +	test_thin_bundle_object_count since.bdl 16
> +'
> +
> +test_expect_success 'create bundle 1 - no prerequisites' '
> +	git bundle create 1.bdl topic/1 topic/2 &&
> +
> +	cat >expect <<-EOF &&
> +		The bundle contains these 2 refs:
> +		<COMMIT-D> refs/heads/topic/1
> +		<COMMIT-H> refs/heads/topic/2
> +		The bundle records a complete history.
> +		EOF
> +
> +	# verify bundle, which has no prerequisites
> +	git bundle verify 1.bdl |
> +		make_user_friendly_and_stable_output >actual &&
> +	test_i18ncmp expect actual &&
> +
> +	test_bundle_object_count 1.bdl 24
> +'
> +
> +test_expect_success 'create bundle 2 - has prerequisites' '
> +	git bundle create 2.bdl \
> +		--ignore-missing \
> +		^topic/deleted \
> +		^$D \
> +		^topic/2 \
> +		release &&
> +
> +	cat >expect <<-EOF &&
> +		The bundle contains this ref:
> +		<COMMIT-N> refs/heads/release
> +		The bundle requires these 3 refs:
> +		<COMMIT-D>
> +		<COMMIT-E>
> +		<COMMIT-G>
> +		EOF
> +
> +	git bundle verify 2.bdl |
> +		make_user_friendly_and_stable_output >actual &&
> +	test_i18ncmp expect actual &&
> +
> +	test_bundle_object_count 2.bdl 16
> +'
> +
> +test_expect_success 'fail to verify bundle without prerequisites' '
> +	git init --bare test1.git &&
> +
> +	cat >expect <<-EOF &&
> +		error: Repository lacks these prerequisite commits:
> +		error: <COMMIT-D>
> +		error: <COMMIT-E>
> +		error: <COMMIT-G>
> +		EOF
> +
> +	test_must_fail git -C test1.git bundle verify ../2.bdl 2>&1 |
> +		make_user_friendly_and_stable_output >actual &&
> +	test_i18ncmp expect actual
> +'
> +
> +test_expect_success 'create bundle 3 - two refs, same object' '
> +	git bundle create --version=3 3.bdl \
> +		^release \
> +		^topic/1 \
> +		^topic/2 \
> +		main \
> +		HEAD &&
> +
> +	cat >expect <<-EOF &&
> +		The bundle contains these 2 refs:
> +		<COMMIT-P> refs/heads/main
> +		<COMMIT-P> HEAD
> +		The bundle requires these 2 refs:
> +		<COMMIT-M>
> +		<COMMIT-K>
> +		EOF
> +
> +	git bundle verify 3.bdl |
> +		make_user_friendly_and_stable_output >actual &&
> +	test_i18ncmp expect actual &&
> +
> +	test_bundle_object_count 3.bdl 4
> +'
> +
> +test_expect_success 'create bundle 4 - with tags' '
> +	git bundle create 4.bdl \
> +		^main \
> +		^release \
> +		^topic/1 \
> +		^topic/2 \
> +		--all &&
> +
> +	cat >expect <<-EOF &&
> +		The bundle contains these 3 refs:
> +		<TAG-1> refs/tags/v1
> +		<TAG-2> refs/tags/v2
> +		<TAG-3> refs/tags/v3
> +		The bundle records a complete history.
> +		EOF
> +
> +	git bundle verify 4.bdl |
> +		make_user_friendly_and_stable_output >actual &&
> +	test_i18ncmp expect actual &&
> +
> +	test_bundle_object_count 4.bdl 3
> +'
> +
> +test_expect_success 'clone from bundle' '
> +	git clone --mirror 1.bdl mirror.git &&
> +	git -C mirror.git show-ref |
> +		make_user_friendly_and_stable_output >actual &&
> +	cat >expect <<-EOF &&
> +		<COMMIT-D> refs/heads/topic/1
> +		<COMMIT-H> refs/heads/topic/2
> +		EOF
> +	test_cmp expect actual &&
> +
> +	git -C mirror.git fetch ../2.bdl "+refs/*:refs/*" &&
> +	git -C mirror.git show-ref |
> +		make_user_friendly_and_stable_output >actual &&
> +	cat >expect <<-EOF &&
> +		<COMMIT-N> refs/heads/release
> +		<COMMIT-D> refs/heads/topic/1
> +		<COMMIT-H> refs/heads/topic/2
> +		EOF
> +	test_cmp expect actual &&
> +
> +	git -C mirror.git fetch ../3.bdl "+refs/*:refs/*" &&
> +	git -C mirror.git show-ref |
> +		make_user_friendly_and_stable_output >actual &&
> +	cat >expect <<-EOF &&
> +		<COMMIT-P> refs/heads/main
> +		<COMMIT-N> refs/heads/release
> +		<COMMIT-D> refs/heads/topic/1
> +		<COMMIT-H> refs/heads/topic/2
> +		EOF
> +	test_cmp expect actual &&
> +
> +	git -C mirror.git fetch ../4.bdl "+refs/*:refs/*" &&
> +	git -C mirror.git show-ref |
> +		make_user_friendly_and_stable_output >actual &&
> +	cat >expect <<-EOF &&
> +		<COMMIT-P> refs/heads/main
> +		<COMMIT-N> refs/heads/release
> +		<COMMIT-D> refs/heads/topic/1
> +		<COMMIT-H> refs/heads/topic/2
> +		<TAG-1> refs/tags/v1
> +		<TAG-2> refs/tags/v2
> +		<TAG-3> refs/tags/v3
> +		EOF
> +	test_cmp expect actual
> +'
> +
> +test_done
> -- 
> 2.30.0.2.g06d2f50715
> 

-- 
Danh
