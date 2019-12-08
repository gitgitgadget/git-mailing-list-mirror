Return-Path: <SRS0=+MKA=Z6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC3EC43603
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 05:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E97920706
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 05:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPuZ+J8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbfLHFmM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Dec 2019 00:42:12 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40714 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfLHFmM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Dec 2019 00:42:12 -0500
Received: by mail-oi1-f193.google.com with SMTP id 6so3544838oix.7
        for <git@vger.kernel.org>; Sat, 07 Dec 2019 21:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jdMznqDDi9CvSZydGoVvmejCSCES6ZdRfoxMHH2/2rY=;
        b=fPuZ+J8Obr+sIvT27Ok5eCr+2Tw9otnMljT0ksZiTUxgF0m4ZlnewooE59r7tDZl/V
         Dz57C1py8j3B+jOrap9ahvqYEdxtSuMjGc2HcXIF6Nd6IvIFyRZ+6onxjengmt9nq4re
         XkoR2gqjmvqfGSLB37h2I4RKalgdPqj5fTzPTqzfiQRmPE517tnLSuAE35H6I644f82L
         4yFoBYg4uIT0C2zpyvKBV/TTNUClhPgWZJe3MU3fRvk5gIE2gZ3bFJt9CH2zz10HmMBs
         iQFhCIuUuVcZI55EPCBeA6ScvqTr4sbxtvt7GL/WKWrdqyfYOswxs+fG5p9UT4fURmff
         OOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jdMznqDDi9CvSZydGoVvmejCSCES6ZdRfoxMHH2/2rY=;
        b=TGztSpsPd7oAXjvjbzZ1nsItlM1MTApu+D2x3nOzXsYHhidMqYnnd6LD3KGGLuIkIG
         ppq/S54Ikx1vbOfA9GBOjN4Vsas59l/OxAanrxEShEP0UbW6bIb/eHD8ZcROCUINoxO4
         skUzM0P3m//UhlMFs0Y6DECEfd/VlRKd8b2+sUMAb7r4ksTQYa2KtADqWlvBLTj84k62
         tgH23jZMaO905EdLqPJ/HZfDMWL8UvBxtbtKni6IFUKAfWVU38/esuzSDwg7V9tAxKW1
         a7rQf4Ks7wFzX/8ZiZ6KzJ0F+OtDlO0z4G6NASnXlHMIQdvxYEfi4YJX2fIZ4vGzGQw4
         kl8g==
X-Gm-Message-State: APjAAAWdVKXbm6kdwCMxUmYqkgtmNrp3yARDpjiigc+h8ZMp/B1066MD
        z5SGkpO3YY2SvhrgLYxv4YoIypfp37/1jki61lZeUQ==
X-Google-Smtp-Source: APXvYqxTK4VovE6AJZsfqPVSPmScr9nKfTXzWZWZq/IZmSUn3Ne/Y3zEPZcfDRgB2p06J7BWpmZAXDRFqBBGW+9HcuU=
X-Received: by 2002:aca:dc45:: with SMTP id t66mr14092439oig.39.1575783731200;
 Sat, 07 Dec 2019 21:42:11 -0800 (PST)
MIME-Version: 1.0
References: <874kyf6en3.fsf@kyleam.com> <871rtfv0wn.fsf@kyleam.com>
In-Reply-To: <871rtfv0wn.fsf@kyleam.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 7 Dec 2019 21:42:00 -0800
Message-ID: <CABPp-BEvr+wB_yqOAG9oOaONtckYzn-zghyAtx2fWJweg55ovA@mail.gmail.com>
Subject: Re: [BUG?] ls-files -o now traverses nested repo when given multiple pathspecs
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kyle,

On Sat, Dec 7, 2019 at 9:31 PM Kyle Meyer <kyle@kyleam.com> wrote:
>
> Kyle Meyer <kyle@kyleam.com> writes:
>
> > Elijah Newren <newren@gmail.com> writes:
> >> [...]
> >> At least my changes in git-2.24.0 made the behavior consistent; it'll
> >> always traverse into a directory that matches a given pathspec.
> >
> > I might be getting mixed up, but the changes in 2.24.0 did introduce
> > some inconsistent behavior (in the no trailing slash case) with respect
> > to giving a single pathspec and giving multiple pathspecs, no?  Using
> > your example:
> >
> >     $ git --version
> >     git version 2.24.0
> >     $ git ls-files -o untracked_repo
> >     untracked_repo/
> >     $ git ls-files -o untracked_repo empty
> >     empty
> >     untracked_repo/
> >     untracked_repo/empty
>
> It looks like the "multiple pathspecs trigger traversal" change isn't
> limited to nested repositories.  It can also be observed with
> --directory and plain untracked directories.  Assume the tree layout
> from your example again.  With a single pathspec (and no slash),
> 'ls-files -o --directory' will not expand the untracked directory's
> contents:
>
>     $ git ls-files -o --directory untracked_dir
>     untracked_dir/
>
> But, as of 89a1f4aaf7, tacking on an additional pathspec will cause
> ls-files to traverse into the untracked directory:
>
>     $ git ls-files -o --directory untracked_dir empty
>     empty
>     untracked_dir/
>     untracked_dir/empty
>
> In contrast, on 89a1f4aaf7^ the same command shows
>
>     $ git ls-files -o --directory untracked_dir empty
>     empty
>     untracked_dir/

Yeah, I spotted that too.  You left out a case, a single pathspec with
the trailing slash:

   git ls-files -o --directory untracked_dir/

That will traverse into the directory before or after my changes.  I
also spotted a few other bugs, e.g. try out 'git ls-files -o .git/'
(with either git-2.23 or git-2.24).  Whoops.  We do correctly avoid
traversing into the .git directory if multiple pathspecs are provided.
Anyway, this whole area seems to be a bug factory.  Every time I think
I'm close to having some patches to send to the list to fix up the
issues I've found, I find the fix isn't where I thought it was and/or
find yet another bug.  Quite aggravating.

I'm thinking of just sending the patches I have, since they fix up all
the issues we've discussed so far (including the .git/ case I just
mentioned), and ignoring the 2-3 other bugs I found that are still
broken other than providing testcases documenting their breakage.
