Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0353FC4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 20:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F1D42083B
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 20:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PsLo/XSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgJGUIS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 16:08:18 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63215 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgJGUIS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 16:08:18 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9EAC4F1CAC;
        Wed,  7 Oct 2020 16:08:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=95uU94ElOZJR
        jPIFeOusbz+PIQk=; b=PsLo/XSaGSWEUZT9acP6/O4U+z1a/LF8dHkQVdkREqBx
        6qvz4nLB+tyWWF9kZuDl/z9KwMpasJrai4kl53WMW8vVpMveDWvLMiHY4oOvvMME
        ugMfvczAzpgjVwBVWxDNw1yuprmGA6K64yAIjO4Ujr7MazsqNEbtNVDGuBmaD6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dRuoTF
        aE+23c55/IhiK3UQ373KzFVa4boUa5HoGRolbigiyYxQqaEqqXNQv+733n5oLlRz
        /dlmyXNyh5ipfKjGsrN05ejqxfPfYIX/0L8YBweVWDGLKASaXLHOXNwkPRY4tFQe
        iYI2c2z7TvzKVFf+8rlFBK+/uvQ0I/M1SnRTo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 97178F1CAB;
        Wed,  7 Oct 2020 16:08:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DBF1FF1CA8;
        Wed,  7 Oct 2020 16:08:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] diff: add -I<regex> that ignores matching changes
References: <20201001120606.25773-1-michal@isc.org>
        <20201001120606.25773-2-michal@isc.org>
        <xmqqy2kpbye9.fsf@gitster.c.googlers.com>
        <20201007194821.GA20549@larwa.hq.kempniu.pl>
Date:   Wed, 07 Oct 2020 13:08:12 -0700
In-Reply-To: <20201007194821.GA20549@larwa.hq.kempniu.pl> (=?utf-8?B?Ik1p?=
 =?utf-8?B?Y2hhxYIgS8SZcGllxYQiJ3M=?=
        message of "Wed, 7 Oct 2020 21:48:21 +0200")
Message-ID: <xmqqft6p240j.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D4AF6FD4-08D8-11EB-AE9E-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Micha=C5=82 K=C4=99pie=C5=84 <michal@isc.org> writes:

>> cannot be memset(0) before use?  It seems like a much better
>> approach to ensure that we clear the structure.
>
> I do not know of any reason for xpparam_t structures to not be
> zero-initialized.  In fact, they _are_ zero-initialized most of the
> time; AFAICT, there are just three places in the tree in which they are
> not.
>
> Would you like me to address that in a separate patch in this patch
> series?

Yes, as a preliminary clean-up patch before the real/fun stuff ;-)

>> > +-I<regex>::
>> > +	Ignore changes whose all lines match <regex>.
>> > +
>>=20
>> The implementation seems to allow only one regex, but I suspect we'd
>> want to mimic
>>=20
>>     $ printf "%s\n" a a a >test_a
>>     $ printf "%s\n" b b b >test_b
>>     $ diff -Ia     test_a test_b
>>     $ diff     -Ib test_a test_b
>>     $ diff -Ia -Ib test_a test_b
>
> Ah, sure.  After skimming through various man pages available online, I
> was not sure whether all standalone versions of diff which support -I
> allow that switch to be used multiple times and I thought it would be
> better to start with the simplest thing possible.  If you would rather
> have the above implemented immediately, I can sure try that in v2.
>
>> and until that happens, the explanation needs to say something about
>> earlier <regex> being discarded when this option is given more than
>> once.
>
> Sorry, where do I look for that explanation?=20

You wrote "Ignore changes whose all lines match <regex>"; I was
suggesting that we also need "when given more than once, all but the
last <regex> are ignored" after that sentence, because that is not
what people who know how -I works in versions of "diff" that support
it expect.

But I think it should be trivial to make it a list of patterns and
try to match against them in a loop.  So let's support multiple
patterns from the get-go.

> I have not thought about this approach before, but it sounds elegant to
> me, at least at first glance - option parsing code sounds like the righ=
t
> place for sanitizing user-provided parameters.  Doubly so if we take th=
e
> multiple -I options approach.  I will try this in v2.

Sounds good.

>> I agree with what you said in the cover letter that it would be a
>> good idea to name the existing xdl_mark_ignorable() and the new one
>> in such a way that they look similar and parallel, by renaming the
>> former to xdl_mark_ignorable_lines or something.
>
> Then I will do that in v2.  Separate patch?

Given that the function has only one caller, I think it is better
done within the same patch.  xdl_mark_ignorable() as the name of the
function is not wrong per-se, so it does not deserve to be renamed
standalone in a preliminary clean-up patch---there is nothing to be
cleaned up.  The fact that we introduce a similarly tasked function
makes its current name less desirable, so adjusting to the new world
order is better done as part of the same patch.

> My pleasure ;-)  And thanks for taking a look.  Sorry about the long
> turnaround time, but unfortunately this is the best I can do at the
> moment.

Pleasure is mutual ;-)

We've survived without -I for 15 years.  Even a few more months
would not hurt anybody.  Take time, aim for a quality job, and most
importantly, have fun.

Thanks.
