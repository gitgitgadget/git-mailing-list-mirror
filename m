Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62468C4CECD
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 449352073C
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nsURAKO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgD0Uqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:46:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62081 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgD0Uqn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 16:46:43 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 10EEF5C97E;
        Mon, 27 Apr 2020 16:46:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CFAR2zHq4YxPx89ncHxwP8/vG1M=; b=nsURAK
        O/QTubUDNiXjqS3jfwwXBZUjlWbcmr+CmscI+crWGnDS8sn5B5ExT/uf1pkgEfhR
        QWiNLOsoaLL/wqsA1mzuLI3+ueQZ7W6iZO16Hqh7KlIl80vS5QqiFOmWWmkRH2cj
        XmBdGh54AcNa/wxJ6uQpebyN1Y9BwXyVoV+bc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=evRuFcU6O16N+ahhwzFC7V1QOFLT3nUa
        I/2EJgMaq6inmauF4QoQiL/Wrifo1eSCWkPhGyb3kHUICtGDTff6nQZPZ8C8pyiq
        1xbBB5odh3b9BgzGgI31YmqgW8RYKRBMy8IilUAK0+V0Z2iJ/y5pXga8o3NSCc++
        MXYsrddqPiQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 06FCD5C97C;
        Mon, 27 Apr 2020 16:46:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 699125C97B;
        Mon, 27 Apr 2020 16:46:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] bugreport: collect list of populated hooks
References: <20200424233800.200439-1-emilyshaffer@google.com>
        <xmqqsggs9ngo.fsf@gitster.c.googlers.com>
        <20200427190257.GA77802@google.com>
Date:   Mon, 27 Apr 2020 13:46:38 -0700
In-Reply-To: <20200427190257.GA77802@google.com> (Emily Shaffer's message of
        "Mon, 27 Apr 2020 12:02:57 -0700")
Message-ID: <xmqqr1w87j2p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 318EF94A-88C8-11EA-8675-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> > +	/*
>> > +	 * NEEDSWORK: Doesn't look like there is a list of all possible hooks;
>> > +	 * so below is a transcription of `git help hooks`. Later, this should
>> > +	 * be replaced with some programmatically generated list (generated from
>> > +	 * doc or else taken from some library which tells us about all the
>> > +	 * hooks)
>> > +	 */
>> 
>> Yes, I recall that we discussed adding some annotation to
>> documentation and extracting this automatically.
>
> Right, we did. I think I was hesitant to move on it because I had
> https://lore.kernel.org/git/20200420235310.94493-1-emilyshaffer@google.com
> on my back burner and wasn't sure how the hook architecture would look
> afterwards.

I thought we already agreed back then during that discussion I
recalled that we'd leave that "single source of truth" unification
out of the current topic.  Unless anything has changed recently to
bring us closer to be ready to start designing, I think it still is
fine to keep the needs-work comment above and punting.

Thanks.

