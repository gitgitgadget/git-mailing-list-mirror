Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0FFC433DB
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 19:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 463736023B
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 19:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhBTTIP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Feb 2021 14:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhBTTIP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Feb 2021 14:08:15 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EE8C061786
        for <git@vger.kernel.org>; Sat, 20 Feb 2021 11:07:34 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id lu16so22164419ejb.9
        for <git@vger.kernel.org>; Sat, 20 Feb 2021 11:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LCZrNbmpJfJxQK4Gkp5HcoGb3wxk5VaDq4vYfAX/Z1s=;
        b=F52OYrgOrYsksOTCbM8DbUVXORPNYzYyXzeX8lnQC17ikOPCchIxm1dD5cA1cOV4Vv
         7EXh+MPN/ymoVE87C/0RSPkYin5HZY2wVB1SwjCMZbSnJ0SBawXP+2uqBoKMm4ywC08x
         IGrTPu1xnLNAG65JEeTjAOkx8uRBNbETOlYvyEvx0LKxCzP/B/9qnAx14PuS7i8rWdvC
         8lkV3JC6ISIJ1Va0Za2sEmg0FnYslZc3aRNI77UC9myYJfhg8uUZUGhSKyyBAXQ/g1Y7
         LOJbg20Q7oPmxVyv+1wUlWX1myzvClfmeuwm/Tovf5t1TiMTyWm6kV4TpyzychVR+C9i
         8OMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LCZrNbmpJfJxQK4Gkp5HcoGb3wxk5VaDq4vYfAX/Z1s=;
        b=VYJxLTcmOyAmrkDpBvVm340dkBOhF6LTPV8YS7gm/tgSBW81zMlsnqivFvN24qomP4
         Uwec6EJ78z0iDpIRpZ1/OY/V8dGCn81O7p3CnUCaOt53gphkF7xO+7NCVpfCIobYO+6c
         8ywts/7iEaqD6A6+CEF+pPh+XvaQeOOiI1EDqZxrH0fpoGF5p62e1Ac9P+hneja/ylGq
         JUtLIkjXKWyrLqoYUnXPrioqCXjEag6ZmDYN52zMdZUejD0fjtrpAWdRXR5DbR7CPSy9
         vgikR3jBEfHk/GGfIhqeYVxqfblG6xMK8G0Gxhr/iiymjsbOdnMJF4qO+FkPwqk+Nk4x
         1YwA==
X-Gm-Message-State: AOAM531yOrlgMcKwEIfueB9Qtf2m7CAnIPJjXmXSqYgAXoYA1HR+pa5b
        zTjbIn2EkpPex+945yqHBH0GJjW4zSw=
X-Google-Smtp-Source: ABdhPJwPoT88I2nTnyhEYdT3xS/9bPBE7DSAV93PwlkwkzDE7FDYkEI7oxyH1edks7RHt+05DICk8g==
X-Received: by 2002:a17:907:4cf:: with SMTP id vz15mr3612976ejb.39.1613848053073;
        Sat, 20 Feb 2021 11:07:33 -0800 (PST)
Received: from szeder.dev (94-21-146-126.pool.digikabel.hu. [94.21.146.126])
        by smtp.gmail.com with ESMTPSA id w9sm3535551ejb.22.2021.02.20.11.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 11:07:32 -0800 (PST)
Date:   Sat, 20 Feb 2021 20:07:28 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Divyansh Garg <divyansh.gargsg@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSOC] fatal error: curl/curl.h: No such file or directory
Message-ID: <20210220190728.GA3590451@szeder.dev>
References: <CAB=huCZLwkBv-Fd4iUqbDwNuNfeFBfjPfKRzYUGShc727KJJzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB=huCZLwkBv-Fd4iUqbDwNuNfeFBfjPfKRzYUGShc727KJJzg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 20, 2021 at 07:27:32PM +0530, Divyansh Garg wrote:
> Hello,
> I am trying to build the source code on my system (Ubuntu 20.04).
> After cloning the repo, when I proceed with the command: make, I get
> the following error.
> I tried installing curl and searched the internet but couldn't get a fix.
> Please advise, how can I solve this problem.
> 
> divyansh:~/gsoc/git$ make
> make: curl-config: Command not found
>     * new prefix flags
>     CC attr.o
>     CC config.o
>     CC exec-cmd.o
>     CC gettext.o
>     AR libgit.a
>     LINK git-daemon
>     LINK git-http-backend
>     LINK git-imap-send
>     LINK git-sh-i18n--envsubst
>     LINK git-shell
>     CC http.o
> In file included from http.c:2:
> http.h:6:10: fatal error: curl/curl.h: No such file or directory
>     6 | #include <curl/curl.h>
>       |          ^~~~~~~~~~~~~
> compilation terminated.
> make: *** [Makefile:2422: http.o] Error 1

As Torsten said you have to install not only a couple of libraries but
also the related '-dev' package containing includes and static
libraries.

In our CI jobs using Ubuntu we install the following packages by
default (see 'ci/install-dependencies.sh'):

UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
 tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl
 libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl"

