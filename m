Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC6FC54FCB
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 22:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EEC420700
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 22:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="I/DA/uas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgDZWc7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Apr 2020 18:32:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51636 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgDZWc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Apr 2020 18:32:58 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EA70CDF33E;
        Sun, 26 Apr 2020 18:32:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ztwjrWjI7iCTmfT4TJjW95bH79Q=; b=I/DA/u
        asdoe3zBkl9fvT2fac/kXxqaUGuAS9UKcpc2+rFUlXEJfv0vxcyF2+ilKrv5VDRk
        Sx96Hu5kBRFyZFxDAPZsmqxqf8syY1qrkP7+2A3BW0/3LzbgPQLTEa9GnVr3yOCd
        IUbxRJn//Fn4H4ZmjsPOGcCt+M1WnCJFqeQ64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o9WqFd+6YSA8+tnRaNbuHjIfqEVpWHVs
        m4PiX4yve/P9GInD34thypFnW3tY1fLVjEE8az0bXBd6gCKWxDifZHgoWTGgVPTA
        xas0EtMO8l21YWxeob/bc6WycJsVAUKv3+mW8ZvLw4XlKOkYbxNL629YWar4je2F
        rCQLmUL/tJQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E2273DF33D;
        Sun, 26 Apr 2020 18:32:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A1329DF33C;
        Sun, 26 Apr 2020 18:32:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Matt Rogers <mattr94@gmail.com>,
        Mateusz =?utf-8?Q?Nowoty=C5=84ski?= <maxmati4@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        bwilliams.eng@gmail.com
Subject: Re: [PATCH] config: use GIT_CONFIG in git config sequence
References: <20200425235716.1822560-1-maxmati4@gmail.com>
        <CAOjrSZs33-CqV5m4wKROYJT8au1hup7bGZWiEaXMV7cU4p-J=Q@mail.gmail.com>
        <ff9a63d4-80e4-8090-c85c-03fd3ab43c55@iee.email>
        <CAOjrSZt7WJy1vv97Rw9MFJyTcB2Ehqq9BjGrXMtV95oB5p53SA@mail.gmail.com>
        <8992c1a7-a638-e823-1cb7-2c8f6b28d486@iee.email>
        <xmqqwo627xsd.fsf@gitster.c.googlers.com>
Date:   Sun, 26 Apr 2020 15:32:51 -0700
In-Reply-To: <xmqqwo627xsd.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 26 Apr 2020 14:16:34 -0700")
Message-ID: <xmqqsggp98to.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE7A906C-880D-11EA-A42A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Philip Oakley <philipoakley@iee.email> writes:
>
>> Mateusz's original problem was with discovery of these env variables,...
>
> I somehow doubt it.  
>
> Certainly, defeating /etc/gitconfig should be a part of the solution
> to the "I want a stable environment to run tests reproducibly,
> without getting affected by random settings the testing user may get
> affected" problem.  It is not enough to defeat $HOME/.gitconfig (and
> its xdg variant).
>
> But I didn't get the feeling that Mateusz was even aware of the need
> ...

After re-reading the patch that started this thread, I suspect the
reason Mateusz did not mention GIT_CONFIG_NOSYSTEM could be because
he was aware of the need to defeat /etc/gitconfig, and was already
using it.  There was no discovery issue---to somebody who would
propose the patch under discussion to solve "I want a stable
environment for testing", /etc/gitconfig was a solved problem.

And unfortunately we do not have GIT_CONFIG_NO_GLOBAL; so there is
nothing to discover there, either X-<.  If we were to add such an
environment, we need to make sure that it is discoverable ;-)

I still think setting up a directory that can be used as a stable
$HOME replacement and pointing at it during the test, while
declining the system-wide one with GIT_CONFIG_NOSYSTEM, is the right
approach for "stable test environment" problem.
