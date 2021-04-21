Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6297C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 18:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63AA3608FC
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 18:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244141AbhDUSmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 14:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236033AbhDUSmm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 14:42:42 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE1AC06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 11:42:09 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so39824878otn.1
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 11:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=78B2/7udNwfEIsAsSu4x9OGQ7j/v2oDOFDFB5+xkamo=;
        b=lzaoCK6L/L3VsJTc6hSXhdWwIYQ76s0upjdbDIRFyovVuaMGcmlZoAo8A/qdMJKWOb
         8baM788mAwP69uTk6RYpJjDcGV4FhA5MIiVcI8st+OWXu466UH23YEwVGLlIssOADjiR
         VTXjdnFTczQVAbk80Dnvy6UE116APlujhdWzgJDfcG+k67RjqQVZi5EZblvRVespRbYs
         BxyHOsw8q78GrzSU5Auz+MSb97CpcZEfsRvXWSGbWA4cGLXeLnOZ7ozPPEAxAucluSwJ
         R+VCv8CI5VR8EIyIGTLOCk3kYWzRdBUgJRB+KO0uj0HGLojblUsKC3M0fQ6sdEx9vrBf
         6kqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=78B2/7udNwfEIsAsSu4x9OGQ7j/v2oDOFDFB5+xkamo=;
        b=JT5fcIi3DWwKgBmxcE39qPlg/Qpk97Q06ZiTtnFLlMEoD7RI14ZnsBR5gH4A8nG4r0
         z0CXN+vU6vMctukvWsxzpfSyffWC0e3bEu4QEEt6MhOzxpKdR3I6f4kRE5Y1AXrPMmPW
         PJR4k0yMtCG+34rpkeHJVXNdDt7KVKP9B9nEcgd9KXVxh4LQyByX5dfdrWhW+hGDEH4t
         z/v/Zaz2xMyWBqfB8nD/eo15RTPffqGHk5sUrnU/pnWl9R8XeguoFgd7Z0AqXgJuV0ZG
         tGFOm56k5c2JLbIO5Fy8Zb5p86moee9lHYZV9QuFiKd0q1itVe+EM9nqVgBslOvxPbpX
         geag==
X-Gm-Message-State: AOAM530kBWGyW7Fw/0FTBV5hQqIljWcEDU0W4RiaiKA5/f36pR8CJjsL
        WFNIK0caRF5gRtPQc1xnd5YXahqgBjxRqCv8b9U=
X-Google-Smtp-Source: ABdhPJwvZr0qVVhMihKm3dqydPuiL9HCaBc4CQQx0sGWUy6Nk4erQSboaMDiY31Jk7IQ1q3qva9WwiAxt3UJRml20mA=
X-Received: by 2002:a9d:8a6:: with SMTP id 35mr24039783otf.316.1619030528469;
 Wed, 21 Apr 2021 11:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210420190552.822138-1-lukeshu@lukeshu.com> <xmqqa6ps4otm.fsf@gitster.g>
In-Reply-To: <xmqqa6ps4otm.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 21 Apr 2021 11:41:57 -0700
Message-ID: <CABPp-BF-rHnxvz0sAFAujXkiNwSjtpRQA4uvxT=a3z8v_sYbAA@mail.gmail.com>
Subject: Re: [RFC PATCH] fast-export, fast-import: Let tags specify an
 internal name
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Luke Shumaker <lukeshu@lukeshu.com>,
        Git Mailing List <git@vger.kernel.org>,
        Luke Shumaker <lukeshu@datawire.io>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 20, 2021 at 2:40 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Luke Shumaker <lukeshu@lukeshu.com> writes:
