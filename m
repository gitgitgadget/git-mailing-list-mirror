Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB1CC2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 19:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D1A320717
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 19:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cRBVQZbM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbgKWTxy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 14:53:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53281 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729009AbgKWTxy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 14:53:54 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DFAC8C35A;
        Mon, 23 Nov 2020 14:53:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tMXDhgf/yAaSm3fm+Oq0Q7mcCA0=; b=cRBVQZ
        bMdQWtZuTIansf3eW9exC4WAUACo40BYrPb6yaDgI8IG6tnHYzMUiI8mz5+aqF1g
        UBRLR9L6b1tWaX7ImHbcn3gZtqG9Ldndh9MAQ4pnc1Laro9YzhCnWVDTJgdWBfoB
        wLYu9gHye8h0b/QDmFz2aHJD2XUqMML51qI4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lsWTUOC3uToWGEJiUHOPIm15u21u9Umf
        M8syrm+Ujhj6V+TRJgez4tkmtj4f25h7aNGhAX1oSJM3ZCGIOwWK4goXP9ue0hTE
        1GiyusWStHICQ6WxA7ZlH30w2B5NJFTOpkybNMls9y2wNa+tKDT9P7bJzrxY/8qc
        OU7I6sj2Jl0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 534798C359;
        Mon, 23 Nov 2020 14:53:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD0B38C357;
        Mon, 23 Nov 2020 14:53:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 6/7] config: implement --fixed-value with --get*
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
        <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
        <8e0111c7b4b2c766c61df30c4ae93bd2d724de06.1606147507.git.gitgitgadget@gmail.com>
Date:   Mon, 23 Nov 2020 11:53:49 -0800
In-Reply-To: <8e0111c7b4b2c766c61df30c4ae93bd2d724de06.1606147507.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 23 Nov 2020
        16:05:06 +0000")
Message-ID: <xmqqwnybn92q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B1528CE-2DC5-11EB-B5DF-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -	if (regex_) {
> +	if (regex_ && (flags & CONFIG_FLAGS_FIXED_VALUE))
> +		value_regex = regex_;
> +	else if (regex_) {
>  		if (regex_[0] == '!') {
>  			do_not_match = 1;
>  			regex_++;

When the --fixed-value option is in effect, there is no way to say
"replace values that do not match this string", because unlike the
regex case, we do not special case '!' at the beginning.

I think it is a good design decision.  The special case has an
escape hatch to start your value_regex with "[!]" when ERE is in
use, but there is no such escape hatch possible with --fixed-value.

Depending on how this '!' negation is documented to the end-users
for existing value_regex that is ERE, the documentation for the new
option may want to talk about the lack of negation explicitly.

	... goes and looks ...

It is worse than I thought.  Here is what "git config" description
has (and some of the badness is not the fault of this series):

    Multiple lines can be added to an option by using the `--add` option.
    If you want to update or unset an option which can occur on multiple
    lines, a POSIX regexp `value_regex` needs to be given.  Only the
    existing values that match the regexp are updated or unset.  If
    you want to handle the lines that do *not* match the regex, just
    prepend a single exclamation mark in front (see also <<EXAMPLES>>).

The end-users these days no longer see "lines" because they do not
hand edit .git/config, so we may need a replacement phrase to refer
to a single "vari.able=value" setting, but we should leave it out of
the scope of this series to clean that up---"git config --help" is
full of references to "line".

It was not "a POSIX regexp" (which does not say if it is BRE or
ERE), and it no longer is a regexp with the new option.

    ... which can occur on multiple lines, a pattern `value_regex`
    needs to be given.  Only the existing values that match the
    pattern are updated or unset.  The pattern is by default matched
    as an extended regular expression, but with the `--fixed-value`
    option, taken as a literal string and values must be identical
    to it to be considered a match.  You can prepend an exclamation
    point '!' to affect lines that do *not* match the pattern, but
    this is applicable only when not using the `--fixed-value`
    option.

Ideally we probably should do s/value_regex/value_pattern/ in the
documentation and error messages eventually, but I do not know if
it is warranted in the scope of this series.
