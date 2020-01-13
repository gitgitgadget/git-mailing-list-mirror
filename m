Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1722DC33CA9
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 22:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1158207FD
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 22:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ci1Eyk6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgAMWzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 17:55:46 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41855 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbgAMWzp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 17:55:45 -0500
Received: by mail-oi1-f196.google.com with SMTP id i1so9972823oie.8
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 14:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ABhohUhKHcgHLRjYp0+EfemIocy2kBmbFYVfCn/duQA=;
        b=Ci1Eyk6BV8Qvo6GueGV1bV4Li7GzrtkkZnbv/t3Xbe6SAwrJn5OjBhzhcKrvm4bEzi
         tSobxEFxLtxo8CncfHZcnx+YsZxi/GNu1Ywc/i0/m4UfUnK5amHiVBpa8uRg/PAHOi83
         IvlQ68lfsCYd5TKiEQWCi3egRiLOFH1DQ0zNxlZ+wmw/aEdoPVC5Yz1mtGe+uf6wRrcj
         984mFKN0rSAjhuGsohXlCq/BQINbXuuk54YfpW1a/GKDqfdXQgQiFLiPW1KpKG0flYBm
         mO/Atux4lMCPokZsb6Sf1TLtQZ/6Y10PHO0RNACpCmmnwbSR6q8QLgG5UAbyz6wwXMTk
         GMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ABhohUhKHcgHLRjYp0+EfemIocy2kBmbFYVfCn/duQA=;
        b=ujCzCLG8fUwF4PsXdwYkH4gFibqZzQQbtRUm3LqHinKAZmTwb4PBjymj1BgQxDtfjG
         3pqy5jwQeIjWC6oaZFl4ExvN8bzhGBPRNivc/CJH0fTPMaalQo8x01G2oJl70IIu/Ho+
         5yV7SFdtZ7bZPLPmxkPrmsMUUDKk1Yb/cyaZhbk0LgPW8durnXxR/QWdAf/k2fxRGEgA
         kraw5ztU7SV4HuAoWeOrx75u/U0fpnGMishftsDAOz8+UpQRSmRERfYFu0kbabG0+OHi
         dDyXBhvrRbP3mtt+XgcaslJifFjBM5ym/9pHAuIQWrvB6opgAEF849/NldxeOOJ85PeV
         jSpA==
X-Gm-Message-State: APjAAAV5QQQiIP/0YqluvL6GkP0K9bUr14bLU9IDPzdAmXGKAH+AnsCX
        5JQsxHvjidbNY3QvqkMo+B3JIEyewmjI26a8DM4=
X-Google-Smtp-Source: APXvYqyKkLd6OgQ8KFyZWETPb9LNBTCFrV/uS1xLHa1P4UnuAofkTaOTMb+2zOll4Z/bQX3414hTFuT351BT7MRfh8A=
X-Received: by 2002:a05:6808:b18:: with SMTP id s24mr13826440oij.31.1578956144789;
 Mon, 13 Jan 2020 14:55:44 -0800 (PST)
MIME-Version: 1.0
References: <18b8b8fd-ee38-e1bf-8fae-b719b7b78a75@gmail.com> <xmqqk15vj8aw.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk15vj8aw.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 Jan 2020 14:55:33 -0800
Message-ID: <CABPp-BHgZdMnyiA_w-vCJTqj7aBcf4or0ABmSYui-HbMp=XVNw@mail.gmail.com>
Subject: Re: Re* Potential Issue with ls-tree documentation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kevin Bowersox <kevin.m.bowersox@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 13, 2020 at 2:37 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Kevin Bowersox <kevin.m.bowersox@gmail.com> writes:
>
> > Within the ls-tree documentation for Git found here:
> > https://git-scm.com/docs/git-ls-tree
> > <https://git-scm.com/docs/git-ls-tree>
> >
> > It mentions the following:
> >
> > the behaviour is slightly different from that of "/bin/ls" in that the
> > <path> denotes just a list of patterns to match, e.g. so specifying
> > directory name (without |-r|) will behave differently, and order of
> > the arguments does not matter.

This is unreadable, IMO.  I don't understand what it's even trying to say.

