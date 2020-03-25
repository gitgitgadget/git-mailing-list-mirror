Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3F0C1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 15:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12FE021D82
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 15:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="guihFn4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgCYPFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:05:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60224 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgCYPFT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 11:05:19 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E3318B34B8;
        Wed, 25 Mar 2020 11:05:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XAzv7X9j1fwd7XU/fMSP+WeXfY8=; b=guihFn
        4XBeAIY/UAVDNYKldYQri7hRSgobML9MawJ530TQHBa87h4mN6WfmoL8iC2XMj/0
        GnjNHyzAYHiGt8MPKQ9Kz6Dcyd+vuo0caizsvqHTJUPcgkr2GWlCjUhSLaYl7Dth
        wivcGbTSXGMeovboOYQbbkHAV8VAUcfL0b79w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ChadAqJM4txgvsnz+mIop1qPbUNgHg/D
        mizZmRNfPTrHqi42LZrsBY8AmAQZYLxpOwhY6LH5s0c1937GFrH1lQYQp4hMLFwX
        N7A4tRj4A46592FxZglX4roa8cCWz2i1bK4/2j3qpHmFRCD47S147yekddPGaLum
        cWDm4SlKwpg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DAF3CB34B7;
        Wed, 25 Mar 2020 11:05:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0C42FB34B2;
        Wed, 25 Mar 2020 11:05:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 1/3] t5543: never report what we do not push
References: <20200322131815.11872-3-worldhello.net@gmail.com>
        <20200325143608.45141-2-zhiyou.jx@alibaba-inc.com>
Date:   Wed, 25 Mar 2020 08:05:11 -0700
In-Reply-To: <20200325143608.45141-2-zhiyou.jx@alibaba-inc.com> (Jiang Xin's
        message of "Wed, 25 Mar 2020 22:36:06 +0800")
Message-ID: <xmqqa744xyoo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0716C9D2-6EAA-11EA-A433-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> +format_git_output () {

Unless this helper is able to take any git output and massage,
please describe what kind of git output it is meant to handle.

Also, "format" does not tell anything to the readers why it wants to
transform its input or what its output is supposed to look like.  It
does not help readers and future developers.

> +	awk '/^(To| !) / {print}' | \
> +	sed \
> +		-e "s/  *\$//g" \

What's the point of /g?  You are anchoring the pattern (i.e. one or
more SP) to the right end of the line, so it's not like it would
transform "a  b c   " into "abc".  Also it would be sufficient to
say "zero or more" and that would be shorter, I think.

> +		-e "s/'/\"/g"

It is unclear what this thing is for.  If the output from a git
subcommand you are munging with the helper says <don't>, this will
turn it into <don"t>, presumably before comparing it with the
expected output you'd literally prepare in the test script.  Are the
git subcommands whose output you are munging unstable and sometimes
use single and sometimes use double quotes?  

If not, if you used single quotes when preparing the expected
output, wouldn't you be able to do without this?

Is it because you'd have the code that prepares the expected output
inside a sq pair (because it is in test_expect_thing), and it is
cumbersome to write a literal single quote?  If that is the reason,
that is understandable, but I think readers deserve some comments
explaining why these transformations are done.  Please do not waste
readers' time.

It looks wasteful to pipe awk output to sed.  I wonder if something
along the lines of

	sed -ne "/^\(To\| !\) /{
		s/ *\$//
		s/'/\"/g
		p
	}"

would do the same thing with a single tool.

> +# References in upstream : master(1) one(1) foo(1)
> +# References in workbench: master(2)        foo(1) two(2) bar(2)
> +# Atomic push            : master(2)               two(2) bar(2)
> +test_expect_failure 'atomic push reports (reject by update hook)' '
> +	mk_repo_pair &&
> +	(
> +		cd workbench &&
> +		# Keep constant output.
> +		git config core.abbrev 7 &&

This '7' is "use at least seven hexdigits", so it does not give any
guarantee that your output will be stable.  Depending on chance,
some objects may be shown using 8 or more---is our "munge output
before comparison" helper prepared for such a case?

> +		test_commit one &&
> +		git branch foo &&
> +		git push up master one foo &&
> +		git tag -d one
> +	) &&
> +	(
> +		mkdir -p upstream/.git/hooks &&
> +		cat >upstream/.git/hooks/update <<-EOF &&
> +		#!/bin/sh
> +
> +		if test "\$1" = "refs/heads/bar"
> +		then
> +			echo >2 "Pusing to branch bar is prohibited"

Meant to redirect to the standard error stream, not a file "2"?

> +			exit 1
> +		fi
> +		EOF
> +		chmod a+x upstream/.git/hooks/update
> +	) &&
> +	(
> +		cd workbench &&
> +		test_commit two &&
> +		git branch bar
> +	) &&

At this point, we have the refs described in the comment at the
beginning (which is greatly appreciated---it hels understanding what
is going on).

> +	test_must_fail git -C workbench \
> +		push --atomic up master two bar >out 2>&1 &&

As "git push" does not auto-follow tags, what we push will be
exactly these three refs.

> +	format_git_output <out >actual &&
> +	cat >expect <<-EOF &&
> +	To ../upstream
> +	 ! [remote rejected] master -> master (atomic push failure)
> +	 ! [remote rejected] two -> two (atomic push failure)
> +	 ! [remote rejected] bar -> bar (hook declined)
> +	EOF

And we expect them to be rejected, as 'bar' needs to stay constant
there.  

> +	test_cmp expect actual

All makes sense.

