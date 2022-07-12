Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B254FC433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 13:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbiGLNAj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 09:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiGLNAi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 09:00:38 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3CBB23DE
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 06:00:36 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id q7so9757441lji.12
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 06:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XME4x+qLSvAGLpnTokaDzODdJA/3iK9SlBlLXBMbcGk=;
        b=Acss9KwYhmc+rO2wwwop1Wi0VCz7/CfXkKapqFX25qydDX3lkl4Tu5O0ID5MzQNCja
         qJZK0Or5OLTxpe9QFbpcUSZhcA/35LS3dfu1DGPxDpVAQPrSB367+Xt+Xl0UHZodU6Vi
         utI0kJ0tyRrJsI1GEYnopUo8Z2/IhlskGZYXlvPeoOTrj4Z89NU32vyXwvAp5ftc8Zp1
         C4LiF9J9DEFgPMq2ZxH4WAjspu4Now/4MttkV2M7FpMtjKhlh6hZZdNga9epHSIAQQVN
         DsfSy43JX9Wql9YRV6XT+Ulx7rC5y/I+opYmNMud2S107Otf3ki3WPTVRgJLiox8oQSr
         qxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XME4x+qLSvAGLpnTokaDzODdJA/3iK9SlBlLXBMbcGk=;
        b=YaD6D+LQqrgtGPtk4wsWBtjVVGnbHfh8O+2icPrMijnlbR7b/iYjkP9gpX+I7Lp7ye
         g5g5uX4Jn4iJ5dEN2l2CQxqSy8QK619hx+YR/BsJoAECedOSPpbAXMT9EN0h2xNFx8jm
         F95mcvM/zOt/uhqZt68+UBy2aSgB8Zidttt0e6NB9XkRHS2BLAxjwHH8B025JE7sodT2
         fPomY9x/MhwyUkRsXPAykq/8hGMUtqztlxl/i5fiytv0WhfOJJn2r0XtT8g9oLf64EaW
         ELu7DZ3LQqAB2mOyJzOmLKcp9OabGB6rHDJ8dC/OiAtZKxSG84mrz7JHxtSK7ISrnVix
         QW4Q==
X-Gm-Message-State: AJIora9UO7KmDG7fwjrBT3oT84CwjeL2GhVGxohoouh4esrR1xo2ilv8
        LUXuvV7G7VK20qdNW3rktsmblvEzY9DuRRJyL3ipzrek7cMHcA==
X-Google-Smtp-Source: AGRyM1tkz1UQmNj0W2XVz/Mg5nLFFI+qNgQyF9yIb5B7QEa17mi008TukJ3WxDqnzZsxA/q0w9Cgqn0rl2BEfhIOKkI=
X-Received: by 2002:a2e:3018:0:b0:25d:5ba0:d20a with SMTP id
 w24-20020a2e3018000000b0025d5ba0d20amr11054758ljw.24.1657630833191; Tue, 12
 Jul 2022 06:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAKSRnEzMaQEv=3mkNWRpy6+-c0rz=R191iqheCQ2ptXFs1CQgw@mail.gmail.com>
 <96034b3f-9811-38c1-7afe-c1c9dd243f0e@github.com> <CABPp-BHv3TSJhnWSF8AjF_nr72vMnOFXZJKoG0juGwjz13TZ=w@mail.gmail.com>
 <c5662c60-4a21-be94-8fe0-13c6730292dd@github.com> <CABPp-BFRHjF7+9T8dGG=ixsezksZUNU7pm29MG2kcLEYwE06Og@mail.gmail.com>
 <CAKSRnEx2seC41QCe8sQOPf0=VNqHB6GkZ3M_CpGmOZRS0FS1gA@mail.gmail.com>
 <CABPp-BHgwaWNEJnSer0-jw8+53NDuRWLvtXp4U_JJ8T_t-bTpQ@mail.gmail.com>
 <CAMwyc-Q7dEwo7AzFTYXrX-0i+b80ikzv_MCzTr7ZKaCPKwcERw@mail.gmail.com>
 <CAKSRnEwda+WomBQbvjZ+hry+k2vGO4ukR42f66tHqxO7LdU_sA@mail.gmail.com> <CABPp-BEkJQoKZsQGCYioyga_uoDQ6iBeW+FKr8JhyuuTMK1RDw@mail.gmail.com>
In-Reply-To: <CABPp-BEkJQoKZsQGCYioyga_uoDQ6iBeW+FKr8JhyuuTMK1RDw@mail.gmail.com>
From:   Dian Xu <dianxudev@gmail.com>
Date:   Tue, 12 Jul 2022 09:00:21 -0400
Message-ID: <CAKSRnEz6xg6jiTqaVtYf+32kEzS0jydiajbTnvK7qy_Po=y=uA@mail.gmail.com>
Subject: Re: git bug report: 'git add' hangs in a large repo which has
 sparse-checkout file with large number of patterns in it
