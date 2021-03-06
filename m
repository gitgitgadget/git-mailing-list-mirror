Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6B1C433DB
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 22:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01A4A650D7
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 22:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhCFWHD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 17:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhCFWGt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 17:06:49 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB74DC06174A
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 14:06:48 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id x78so6858445oix.1
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 14:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gSCQA2HijEZrIuN0WfjE4tQLTkz4VTbqV3NIgFgmrts=;
        b=UaQhTwp3N2N6eWu0DpfqbP0Ef7vzq5HTZgjUafRWZmPpSRpb3+XB0Oqb+6FQQLbcEt
         UTaVM7tMW//DaxOpr0ED/hSst/obZPi+FRhTrpmTBOiD5ckyeHZJhja0jEnUrdBN4G+G
         04krzV7G919lrVRNyfA0KztmGzsiEoQ9acAmPbhL2K6SHKOTN3IVhCg5msd5vnFi+rgR
         J1RVz5MD0pz0NWHOpCP1xWieUePxfhahTpnl6oy3EjyTKOw7dgeo1efigmlTL3ak/vsn
         2hfqHXQmcwg+8vVdW9eMwdU957PuhCoeMMKLLLOOZoNKw2RsdPW9QjVWQUig2lWGSlWz
         677g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gSCQA2HijEZrIuN0WfjE4tQLTkz4VTbqV3NIgFgmrts=;
        b=lzSA5EnfVu+L3yPPSFHtyQSyeuqj+281DzPuYNz9YDyjsyYpDgsTurj7WhdlaYU85g
         y+osk/I0rnpBz/R5e6if0D9Jr6mKVqSnPMZuqtKwaZPefojk9orclBFGRxU6mvB35pJ3
         6rZBOazOgLzJ1DV9sIwjUngpwrYhsSCgrbYKCFIIY53Uza+my33T2F1r4CpJXRZBxPNY
         iEWQUMu2OcHXqKUxRbqVH875iw95jvdJFYR9Fg7NFYVkNj6kw47WbBuLQ826zXUvVYiC
         FgltQ0Aolq/OrwfV1Y3PA1K8O3rAv6GTuEkWbK5uPvt7cvN9D9Rz9nwlRAHk36zJiR/i
         EFNw==
X-Gm-Message-State: AOAM531KywSA+N+xNRRLNJ+6jmphh91a2aHDUnp1aZLwK4C13aU5MVA6
        SLDnHOxj/5eoTfinbA4BrhpYvsI2cy/qtmbufiM=
X-Google-Smtp-Source: ABdhPJy2MQDJqfOgazFZN/kLXTXX6+PA7lEU0OJyGuWgL5nECv4CycvjjtsUkaIeKemlQZ6x8q7OFb6L/e7MGBkGMJw=
X-Received: by 2002:aca:b489:: with SMTP id d131mr6156519oif.39.1615068408371;
 Sat, 06 Mar 2021 14:06:48 -0800 (PST)
MIME-Version: 1.0
References: <1240014568-3675-1-git-send-email-pclouds@gmail.com> <20210306193458.20633-1-avarab@gmail.com>
In-Reply-To: <20210306193458.20633-1-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 6 Mar 2021 14:06:37 -0800
Message-ID: <CABPp-BHTPmW+uwHum7p0PsWbMpM2uGX7CP=KoZ+W3PRzxjQxWw@mail.gmail.com>
Subject: Re: [PATCH 0/7] Move the read_tree() function to its only user
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 6, 2021 at 11:35 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> This is a small cleanup series to remove move the last user of
> read_tree() over to read_tree_recursive(), and while we're at it
> adjust the API of read_tree_fn_t to its current use-case.
>
> I found out after writing this that there had been a FIXME comment
> (never made it into git.git) about this from mid-2009:
> https://lore.kernel.org/git/1240014568-3675-1-git-send-email-pclouds@gmai=
l.com/
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (7):
>   tree.c API: move read_tree() into builtin/ls-files.c
>   ls-files: don't needlessly pass around stage variable
>   ls-files: remove cache juggling + sorting
>   merge-ort: move cmp_cache_name_compare() from tree.c
>   ls-files: refactor read_one_entry_quick() to use a strbuf
>   tree.h API: remove support for starting at prefix !=3D ""
>   tree.h API: remove "stage" parameter from read_tree_recursive()

I read over all 7 patches.  For the most part, they look good.

Some of the wording in the commit message for patch 6 seemed confusing
and could use some touch-ups; it may also be worth documenting when
the code stopped having any callers with a base other than "".

For patch 3 (the actual removal of read_tree()), either I'm
misunderstanding something, or the changes look problematic and
unsafe.  I'm hoping it's the former.
