Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 694051F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 01:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfKSBYk (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 20:24:40 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63921 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfKSBYk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 20:24:40 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6AC211E6E6;
        Mon, 18 Nov 2019 20:24:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wtPl9vKnlqcLxyWuVq5C6vwZdN8=; b=VvBs8C
        b/Xvl7iykYmm6q4cjsqpaDHymPZazvHT82s9HTtgcDl3NOye2QXtIf/3F60xzBPt
        Uhv0JEuZWgmRRx5JVfhidIAMcAXkK1H0oA7P9FTjtb2+TKwf37eQeXzFgszzwqT0
        uaxjET5QPlR9PzZDdQyd3KxYD9S5STxV3q4qU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oiIB+YZ7ODVrMdGJiUbqzQONgcgdANYO
        4JA534v6WPL6kUrilGSGk7y+31TcDQICZ3MdJY6hoUPqEadtPK75yCutLzlNkqB9
        B08qUWJkjzXbe8hZa6nWOGeYXF+GIWx0xCeVghk9uqX56VWaCrfup3USlXiC7ruy
        FdJT4GNHeUo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63A0A1E6E5;
        Mon, 18 Nov 2019 20:24:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A283D1E6E2;
        Mon, 18 Nov 2019 20:24:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: rev-list and "ambiguous" IDs
References: <CAGyf7-EXOUWYUZXmww2+NyD1OuWEG18n221MPojVSCCu=19JNA@mail.gmail.com>
        <20191114055906.GA10643@sigill.intra.peff.net>
        <ab4dcc9c-4416-aef8-c8c4-38bb5ec97990@virtuell-zuhause.de>
        <20191115034941.GB20863@sigill.intra.peff.net>
        <917e2664-6059-c190-30fd-02f3cf7aa5dc@virtuell-zuhause.de>
        <xmqqmucw4h4n.fsf@gitster-ct.c.googlers.com>
        <20191118120315.GB12766@sigill.intra.peff.net>
Date:   Tue, 19 Nov 2019 10:24:35 +0900
In-Reply-To: <20191118120315.GB12766@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 18 Nov 2019 07:03:15 -0500")
Message-ID: <xmqq7e3w1wvg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 597521AE-0A6B-11EA-BD8A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think that changes the meaning of GET_OID_COMMITTISH, though. Right
> now it means "if disambiguating, prefer a committish", but not "I can
> only accept a commit". So we would still happily return an unambiguous
> object that does not match that type.

Ah, OK, so I was stupid (not a news anymore ;-)

> And that is why "git -c
> core.disambiguate=committish show $short_blob" works, for example.

Yes, and it should work that way.

> Perhaps a simple fix would just be for get_short_oid()'s error message
> to mention the disambiguation rule. E.g., something like:
>
>    $ git show abcd2
>    error: short SHA1 abcd2 is ambiguous
>    hint: We would have preferred a commit or tag pointing to a commit,
>    hint: but none were found. The candidates are:
>    hint:   abcd22f55e tree
>    hint:   abcd238df0 tree
>    hint:   abcd2b1cc8 blob
>
> or
>
>   $ git show abcd2
>   error: short SHA1 abcd2 is ambiguous
>   hint: We preferred a commit or tag pointing to a commit to other
>   hint: object types, but two candidates were found:
>   hint:   abcd22f55e commit
>   hint:   abcd238df0 commit
>   hint:   abcd2b1cc8 blob
>
> (optionally the second one could even not mention the blob, though I
> think with the lead-in sentence it's OK).
>
> The verbiage there isn't great (I was trying to avoid the jargon
> "committish"), but hopefully you get the point.

Yup, if we were to do anything, this is a much more sensible thing
to do than make GET_OID_<TYPE> reject objects that are not of <TYPE>,
I think.

Thanks for a dose of sanity.
