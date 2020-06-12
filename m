Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3B2C433DF
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 12:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06B9920691
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 12:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ESa0GWgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgFLMcu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 08:32:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50251 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgFLMct (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 08:32:49 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DA2FD4CDEF;
        Fri, 12 Jun 2020 08:32:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jYOHLqYE49Kw9dkxqF+9+VYhNnA=; b=ESa0GW
        gLZNf2I4jf1bKazQIILBmizaYS5UxP6fDCH0HlFAxfNTWAGoIWezy3D496lGjXga
        C9H38itxclr25l/sN+FAAlZZpUhAzq71MVU/sSggFsX3+YphJyURS4FwCfOfddRZ
        KXrUE4UCbT9R3fOCJ/sn7b6qO2NlfIU2Hx1a4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YDrXlj5fZ9WaJe9WYSvpDRzA4moMCfDY
        1LQyfxljsbe0CiXVBQ2nUi/GF6oZbmuCMHcvUGL71L2c1GTjO9UpoeRC+E1JVlB9
        GwHATMEhSNKIvcTUqDOewIReXNA9N+SZGrEdwYUMiVw44rw9w+tJGx1YriHXEYn3
        tuoW6uQwtOY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D0F404CDEE;
        Fri, 12 Jun 2020 08:32:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 590894CDED;
        Fri, 12 Jun 2020 08:32:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Matt Rogers <mattr94@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        don@goodman-wilson.com, stolee@gmail.com, Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH 8/9] fast-export: respect the possibly-overridden default branch name
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com>
        <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com>
        <20200610233912.GU6569@camp.crustytoothpaste.net>
        <CAOjrSZvV6+ApfmOBa7rdXDPQJbExRsOfodO16i_1N5QjjhCB1w@mail.gmail.com>
        <xmqq3672cgw8.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2006111559300.56@tvgsbejvaqbjf.bet>
        <xmqqpna5bq2l.fsf_-_@gitster.c.googlers.com>
        <xmqqtuzha6xn.fsf@gitster.c.googlers.com>
        <xmqqimfxjwk6.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2006121403340.56@tvgsbejvaqbjf.bet>
Date:   Fri, 12 Jun 2020 05:32:43 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2006121403340.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 12 Jun 2020 14:07:01 +0200 (CEST)")
Message-ID: <xmqqa7184g7o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0AF369E-ACA8-11EA-83F7-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> BTW I heard from a couple sides that "primary" would imply that there is
> also a "secondary" branch, and potentially an ordering of all branches,
> which is why I did not really consider "primary" as candidate. Besides, it
> is so much more awkward to type than "main" (especially when you're as
> tired as I am right now...).
>
> That's why I try to stay with "main" for the moment.

You are reading too much into it.  I used "primary" because I needed
a word that clearly conveys the concept of being a special among
others, a word that is about the concept which is different from the
concept of "default", and that is clearly different from any of the
candidates floated as concrete words to replace 'master'.  Because I
wanted to say things like:

    In the context of fast-export, you'd want to special case the
    "primary" branch name, because unlike the "default" branch name
    (which we envision to be 'main' for most people in the new world
    order, so it may be less worth anonymizing because of the same
    reason the current code keeps 'master' as-is), its name can be
    sensitive.

without becoming unnecessarily ambiguous (replace 'primary' with
'main' in the above).

It was not because I do not want us to pick 'main' as the
replacement word for 'master' as the default branch name.

And a set of things, among which there is a concept of "one thing
that is special and different from all the others", does not
necessarily have to be a totally ordered set.  When cloning, we say
that the (often bare) repository at the other end indicates which
branch is the primary branch of the project by pointing at it with
its HEAD (which is the reason why we try to fork it to our local
branch namespace and check it out after cloning).  There is no
"secondary" in such a use case, and there is no need to have one.
