Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B58BC43334
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 01:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbiGHBxQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 21:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiGHBxP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 21:53:15 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1C132EFD
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 18:53:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a9so5641743ejf.6
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 18:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XLqtJ/HdPzISxu9TN50860/remy8/bD2slduUba0Cmg=;
        b=Uyp66hjy792q4G+4lLhnGh/mbv5cUmQ81EHizMvZY3RlfFx3bRsS35fJKW/+sKZXJH
         XO+GVD6J/gcIpBqtpHP7xLANy5skBEy1kJXG+w/JPeWcsZ327fdb95yWJVCOa9JuSN41
         LYCWjWi0bKHhwzeLEdRG5no/c3ZX+RNImav8Th2foC67AOcJgb5mAgSm6ve2UWa3Prrb
         WgtG0DYvjcRQeGolPEToNxIBouheWg2RhGhZJ79pOe6lFIgfQ++Ut/nz+5CVvvL/FBcc
         KSljX70gaULMw4TljnbsVi1h5ozNiH08wDV0eEZGz86ju+tuSM1ecOz97Rrq+L1dH3AN
         e81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XLqtJ/HdPzISxu9TN50860/remy8/bD2slduUba0Cmg=;
        b=yDuoWQJQSceqi9q8fpfQPkhjywRMsGRwwN38PZyoYh+2w0S/KSnBUnfU9vbYK6CT6k
         jjqjgi/ybcUDCWGAaDKZdEbXPGnmyYQ2WVcx7UmftT5rflZe7OEXELIq5MZaYKlGOFdY
         EMwLkc9iOMmoWo9L76MB3zg93T3tGC7JRl1IiCwZ1YNcMDXPbNzJxc3VfjeANPF1c+7f
         YZSpEe2JpxkhIZXVIQDv6MLCBvk17p4LspV5Hz3g0bRZ1Fv4GWGafSkG6ls1V060K0i1
         nMN0lupNBawO5OkaVioaPqxVBY6LvR562zP7N6jqmSJNpAS8SCeXgU2GXtpgF3Va5WQI
         QBmQ==
X-Gm-Message-State: AJIora/rAHzAyrLW+I0uX7a8AcL9o7N3+BOUeXaDVzeCthLGi1wFMmA9
        ss57Ohzj4+t1fiCtn2qsOM3DF8qSArDX35tuAm4=
X-Google-Smtp-Source: AGRyM1vviEdf/PTIbRx2YihQL9H2hBWpf0fToiv1OwruJLL2nmRsTof9RLcxrru7BrzYg7D+7H7jb7igjGm1FE7pBao=
X-Received: by 2002:a17:906:7049:b0:70c:a5fe:d4f8 with SMTP id
 r9-20020a170906704900b0070ca5fed4f8mr1030009ejj.493.1657245191679; Thu, 07
 Jul 2022 18:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAKSRnEzMaQEv=3mkNWRpy6+-c0rz=R191iqheCQ2ptXFs1CQgw@mail.gmail.com>
 <96034b3f-9811-38c1-7afe-c1c9dd243f0e@github.com> <CABPp-BHv3TSJhnWSF8AjF_nr72vMnOFXZJKoG0juGwjz13TZ=w@mail.gmail.com>
 <c5662c60-4a21-be94-8fe0-13c6730292dd@github.com> <CABPp-BFRHjF7+9T8dGG=ixsezksZUNU7pm29MG2kcLEYwE06Og@mail.gmail.com>
 <CAKSRnEx2seC41QCe8sQOPf0=VNqHB6GkZ3M_CpGmOZRS0FS1gA@mail.gmail.com>
 <CABPp-BHgwaWNEJnSer0-jw8+53NDuRWLvtXp4U_JJ8T_t-bTpQ@mail.gmail.com>
 <CAMwyc-Q7dEwo7AzFTYXrX-0i+b80ikzv_MCzTr7ZKaCPKwcERw@mail.gmail.com> <CAKSRnEwda+WomBQbvjZ+hry+k2vGO4ukR42f66tHqxO7LdU_sA@mail.gmail.com>
