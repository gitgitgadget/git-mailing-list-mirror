Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D58BC4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 17:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5695E610A0
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 17:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242238AbhHYRYm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 13:24:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58590 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbhHYRYl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 13:24:41 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E611BDC74E;
        Wed, 25 Aug 2021 13:23:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KAhfsq36j5kBNbl6vshh1PjZ4VFXxVuB8VCr/f
        BeEa8=; b=PNb+wnj9125sutJg6rzgyPgMrv8+8ly3xisAN6fbp8ZCdXvEJkTtpj
        Xs+9oUopDNeTnSPXGGHq3q4odj8wjJPKPCNOjfErN/wV09l4/HD40X9V8G3GKG9x
        X9i6IYm2rs9DlSdPx7DvceD/m1we8/xXpag/ShX9txL0Oye6N/C9w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD5ECDC749;
        Wed, 25 Aug 2021 13:23:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 63220DC740;
        Wed, 25 Aug 2021 13:23:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] ls-refs: reuse buffer when sending refs
References: <ccd03e685af0f5cf25c68272a758fc88d115e37a.1629899211.git.ps@pks.im>
        <705fee2c-7711-ac99-f692-ab08cd7b4e26@gmail.com>
        <YSZlK2y74wmYQcSd@ncase>
Date:   Wed, 25 Aug 2021 10:23:53 -0700
In-Reply-To: <YSZlK2y74wmYQcSd@ncase> (Patrick Steinhardt's message of "Wed,
        25 Aug 2021 17:43:39 +0200")
Message-ID: <xmqqzgt5igk6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 38FB7526-05C9-11EC-A8C4-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> I don't know. I just happen to revisit this topic every few days, and
> every time I stumble upon some more performance improvements. It would
> feel wrong to shift the goalposts of the other series every time I find
> something new, so I instead opt for separate patch series.
>
> If this proves to be annoying for reviewers, then feel free to shout at
> me and I'll change my approach.

The easiest would be to keep them independent and to justify them
independently.  There is no shifting the goalposts involved if you
did so.  Of course, you wouldn't be able to include the improvements
the follow-on topics make as part of the "advertising material" to
sell the benefit of the base series, though.  It can only work when
the follow-on topic is truly independent and is a good idea by
itself.  Another is to keep these follow-on topics unpublished
before the base topic graduates, and pretend that you came up with
them much later than you originally did.  Nobody would notice and
mind, as the base topic would be cast in stone by that time.

At the receiving end, what is most irritating is a series of topics
that pretends to be about different things but depend on each other
to function well [*].  I would imagine that it would be a lot more
trivial and pleasant to handle if any of the patches involved did
not come before these follow-on topics are all already thought of by
the author and instead came in a well-structured single topic, but
we do not live in a perfect world ;-).

In the case of this particular patch, I think the logic behind the
change makes sense by itself, so if I were doing it, I'd probably
choose to sell it as an independent change unrelated to the other
topic.

Thanks.


[Footnote]

* Any time the base topic gets rerolled, I'd be the one who ends up
  having to remember which other topics that did not rerolled depend
  on it in what order and rebase them correctly, and then I have to
  replace the follow-on topics that have been rerolled.  Even a
  single missed subtopic will cause the day's integration work
  redone, and all that robs time and concentration that the topics
  by other contributors needs from me, which would make me grumpy
  X-<.
