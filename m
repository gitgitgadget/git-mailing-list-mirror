Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 718051FF6D
	for <e@80x24.org>; Wed, 21 Dec 2016 18:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756940AbcLUSp0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 13:45:26 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59188 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755809AbcLUSpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 13:45:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6EFB858B8D;
        Wed, 21 Dec 2016 13:45:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4PNy59xfUo4hoJiHyeMZp/4w54Q=; b=goT3r4
        +zX4VS2ZMyFEG7ayCfjrui5aGHVOcjimLjWlTv/5r6T3G3mRogTnBkdKUeYssLLL
        9u4xcNoNZffgm+XnrnDHOme3edwbM5ArcRA5CgnS1TJJCenikHXoKR9JSPqqbSsk
        LkVCWYtWevxcpET3UHXyVX7fJiEtDZhGbLVeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PrhUPIn766HfWLDuIoZJ4+0RS8/vwvBr
        zhhG/frG9qOx4MnowrTbBO6gYZail1cL+rlEO1eDOCQmCk1hKHD20Vq716XoayHm
        oRi4B23ZWvbG4yus2fGHwMzWcJo736Uy4oX1JUnjeyKsq0tEkllZydGYfW3vYJ2M
        NguGPank8dw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 66B9058B8C;
        Wed, 21 Dec 2016 13:45:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CA25858B8B;
        Wed, 21 Dec 2016 13:45:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/2] mingw: replace isatty() hack
References: <cover.1482342791.git.johannes.schindelin@gmx.de>
        <18174f0a7fbb4a0ccd8ca8380e00161826166a32.1482342791.git.johannes.schindelin@gmx.de>
Date:   Wed, 21 Dec 2016 10:45:22 -0800
In-Reply-To: <18174f0a7fbb4a0ccd8ca8380e00161826166a32.1482342791.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Wed, 21 Dec 2016 18:53:43 +0100
        (CET)")
Message-ID: <xmqqpokli0jh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A1CA5126-C7AD-11E6-B250-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> For over a year, Git for Windows has carried a patch that detects the
> MSYS2 pseudo ttys used by Git for Windows' default Git Bash (i.e. a
> terminal that is not backed by a Win32 Console).
>
> This patch accesses internals that of a previous MSVC runtime that is no
> longer valid in newer versions, therefore we needed a replacement for
> that hack in order to be able to compile Git using recent Microsoft
> Visual C++.

Sorry, but I cannot parse the early part of the first sentence of
the second paragraph before the comma; I am especially having
trouble around the first "that".

> This patch back-ports that patch and makes even the MINGW (i.e.
> GCC-compiled) Git use it.
>
> As a side effect (which was the reason for the back-port), this patch
> also fixes the previous misguided attempt to intercept isatty() so that
> it handles character devices (such as /dev/null) as Git expects it.

I had to read the above three times to understand which patches
three instances of "This patch" and one instance of "that patch"
refer to.  I wish it were easier to read, but I think I got them all
right [*1*] after re-reading, and the story made sense to me.

> +static int fd_is_interactive[3] = { 0, 0, 0 };
> +#define FD_CONSOLE 0x1
> +#define FD_SWAPPED 0x2
> +#define FD_MSYS    0x4
>  
>  /*
>   ANSI codes used by git: m, K
> @@ -105,6 +108,9 @@ static int is_console(int fd)
>  	} else if (!GetConsoleScreenBufferInfo(hcon, &sbi))
>  		return 0;
>  
> +	if (fd >=0 && fd <= 2)

Style: if (fd >= 0 && fd <= 2)

> +/* Wrapper for isatty().  Most calls in the main git code

Style: /*
	* multi-line comment block begins with slash-asterisk
        * and ends with asterisk-slash without anything else on
	* the line.
	*/

> + * call isatty(1 or 2) to see if the instance is interactive
> + * and should: be colored, show progress, paginate output.
> + * We lie and give results for what the descriptor WAS at
> + * startup (and ignore any pipe redirection we internally
> + * do).
> + */
> +#undef isatty
>  int winansi_isatty(int fd)
>  {
> +	if (fd >=0 && fd <= 2)

Style: if (fd >= 0 && fd <= 2)

> +		return fd_is_interactive[fd] != 0;
> +	return isatty(fd);
>  }

Thanks.


[Footnote]

*1* What I thought I understood in my own words:

    Git for Windows has carried a patch that depended on internals
    of MSVC runtime, but it does not work correctly with recent MSVC
    runtime.  A replacement was written originally for compiling
    with VC++.  The patch in this message is a backport of that
    replacement, and it also fixes the previous attempt to make
    isatty() work.

