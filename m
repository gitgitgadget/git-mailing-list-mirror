Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C90BC7EE23
	for <git@archiver.kernel.org>; Tue, 30 May 2023 10:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjE3K3B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 May 2023 06:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjE3K2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2023 06:28:25 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA11E58
        for <git@vger.kernel.org>; Tue, 30 May 2023 03:27:26 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b01d7b3ee8so25178845ad.0
        for <git@vger.kernel.org>; Tue, 30 May 2023 03:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=myitcv.io; s=google; t=1685442446; x=1688034446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hqg5FoSa1MR9LJqC1AFW32qQaxBhsTo7SuYiogPrJ+s=;
        b=SMZeo9NbEVx5Ab6eeZ/8qkrerrQURDwWwwsUF9yE23K/113yLyDcGZaitKtJNyjIvM
         mcJ1MjzD8B5eLkYLn33sJ92ZvuGuyH52Aq0MjPeNQIl2YhhoIDKI88wXuVFBYjoevy/u
         CflJpvSdL05HOCQUJCvm4wJmN96sJP8sJtbZkKwMEBMss2moO9VkD5llThFbh1g9PTNs
         xNEZa2Tw/ONS7ppnJlBeIKeNbs6f3XU/BT61vAzakjpSZxYQgLSj64vPb7MuzUFCAz3J
         KA2jYiD3zLzJcX1Yu/E+tmfVw8V1tN6FEEGWwfxDYz4ahNZ3wm5LB+mIBma2+ww5ObGO
         eokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685442446; x=1688034446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqg5FoSa1MR9LJqC1AFW32qQaxBhsTo7SuYiogPrJ+s=;
        b=iU2yyDUHXbDLVop/eifis/vQLGqfOgL2VqDtGA1w+uk28t8ony5VZZAelqWfpHwWUM
         gpsip3Yrz7X/ZKiV7s1Cp+qpzAGjkvAIW6APjyEUU1ahvBD208a7ojqtJy7/wmQllAxh
         fsj4BBgwG4aM4WDdenX4dJO9gPr0Y9c8wkHMRFGQxl+wXB+ifgtWkQC48/jnv46b7Lul
         SrbVyDOop7fZ8tuaKN6nWwZWT1Ionm6u7kPXL9Z2GINafEKn6cOTWss+Qe1B3zhUpiDp
         epaXxgp29WG8kzjvgb77psoWKHHV8SwA78oxwElYiAQ6fBYmmwYaVdDmYCo+cTnNhH11
         G8Kg==
X-Gm-Message-State: AC+VfDxpA/NtBzJ0kYz0UKnP8sSGAo3Bnu/5z1wKp3lyj7yXmMCouuNN
        kyM/SXxZH6jS8si8oo69av5GglY24yw4zHVW/HeyISspjQ6n+QPiWxlnQg==
X-Google-Smtp-Source: ACHHUZ7n5EbyCwsrCe338kjHJInNk0Cp1MtgVBKWuExx6WXEEnI0GkZk+6YlO3NYV0ajunyg2kfZAFK+0axmvcsdJwk=
X-Received: by 2002:a17:902:ab8b:b0:1ae:6882:5bc4 with SMTP id
 f11-20020a170902ab8b00b001ae68825bc4mr1633765plr.64.1685442446396; Tue, 30
 May 2023 03:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <CACoUkn7TmZ=trtDKcQm0SG5qCqK=-+YxrDV-7xYnLH_XK7K7og@mail.gmail.com>
 <ZHXFdRnrwzNCA227@ugly>
In-Reply-To: <ZHXFdRnrwzNCA227@ugly>
From:   Paul Jolly <paul@myitcv.io>
Date:   Tue, 30 May 2023 11:27:15 +0100
Message-ID: <CACoUkn5i_nR5Tpd_ZBBQyP4e0ObYKVXXa9d+umkdpF5PPXa-pg@mail.gmail.com>
Subject: Re: Automatically re-running commands during an interactive rebase or
 post commit
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi ossi,

Thanks for the response.

> i would recommend taking a step back and considering whether you're
> actually trying to fix the right problem.
>
> why are you checking in an auto-generated file, esp. given that it can
> be generated very quickly as you report?
>
> usually, this should be done by the build system.

Thanks for asking about this and forcing me to think more on the point.

To add a bit more context, and explanation behind the current design decisions.

The system I have described is a pipeline that supports a
documentation site for https://cuelang.org/. The architecture I have
described is that of the preprocessor, a tool which helps to automate
the testing of examples in documentation. Content authors write
documentation in format X, the preprocessor validates (and runs, as
required) that content, and produces format Y. Format Y is the input
to a Hugo (https://gohugo.io/) static site; hugo processes format Y to
produce format Z, the HTML that then renders the site.

The generation of hashes that I referred to before relates to the
contents of format X. If when the preprocessor runs it detects
(according to the cache files commited with the content) a cache hit,
then there is no need to re-run an example in some documentation. We
commit those hashes for now to sidestep needing to create and maintain
a shared preprocessor cache (a cache that is shared between CI systems
and users). We might move to a system like that in the future; for now
this feels like a sufficient setup.

The cache right now is very dumb; well-known files are updated with
hash values. And this is what creates the git conflicts. One thing we
could do to eliminate the conflicts altogether is commit a
content-addressed cache. This would have the problem of growing over
time... but I think we could solve that problem a different way.

> if the used build tool really is too dumb to integrate it into the build
> system, you might have luck with a post-checkout hook.
>
> you can also obtain existing hashes directly from git, with ls-tree,
> though this would again require some kind of integration with the build
> or checkout process.
>
> if you can't get around checking in the hash, i can think of hacking it
> using rebase --exec. basically, before each pick you'd create a commit
> that reverts the hash change (by checking out that path from the parent
> of the last commit that touched it, found automatically with git log),
> and after the pick you'd squash away the revert (using `reset HEAD~2 &&
> commit -C @{1}` or something to that effect). very ugly, very fragile.

Thanks. I have a working setup now using a combination of git rebase
-x and a script that I run whenever git rebase fails because of a
conflict. This works but is not ideal for a couple of reasons:

1. Each interactive rebase is "littered" with exec lines which should
be a detail
2. I need to re-run the script manually when conflicts are detected

Point 1 would be nicely addressed by a git hook that fires "pre
commit" during a rebase.

Point 2 could be solved by a custom merge driver, but that's seemingly
not possible right now:
https://lore.kernel.org/git/ZHXFdRnrwzNCA227@ugly/T/#m14b204843fea1fe9ff1c7500244049a43ed610eb.
Alternatively it could be solved by another hook that fires when
rebase detects a conflict, a hook that attempts to "recover" the
situation before rebase actually fails.

Thanks again for asking about whether we are solving the right problem
here. Writing my response above prompted me to think again about
different solutions.

Best,


Paul
