Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF581C3DA78
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 15:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjANPOv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 10:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjANPOt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 10:14:49 -0500
Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E650CA6
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 07:14:47 -0800 (PST)
Received: from [10.0.2.15] ([147.147.167.102])
        by smtp with ESMTPA
        id GiF2pGkuxbPhbGiF3p7V7i; Sat, 14 Jan 2023 15:14:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1673709286; bh=Vzi7TFFOFCq7+E46sgtYagdlpXPrldDTWVCkDVXMFCE=;
        h=Date:Subject:From:To:References:In-Reply-To;
        b=FYUqf22Kj04cnJuWlBgVSz7OgExVLVAaDJ2g4pXE8L0+CDGLBMBBBGirUJecFQxNF
         Vkwe95OmUMtxElDSRHaPzI0VXegHk2PihibnF096LP7HqlOVY6jHXazDJZBs3EFGyL
         MXU8GHWN4MUrvafF+1ZRvmgu5wePEKZkXP5cOpAYyeTvrzb84GN3YFFb8pxihxPzba
         zBlvk+2strYCDYvKc+xFSQQFigTbGAV9XqDZGa0z2Enxn/kgMHgIiRg9IXgorI3E/E
         WOh4kelrm0LnsndIz4oOppIr96mesBdHhBVkv3RownRUHTHHGHgoj0oksjzqPKO7Or
         i+dCUtRx69GFw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=U+qBsMnu c=1 sm=1 tr=0 ts=63c2c6e6
 a=O4HnXJxpn4bBnFCb4s/IkQ==:117 a=O4HnXJxpn4bBnFCb4s/IkQ==:17
 a=IkcTkHD0fZMA:10 a=xey63x3kfdnjHwDfML0A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <7498bff0-782f-8c81-5817-ed841f12dbba@ramsayjones.plus.com>
Date:   Sat, 14 Jan 2023 15:14:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] ci: do not die on deprecated-declarations warning
Content-Language: en-GB
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqv8l9n5fj.fsf@gitster.g>
 <11dccdea-0e33-6669-9554-19f064df6010@ramsayjones.plus.com>
In-Reply-To: <11dccdea-0e33-6669-9554-19f064df6010@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfNpOstGOyCMITMGkH0kQLVjGqc/lVa9gFM5wgOB1hC3X7hhA8D7Emo15sGFEw/XK9nDZ552ICduWQozyVFOC0JiPqfNWeK3fm3og4P3ZE7rHDOFXQmW+
 qEXx8FDw2vnuDXFjBtljTmjB0NVvnWOBJxngI9BLwpvCc8JCGqVUsOnlLl+lJ78Ogg238nbAARxhgkg5Gcl2OHNgWqD29x24qQw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 14/01/2023 14:29, Ramsay Jones wrote:
> Hi Junio,
[snip]

> Sorry for not looking into this (and notifying the list) sooner.

Ah, that reminds me...

When I updated to Linux Mint v21.0 (based on latest Ubuntu LTS) last
year, sparse started failing. This was due to a change to the 'regex.h'
header file (the libc6-dev package version was updated from 2.31 to
2.35), where (among other things) the diff looked like:

..

524a525,548
> #ifndef _REGEX_NELTS
> # if (defined __STDC_VERSION__ && 199901L <= __STDC_VERSION__ \
>       && !defined __STDC_NO_VLA__)
> #  define _REGEX_NELTS(n) n
> # else
> #  define _REGEX_NELTS(n)
> # endif
> #endif
> 

..

645c681,682
<                   regmatch_t __pmatch[_Restrict_arr_],
---
>                   regmatch_t __pmatch[_Restrict_arr_
>                                       _REGEX_NELTS (__nmatch)],

..

The last hunk is the declaration of regexec(), thus:

extern int regexec (const regex_t *_Restrict_ __preg,
                    const char *_Restrict_ __String, size_t __nmatch,
                    regmatch_t __pmatch[_Restrict_arr_
                                        _REGEX_NELTS (__nmatch)],
                    int __eflags);

So, sparse falls over on the '__nmatch' as part of the __pmatch
argument declaration. [Actually, it doesn't bomb out on the
declaration, but at each regexec() call site].

To fix my build, I added the following to my config.mak file on linux:

    SPARSE_FLAGS += -D__STDC_NO_VLA__

.. and forgot about it! :)

I need to fix this sometime.

ATB,
Ramsay Jones


