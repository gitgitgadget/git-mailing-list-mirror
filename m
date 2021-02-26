Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE43C433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 22:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B538964DAF
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 22:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhBZWkd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 17:40:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64621 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhBZWkc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 17:40:32 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C7E4EBAAEF;
        Fri, 26 Feb 2021 17:39:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1LWbSD6eJ8LI
        XGIaYG3ubvkEZnU=; b=xcLxqtMS0EJX+ylY8s+/CdH89c76qS2wIJZckxiIrO9K
        CzC3zBZ9r+7k/D54MLbP567poIdrQwbryuPhyuloCpsS+YfweOwsYg8X2aTpugpO
        yPi+RiuOPvJPWlcJT56YxaDU9Zbxy3uIGusaqUaYkyfqGTqzrPrIhAuzRc3NnLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=xdxBr8
        xfLh0jenY5yCW8Le+2hQw8S3NGAw2IAmvMYEWkVmRIxYdYYgUHVCnZr0292K/l76
        K1LUUayydKk1Ob536zCKKwZ+NoA5kI493ZQluWmtHACCxyTyk9cPbyH/BEO1x2AW
        ew+vVl53MQf1xnWVpfwXxLAvhvmfmhw65x6WQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BF69CBAAEE;
        Fri, 26 Feb 2021 17:39:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4E346BAAEC;
        Fri, 26 Feb 2021 17:39:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] commit-graph: warn about incompatibilities only when
 trying to write
References: <pull.888.git.1614351036334.gitgitgadget@gmail.com>
        <87r1l27rae.fsf@evledraar.gmail.com>
Date:   Fri, 26 Feb 2021 14:39:47 -0800
In-Reply-To: <87r1l27rae.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 26 Feb 2021 17:00:25 +0100")
Message-ID: <xmqqy2faqwr0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 880A7C08-7883-11EB-8457-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Feb 26 2021, Johannes Schindelin via GitGitGadget wrote:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> In c85eec7fc37 (commit-graph: when incompatible with graphs, indicate
>> why, 2021-02-11), we started warning the user if they tried to write a
>> commit-graph in a shallow repository, or one containing replace object=
s.
>>
>> However, this patch was a bit overzealous, as Git now _also_ warns whe=
n
>> merely checking whether there _is_ a usable commit graph, not only whe=
n
>> writing one.
>>
>> Let's suppress that warning unless we want to write a commit-graph.
>
> Ah, so that's what it's for, as I suspected :) Unfortunately...
> ...
> ...doing this will cause "git gc --auto" to run into persistent
> warnings. See a WIP patch-on-top in [1] below...

Thanks for an input.

> diff --git a/builtin/gc.c b/builtin/gc.c
> index 64f2b52d6e2..9109898eacb 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -593,7 +593,7 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
>  		/*
>  		 * Auto-gc should be least intrusive as possible.
>  		 */
> -		if (!need_to_gc())
> +		if (0 && !need_to_gc())
>  			return 0;

Leftover debugging cruft?

> -			if (!quiet)
> +			if (flags & COMMIT_GRAPH_WRITE_WARNINGS)
>  				warning(_("repository contains replace "
>  					  "objects; skipping commit-graph"));

I would have expected the code would arrange to make the bit cleared
in the "flags" that would be passed around to the next call that
inspects the same bit, so that we won't need to see repeated
warning()s, but I do not see where it is done.

I am tempted to say that we should revert c85eec7f (commit-graph:
when incompatible with graphs, indicate why, 2021-02-11) for the
upcoming release.  That would give us enough time to come up with
and cook the solution in 'next' in the meantime.
