Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389BEC63697
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 23:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0348520724
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 23:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lsUXO8a0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgKWXcn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 18:32:43 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54870 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgKWXcm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 18:32:42 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C4FC110A7FA;
        Mon, 23 Nov 2020 18:32:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nRXkj1QrSEQQVA2RNNOzOX81EWQ=; b=lsUXO8
        a0GYTA8pyOlTYMPs+7g27PEvdNXOkcojTqdtaXuIbm3uSJXC3I5Z5OeCjAO6iQuw
        UBPF1qzUpUHjrkKpN0Pr/vONexvPeqWJdX3AGAOWHKxa5drkb6djyVtj0XYXshCK
        XjKanPjrLgS7SsEHKII9vdHduvlLNzrwBMimk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xzzFobGNlzhcpA5KOqZBuuLc7TTYyQqS
        QDKx8okCHp7Qzj1gIk7BOUmO30lNwj6180PDwy/87LARDZYGjAJchxnd6oGl/O9n
        Vu/aCRt8/lGZFny+E9mN9yULgN1XCBSyygz4mqK5GnIXN72+H6sieXK3WOH/3jLc
        9V+qeuZgvDQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A9F2C10A7F9;
        Mon, 23 Nov 2020 18:32:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EF09310A7F8;
        Mon, 23 Nov 2020 18:32:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git <git@vger.kernel.org>,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>, Jeff King <peff@peff.net>,
        Andreas Krey <a.krey@gmx.de>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        Philip Oakley <philipoakley@iee.email>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v7 1/1] pull: add ff-only option
References: <20201123224621.2573159-1-felipe.contreras@gmail.com>
        <20201123224621.2573159-2-felipe.contreras@gmail.com>
        <CAMP44s2FRZUvUy+F3banxd9MEdL=RMqEdJL3JLYEGDQkOz3vNA@mail.gmail.com>
        <CAMMLpeR8_fshsaqSF6idOY-KyFw2+AK_5683a-7wDXhsO=iFVQ@mail.gmail.com>
Date:   Mon, 23 Nov 2020 15:32:36 -0800
In-Reply-To: <CAMMLpeR8_fshsaqSF6idOY-KyFw2+AK_5683a-7wDXhsO=iFVQ@mail.gmail.com>
        (Alex Henrie's message of "Mon, 23 Nov 2020 16:22:28 -0700")
Message-ID: <xmqqim9vlkdn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C101BEA-2DE4-11EB-A84F-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> On Mon, Nov 23, 2020 at 3:46 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>>
>> This patch leaves everything in place to enable this new mode, but it
>> only gets enabled if the user specifically configures it;
>>
>>   pull.rebase = ff-only.
>
> Why not use the existing pull.ff=only option instead of adding a new one?

If you have pull.rebase=false, "git -c pull.ff=only pull" would fail
as desired upon a non-fast-forward.  But if you have
pull.rebase=true, does it fail the same way (not a rhetorical
question; I didn't try)?  If so, I agree we do not need a new one.

Otherwise, I am on two minds.

Having just a single variable would be easier to manage, so
pull.rebase=ff-only that is equivalent to pull.ff=only might be
claimed to be UI improvement.

On the other hand, it looks quite funny for that single variable
that controls the way how pull works, whether rebase or merge is
used, is pull.REBASE.


