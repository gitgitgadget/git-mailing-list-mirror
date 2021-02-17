Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF4CC433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66CA864E5F
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbhBQT5h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:57:37 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55190 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbhBQT5g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 14:57:36 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 29557A76E2;
        Wed, 17 Feb 2021 14:56:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DIbJ1PXcN3lNv3rj1O/vOJYuGp0=; b=tFUAGS
        5ispr7Rl8d178pJJ3IJtcMbAaHHwtjjXwn3KrWRDFHqBYMO2U1yspf2zmTfEbHWa
        BZpNx/tt24/s5DSjV4VsbP57EnvEzKCFSLejJsALZJ5NVh8g0vLJPm4FGfpGDM/3
        yjJpPgQgx2yut7wrIhXjZuNMV5nU4IcQHIft0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nT8lPecNtD3f0SXp7bAXhPvGeb/BjwNA
        PIitlGpCTl9XlAbOZZcmtChiU63xq6mE/WvV1rNhH0eSyauZjM9VYkObZsSVzCur
        YiL5ED7gNHNA/C7JCvfYhk4j6Zo/UbpaH6Fre71gpggtVmrqtZOpRz82KdVLjUoA
        IYfJXobj+DA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F8B4A76E1;
        Wed, 17 Feb 2021 14:56:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A19EAA76E0;
        Wed, 17 Feb 2021 14:56:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        phillip.wood123@gmail.com,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 3/6] commit: add a reword suboption to --fixup
References: <20210217072904.16257-1-charvi077@gmail.com>
        <20210217073725.16656-1-charvi077@gmail.com>
        <20210217073725.16656-3-charvi077@gmail.com>
Date:   Wed, 17 Feb 2021 11:56:52 -0800
In-Reply-To: <20210217073725.16656-3-charvi077@gmail.com> (Charvi Mendiratta's
        message of "Wed, 17 Feb 2021 13:07:22 +0530")
Message-ID: <xmqqwnv6jwmz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4793B638-715A-11EB-8519-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> `git commit --fixup=reword:<commit>` creates an empty "amend!" commit
> that will reword <commit> without changing its contents when it is
> rebased with --autosquash.
>
> Apart from ignoring staged changes it works similarly to
> `--fixup=amend:<commit>`.
>
> Example usage:
> $ git commit --fixup=reword:HEAD~3
> $ git commit --fixup=reword:HEAD~3 -m "new commit message"

The same comment applies to the above as an earlier step.

> +static void check_fixup_reword_options(void) {
> +	if (whence != FROM_COMMIT) {
> +		if (whence == FROM_MERGE)
> +			die(_("You are in the middle of a merge -- cannot reword."));
> +		else if (is_from_cherry_pick(whence))
> +			die(_("You are in the middle of a cherry-pick -- cannot reword."));
> +	}
> +	if (all)
> +		die(_("cannot combine reword option of --fixup with --all"));
> +	if (also)
> +		die(_("cannot combine reword option of --fixup with --include"));
> +	if (only)
> +		die(_("cannot combine reword option of --fixup with --only"));
> +}

Not just these options, wouldn't it be an error to ask to commit
anything but an empty commit?  E.g. shouldn't this sequence

	edit builtin/commit.c
	git commit --fixup=reword:HEAD~3 -- builtin/commit.c

trigger an error, as we will *not* be taking any change made to the
working tree file?

Or is that implicitly covered by some other code?

In any case, we'd need a test for that (this is just a mental note
for myself---I haven't finished reading the series to the end, so
you may have one already).

Thanks.
