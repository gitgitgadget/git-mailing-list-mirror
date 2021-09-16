Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DBFC433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B9C7610D1
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhIPTZP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 15:25:15 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60341 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhIPTZP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 15:25:15 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1727314F801;
        Thu, 16 Sep 2021 15:23:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qeHutBrB1XUr
        dpFNv3ilwYT9jd3gyNmLwF0vpw1z8wM=; b=jb8f8k9AkpG5usHE31l4i+1WeaFL
        c+o3jWdBfkJypJcdDQNS9TP9PzWIeBWfSDvb6R/giTMsAbyPPdwH7Hjk6K0WttZM
        +6D8a3wCMlUpDNOFLR5gfk6FHwYLsrJxFbHCKSf3+wFTqj2WYHO0WltqzazM0X63
        54hgF7F0rLG/6jA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0D4A714F7FF;
        Thu, 16 Sep 2021 15:23:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0F87F14F7F6;
        Thu, 16 Sep 2021 15:23:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        Carlo Arenas <carenas@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, felipe.contreras@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH v3] make: add INSTALL_STRIP option variable
References: <20210902121104.14778-1-bagasdotme@gmail.com>
        <87a6kchlqc.fsf@evledraar.gmail.com>
Date:   Thu, 16 Sep 2021 12:23:49 -0700
In-Reply-To: <87a6kchlqc.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 16 Sep 2021 11:50:30 +0200")
Message-ID: <xmqqlf3wtjcq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9F9CD8FE-1723-11EC-9EA7-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I think the suggestion in
> https://lore.kernel.org/git/xmqqo89cqkt9.fsf@gitster.g/ is to make this
> a boolean variable, and in any case I think that makes more sense here,

I do not think I ever suggested to use a boolean in that message nor
in the other message in thread.  A boolean may convey the wish of
the users to cause the binaries installed in a stripped form, but
does not allow them to express how to do so on their particular
platform (e.g. where is "strip" installed? how to tell "install"
to strip?).

> since....
> ...
> ...this really is not an INSTALL_STRIP but (using some combination of
> your own naming) a "INSTALL_XPROGRAMS_OPTS" or "INSTALL_XOPTS". I.e. yo=
u
> can supply arbitrary options to "install" with this, but only for
> binaries.

INSTALL_STRIP_OPTS is a perfectly fine name for this thing. =20

It should not say XPROGRAMS but should say STRIP to express the
intent, i.e. why we have it, not what we do with it.  The fact that
it wants to apply to binaries and not to scripts is an
implementation detail.

Of course, when you want to "affect" only binaries but not scripts,
even if the effect you are trying to cause on them is _not_ "strip",
you could abuse the option, but the name must make it clear that
such a use is an abuse.  By naming the variable with STRIP in its
name, we reserve the right to change to which instance of $(INSTALL)
the option is applied to to better implement the goal to "strip
while installing", which might not be a simple "binaries get it,
scripts don't" we currently have, and it will be clear to those who
have been abusing the option to affect "only binaries and not
scripts" that they have no right to complain.

HTH.
