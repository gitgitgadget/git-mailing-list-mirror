Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18E181FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 17:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762000AbcINRnX (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 13:43:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52751 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758858AbcINRnW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 13:43:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9EC1B3E9A3;
        Wed, 14 Sep 2016 13:43:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lVLoYNjxrpLkNAgQfYShVMwctqI=; b=TvnEtu
        xRfBe6sqB8vxBvwShP2ejATIBQZUDBC3k6qL+yobHNMmTWoY0897fsQLo3o4ZZUc
        ySB4KFrGzfeHtJvxEJvi5jtu2xEbarckduP55kcPfSOtmWbiUYihWpN232NXiADz
        eziq2UdIBiOaxXOVXPi8MAtB+6yY6OCmNJ5zQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DSP27TWHQeb0WGfdJnzL0XBxDAvhJiou
        EPN6LmL6XbVxIWMVJGdxXio2khgUHQ53/vAosnOB2drlyOMk0vPs8VoAGJH3OOiR
        x64WD39+dP/f7zrd7Mo2i1QdvQeI1owCluO8erSmv8GM5QGiw13I0vaPqIAZbky1
        t2Cojd9Zw8M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 979E13E9A2;
        Wed, 14 Sep 2016 13:43:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 205363E9A1;
        Wed, 14 Sep 2016 13:43:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [RFC 0/1] mailinfo: de-quote quoted-pair in header fields
References: <20160913152622.2xtyn6mki6p6afsg@sigill.intra.peff.net>
        <20160913234612.22806-1-me@ikke.info>
        <20160913234612.22806-2-me@ikke.info>
        <xmqqr38ns5wi.fsf@gitster.mtv.corp.google.com>
        <20160914050919.qhv2gxzjyj5ydpub@sigill.intra.peff.net>
        <xmqqmvjbrpp4.fsf@gitster.mtv.corp.google.com>
        <20160914160308.GB26893@ikke.info>
Date:   Wed, 14 Sep 2016 10:43:18 -0700
In-Reply-To: <20160914160308.GB26893@ikke.info> (Kevin Daudt's message of
        "Wed, 14 Sep 2016 18:03:08 +0200")
Message-ID: <xmqqoa3qqsw9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9C643F0-7AA2-11E6-A328-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

> When applied the the author of this patch shows up as:
>
>     Author: A U Thor" (test) <au@thor.com>
>
> So I agree with Jeff[1] where he states that the surrounding quotes
> should be removed, if that's not a problem for git.
>
> [1]:https://public-inbox.org/git/20160914051305.vphknpsikyxi3hg3@sigill.intra.peff.net/

I think we can go either way and it does not matter all that much if
"mailinfo" changes its output or the reader of "mailinfo" output
changes its input--we will either be munging data read from "From:"
when producing the "Author:" line, or taking the "Author:" output by
mailinfo and removing the quotes.

As an output from mailinfo that looks like this:

	Author: "A U Thor"
        Email: au@thor.com

is made into a commit object that has this:

	author A U Thor <au@thor.com>

we know that the reader of mailinfo output _already_ has some logic
to strip the surrounding double quotes.  That is the only reason why
I think it is a better approach to not dequote in the "mailinfo" but
in the reader to turn

	Author: "A \"U\" Thor"
        Email: au@thor.com

into a commit object that has this:

	author A "U" Thor <au@thor.com>

than updating mailinfo to produce

	Author: A "U" Thor
        Email: au@thor.com

and then create the same result.
