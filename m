Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05C5C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 02:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7112822228
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 02:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A40m8TaC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgKRC4P (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 21:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgKRC4P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 21:56:15 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDC5C0613D4
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 18:56:15 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id 18so185015pli.13
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 18:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kbbC30JgzOLmazkgaXtB1pY0vxE8wgMdE1aYaUJTXQI=;
        b=A40m8TaC+mMyGvVP6fC4x8SZh/b+HD1uH0cVK918WuAGzmFk6An8XSfSBpStfp6tIl
         4vuo7H+e6T7g11neIlQCo8By9yjady9yYvxV2vK/g897r2Ipw5a5+Z2gkJCvEaZA9EtE
         6tCQviTPYnQb7NhhKDLy/DQyWfpPcHCeRaQBou5YDiIHsyax3tC3qi0ffRbWkRq4z5Jl
         u5UBrXicf+5cBO2C4ITaj+iOwYCUXlut97b9pSgOLlVRhGjOOD6GeaEgnw0wrZezdwjR
         LYZU+qIxpZD7EqROraZWbjWyiPPslJ3cI6TSVupo7pO1WtTQyyUlQoI6Z3RYFvQo24F2
         vD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kbbC30JgzOLmazkgaXtB1pY0vxE8wgMdE1aYaUJTXQI=;
        b=pux/tgOr0T8EmxN3egZYolzIzsrE5i8FoGRMrnRzOqGV5OfLZjz7EalhT2cPovUXY4
         fe/GqGZFoPix01SNqpcEJO220Pz2wvVG/A0YEPg/fsGg15KssDxQ2+O6+cDqUbqYKZ8I
         FctCnQURL/bSqu2Z1p1d1yav31XcZz7KjU32eLC4Lzlpmyfd9fSfLZlPyjSHfmef7cA7
         MGiWn1gKE4l4tZ7zJz/glO37V5/BDxtgWcounLYLe4RMWHuTakUx/nSc8qaQPArb3fY1
         O4mRnbTIYBusrh1wQrYKZD2THwc/0FzdfDab3lSeEnsBV3U9VQlL+rVIZBCK55fsW8CW
         UZSg==
X-Gm-Message-State: AOAM532/BKB0FqEMhPNIwdykS75BZ42w8QbGrSIG7Ln/FuRmyqMG0TSO
        6zl/0RmEVCnUxNf0uxfZge0=
X-Google-Smtp-Source: ABdhPJwQaxQzJ8W3sFcdcmOQCmveJLbry4tzGy5d5bWp71jCoffeLBbns0pN4kFxo3APgKNt32TA2w==
X-Received: by 2002:a17:90b:b15:: with SMTP id bf21mr1968275pjb.21.1605668174651;
        Tue, 17 Nov 2020 18:56:14 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id s4sm494722pjr.44.2020.11.17.18.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 18:56:13 -0800 (PST)
Date:   Tue, 17 Nov 2020 18:56:11 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/28] Use main as default branch name
Message-ID: <20201118025611.GF360414@google.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
 <87r1oraewl.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1oraewl.fsf@x220.int.ebiederm.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric W. Biederman wrote:

> Instead of having a fixed name across all repos for the initially
> created branch can we instead use the directory name of the repo for the
> branch name?
>
> Advantages:
>
> - The branch name that is somewhat meaningful to the creator of the git
>   repo.
>
>   I have at least two repos where I wound up doing this by hand.  So at
>   least for me it is something I am doing anyway.

Example: this would make the main branch in a new git.git repository
default to "git".  However, we would be free to switch to some other
workflow-specific name like "stable".

> - Tools can not hard code the name of an initially created branch and
>   expect it to work.
>
>   This moves us farther from the realm of people assuming incorrectly
>   that there is something special about the branch created by default.

What's especially nice about this is that a repository's local
basename and the URL at which it gets published do not always
coincide.  So scripts designed to be robust would be more likely to
use commands like "git branch --show-current" instead of trying to
guess using the new rule.

That said, if I put myself in the shoes of such a script author for a
moment, I'm likely to be irritated.  What started as a static string
now becomes something dynamic.  If I put myself in the shoes of
someone who has *inherited* a script (a testsuite, maybe), I'm likely
to be even more irritated.

For testsuites, one can buy time by setting init.defaultBranch, but
not for other scripts.

Are there things we can do to make a script author's life easier?

Today if I want to look up a remote repository's default branch,
the best I can do is

	git ls-remote --symref origin HEAD

The output is not as easy to parse as I'd like: it's split between two
lines and has multiple fields on each line.  Worse, it is slow, since
it scans all refs instead of just the ref I wanted.  Even worse, if
another ref in the remote repository ends with /HEAD (e.g.,
refs/remotes/someremote/HEAD), it prints that, too.

If I could do something like

	git ls-remote --format='%(symref)' --exact-match origin HEAD

(using for-each-ref style formats, and allowing exact matching) then
that would be helpful.

In general, this aspect of a less deterministic first branchname is
appealing; it would result in improving the quality of the ecosystem
of tools built around Git.  This is what I like most about this
proposal.

[...]
> At least for my usage main is a pretty huge misnomer as I barely use the
> branch with the master.  Renaming my unused branch main implies that I
> am using the tool wrong.

Is that because "master" is inherited from your upstream?  Which
branch would you want people to check out by default when they clone
from your repo?

For what it's worth:

- I find this proposal really tempting, and have liked it since the
  moment gitster brought it up on #git-devel.  The main reason I
  haven't brought it up since then is that I didn't have a patch
  implementing it. :)

- That said, a fixed string as default would be fine with me, too.

Thanks,
Jonathan
