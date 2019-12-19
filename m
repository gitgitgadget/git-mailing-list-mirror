Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42D2C2D0C1
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 14:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C1424679
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 14:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjRJ/8RH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfLSOjd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:39:33 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37420 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfLSOjd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 09:39:33 -0500
Received: by mail-ed1-f66.google.com with SMTP id cy15so5094656edb.4
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 06:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TD2KudD3gGIBiGQtuac9LAoU5tHsrJXWflir8h4/XfU=;
        b=JjRJ/8RHMPDVG8BJlSIX46FFkWE6K7+I3AOQfBuR/4VGvA5bKXdvwrTLHokRd2y1AY
         YyKQPVFETQWyAtdCxyja8rHbGWZCN7Fsw/G6PaIKTz9g6QeINZyse07Y78SGJLBPhqdW
         BwwQDVoe5/9sDrsJl8evWwhYz/hjDIatC4feeQ1t8iaCJ53m/AoYCu9xp0JlDxK0eHxu
         tOBQVCTr89qy4m3qdn9jmVnmpomLDu9C7ut9K3Q2W1To4DIJT0Nv9nyRmeJ74UaC1ogh
         Z8h5Uq7wBE3L2AtMmb9luwIBdEpDg/+wdjRg/dXQGqZplfcA1AmQthOlcghFf3ExhGtb
         aZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TD2KudD3gGIBiGQtuac9LAoU5tHsrJXWflir8h4/XfU=;
        b=TTfouqlY9ju9lNjMguBibf1jcXp3y1Es6mzTqfRF3xXk5NsAUHZvbnhjCp9JvH4ORs
         zZKGMpqz4tyLJBoOmJ+eAsVaMjToJcb5+ZM/eX4yLYRZ3GuK4I+8jkZxLZG/GiRY3Gxm
         jYBTaJx3uhTjVTLKawO18rVlHbIrukktU39SFAUbHD7uJBajanYi4+2l0V9h/YWynW8Q
         W47UejBa66rAnNeSC/5fbXD+zuxujdayqCK4WgUl2GVAT2L4d6H9zbp0x5MW1domphdS
         ql7TBA2cgPQj2kBV8NmjPaUd57FtQD5y5JjhZ2KZdK+O5RYmJHwadRdvjcZH8wGpVxzs
         WAGA==
X-Gm-Message-State: APjAAAVqt2cEOGG1HvwWAWIKTPaUO5Xl/qNW4w/MhTclNEFH/zio8Pef
        YDSgm6C/jLZ77hfp7OGkH+E=
X-Google-Smtp-Source: APXvYqyilVINjioPf4Y+YJAEU+o12zOZDGtcSI0iIPme/ZvH6/C/tnA5f5f2nGKxcJaUttL6sZwe6w==
X-Received: by 2002:a17:906:7e59:: with SMTP id z25mr10065003ejr.130.1576766371338;
        Thu, 19 Dec 2019 06:39:31 -0800 (PST)
Received: from szeder.dev (x4db583fb.dyn.telefonica.de. [77.181.131.251])
        by smtp.gmail.com with ESMTPSA id c19sm547683ejm.47.2019.12.19.06.39.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 06:39:30 -0800 (PST)
Date:   Thu, 19 Dec 2019 15:39:27 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/6] completion: return the index of found word from
 __git_find_on_cmdline()
Message-ID: <20191219143927.GD8609@szeder.dev>
References: <20191017173501.3198-1-szeder.dev@gmail.com>
 <20191017173501.3198-4-szeder.dev@gmail.com>
 <CAPig+cTLCTPtUWHKVBQEaP9GkrmrnHPwfef8KnktOSqYQY-jPA@mail.gmail.com>
 <20191018143728.GC29845@szeder.dev>
 <CAPig+cRSGfaRggDhauSvJyrO1Zu7ZFSG+gfF134z8UV1ovSuEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cRSGfaRggDhauSvJyrO1Zu7ZFSG+gfF134z8UV1ovSuEw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 18, 2019 at 05:01:42PM -0400, Eric Sunshine wrote:
> On Fri, Oct 18, 2019 at 10:37 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> > On Thu, Oct 17, 2019 at 01:52:27PM -0400, Eric Sunshine wrote:
> > > > +               case "$1" in
> > > > +               --show-idx)     show_idx=y ;;
> > > > +               *)              return 1 ;;
> > >
> > > Should this emit an error message to aid a person debugging a test
> > > which fails on a call to __git_find_on_cmdline()? [...]
> >
> > And printing anything to standard error during completion is
> > inherently bad: it disrupts the command line, can't be deleted [...]
> > Remaining silent about the unrecognized option
> > is in my opinion better, because then the completion script usually
> > does nothing, and Bash falls back to filename completion.  Yeah,
> > that's not ideal, but at least the user can easily correct it and
> > finish entering the command.
> 
> I had tunnel-vision and was thinking about this only in the context of
> the tests. However, while I agree that spewing errors during
> completion is not ideal, aren't there two different classes of errors
> to consider? Some errors can crop up via normal usage of Git commands
> in Real World situations; those errors should be suppressed since they
> are expected and can be tolerated. However, the second class of error
> (such as passing a bogus option to this internal function) is an
> outright programming mistake by a maintainer of the completion script
> itself, and it would be helpful to let the programmer know as early as
> possible about the mistake.
> 
> Or, are there backward-compatibility or other concerns which would
> make emitting error messages undesirable even for outright programmer
> mistakes?

It's not necessarily an outright programming mistake, and that error
could be triggered by ordinary users as well.

Let's suppose that a user has a custom 'git-foo' command in $PATH with
a custom '_git_foo' completion function in '~/.my-git-completions',
which the helper function '__git_bar --option' from our completion
script.  Let's also suppose that the user sources this completion
function from '~/.bashrc', but otherwise uses the system-wide git
completion script, and that $HOME is shared across multiple computers.

In this (arguably somewhat convoluted) scenario it might happen that
on a not quote up-to-date computer the system-wide git completion
script already has the '__git_bar' helper function, but it doesn't yet
support '--option'.  If '__git_bar' then prints an error to stderr,
then the command line will get badly messed up, and the user will have
to ctrl-C and start over.

However, if '__git_bar' silently ignores the unknown option, then the
worst that can happen is that completion doesn't work, and e.g. it
falls back to Bash's filename completion or offers something
nonsensical.  In either case, after a brief "Huh?!" moment the user
can correct it by hitting backspace a couple of times and then enter
the rest of the command by hand.

