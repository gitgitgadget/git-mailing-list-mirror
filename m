Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8402C54EBC
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 23:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjAHX0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 18:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbjAHX0I (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 18:26:08 -0500
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414F465AF
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 15:25:59 -0800 (PST)
Received: by mail-pj1-f44.google.com with SMTP id n12so7044147pjp.1
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 15:25:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P3mVzyInvU7KZuEVrWkBtBpKUj8L487BGmiRbdoxP3Q=;
        b=4m+M0DPWVBEOwOx7lAkdVxHCYdovV5QmM7NHudIUbaaJMSA3KdbkwUinXFjElg1mgX
         BDfyQ1HdLEWUy1o+RC4CyBZtkINHEzALO05XVGfuM2f823m9Wfd2iN90vA/1ggrPVTPd
         5SCUCAa53/h7NMeq/V7S2LgSq0gOEqhq8IP0fhKQqcVE+SEIUcJIu+hazG8Geepqpdof
         8SAb7ZhSuCm3KMdG7kkb96Mg7Np38W6PDampRIjiAIAQxVVDAGXZjmVPm/u4sxMefOQ0
         6SpZf2MuTR885MaJiNpS36AEpY/xm1M+aZg8NhnPRRabgkU/PWBJcGqnRbwjGBf9JLMi
         5Cdg==
X-Gm-Message-State: AFqh2kppYOLVSUaNDM2qg6mHoSh0og9ki5BP04Yvx3d5wsFeWfTsxpWk
        BNB5xSM4EXt7bBCV4G7cb/5VIkuEHH5otvOCFpDJDv/A
X-Google-Smtp-Source: AMrXdXtk3Wr68jEHAsvC40WMkbuVeGRbu8rGnLw3xa1IE3sBCiDIA1p1M7Lr3jr1BipFjc1rPiFAo9uvelLAYn2Nhlc=
X-Received: by 2002:a17:90a:3e01:b0:226:7387:2ea5 with SMTP id
 j1-20020a17090a3e0100b0022673872ea5mr34185pjc.64.1673220358562; Sun, 08 Jan
 2023 15:25:58 -0800 (PST)
MIME-Version: 1.0
References: <pull.1457.git.1673171924727.gitgitgadget@gmail.com> <CAC-j02O6z4sG85LpRNzEZ52Y-McurYDa_VnVXtqFVPBFu9kbug@mail.gmail.com>
In-Reply-To: <CAC-j02O6z4sG85LpRNzEZ52Y-McurYDa_VnVXtqFVPBFu9kbug@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 8 Jan 2023 18:25:47 -0500
Message-ID: <CAPig+cS_dXL-Q6NZtUJxDOL4-Q=MJv8fPEPAnEPuONaNF8-sCA@mail.gmail.com>
Subject: Re: [PATCH] githooks: discuss Git operations in foreign repositories
To:     Preston Tunnell Wilson <prestontunnellwilson@gmail.com>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[administrivia: please reply inline rather than top-posting]

On Sun, Jan 8, 2023 at 2:45 PM Preston Tunnell Wilson
<prestontunnellwilson@gmail.com> wrote:
> Thank you for this wonderful remedy, Eric! I really appreciate the
> background context and how you framed the problem that I ran into.
>
> I have two questions:
> 1. Documentation is a great first step in addressing this, but I'm
> wondering if this should be automatic? If this is a best practice for
> hook authors, could `git` do this for them automatically when running
> hooks?

For the general case, probably not. "Best-practice" is context
sensitive. It may be best-practice when a hook needs to invoke Git
commands in some other repository (or worktree), but clearing those
variables automatically would, in some situations, break the much more
common case of the hook invoking Git commands in the local repository
(or worktree). The fact that those environment variables may have been
set manually by the user or automatically by Git further complicates
the situation.

> 2. Should we add something in the `git-worktree` documentation? In
> `Documentation/git-worktree.txt`, it mentions:
>
> > BUGS
> > ----
> > Multiple checkout in general is still experimental, and the support
> > for submodules is incomplete. ...
>
> Would it be helpful to plant a flag in the above documentation to
> point to this potential issue?

As noted above, we can't really call this a bug. Git is behaving as
intended. Whether the user set the variables manually or whether some
parent Git process set them automatically, the child Git respects the
variables as it should rather than second-guessing about the user's
intentions, and possibly guessing incorrectly.

So, no, I don't think this qualifies for the BUGS section of
git-wortkree, and mentioning this potential gotcha only in
git-worktree but not in any other hook-running command doesn't seem
ideal either. At present, the best place to discuss it seems to be
Documentation/githooks.txt, as this patch does. It may be possible to
argue that gitfaq.txt could talk about it, but considering that this
issue can manifest in many different ways (various error messages or
misbehaviors), it's difficult to come up with any text for the "Q"
which people would be likely to find when Googling. That's not to say
it shouldn't be mentioned elsewhere in the documentation, but rather
that I haven't come up with any better places than githooks.txt
itself.
