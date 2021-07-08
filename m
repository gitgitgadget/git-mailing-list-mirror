Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455B5C07E96
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 18:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20838616EB
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 18:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbhGHSIE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 14:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhGHSID (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 14:08:03 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47996C061574
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 11:05:21 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id j65so2707914oih.5
        for <git@vger.kernel.org>; Thu, 08 Jul 2021 11:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=cNUuK5hMdqEjUSM0i5eb+YCLzMw+qCiFV+B2PSU2O2M=;
        b=hnHIKxsU4AXZaJXE9tuoStxQQl1p+0lVIChe1HiSwdybzz+XCKnagDoDpiAsUP24A9
         MDhSjr+jmZhjYIuRPoTjv7YjwtR9t6UDUxmA/cA+Br/o6CFXi6LuohHOrs7r1ZFSyOR0
         lOTnWMoEacZLfR6wFczBbyQH8a7Q5X7jtbYZd7Me63LcSlDk7lqCDIa2Z12idyDWAuG1
         /3mUuNnSMy2BHxxXdj3MvyEkMEoZZfyKD5/PkFQV3JKekjBrRyXff0KT6/fnSe59tYDb
         E6OO4uhuZhUqd5o31FjXY9pbYSm+Mit9AUBSxlxPV9xa5PFDvDDCycmMnB/4RU9GkNmL
         YjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=cNUuK5hMdqEjUSM0i5eb+YCLzMw+qCiFV+B2PSU2O2M=;
        b=J6QAjyJVSZ+lV1hLycTpYH+BytF9+lc6RmMP96p12HwGc4jpBmTodREtidukFRrOLi
         wv5l0PoMKdNwhvycSc1/ETmWTjgi4kq3OXXMBGJcJ2gICpOJlau66kz6KiqxZ5fManDD
         xhDJcR6QuyIaAAyR6JHuWc2N5Z+xtw/MJ7AWIbQldySIWWjtSN77H2q7aoTK41WmtMKx
         BS4O+1mgRzfl53P0JECSLO8vKq4NUmPybg0PQsrWzeMhXIyl9RpYCG72n778ixYOC1oD
         e4fCGLDY/V0cnrESxio8bc4aORS1zsnPDjrI4e4fY3SsZL93WpkSWTwtvlFHARPK23Ob
         Svzw==
X-Gm-Message-State: AOAM530v+P7sU4l7RPHvcqq+IJ52oB6FasUApZlNVmhY76mx24B8/GLf
        Kuq/uwTM5deFIjsAOxvBQJk=
X-Google-Smtp-Source: ABdhPJxRp6oGSr2t/LuyrWkXqdvhHY4tKLYIWaNauPwMI9jrTdrN/ezsgTDipe58YOBeyiyQAocnMw==
X-Received: by 2002:aca:4888:: with SMTP id v130mr1855151oia.161.1625767520645;
        Thu, 08 Jul 2021 11:05:20 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id bb34sm504732oob.39.2021.07.08.11.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 11:05:20 -0700 (PDT)
Date:   Thu, 08 Jul 2021 13:05:18 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Martin <git@mfriebe.de>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Message-ID: <60e73e5ebd069_309390208a@natae.notmuch>
In-Reply-To: <87im1l3vj2.fsf@osv.gnss.ru>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <xmqqk0mcy6g2.fsf@gitster.g>
 <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
 <xmqqpmw4uwh2.fsf@gitster.g>
 <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
 <xmqqy2arrmba.fsf@gitster.g>
 <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
 <87wnqaclz8.fsf@osv.gnss.ru>
 <60e5f3981de5f_301437208bc@natae.notmuch>
 <87bl7d3l8r.fsf@osv.gnss.ru>
 <60e61bbd7a37d_3030aa2081a@natae.notmuch>
 <877di13hhe.fsf@osv.gnss.ru>
 <60e66d28c0cb3_306ac120813@natae.notmuch>
 <87im1l3vj2.fsf@osv.gnss.ru>
Subject: Re: What actually is a branch?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Sergey Organov wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >> 
> >> > Since this is not strictly related to the topic of `git switch` I
> >> > renamed the thread.
> >> >
> >> > Sergey Organov wrote:
> >> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >> >> > Sergey Organov wrote:
> 
> [...]
> 
> >> >> As for branch tail, I do have convention of marking start of a
> >> >> long-standing branch with corresponding tag, where branch "foo" has
> >> >> corresponding "foo-bp" tag marking its "branch point". Recently I
> >> >> started to mark start of feature branch with yet another branch "foo-bp"
> >> >> rather than tag, "foo" being set to track "foo-bp", that allows to
> >> >> automate rebasing of "foo" against correct base.
> >> >
> >> > So foo-bp is the upstream of foo, and you do basically:
> >> >
> >> >   git rebase foo@{upstream}
> >> 
> >> Yep, but essential feature to me is that I in fact use tools that simply
> >> run bare
> >> 
> >>    git rebase
> >> 
> >> and that "just works" (tm).
> >
> > I typed the revision explicitly, but `git rebase` would work just
> > fine.
> 
> Sorry, I don't follow. Did you change semantic of `git rebase`? With
> current mainstream Git, as far as I can tell,
> 
>   git rebase
> 
> essentially is:
> 
>   git rebase --fork-point @{upstream}

More explicitly, it's

  git rebase --onto @{upstream} --fork-point @{upstream}

> How introduction of @{tail} changes this, exactly?

Now --fork-point is not necessary:

  git rebase --onto @{upstream} @{tail}

> >> > This is works if your base (or tail, or whatever) is static, but many
> >> > branches jump around, and that's where @{tail} comes in handy.
> >> 
> >> Yeah, I see. When I need to make a branch jump around, I do need to
> >> manually move my references, but that's fortunately very rare use-case
> >> for me. Having direct support for that is still a win.
> >> 
> >> >
> >> > You can do this:
> >> >
> >> >   git rebase --onto foo@{upstream} foo@{tail}
> >> >
> >> > This will always rebase the right commits (no need to look into the
> >> > reflog). So you can say that the branch is foo@{tail}..foo.
> >> 
> >> I see where and when it's useful, but for a feature branch 99% of times
> >> I don't want to rebase it onto some true upstream. I rather want to just
> >> fiddle with the branch in place, and I prefer to setup things the way
> >> that ensures that bare "git rebase" does "the right thing".
> >
> > But that's precisely the point: when you do `git rebase` you don't have
> > to type the base or --onto anymore. It's done automatically.
> >
> > Not just for your long-standing branches, but for *any* branch.
> >
> >> Probably that could be solved by a branch-local configuration that makes
> >> "git rebase" become "git rebase @{tail}" for the branch instead of "git
> >> rebase @{upstream}"
> >
> > No. @{upstream} is where you want to rebase *to*, @{tail} is where you
> > want to rebase *from*.
> 
> My point is that for feature branch I rather want to rebase from @{tail}
> to @{tail} 99% of times.

Just make @{upstream} = @{tail}, then you get your desired result.

> > When you do:
> >
> >   git rebase foo@{upstream}
> >
> > This is basically the same as:
> >
> >   git checkout foo@{upstream}^0
> >   git cherry-pick --right-only foo@{upstream}...foo
> 
> Yes, but you probably meant foo@{upstream}..foo (2 dots, not 3) here.

I think if you do foo@{upstream}..foo then that --right-only doesn't do
the same thing.

`--right-only foo@{upstream}...foo` will drop commits that already part of
upstream. Another way you can find commits already part of upstream is
with `git cherry foo@{upstream}`.

> > git is smart enough to figure out what commits are already part of
> > foo@{upstream}, and those are skipped, but at no point was any "base"
> > calculated (at least not from `git rebase`).
> >
> > Most of the time `git rebase` works fine, because there aren't too many
> > commits to figure out where they should go, but it's definitely not
> > efficient, and there's many corner-cases (see a Linux kernel maintaner
> > baffled by what the hell `git rebase` is doing [1]).
> 
> Once again, how exactly the foo@{tail} fits in this picture?

It sets <upstream> so no --fork-point is necessary.

> >> > Another advantage of having this notion is that `git rebase`
> >> > automatically updates the tail (in this case to foo@{upstream}).
> >> 
> >> Yep, looks useful. Is it all local to given repo, or else?
> >
> > I implented it as 'refs/tails' (as opposed to 'refs/heads'), so it's
> > local to a given repo, but could easily be exported.
> 
> Do I get it right that now `git switch br1; git rebase --onto br2` will
> likely have different outcome in the repository where "br1" has been
> created compared to any other repository, as "br1@{tail}" will only
> exist in that exact repo?

It very well could, if `--fork-point @{upstream}` finds a different base
than `@{tail}`.

Cheers.

-- 
Felipe Contreras
