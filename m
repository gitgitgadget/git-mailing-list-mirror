Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55234C5519F
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 14:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3F252222A
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 14:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIkhyRFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgKQOWL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 09:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbgKQOWK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 09:22:10 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE88C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 06:22:08 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id m16so7747275edr.3
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 06:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=1KqdptDJ34qb4hwIcR5t7u4FOyfq36FR76Oz4cQ4pLY=;
        b=LIkhyRFTkf44k1fscEGWQK8qpzaQZ4U7wtWyHruOGIz8Jh+mkC/rHDRjQkYWcylhz7
         vzktwj1IMBwKY/bCJvhADrzQJrGJ6KmbRki4ZL5KyTzA343ZYvdh+Hpc6TFYZJ2EishI
         qLZ3/gGHE4Nuk3AeMoXf9uxsEEUAkUJBBQXeVYmEqpmleBr/Qoo3sWIW7h06EShjW1n7
         6iOF1KVtUo/Glu2yYICLzRqJ2Eb3LIxLWrRytE1dxS0WyyrXb21CErIwW31Cojo0GGu4
         mf8QY4t7kwMgeQa4t5XWN2laWR8NUe91Ae00LF5KXzX67Wt6JUGyN1Skxv/bdds4iuss
         h05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=1KqdptDJ34qb4hwIcR5t7u4FOyfq36FR76Oz4cQ4pLY=;
        b=LQdH9C7xxo4Pvh1N6PEBnx+L7GSSrImia1Qn6Au6C+SFOKN/mUUvqH0zkCqQU3ybHB
         Lqh0oNMBkJ/9/anqP6VBN0rTU4FfjJZUXKP+g/tGSOxsrgzyqS+z2ulf2axUdSp+RjE6
         1hCYqDgafUsLpKT/1lJmWh+wIxFwS1kKRzThzcls5gIkifQFQMxrGlSa0ePU5SD1XXEz
         GdrmdYb+2BCjht756QBNY0WVEJyXDEomGbiVYHDTfN0BJ8d//iUGwOBIm6ThK2OUAm/S
         nRjTYjVanwfN+lN2XXfi79cDKv2Peo7CB8b97dxLBNsW1htJ5Yu9itP7y9Xbg+DTvIaK
         LxjA==
X-Gm-Message-State: AOAM531PEx6dZ/kaZDcqxzSD5xTHbBMCpsBnLeo75Kqwf4jD8Mn5YF3u
        5cS8feIsGCc3kF5NndeCQ2I=
X-Google-Smtp-Source: ABdhPJy8syVaDeX65Ak6USksEC6fF+eyoHqX/6ZnK14W1chxtLS+IunaIvazYLi5P7N7V/t+Nf5A6Q==
X-Received: by 2002:a05:6402:1a58:: with SMTP id bf24mr20300534edb.191.1605622927056;
        Tue, 17 Nov 2020 06:22:07 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id q14sm11865328eds.80.2020.11.17.06.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 06:22:06 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] config: allow specifying config entries via envvar pairs
References: <cover.1605269465.git.ps@pks.im> <44e8dd50c6ea7cbcc5e4fc35c9b9057c0a52038c.1605269465.git.ps@pks.im> <87mtzlflw7.fsf@evledraar.gmail.com> <xmqqy2j1851k.fsf@gitster.c.googlers.com> <20201117023454.GA34754@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <20201117023454.GA34754@coredump.intra.peff.net>
Date:   Tue, 17 Nov 2020 15:22:05 +0100
Message-ID: <873618f4he.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 17 2020, Jeff King wrote:

> On Mon, Nov 16, 2020 at 11:39:35AM -0800, Junio C Hamano wrote:
>
>> >> While not document, it is currently possible to specify config entries
>> >> [in GIT_CONFIG_PARAMETERS]
>> [...]
>>
>> "While not documented" yes, for sure, but we do not document it for
>> a good reason---it is a pure implementation detail between Git
>> process that runs another one as its internal implementation detail.
>
> I have actually been quite tempted to document and promise that it will
> continue to work. Because it really is useful in some instances. The
> thing that has held me back is that the documentation would reveal how
> unforgiving the parser is. ;)
>
> It insists that key/value pairs are shell-quoted as a whole. I think if
> we made it accept a some reasonable inputs:
>
>   - do not require quoting for values that do not need it
>
>   - allow any amount of shell-style single-quoting (whole parameters,
>     just values, etc).
>
>   - do not bother allowing other quoting, like double-quotes with
>     backslashes. However, document backslash and double-quote as
>     meta-characters that must not appear outside of single-quotes, to
>     allow for future expansion.
>
> then I'd feel comfortable making it a public-facing feature. And for
> most cases it would be pretty pleasant to use (and for the unpleasant
> ones, I'm not sure that a little quoting is any worse than the paired
> environment variables found here).

I wonder if something like the git config -z format wouldn't be easier,
with the twist that we'd obviously not support \0. So we'd need an
optional length prefix. : = unspecified.

    :user.name
    Jeff K
    :alias.ci
    commit
    :10:bin.ary
    <10 byte string, might have a \n>
    :other.key
    Other Value

Maybe that's overly fragile, or maybe another format would be better. I
was trying to come up with one where the common case wouldn't require
knowing about shell quoting/unquoting, and where you could still do:

    GIT_CONFIG_PARAMETERS=":my.new\nvalue\n$GIT_CONFIG_PARAMETERS"

Or equivalent, and still just keep $GIT_CONFIG_PARAMETERS as-is to pass
it along.

Your "do not require quoting" accomplishes that, and it's arguably a lot
