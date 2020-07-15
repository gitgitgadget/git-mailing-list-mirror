Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8427BC433DF
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 14:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57009206D5
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 14:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DOfjU7uj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgGOOu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:50:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55230 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgGOOu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 10:50:56 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF393770C2;
        Wed, 15 Jul 2020 10:50:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rkrBAyRrw0uUr65kgl1eNnK3Qqw=; b=DOfjU7
        ujzFm0Igvhe1Gde64h3WyIyKSrO9ncYxOyRKYWgT02DlMdEUvQmo0lpGQvxbYxdM
        qlOrg4Hs6RPR0Z22aa1q0IyzPS/ljUIRVvXJ/EW9FwSC+clOb3scTU9SoyvzFaha
        EDzvvrKjJI5qhp9Np8nZPZt3jZw6gydsj+ow0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D4UFSMB0C7cZHWbVbbhlzbKOHp7++ekz
        UV8AhadpgeiBQUxkvkrhNgyK6CY7pEoZ08oIOEYOGxExVztty3KFRjL7jhjDvy2Q
        U2moyy6yW13balkgtAxyhy1gXfmTH8T8cZt2xYibHKnEXZhRB4O7mJD9fs6pKJJB
        ti1nxvblMIA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7FA5770C1;
        Wed, 15 Jul 2020 10:50:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 56714770C0;
        Wed, 15 Jul 2020 10:50:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Chris Torek <chris.torek@gmail.com>,
        Larry Martell <larry.martell@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Can't checkout branch
References: <CACwCsY7YSn_mbtFv3QjL5dY80G6e_r-gGC3SGo5rO5b8LGXxVA@mail.gmail.com>
        <CACwCsY7P5NiQL5ajHMOWo2EPiQZKUj_m_AVbtGy=z=twChimjw@mail.gmail.com>
        <CAPx1GvcOpmpuPseAQDYk9pg+hfdF9KJSSSiB0fEHQrnUuPS4CA@mail.gmail.com>
        <875zap8dqb.fsf@igel.home>
Date:   Wed, 15 Jul 2020 07:50:53 -0700
In-Reply-To: <875zap8dqb.fsf@igel.home> (Andreas Schwab's message of "Wed, 15
        Jul 2020 09:00:12 +0200")
Message-ID: <xmqq5zaoltma.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9588728A-C6AA-11EA-B89E-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Schwab <schwab@linux-m68k.org> writes:

> On Jul 14 2020, Chris Torek wrote:
>
>> To work around this in all versions of Git, you can just be
>> more explicit.  For instance:
>>
>>     git checkout deploy --
>>
>> forces Git to treat it as a branch name.
>
> For recent versions of git, you can also use `git switch deploy'.

Yes, that is the best piece of advice in the thread so far.

Thanks.
