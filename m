Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31466C83F37
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 21:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347491AbjHaVGf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 17:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244408AbjHaVGe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 17:06:34 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA48B5
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 14:06:31 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C5E2621AC0;
        Thu, 31 Aug 2023 17:06:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=U0XoPBAebDvnri5Wflm3qXZwxqO2tuJ9wO0+vH
        OYmJc=; b=JuMRm3aZwbhVbiR8kaEL0IZ8wmV1DGkgN6lGHzNYe9tRVVM11krPA7
        xZ4PH+4biJIYncBmz3OygtfWAQ8qyN4nakraYdw7gp3UD+ZeoaVgc7e+B4tBHIxZ
        3Cis7IvTCW7kHBCwDSSSO5tLXo2vsWFyZ3tcdA5ihRp9bcp6aGWVc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A9E8F21ABF;
        Thu, 31 Aug 2023 17:06:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C964121ABE;
        Thu, 31 Aug 2023 17:06:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Subject: Re: [PATCH 10/10] lower core.maxTreeDepth default to 2048
In-Reply-To: <20230831174215.GA3208283@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 31 Aug 2023 13:42:15 -0400")
References: <20230831061735.GA2702156@coredump.intra.peff.net>
        <20230831062320.GJ3185325@coredump.intra.peff.net>
        <ZPBt6VYAWHJhv3N2@ugly>
        <20230831174215.GA3208283@coredump.intra.peff.net>
Date:   Thu, 31 Aug 2023 14:06:25 -0700
Message-ID: <xmqq7cpaudke.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3FACFD14-4842-11EE-9E03-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Aug 31, 2023 at 12:39:37PM +0200, Oswald Buddenhagen wrote:
>
>> On Thu, Aug 31, 2023 at 02:23:20AM -0400, Jeff King wrote:
>> > But I thought that
>> > following the sequence of logic (from "4096 is probably OK" to "whoops,
>> > it's not") had some value to share.
>> > 
>> of course, but you can just integrate that into the squashed commit message.
>> having it all in one place makes it easier to follow.
>
> Yes, though I think having it as a separate patch makes it easier to
> revisit later (e.g., by reverting or by replacing the patch during a
> re-roll).

I am on the fence.  Having it squashed into the same step as it was
introduced may reduce the patch count, but then it would not be easy
to explain why 2048 is a reasonable default at that step when no
code actually uses the variable, so the end result is not all that
easier to follow and read, as that earlier step would be handwaving
"2048 is good at the end of the series, trust me", unlike having it
at the end.  When 4096 is introduced as a "random number that seems
larger than large enough" in the earlier step, it might be worth
mentioning that it is a tentative default and may turn out to be
larger than necessary in which case we may want to shrink it ;-)


