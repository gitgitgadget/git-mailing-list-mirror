Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1699AC433DB
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 21:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4F9D2226A
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 21:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbhAPVwG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 16:52:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62902 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbhAPVwB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 16:52:01 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 99C68916D4;
        Sat, 16 Jan 2021 16:51:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=F1Qn6LUWtWSSp625Q525D4oex
        l0=; b=vVc03vXBJar2OakEByNj7ynFGKhOuoy3IC1gQVaNx4YIiAlMSyYAG3qg7
        wHiG+yOfeYRx+aAfrKuLEmePQiBXBzUpyj7o79eQ2hIVRIQfA8va4DH7IgulOuV3
        h0mW4Yg1YenSGTEZfBPQalXenNFAR8Y9IcXtwmcwxVkk6cB2DY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=C5TkEKHr7LH3TYhVvJJ
        6JLZXNETxL1Xj5Hs47pGou7fEB6ryGkPvuOz8FNX+XptxE+vJZjhiDZeGMn6V3+H
        ypqE0wsGwBT0p9TRO7VQRKB6mebY4OKYrbuCHyC0QQSkVogKPxbTkUyUTQiYG+Pv
        yCnpCh5wFgx+N0AV9Y1Zwo1I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 82BFA916D2;
        Sat, 16 Jan 2021 16:51:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F29A8916D0;
        Sat, 16 Jan 2021 16:51:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 03/11] cache-tree tests: refactor overly complex
 function
References: <20210114233515.31298-1-avarab@gmail.com>
        <20210116153554.12604-4-avarab@gmail.com>
Date:   Sat, 16 Jan 2021 13:51:15 -0800
Message-ID: <xmqqczy4o8j0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F538CB04-5844-11EB-8985-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Refactor overly complex code added in 9c4d6c0297 (cache-tree: Write
> updated cache-tree after commit, 2014-07-13).

OK.

> Interestingly, in the numerous commits[1][2][3] who fixed commits bugs
> in this code since its introduction it seems not to have been noticed

Sorry but -ECANNOTPARSE.

> that we didn't need to be doing some dance with grep/cut/uniq/awk to
> extract this information. It can be done in a much simpler way with
> just "ls-tree" and "wc -l".

The new code seems to take advantage of the fact that the index and
HEAD are always in sync when test_cache_tree is called; it is worth
mentioning in the log message around here.

> I'm also removing the comment, because I think now that this code is
> trivial to understand it's not needed anymore.

OK.

Thanks.

> 1. c8db708d5d (t0090: avoid passing empty string to printf %d,
>    2014-09-30)
> 2. d69360c6b1 (t0090: tweak awk statement for Solaris
>    /usr/xpg4/bin/awk, 2014-12-22)
> 3. 9b5a9fa60a (t0090: stop losing return codes of git commands,
>    2019-11-27)
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t0090-cache-tree.sh | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
> index 2e3efeb80e..f1b0a6a679 100755
> --- a/t/t0090-cache-tree.sh
> +++ b/t/t0090-cache-tree.sh
> @@ -18,20 +18,16 @@ cmp_cache_tree () {
>  # correct.
>  generate_expected_cache_tree_rec () {
>  	dir=3D"$1${1:+/}" &&
> -	# ls-files might have foo/bar, foo/bar/baz, and foo/bar/quux
> -	# We want to count only foo because it's the only direct child
> -	git ls-files >files &&
> -	subtrees=3D$(grep / files|cut -d / -f 1|uniq) &&
> -	subtree_count=3D$(echo "$subtrees"|awk -v c=3D0 '$1 !=3D "" {++c} END=
 {print c}') &&
> -	entries=3D$(wc -l <files) &&
> -	printf "SHA $dir (%d entries, %d subtrees)\n" "$entries" "$subtree_co=
unt" &&
> -	for subtree in $subtrees
> +	git ls-tree --name-only HEAD >files &&
> +	git ls-tree --name-only -d HEAD >subtrees &&
> +	printf "SHA %s (%d entries, %d subtrees)\n" "$dir" $(wc -l <files) $(=
wc -l <subtrees) &&
> +	while read subtree
>  	do
>  		(
>  			cd "$subtree"
> -			generate_expected_cache_tree_rec "$dir$subtree" || return 1
> +			generate_expected_cache_tree_rec "$subtree" || return 1
>  		)
> -	done
> +	done <subtrees
>  }
> =20
>  test_cache_tree () {
