Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3C8C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 15:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97EC5610FA
	for <git@archiver.kernel.org>; Tue, 18 May 2021 15:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343506AbhERPRZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 11:17:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65120 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243998AbhERPRY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 11:17:24 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 52E9513A159;
        Tue, 18 May 2021 11:16:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Co3kDJ2K+7gf
        Fv5F+jz+jgEXPfzBoFUEiSalWurG87E=; b=oFyTG6VehmD3i515ceIV9VV5f2vX
        ovHbd4S7ZDfSkqz/HlB11fCAbTwfoL8tEnjRZ691/gQIIeCGyF9mQJp9U1EcT4yv
        VKODaQ89E+Dzxo8ivnXUiMOjF23VZl3m1Y+0YGwkgnZuZjgXgkBLqfy2iUk/JVMP
        ECoGp9C25NAZeuM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4B2F613A158;
        Tue, 18 May 2021 11:16:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8D34113A157;
        Tue, 18 May 2021 11:16:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        karthik nayak <karthik.188@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Options like hash-object --literally and cat-file
 --allow-unknown-type
References: <87r1i4qf4h.fsf@evledraar.gmail.com>
Date:   Wed, 19 May 2021 00:16:01 +0900
In-Reply-To: <87r1i4qf4h.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 18 May 2021 16:08:18 +0200")
Message-ID: <xmqqtun0139q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F5EB2874-B7EB-11EB-B8EF-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> So you might expect it to accept an --allow-unknown-type, but it
> doesn't. I could add support for that, but I think it would be stupid.
>
> Why should you need to restart a "cat-file --batch" just because you
> encounter a bad object? Just .. print it, we can do that safely. I
> really don't see the point of having --allow-unknown-type at all. Ditto
> for the --batch-check mode.
>
> I mean, having read all the code I think I know why it's there. I think
> It's because there was no way to ferry the information up from
> object-file.c before my yet-to-be-submitted patches, so the solution wa=
s
> to pass down a flag saying "please don't die()".
>
> But is it something that anyone thinks is a good idea in the abstract? =
I
> don't see why I shouldn't just document something like:
>
>     Older versions of "cat-file" used to require an --allow-unknown-typ=
e
>     flag to emit information about objects of unknown types. This is no
>     longer required or the default. If you'd like to die on anything
>     except known types (e.g. to die instead of bothering with parsing a
>     "bad" type that possibly has spaces in it in the --batch output)
>     supply --no-allow-unknown-type.
>
> What do you think?

Thanks for thinking things through.

My knee-jerk reaction is

 - As long as "cat-file -t $thing" exits with non-zero status for an
   invalid thing, which was crafted using hash-object --literally,
   reporting the typename it read from the object header to its
   standard output would be fine without "--allow-unknown-type".
   But scripts would be upset if it suddenly started to return with
   zero status when asked to check what type of object the $thing
   is.

 - For "cat-file --batch[-check]", I am on the fence.  A script may
   break because it is not prepared to see anything but four
   existing types (so it might even say "do X if it is a blob, do Y
   if it is a tree, do Z if it is a tag, and do W for everything
   else" and expect/assume that W will see only commits), so failing
   without --allow may still be a prudent thing to do.  We could
   declare that such a script is already broken, even though it
   would not change the fact that the user has been successfully
   using it reliably.

With your new "we can now bubble necessary information up from the
object-file.c layer without dying" change, it might make it easier
to arrange so that object-file.c layer would never die and I do not
think I have any objection against such a plan.  The implementation
of "--[no-]allow-unknown-type" would have to be migrated to the
caller at the higher level to decide what to do when it learns that
the object it asked the object_info() about is of an invalid type.
And the choice of the default would become easier to change later
with such a change to the lower layer.  But I am not sure if that
warrants switching of the default.
