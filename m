Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5C0C05027
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 13:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjBCNqP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 08:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjBCNqL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 08:46:11 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C669E9C5
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 05:45:55 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ml19so15626160ejb.0
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 05:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PWIUoMCCpqSJ+qMj/7JaEnTUiQJY9e2dqIl4aZYTPJI=;
        b=MWvElyZ9K64L/9Cfux+Q9hzsblooeaPQUExDGk56/Dt10wG0wTh98bxuXuN1wQPmWY
         Mq8gH/yAKAnMGhsQ4Sh7K7aq5jq5zsahApMAbTVAvs/xJn61YMxxGDKvvo9qvgxvfGxz
         STz5c9HhUdo4o+q+R4HXD6gZOTIsAb9Lov5kLZc+m2ZAn1vTlfNsWExNzDTylBxK4MDC
         gTO0FEIXXSMv1elDjfmbSqbdsKzKKU5mPDnXb1db5BJElsI/pe9sXpJ4SfXVp2OJyvlA
         dv27NMTXePGTNHnggvdZrDcASF+OfAx+EXHr8YPu1CYQoKI4BhYyqPQFeOZlLNsDt/hG
         Aa3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWIUoMCCpqSJ+qMj/7JaEnTUiQJY9e2dqIl4aZYTPJI=;
        b=m0cU5gGWclLdL9/g0nMj+k45UWAdXIa1HWuMP8rmCcGxblCfeXU8hxBShHFMht3EYb
         irIpGKcCv1kjqQTy7TXIfLTrxuLqj8AWZ9fO+Gmjzfc0d/D7qXOtuQOyrZbV++xd6tRx
         KuxIAsSTC6bvUny9bYTYqF2DKi/5AxHFwZDPzWUn9LrvW6nPAw9jNim0yCesg4crqyfb
         7Y6tb+ePkzkTad25bqk3s1b+xHd22qA2Te0+83U46zfwrtoCKV6YiWzT3shHqq+mcYj9
         Srq23F3BzYX/iVoiqzf2eCg3ERwE3UX2SXHXjwf/4uJcgkv9GsqjTv5S+bap2Z7eltgw
         BePg==
X-Gm-Message-State: AO0yUKXbG4YP1RHM8hEEsfVIUJMTFqkwXduDcIxDg7i/pp8C6sIHztkR
        G1HsZyzLGTAlwnXvQwFN53s=
X-Google-Smtp-Source: AK7set+VyhadR98aJoWmfgsymXtiVU+ND8zn3X1bf8sGOjrzAbnCczRajc2P/lcyPpedJciZYMBDng==
X-Received: by 2002:a17:907:7293:b0:886:ccbb:a610 with SMTP id dt19-20020a170907729300b00886ccbba610mr2405448ejc.12.1675431953696;
        Fri, 03 Feb 2023 05:45:53 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709060ac500b008806a3c22c5sm1398079ejf.25.2023.02.03.05.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 05:45:52 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pNwO0-000DVF-18;
        Fri, 03 Feb 2023 14:45:52 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] .gitattributes: include `text` attribute for eol
 attributes
Date:   Fri, 03 Feb 2023 14:40:13 +0100
References: <20220216115239.uo2ie3flaqo3nf2d@tb-raspi4>
 <20230203125920.751-1-philipoakley@iee.email>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230203125920.751-1-philipoakley@iee.email>
Message-ID: <230203.86k00yc167.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 03 2023, Philip Oakley wrote:

> The standard advice for text file eol endings in the .gitattributes file
> was updated in e28eae3184 (gitattributes: Document the unified "auto"
> handling, 2016-08-26) with a recent clarification in 8c591dbfce (docs:
> correct documentation about eol attribute, 2022-01-11), with a follow
> up comment by the original author in [1] confirming the use of the eol
> attribute in conjunction with the text attribute.
>
> Update Git's .gitattributes file to reflect our own advice.
>
> [1] https://lore.kernel.org/git/?q=%3C20220216115239.uo2ie3flaqo3nf2d%40tb-raspi4%3E.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.email>
> ---
>
> I was catching up on last year's back emails, and had saved those on
> eol and text conversion, and was prompted by Torsten's [1] to check
> my .gitattribute files, only to discover, we aren't providing a good
> example to others. Let's fix that. 

This seems sensible, but if we're taking the churn of changing these
lines maybe it's worth moving or adjusting some of this while-at-it.

In particular:

>  .gitattributes | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/.gitattributes b/.gitattributes
> index b0044cf272..158c3d45c4 100644
> --- a/.gitattributes
> +++ b/.gitattributes
> @@ -1,17 +1,17 @@
>  * whitespace=!indent,trail,space
>  *.[ch] whitespace=indent,trail,space diff=cpp
> -*.sh whitespace=indent,trail,space eol=lf
> -*.perl eol=lf diff=perl
> -*.pl eof=lf diff=perl
> -*.pm eol=lf diff=perl
> -*.py eol=lf diff=python
> -*.bat eol=crlf

We don't have any *.bat in-tree except in compat/vcbuild/. Shouldn't we
just create a compat/vcbuild/.gitattributes? This was added in
https://lore.kernel.org/git/pull.149.v2.git.gitgitgadget@gmail.com/; so
it's for those specific files.

>  CODE_OF_CONDUCT.md -whitespace
> -/Documentation/**/*.txt eol=lf
> -/command-list.txt eol=lf
> -/GIT-VERSION-GEN eol=lf
> -/mergetools/* eol=lf
> -/t/oid-info/* eol=lf
> +/Documentation/**/*.txt text eol=lf

We have a Documentation/.gitattributes, shouldn't we move this
Documentation/ rule there instead?

> +/command-list.txt text eol=lf
> +/GIT-VERSION-GEN text eol=lf
> +/mergetools/* text eol=lf

..maybe we should create a mergetools/.gitattributes & move this there?

> +/t/oid-info/* text eol=lf

Ditto t/.gitattributes and thist/oid-info/ rule.

>  /Documentation/git-merge.txt conflict-marker-size=32
>  /Documentation/gitk.txt conflict-marker-size=32
>  /Documentation/user-manual.txt conflict-marker-size=32

