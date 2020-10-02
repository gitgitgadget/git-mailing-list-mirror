Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E7EC4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 16:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9575D2085B
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 16:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gOo8O9DI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388158AbgJBQco (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 12:32:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59810 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387768AbgJBQco (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 12:32:44 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A434E99B5;
        Fri,  2 Oct 2020 12:32:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2n6EHmVWss73uz1L+xNSLWymoG4=; b=gOo8O9
        DIho1Nd5S5s19w9wRi0sK/Cec2iB5/Zx+goSFaKIQ8F5bs4lq1tWghemmyAPWVZf
        +3MwjCilPopIVqV3ksOZUmYCLyr0oUI+VNk6R656tEd7coE4Vk0IADwCVhTskE3X
        ecrSED9qKGa9UgqXUc9JTJ5G3yq1Gk+2oqE+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=INhBXOdI6q8MiGC3dpS4QY+sj5TxmKWC
        PKn3KfeH77MTyJuIjz6KLSsJwsB6kUpa+vcZdS5I6yZncPzavv7C2KeLi/yDnz1P
        WuejeA6KmeZRqg8L7Khn2ask+//dcu2aBC7bjGhbsEPmtawj9KRnn0I7Zxl+Quc0
        6RuQdWK+kkc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 22CCAE99B4;
        Fri,  2 Oct 2020 12:32:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5CA13E99B3;
        Fri,  2 Oct 2020 12:32:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Nikita Leonov via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nikita Leonov <nykyta.leonov@gmail.com>
Subject: Re: [PATCH v2 1/3] credential.c: fix credential reading with
 regards to CR/LF
References: <pull.710.git.git.1581688196706.gitgitgadget@gmail.com>
        <pull.710.v2.git.git.1601293224.gitgitgadget@gmail.com>
        <27f6400a21412d762b290a34a78ebe7296d36bf3.1601293224.git.gitgitgadget@gmail.com>
        <20200929004220.GC898702@coredump.intra.peff.net>
        <nycvar.QRO.7.76.6.2010021011540.50@tvgsbejvaqbjf.bet>
Date:   Fri, 02 Oct 2020 09:32:37 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2010021011540.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 2 Oct 2020 13:37:23 +0200 (CEST)")
Message-ID: <xmqqk0w8a8re.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E30BC06A-04CC-11EB-BE2B-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Therefore, I spent some time pouring over the commit message. This is my
> current version:
>
>     credential: treat CR/LF as line endings in the credential protocol
>
>     This fix makes using Git credentials more friendly to Windows users: it
>     allows a credential helper to communicate using CR/LF line endings ("DOS
>     line endings" commonly found on Windows) instead of LF-only line endings
>     ("Unix line endings").
>
>     Note that this changes the behavior a bit: if a credential helper
>     produces, say, a password with a trailing Carriage Return character,
>     that will now be culled even when the rest of the lines end only in Line
>     Feed characters, indicating that the Carriage Return was not meant to be
>     part of the line ending.
>
>     In practice, it seems _very_ unlikely that something like this happens.
>     Passwords usually need to consist of non-control characters, URLs need
>     to have special characters URL-encoded, and user names, well, are names.
>
>     So let's change the credential machinery to accept both CR/LF and LF
>     line endings.
>
>     While we do this for the credential helper protocol, we do _not_ do
>     adjust `git credential-cache--daemon` (which won't work on Windows,
>     anyway, because it requires Unix sockets) nor `git credential-store`
>     (which writes the file `~/.git-credentials` which we consider an
>     implementation detail that should be opaque to the user, read: we do
>     expect users _not_ to edit this file manually).
>
> What do you think?

I am not Peff, but I was also drawn into the same confusion by the
"we never see an empty line" red herring.  

There are some micronits, but the above made a lot easier to
understand (I think you could even add "quit\r" bit to make it even
easier to understand) than the original description.

Thanks.
