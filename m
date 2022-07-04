Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EACDC43334
	for <git@archiver.kernel.org>; Mon,  4 Jul 2022 19:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiGDTYE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jul 2022 15:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiGDTYD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jul 2022 15:24:03 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391EE958B
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 12:24:02 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id fw3so18152720ejc.10
        for <git@vger.kernel.org>; Mon, 04 Jul 2022 12:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DAeNREmUI5bMIvU8th9J9dGe4/mdJ9smY8v9cUy2mR0=;
        b=lkNt9bC4d7ZCy+iqh2+xpc87YPIrPEMz9BbNye4JSnLZ4OHPQfvlXlyka8FMlc9jPV
         o9rIzQVsSjOegI0YIPr9QCu33FyQTpgaE+i43nC5OUIhxnI4mvwuElkp23NCiDQR0Whe
         SD+pLP3UB+2tzukiiyP02SKcUKfV0stMNarHfsQHcS9o7SXqURKs+aeElctgwAnQe47W
         Q8WVy93KYHtVpU0wT3CcyCDpMH4xGvFKdgG2P4ZRKmK2ZSiB7g43VJ1kHyIF3gcx1iDB
         cecjvVm9A+thut80o5gcHieOXhiqhIhBGkEH6DN1oD2GNOJVzVXJjJWt9iYn/MB3hgBZ
         Y3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DAeNREmUI5bMIvU8th9J9dGe4/mdJ9smY8v9cUy2mR0=;
        b=8KaY4j5zuUS7t92itrmrYqz1rRk/gltNTW6gdSzQB/RB+iduK6OKuZJmL11zevee2c
         4PDwCyA92RvtxsFh5W1yrymP5uRC9qEcW/rfvrJPlj3c2Jj4QfJKQJNnCdnVzqoQCm5z
         EBrqzNfcc2VIrQWw+gC4hBibPVzYsv3shkqvi+iCjkufQ7ISvUmx543xWPHGfUewt5SK
         JqPdLxhc0OWXU5I5O/qTfsk0yBwES6N7fskcL9fFIiR1kXwQsI/tvNb/837piBDrEl6Y
         0/XH9NrNxxIzA4so2ASzZ8Hrs7IB9PHdqcaTGHnu5j6r6bzZElbSwlkPNqaLTIZ131HM
         HaAg==
X-Gm-Message-State: AJIora9oYPKbZXaB7aECxrzdJ6DZYaZDylh7Rx1vwdnF1N12tobM0YGa
        +i7Lh7/Fsfj4lzK+rSnrBXjfHhYJg/pE8+mmC6UMysU5xKc=
X-Google-Smtp-Source: AGRyM1tqAQYnaiErMXxJroWDQCgYkMtG0HcGuuhudirCSqz/gTUPyWuh5VyCQCotFyyjXiXfC+WgHt1TWxdfFZMTYIY=
X-Received: by 2002:a17:906:99c5:b0:6ff:4c8f:6376 with SMTP id
 s5-20020a17090699c500b006ff4c8f6376mr30272015ejn.328.1656962640783; Mon, 04
 Jul 2022 12:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhVC3Z92hBsK0FbE4E_LV1CSxjR1zmu+MO8=iwR02BKqnwgUA@mail.gmail.com>
In-Reply-To: <CAMhVC3Z92hBsK0FbE4E_LV1CSxjR1zmu+MO8=iwR02BKqnwgUA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 4 Jul 2022 12:23:49 -0700
Message-ID: <CABPp-BEkEKQZR=1duxSS4AVv9u5tnPk5CaLCM_fQWPbAqfSMxw@mail.gmail.com>
Subject: Re: Why `git am -3` apply patches that don't normally apply?
To:     Yuri Kanivetsky <yuri.kanivetsky@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 3, 2022 at 6:09 AM Yuri Kanivetsky
<yuri.kanivetsky@gmail.com> wrote:
>
> Hi,
>
> From what I can see w/o `-3` `git am` follows the `patch`'es behavior.
> And the `patch`'es behavior is if there are lines in a patch that
> doesn't match the lines in the source file, it fails. For example, a
> source file:
>
> 11
> 2
> 3
>
> A patch:
>
>  1
>  2
> -3
> +33
>
> But `git am -3` will apply such a patch.

Will apply the changes, but they might result in conflicts; it depends
on what you apply it to.

> That is, `patch` sees that
> the first line changed and that prevents it from applying the patch,
> but `git am -3` decides that it's okay. Why is that?

Because `git am -3` is doing a three-way merge, as requested, where it
is no longer using a patch with changes and a context region but
instead has three full files that it can three-way merge.  Let's dive
into your example to explain...

> A script that reproduces the issue:
>
>     set -eux
>
>     mkdir a
>     (cd a
>     git init
>     echo '1
>     2
>     3' > a
>     git add a
>     git commit -m 1,2,3
>     sed -Ei 's/3/33/' a
>     git add a
>     git commit -m '3 -> 33'
>     git format-patch -1 HEAD)

So you have a repository with two commits.  Also, format-patch puts
references to the before-and-after blob hashes of the file 'a' into
the diff.

>     mkdir b
>     (cd b
>     git init
>     echo '11
>     2
>     3' > a
>     git add a
>     git commit -m 11,2,3
>
>     git remote add a ../a
>     git fetch a

So 'b' is a repository with 3 commits; 1 that you added to it
directly, and 2 that you fetched into it from your other repository.

If you had not done the fetch from 'a' into 'b', attempting to "git am
-3" the patch you created earlier would fail.

>     cat a
>     cat ../a/0001-3-33.patch
>     git --no-pager log --oneline --graph --all
>     git am "$@" ../a/0001-3-33.patch  # try it w/ and w/o -3

As per the documentation of -3:

        When the patch does not apply cleanly, fall back on
        3-way merge if the patch records the identity of blobs
        it is supposed to apply to and we have those blobs
        available locally.

format-patch records the identity of the blobs, and your fetch made
sure your 'b' repository has them.  So, it knows the base version of
the file has the following complete contents
    1
    2
    3
and the version from the patch has the following complete contents
    1
    2
    33
The version in HEAD you are using in the three-way merge has the
following contents
    11
    2
    3
Note that here we are not dealing with limited context, but with the
full copies of the files.  Now, doing a three-way merge, we see that
the line with '2' is common in all three versions.  The first line was
changed from 1->11 on the HEAD side (and left alone on the other
side), and the last line was changed from 3->33 on the other side
(while being left alone on the HEAD side).  The three-way merge of
these is simply
    11
    2
    33

So `git am -3` succeeds without conflicts for this case.
