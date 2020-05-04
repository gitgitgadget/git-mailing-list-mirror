Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53242C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 16:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19F2620721
	for <git@archiver.kernel.org>; Mon,  4 May 2020 16:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFj0/Ssa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbgEDQmv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 12:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbgEDQmu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 12:42:50 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F11EC061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 09:42:50 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id x17so2541728ooa.3
        for <git@vger.kernel.org>; Mon, 04 May 2020 09:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K6GGRY5oHYgyDOys1wOHw+gDF0f61QNOPdOm49STlUA=;
        b=BFj0/Ssa15DEFLasWkttq0Xn8zzOmm/BI4TPzrXqhr/HJP7DiTOlqUYuqXYiCdlQV7
         EmQPdyNHjvBT6BSv7SDjECHd5pVxIyFT5z+334yi5K9gmouXZ89Ttn3jj5+t2L6u9DHi
         vDC6EXRjfOkndr3sZ4OVE2jTbp+SDPaWJIm4LHcIBXTFcq8b8uPvnjntcuitzyj4MuKV
         GxH+546EddxWhm2jMOtmi5KkYV4rERzv1fk/ZjTBvI8EtmZUNOP037ClZt8GSBYgwZJc
         7SIN9DR+coFS/lbD1W7bX21Vcg+2ICF2VeJyW6CjA+JTwbwVLdY3dKXdBiegYkYACC5v
         9vmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K6GGRY5oHYgyDOys1wOHw+gDF0f61QNOPdOm49STlUA=;
        b=QfauEYCPOIu+0MKJkAfk4RoZLM/MObQrXehR7ErEb3LWtQ7T5wb1dxucGMLCxp0N6d
         NX6Cx5zB3/l5A1o24jugPh0800JMsDYQRFlJsK/tI6JGMpzKvG5mTdrfa5qAjT9h471k
         1FsTjvaRS7zw9EAw3DQew061VreyMDGpFy1bhqQksVj8Q0eyCzmgDd6y2TzrxWp7gutZ
         Vp6NhiWLI9ptCjtiMZDakSERj/9FqBbDABUfOCOxHgDYjwEMnNPL1ZiViadnZN34Gfat
         tO+EfGnZy0zo1y6zbvS1halZltqaUJO9cIg72Na8etAhSuDw6UNMDC1tYNPQbqB1EB/3
         PjZw==
X-Gm-Message-State: AGi0PuYkdnX5cNcIvfx04wFmxEweVdgwURL+ZjAvFSl7ut5cmFy6yAig
        c3Hee4tMceLONPPCSiuAAB1LVuHBX23umiKf6eo=
X-Google-Smtp-Source: APiQypKQ/7stPopWtPGICcqp1sVouu10bwoX1oIAIcoZ6Bb2GrjpkLft5q4MdyXoqC+ep9232XYtUEwT/34Y6x1QsXw=
X-Received: by 2002:a4a:e40d:: with SMTP id t13mr15835446oov.32.1588610569435;
 Mon, 04 May 2020 09:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200504054223.11125-1-shouryashukla.oo@gmail.com> <20200504054223.11125-4-shouryashukla.oo@gmail.com>
In-Reply-To: <20200504054223.11125-4-shouryashukla.oo@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 4 May 2020 09:42:38 -0700
Message-ID: <CABPp-BE7rk=B8a9GuZmtpnrdh7O1-=+zPPmgT1AHE2JgMq25Bw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] gitfaq: fetching and pulling a repository
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 3, 2020 at 10:42 PM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:
>
> Add an issue in 'Common Issues' section which addresses the confusion
> between performing a 'fetch' and a 'pull'.
>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
>  Documentation/gitfaq.txt | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> index 5dfbb32089..04ea7be99f 100644
> --- a/Documentation/gitfaq.txt
> +++ b/Documentation/gitfaq.txt
> @@ -255,6 +255,22 @@ way of cloning it in lesser space?::
>         presumes that the user has an always-on network connection to the
>         original repository).  See linkgit:partial-clone[1].
>
> +[[fetching-and-pulling]]
> +How do I know if I want to do a fetch or a pull?::
> +       A fetch brings in the latest changes made upstream (i.e., the
> +       remote repository we are working on) without modifying the current
> +       branch or the working tree.  This allows us to inspect
> +       the changes made upstream and integrate all those changes (if
> +       and only if we want to) or only cherry pick certain changes.
> +
> +       A pull is a wrapper for a fetch and merge/rebase.  This means that
> +       doing a `git pull` will not only fetch the changes made upstream
> +       but integrate them immediately with our current branch too.  The
> +       merge/rebase may go smoothly or have merge conflicts depending
> +       on the case.  Hence, a pull does not give the user a chance to
> +       review changes before applying them to their local repository/current
> +       branch.
> +

So a few issues; elsewhere in this thread, Junio said:

    We should strive to (1) make sure any FAQ entry can have a pointer
    to more comprehensive and canonical documentation, and (2) an FAQ
    entry with such a pointer does not consume more than one paragraph,
    say no more than 5 lines.

* This answer is multiple paragraphs and 12 lines.
* The answer is fairly repetitive (e.g. why add "if and only if we
want to"; isn't that already covered by "allows us to"?).  You also
bring up inspecting/reviewing the changes multiple times.
* This brings up cherry-picking in a really awkward way that seems to
be suggesting or at least condoning what sounds like a very broken
workflow.  (If it's your upstream, why are you only cherry-picking
changes from it?  You're going to get divergent history and the next
merge will end up with multiple copies of the commits.  If it's
something you only cherry-pick from, it sounds like it isn't intended
to be an upstream but something else.)
* This side-tracks into the results of a merge or rebase; why do we
need to mention that it can go smoothly or have conflicts at this
point?


How about the five line version I suggested earlier:

A fetch stores a copy of the latest changes from the remote
repository, without modifying the working tree or current branch.  You
can then at your leisure inspect, merge, rebase on top of, or ignore
the upstream changes.  A pull consists of a fetch followed immediately
by either a merge or rebase.

You could optionally also add a link to the git-pull documentation
(which incidentally also answers the original question in the first
four sentences of its description).
