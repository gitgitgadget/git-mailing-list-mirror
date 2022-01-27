Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374F1C433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 00:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbiA0ARG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 19:17:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60334 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiA0ARG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 19:17:06 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E9A7611F2BE;
        Wed, 26 Jan 2022 19:17:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jFlOFJ5QAZ/4uqPb2LyszmWxNfVDW0j7Fp+Hfp
        ixzeo=; b=KWFaGdrnGD/6FWCXp4MFbw0IrqbDr9T4VPzoQYz8vPurq+tcw1OyId
        GYaIfKA/bMegdHyqCkA/mrr3hGgqTN8x/F/YnznEwoPoYmxmrzaKqOfjzor+if1M
        CYELAmmXCuAbc2uKKCOSJsSQMYrm4NQUw2y3Ags/6YrHKIO7dva8k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F95111F2BD;
        Wed, 26 Jan 2022 19:17:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7127611F2BC;
        Wed, 26 Jan 2022 19:17:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Konstantin Khomoutov <kostix@bswap.ru>, git@vger.kernel.org
Subject: Re: [RFC] shell: local x=$1 may need to quote the RHS
References: <xmqqsftc3nd6.fsf@gitster.g>
        <20220125092419.cgtfw32nk2niazfk@carbon> <xmqqa6fjzlm0.fsf@gitster.g>
        <YfBbRca0Rjl59MM0@nand.local> <xmqqo83zt54a.fsf@gitster.g>
        <YfHCoR2VSad95Cpu@nand.local>
Date:   Wed, 26 Jan 2022 16:17:02 -0800
In-Reply-To: <YfHCoR2VSad95Cpu@nand.local> (Taylor Blau's message of "Wed, 26
        Jan 2022 16:52:33 -0500")
Message-ID: <xmqqlez2nibl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 740733EC-7F06-11EC-BBE5-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Jan 25, 2022 at 09:53:25PM -0800, Junio C Hamano wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>> >
>> >> The manual page for recent dash may need an update.
>> >> Can you perhaps file a bug on their documentation?
>> >
>> > Yes, I agree that dash.1 is out-of-date after cbb71a8. Konstantin:
>> > please feel free to use any of this if it's helpful to you in creating a
>> > bug report for the dash folks.
>>
>> I doubt that we can write off dash v0.5.10 as too old to matter, as
>> the tagger date seems to be mid 2020 at
>>
>> https://kernel.googlesource.com/pub/scm/utils/dash/dash/+/refs/tags/v0.5.11
>
> That isn't quite what I was implying. What I meant to say was that the
> dash _manual page_ is out-of-date w.r.t. the dash patch I linked, not
> that that version is something we could ignore.

Oh, I didn't mean it that way.  I was continuing from your findings
that certain features of "local" may not have been available in
0.5.10; hence the hits from grep that showed any assignment might be
problematic with that version and we may need to downgrade our
scripts.

But as Szeder writes in a response later in the thread, assignment
on "local" may have been avaiable in versions before 0.5.11 in a
limited form (namely, it is split at $IFS unlike normal assignments,
which was the starting point of this thread), which reduces the
scope of downgrading necessary by a large margin ;-)

