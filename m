Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5561C433F5
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 20:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B887660F56
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 20:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbhJPUfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 16:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbhJPUfK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 16:35:10 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31286C061765
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 13:33:02 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id t16so11984674qto.5
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 13:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=MDoGZB7zQMgMWbF0jv2g0ZkToKkJze7Xb/a9cYl0M6E=;
        b=J7PXYpmmXLT/f4jFj6ScRLOdVO7+HE1SPKPHCaqceha4wpcja3WpXtTKicXOAs9jB4
         zNsEi7uh4lrhhFm9Yb3ZP9D835YH3W/u9GpekJ53qGnsYqWm1YXCu8QKzlEZiNzpLXs+
         T0xAb3g5e5MatJ/U4hx7F7bh+xgHsAMWcs59zZ7q5aSHC3vbCDL+yNNV4rhrJTwUl3rp
         7MnGvtcnp90AHWeRiAnWqVNFpXgRZvNzLHJgJGxJDQT2dkOfM9qebq7HWlagvzGG/ZDB
         DfHB6EaTSNdGHxTufgDR7Qse8MsB0pcYhP8ll6WkemhHmhscXWqQAUneIk1nyOuJgGxu
         c+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=MDoGZB7zQMgMWbF0jv2g0ZkToKkJze7Xb/a9cYl0M6E=;
        b=ogEy2zvR3wfQTIBlKHm5ssyIyDijHgc1x4aT7NXGYscUWKJI3uAPKSqoI4hDCKXPVE
         qMBjpINoT+1EFFcWOlzRZ7xGueYnRwGczeFXpJOdJdt0NyAkcRP6AhUneKoRQvm5w569
         HlRjziKcNHyv38tqtfPrZqid0eoy3oyqhdCs4V+6ZbYVZBymHl9ARYM88+CybNyVO1D0
         5HgIbx8Xc6TliAT4l4h1Cd1OEGbK0a0dGvcRCKc8+fEBM8rYvZC+8zC0E+Rpl6KKkhvw
         Wf7YnltBtZ28+cLVlKQz0imikPBXfTwKlz8ooJoh2R/7h7OEXq7fwWDUbNsW/zSglC+T
         f3gA==
X-Gm-Message-State: AOAM532XemF6BL2an3RZsC8BGjA9rAcREQgd1kAX7tDhm5UlK4cEXWRx
        XQRTCF1zKp3WcwsZV6Swuzl+ALFzDdsizeiAHaQ=
X-Google-Smtp-Source: ABdhPJyX8bivlA9ojLFHT8q1+eHa+eoY1Zx57b7yaR3vkYKzqMjDyC5jv8Qs3/J8Hb6QJhvlGy5hS/acoWsczu5rbEI=
X-Received: by 2002:ac8:7f4b:: with SMTP id g11mr4235902qtk.339.1634416381383;
 Sat, 16 Oct 2021 13:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <CADTYju0PpHHG1=S3N4MDWk5yZqb5t_KUhiDvZ_2i-vXFUT_LDw@mail.gmail.com>
 <YWsffmtRQKQGxkiR@camp.crustytoothpaste.net>
In-Reply-To: <YWsffmtRQKQGxkiR@camp.crustytoothpaste.net>
From:   Adam Hutchings <adam.abahot@gmail.com>
Date:   Sat, 16 Oct 2021 13:32:25 -0700
Message-ID: <CADTYju16KTNP_4cLs=Q=19r72ECgYnjLv=Y3nCNhX1fs1P-vxQ@mail.gmail.com>
Subject: Re: Possible bug with checkout and submodules
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Adam Hutchings <adam.abahot@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OK, thank you!

On Sat, Oct 16, 2021 at 11:52 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2021-10-16 at 18:44:04, Adam Hutchings wrote:
> > Hi,
> >
> > I may have found a bug in Git but I'm not sure if it's intentional or not. I
> >
> > checked out to a new branch to test a PR on my repo, and the PR added a
> >
> > submodule. I init'ed and updated the submodule, and when I was done testing, I
> >
> > went back to my main branch. However, it did not remove the submodule, and
> >
> > produced this message:
> >
> >
> > ```
> >
> > $ git checkout main
> >
> > warning: unable to rmdir 'glfw': Directory not empty
> >
> > Switched to branch 'main'
> >
> > $
> >
> > ```
> >
> >
> > A friend of mine has managed to reproduce this behavior. We believe the expected
> >
> > outcome is to remove the submodule folder, but this does not seem to happen. Is
> >
> > this intentional?
>
> This is intentional.  It may be that the submodule has data that's
> ignored, it could have local changes, or it could have additional
> unpushed history, any of which would probably be data users might not
> want to lose.  As a result, we don't remove the directory unless the
> user has run "git submodule deinit".
> --
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA
