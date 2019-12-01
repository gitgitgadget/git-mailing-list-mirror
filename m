Return-Path: <SRS0=LEOb=ZX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307D9C432C3
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 02:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9ACD206E4
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 02:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=deltaq.org header.i=@deltaq.org header.b="JJEGDN3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfLACNR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 21:13:17 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38526 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfLACNR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 21:13:17 -0500
Received: by mail-lf1-f68.google.com with SMTP id r14so9060195lfm.5
        for <git@vger.kernel.org>; Sat, 30 Nov 2019 18:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deltaq.org; s=deltaq;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c61i3WTTTPuo4ApIKsBzsZ5TBY+6u6qhyFY+aNO+xKA=;
        b=JJEGDN3Jdrz7QMC9KMCduenI5qyjMd9fOiW/eb+T5WbZ7e6wa0uWEBDZQbvpE/dSXK
         /hRrvb8MiV3n9l3bHTqILgqxNOSSq2ESpdQuiC/1RW3as6V2ZnPXqQRt69yK51znERIs
         s1M0zL2WKv3q4ziN+Jr1C3dHrJR6PUjhkNM7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c61i3WTTTPuo4ApIKsBzsZ5TBY+6u6qhyFY+aNO+xKA=;
        b=JijAI9+7+BV5UnqHnBIK0FSUvgbL+paB16YXTVUTzICvQXU0d8+9cwn0RoyJ3esd3A
         owvS7ui5jH82auCuZZC7lAh6DU+I9Cox/BW820vs8kxsqy0L2rRvJAO2NM9qJ9f7M9bB
         J4w5vKgSoxViAGSCNMx3BmflWFRkKMOfYVyDUrYLNYo6junvyNhycxbWjjvkcyfDd6p9
         4qNUhmXB4S/6gRLv8rkjoWBffVkmzREtbsrbyc+0ahb9h3L/T+2bJwvCHmNEbQuD2TPd
         JcedOyeP4H3CUcZaFNAlyo+hSAA+ArQxn2ZH/lX6kso+Jh5pXD5AfJI5UTgYGsQljK9O
         Yivg==
X-Gm-Message-State: APjAAAUfJ9pvIJZEYTQn6dP6WFejk3gxLbb+qP5mAk7zoIanGHL7SeSl
        mo8/ff7YKTktScmkFCsVJDR4XffbFOfnLMvwa2/devppzWK/XA==
X-Google-Smtp-Source: APXvYqx5tiJx91h/Nd4v80qXXe8LE5DC9kKfMdMaoC3TB4eyL/Q0CJ+MWVkKWoK2TAD93z3V2kmxjQJzl6WXxujIrtc=
X-Received: by 2002:a19:ee0d:: with SMTP id g13mr7572218lfb.115.1575166393265;
 Sat, 30 Nov 2019 18:13:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.436.v5.git.1574627876.gitgitgadget@gmail.com>
 <pull.436.v6.git.1574929833.gitgitgadget@gmail.com> <ab3d8e54c3d3d5174fe222ee77101ab3b8e9cab8.1574929833.git.gitgitgadget@gmail.com>
 <20191130230543.p5xtapnx5a56arng@yadavpratyush.com>
In-Reply-To: <20191130230543.p5xtapnx5a56arng@yadavpratyush.com>
From:   Jonathan Gilbert <logic@deltaq.org>
Date:   Sat, 30 Nov 2019 20:12:55 -0600
Message-ID: <CAPSOpYs7GeKhcWLHtmwuXQWimp-Bgk8F5WYoO+XQM8C8dDj7pA@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] git-gui: update status bar to track operations
To:     "Pratyush Yadav me-at-yadavpratyush.com |GitHub Public/Example Allow|" 
        <172q77k4bxwj0zt@sneakemail.com>
Cc:     Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Jonathan Gilbert <JonathanG@iqmetrix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 30, 2019 at 5:05 PM Pratyush Yadav me-at-yadavpratyush.com
|GitHub Public/Example Allow| <172q77k4bxwj0zt@sneakemail.com> wrote:
> Hi Jonathan,
>
> Thanks for the re-roll.

You are most welcome :-)

> On 28/11/19 08:30AM, Jonathan Gilbert via GitGitGadget wrote:
> > +# Operation displayed by status mega-widget during _do_clone_checkout =>
> > +# _readtree_wait => _postcheckout_wait => _do_clone_submodules =>
> > +# _do_validate_submodule_cloning. The status mega-widget is a difference
> > +# instance than that stored in $o_status in earlier operations.
>
> The last sentence doesn't make a lot of sense to me. What is "earlier
> operations"? If this refers to previous versions of this file, then I
> don't think such a comment belongs here. It should be in the commit
> message instead.

A clone starts out by calling `_do_clone2`, which, for `$clone_type`
of `hardlink`, creates a status "mega-widget" and uses it to track
linking and/or copying the underlying files. Then, this part of the UI
is destroyed. Later, the code calls into _do_clone_checkout, which
sets up its own, different view. This view _also_ uses a status
"mega-widget", but it's not the same one as before. This wasn't
obvious to me in my first read-through, and I erroneously wrote code
that assumed the widget objects would carry forward. As such, I felt
it might be useful to other readers to have this detail called out
up-front. In the context of `_do_clone_checkout`, the "earlier
operations" is what happens in `_do_clone2`.

> >               destroy $w_body
> > +
> > +             set o_status {}
>
> Should we be calling a destructor for this here? There is the '_delete'
> method in status_bar.tcl, but I don't see any usages of it so I'm not
> sure what exactly it is supposed to do.
>
> That said, the previous version of this file doesn't call any sort of
> destructor either, so maybe we should just leave it like it is for now.
> I dunno.

As far as I can tell, `destroy $w_body` automatically deletes the
entire subtree of UI components. I mentioned that I had written broken
code at first because I didn't realize the status widget got replaced
between `_do_clone2` and `_do_clone_checkout` -- that code encountered
an error that indicated that the status widget object no longer
existed at all. Thus, I have proceeded on the assumption that `destroy
$w_body` handles that particular detail, and all that's left is to
clear `o_status` of its dangling reference to the object that no
longer exists.

> > -method _do_validate_submodule_cloning {ok} {
> > [..]
> > -method _do_clone_submodules {} {
>
> Is there a reason for moving these two methods around? Not that its a
> bad thing, I'm just curious.

I touched on this in the cover letter. I'll just copy/paste that text
since it says it just as well as I could re-synthesize here :-)

* In `choose_repository.tcl`, there is a sequence of functions
involved performing the checkout on the clone: `_do_clone_checkout` =>
`_readtree_wait` => `_postcheckout_wait` => `_do_clone_submodules` =>
`_do_validate_submodule_cloning`. The functions have been re-ordered
in the source code to match the sequence in which they execute to
improve clarity.

Re-roll (final?) incoming.

Thanks,

Jonathan Gilbert
