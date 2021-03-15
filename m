Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD68C433DB
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 04:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF89564E27
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 04:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhCOEjJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 00:39:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61904 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhCOEit (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 00:38:49 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 12F3DAAE68;
        Mon, 15 Mar 2021 00:38:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IQ3hzOe6t5ZodOuboWjzJsbYkcQ=; b=kkLg1G
        VX/6OyhdB8S/YpSCZh5bD6/wol9XhQBCE+l9kEDorRp8qUsC3I3NdHODb4uf4Vfk
        ikjuKrNuI9YkNat3LJ64qkfU77zrwA2iLaPifJCJIhGavOo9bDtOtqjhxWp354gT
        NjYfKFqfpSelnZF7Jwo/DJB2GvNe65ryOZcIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=biJ8pzgJSNOpQeH8k89LEbhVHVed43bZ
        BWoUlv0vqvM6MVy/GOrImfmGyF2jr7hveAPJqxVVdNvAvRwYW22aoPQuD6sRWO0C
        ydSW0N4AEtknoyXmKLTSXbAdqci5TWwGs8zT84elS9uf12SMHMoo8OTJ13Y9opHZ
        JuTvy+WK84Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 07410AAE67;
        Mon, 15 Mar 2021 00:38:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 82864AAE66;
        Mon, 15 Mar 2021 00:38:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v4] [GSOC] commit: add --trailer option
References: <pull.901.v3.git.1615726978059.gitgitgadget@gmail.com>
        <pull.901.v4.git.1615737505834.gitgitgadget@gmail.com>
Date:   Sun, 14 Mar 2021 21:38:47 -0700
In-Reply-To: <pull.901.v4.git.1615737505834.gitgitgadget@gmail.com> (ZheNing
        Hu via GitGitGadget's message of "Sun, 14 Mar 2021 15:58:25 +0000")
Message-ID: <xmqqczw12fqg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 559F18A6-8548-11EB-9509-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

One thing I forgot to mention.

> +static int opt_pass_trailer(const struct option *opt, const char *arg, int unset)
> +{
> +	if (unset) {
> +		strvec_clear(&run_trailer.args);
> +		return -1;

What input is this part of the code designed to handle, and what
outcome does it want to show to the user?

Does the test added in this patch cover this codepath, where unset
is true?

I think this codepath is reached when the command line says
"--no-trailer", and I am guessing that by clearing the code wants to
say "ignore the accumulated trailers and start accumulating afresh",
i.e.

    git commit --trailer='T1: V1' --trailer='T2: V2' \
		--no-trailer \
		--trailer='T3: V3'

would want to add only the "T3: V3" trailer; which is a sensible
design, but I do not think returning -1 would be compatible with
that design.

If on the other hand the code wants to say "--no-trailer is a
command line error", then using PARSE_OPT_NONEG to let the
parse-options API issue an error message and die would be more
appropriate.  That is an often used pattern for an option that can
appear on the command line only once without accumulating, which may
be less appropriate for the "--trailer", though.

> +	}
> +	strvec_pushl(&run_trailer.args, "--trailer", arg, NULL);
> +	return 0;
> +}

