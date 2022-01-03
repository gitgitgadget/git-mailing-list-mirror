Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D1BC433F5
	for <git@archiver.kernel.org>; Mon,  3 Jan 2022 16:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbiACQho (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 11:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiACQhm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 11:37:42 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CDCC061761
        for <git@vger.kernel.org>; Mon,  3 Jan 2022 08:37:42 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id j6so137864889edw.12
        for <git@vger.kernel.org>; Mon, 03 Jan 2022 08:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g5lLSqVbwg4hc2ZiyN1I9P5T7qGtVc9zdBK/VG7QCdM=;
        b=MAqGjmb8Kp6cP3MIkXdqrnzfAk/xi/bWmayp5pa3ijQbtWxp1oF22PE01td+CoPL5a
         4FT5lvVzDPuxLJTqCU+BFqrTdnLs0m8PLJ/rhzhZrI/x8dKp4EfcazKLDc8S45C51hU9
         UepAXZO5c4vkQ4masM25T6RCAj7I1fqQHt6daKnNIQ0eBVAM+jgXcKyXJGyu8ZxEACgp
         tQjEXStZVkND7vKUg+Jtg3U3W/vxsvwG+sw8+XyUm72G/XFW1hySwJR7799br9R3JJsX
         szhnvmf4pUbQxuplOmSLQ1clhSO1kzTeAQceTSJlsQu/PDKHrGS6MwLst7+AQeFKWzxI
         ZA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g5lLSqVbwg4hc2ZiyN1I9P5T7qGtVc9zdBK/VG7QCdM=;
        b=eSnED+GtDRoXjvcI06tl4kWxDqwJRV8jLuzhycf8HwleJyDYQAUe6G2CDkjpuahfEp
         tZJh9nfwwfxhDtSpyoF/7fM1UT8H6XcrZdrR8utsu/+b4hgcMzWgxPzP0Q7lI6iIuOsc
         mY2GDQpamTK+z/VKrPDLlJq4h6GYXQgs7UTCZg2WH+dm6mbPqjr/t3JvbpxGT0OlyuXN
         m+qpgq6ErwmX5nsKPR6DEBU+eo3jhQktI/KALa3RJaveoreLuJqnDFN48pjZ8D64wMlc
         iYUlKlfMnoR+JRUYhVsRtTkP1NfK95kI4fRXO1E4huMng7c/MhAqWded5KVesHMpon2+
         P53A==
X-Gm-Message-State: AOAM531OKqPfqWL98M5L6Qm/mqq43A9PXPV0Qjme77S6NZHa+zWG8ELB
        tNq9tuzIPw+qH2MOb7Qa374bm/yo9ZCzRWAGAHQ/TI6tujw=
X-Google-Smtp-Source: ABdhPJwCK4v3kkJyHIPjvpFeuE0k/f1RivkDcKKGa0iNMlSjkyBzvwgxN6/5AHJdyQGrvVkOOTcIgzEr52+uMDa8Fpk=
X-Received: by 2002:a17:907:60c8:: with SMTP id hv8mr36245189ejc.192.1641227860939;
 Mon, 03 Jan 2022 08:37:40 -0800 (PST)
MIME-Version: 1.0
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
 <9fc71f4511b163bec53616d82e8fe5214facf060.1640927044.git.gitgitgadget@gmail.com>
 <20220103122347.uba66kusy3ft7g2h@fs>
In-Reply-To: <20220103122347.uba66kusy3ft7g2h@fs>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 3 Jan 2022 08:37:29 -0800
Message-ID: <CABPp-BHWAfeqPyhBehf=37kfMmfi2LtV2tOrqRwTztcQr4fsDw@mail.gmail.com>
Subject: Re: [PATCH 4/8] merge-tree: implement real merges
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 3, 2022 at 4:23 AM Fabian Stelzer <fs@gigacodes.de> wrote:
>
> On 31.12.2021 05:04, Elijah Newren via GitGitGadget wrote:
> >From: Elijah Newren <newren@gmail.com>
> >
> >This adds the ability to perform real merges rather than just trivial
> >merges (meaning handling three way content merges, recursive ancestor
> >consolidation, renames, proper directory/file conflict handling, and so
> >forth).  However, unlike `git merge`, the working tree and index are
> >left alone and no branch is updated.
> >
...
> >+test_expect_success setup '
> >+      test_write_lines 1 2 3 4 5 >numbers &&
> >+      echo hello >greeting &&
> >+      echo foo >whatever &&
> >+      git add numbers greeting whatever &&
> >+      git commit -m initial &&
> >+
> >+      git branch side1 &&
> >+      git branch side2 &&
> >+
> >+      git checkout side1 &&
> >+      test_write_lines 1 2 3 4 5 6 >numbers &&
> >+      echo hi >greeting &&
> >+      echo bar >whatever &&
> >+      git add numbers greeting whatever &&
> >+      git commit -m rename-and-modify &&
>
> The commit implies a rename as well which I think is missing.

Sorry, I revised the testcase (multiple times) and forgot to update
this commit message string.

> >+
> >+      git checkout side2 &&
> >+      test_write_lines 0 1 2 3 4 5 >numbers &&
> >+      echo yo >greeting &&
> >+      git rm whatever &&
> >+      mkdir whatever &&
> >+      >whatever/empty &&
> >+      git add numbers greeting whatever/empty &&
> >+      git commit -m remove-and-rename
>
> And this looks more like a remove-and-modify.

Likewise.


I'll fix these up; thanks for pointing them out.
