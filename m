Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3EFC4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 12:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85A3D60F01
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 12:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238693AbhG3MEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 08:04:55 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:36645 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbhG3MEz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 08:04:55 -0400
Received: by mail-qk1-f173.google.com with SMTP id b20so9143319qkj.3
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 05:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z69NgHmCF5PDTU+Z9UovWTaDwi+Ak9KL62r6fMXEilU=;
        b=gOV2vzK3EwE9/6Bh6QzNMAkisfGeTIHlERpp6zdTS0P63rabdcHWVj059Vn25IuJ3f
         aMPv/duBo+K7U7YDO1SlIGsV30HRNudJM/EohH+JNn8wmOtqC5ZZRDFPqEzYDULe7cIW
         DyiCT1lSQwfUsj3E7PqHN9ChAJh2XR3YCZP3vrp53z1Br6UNHlwKwgHzcWp8fY9ST0Wj
         NsyYOTm/daderx0EftM7AxEn4SxSfHyOefDmzDjJTHEZg/dnbXrFUmJrcdFfwzqzKuXz
         8ATWarLzORo59lxNzvrJxpZcL8IgmwcNb94FV4Xp1aEo35ceBDeAokY7K1ZxSZps0PEh
         3BDA==
X-Gm-Message-State: AOAM533HTRj25CxH2SGozadG2HxwCa/z2+WjdWijBpqTwUOCElkOCi3R
        S9Ag0yUzuTjEt8agegMVU7JfHgYriTU=
X-Google-Smtp-Source: ABdhPJw3f09TmlqTJnhI5YiaadsnwsmqfWb/TBzxhuLG0FL8zEkU1OALhjodNg306KhXj5jPT+BONg==
X-Received: by 2002:a37:45c9:: with SMTP id s192mr2001055qka.21.1627646689282;
        Fri, 30 Jul 2021 05:04:49 -0700 (PDT)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com. [209.85.222.170])
        by smtp.gmail.com with ESMTPSA id z9sm537598qtn.54.2021.07.30.05.04.48
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 05:04:49 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id k7so9108178qki.11
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 05:04:48 -0700 (PDT)
X-Received: by 2002:ae9:ef10:: with SMTP id d16mr1998090qkg.264.1627646688781;
 Fri, 30 Jul 2021 05:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210706210317.706313-1-me@avishay.dev>
In-Reply-To: <20210706210317.706313-1-me@avishay.dev>
From:   Avishay Matayev <me@avishay.dev>
Date:   Fri, 30 Jul 2021 15:04:37 +0300
X-Gmail-Original-Message-ID: <CAJ-0OszP86LBkDr2oKS0NyOm+8fK8kbx+fBZaQFcAuj7KsL8Jg@mail.gmail.com>
Message-ID: <CAJ-0OszP86LBkDr2oKS0NyOm+8fK8kbx+fBZaQFcAuj7KsL8Jg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Override isatty with GIT_FORCE_TTY
To:     git@vger.kernel.org
Cc:     code@tpope.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 7 Jul 2021 at 00:03, Avishay Matayev <me@avishay.dev> wrote:
>
> This is the resulting patch series from the discussion in the mailing list[1]
> and the Fugitive github issue[2].
>
> The goal is to allow to override git decisiveness about not doing
> something when some fd is not a pty, which can hinder Fugitive.
>
> I didn't annotate the location of the commits as I wasn't sure what was
> the correct one.. As it is not specific to a single mechanisms, but
> rather it is something global, is it fine as it is or should I use
> something as `global, `tree:` or `tree-wide:`?
>
> I also didn't document this feature, or at least I wasn't sure where
> to document it (other than on these commits), I would compare it to the
> GIT_SMART_HTTP as it is something pretty niche and it isn't (and IMO
> shouldn't be) documented to the regular user.
>
> Thank you,
> Avishay
>
> 1. https://lore.kernel.org/git/CAJ-0OswsrnAuCwU6U=S2i1qKkg=66U-8RHSGqD2kh9T_30Yw9w@mail.gmail.com/
> 2. https://github.com/tpope/vim-fugitive/issues/1772
>
> Avishay Matayev (3):
>   Change isatty's parameter to a *_FILENO define
>   Allow isatty to be overriden with GIT_FORCE_TTY
>   Add tests for GIT_FORCE_TTY
>
>  builtin/am.c               |  2 +-
>  builtin/bisect--helper.c   |  4 ++--
>  builtin/blame.c            |  2 +-
>  builtin/bundle.c           |  2 +-
>  builtin/checkout.c         |  2 +-
>  builtin/commit-graph.c     |  4 ++--
>  builtin/commit.c           |  2 +-
>  builtin/fsck.c             |  2 +-
>  builtin/gc.c               |  2 +-
>  builtin/log.c              |  2 +-
>  builtin/merge.c            |  4 ++--
>  builtin/multi-pack-index.c |  2 +-
>  builtin/pack-objects.c     |  2 +-
>  builtin/pack-redundant.c   |  2 +-
>  builtin/prune-packed.c     |  2 +-
>  builtin/prune.c            |  2 +-
>  builtin/rebase.c           |  2 +-
>  builtin/repack.c           |  2 +-
>  builtin/send-pack.c        |  2 +-
>  builtin/shortlog.c         |  4 ++--
>  builtin/sparse-checkout.c  |  2 +-
>  builtin/unpack-objects.c   |  2 +-
>  cache.h                    |  3 +++
>  color.c                    |  2 +-
>  column.c                   |  2 +-
>  compat/mingw.c             |  6 +++---
>  compat/mingw.h             |  2 +-
>  compat/winansi.c           | 16 ++++++++--------
>  config.c                   |  5 +++++
>  date.c                     |  2 +-
>  editor.c                   |  2 +-
>  pager.c                    |  4 ++--
>  preload-index.c            |  2 +-
>  read-cache.c               |  2 +-
>  remote-curl.c              |  2 +-
>  sequencer.c                |  4 ++--
>  sideband.c                 |  2 +-
>  t/t9904-git-force-tty.sh   | 38 ++++++++++++++++++++++++++++++++++++++
>  transport.c                |  6 +++---
>  transport.h                |  2 +-
>  wt-status.c                |  2 +-
>  41 files changed, 101 insertions(+), 55 deletions(-)
>  create mode 100755 t/t9904-git-force-tty.sh
>
> --
> 2.25.1
>
Bumping this thread, I'll appreciate any constructive feedback.
