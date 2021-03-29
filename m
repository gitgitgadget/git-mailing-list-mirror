Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5C6C433E3
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 18:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D98B619A9
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 18:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhC2SWN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 14:22:13 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60077 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbhC2SV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 14:21:57 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A1101241D7;
        Mon, 29 Mar 2021 14:21:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Iksa0eSEoICC
        bCCTRAntX1N+NUU=; b=fFWnHL9FYGN7f627NL6papVmme19fjPC0X4moUPeyhZX
        INeHXgDQQrUGJlxkBqXAJi2wwkAeEbvKOYaDvwiJtj7+4VotSdRGhCSO5bgCRTBJ
        wjT9KmNcnQKG4hhzD9bFg8B6leiZHgyVJtAghD6XJA6tPwaritQFy9E1+Sl8QKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=WR4Ure
        EPDoyenTqrKkongybZxa08yIWHoS0jU/JuKOleb3xDF72VzNUSAAw8cgT5kAZRBw
        rcQUIJ2cyK/6pGkldgD6vZmpPbjCZharTkT/rpTzSHgCou1eSEAu/lxfZxedAyBC
        ixJdIehcs/XxIZ6WarZTs02vYhLhvSMfMtHVc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 21B691241D6;
        Mon, 29 Mar 2021 14:21:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6C0AD1241D5;
        Mon, 29 Mar 2021 14:21:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/5] Makefile: rename objects in-place, don't clobber
References: <20210307132001.7485-1-avarab@gmail.com>
        <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
        <patch-1.6-3330cdbccc0-20210329T161723Z-avarab@gmail.com>
Date:   Mon, 29 Mar 2021 11:21:52 -0700
In-Reply-To: <patch-1.6-3330cdbccc0-20210329T161723Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 29 Mar
 2021 18:20:08 +0200")
Message-ID: <xmqqy2e5kegv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A3B28162-90BB-11EB-9368-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Per the log of changes to the Makfile and Junio's recent comment about
> [1] why that pattern got introduced it was for a different reason
> entirely, i.e. ("[]" edits are mine, for brevity):
>
>     [T]hat age old convention [...] is spelled [as]:
>
>     	thing:
>     		rm -f thing thing+
>     		prepare contents for thing >thing+

Did I say that?  I recall I specifically avoided the "redirection"
because this is *NOT* shell-script only principle.  If a command is
so broken that "cmd -o thing" that fails to work correctly leaves a
broken output in thing, then the pattern should be applied and made
to "cmd -o thing+ && mv thing+ thing".

On the other hand, if "cmd" refrains from leaving a half-baked
result in "-o thing" (and I believe $(CC) is well-behaved even on
AIX), I do not think it is a good idea to use that pattern.  One
version of AIX may refuse to overwrite a file in use because
creat("thing") that is necessary for "-o thing" may fail while
"thing" is in use), but another system may refuse to rename over a
file in use (i.e. "-o thing+" into a brand new "thing+" may be OK
but the final "mv thing+ thing" may fail).  So pretending that it is
a cure for broken use case is cluttering Makefile for no real
benefit and leading readers into confused thinking.

>     		mv thing+ thing
>
>     It protects us from a failure mode where "prepare contents for
>     thing" step is broken and leaves a "thing" that does not work, but
>     confuses make that make does not need to rebuild it, if you wrote i=
t
>     as such:
>
>     	thing:
>     		prepare contents for thing >thing
>
>     [It might leave behind a corrupt 'thing'.] In any case, it is not
>     "we are trying to make thing available while it is being
>     rewritten" at all.
>
> That makes perfect sense for shellscripts, but as this change shows
> there's other good reasons to use this age old convention that weren't
> considered at the time.

So, no, the age old convention may have considered and does not
apply to such a use case.

>  git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
> -	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
> -		$(filter %.o,$^) $(LIBS)
> +	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@+ $(ALL_LDFLAGS) \
> +		$(filter %.o,$^) $(LIBS) && \
> +	mv $@+ $@

Really, does anybody else use "$(CC) -o $@" in such a way in their
Makefile?  Having to do this smells simply crazy (I am not saying
you are crazy---the platform that forces you to write such a thing
is crazy).

So, while I do not think the end result would break the build (other
than it probably would leave crufts "make clean" would not notice
behind when interrupted in the middle), I am moderately negative on
this change.

Thanks.
