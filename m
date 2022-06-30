Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE9CC433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 00:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiF3AHJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 20:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiF3AHI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 20:07:08 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89652252B0
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 17:07:04 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id fi2so35670647ejb.9
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 17:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JjaXEPxT6rSSEMEFMQtBInTg3Tk6aFB7NO/VuHpdqMQ=;
        b=SIziIdIZEy2ow4fpfQXouNjyesmofoHGHnqCkOXaEZ3GRwibm+WY+RnOYYRhkx4t6e
         lgsi2TsSx5uf5uj/sOtpehglo/yiIosG63STbVS454KXPDmowSZ60eFcuDmrVs3tRMb+
         Lrc91j33RfZV990aHVpFagC2Rjqo+wFIdse/rmMfUVW29hk4WfyJM8UaHmsyNw9y3R/m
         2CkjiFxWRnIJQ7S7Q004PQ2+2ATiGJF8+FJhxORQRgTK4PQrZX/vUtTneYB2xsuvdZ3L
         hTsDMSdepyPD7ucKkMJ+1wVnGwbv1vWbh8977akEfTtA36cB1RJoI/Poyb83kCmDZmx5
         4wUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JjaXEPxT6rSSEMEFMQtBInTg3Tk6aFB7NO/VuHpdqMQ=;
        b=1X+wGXUBMCjDxs+dPvQIjwNiOlIutzVWUMG0KkVMGuiMkpTvNu6EEUWC4w1ql+RxCB
         kMT0epkFimr9DjSrwuz2kCXWhsMDeEjsn1gUxORkFEp2FdknXZhE6tqDviiDez0if9Cm
         6W/HUQOiNjXVMRYfK+O/k2eAbhcCr2kPZN6oNZo/Uo/sAmUGDQAGBLn7lDxrJNyZ3Sh9
         9PNSTGbfToz6jVmqQuxZNT8NcNfycfUQ/Rc5LMZeUVBuD0zjCqxjSCxLlO4bHdUgRijV
         oqnZ4VrTCfkqFJ+mmfXcqfLrK0izx3XCQzwm/tSGle5MRe0AeT2YVB2W1nOqqPvkiiIY
         Py7Q==
X-Gm-Message-State: AJIora9M4iOdVnaxeljYU8ZTFNdP+L6a2X5B/JfhkVS1sVR3h9jD5bXL
        KoB8Gs2KNY6RMpDwplHZfi8qRm7pj2N6cYk1iDsoodNvFT4=
X-Google-Smtp-Source: AGRyM1tcSNiUz3r2kgtPxWDCWwt3dkMx0CbDRp6guHNlHQLnDVkmXpQ62ZYACCb1vuPMIx6OtuzOdP3y4Qyo+Nj7Zts=
X-Received: by 2002:a17:907:728a:b0:726:d6c8:d95c with SMTP id
 dt10-20020a170907728a00b00726d6c8d95cmr5952364ejc.269.1656547623089; Wed, 29
 Jun 2022 17:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <69d6204184363e491acb68f744ded0991be63a47.1655871652.git.gitgitgadget@gmail.com>
 <20220627182024.1358144-1-jonathantanmy@google.com>
In-Reply-To: <20220627182024.1358144-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 29 Jun 2022 17:06:51 -0700
Message-ID: <CABPp-BGtKQVgaf9ttwRMAE6AvH1QC3TqFcFwiAOpnm-SqKnNCQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] t6423: add tests of dual directory rename plus
 add/add conflict
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 27, 2022 at 11:20 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > This is an attempt at minimalizing a testcase reported by Glen Choo
> > with tensorflow where merge-ort would report an assertion failure:
> >
> >     Assertion failed: (ci->filemask == 2 || ci->filemask == 4), function apply_directory_rename_modifications, file merge-ort.c, line 2410
>
> First of all, thanks for this fix - I've verified with Glen Choo's test
> cases and it does fix it.

:-)

> > diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
> > index 479db32cd62..296c04f8046 100755
> > --- a/t/t6423-merge-rename-directories.sh
> > +++ b/t/t6423-merge-rename-directories.sh
> > @@ -5199,6 +5199,108 @@ test_expect_success '12k: Directory rename with sibling causes rename-to-self' '
> >       )
> >  '
> >
> > +# Testcase 12l, Both sides rename a directory into the other side, both add
> > +#   a file with after directory renames are the same filename
> > +#   Commit O: sub1/file,                 sub2/other
> > +#   Commit A: sub3/file,                 sub2/{other, new_add_add_file_1}
> > +#   Commit B: sub1/{file, newfile}, sub1/sub2/{other, new_add_add_file_2}
> > +#
> > +#   In words:
> > +#     A: sub1/ -> sub3/, add sub2/new_add_add_file_1
> > +#     B: sub2/ -> sub1/sub2, add sub1/newfile, add sub1/sub2/new_add_add_file_2
> > +#
> > +#   Expected: sub3/{file, newfile, sub2/other}
> > +#             CONFLICT (add/add): sub3/sub2/new_add_add_file
>
> The "expected" might need to be updated.

Oops!  Yes, I kept changing and editing the testcase and the
comments...but didn't quite get all the updates I needed when I was
revising.

> After all patches are applied,
> this is the tree I get (note that it's "sub1/sub2/new_add_add_file, not
> "sub3/sub2/new_add_add_file"):
>
>   .
>   |-- sub1
>   |   `-- sub2
>   |       `-- new_add_add_file
>   `-- sub3
>       |-- file
>       |-- newfile
>       `-- sub2
>           `-- other

Yes, that's right.

> Also, at first glance, "newfile" shouldn't belong in a minimal
> reproduction

Ah, I can see you've looked at this very closely.  Thanks for digging
in!   I know it's counter-intuitive at first, but the file is
necessary in order to get the sub1/ -> sub3/ rename.  The reasoning is
as follows: We don't need to detect a directory rename for a directory
where the other side added no new files into that directory...because
the whole point of directory renames is to move new files in a
directory to the new location.  Therefore, no new files in the
directory on one side, means no need to detect a directory rename for
it on the other side.  For a deeper discussion of this, see commit
c64432aacd (t6423: more involved rules for renaming directories into
each other, 2020-10-15).


>, but it somehow changes the output. When I apply this diff
> (to the state after all patches are applied):
>
>   diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
>   index 4286ae987c..9472fb7233 100755
>   --- a/t/t6423-merge-rename-directories.sh
>   +++ b/t/t6423-merge-rename-directories.sh
>   @@ -5237,7 +5237,6 @@ test_setup_12l () {
>
>                   git checkout B &&
>                   echo dissimilar >sub2/new_add_add_file &&
>   -               echo brand >sub1/newfile &&
>                   git add sub1 sub2 &&
>                   git mv sub2 sub1 &&
>                   test_tick &&
>   @@ -5255,14 +5254,14 @@ test_expect_merge_algorithm failure success '12l (B into A): Rename into each ot
>                   test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 &&
>
>                   git ls-files -s >out &&
>   -               test_line_count = 5 out &&
>   +               test_line_count = 4 out &&
>
>                   git rev-parse >actual \
>   -                       :0:sub3/file :0:sub3/newfile :0:sub3/sub2/other \
>   +                       :0:sub3/file :0:sub3/sub2/other \
>                           :2:sub1/sub2/new_add_add_file \
>                           :3:sub1/sub2/new_add_add_file &&
>                   git rev-parse >expect \
>   -                       O:sub1/file  B:sub1/newfile O:sub2/other \
>   +                       O:sub1/file  O:sub2/other \
>                           A:sub2/new_add_add_file \
>                           B:sub1/sub2/new_add_add_file &&
>                   test_cmp expect actual &&
>
> I get:
>
>   .
>   |-- sub1
>   |   `-- sub2
>   |       |-- new_add_add_file
>   |       `-- other
>   `-- sub3
>       `-- file
>
> (Note the path to "other".) I haven't figured out what's going on,
> though.

Yeah, this is the result of having no directory rename due to having
no new files that need to be moved by a directory rename.
