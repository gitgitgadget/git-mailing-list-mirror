Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A99C43463
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 20:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48B7320829
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 20:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="ahpQ5nAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgITUwf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 16:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgITUwe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 16:52:34 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AF7C061755
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 13:52:34 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x14so10663962wrl.12
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 13:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uDaM/DkzTg39L+jSbmZNJggS9EYB+Zdj+Dq81AymA0w=;
        b=ahpQ5nAVZQQXxHQEjmcRJm4r76nCxoO2hD+ZrVdkO4aoLGvlR7k/XRAXg/Bsc2AW8D
         GuqUAlKCsSNu6UuRXJA9LSyCmrYhkqjdu6hbx9P1o7wvBAxazcApdRWmH9piLzIEnXtO
         t6N8XpLWBBf1UozgRL3ZMSDqSr6RwpMc6XeZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uDaM/DkzTg39L+jSbmZNJggS9EYB+Zdj+Dq81AymA0w=;
        b=Y2Fw043hsFkiqagCG3ZbdVno98NjQ4K6D6iNXq5H4u6lYrqH2pcrCIE9HCVBIfPlfk
         h0AKzT9FZah8kcMv5gty10HB4PnH6YRXsGsp/v57soTW3VnDc3rH7bekLm6XQm77Ixk9
         dNToCI+Vmq8f1+sI+3jSI7tq1SSt/Akng/zwczw55JJRJJ/OORUmTQ2qKnhLnvH+RmDF
         qwFlBNKxAXZusJ8MU2khRgiknrBj3ofr7xQvP7oJ6+MX4rPf+K28psLonDTWHXu5Kyy+
         18NpwJIzFskIr+T26oXr/uxA0PpG2j4cFQ0m0K4EX4AIB2dr3xmzzkxNjYL0NtsWwXbo
         CWJw==
X-Gm-Message-State: AOAM533jYinK1+ET75Nj3ESe+NhTv4wcD75CUoQwU/BharFqtOVaHIto
        tNydMBxGHwSMKS7Fzp4lo/flS0+BzKmQOuD/F7UkZg==
X-Google-Smtp-Source: ABdhPJzGELJrP9w4eMNpUN/wNnQ3jcc8ht6TJmM2VChvwIxALUWjF7dLHfQ0AVERkDUkIwBf6NhVZBqp57XVBMgNUAA=
X-Received: by 2002:a5d:6912:: with SMTP id t18mr51576030wru.326.1600635153198;
 Sun, 20 Sep 2020 13:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAE5ih78zCR0ZdHAjoxguUb3Y6KFkZcoxJjhS7rkbtZpr+d1n=g@mail.gmail.com>
 <CAE5ih79puooMA1v8jOkqKaO9xPmYqtkT9kXHq2L6YODJJ8oGEQ@mail.gmail.com> <4eb688f2-0c17-9b85-e60e-f07485895622@gmail.com>
In-Reply-To: <4eb688f2-0c17-9b85-e60e-f07485895622@gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Sun, 20 Sep 2020 21:52:22 +0100
Message-ID: <CAE5ih78bWJ3BjvJw0=0=ry2OpcT5Dg5ryibw9Cf6pg-xhAJf4Q@mail.gmail.com>
Subject: Re: How to checkout a revision that contains a deleted submodule?
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git Users <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 20 Sep 2020 at 19:02, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> On 20/09/20 3:14 pm, Luke Diamand wrote:
> > On Sat, 19 Sep 2020 at 10:03, Luke Diamand <luke@diamand.org> wrote:
> >>
> >> Maybe this is a FAQ, but I couldn't figure it out!
> >>
> >> I have a repo which has a couple of submodules.
> >>
> >> At some point in the past I deleted one of those submodules:
> >>
> >>      git rm sub2
> >>      git add -u
> >>      git commit -m 'Deleting sub2'
> >>      git push origin
> >>      ...
> >>      ... more commits and pushes...
> >>
> >> Now I go and clone the head revision. This gives me a clone which has
> >> nothing present in .git/modules/sub2.
> >>      login on some other machine
> >>      git clone git@my.repo:thing
> >>      cd thing
> >>      ls .git/modules
> >>      <sub2 not present>
> >>
> >> So when I go and checkout an old revision where sub2 is still around I get:
> >>      git checkout oldrevision
> >>      fatal: not a git repository: sub2/../.git/modules/sub2
> >>
> >> What am I doing wrong?
> >> What set of commands do I need to use to ensure that this will always
> >> do the right thing?
> >>
> >> Thanks
> >> Luke
> >
> > Replying to myself, adding Jens who added the section below.
> >
> > This is a known bug:
> >
> > https://git-scm.com/docs/git-rm
> >
> >> BUGS
> >> ----
> >> Each time a superproject update removes a populated submodule
> >> (e.g. when switching between commits before and after the removal) a
> >> stale submodule checkout will remain in the old location. Removing the
> >> old directory is only safe when it uses a gitfile, as otherwise the
> >> history of the submodule will be deleted too. This step will be
> >> obsolete when recursive submodule update has been implemented.
> >
>
> I don't think that part of the documentation applies to your case. So,
> I also don't think this is a known bug. As a matter of fact, I couldn't
> reproduce this with the following:
>
>
>  git init checkout-removed-submodule &&
>  cd checkout-removed-submodule/ &&
>  echo "Hello, world" >foo &&
>  git add foo && git commit -m "Initial commit" &&
>  git init ../submodule &&
>  cd ../submodule/ &&
>  echo "Foo bar" >foobar.txt &&
>  git add foobar.txt && git commit -m "Foo bar baz" &&
>  cd ../checkout-removed-submodule/ &&
>  git submodule add ../submodule/ foobar &&
>  git commit -m "Add foobar submodule" &&
>  git rm foobar/ &&
>  git commit -m "Remove foobar submodule" &&
>  git checkout HEAD~ # Checking out the "Add foobar submodule" commit
>
> I get:
>
>  HEAD is now at 25270d8 Add foobar submodule
>
>
> I also tried with a cloned version of that repository as follows:
>  git clone /me/checkout-removed-submodule/ cloned-repo &&
>  cd cloned-repo &&
>  git co HEAD~
>
> I get:
>
>  HEAD is now at 25270d8 Add foobar submodule
>
> So, I don't get any errors when I checkout a revision where the deleted
> submodule is still around. There might other factors in play such as,
>
> - the version of Git being used
> - whether `--recurse-submodules` was passed to checkout
> - the configuration of the submodule in .gitmodules
>
> It would be great if you could share these and possibly other useful
> information to help us identify why you get an error when checking out
> the revision.

Thanks for taking the time to answer!

I will see if I can come up with a test case.

Luke
