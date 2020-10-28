Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0140C388F7
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A31E9207BC
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iCHONAIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388023AbgJ1XoO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:44:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57159 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389602AbgJ1XoM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 19:44:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 426B28C6B4;
        Wed, 28 Oct 2020 19:44:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DdbTimkrMTBDvizrnnooXnp0/3Q=; b=iCHONA
        IKq2GHib+mwaRog6ub8k7Xb1SF+pqZ1AMzSxAQOb00NgoK23QGvC87mLXZ9OiHbr
        Y+xb6SB08O7Y0+0vODHbP03XPiOyoMUVSGKvqaanMVuBZU0eALgEvlCad3AooKCM
        +oufpqM6YjshNtiZ2eB4YVuGxohkYsuUR/K3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LCT2XphcrVMheXLXoLo7lQP0ue+Fc9Nt
        UbmTtHmGYeeRyMNmcmE7x8rOOdKjXfj3XDT59RITZLUWn/kXesW+NX2xo+noKUwN
        IIlS8C2dUOsVu/zwV34HIIUNggPTcsMgiEO/RsT/NET2p/Av0cZU1yc4dO0KZRz7
        sciNl/fcCdU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 388C08C6B3;
        Wed, 28 Oct 2020 19:44:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 70E318C6B2;
        Wed, 28 Oct 2020 19:44:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Filipp Bakanov <filipp@bakanov.su>
Cc:     git@vger.kernel.org
Subject: Re: Proposal: "unadd" command / alias.
References: <CAAdniQ5pRHKUU77XVmZkZ_gUgfYYFpo9=Xt2T6EgzJ3hoT0YMg@mail.gmail.com>
Date:   Wed, 28 Oct 2020 16:44:08 -0700
In-Reply-To: <CAAdniQ5pRHKUU77XVmZkZ_gUgfYYFpo9=Xt2T6EgzJ3hoT0YMg@mail.gmail.com>
        (Filipp Bakanov's message of "Tue, 27 Oct 2020 23:10:00 +0300")
Message-ID: <xmqqmu059arb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 797AAF16-1977-11EB-BFFC-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Filipp Bakanov <filipp@bakanov.su> writes:

> Hi! I suggest to add "unadd" command, that will undo a git add command.
>
> git unadd path/to/file
>
> It will be an alias to:
>
> git reset HEAD -- path/to/file
>
> The motivation is that I always forget syntax and have to google each
> time I want to undo accidentally added files. Unadd is just much
> easier to remember and quite obvious.

I am not sure if the behaviour of the "git reset HEAD -- path" is
what people would imagine what "unadd" would do, actually.  For
example, with this sequence:

    $ edit file
    $ git add file
    $ edit file
    $ git add file
    $ git unadd file

what would be the natural expectation of users after the last
"unadd" step?  Should it have the result of the first 'add'?  Should
another "git unadd file" bring the index back to the state before
the first 'add' was run?

There is no such ambiguity to "reset HEAD -- path".  It tells
exactly what contents you want to have in the index for the path
(i.e. the same as what is in HEAD).  There is no "go back to the
state before the last add", and there is no false hint that such a
thing might exist.

So, I do not think it is a good idea to even call it "unadd", let
alone adding an alias that is used outside your immediate circle
where you can explain what it exactly means to "unadd" by your
definition.