In-Reply-To: <CAKSRnEwda+WomBQbvjZ+hry+k2vGO4ukR42f66tHqxO7LdU_sA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 7 Jul 2022 18:53:00 -0700
Message-ID: <CABPp-BEkJQoKZsQGCYioyga_uoDQ6iBeW+FKr8JhyuuTMK1RDw@mail.gmail.com>
Subject: Re: git bug report: 'git add' hangs in a large repo which has
 sparse-checkout file with large number of patterns in it
To:     Dian Xu <dianxudev@gmail.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Victoria Dye <vdye@github.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 5, 2022 at 6:08 AM Dian Xu <dianxudev@gmail.com> wrote:
>
> Hi Elijah,

Hi Dian,

Please don't top post on this list.  It'd also help to respond to the
relevant email instead of picking a different email in the thread to
put your answers in.  Anyway, that aside...

> Please see answers below:
>
> 1.  H: 2.27m; S: 7.7k; Total: 2.28m
>
> 2.  Sure I will run 'reapply' after the sparse-checkout file has
> changed. Just curious, do I have to run 'reapply' if 'checkout' is the
> next immediate cmd? I thought 'checkout' does the updating index as
> well
>
> 3.  I simply added one file only, 'git add' and 'git add --sparse'
> still hang. Let me know if you need me to send you any debug info from
> pathspec.c/dir.c
>
> 4.  Good to know and we are investigating if we have a way out from --no-cone
>
> 5.  I should've been clearer: The experiment done here uses 2.37.0

Thanks for providing these details.  It was enough to at least get me
started, and from my experiments, it appears the arguments to `git
add` are important.  In particular, I could not trigger this when
passing actual filenames that existed.  I could when passing a fake
filename.  Here's the concrete steps I used to reproduce:

    git clone git@github.com:newren/gvfs-like-git-bomb
    cd gvfs-like-git-bomb

    git init attempt
    cd attempt
    ../make-a-git-bomb.sh

    time git checkout bomb

    echo "/*" >.git/info/sparse-checkout
    echo '!/bomb/j/j/' >>.git/info/sparse-checkout
    for i in $(seq 1 10000); do
        printf '!some/random/file/path-%05d\n' $i
    done >>.git/info/sparse-checkout
    git config core.sparseCheckout true
    time git sparse-checkout reapply

    echo hello >world
    time git add --sparse world nonexistent
    time git rm --cached --sparse world nonexistent
    time git add world nonexistent
    time git rm --cached world nonexistent

This sequence of steps will (1) clone a repo with 2 files, (2) create
another repository in subdirectory 'attempt' that has 1000001 files
(but only two unique files, and only six or so unique trees) in a
branch called 'bomb', (3) check it out, (4) create 10002 patterns for
the sparse-checkout file (only the first 2 of which match anything)
which will leave ~99% of files still present (990001 files checked out
and 10000 files sparse) and turn on sparsity, (5) measure how long it
takes to add and remove a file from the index, both with and without
the --sparse flag, but always listing an extra path that won't match
anything.

The timings I see for the setup steps are:
    4m10.444s  checkout bomb
    1m0.380s   sparse-checkout reapply

And the timings for the add/rm steps are:
    4m43.353s  add --sparse world nonexistent
    9m25.666s  add world nonexistent
    0m0.129s  rm --cached --sparse world nonexistent
    9m23.601s  rm --cached world nonexistent

which shows that 'rm' also has a performance problem without the
'--sparse' flag (which seems like another bug).

Now, if I remove the 'nonexistent' argument from the commands, then
the timings drop to:
    0m0.236s   add --sparse world
    0m0.233s   add world
    0m0.175s   rm --cached --sparse world
    4m43.744s  rm --cached world

So, I can reproduce some slowness.  'rm' without --sparse seems
buggily slow for either set, whereas 'add' is only slow when given a
fake path.  You never mentioned anything about the arguments you were
passing to `git add`, so I don't know whether you are using specific
filenames that just don't exist (like I did above), or globs that
perhaps match some files, or something else.  That might be useful to
know.  But there appears to be something here for both 'add' and 'rm'
that we could look into optimizing.  I don't have time right now.  I'm
not sure if someone else has some time to look into it; if no one else
does, I'll eventually try to get back to it.
