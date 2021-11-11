Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91441C433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 20:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75D4C6112F
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 20:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbhKKUf6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 15:35:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54193 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbhKKUf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 15:35:57 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59F08F235A;
        Thu, 11 Nov 2021 15:33:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MhmUIYIZoMqeg/u422LKcjWP/zdu0YgU/UOp50
        e1Keo=; b=vnM0/kl2u55kIqFMwFdr3VQZ4nX0i8x4U3SgRk2VadrbNvfmt5A9bB
        +ejsE+WmJKHZMkPcvrm98Py3QrNTZm3GT46RBC7i7RUbmQ0laga6br4W1mXl87x/
        ABz9OOKAyf8VTxMpTXK6OFznRJhYB/yeF+fGv0qVOzOi5KeaGT1zs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 39CB1F2358;
        Thu, 11 Nov 2021 15:33:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 047F3F2355;
        Thu, 11 Nov 2021 15:33:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.34.0-rc2
References: <xmqq4k8kzuz2.fsf@gitster.g>
        <YY0HbQJEWbOwuuFj@coredump.intra.peff.net>
        <xmqqwnlemwcy.fsf@gitster.g>
        <YY17rBFIdDl+H47I@coredump.intra.peff.net>
Date:   Thu, 11 Nov 2021 12:33:03 -0800
In-Reply-To: <YY17rBFIdDl+H47I@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 11 Nov 2021 15:23:08 -0500")
Message-ID: <xmqqy25ujuv4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92B4CBC4-432E-11EC-B080-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Nov 11, 2021 at 09:32:29AM -0800, Junio C Hamano wrote:
>
>> ...  So in this particular example, it would not matter if the
>> new unsorted traversal is subtly broken (I think the extent of the
>> damage is similar to making the SLOP problem deliberately worse),
>> but I am not sure if there are other failure modes that would yield
>> outright incorrect result.
>
> Yes, I think that framing is right: it is making SLOP much worse. We
> could similarly have had bogus timestamps in those commits which would
> cause the same outcome. So in that sense it is nothing new. On the other
> hand, I wonder how often it will cause extra traversal work (keeping in
> mind that this commit traversal is just the first stage; after we find
> the commits, then we talk all of their trees, which is the more
> expensive part).
>
> For the case of adding new commits directly on top of another branch, I
> think there would be no change. But any time you have to walk down to a
> common fork point (e.g., imagine I made a new branch forked from an old
> bit of history), we may fail to find that. I haven't quite constructed
> an example, but I have a feeling we could end up walking over
> arbitrarily long segments of history.
> ...
> I'd be curious to hear Patrick's thoughts on the whole thing.

Yes.  I'm tempted to wait for him to chime in.
