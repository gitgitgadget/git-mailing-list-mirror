Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF146C10DCE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 10:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B7D206BE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 10:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcmPeZNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgCOKw7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 06:52:59 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:37765 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbgCOKw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 06:52:59 -0400
Received: by mail-wm1-f46.google.com with SMTP id a141so14851440wme.2
        for <git@vger.kernel.org>; Sun, 15 Mar 2020 03:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b+pS4BTpe/kYxJM1A6FUrnj6ADL81G5tBuUTXyYtFPk=;
        b=ZcmPeZNsxa85QkArNYZ0CPGLnDjkae8oUvn7J+4mvkUyYWcaNVP8fEPBpRDG8Ga8j6
         U/Uu5jruvBubgNKlFRYkn5k+Is9kVUG8PiQ8KAa3AN+pGeSe3fiyoP+cjFDW5KwjUjYh
         2XwksCSTYWdJx0mCUb3SCHt57OVSW0iD3h392PPkA94HkkopLTd3YGZD3nkntjjjsr3q
         Tfn3zIHuOYaHTuAwtvHuN8Hzor9FGHWFR/sQDfEAuT7h1WkEnnZeJ7aw4GvRkz0dLnll
         hQ8TGxJlPOKHpSFN0bnNSU/xim4TU0LP5cnVqV+1IL0g+PlSat6lW1Bd0quaWlFvHUYI
         kR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b+pS4BTpe/kYxJM1A6FUrnj6ADL81G5tBuUTXyYtFPk=;
        b=kNkiQqsU20hnsipJ+t3dhekKJe6U2zp2nufSyUsEkfzeIZfjHspMhFais1UIUD9Eep
         nSyfG2YKWF5HReAMlenpCMxv9HhbI+PDp1sEae1ksf+R4i29LUFyQ17cP72gCsAD2bhX
         p9CwMsb74R3XqpDo801UX0zCoe6UCDHJ6ONLMgU8JEdJomdg52iF1cySm50AVwdJ6Q+E
         6hY5soriVUhlMarRQfQYRWmOUpaKj/gHzfCzEcUunBbmhqw7S40FEYF0erGMJjPSCWNB
         HHhHOOPt1DBJRODYOaCa3TnfRdzSgvH9dIo+SCDdGko4Mj02ULXK/qlYXqB04nTZx+h+
         eU5Q==
X-Gm-Message-State: ANhLgQ21GghMxJPsW4ydGJ/Rne5HL7WeFK0Mwr25R061YAUJ/ALIkOhm
        4ZzsI72tQhd5vgSDSRzr1VA=
X-Google-Smtp-Source: ADFU+vuBOgt7wdVK1Wy5bAkhOvJYXg71dmBvjbbFZ2YAmkXbzTPMhbri4NT8b5WgmC/iN3w/eso7yw==
X-Received: by 2002:a05:600c:21d2:: with SMTP id x18mr21169162wmj.75.1584269577164;
        Sun, 15 Mar 2020 03:52:57 -0700 (PDT)
Received: from szeder.dev (94-21-29-150.pool.digikabel.hu. [94.21.29.150])
        by smtp.gmail.com with ESMTPSA id u1sm69612613wrt.78.2020.03.15.03.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2020 03:52:55 -0700 (PDT)
Date:   Sun, 15 Mar 2020 11:52:53 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Why am I on Master instead of my branch
Message-ID: <20200315105253.GI3122@szeder.dev>
References: <CAH8yC8=FZrDmHBSk=GFZd08Ovk4zffyB7KEOoyUpAPLYi_xUeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH8yC8=FZrDmHBSk=GFZd08Ovk4zffyB7KEOoyUpAPLYi_xUeA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 14, 2020 at 09:54:00PM -0400, Jeffrey Walton wrote:
> I'm trying to test some changes I made on a branch on some other
> machines. The changes were committed and pushed. However, after a
> checkout and pull on the other machines the changes were missing.
> 
> When I do a 'git branch' I am on master for some reason:
> 
> $ git branch
>   cmake-inno-setup-COVERAGE
>   config-guess
>   declarations
> * master
> 
> However, I have never switched back to master:

Perhaps you haven't switched away from 'master' in the first place.

> $ history | grep git | grep -E 'master|cmake'
> ...
> 2630  git checkout cmake-inno-setup-COVERAGE

This could have failed because the branch 'cmake-inno-setup-COVERAGE'
didn't exist.

>  2631  git fetch upstream cmake-inno-setup-COVERAGE

This fetched the branch 'cmake-inno-setup-COVERAGE' that exists on the
remote and stored the commit object id at its tip in FETCH_HEAD, but
it didn't create a local branch of the same name.

>  2632  git checkout cmake-inno-setup-COVERAGE
>  2634  git checkout cmake-inno-setup-COVERAGE

So these two failed as well, because there was no such branch.

>  2635  git branch cmake-inno-setup-COVERAGE

Here you do create a branch called 'cmake-inno-setup-COVERAGE'
(pointing to the currently checked out commit in your local
repository, which is most likely not where it points to in the remote
repo), but you haven't checked it out.

>  2757  git diff upstream/master
>  2766  history | grep git | grep -E 'master|cmake'
> <end of history>
> 
> How am I on master when I checked out cmake-inno-setup-COVERAGE?

Did you?
We can't tell without you telling us what the output of all those
commands were.

