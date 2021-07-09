Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E55C07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 19:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB44B600D3
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 19:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhGIT70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 15:59:26 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:42975 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGIT7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 15:59:25 -0400
Received: by mail-qk1-f177.google.com with SMTP id e14so10634631qkl.9
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 12:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D6kJRzKMrJ9yL5DGGxcawZh1sBY6PSm+9ruh3mRgyx8=;
        b=FqgN4fDDGmUyCnNGxUGPlXlyDIWq09wtaJXVsu2tqTKWSKQcudDV72ZSjOadPVdoPz
         c/PZnC6tmj4bp7a24szAiu5SoyoLXAulNZjBQ29Lz2CVzdjOG4ytc85dGwGRcK81Av/K
         00mD2Ysym9WmFuoLaT6yEWLaTDLAuqRuMVIYhquAuOrdN7BHKxl/5A83MGJkpnqSqxZ/
         6rFgZrKk2zX0nbHegSTqyJoO1xTIHEkm8EO1+UBmLdrHYL9g5MCRnMVCh5WWiiuO55NL
         103hr18gEJ9iSl2qt8FP5W3FOtsXwiczKCKjuA9AuB8B9V3upM48JUF/Sc9424SMMIsv
         S2ng==
X-Gm-Message-State: AOAM531DD0BwzGJP1GLZNGGuCnkabE36v1r2f8vCSxdLgZIT3crMd7BN
        3qtrvP0FaLYIWYOObun7jo5N21HN4oKEuQ==
X-Google-Smtp-Source: ABdhPJx0nPrD52Vx/kwYiSfGWYpA/9YsMwD6HK2tBDO9B/NKOrMtr4txekmR98KE3uj1JIiDy8SedQ==
X-Received: by 2002:a37:644f:: with SMTP id y76mr16338362qkb.194.1625860601133;
        Fri, 09 Jul 2021 12:56:41 -0700 (PDT)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id i9sm2186958qtp.50.2021.07.09.12.56.40
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 12:56:40 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id s4so10610741qkm.13
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 12:56:40 -0700 (PDT)
X-Received: by 2002:a37:8bc7:: with SMTP id n190mr39054127qkd.113.1625860600426;
 Fri, 09 Jul 2021 12:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210706210317.706313-1-me@avishay.dev> <20210706210317.706313-3-me@avishay.dev>
 <xmqqbl7fgkvu.fsf@gitster.g> <CAJ-0Osy2RLiZmi9m=W=rpK6Bh5uXk-psO-BTb18a8COrsQANUw@mail.gmail.com>
 <xmqqo8bb769a.fsf@gitster.g> <CAJ-0Osx4A0NaY9f5Z-6_H2rfW-XwyDmW_7+OxKFt7WJaWOixSQ@mail.gmail.com>
 <xmqqfswn72jj.fsf@gitster.g>
In-Reply-To: <xmqqfswn72jj.fsf@gitster.g>
From:   Avishay Matayev <me@avishay.dev>
Date:   Fri, 9 Jul 2021 22:56:28 +0300
X-Gmail-Original-Message-ID: <CAJ-0OsxSXrgQE-Kn-DdbPTVZJ2V9+yiRug5mSyNQ096O+3fYww@mail.gmail.com>
Message-ID: <CAJ-0OsxSXrgQE-Kn-DdbPTVZJ2V9+yiRug5mSyNQ096O+3fYww@mail.gmail.com>
Subject: Re: [PATCH 2/3] Allow isatty to be overriden with GIT_FORCE_TTY
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, code@tpope.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 9 Jul 2021 at 21:41, Junio C Hamano <gitster@pobox.com> wrote:
>
> If we want to force output to always go through the pager, we should
> call it "force pager", not "force tty".  If we want to always show
> progress bar no matter where the output goes, we should call it
> "force progress", not "force tty".  These should be controllable
> independenty, even though it is OK to have catch all "force
> everything" for convenience.
>

But using "force pager" or "force progress" is exactly the same as
acknowledging that git uses tty for the output, as you'd have to know
that the pager wouldn't open because there is no tty. The original
implementation should've been to implement just the "force pager"
logic but we've realised there are more places where git acts in a
different way because of tty and I don't really see a reason those
should be controlled individually, it will just create too many variables
when the reason for their existence is the same, the absence of a tty.

> There is no inherent reason why the output has to be passed through
> the pager when it goes to tty.  It merely is how we happen to have
> designed the heuristics.  We don't want to carve it in stone and
> expose it on end-users with a poorly chosen name.  Also, we do not
> want to tie multiple features unnecessarily.

I mean, git is pretty CLI centered, it isn't a library, so I'd say there is a
pretty strong core reason for this design (at least that's how I see git).
Unfortunately, when we want to use git in its not really CLI-like way, it acts
unexpectedly.

Moreover, I really don't think this feature is intended for the
regular git user,
it will mostly help Fugitive or other programs that are built upon git's core,
and those are most likely have to be familiar with git's implementation in
one way or another.

Avishay
