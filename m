Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EBB31FF76
	for <e@80x24.org>; Fri, 23 Dec 2016 17:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941975AbcLWRv6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Dec 2016 12:51:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65419 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S941959AbcLWRv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Dec 2016 12:51:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A89725A760;
        Fri, 23 Dec 2016 12:45:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QR7M7j1EkjTFf9Bm7RxFGGZRryI=; b=GmxzSd
        F4eZ1C5V+yLytS3CiHGGN+x6xG/z4nBArC0PJsPztulPe43WzCZPTO3tAXnPcN3h
        yB0GPrcHMkYnCmcuhw8Bye5ocTXROYUuHhbCedsrMQxS14IJo3pQLashU/7g0W4G
        G4SkqZlqNUkxdrWlqjSGlG9ygnRSuXC0jMkkc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sWpJvjUAxca0EC8LUsr/VpPsWK2mEFcq
        8Va1/5TTdbDOoosmy1n6AwvZq9Yd+fItAnxNW3yX/q4oMw27VGKCP97gH8SxpkDe
        JElBWOR27JdShJy/YhtK9blbsdxLMZKjpKctGHMc9PNHO/CBc6+ldwIXdmjVZSIL
        Egcj2vxuQuQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D9855A75F;
        Fri, 23 Dec 2016 12:45:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 110715A75E;
        Fri, 23 Dec 2016 12:45:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Norbert Kiesel <nkiesel@gmail.com>
Subject: Re: [PATCH] diff: prefer indent heuristic over compaction heuristic
References: <20161217005442.5866-1-jacob.e.keller@intel.com>
        <xmqq7f6zqr3i.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xp=7h7oATwO6vunqO+nfGhvQgiRkwG0P44hC4YLW2MRhA@mail.gmail.com>
        <xmqqinqbfz2r.fsf@gitster.mtv.corp.google.com>
        <20161223072201.zw2lwkdcs6qmb4rp@sigill.intra.peff.net>
        <CA+P7+xrWsCkABzpSkYJ4fb2_JijmUx=Sf4Hgsr6Z+k=_GogE_Q@mail.gmail.com>
        <20161223161917.4a352c2wzerj5uyz@sigill.intra.peff.net>
Date:   Fri, 23 Dec 2016 09:45:09 -0800
In-Reply-To: <20161223161917.4a352c2wzerj5uyz@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 23 Dec 2016 11:19:18 -0500")
Message-ID: <xmqqh95uedzu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D3F45F0-C937-11E6-97E2-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Dec 23, 2016 at 12:12:13AM -0800, Jacob Keller wrote:
>
>> I actually would prefer that we just say "this is the default now" and
>> provide some knob "no-indent-heuristic" or "no-compaction-heuristic"
>> and go with that, I think, since I am pretty sure we're all in
>> agreement that the heuristic is an improvement in almost every case,
>> certainly all the ones we've found. It's at least not worse in any
>> case I've seen, and is usually better.
>> 
>> Thoughts? I don't have a super strong opinion about which name we went
>> with for the knob.
>
> Yes, I think we should also make --indent-heuristic the default. That's
> technically orthogonal to the name, but I agree the name becomes a lot
> less important when it is just on by default.

Yes, I agree that will be the endgame, but one step at the time, and
also removing one of them is orthogonal that we would want to do
sooner rather than later.  So the step represented by the patch
under discussion is the first one among the two towards the final
state.

I guess both you and Michael are in favor of just removing compaction
variant without any renames, so let me prepare a reroll and queue
that instead.  We can flip the default perhaps one release later.

Thanks.
