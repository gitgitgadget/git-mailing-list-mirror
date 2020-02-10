Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94366C35254
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 18:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA0520715
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 18:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MWFPpY3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgBJStA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:49:00 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65054 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgBJStA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 13:49:00 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 480EFB8A2F;
        Mon, 10 Feb 2020 13:48:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fZq31e27+W0L94D8hXpkeVprWUo=; b=MWFPpY
        3DNsL9AxBDLXd/YTYz9tote+4GPE40p56KQit8CQwGvcV4uOj+fFnIVtMZCOSPLu
        Fziz1j9g1GREXtP7iUCUxVUOqlgJzmxuQ3y9oafJ2SnW/ZoenvsA90iolRS3Vy8U
        bA0jMwzE7OdZvLDTvsjjCqSj5qJsMEWBYayO0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=efD5BCHF7WI+mO4S7kugr9/ACk8P5Sb3
        QhE9ZX9gdFcdz7P0kTIpxZL7pOnNxKLCP1loMv7EqsOWuOgduk57tNnMEFncUslN
        izL0uS+n+c2/cU9ICnTM5WyFdI8Q6RnfmZwIBenXn8LHr7hBe/LYomNUwnQTn+kU
        suEf2JMK5l0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3FA8DB8A2E;
        Mon, 10 Feb 2020 13:48:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 68CBBB8A2B;
        Mon, 10 Feb 2020 13:48:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Cc:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: Re: [PATCH 2/8] rm: support the --pathspec-from-file option
References: <pull.530.git.1579190965.gitgitgadget@gmail.com>
        <5611e3ae326bb7f61abf870e3b2851226b6af1d8.1579190965.git.gitgitgadget@gmail.com>
        <xmqqftg8a9fp.fsf@gitster-ct.c.googlers.com>
        <19ab18db-3149-02b1-41d8-7ddb42c3757d@syntevo.com>
Date:   Mon, 10 Feb 2020 10:48:53 -0800
In-Reply-To: <19ab18db-3149-02b1-41d8-7ddb42c3757d@syntevo.com> (Alexandr
        Miloslavskiy's message of "Mon, 10 Feb 2020 15:46:58 +0100")
Message-ID: <xmqqd0amz3ai.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD4646E4-4C35-11EA-83CC-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com> writes:

> Sorry for late reply, I was on vacation. Now I'm back and ready to
> continue :)
>
> Thanks for your review!
>
> On 21.01.2020 20:36, Junio C Hamano wrote:
>>> Decisions taken for simplicity:
>>> 1) It is not allowed to pass pathspec in both args and file.
>>>
>>> `if (!argc)` block was adapted to work with --pathspec-from-file. For
>>> that, I also had to parse pathspec earlier. Now it happens before
>>> `read_cache()` / `hold_locked_index()` / `setup_work_tree()`, which
>>> sounds fine to me.
>>
>> That is not an explanation nor justification.
>
> I'm not exactly sure what are you suggesting.

I expected that the proposed log message to explain and justify why
a change (in behaviour, in design, etc.) is made.  "There is this
limitation" is not a justification---"because of such and such
reasons, there is this limitation, otherwise such and such bad
things happen" is.

