Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9AFC76195
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 10:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbjC0KLg convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 27 Mar 2023 06:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbjC0KLc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 06:11:32 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922D95264
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 03:11:28 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id x15so7212974pjk.2
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 03:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679911888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=meVel8Z3YGLpaVi5ExpkTEvO9Onf2jRVMfGA8U6qXgE=;
        b=BI1AFuUsyh6FkZRG7oOIRWIkcm0ghvMnwaDlys7p4mIAX+apo//meA+saZxtAqYcJy
         2HU0rU8li6KZxMdsWkyGNvHdDhi8R6iz7kLgYVd3naiHINWLX1xldtpVitkEPs6XHRHm
         xAg9f7TJGCD51xs4g/kp4s7LHdF6w4t0VgWqUd8UNlzZNy9aPc1UvsWUgxF8CSANtK0R
         JTxjAQLUHMXEWMkbYT/U3sdEQ+Io7v3ySVSUWZbPZIGN9IWgrivZ+3Spqh6MnUFMHQVA
         6t+yo/HvqJledhaRxt+lDtUMkzRnpNT8DbzVWBCxXpSr7bNCe6QlI4DM1RV/BlA+tOH3
         Fh+g==
X-Gm-Message-State: AAQBX9cP/zedthKNAeJodYZVNrYvZ+645U2YGO2JVtRWrjxnTuUs37L6
        +gTbkeeo9ge/YsQVrV9z9yidgxzAp6w4zIAXjYle4UcNiGg=
X-Google-Smtp-Source: AKy350Y/AVISMm/ekB6Pnb9wXM3xBPPJxs22SV3c4Qbg9U9GOVg5j5w1Bcxj3l7H+KsXvLcQxxP1O+BcU3Z6ZWLbeEM=
X-Received: by 2002:a17:902:b195:b0:19f:3aa9:9ea1 with SMTP id
 s21-20020a170902b19500b0019f3aa99ea1mr4203167plr.8.1679911887831; Mon, 27 Mar
 2023 03:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230326173147.39626-1-edwinfernando734@gmail.com>
 <20230326173147.39626-2-edwinfernando734@gmail.com> <be2f23ec-4b3c-eb9f-fc2d-fecdf76604e1@gmail.com>
In-Reply-To: <be2f23ec-4b3c-eb9f-fc2d-fecdf76604e1@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 27 Mar 2023 06:11:16 -0400
Message-ID: <CAPig+cRS5M65MskbWKBuqtzuGUMjibbBHpTBDxLYEJF33aJX4Q@mail.gmail.com>
Subject: Re: [GSOC][PATCH 1/1] t3701: Avoid suppression of exit status of git
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     Edwin Fernando <edwinfernando734@gmail.com>, vdye@github.org,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 26, 2023 at 4:21 PM Andrei Rybak <rybak.a.v@gmail.com> wrote:
> On 26/03/2023 19:31, Edwin Fernando wrote:
> In subject line "t3701: Avoid suppression of exit status of git" -- the first
> word after a colon shouldn't be capitalized.  By the way, similar existing
> commits call it:
>    don't lose "git" exit codes
> and
>    preserve "git" exit codes

Thanks, your review comments covered almost everything I was going to
say, and I agree with all you said, so I'll just add a couple comments
not covered by your review.

> > +     git show :file > show_file &&
>
> Code style here and in all output redirections below: lose the space between
> redirection and the path, like so:
>    git show :file >show_file
>
> Also, the suffix "_file" is unnecessary.  Just
>    git show :file >show
> or
>    git show :file >out
> or
>    git show :file >actual
> might be better.

Fully agree with either of the latter two suggestions.

> > @@ -311,9 +315,12 @@ test_expect_success FILEMODE 'stage mode and hunk' '
> > -     git diff --cached file | grep "new mode" &&
> > -     git diff --cached file | grep "+content" &&
> > -     test -z "$(git diff file)"
> > +     git diff --cached file > diff_file &&
> > +     grep "new mode" diff_file &&
> > +     git diff --cached file diff_file &&
> > +     grep "+content" diff_file &&
> > +     git diff file > diff_file &&
> > +     test -z $(cat diff_file)
>
> Function test_stdout_line_count can be used here instead of "test -z".
> test_stdout_line_count would produce a more helpful error message in
> case of test failure.

The other idiomatic possibility would be to use test_must_be_empty()
to verify that the file is empty.

> > -     rev="$(git -C for-submodules/dirty-head rev-parse HEAD)" &&
> > -     grep "$rev" actual
> > +     git -C for-submodules/dirty-head rev-parse HEAD > rev &&
> > +     grep -f rev actual

This change is unnecessary since this is a cases in which the exit
code does not get lost; the exit code of the command substitution
becomes the exit code of the assignment:

  % x="$(true)"
  % echo $?
  0
  % x="$(false)"
  % echo $?
  1

So let's drop this change from the patch.
