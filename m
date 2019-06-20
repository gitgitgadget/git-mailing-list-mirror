Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 450731F461
	for <e@80x24.org>; Thu, 20 Jun 2019 20:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfFTU6D (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 16:58:03 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55842 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfFTU6D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 16:58:03 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 08B456C444;
        Thu, 20 Jun 2019 16:58:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xnlvJPh/6vsdHv+Ac2RxlhdVOIA=; b=RaY0Sd
        5gz+uDYh2fs3y5uXqqTXzQGKiPFLZ7bE2HFdua93lKcLvcEQ3EIEEIJ5TZboC5Uc
        hN51cyZclBPqwXJpO9in7g+hxeJSi1oMqECxPgSlVOUMsd8fpxZhyQD1tv6QD58u
        0mEwQNMllI3B6F0ZQg/JdynBsVvDzlMh9/hYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N9vrSZ3qjqYAT3Dk7JXsOIKlrZ2KVAGG
        ZIOLD9lDD1Evxnqtti8Je5NXD4/gzUM3FcrV4uxE4NjHkwJjB/JuKENZFrS7Y2H5
        k1Dy7xhV6tworL3G96lAy5pnv1FVpjOC5WUacsSruEBEuNVVecLrIT4gRgeHrNKy
        rbuOGmjbuJk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 006126C443;
        Thu, 20 Jun 2019 16:58:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2D26D6C442;
        Thu, 20 Jun 2019 16:57:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/2] sha1-file: use OBJECT_INFO_NO_FETCH_IF_MISSING
References: <20190620083026.14524-1-chriscool@tuxfamily.org>
        <20190620083026.14524-3-chriscool@tuxfamily.org>
        <20190620085009.GC3952@sigill.intra.peff.net>
        <d88ac28b-638b-89c0-2bfb-634a0bb6ca4c@gmail.com>
        <CAP8UFD1-=+32G2XYXARcXm8=hnqZwxa1Ev9nmaS=qfqKS7GSWQ@mail.gmail.com>
Date:   Thu, 20 Jun 2019 13:57:56 -0700
In-Reply-To: <CAP8UFD1-=+32G2XYXARcXm8=hnqZwxa1Ev9nmaS=qfqKS7GSWQ@mail.gmail.com>
        (Christian Couder's message of "Thu, 20 Jun 2019 16:08:00 +0200")
Message-ID: <xmqqy31wkm97.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 153D964A-939E-11E9-A9A4-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Thu, Jun 20, 2019 at 2:39 PM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 6/20/2019 4:50 AM, Jeff King wrote:
>> > On Thu, Jun 20, 2019 at 10:30:26AM +0200, Christian Couder wrote:
>> >
>> >> Currently the OBJECT_INFO_FOR_PREFETCH flag is used to check
>> >> if we should fetch objects from promisor remotes when we
>> >> haven't found them elsewhere.
>> >>
>> >> Now that OBJECT_INFO_NO_FETCH_IF_MISSING exists, let's use
>> >> it instead to be more correct in case this new flag is ever
>> >> used without OBJECT_INFO_QUICK.
>> >
>> > I said earlier that this one would need to be tweaked for the new
>> > upstream name. But actually, I think it is not necessary after Stolee's
>> > patch.
>>
>> Yes, I believe that 31f5256c82  does an equivalent thing to the
>> combination of these patches.
>
> Yeah, I agree. Thanks Stolee for having already fixed that, and sorry
> for bothering everyone with this.

OK, I'll stop looking at this patch.
