Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF854C4332F
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 01:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbiKWBd2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 20:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiKWBd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 20:33:26 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8712F003
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 17:33:23 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c188-20020a25c0c5000000b006d8eba07513so15344301ybf.17
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 17:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jp7raq/LGF2hXYUavhUfcIeuaVXXZvAvpqlXoNDQ1os=;
        b=Kijp4AL/XrpnQ05lywcY79Y/VRMCNNxMxltvbAPncDZkgxBtuI+buV9W6sMTzZij34
         ue5TDsP7D88pHA8eUC0nb+eM+H+P0MMG+n6Nca5oQ4PYBZq1rpsr8ZNQHHqyDyC1l9nq
         90QazmmHJfChTWr52HQUEiBLsRYsjfjVbyM5mzaKKjIjL3tgG4kQ0B/e70eauAabASkq
         b3f1M2K1wSeBQrh3NKtizVc2ls1agiiL8X2wIJnf4fJDE1aEjFZiaul/uh9WazAgCOL5
         kagDZa11i126ahiTJCm8DRGSCB8mxgQF1p3RLRXo7b8iRZ2DJK7zYK+0bQ/tsp1WR7ai
         sWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jp7raq/LGF2hXYUavhUfcIeuaVXXZvAvpqlXoNDQ1os=;
        b=HDNutzKUdhOexI8o5DYbOr+7rxDDlMzw2YcEXeRZV5j1D2zCJfr4pPKGAa5fJOzlIG
         Adpz1Qi4yejeOU3v2YIXGsRCYn9xSD2cPHbT6ktjF5R707lxUzpQWk+BzEOi4Z8WPRN2
         YOWmAQ9mrvXIsCIhQGavkVEsSvNPNDRpf/s6ODlDehTMCnVmd4tw7izDMnc5xLF5TCJW
         Dk8bL8sJGGgFSkCxcvxu13BvBKR4gYN5YWgZwK9YpdjyrhXKMw33NIAzGospILBkpaZ6
         J6eDg8lTGl3u3oeXtYwDVNQe8osr67xNaWDNyCkwayljuoLqrBUGnU/Ng77jOjS94I/3
         QV0Q==
X-Gm-Message-State: ANoB5pm82QygP1mKhF6nkoEwX0SWvv5PU1DW0QZ8fkGr5e/FPGNDJUji
        zV3RH3tOb3gsLW6uuMvv6I6jfUamTw97izrHhS5p
X-Google-Smtp-Source: AA0mqf7SGK5g1qbWpq3dubUnPPukY9iEOUQB0FOzg2wq1bnJSItWm1QdfRjtzz625Xz9I26+1kZ4s8aQvhGCSqUvbYNI
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:8002:0:b0:6e6:5384:a5f7 with
 SMTP id m2-20020a258002000000b006e65384a5f7mr15466532ybk.210.1669167202774;
 Tue, 22 Nov 2022 17:33:22 -0800 (PST)
Date:   Tue, 22 Nov 2022 17:33:19 -0800
In-Reply-To: <kl6lmt8iesmu.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221123013319.1597025-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 8/8] clone, submodule update: create and check out branches
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> > 1. Checkout the branch, ignoring OID (as in this patch).
> > 2. Checkout the branch, erroring out if the OID is wrong.
> > 3. 1 + creating the branch if it does not exist.
> > 4. 2 + creating the branch if it does not exist.
> > 5. Always forcibly create the branch at the gitlink's OID and then checking
> >    it out.

[snip]

> > A. Create only the branch that is checked out in the superproject (as in this
> >    patch).
> > B. Create all branches that are present in the superproject.
> > C. Go back on our previous decision, switching to 3.

[snip]

> But it doesn't make sense to mix both A _and_ C, since C would already
> give us the same result as A, so it probably makes sense to go straight
> to C in this series (i.e. only for the initial clone, not subsequent
> checkouts). I'll do that in v3.
> 
> I prefer C in the long run, since both A and B require that the list of
> submodule branches never get out of sync with the superproject, which is
> hard to enforce, e.g.:
 
I discussed this with Glen in-office and Glen pointed out that A is actually
not necessarily redundant with respect to C, since a "git submodule add" may
clone a submodule, but it would not run "git submodule update" (so 3 + C would
mean that no branch is created in the submodule, which is not what we want). So
we still need A.

As for 1 vs. 3, we will still need 3 in the future for the reasons I described
in my previous e-mail, but I think that that can be done incrementally. My
concern is to avoid doing something in a patch set that we will later need to
undo; I think that we are indeed avoiding it here (we're doing A but we will
still need it in the future, so there is no undoing of A needed).

So overall, after this discussion, this patch set looks good to me, except for
the minor points that I have commented on in my previous emails.
