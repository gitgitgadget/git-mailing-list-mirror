Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBC0C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 17:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97E6760F38
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 17:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239753AbhHDRGt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 13:06:49 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60041 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhHDRGs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 13:06:48 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E33121301CA;
        Wed,  4 Aug 2021 13:06:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=keqigiyuNDh7
        4GbFX8ZNU0LWKKoLZ/ErorczvYvqWNU=; b=mgnVpiLDIrm9sv7E9BYAoJfLHeU1
        /yruhQ2Tg8O09pPLmNqDAN+y54m1iIDlhiDJnO+ccVK12iC3ht4JPCdKHN8sfSA4
        INikYp2Rf36bGXFyV8DzxbgU7HIfTF4YLID2qgc7cL1ELunUTDbu43yAZf6o2jmj
        Qd9MfrlBcoTL2cQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DAE501301C9;
        Wed,  4 Aug 2021 13:06:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 28CA31301C8;
        Wed,  4 Aug 2021 13:06:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     git@vger.kernel.org, rn+git@sigpipe.cz
Subject: Re: [PATCH v2] clone: Allow combining --bare and --origin
References: <xmqqv94mtdyj.fsf@gitster.g>
        <20210804133010.25855-1-oystwa@gmail.com>
Date:   Wed, 04 Aug 2021 10:06:31 -0700
In-Reply-To: <20210804133010.25855-1-oystwa@gmail.com> (=?utf-8?Q?=22?=
 =?utf-8?Q?=C3=98ystein?= Walle"'s
        message of "Wed, 4 Aug 2021 15:30:10 +0200")
Message-ID: <xmqqbl6dqgvc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 51AE4F32-F546-11EB-826F-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=98ystein Walle <oystwa@gmail.com> writes:

> Hi again,
>
> Thanks for accepting the patch.
>
>> It is somewhat unfortunate that we do not say what the name of the
>> "origin" is anywhere in the resulting configuration file.  The only
>> way to tell that "--origin somewhere" was used is to notice that there
>> is only one remote and its name is "somewhere".
>
> This reads as self-contradictory to me. The word "origin" is nowhere in
> the configuration file, that's true. But that's because the user chose
> it to be that way, and the name the user chose is in the there.

In other words, if there were two remotes in the configuration file,
you cannot tell which one was given to --origin when you made the
repository with "git clone".

> The reason I see it as self-contradictory is that I see two different
> usages of the word "origin" in your email:
>
>  1. A *term* meaning the repository that was cloned (e.g. 'name of the
>  "origin"', remote.originName)
>
>  2. The *name* of a remote ('there is only one remote and its name is
>  [not "origin"]')
>
> Seems you are aware since you write it in quotes :-)=20

May be but #1 is not all that interesting. =20

I meant the only one thing.  The user told Git that 'somewhere' is
the word, not 'origin' that is used by those who use the default
configuration, will be used to refer to the remote the repository
was cloned from.  In the first paragraph you quoted, I was referring
to the fact that the knowledge will be lost once you did "git remote
add elsewhere".

We cannot tell between 'somewhere' and 'elsewhere', which one is
what those who use the default configuration would refer to
'origin'---presumably, 'somewhere' being the --origin's argument
when "git clone" was run, has some significance over 'elsewhere' in
the user's mind, even after the latter is added to the repository.

But we'd end up treating them the same.  And something like
remote.originName would help that.  Otherwise, we'd end up sending
this message:

    Even if we give "--bare --origin yourfavouritename" to you now,
    unlike how 'origin' is treated in the default case, in the
    resulting repository, 'yourfavouritename' is not special at all.

Some people may want to treat yourfavouritename is not special at
all, while some people may want to treat yourfavouritename truly as
a replacement for 'origin' that is the default.  The message we
would be sending is that we'd ignore the latter folks.

