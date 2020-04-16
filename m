Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152C2C2BB55
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 20:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF71A21744
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 20:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yKUVJi9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgDPUIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:08:10 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59469 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgDPUHx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 16:07:53 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4CAEBCEB66;
        Thu, 16 Apr 2020 16:07:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4Q4rvw2hIT8wGG9xBJiYGr/OFDU=; b=yKUVJi
        9mCUUmJDUHJvXnnVfaoRpNvUVUHQ2aYZGBc+VQJZEwEeFuqPNalWg54460oMASyI
        pt3CtT2JwXeNVKWR6twqXRaCpSidMMEd/mSXwQdtxI1Bm9u+TdN7QCqhwpUTJLvv
        wOwIiTmjwl8sDFJIqCBSpWufexJoa6xaHHkR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZUK7ed6TrRLMCjv2iv2K+DyXFe7I2XR0
        D12F334fExCdPqanOPV96ISBt/Vkuadk34JlcrrGjYldMDYoDOp9Lnjv4wQsv1Fz
        XMhJ0vSAbM4+epTMI/w/OwrKp5rv+0kjX9i/At7k20wWML5ESEmYnsIAKaakgsI4
        mbYpSzLllRM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 44504CEB65;
        Thu, 16 Apr 2020 16:07:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 82081CEB61;
        Thu, 16 Apr 2020 16:07:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Greg Hurrell <greg@hurrell.net>,
        Andreas Heiduk <asheiduk@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: git-grep's "-z" option misbehaves in subdirectory
References: <CAOyLvt9=wRfpvGGJqLMi7=wLWu881pOur8c9qNEg+Xqhf8W2ww@mail.gmail.com>
        <CAHd-oW4NK3E2umq9OXXW9TUyLKQwWN4R-b1KKK117tWPc=K7aw@mail.gmail.com>
Date:   Thu, 16 Apr 2020 13:07:43 -0700
In-Reply-To: <CAHd-oW4NK3E2umq9OXXW9TUyLKQwWN4R-b1KKK117tWPc=K7aw@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Thu, 16 Apr 2020 15:59:12
        -0300")
Message-ID: <xmqq1ronyz1s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFE64794-801D-11EA-BA75-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

> Note that, differently from other Git commands, "-z" doesn't affect
> quoting/escaping in git-grep. For example, while git-ls-files' man
> page says:
>
> -z
>       \0 line termination on output **and do not quote filenames**.
>
> The git-grep one only says:
>
> -z, --null
>       Output \0 instead of the character that normally follows a file name.
>
> Indeed, this inconsistency might be a little confusing. The reason for
> it may be ...

Let me lift the need for speculation ;-) It was a simple oversight
when the documentation was writte, and those "add relative with
quoting" were bugs that not many people thought of testing with -z
output mode.  It is unfortunate, but it happens that things fall
into cracks without anybody noticing X-<.

The reason why we quote paths in output from various commands
without -z is to make them machine parseable; there is no reason to
quote if \0 delimiting is used as no paths contain NUL byte in it.

> 1.  Make git-grep more consistent with other Git commands by always
> quoting/escaping unusual pathnames (relative or not), unless "-z" is
> given or core.quotePath is set to "false".

This is the only sensible way forward, I would think.
