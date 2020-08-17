Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A24C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 16:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AFD52065C
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 16:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YiHfjREl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387882AbgHQQlV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:41:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50799 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388909AbgHQQkl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 12:40:41 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C0AF183DD3;
        Mon, 17 Aug 2020 12:40:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=OpTwdOTbKCmz
        n8q+DpZavER1r+0=; b=YiHfjRElWNZxtq3jG7p40HXnuru+HThlndnmo2SVg93W
        etGZ/NIEs5f3PgAigd7FYEKaH2ugJw+pyOfv0f4A8/9ucVxexOzkCXDtGjQ+vJej
        nX6LRzGF+sa4bi4O5imwKECTc5e6BIj6D1aeRP4CGr5utJFmrdX/3XJZ50D7Dcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=EU8/39
        CZrfKxVanZg0SymDUB+Cpb5DQBErrRc4Ss80qxgAB14ydixoJ1IVAfhaUdgputuo
        y8ntlmEBXw58l5Ie4aZ1GwlpjO8ujxQLvlZwLgHO7YrPjftCWYatZYKY5/smxlOX
        32WXEARtkh+xr6jWet5uWYTaU8K1Wikf3vYTo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B75E283DD2;
        Mon, 17 Aug 2020 12:40:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2C44A83DD1;
        Mon, 17 Aug 2020 12:40:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Alexander Ost <ost@ieee.org>, Git List <git@vger.kernel.org>
Subject: Re: [BUG] `make install' partly ignores `NO_INSTALL_HARDLINKS'
References: <CAGNCYk3hGWHuSb4vDzrBE54P5y6Sm+TwfVrCfHD0LnLQWSr9nA@mail.gmail.com>
        <CAPig+cQnGUyM2cwNjDm_zys15B9n82QT6-RD7Lgyz1-XSGp8yw@mail.gmail.com>
        <xmqqimdm1ae6.fsf@gitster.c.googlers.com>
        <20200814150214.GC9518@danh.dev>
        <xmqqo8ndxhof.fsf@gitster.c.googlers.com>
        <20200815011544.GB12363@danh.dev>
Date:   Mon, 17 Aug 2020 09:40:23 -0700
In-Reply-To: <20200815011544.GB12363@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcg==?=
 =?utf-8?B?4bqnbiBDw7RuZw==?= Danh"'s
        message of "Sat, 15 Aug 2020 08:15:56 +0700")
Message-ID: <xmqq8sed445k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5916F692-E0A8-11EA-B58A-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> On 2020-08-14 10:26:24-0700, Junio C Hamano <gitster@pobox.com> wrote:
>> > Since both git-citool and git-gui will be installed into same
>> > directory "$(libexecdir)", I think it would make more sense to use:
>> >
>> > 	LN =3D ln -s
>> >
>> > here instead?
>>=20
>> In the top-level Makefile, INSTALL_SYMLINKS make macro does exist,
>> but it is not exported to submakes.  If it were, something like
>>=20
>>     ifdef INSTALL_SYMLINKS
>> 	LN =3D ln -s
>>     else
>>     ifdef NO_INSTALL_HARDLINKS
>> 	LN =3D cp
>>     else
>> 	LN =3D ln
>>     endif
>>     endif
>>=20
>> might become possible, but you'd need to audit what is fed to $(LN)
>> at the locations the macro is used and make necessary adjustment
>> accordingly.  "cp A ../B" or "ln A ../B" will make a usable copy of
>> file A appear inside ../B directory, but "ln -s A ../B" will not,
>> and I didn't see if all uses of $(LN) was to give synonyms to what
>> is already installed, or some of them were truly installing from the
>> build location when I gave the "something along this line" example.
>
> Yes, the top-level Makefile seems to have a special branch for
> BUILT_INS, in which, we will create symlink for those builtin in
> libexecdr if NO_INSTALL_HARDLINKS is defined.

Did you mean pieces like this?

	for p in $(filter $(install_bindir_programs),$(BUILT_INS)); do \
		$(RM) "$$bindir/$$p" && \
		test -n "$(INSTALL_SYMLINKS)" && \
		ln -s "git$X" "$$bindir/$$p" || \
		{ test -z "$(NO_INSTALL_HARDLINKS)" && \
		  ln "$$bindir/git$X" "$$bindir/$$p" 2>/dev/null || \
		  ln -s "git$X" "$$bindir/$$p" 2>/dev/null || \
		  cp "$$bindir/git$X" "$$bindir/$$p" || exit; } \
	done && \

The symlinks happen ONLY when INSTALL_SYMLINKS is asked for.  Not
all filesystems support symbolic links, hardlinks never suffer from
dangling link problem, and often they are cheaper.

> I was aiming for something like this to make git-gui a bit more
> consistent with top-level Git, with or without INSTALL_SYMLINKS
> exported:

So with or without optional INSTALL_SYMLINKS exported, what I gave
you is what is the most consistent with the top-level, that is, if
INSTALL_SYMLINKS is there, we do "ln -s".  Otherwise, we check
NO_INSTALL_HARDLINKS and we do either "ln" or "cp".
