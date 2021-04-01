Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73979C433ED
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 19:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 426F3610CA
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 19:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbhDATwg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 15:52:36 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64331 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbhDATwf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 15:52:35 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9EB77127448;
        Thu,  1 Apr 2021 15:52:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7fE3fQsTYIZS2QVNAzZVoBAPiIY=; b=V0fVPd
        /msxc8zZxtVREhBLk33jIZtOgSEaVQUt6eZcNMZsuDITDLjXtgboSQ4n0TeaInlW
        3a+8ATEWhT/P8SgFNn3bC/onFPlGYAZZcNSvfVUSfu7bklN0TDb9La03Llz/MI2N
        BH7gXIzg4vqdmMUHG/2jyYlTqcXXUA6CdUhSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CdEhKfcxHrZy2UCM+hdKvRw63TrrtKzE
        pdBaQ1WwlUdaulJNNhqbbTn+7iLIjX2kIWE0ZNFnxSVm9OPO2Z2Q43Mwy7clPtD2
        q7U0DCv8ZX477LkJWjw45t/jyTjBTZkse8MQLa1myyO+lVbrx2HaG3OYOozxDWom
        hoyzBB0I3UU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 97301127447;
        Thu,  1 Apr 2021 15:52:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D2368127444;
        Thu,  1 Apr 2021 15:52:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] ref-filter: fix NULL check for parse object failure
References: <20210308200426.21824-1-avarab@gmail.com>
        <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
        <patch-10.11-a84f670ac24-20210328T021238Z-avarab@gmail.com>
        <xmqq35wdfaw5.fsf@gitster.g>
        <YGRWqX+qF+Rtqr20@coredump.intra.peff.net>
        <87k0pnkwej.fsf@evledraar.gmail.com>
        <YGTGgFI19fS7Uv6I@coredump.intra.peff.net>
        <87eefvkq5d.fsf@evledraar.gmail.com>
        <YGV8UOsYUQt7Lpto@coredump.intra.peff.net>
        <YGWFGMdGcKeaqCQF@coredump.intra.peff.net>
Date:   Thu, 01 Apr 2021 12:52:31 -0700
In-Reply-To: <YGWFGMdGcKeaqCQF@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 1 Apr 2021 04:32:24 -0400")
Message-ID: <xmqqh7kp3hq8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC7C43D4-9323-11EB-8931-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Here's a patch to fix it. This is mostly orthogonal to your patch
> series. It happens to use a similar recipe to reproduce, but that is not
> the only way to do it, and the fix and the test shouldn't conflict
> textually or semantically.
>
> -- >8 --
> Subject: [PATCH] ref-filter: fix NULL check for parse object failure
>
> After we run parse_object_buffer() to get an object's contents, we try
> to check that the return value wasn't NULL. However, since our "struct
> object" is a pointer-to-pointer, and we assign like:
>
>   *obj = parse_object_buffer(...);
>
> it's not correct to check:
>
>   if (!obj)
>
> That will always be true, since our double pointer will continue to
> point to the single pointer (which is itself NULL). This is a regression
> that was introduced by aa46a0da30 (ref-filter: use oid_object_info() to
> get object, 2018-07-17); since that commit we'll segfault on a parse
> failure, as we try to look at the NULL object pointer.
>
> There are many ways a parse could fail, but most of them are hard to set
> up in the tests (it's easy to make a bogus object, but update-ref will
> refuse to point to it). The test here uses a tag which points to a wrong
> object type. A parse of just the broken tag object will succeed, but
> seeing both tag objects in the same process will lead to a parse error
> (since we'll see the pointed-to object as both types).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  ref-filter.c            |  2 +-
>  t/t6300-for-each-ref.sh | 10 ++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)

Makes sense.  Will queue.

> diff --git a/ref-filter.c b/ref-filter.c
> index f0bd32f714..a0adb4551d 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1608,7 +1608,7 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
>  
>  	if (oi->info.contentp) {
>  		*obj = parse_object_buffer(the_repository, &oi->oid, oi->type, oi->size, oi->content, &eaten);
> -		if (!obj) {
> +		if (!*obj) {
>  			if (!eaten)
>  				free(oi->content);
>  			return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index cac7f443d0..2e7c32d50c 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -1134,4 +1134,14 @@ test_expect_success 'for-each-ref --ignore-case works on multiple sort keys' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'for-each-ref reports broken tags' '
> +	git tag -m "good tag" broken-tag-good HEAD &&
> +	git cat-file tag broken-tag-good >good &&
> +	sed s/commit/blob/ <good >bad &&
> +	bad=$(git hash-object -w -t tag bad) &&
> +	git update-ref refs/tags/broken-tag-bad $bad &&
> +	test_must_fail git for-each-ref --format="%(*objectname)" \
> +		refs/tags/broken-tag-*
> +'
> +
>  test_done