>
> The above description is solely focused on the pathspec part of the
> argument list and the text needs to clarify that.  In other words,
> the above paragraph only wants to say:
>
>     Among the paths in the given tree-ish, a subset of paths are
>     chosen to be shown by using pathspec, and the way these pathspec
>     arguments are used is different from how "/bin/ls" uses its
>     arguments.

Ah, much better.  But...

>
> The "order of the arguments" part is better read as if there is
> the word "pathspec" before "arguments" for clarity.  As the synopsis
> makes it clear, <tree-ish> must come before the pathspec, so the
> order of that part would not be flexible, obviously.
>
> Thanks.
>
> Perhaps something like this?
>
> -- >8 --
> Subject: ls-tree doc: clarify and modernize pathspec description
>
> We have been updating our docs to consistently say <pathspec> when
> an argument is one and not a path; "ls-tree" takes a tree-ish and
> optionally pathspec, so use the correct term.
>
> It is correct that the order of pathspec arguments do not make a
> difference in the output unlike the order of path arguments given to
> "/bin/ls", but the existing documentation can be misread to allow
> having even the <tree-ish> argument at a random place on the command
> line, which obviously was not what the original authors intended to
> say.  Clarify it.
>
> Noticed-by: Kevin Bowersox <kevin.m.bowersox@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-ls-tree.txt | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
> index a7515714da..aa368a8d14 100644
> --- a/Documentation/git-ls-tree.txt
> +++ b/Documentation/git-ls-tree.txt
> @@ -11,19 +11,20 @@ SYNOPSIS
>  [verse]
>  'git ls-tree' [-d] [-r] [-t] [-l] [-z]
>             [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]]
> -           <tree-ish> [<path>...]
> +           <tree-ish> [<pathspec>...]
>
>  DESCRIPTION
>  -----------
>  Lists the contents of a given tree object, like what "/bin/ls -a" does
>  in the current working directory.  Note that:
>
> - - the behaviour is slightly different from that of "/bin/ls" in that the
> -   '<path>' denotes just a list of patterns to match, e.g. so specifying
> -   directory name (without `-r`) will behave differently, and order of the
> + - The way <pathspec> is used is slightly different from how "/bin/ls" uses
> +   its paths arguments, in that '<pathspec>' denotes just a list of
> +   patterns to match, e.g. so specifying directory name (without
> +   `-r`) will behave differently, and the order of the pathspec
>     arguments does not matter.

This is much better; but it's still not parseable in my opinion.  Most
of this long sentence is much improved but the phrase "e.g. so
specifying directory name (without `-r`) will behave differently"
still seems quite difficult to understand.  Possible permutations I
run through in my head while trying to read that:

Specifying a directory name behaves differently than specifying a
file?  But only if -r is not specified?  Or is ls-tree output for a
directory different than /bin/ls output for a directory?  But I
thought ls-tree output was different than /bin/ls in all cases, not
just for directories??  Or maybe ls-tree output shows files
differently if one of the pathspecs specified happens to be a
directory, even if the files don't match that directory pathspec?

Being relatively familiar with git and ls-tree, so that I already know
my first five most natural interpretations of that sentence are
incorrect, I think that sentence fragment is trying to say that
ls-trees won't recurse into a specified directory (making it somewhat
like the -d option of ls), but what a convoluted way of saying it.
And I'm still not sure that is what it is actually trying to say.

> - - the behaviour is similar to that of "/bin/ls" in that the '<path>' is
> + - the behaviour is similar to that of "/bin/ls" in that the '<pathspec>' is
>     taken as relative to the current working directory.  E.g. when you are
>     in a directory 'sub' that has a directory 'dir', you can run 'git
>     ls-tree -r HEAD dir' to list the contents of the tree (that is
> @@ -73,10 +74,8 @@ OPTIONS
>         Do not limit the listing to the current working directory.
>         Implies --full-name.
>
> -[<path>...]::
> -       When paths are given, show them (note that this isn't really raw
> -       pathnames, but rather a list of patterns to match).  Otherwise
> -       implicitly uses the root level of the tree as the sole path argument.
> +[<pathspec>...]::
> +       When pathspec is given, only show paths that match the pattern.
>
>
>  Output Format
>
>
