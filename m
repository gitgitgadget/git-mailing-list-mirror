Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49294C433EF
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 05:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B8561181
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 05:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236718AbhJPFYv convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 16 Oct 2021 01:24:51 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:39720 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhJPFYv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 01:24:51 -0400
Received: by mail-ed1-f53.google.com with SMTP id ec8so46444553edb.6
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 22:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R6gQU6Eqf0xdPngTxGFCYyYbixqS3qkHWUb+4HTDe/4=;
        b=cI/usLbNsMCICTFifoZtN2NEStBXi7JG6jPiOMg0yExN02Qd+HNoD9j+PNJqjj7UP4
         hR6LZI5Fn1B4FewhSq91aF5bdWxQqLWVWDFyQao+PjH5vn6E/j7UlOIlzLKh08vIvyH6
         YO8H5PPCduREr7kzD+T/wAw1oY4C2db2Aq8IWTU5lARV1u5EvTCxZwlqfsBQR6Z5nlWT
         kPv446HjbmOa8q1TKISMvasOudoAYS69py3NTWXdcXjx9jLZUN3lZeycupcWQgtQYyDe
         5n7+xkGsuCqwFRHmmzGq7c1v9uooluRjsKUeQb7NzELnh1mBciyDzVOsXda4DMKKBp49
         048g==
X-Gm-Message-State: AOAM532dcyYsA//Zh2K0DS0S3cW+7vA+jQSJgAZk23MkoO5t5/O0YP7V
        EjR0cV56+zwDQUfMqNkpxEzNzVLe7qv9MuXNqYKY6Spay7A=
X-Google-Smtp-Source: ABdhPJwTVt/r0Og6YhCI91M3dSsTx5Zh8/duESDb5iDReWmCNDp0y41LElB9h9H4HRJI9hY/gAj5gl7QdCubcsq+v5o=
X-Received: by 2002:a17:906:b19:: with SMTP id u25mr11766348ejg.36.1634361762656;
 Fri, 15 Oct 2021 22:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com> <xmqqbl3p4wgz.fsf@gitster.g>
In-Reply-To: <xmqqbl3p4wgz.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 16 Oct 2021 01:22:31 -0400
Message-ID: <CAPig+cSUFE7zXo25iSpwYA7QAine+-6xfCVBSb3DupdyoDw1WQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] hook.[ch]: new library to run hooks + simple
 hook conversion
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 15, 2021 at 8:58 PM Junio C Hamano <gitster@pobox.com> wrote:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> > Part 2 of the greater configurable hook saga, starting by converting
> > some existing simple hooks to the new hook.[ch] library and "git hook
> > run" utility.
>
> This, when merged to 'seen', seems to fail so many tests to make me
> question my sanity.  Something is not playing with it well.
>
> Queued on top of a merge of ab/config-based-hooks-1 into 'master';
> when tested alone, without any other topics in 'seen', it seems to
> fare much better.  Only t2400-worktree-add.sh fails at 58-59 and 62.

For what it's worth, `git worktree add` is special in that it has to
run the `post-checkout` hook in the newly-created worktree, not in the
worktree in which the `git worktree add` command was issued.
