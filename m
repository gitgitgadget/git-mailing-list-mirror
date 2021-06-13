Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8720C48BCF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 06:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8D2F61009
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 06:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFMHAG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 03:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhFMHAG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 03:00:06 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E71BC061574
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 23:57:50 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id q5-20020a9d66450000b02903f18d65089fso7614767otm.11
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 23:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4RhlfPZT6k5dycUA/MdgJUdEOvW5DMEFs25+qxS+tiY=;
        b=iOs7P0lstSYVHjHl5XtIiWi9BkB/VOyQ0/hLRpcij+fm2RDq/IgjpdPgTmHvDZQSJn
         ftjUmzktzSKXQmzSnpLgCiTfSlvGeFwiVn7G57wTwyaplXSTuejd2bCWZbkjXINfGd1/
         CJsPZVqmE9ZBc56U3rKQau6C33yVneBD/UeArFPBXwJpop7nu/3GuhfxUBTefCIhZxF+
         IXU9LyTsH0APogwvguRyHRzsUKg//wmoMJLTpeQlykwNkHhzBcyku8p48GcXDxxPYhOQ
         EEWQKBQSVBuqauQD0QMwb1WfYLV2PkuQBD3D2P5B2hToCO5URfbiaoct55U7ml85aaE+
         lBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4RhlfPZT6k5dycUA/MdgJUdEOvW5DMEFs25+qxS+tiY=;
        b=B1wbI45ymZTTd68vX0ct47z+iyL54ehOdzWMfdHVgT7+p1L3pbwwMfvEg+W7+DiXFU
         xINbptCZImW7QQZMDwPSMXLx+tqLBwGe2g71DCzMiQvxl0T3TybE7hns0Q6rw8uBX3Q9
         /GSc54zIHxW22GVfRb5kl1MrKwLdrL9BuzJ8KaISNWTJEKMa8qQ2gckfy0peZJ7v5yQ8
         a0/PeSxAIw/yVoR5qcmx7mBKq4Tk02W/WvKQvZApmx2WCpZeauHjWqdFtI7AHbOWcsZr
         WCQxT+OTbFCz2Xa56sh7JOxlA8za+vrc+eOFzRs7x36zWyTj1Tj7+zdFNi1gvPPFfKuW
         JOVA==
X-Gm-Message-State: AOAM533Jgo64u8Yq9zmBZdpFI3qOcpcAi227R5tYCc4cOglw8rYIKak9
        Dpcq+pts1CZ3PWAHjS4OooOhyYkS4C8A1u3G6UY=
X-Google-Smtp-Source: ABdhPJyK5MpHvHL9GHaHEENGRbdZOdYaDkxdaKA+pzkh8rc5HrB63LWPp48f3wKHHGUsL5Splidtxfhgy0vB2feF8as=
X-Received: by 2002:a9d:1a8:: with SMTP id e37mr9032191ote.316.1623567469271;
 Sat, 12 Jun 2021 23:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <148044c89c194a82aa15ab0ca016669d@oc11expo7.exchange.mit.edu>
In-Reply-To: <148044c89c194a82aa15ab0ca016669d@oc11expo7.exchange.mit.edu>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 12 Jun 2021 23:57:38 -0700
Message-ID: <CABPp-BGDfucqae=HNES_QmmsjpDbdHrR6CG=H3gtiDygHzquVg@mail.gmail.com>
Subject: Re: v2.25 regression: cherry-pick alters patch and leaves working
 tree dirty
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 12, 2021 at 12:34 AM Anders Kaseorg <andersk@mit.edu> wrote:
>
> I ran into a problem where git cherry-pick incorrectly alters a patch tha=
t should apply cleanly, and leaves the working tree dirty despite claiming =
to finish successfully. I minimized the problem to the reproduction recipe =
below. Bisecting git.git shows the problem was introduced by 49b8133a9ece19=
9a17db8bb2545202c6eac67485 (v2.25.0-rc0~144^2~1) =E2=80=9Cmerge-recursive: =
fix merging a subdirectory into the root directory=E2=80=9D, and it remains=
 a problem in v2.32.0.
>
> To reproduce:
>
> git init
> echo foo >foo
> echo bar >bar
> echo baz >baz
> git add foo bar baz
> git commit -m 'Initial commit'
> mkdir dir
> git mv foo dir/foo
> git commit -am 'Move foo'
> git mv bar dir/bar
> echo baz >>baz
> git commit -am 'Move bar'
> git tag move-bar
> git reset --hard move-bar~2
> git cherry-pick move-bar
>
> The rename part of the patch has been unexpectedly lost, and =E2=80=98bar=
=E2=80=99 has been unexpectedly deleted from the working tree:
>
> $ git show
> commit f06592b45db70540983a6c3e8bcf62712c694257
> Author: Anders Kaseorg <andersk@mit.edu>
> Date:   Sat Jun 12 00:20:13 2021 -0700
>
>     Move bar
>
> diff --git a/baz b/baz
> index 7601807..1f55335 100644
> --- a/baz
> +++ b/baz
> @@ -1 +1,2 @@
>  baz
> +baz
>
> $ git status
> On branch master
> Changes not staged for commit:
>   (use "git add/rm <file>..." to update what will be committed)
>   (use "git restore <file>..." to discard changes in working directory)
>         deleted:    bar
>
> no changes added to commit (use "git add" and/or "git commit -a")
>
> Before 49b8133a9e, the results are as expected:
>
> $ git show
> commit b7a2a3505dae3589203ca4469cb49e8a8e2727c3
> Author: Anders Kaseorg <andersk@mit.edu>
> Date:   Sat Jun 12 00:23:07 2021 -0700
>
>     Move bar
>
> diff --git a/baz b/baz
> index 7601807..1f55335 100644
> --- a/baz
> +++ b/baz
> @@ -1 +1,2 @@
>  baz
> +baz
> diff --git a/bar b/dir/bar
> similarity index 100%
> rename from bar
> rename to dir/bar
>
> $ git status
> On branch master
> nothing to commit, working tree clean
>
> Anders

Thanks for the detailed report, and going the extra mile to come up
with a simple testcase.  Very helpful.

There's two bugs here, and they actually predate v2.25.  If you put
all your files in a subdirectory (e.g. 'subdir/bar' instead of 'bar'
and 'subdir/dir/bar' instead of 'dir/bar'), then the same bug
reproduces going back many more versions.  The changes in v2.25 to
support directory rename detection of a subdirectory to the root just
allowed this bug to happen at the toplevel as well.

Also, one of the two bugs affects merge-ort (in addition to merge-recursive=
).

I've got a one-liner fix to merge-ort.c, plus two additional lines
changed to audit for similar bugs in merge-ort and make sure they just
can't happen.  I was hoping to also have patches to fix
merge-recursive as well, but despite spending more time on it than on
merge-ort, I wasn't yet able to track down either of those two bugs.
I'll try again next week.
