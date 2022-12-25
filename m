Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCD9C46467
	for <git@archiver.kernel.org>; Sun, 25 Dec 2022 18:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiLYSMV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Dec 2022 13:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYSMT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Dec 2022 13:12:19 -0500
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9399A26C8
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 10:12:18 -0800 (PST)
Received: by mail-pj1-f44.google.com with SMTP id ge16so5420106pjb.5
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 10:12:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OTq7C4CwDZKlHL2D7HylGw/w1nKahleqtR8mUMDk7Y0=;
        b=ozwZEvSroNCNqg+CxydDi4UZLRSN7sHB/BtscrLI0R7spaIQemouE2Zbhux9reDK47
         /EnVQj51P4kDB8lCGMRVbnwuqdItbMI0aQgLbdrpJtyCs9u/n2OHdaWLwtTtIKyDtDI8
         SXxMZvmiss7Ko/suMyeYWRTGsnEG2vj15UgKAkMYH/Tm6WXhTsRouW5bfeYG+Uji/Azi
         JVwPIaG3Rn/FjLHdzZZ4LodbCzdLwkfkenJVPux5knNjPq8XlAKMMOrczPqSagMMNJw+
         pchhj4/I7MAprdIN5WcuerTFHjbsNmIb864QajCRCy23e47BW5tk9rWnNft6n7r+PjS4
         uyJg==
X-Gm-Message-State: AFqh2krOWVR75fUB9Nclq4UwzOspQko9ouEerVJgSk7T0kIyAqkCGGyO
        Qj8D57rsdVoud/smLPonrmGXp9Cpr/tWmh5OK4zs5os0AmM=
X-Google-Smtp-Source: AMrXdXswShFMLWvyFHIXG2WiG5aw7AhHZfOBS+df+9uHKPMmzPRYuHTQaarj471nlzwu87lcbYKYKHgayFKeRp5tYME=
X-Received: by 2002:a17:902:cf08:b0:191:34ee:a3fc with SMTP id
 i8-20020a170902cf0800b0019134eea3fcmr996232plg.12.1671991937948; Sun, 25 Dec
 2022 10:12:17 -0800 (PST)
MIME-Version: 1.0
References: <CAL_N1vv1KqojvaS7TSeJ1JnUfO=cSzfUNMhGzgLi2pLUrmMWxQ@mail.gmail.com>
In-Reply-To: <CAL_N1vv1KqojvaS7TSeJ1JnUfO=cSzfUNMhGzgLi2pLUrmMWxQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 25 Dec 2022 13:12:06 -0500
Message-ID: <CAPig+cQEC6CAV-Es9Ok96s8Cj=Dj76PRyOt4qKQus+rppswuyA@mail.gmail.com>
Subject: Re: bug report
To:     Eyal Post <eyalpost@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 25, 2022 at 12:48 PM Eyal Post <eyalpost@gmail.com> wrote:
> 1. I have a script which creates a git worktree and checks out a few
> files from the master branch
> 2. When this script runs "stand alone" - everything works fine
> 3. When this script runs from a "pre-commit" hook it fails with an
> error: "fatal: Unable to create '/tmp/wt-1/.git/index.lock': Not a
> directory"
>
> The content of the script is (simplified example):
> git worktree add /tmp/wt-1 master --no-checkout --detach

This was previously reported[1]. Based upon a quick scan of that old
email thread, I'm not sure we ever came to a final conclusion about
whether Git could address this case itself[2] without breaking
existing workflows or if it should be the hook's responsibility[3].
Perhaps try having your hook script unset environment variables as
explained in [3], or at minimum unset GIT_INDEX_FILE. Also, perhaps
this advice[4] applies and you can take a simpler, less heavyweight
approach to whatever your hook is doing.

[1]: https://lore.kernel.org/git/CAJFQqN+Z9eX6onaj8vVSqpvf-nOC7-Y0Un4NLUie6x6bGfmvZA@mail.gmail.com/
[2]: https://lore.kernel.org/git/20190517011941.GA30372@sigill.intra.peff.net/
[3]: https://lore.kernel.org/git/20190516221702.GA11784@sigill.intra.peff.net/
[4]: https://lore.kernel.org/git/CAGyf7-GtnCqfqPWVpBAELB4xAE6syn7+DfKXgfhL0UoMfvbn4A@mail.gmail.com/
