Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA1DC433E0
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 23:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D9C064EFA
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 23:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhBZX1q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 18:27:46 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57589 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhBZX1q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 18:27:46 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E94C3125D37;
        Fri, 26 Feb 2021 18:27:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fY4fXxHaV3+8
        DMoG7xN0P6ptT0g=; b=WiuRb2dTqEUIPxTUeL10aNtvaC7tPY6DBzSgUsVFy0Vl
        Z0fruS12yg2YvigfgCjhKMgeqt9OeaWzk9O/p/METcgPyVH6iH97cB9OzNG1MO5O
        q8Ki+TZ0l1h0eCbtZPoCDblctZVIZsyfI/6J+/zzA0r/8R1qtDKY2yKIvZYeP2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rlJESn
        iwD7nQLqvb89KOsTzZsK3AA2E1zT3sRwHmfBC3aGEpfLJNb213d390cCN0xFxp9N
        GOExb8XyoKmvpBQz19W6fIGWyDn28w1RsaFLz7yAG/EtLQo/clbvc1ZZfQj+Nk66
        kP/ppR2Xom/VdktVT0cvco1V6GD1rHz96YfIY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E17AA125D36;
        Fri, 26 Feb 2021 18:27:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 32D9A125D35;
        Fri, 26 Feb 2021 18:27:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Pathspec does not accept / does not warn for specific pathspecs
References: <CAHMHMxVc8Q1waPQbec-UUN9jcEUgtXOdHymAKigtNj+tc=Wwvg@mail.gmail.com>
Date:   Fri, 26 Feb 2021 15:27:01 -0800
In-Reply-To: <CAHMHMxVc8Q1waPQbec-UUN9jcEUgtXOdHymAKigtNj+tc=Wwvg@mail.gmail.com>
        (=?utf-8?B?Is6jz4TOsc+Nz4HOv8+CIM6dz4TOrc69z4TOv8+CIidz?= message of "Fri,
 26 Feb 2021 22:44:19
        +0200")
Message-ID: <xmqqft1iquka.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 21C3E2A2-788A-11EB-A668-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82 =CE=9D=CF=84=CE=AD=CE=BD=CF=84=
=CE=BF=CF=82  <stdedos@gmail.com> writes:

> git archive HEAD -o p.zip --prefix=3Dp/ -- ':!(glob)**/.gitignore'
>
> Which lead to **both of the  .gitignores** to be included. And then I
> was baffled.
> Now I know (I guess) that the pathspec magic was `:!`, and I tried to
> match against a `(glob)**/.gitignore`, i.e. `(glob)*/.gitignore`,
> which, of course, it doesn't exist in any form.

You correctly guessed.

The section on pathspec in "git help glossary" may need to be
clarified so that ":!(exclude,glob)" is the right way to spell what
you meant, I think.

> And I wonder:
> Why doesn't `git archive ... -- ` understand `:!.gitignore` as a
> .gitignore file would do (minus the `:`)?

At this point, asking "why" is fruitless.  They are spelled
differently, because pathspecs and .gitignore patterns are simply
different.

> Is there some reason that `git archive ... -- ` doesn't understand
> `:!(glob)**/.gitignore`? It doesn't sound awfully complicated, or
> risking a lot of regression (a folder starting with `(`, and
> containing valid pathspec long forms IMHO is rare),

It was probably OK back in 2006 when the number of users and
projects that are using Git were smaller, but these days, whatever
anybody would think "rare" are used by somebody and it would hurt
many people (in absolute terms---they may be a tiny minority of the
population) if you make a backward incompatible change that breaks
these "rare" cases.

> Is there some reason that `git archive ... -- ` doesn't warn me that
> `:!(glob)**/.gitignore` is invalid (and maybe I meant
> `(exclude,glob)`)?

This one does have merit.  Patches are very much welcomed.

Thanks.
