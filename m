Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB765C2BA2B
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCFA2072A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgBeCwHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgDGOaZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:30:25 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35606 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbgDGOaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:30:25 -0400
Received: by mail-ot1-f68.google.com with SMTP id v2so3319881oto.2
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 07:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0U2pTwB6/QD8LZhAaK4uWubeUYW6tS4cbPkpnXuq7JE=;
        b=OgBeCwHshxpJJKObAXraQVJVQGl2SLA8BvS7CEpJ+FvdDnai/xXy3nAkV3hMcYL++O
         eSgU0AhvZNWOVgL5kAmKvonrbp1yYJ46MNW8QDz5XeHGVgyFW/bW5ShE7TJvSUgNXHOi
         JdHqa/oM+5fCM+WKQrH/4haT83XQ/8NImHAm/1xBhstaGHzGBMzQI9Thc+AWpjf7yjVR
         TV5UXxIkG+OzkYMqBZxzxlIaBrLgckzePzmcd7dN4lYHmQb6+AfE8A2XEWMQOZtc4RP/
         hrqt8ZxT4kRXGLb39ZxeiX4efWbbE3GTWkGYgycYpAdshJwVaWSTnmdFKbzUqPrnKJXz
         7C2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0U2pTwB6/QD8LZhAaK4uWubeUYW6tS4cbPkpnXuq7JE=;
        b=XcpuGcUxHojxlZc2Vr877DtM7JkU7RdgyoCb4ECwuDqM13SY5mZF1scF3nDkuZ5FEO
         AV/xYD81wmkaHlYzhFUGyyDyCYFOgfYFTCfeX4DMlVC5rPkS+oz/lNduCNcqzkXLyF97
         cCOrp9hPUYyM6bDkzmtl54TsrnxVhQ00riBocMPotl3lSUT9TusUZGsAk2OeEEBdVjSs
         A/m/dH+hVtLDl2rjqFT7LB/BxYxLsXrszMXE/cyupl7sJi+6zsA1UIz49fAilyetzODj
         jgBBYjuiNbcZVQRJsZ+TSYroRfqTHsghUrciw5h8QJUiJhX5macg8aCil8wgKsAwlxpK
         WFbQ==
X-Gm-Message-State: AGi0PuZLIgtsmPTDFPT8EVG9VAtecZLZtS+k4AlImpaNEPyay33h0RWe
        AmAjhPPoJ2vxFHn17RWpu7pt4cVE3BFIm3hGyc4=
X-Google-Smtp-Source: APiQypJexEULzWPssQlgAe+u2kadhXvHNhXKelnnXjzmqtDEYqYidHeQhTUtIKGt09qNziRxq+R4/hawTN7zmKO4/Sg=
X-Received: by 2002:a9d:5e0d:: with SMTP id d13mr1856763oti.162.1586269824566;
 Tue, 07 Apr 2020 07:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200407141125.30872-1-phillip.wood123@gmail.com> <20200407141125.30872-3-phillip.wood123@gmail.com>
In-Reply-To: <20200407141125.30872-3-phillip.wood123@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 7 Apr 2020 07:30:13 -0700
Message-ID: <CABPp-BENw_tdukSEix+0EyjYbh4-jxyN9GYqHbuHNVaK9ax36Q@mail.gmail.com>
Subject: Re: [PATCH 2/6] t3433: remove loops from tests
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 7, 2020 at 7:11 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Looping inside a test is asking for trouble as we only detect any
> failure on the last iteration. Instead get all the dates at once which
> is also more efficient. Note the previous code accidentally compared the
> diffs as well as the dates this is fixed as well.

Add a semicolon between "dates" and "this" in the last sentence?

>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  t/t3433-rebase-options-compatibility.sh | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
>
> diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-options-compatibility.sh
> index 5166f158dd..2b4d75f1ef 100755
> --- a/t/t3433-rebase-options-compatibility.sh
> +++ b/t/t3433-rebase-options-compatibility.sh
> @@ -90,13 +90,9 @@ test_expect_success '--committer-date-is-author-date works with rebase -r' '
>         git checkout side &&
>         git merge --no-ff commit3 &&
>         git rebase -r --root --committer-date-is-author-date &&
> -       git rev-list HEAD >rev_list &&
> -       while read HASH
> -       do
> -               git show $HASH --pretty="format:%ai" >authortime
> -               git show $HASH --pretty="format:%ci" >committertime
> -               test_cmp authortime committertime
> -       done <rev_list
> +       git log --pretty="format:%ai" >authortime &&
> +       git log --pretty="format:%ci" >committertime &&
> +       test_cmp authortime committertime
>  '
>
>  # Checking for +0000 in author time is enough since default
> @@ -120,12 +116,8 @@ test_expect_success '--ignore-date works with rebase -r' '
>         git checkout side &&
>         git merge --no-ff commit3 &&
>         git rebase -r --root --ignore-date &&
> -       git rev-list HEAD >rev_list &&
> -       while read HASH
> -       do
> -               git show $HASH --pretty="format:%ai" >authortime
> -               grep "+0000" authortime
> -       done <rev_list
> +       git log --pretty=%ai >authortime &&
> +       ! grep -v "+0000" authortime
>  '

The new form is much more readable (and more correct and efficient, as
you point out).  Thanks.
