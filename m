Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39B3C432C0
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 22:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967F72071E
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 22:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yIvgtjTu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfLBWxQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 17:53:16 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62687 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfLBWxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 17:53:16 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 55C52ADDAF;
        Mon,  2 Dec 2019 17:53:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gaB0Hl7jwKq9Mcder+Pk+OYorhM=; b=yIvgtj
        Tu/i1uvbtAAZmYTEIw0gzvz1WCEQ0cUU3IBnf3vq+W8Xjcfwqjc92+dQpfcOYdJq
        tlVEpiaEbwToyuE+wy29RE52h+Q4SRK91YypVCU2vDA9OHrc3Drh4srAWMXvKg3b
        Cwq3/SQWG0a9nKi3kadASEwyLsvaIbgUV4+LA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ceu6dAJtvZYu1KItXdOOmFpm9sbl7A7/
        /MDg14qO2v2GHNZDwv7TJSCnFMzyzp9lGSBtV+nQv9Y9iLLfnyz9WgHkpz7owvAZ
        zfn76DRhAgo72uAk8uKUAfQJV8ZdLQuIj5N404T6X5FLWajEFTgykIYMal+r26py
        0RFK8z4ofm8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4D63EADDAE;
        Mon,  2 Dec 2019 17:53:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 72035ADDAB;
        Mon,  2 Dec 2019 17:53:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 22/26] t7700: consolidate code into test_no_missing_in_packs()
References: <cover.1574731022.git.liu.denton@gmail.com>
        <cover.1574884302.git.liu.denton@gmail.com>
        <a99a45cb6f2cc7328ef0e52fc2ea8fec537bfba9.1574884302.git.liu.denton@gmail.com>
        <xmqq7e3i4b1p.fsf@gitster-ct.c.googlers.com>
        <20191202205037.GA43606@generichostname>
Date:   Mon, 02 Dec 2019 14:53:09 -0800
In-Reply-To: <20191202205037.GA43606@generichostname> (Denton Liu's message of
        "Mon, 2 Dec 2019 12:50:37 -0800")
Message-ID: <xmqqo8wqwd9m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 840A46D8-1556-11EA-9BCE-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Hi Junio,
> ...
>> "grep" is better only if the original were
>> 
>>     $ sed -n -e '/required match/p'
>> 
>> but everybody would write it with grep to begin with ;-)
>
> This was what I was intending. It was originally written like the above
> and it made sense to convert it to use grep. I guess "filter lines" in
> my commit message is a little bit vague. Could we change this to "filter
> matching lines" perhaps?

Ah, I see.  I somehow thought that some of the "sed" invocation in
the original version were doing "find lines and filter its
contents" (i.e. "-n -e 's/find/munge/p'"), but all three of them are
just "find lines" (i.e. "-n -e '/find/p'").  So I think the change
made by the patch is OK.

I think I was reacting to the output of "grep" being piped to "cut".
IOW, the original

	... | sed -n -e '/find/p' |
	while read sha1 garbage
	do
		... use sha1 ...

were rewritten to

	... >raw &&
	grep -e 'find' raw | cut -d" " -f1 >orig
	... use orig as a list of sha1s ...

But the "grep piped to cut" can be a single process

	... >raw &&
	sed -n -e 's/\(find\).*/\1/p' raw >orig
	... use orig as a list of sha1s ...

So in the tiniest picture, turning "sed -n -e /find/p" into "grep"
is not wrong per-se, but if you step back a bit and see a larger
picture, using "sed" a bit more effectively turns out to be still a
better rewrite.

... and I wrote the above before I read the remainder of your
response, where you considered which one is easier to read between
"grep piped to cut" and "sed" ;-)


> (By the way, if I were to reroll this series, should I keep sending out
> the entire patchset? It feels very noisy to send out 20-something emails
> every reroll when I'm just making a small one or two line change.)

Especially if it is near the end of the series, just a single step
is OK.  But is there anything that is glaringly wrong that needs a
reroll?  Or would it be "this is good enough, so let's have them
cook in 'next' and graduate to 'master'---further clean-up can be
done after all the dust settles"?  I have an impression that we
reached the latter by now.

Thanks.