>
> > That'd work fine if they're lightweight tags, but if they're annotated
> > tags, then after the rename the internal name in the tag object
> > (`v0.0.1`) is now different than the refname (`gitk/v0.0.1`).  Which
> > is still mostly fine, since not too many tools care if the internal
> > name and the refname disagree.
> >
> > But, fast-export/fast-import are tools that do care: it's currently
> > impossible to represent these tags in a fast-import stream.
> >
> > This patch adds an optional "name" sub-command to fast-import's "tag"
> > top-level-command, the stream
> >
> >     tag foo
> >     name bar
> >     ...
> >
> > will create a tag at "refs/tags/foo" that says "tag bar" internally.
> >
> > These tags are things that "shouldn't" happen, so perhaps adding
> > support for them to fast-export/fast-import is unwelcome, which is why
> > I've marked this as an "RFC".  If this addition is welcome, then it
> > still needs tests and documentation.
>
> I actually think this is a good direction to go in, and it might be
> even an acceptable change to fsck to require only the tail match of
> tagname and refname so that it becomes perfectly OK for Gitk's
> "v0.0.1" tag to be stored at say "refs/tags/gitk/v0.0.1".
>
> > diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
> > index 39cfa05b28..6514b42d28 100644
> > --- a/Documentation/git-fast-import.txt
> > +++ b/Documentation/git-fast-import.txt
> > @@ -824,6 +824,7 @@ lightweight (non-annotated) tags see the `reset` command below.
> >  ....
> >       'tag' SP <name> LF
> >       mark?
> > +     ('name' SP <name> LF)?
> >       'from' SP <commit-ish> LF
> >       original-oid?
> >       'tagger' (SP <name>)? SP LT <email> GT SP <when> LF
>
> The documentation after this part must be updated, too.  Here is my
> attempt.
>
>  Documentation/git-fast-import.txt | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git c/Documentation/git-fast-import.txt w/Documentation/git-fast-import.txt
> index 39cfa05b28..c3c5a7ed16 100644
> --- c/Documentation/git-fast-import.txt
> +++ w/Documentation/git-fast-import.txt
> @@ -822,22 +822,28 @@ Creates an annotated tag referring to a specific commit.  To create
>  lightweight (non-annotated) tags see the `reset` command below.
>
>  ....
> -       'tag' SP <name> LF
> +       'tag' SP <refname> LF
>         mark?
> +       ('name' SP <tagname> LF)?
>         'from' SP <commit-ish> LF
>         original-oid?
>         'tagger' (SP <name>)? SP LT <email> GT SP <when> LF
>         data
>  ....
>
> -where `<name>` is the name of the tag to create.
> +where `<refname>` is also used as `<tagname>` if `name` option is
> +not given.
>
> -Tag names are automatically prefixed with `refs/tags/` when stored
> +The `<tagname>` is used as the name of the tag that is stored in the
> +tag object, while the `<refname>` determines where in the ref hierarchy
> +the tag reference that points at the resulting tag object goes.
> +
> +The `<refname>` is prefixed with `refs/tags/` when stored
>  in Git, so importing the CVS branch symbol `RELENG-1_0-FINAL` would
> -use just `RELENG-1_0-FINAL` for `<name>`, and fast-import will write the
> +use just `RELENG-1_0-FINAL` for `<refname>`, and fast-import will write the
>  corresponding ref as `refs/tags/RELENG-1_0-FINAL`.

Going on a slight tangent since you didn't introduce this, but since
you're modifying this exact documentation...

I hate the assumed "refs/tags/" prefix.  Especially since the "commit"
and "reset" directives require full renames, why should tags be so
special?  The special casing reminds me of the ref-updated hook in
gerrit (where branches would sometimes come without the "refs/heads/"
prefix) and all the problems it caused for years until they finally
fixed it to always specify full refnames.  In this particular case,
the "refs/tags/" assumption breaks exporting/importing of some
real-world repos by mangling tag locations in weird ways -- though I
never bothered to fix it because those tags appeared to already be
broken given the fact that the name inside the tag didn't match the
name of the actual ref.  (To be honest, though, I was never sure why
the name of the tag was recorded inside the tag itself.)