To:     Elijah Newren <newren@gmail.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Victoria Dye <vdye@github.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 7, 2022 at 9:53 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Tue, Jul 5, 2022 at 6:08 AM Dian Xu <dianxudev@gmail.com> wrote:
> >
> > Hi Elijah,
>
> Hi Dian,
>
> Please don't top post on this list.  It'd also help to respond to the
> relevant email instead of picking a different email in the thread to
> put your answers in.  Anyway, that aside...
>
> > Please see answers below:
> >
> > 1.  H: 2.27m; S: 7.7k; Total: 2.28m
> >
> > 2.  Sure I will run 'reapply' after the sparse-checkout file has
> > changed. Just curious, do I have to run 'reapply' if 'checkout' is the
> > next immediate cmd? I thought 'checkout' does the updating index as
> > well
> >
> > 3.  I simply added one file only, 'git add' and 'git add --sparse'
> > still hang. Let me know if you need me to send you any debug info from
> > pathspec.c/dir.c
> >
> > 4.  Good to know and we are investigating if we have a way out from --no-cone
> >
> > 5.  I should've been clearer: The experiment done here uses 2.37.0
>
> Thanks for providing these details.  It was enough to at least get me
> started, and from my experiments, it appears the arguments to `git
> add` are important.  In particular, I could not trigger this when
> passing actual filenames that existed.  I could when passing a fake
> filename.  Here's the concrete steps I used to reproduce:
>
>     git clone git@github.com:newren/gvfs-like-git-bomb
>     cd gvfs-like-git-bomb
>
>     git init attempt
>     cd attempt
>     ../make-a-git-bomb.sh
>
>     time git checkout bomb
>
>     echo "/*" >.git/info/sparse-checkout
>     echo '!/bomb/j/j/' >>.git/info/sparse-checkout
>     for i in $(seq 1 10000); do
>         printf '!some/random/file/path-%05d\n' $i
>     done >>.git/info/sparse-checkout
>     git config core.sparseCheckout true
>     time git sparse-checkout reapply
>
>     echo hello >world
>     time git add --sparse world nonexistent
>     time git rm --cached --sparse world nonexistent
>     time git add world nonexistent
>     time git rm --cached world nonexistent
>
> This sequence of steps will (1) clone a repo with 2 files, (2) create
> another repository in subdirectory 'attempt' that has 1000001 files
> (but only two unique files, and only six or so unique trees) in a
> branch called 'bomb', (3) check it out, (4) create 10002 patterns for
> the sparse-checkout file (only the first 2 of which match anything)
> which will leave ~99% of files still present (990001 files checked out
> and 10000 files sparse) and turn on sparsity, (5) measure how long it
> takes to add and remove a file from the index, both with and without
> the --sparse flag, but always listing an extra path that won't match
> anything.
>
> The timings I see for the setup steps are:
>     4m10.444s  checkout bomb
>     1m0.380s   sparse-checkout reapply
>
> And the timings for the add/rm steps are:
>     4m43.353s  add --sparse world nonexistent
>     9m25.666s  add world nonexistent
>     0m0.129s  rm --cached --sparse world nonexistent
>     9m23.601s  rm --cached world nonexistent
>
> which shows that 'rm' also has a performance problem without the
> '--sparse' flag (which seems like another bug).
>
> Now, if I remove the 'nonexistent' argument from the commands, then
> the timings drop to:
>     0m0.236s   add --sparse world
>     0m0.233s   add world
>     0m0.175s   rm --cached --sparse world
>     4m43.744s  rm --cached world
>
> So, I can reproduce some slowness.  'rm' without --sparse seems
> buggily slow for either set, whereas 'add' is only slow when given a
> fake path.  You never mentioned anything about the arguments you were
> passing to `git add`, so I don't know whether you are using specific
> filenames that just don't exist (like I did above), or globs that
> perhaps match some files, or something else.  That might be useful to
> know.  But there appears to be something here for both 'add' and 'rm'
> that we could look into optimizing.  I don't have time right now.  I'm
> not sure if someone else has some time to look into it; if no one else
> does, I'll eventually try to get back to it.

Hi Elijah,

Thank you for sharing the reproduction steps. I believe they represent
our workflow.

We use 'git add <path_to_file>', where path_to_file is an existing
file, which is also within sparse-checkout shape.

Not sure this is related but we also use --reference while setting up the clone.

Dian Xu
Mathworks, Inc
1 Lakeside Campus Drive, Natick, MA 01760
508-647-3583
