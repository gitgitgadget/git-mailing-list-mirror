Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A073A1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 17:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfGARmd (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 13:42:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52555 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbfGARmd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 13:42:33 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E26714A836;
        Mon,  1 Jul 2019 13:42:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NNzEfJ6tNmUX
        HbbzHFK4Gf2FJ1E=; b=RGrrCpy40IUf0hwQoq+87hDL8dyry7nh/77ha+q0nmdh
        E5wYi76KhfmnVOuRmMD6xG7mVNworob5PI9ARlBAB2e5PN3gPaS0CjRzfmFUhA8m
        rgrsuzHFldBBxscn5gPHk4P7mR+Ry3XTOY+q2QUu/p6RzqlrwrCZyZW6unSZco0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ANoZek
        F+gKGrOc8Lmkzwob/sSzBHNbMqDPukeKfIggAen/hixocIPQExf6fPgPFTOBBSBP
        udt1MkmUGQ/EdieWzS5sMqVvixiEQQqAozsoxnE6zcPO7K9Fndf4rmhfQ6hVeFdU
        c7LYAxZwUvcOZ3BNdUQ8n7RUjvHENyHWf/1Nw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 557F814A835;
        Mon,  1 Jul 2019 13:42:28 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B63C814A834;
        Mon,  1 Jul 2019 13:42:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/6] test-lib: introduce test_commit_bulk
References: <20190628093751.GA3569@sigill.intra.peff.net>
        <20190628093911.GA27329@sigill.intra.peff.net>
        <CAPig+cQAKVOqYH-CcqzViP_zuKwg5fWO2_i8=Z5t=BVf9uoAXQ@mail.gmail.com>
        <20190628230417.GC21574@szeder.dev>
        <CAPig+cQnvotvJakCp1ic_WP3AMojNmfZw-PoinR=VOODmtNBtw@mail.gmail.com>
        <20190629082457.GE21574@szeder.dev>
Date:   Mon, 01 Jul 2019 10:42:26 -0700
In-Reply-To: <20190629082457.GE21574@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Sat, 29 Jun 2019 10:24:57 +0200")
Message-ID: <xmqqblyd7it9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 97E642A4-9C27-11E9-ACF8-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> I recall the discussion around the meaning of `-C ""` when that
>> command line option was introduced. The conclusion was that  the
>> zero-length argument should mean "this directory" since that's how `cd
>> ""` behaves. However, I don't think that behavior ever got documented,
>
> Although it's not documented (but see the patch below), we do
> explicitly test it since 6a536e2076 (git: treat "git -C '<path>'" as a
> no-op when <path> is empty, 2015-03-06) and e.g. our completion script
> relies on this behavior.
>
>> and it's not necessarily obvious. An alternative would be to default
>> 'indir' to ".", which should give the same result and be easily
>> understood.
>
> That's fine for me as well.

I find the "an empty string is the same as a dot and means the
current directory" a bit counter-intuitive, but as long as we have
kept Git working that way for this long, we should document it, too.

For the tests in the patch in question, I think "-C ." is a good
thing to use.

Thanks.  Will queue.


>    --- >8 ---
>
> Subject: [PATCH] Document that 'git -C ""' works and doesn't change dir=
ectory
>
> It's been behaving so since 6a536e2076 (git: treat "git -C '<path>'"
> as a no-op when <path> is empty, 2015-03-06).
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  Documentation/git.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index f9b09db89b..a9deca0acb 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -57,7 +57,8 @@ help ...`.
>  	Run as if git was started in '<path>' instead of the current working
>  	directory.  When multiple `-C` options are given, each subsequent
>  	non-absolute `-C <path>` is interpreted relative to the preceding `-C
> -	<path>`.
> +	<path>`.  If '<path>' is present but empty, e.g. `-C ""`, then the
> +	current working directory is left unchanged.
>  +
>  This option affects options that expect path name like `--git-dir` and
>  `--work-tree` in that their interpretations of the path names would be
