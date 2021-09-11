Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FABC433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 21:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FE7A61152
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 21:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhIKVjm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 17:39:42 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55406 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbhIKVjl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 17:39:41 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 909B9151ACF;
        Sat, 11 Sep 2021 17:38:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Wiyv8TLy+PVu
        dngnuNnFo+ASLxmYwSvVigVKBLz8IFo=; b=UxusfifcnXi+y81Y/IEnmtAlcJXr
        UWN1FKmSDKMWSaJoES9ovWQFIXRcbC8iYRhAJquiTgxBH6jGan0qS26bFmzdT17e
        NM2acIR4MMuy/9geBGY7iekwn51g8NhoG4/TXqJmv3Y4gg/8sulCcqGSxIDJUajv
        QVIfUrzbLoYu0cc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7B322151ACE;
        Sat, 11 Sep 2021 17:38:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B2CB6151ACB;
        Sat, 11 Sep 2021 17:38:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Sep 2021, #03; Fri, 10)
References: <xmqqsfycqdxi.fsf@gitster.g>
        <CABPp-BGR3dfJE7TZ+jkjDdWyeXYowmJhtoFaQ8_Abn=ZROhB5Q@mail.gmail.com>
        <87k0jn80np.fsf@evledraar.gmail.com>
Date:   Sat, 11 Sep 2021 14:38:23 -0700
In-Reply-To: <87k0jn80np.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sat, 11 Sep 2021 19:42:59 +0200")
Message-ID: <xmqq4kaqn67k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 986C7488-1348-11EC-97F4-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>> * ms/customizable-ident-expansion (2021-09-01) 1 commit
>>>  - keyword expansion: make "$Id$" string configurable
>>>
>>>  Instead of "$Id$", user-specified string (like $FreeBSD$) can be
>>>  used as an in-blob placeholder for keyword expansion.
>>
>> Kinda disappointing to see mis-designs from CVS not only persist but
>> get extended.  Perhaps I'm just biased...
>
> Yeah, if we were doing this today we'd say no, just use a smudge/clean
> filter.
>
> Which is effectively what this feature in git is, i.e. before we had
> that we had this built in smudge/clean filter, but this pre-dates that
> facility.
>
> And yeah, the relevant projects should probably fix their build systems
> to not rely on this CVS-era concept.

So three of us are all unhappy about $Id$, which is sort of
understandable given how long we've been involved in the project.

In one sense, our $Id$ is slightly more useful than CVS's, because
you could detect a non-pristine blob (i.e. take the blob object name
after contracting "$Id:...$" into "$Id$" and if it does not match
what is recorded on "$Id:...$", the blob has been tampered), which
CVS's $Id$ would not help, but it is not a huge advantage.  I'd
rather keep it a low-profile checkbox item whose use is not actively
encouraged.

And then the execution in this topic makes it worse by tying the
customization to the attribute mechanism, which would not fly well
both from usability's point of view (the string $Id$ should not be
per path---or the users need to look up which replacement $Id$
string should be used in a path in .gitattributes) and also
correctness's point of view (when you need to decide if $FreeBSD$ in
a different path need to be replaced, your in-tree .gitattributes
file may have been, or may not yet have been, checked out from the
same source, and the attribute mechanism's notion of "in this path,
$FreeBSD$ is to be replaced, instead of $Id$" may or may not apply).
If it were tied to the normal .gitconfig mechanism, it might have
been slightly more palatable.

> But since we're probably not actually talking about ripping the "$Id$"
> feature out of git & telling users to use their own clean/smudge filter
> or whatever for it, I don't see much harm in that existing facility
> becoming configurable.

See above.  I am OK with configurability via the configuration mechansim,
but not via the attribute subsystem.

>>>  The "--preserve-merges" option of "git rebase" has been removed.
>>>
>>>  Will merge to 'master'.
>>
>> I'm not objecting, but I'm kind of surprised to see this after your
>> and Dscho's previous discussion at
>> https://lore.kernel.org/git/xmqqv939uis8.fsf@gitster.g/; I thought
>> it'd stay in next for a while.  Was this a mistake?
>
> Perhaps I was just really convincing in
> https://lore.kernel.org/git/87fsuedl5x.fsf@evledraar.gmail.com/ ? :)

This is merely a result from a mechanical upgrade of "to 'next'" to
"to 'master'" that happens when the whats-cooking draft gets auto
updated after merging topics to 'next', which probably happened
before the "let's merge and keep" discussion happened.


