Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E824C282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 16:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112572070E
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 16:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UNDKH8tE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgAHQJi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:09:38 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50665 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgAHQJi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 11:09:38 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A655797498;
        Wed,  8 Jan 2020 11:09:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S8qfdVbrInuspafGpBNcd+6xcKA=; b=UNDKH8
        tEmz58zvEi2t2Do4F7FQOMdhhcN0pdteC6qb5z0c1PL2LTsWgwuYmVvXAQ7EyrCe
        J4WJe7i+rUTO4aDuPwjuIBqiS7O0cFW7KZeNsjbiywQu6vC0owwpuAs3lpA90C9P
        6y6bO3cNocMtKQDjNApbSnnoCxpEHKj4gXbJI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c5YhmLvhKnbpMpi9DYi9eIuoFU/+gs/+
        mYN8SoYDGY8buN3GLndtz4MOMcopHGVDYUq9bADR0WqIg0i6AWueSwRvZCz/QM37
        2YtVqqsIR7ecq9Db3N/qqO5CWZpF/4rGB64MSYIf/oNtGYfid/geiwTX6pbS/Enx
        vK2oYryzgj8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9CE4897497;
        Wed,  8 Jan 2020 11:09:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2BED697496;
        Wed,  8 Jan 2020 11:09:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Liam Huang via GitGitGadget <gitgitgadget@gmail.com>,
        Liam Huang <liamhuang0205@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/1] Update imap-send.c, fix incompatibilities with OpenSSL 1.1.x
References: <pull.516.git.1578391376.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2001071313580.46@tvgsbejvaqbjf.bet>
        <xmqqv9pn5hgl.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2001071944250.46@tvgsbejvaqbjf.bet>
        <xmqq7e2359an.fsf@gitster-ct.c.googlers.com>
        <xmqqtv573twq.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2001081148300.46@tvgsbejvaqbjf.bet>
Date:   Wed, 08 Jan 2020 08:09:28 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2001081148300.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 8 Jan 2020 11:59:46 +0100 (CET)")
Message-ID: <xmqqzhey2amf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40E7CFC2-3231-11EA-998B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I will change GitGitGadget to no longer Cc: you automatically.

Thanks.

> Please register my suspicion that this will make GitGitGadget a lot less
> useful: the stated mission of GitGitGadget is to make contributing patches
> to the Git project _easier_ so that the contributor can focus on the
> changes they want to make, rather than on the rather involved process.

I am not sure where that "a lot" comes from.  FWIW I do not expect
my response rate to change at all [*1*], but perhaps you have
something else, perhaps effect on reviewers other than me, in mind?

In any case, a large part of focusing on changes they want to make
is to ask for help from the right people who know the part of the
system they want to touch, and that is ...

>> Besides, when they send out patches they would also add area experts and
>> those who participated in the review of the earlier round to Cc: so GGG
>> needs to have a mechanism to allow the end user to do so.
>
> So GitGitGadget should now also learn to determine who the current area
> experts are???

... done by CC'ing the right folks, right?

Whether they run "shortlog --since=18.months $pathspec" locally to
find them, or GGG does so for them before turning the patch into a
piece of e-mail and offers "perhaps some of these people can help
you?", after the contributor decides from whom to ask help, there
would be some way for the contributor to tell GGG "ok I'll ask this
person to help by placing the addresss on the CC", no?  That is what
I meant by the mention of CC: in the part of my response you quoted.

> I must have misread your request.

No, it wasn't even a request (unless GGG does not offer any way to
say "I want this to be CC'ed to these folks", that is).  It was
merely "the contributor must have a way to choose to (or not to) cc
me (or anybody), I presume".

The request part was "let them do so themselves, instead of always
cc'ing me, because the latter does not add any bit of useful
information."

After all, software development is a human interaction process.  I
wouldn't mind if the automated CC is done to address some 'bot
(e.g. patch tracker) at all, but it simply is rude to treat other
people as a convenient review bot and it is even more so to do so
blindly and automatically, which is what automated CC added by GGG
is.  At least, when the contributor chooses to ask a reviewer X,
even if the choice were wreong and the patch were in an area the
reviewer X were not familiar with at all, it means something that
the contributor decided to ask for help from X by CC'ing.


[Footnote]

*1* I do not read patch e-mails out of my mbox and instead read via
the nntp interface to lore or public-inbox archive.  The list of
messages presented to me to choose which ones to read and respond to
would only show me who the author is and what the title is, so "is
it CC'ed to me?" does not affect my response rate at all.
