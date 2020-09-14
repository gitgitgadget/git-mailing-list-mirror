Return-Path: <SRS0=aDBb=CX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7162EC43461
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 22:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26067208E4
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 22:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="p83EEYPJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgINWVb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 18:21:31 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50354 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgINWV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Sep 2020 18:21:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9F227103C1E;
        Mon, 14 Sep 2020 18:21:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gFX1XmmGc8hOAtHmOATntBFFz7A=; b=p83EEY
        PJd2VuNt+W2/Mq7UI2/7upa0HTyRtzCi/4YFirO82zmOeUfGj2UKy4OPPidu5DXH
        njXRI95H6nLMhjFaDKo2l1Y8lrJ3L4HB27cYO0B+FT9xp/obJS7zPinyOgCRH9uu
        j1cVmG2BfFA50mOPh1fGpvtmWN1a/km/JY+mE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EuWzNMG9rAUKmhMWwZXYS/anuVZvG85f
        2AfIOO8gYCjmMhu2mUHokdNusVRuR8A14REFrtI9EWQjqVPiZuos8Ctaen/Zrbl+
        Gb5YKuaeRf8K4VJ1iiltRHCB54XvfrqdhN30yyFsxgj8UZAMqC0aYin9/b3AGsZH
        nVLLaLWZ20E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9626E103C1D;
        Mon, 14 Sep 2020 18:21:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D6D54103C1B;
        Mon, 14 Sep 2020 18:21:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v8 1/1] remote.c: fix handling of %(push:remoteref)
References: <20200312164558.2388589-1-damien.olivier.robert+git@gmail.com>
        <20200416150355.635436-1-damien.olivier.robert+git@gmail.com>
        <20200416152145.wp2zeibxmuyas6y6@feanor>
        <xmqqv9gu7c61.fsf@gitster.c.googlers.com>
        <20200911214358.acl3hy2e763begoo@feanor>
Date:   Mon, 14 Sep 2020 15:21:22 -0700
In-Reply-To: <20200911214358.acl3hy2e763begoo@feanor> (Damien Robert's message
        of "Fri, 11 Sep 2020 23:43:58 +0200")
Message-ID: <xmqqft7k0zkt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F953FC0-F6D8-11EA-BFE7-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Damien Robert <damien.olivier.robert@gmail.com> writes:

> Hum, what about migrating the version that was in next to master? I am not
> fond of it because the series is not perfect and I am not satisfied with a
> patch series that is not as good as I would like it to be. So that was why
> I was arguing against merging it back then.
>
> On the other hand it does correct existing bugs, and the bugs it leaves
> remaining (apart from the memory leak) happens only in exotic cases. So I
> would not want my sense of perfection to prevent this series from graduating
> too long.
>
> And unfortunately I cannot give you an ETA for a fully satisfying series as
> I envision it.

That's OK---that is what "no rush" means.

We can throw the one bug it fixes together with the "bugs it leaves"
into the same category, i.e. happens only in narrow cases.  We now
know that you won't be actively working on the topic right now,
perhaps others can pick up where you left off and perhaps you can
help reviewing such a follow-up work ;-)

Thanks.
