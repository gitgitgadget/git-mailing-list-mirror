Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32536C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 23:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C107922208
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 23:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UN8Z9ozz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgIPXIA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 19:08:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59271 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgIPXH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 19:07:57 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B88D9E986D;
        Wed, 16 Sep 2020 19:07:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vWuOwbBAPIRHedm3Nrda5geJXe0=; b=UN8Z9o
        zzIebPtnP118HGV0EZtelb+YbiRVsicoF/VX2qAD0LT2f3J1wS2v8iGgi+fp0V13
        OV6rtC4jwSc877Blw9eAdwDp5a5HFogb2coOqJ0i2lbNu/Glcf5GqHufFgldOcgj
        7kEHgvMNq5C5YUgOHoguZl7t4zJGvIfw+FqJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Mu/0RwiEbKE0Ng6WBJbCnFZpBeh5xEUY
        SjRbHp4zQrQ7lajWQ1961JljIJpKisqrmjgTWD7gCtd1xpDJX2ddW/TMBEdCJnce
        VEaHluZCb0+Krj9LZwXcvLaLnmBcqgEit8XgO08a7jf3iIy6hPnuh5zky1k1rNQb
        oNwWtViXh5I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B138AE986C;
        Wed, 16 Sep 2020 19:07:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F258AE986B;
        Wed, 16 Sep 2020 19:07:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, peff@peff.net, szeder.dev@gmail.com
Subject: Re: [PATCH v2 00/13] more miscellaneous Bloom filter improvements,
 redux
References: <cover.1599664389.git.me@ttaylorr.com>
        <cover.1600279373.git.me@ttaylorr.com>
        <40abfff8-3b5f-fa63-73fd-280cd80cd25f@gmail.com>
Date:   Wed, 16 Sep 2020 16:07:51 -0700
In-Reply-To: <40abfff8-3b5f-fa63-73fd-280cd80cd25f@gmail.com> (Derrick
        Stolee's message of "Wed, 16 Sep 2020 18:51:27 -0400")
Message-ID: <xmqqzh5ptj5k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 72D9DC80-F871-11EA-865E-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 9/16/20 2:06 PM, Taylor Blau wrote:
>> Hopefully this is it for this series ;). I think that it's in good shape
>> now, and I couldn't find anything in my own inspection that I wanted to
>> change. So, if others feel good, too, I think we should focus on
>> incremental fixes on top of this.
>
> I am also happy with this version. The test updates are
> rather nice.
>
> It is worth highlighging the tracing changes, in case
> anyone was planning to use that style of JSON data in
> production. I think it is better to include this simpler
> data model of one variable per event instead of rolling
> our own JSON format.

Yup, lets merge it down soonish.

Thanks.
