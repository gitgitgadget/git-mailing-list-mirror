Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D950C04A95
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 19:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJVTGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 15:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJVTG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 15:06:29 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC83B97A9
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 12:06:28 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a6so7919650ljq.5
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 12:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t5KUsIjTylS6m4RxGzI4tk6EQiPT3Hnzb0k9DAhfFm8=;
        b=hoVPThlK4XrKp/MSyTPk/Zz56ejA9hvFRR4Wadq4zqMK560olLWf/XYvtBQFNBjMU4
         E3hKd+erViR04GYz8tFNP0au9Q+1EwV5yEJrfBdORAVkJwGyd0czQaR5xHLbNvjFvsy+
         AKu/rBAsYkgz9v4JQehpBblnQFUdVvMuf7oG9VwOjj0N+3cyNW39wc2GW4hFMXmFpdhZ
         92bOiLfF5hd+zMhvjDlDZYATATpyW3MNn7XpilEzouhpZGiVmbukLnXNXuOmy/Ygq3pA
         TTQddvTJ/ZliOwPeGgzdVrdNZTmJLG7V63+wS0MVIpDSjLgfnFjGfcq2vdVTTq+fCHW3
         UHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5KUsIjTylS6m4RxGzI4tk6EQiPT3Hnzb0k9DAhfFm8=;
        b=RXU++sw912f4IsFV/qGG7HGC6fShSSQjIkC5oZKEOE7tzBz7Qw6lFL0DcWlUAlIb+Z
         mUY1GvDNeEokVukGG/pmwRYja6Rj1oNkz64mKB3feuCkr4YdJNQVg7M4iL1aeCcHs+HK
         6kPkGsTG62eV5HjB6Xf+6FaIep9oQvC9s7Tys2WlMzrEe+Jb6qYHwUT1G90ZcD38zglQ
         goqZuKSebOPUkSlzrpRaOcffazuSpjq22+l31LgyfiO6ltM9oZ+BpLzVWmbdycWXOLEX
         xDTJ0BR8Yz22H9rJA4+pCsYBYgMiCLNIPELupCawISbkOfpSg7fApJj46TQ3DvQ1c25d
         Mpmw==
X-Gm-Message-State: ACrzQf378GAhAxB3YoDNpaeNfQ3+u3AmCl1SNeDwc9FnAKhhi0z9Lkd2
        3pxwBtJ5gfgRxV/Unr8EEWO8BnJW6XC5m9LWYjDIxBwphQY=
X-Google-Smtp-Source: AMsMyM6n20KeOedoZ324pdIdMWt+azKTE61v3l/9PRSB8QV+6sQeX+qqzugMhjDedrjkoQ4uK8Dji5qR/septT5ZkzU=
X-Received: by 2002:a2e:8893:0:b0:26c:2f7f:c037 with SMTP id
 k19-20020a2e8893000000b0026c2f7fc037mr9604370lji.325.1666465586715; Sat, 22
 Oct 2022 12:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220916124234.h57p67mwywzok23s@haydn.kardiogramm.net> <CABPp-BGdGZ6dg4_wWxkz+VCvaThfn3eL9uqBvmsK3+8GQf0ByA@mail.gmail.com>
In-Reply-To: <CABPp-BGdGZ6dg4_wWxkz+VCvaThfn3eL9uqBvmsK3+8GQf0ByA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 22 Oct 2022 12:06:13 -0700
Message-ID: <CABPp-BFEg861ru2mJujnHLCD29WNgp4C6f8+CvL6vFRS6r5NLQ@mail.gmail.com>
Subject: Re: git rebase crash: merge-ort.c:2622: apply_directory_rename_modifications:
 Assertion `ci->dirmask == 0' failed.
To:     Stefano Rivera <stefano@rivera.za.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Sep 20, 2022 at 12:15 AM Elijah Newren <newren@gmail.com> wrote:
>
> Hi,
>
> On Fri, Sep 16, 2022 at 6:24 AM Stefano Rivera <stefano@rivera.za.net> wrote:
> >
> > Hi, I got a crash in git-rebase, a failed assertion in merge-ort.c
> >
> > $ git rebase renamed-parent
> > git: merge-ort.c:2622: apply_directory_rename_modifications: Assertion `ci->dirmask == 0' failed.
> >
> > I was rebasing a branch that replaced a directory with a symlink, onto a
> > branch that renamed a parent directory of the modification.
> >
> > Reproducer script attached.
> >
> > Using --strategy=recursive avoids the crash, so it's a bug in ort.
> >
> > Not subscribed, please CC me in replies.
> >
> > Thanks,
> >
> > SR
> >
>
> Thanks for testing out a release candidate, typing up the detailed
> report, and even finding a simple testcase!  Very cool.
>
> I don't have a fix, but just wanted to send a note out that I've seen
> your report and will take a look at it this week.

I had a hacky fix for about a month now, and haven't had time to clean
it up and look around for nearby issues.

I believe the cause here is related to the code added to fix the bug
in 902c521a35 ("t6423: more involved directory rename test",
2020-10-15).  Since that issue was never fixed in merge-recursive, it
didn't get the side effect of this new bug.  Had that other bug been
fixed in merge-recursive, it may well have exhibited a similar issue
with the testcase you reported here.

Anyway, I posted a patch to fix this issue in ort:
https://lore.kernel.org/git/pull.1391.git.1666465450590.gitgitgadget@gmail.com

Thanks again for reporting it, and for providing the simple steps to reproduce!
