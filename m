Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6989020285
	for <e@80x24.org>; Thu, 24 Aug 2017 19:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753492AbdHXTJF (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 15:09:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57873 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751168AbdHXTJF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 15:09:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8283BA9505;
        Thu, 24 Aug 2017 15:09:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=16q2Y9IptVWtehROK5ljeyRS2h4=; b=JcwXSI
        6DeYEVFNQigEK+3VL8kRckuy/tgMawNMhCfQSYQGftyV8HBED3iNsCm26tKUOJXY
        DNatjqDqSwUDGzvvg+xa8o2dk+N2iWVOXHCDGBL5LhQIqdhcUvpmYxnsLMMHJRYs
        MWm9cbjhs/iUvn5i2o1Z1vwuhRtWckaWAOTkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gU/DPQmnQF1G34klM/N/g+EJJRkSlgeq
        wLtomARPodeYOpfzs8023Xffzb2eHHx+FJjcnYu9Aw/w3QJgkfzYQYKnLrESBxGS
        KeYrMrlEM96g9ANmvTuR14LRhJNDIQ/yLR0BBmk35gtcT1oPDmx2XblAdEn9Zt0r
        4EkKP7E8WYw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B8AFA9504;
        Thu, 24 Aug 2017 15:09:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD152A9502;
        Thu, 24 Aug 2017 15:09:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] Doc: clarify that pack-objects makes packs, plural
References: <20170822182242.20862-1-jonathantanmy@google.com>
        <xmqqbmn72x7a.fsf@gitster.mtv.corp.google.com>
        <20170823212251.li5fs4kypeveydbm@sigill.intra.peff.net>
        <CA+P7+xoPscnzCGLHSK-gk80GcZLZ5T4e7E29ztVX7qbjMcGbnw@mail.gmail.com>
        <20170824133842.vqzydienll6ka4vw@sigill.intra.peff.net>
Date:   Thu, 24 Aug 2017 12:09:02 -0700
In-Reply-To: <20170824133842.vqzydienll6ka4vw@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 24 Aug 2017 06:38:43 -0700")
Message-ID: <xmqqd17kwzox.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1C4220A-88FF-11E7-B133-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Aug 24, 2017 at 12:27:52AM -0700, Jacob Keller wrote:
>
>> > For the sneaker-net case, you are much better off generating a single
>> > pack and then using "split" and "cat" to reconstruct it on the other end
>> > Not that I think we should go into such detail in the manpage, but I
>> > have to wonder if --max-pack-size has outlived its usefulness. The only
>> > use case I can think of is a filesystem that cannot hold files larger
>> > than N bytes.
>> 
>> Is it possible to detect on the file system that we can't store files
>> that large, and remove the option, while enabling it only when we
>> detect the filesystem is unable to store large files?
>
> I'm not sure how easy it would be to do such a check. But even if it
> was, I'm not sure that buys us much. We'd still carry the code. We could
> in theory remove the option, simplifying the interface. But that removes
> the possibility of somebody wanting to stage the smaller packfiles on a
> more capable filesystem in preparation for moving them to the
> more-limited one.

I agree that it would not help anybody to _disable_ --max-pack-size
feature for those on certain filesystems, but it _might_ make sense
to automatically _enable_ it (and set it to the maximum number) when
your destination filesystem is limited.

Even in that case, failing with an error code from the filesystem
and then asking the user to redo with --max-pack-size specified
wouldn't be the end of the world, though.
