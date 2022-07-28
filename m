Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2CCC04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 19:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbiG1THm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 15:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiG1THl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 15:07:41 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B655D76474
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 12:07:40 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-31f41584236so29381217b3.5
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 12:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EJTv+N497V6PSflafKze/zdKwiCZ/YDc/cDRH7p4wk8=;
        b=L90AeZHCi8ITDATe172/e4u2SkY27uAWWztMHfSojUulu4HJSyFUU6VcKUtQk5eeVx
         8y/M6A4GoQw8XJqR9Ttvt22WPXQngj2WBuY2aGUMYe2IUTKAvIPlcaug2xdLpkg780IS
         11G6A/GLXGtexFHTfqONrnUPwccEeXAM9l2Ejvx/Ly/Xqb9dJnn1wYAWIugHRH4UAn7h
         ERDJ/y+bOGFvdj1lc8DxKDsfpkZK/dUdG80Ct3kitGzPMj35D7nWPDDIGL0oAKr2qvgQ
         zR7O2GyOn9h+wiOvBsv9B4skurLlCKBDayW1I6HHHWe2/eblsbGb8h1cEhRKLj3J+gQG
         aUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EJTv+N497V6PSflafKze/zdKwiCZ/YDc/cDRH7p4wk8=;
        b=dIZGWOxnfWBUA7gievG2FMldX7sB6fn9uUQnjTXh3AOXpM0CeXumezOo2Oh8zm7HC1
         gZpUoSmkS1blFl47TaUhAAmDyNVLZh1B4QqjKMT7C+BIrG4vsV01EkaOualHd5MbqFM7
         ISKVCtNwS+TwQXuvar9ZfNun6mvmmJ4qkKsntLzqciecj6B5X+kj7esEY8M9BQqWt39D
         qT8vDQBUfsSYLCKpz2YcnJC7m/XV1zHLIOPBIM907ubaibHXHabKatE3VkwGnoOlnqKp
         2jg+qHgaLz/xbfA9kn/kZ+sPaDF4Qw4vVBvFdEQ+Y6KJDAtJAFUVDjUHHw/HWAqeUh4Y
         x0Eg==
X-Gm-Message-State: ACgBeo22CjIzpnF0i7BVkgQ6o2XjybsFCROlaKwisUc89ln8gk+dC9/y
        QkhCMlGyGqd9ZvELesrgIRiCn7C6lhl2Q9woNx0=
X-Google-Smtp-Source: AA6agR6VnvcnozIDOogzqVKq5YFcduvBbv2JcSO7Mahw2yMs3aYOx8qd9yD9ym33HgA64YaG+E/R8pUzer2iA46/zUU=
X-Received: by 2002:a0d:d890:0:b0:31f:3957:2f49 with SMTP id
 a138-20020a0dd890000000b0031f39572f49mr205673ywe.130.1659035259901; Thu, 28
 Jul 2022 12:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220716074055.1786231-1-siddharthasthana31@gmail.com>
 <20220718195102.66321-1-siddharthasthana31@gmail.com> <xmqqpmht3tq1.fsf@gitster.g>
In-Reply-To: <xmqqpmht3tq1.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 28 Jul 2022 21:07:28 +0200
Message-ID: <CAP8UFD0U8hQ+gyN1=7M4oYEhX6=z_1LS4JaLjqdPG52BELRqtg@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Add support for mailmap in cat-file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Siddharth Asthana <siddharthasthana31@gmail.com>,
        git <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 25, 2022 at 8:58 PM Junio C Hamano <gitster@pobox.com> wrote:
> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
>
> > Changes in v6:
> > - The function rewrite_ident_line() returns the difference between the
> >   new and the old length of the ident line. We were not using this
> >   information and instead parsing the buffer again to look for the line
> >   ending. This patch set starts using that information to update the
> >   buf_offset value in commit_rewrite_person().
> > - This patch set also tweaks the commit_rewrite_person() so that it is
> >   easier to understand and avoids unnecessary parsing of the buffer
> >   wherever possible.
> >
> > Siddharth Asthana (4):
> >   revision: improve commit_rewrite_person()
> >   ident: move commit_rewrite_person() to ident.c
> >   ident: rename commit_rewrite_person() to apply_mailmap_to_header()
> >   cat-file: add mailmap support
> >
> >  Documentation/git-cat-file.txt |  6 +++
> >  builtin/cat-file.c             | 43 +++++++++++++++++++-
> >  cache.h                        |  6 +++
> >  ident.c                        | 74 ++++++++++++++++++++++++++++++++++
> >  revision.c                     | 50 ++---------------------
> >  t/t4203-mailmap.sh             | 59 +++++++++++++++++++++++++++
> >  6 files changed, 190 insertions(+), 48 deletions(-)
>
> I haven't seen any comments or objections to this round.  Are people
> happy about it going forward?  I am planning to merge it to 'next'
> and down to 'master' soonish.

I am biased, but I am happy with the current state of this patch
series. During the last versions of this patch series there were only
comments related to the first patch in the series (revision: improve
commit_rewrite_person()). It seems to me that they were all properly
taken into account, and that the code in that patch is now correct and
relatively simple to understand.

Thanks,
Christian.
