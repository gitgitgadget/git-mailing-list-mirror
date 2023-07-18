Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8682FEB64DD
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 23:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjGRXNO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jul 2023 19:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjGRXNN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 19:13:13 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311FCA1
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 16:13:09 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B98EE3674A;
        Tue, 18 Jul 2023 19:13:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xkUbXh4bC3EatAhXqbLfC77jPNMHnlxssHh3V8
        16+Jg=; b=rbeDkrNOe68CkanogVbp6KW4r0DlE5KkB89g7FIubO81Nx+lDfEsod
        /HBkrIJhJbrQcpO18hoE9N6dJsU+xJwmncOOBaDhZeaM42N0THIXDP4AVkeBjojx
        a/HIqvyxWq0E1f7jpI1C0tig86KWLlrtcOJ317Das/fMKuK3PBh04=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B212736749;
        Tue, 18 Jul 2023 19:13:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E6E2D36748;
        Tue, 18 Jul 2023 19:13:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Immolo <immoloism@googlemail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Bug Report] Git fails to compile with fortify-headers and LTO
 - error: inlining failed in call to 'always_inline' 'fwrite': function
 body can be overwritten at link time
References: <CAHfWF5n5kk1bYdU4qKTF3n_Ad9BGjwbbmm+0ZQEX=1NZzRiWXA@mail.gmail.com>
Date:   Tue, 18 Jul 2023 16:13:02 -0700
In-Reply-To: <CAHfWF5n5kk1bYdU4qKTF3n_Ad9BGjwbbmm+0ZQEX=1NZzRiWXA@mail.gmail.com>
        (Immolo's message of "Wed, 19 Jul 2023 00:06:50 +0100")
Message-ID: <xmqqcz0oerup.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5BC4AE6-25C0-11EE-90A7-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Immolo <immoloism@googlemail.com> writes:

> /usr/include/fortify/stdio.h: In function 'verify_cache':
> /usr/include/fortify/stdio.h:59:28: error: inlining failed in call to
> 'always_inline' 'fwrite': function body can be overwritten at link
> time
>    59 | _FORTIFY_FN(fwrite) size_t fwrite(const void *__d, size_t __n,
> size_t __m, FILE *__f)
>       |                            ^
> cache-tree.c:175:33: note: called from here
>   175 |                                 fprintf(stderr, "...\n");
>       |                                 ^

It looks like a plain vanilla invocation of fprintf(), unlike from
any random application, a user of the standard C runtime library .
Is this a bug to be reported here, or would it be more valuable and
useful if reported to GCC or Fortify folks, I wonder?

