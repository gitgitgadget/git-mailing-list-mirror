Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C75DC25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 14:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbiHPOJD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 10:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiHPOJB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 10:09:01 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C87972EDD
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 07:08:58 -0700 (PDT)
Date:   Tue, 16 Aug 2022 16:08:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1660658931; bh=B2kiqbEwA9c4btnbmyb9qCR9UIfsVnCRAYXVJ7srsyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g+iFsTGZZkAHQ5hzqV2t5fvUPV8V/WquX/p8Y4uSU3FUiMa9Gf9eZP4ONTvgZaPRA
         OC1tCr1Ty/R1Xb3wpdsAy6btU07rdFXD9n4/nqBVNxXpb72Z39a+hsjPgXvp3F7M9T
         CY79KZiCS5egR8W8YaKsocRtin8LQwEaFotHD18A=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation: mention the magic pathspec ":/"
Message-ID: <89a2217a-dc62-47e1-96f3-94ee99f2b0d6@t-8ch.de>
References: <20220814095253.3422612-1-thomas@t-8ch.de>
 <xmqqsfly3xar.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqsfly3xar.fsf@gitster.g>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 2022-08-14 22:12-0700, Junio C Hamano wrote:
> Thomas Weißschuh <thomas@t-8ch.de> writes:
> 
> Here before your sign-off is the place for you to justify why this
> patch is a good idea.
> 
> > Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
> > ---
> >  Documentation/gitcli.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
> > index 1819a5a185..a421855bdb 100644
> > --- a/Documentation/gitcli.txt
> > +++ b/Documentation/gitcli.txt
> > @@ -78,6 +78,8 @@ you will.
> >     using a '.' as a repository name in Git (a dot-repository) is a relative
> >     path and means your current repository.
> >  
> > + * The magic pathspec `:/` refers to the root of the working tree.
> > +
> 
> This looks somewhat out of place.  Reading the previous entry, I
> notice it is about the path to a repository, not about path in your
> working tree.  The entry before it is about pathspec, so in a sense,
> what is truly out of place is the "dot is how you refer to the
> current repository".
> 
> I do not quite see why we want to single out ":/", i.e.  the "top"
> pathspec magic applied to an empty string, and not talk about the
> case when it was applied to non-empty string, e.g.  ":/*.c".  If we
> talk about pathspec magic, shouldn't we also talk about "exclude"
> magic, e.g. ":!\*.o", here?
> 
> Besides, the new description is not exactly correct. The "top"
> pathspec magic does not inherently refers to the root.  In
> 
>     $ cd sub/dire/ctory && git grep -e pattern
> 
> we tell "git grep" to look for patterns in the current directory
> and in its subdirectories, and with
> 
>     $ cd sub/dire/ctory && git grep -e pattern :/
> 
> we lift the "current directory and below" limitation and instead
> look for matches everywhere, not limited to the root-level directory.
> We can find a patch from sub/foo.txt that is neither in our current
> directory or at the root-level directory.
> 
> So, I do agree that the users must know more than "Many commands
> allow wildcards in paths" (the entry before the "dot is how you can
> refer to the current repository"), I do not think singling out ":/"
> and refer only to that is a wrong way to go about it for this
> document.  The gitcli manual does not even mention 'pathspec', which
> is the keyword to effectively find many things to learn in the
> glossary ("git help glossary"), and it would be the first thing to
> fix here, I would think.
> 
> So after reading your patch and thinking about it for a few days,
> here is what I think is wrong in the current description, plus its
> fix.
> 
> Thoughts?

This looks good, thanks!

I did not even find the existing documentation in gitglossary(7) and the other
pathspecs.
Originally I got to know about the ":/" pathspec from someones example on a
mailing list. Then I grepped the git source and only found some tests and the
entries in the release notes.
So some literal examples in gitglossary(7) maybe help users to find the correct
documentation.

>  Documentation/gitcli.txt | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git c/Documentation/gitcli.txt w/Documentation/gitcli.txt
> index 1819a5a185..40553fc578 100644
> --- c/Documentation/gitcli.txt
> +++ w/Documentation/gitcli.txt
> @@ -57,9 +57,11 @@ When writing a script that is expected to handle random user-input, it is
>  a good practice to make it explicit which arguments are which by placing
>  disambiguating `--` at appropriate places.
>  
> - * Many commands allow wildcards in paths, but you need to protect
> -   them from getting globbed by the shell.  These two mean different
> -   things:
> + * Many commands take paths to work on as "pathspec".  A pathspec element
> +   can be a literal string, which specifies the named path itself, or it
> +   can be a wildcard pattern, which specifies all paths that match the
> +   pattern.  Wildcards may need to be protected from getting globbed by
> +   the shell.  These two mean different things:
>  +
>  --------------------------------
>  $ git restore *.c
> @@ -73,6 +75,8 @@ the paths in the index that match the pattern to be checked out to your
>  working tree.  After running `git add hello.c; rm hello.c`, you will _not_
>  see `hello.c` in your working tree with the former, but with the latter
>  you will.
> ++
> +To learn more about pathspec, see linkgit:gitglossary[7].
>  
>   * Just as the filesystem '.' (period) refers to the current directory,
>     using a '.' as a repository name in Git (a dot-repository) is a relative

Thomas
