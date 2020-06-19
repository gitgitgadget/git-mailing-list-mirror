Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C376C433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 19:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 068CB21527
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 19:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t8TB/owI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387484AbgFSTUp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:20:45 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65196 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733142AbgFSTUp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 15:20:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 50408C9D56;
        Fri, 19 Jun 2020 15:20:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p9Cs0y329OAMTbJ2cyWcoiTmZhU=; b=t8TB/o
        wI+wlIfd19BWev6VUZw0Aw9LpO0aYPX052ApD7xd3FkZJxg9IY84/tKSGb53chAj
        BQzgI3aUTTGm+4dKYFz7ov7ndHYgLbT37Qo1opuYacpEXMbB4AtfkGACZ1JfDnmD
        6qAodTAYQFnzKt82++bdCIRMy6YFlM78kEdMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uXCw1o04284JUMwfhkHjt7+3NT/NJ7Um
        lpkDTaOFaI4WBPD82zXFpE28XPgHKUdtvPKnjVQE30OS4cMOCTbifuWAxodCQcxN
        IGGs2KwjOMCtJqZxz6VRJ0JqW+fUusKSeq6xwWAF+gndkJrc1Elbczs7LhXs4qF3
        4vAY7AVUNf4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 48933C9D55;
        Fri, 19 Jun 2020 15:20:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8DFFAC9D51;
        Fri, 19 Jun 2020 15:20:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] fast-export: allow dumping the refname mapping
References: <20200619132304.GA2540657@coredump.intra.peff.net>
        <20200619132546.GA2540774@coredump.intra.peff.net>
        <CAPig+cRNem-S5LGX=v=1Tid64sXWBxNyWH4ffgLgF0o1yN=mtw@mail.gmail.com>
        <20200619160129.GA1843858@coredump.intra.peff.net>
        <20200619161816.GA9205@flurp.local>
Date:   Fri, 19 Jun 2020 12:20:38 -0700
In-Reply-To: <20200619161816.GA9205@flurp.local> (Eric Sunshine's message of
        "Fri, 19 Jun 2020 12:18:16 -0400")
Message-ID: <xmqqv9jmhng9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6892622-B261-11EA-ABC9-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Jun 19, 2020 at 12:01 PM Jeff King <peff@peff.net> wrote:
>> On Fri, Jun 19, 2020 at 11:51:06AM -0400, Eric Sunshine wrote:
>> > That is, have the caller do this instead:
>> >
>> >   if (anonymized_refnames_handle)
>> >     dump_anon(anonymized_refnames_handle, ...);
>>
>> <shrug> The names were long enough that I thought it was more clear not
>> to repeat myself. [...]
>
> Indeed, it's a minor point and subjective. Certainly not worth a
> re-roll or even worrying about it.

It probably is subjective but fwiw I too find yours easier to
follow.

>> > This hard-coded "6" seems rather fragile, causing the test to break if
>> > other refs are ever added or removed. Perhaps just count the refs
>> > dynamically?
>> >
>> >   git show-ref >refs &&
>> >   nrefs=$(wc -l refs) &&
>> >   # Note that master is not anonymized, and so not included
>> >   # in the mapping.
>> >   nrefs=$((nrefs - 1))
>> >   test_line_count = $nrefs refs.out &&
>> >
>> That's exactly what I wrote originally, but it failed on macos due to
>> extra spaces in the "wc" output.
>
> Hmph, that shouldn't have failed. Did you quote the $(wc -l refs)
> invocation? Quoting it would cause it to fail.

> +	git show-ref >refs &&
> +	nrefs=$(wc -l <refs) &&

Yup, I've seen that workaround for macs too many times and it should
work well.

>  	# Note that master is not anonymized, and so not included
>  	# in the mapping.
> -	test_line_count = 6 refs.out &&
> +	nrefs=$((nrefs - 1)) &&
> +	test_line_count = $nrefs refs.out &&
>  	grep "^refs/heads/other refs/heads/" refs.out
>  '
