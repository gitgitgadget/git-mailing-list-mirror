Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8974BC433E0
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 21:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 564C264DAD
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 21:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhBGV6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 16:58:02 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:40051 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhBGV6A (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 16:58:00 -0500
Received: by mail-ed1-f53.google.com with SMTP id s3so15945281edi.7
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 13:57:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yYGni6GdunI+dN8CBO8ieW4h45RZgwbLIn8oVBgl+NQ=;
        b=ieQAJq4H5MkzF6U5gYR3zRcxTh+HBldvlaHpqbff7TBZhQ8v/vo1FFA1HQoqXsfIKf
         rxwrhrx3yX77VL9ebkJCB/OY0qcbZhkNEOgJjJBAokyx8Oxe9KC97WrPP2NYsvbub++I
         nJ4WKYwwsEQFxaa856ALqKCvG0GY+32ZYtZIR0b+ad+FTigQK7soyH/EEH6JVxEMKoa6
         t8it88fiAM3VRjd8ZGaof2Gw6bUMMlcBCi0WyyoKFL20yG6neWaE6ggScrj1MJB6h8iW
         X29zmWM3HK94X3city+nw8LoAXLtt94zbEl3b3D5Q/HL2glEN38mFmzP1k/ns2pIytPj
         aE5w==
X-Gm-Message-State: AOAM530Xtj+AHIcnAlxn6FaOIKquROY3eo1z0Q92SED6uPp0sLo/vcDX
        evMPmerym3PtxCmlXYCXPZ7eTmebn5ehyywd+Ztv1+B19F9QHA==
X-Google-Smtp-Source: ABdhPJyUIHzrQAmicBrP9FVVwxWbMhBPcCTJ5DKMaf6vhsxxGOYOq6C3lQDJhuT8fWxVSpgYaSfoBaY1JO7CzzORg/0=
X-Received: by 2002:a05:6402:1914:: with SMTP id e20mr14310117edz.89.1612735038807;
 Sun, 07 Feb 2021 13:57:18 -0800 (PST)
MIME-Version: 1.0
References: <CAKH6PiWS5DvqctFnvZ+uyOzBs75hcy9HzbW_3gUCu+RE+oOYyw@mail.gmail.com>
 <YCAk8Zx8KvZhaJMx@camp.crustytoothpaste.net> <xmqqlfbz927i.fsf@gitster.c.googlers.com>
 <YCAzcs1e08Qnk2wa@coredump.intra.peff.net>
In-Reply-To: <YCAzcs1e08Qnk2wa@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 7 Feb 2021 16:57:07 -0500
Message-ID: <CAPig+cQ=nR7O+uNAufB7ohKN2ZoUP6n1aLbZBz2jeFKMFbaAcA@mail.gmail.com>
Subject: Re: default editor
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        M Douglas McIlroy <m.douglas.mcilroy@dartmouth.edu>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 7, 2021 at 1:38 PM Jeff King <peff@peff.net> wrote:
> The "2l" was bogus (there is no line 2). It seems likely that an
> interactive user might make at least one invalid command while editing.
> Some versions (like GNU ed) have a "-l" option to loosen the exit code.

Cygwin `ed` does support `-l`, so that's helpful, although it still
fails the "test editor" button in the Git-For-Windows installer
program since the installer calls `ed` with a Windows style path
rather than a Unix style path which Cygwin `ed` doesn't understand. It
is possible to skip "test editor" and continue Git-For-Windows
installation without testing. The bigger problem after that, at least
in my testing, is that when `git` from Git-For-Windows itself
eventually launches Cygwin `ed` at commit time, it bombs with:

    0 [main] ed (2444) C:\cygwin64\bin\ed.exe: *** fatal error -
    cygheap base mismatch detected - 0x18034C408/0x180347408.

In fact, Cygwin `ed` crashes with that same problem even just being
launched from the MSYS shell provided by Git-For-Windows due to bad
interaction between the DLL's. On the other hand, Cygwin `ed` launches
just fine from the Cygwin shell as one would expect.

By the way, it's also possible to install Cygwin's Git from the Cygwin
installer rather than attempting to use the Git provided by the
Git-For-Windows project. The combination of Cygwin `ed` and Cygwin
`git` works just fine (in my tests) once you configure `ed` as the Git
editor either by setting GIT_EDITOR or EDITOR environment variables to
`ed -l` or by configuring git itself:

    git config --global --add core.config 'ed -l'

(You would want to uninstall Git-For-Windows, too, if you have it installed.)
