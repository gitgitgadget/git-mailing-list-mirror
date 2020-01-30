Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73B1C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 21:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A9820CC7
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 21:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIRXayki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgA3Vhx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 16:37:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39749 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbgA3Vhx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 16:37:53 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so6003746wrt.6
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 13:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KR47AzEJyyEob+mIEEWiV2g5Ibgvk4RO/6sAS5IWHbw=;
        b=ZIRXaykiSXhQsd2z/03VC+U25F7BN/iSvsSiTiC5DILAlivJ3wjh+LuAEFW4B2gHUl
         cDLtWtFabE826rD9hIhjE0rrgV7POvtxR1HsA+x0MD2g7oxaEM733/raPmh/ZZzmQ+XA
         EVvRijyQ/+8L/mbVfXkpaDwQh3mRLo/sznLZ/Ix1XnSL2gcJIb+y5vku9rfOmyDToCEu
         Q22crnosgqCmbmBULidnNL2xP+DUjajLgXgRDZk6idb9SCdingnXOW60eR2cJcQioVWy
         Z2TtZRiE4DxFNnsNvCOIgwnmsAVxeBuUwsVt05/icjYy8qWnjpqeqDteznB7OSn/AePW
         3Sfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KR47AzEJyyEob+mIEEWiV2g5Ibgvk4RO/6sAS5IWHbw=;
        b=MCS+sofOsGknOk/YBvq696Nn3w7aqamq9lShZ1B6X5Eoue9VZKwqlws76kicyXo/LO
         vlzecX/akJzrJwp4jClUCjTgc25IdX88JvHj8hzrQq7Afo630J/OlVXkbCiFIUd/j3QV
         kQMBSu1g3fr/ZmRMn3ACGOsatyhhHZ3ZVNbxL8OwVZq2coYcrFgbT0PXXS21EyXx68q0
         FOTPiuAKvPGtc4LTZr3mzesnNsIa95Oy96UtO0WnZxPob2PLHXIWmT5QdCv9QH4JltS0
         Yz8udY/sY0lsjrKzBD+Deflc/gxN7UG/gARjEk+ugDj0GYEv7vNzrPWQLz7qPgt6Yifp
         b+pA==
X-Gm-Message-State: APjAAAXpsNVdAwIt+Y41oQQltTcHQ9Wex1pqlzc0wbkkWFJnBoqFDAr2
        /6qOl0/Wc091JYIzKVM4hipiw2wOswyqNKcCRRtM4QB0XHs=
X-Google-Smtp-Source: APXvYqxaPufPENgeRK/DK/SZJ3oDQSlQPdWkrQMUH2/Z1Nc2whie9qgdml23Qde77R0+7/2UOkwmKkeiSDDjWubXqmc=
X-Received: by 2002:a05:6000:1289:: with SMTP id f9mr7308055wrx.381.1580420271375;
 Thu, 30 Jan 2020 13:37:51 -0800 (PST)
MIME-Version: 1.0
References: <20200111123533.1613844-1-marcandre.lureau@redhat.com>
 <CAPig+cQXkiFOz5HczPEgXuSOH_3KsCwXwVwe0qvQzLDtFgnAXw@mail.gmail.com>
 <CAJ+F1CKW3NACgPdPbmAzYGVwR4iO3r+LCNq+g5st0gcz4X+fzA@mail.gmail.com>
 <CAPig+cRCMXjjPHc2O8fLmaSm9m-ZO3qR2BoZwG3s5dLHNbiFFQ@mail.gmail.com>
 <20200112121402.GH32750@szeder.dev> <CAPig+cRvYzm8Cb-AWqOeANRziWyjhWXT32QJ6TsA1==8Joa4zQ@mail.gmail.com>
 <20200124224113.GJ6837@szeder.dev>
In-Reply-To: <20200124224113.GJ6837@szeder.dev>
From:   =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date:   Thu, 30 Jan 2020 22:37:38 +0100
Message-ID: <CAJ+F1CL7RD2Rxaskk47f_UCQLP6yaM_woxTb1pag-ejqP9prBg@mail.gmail.com>
Subject: Re: [PATCH] branch: let '--edit-description' default to rebased
 branch during rebase
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

On Fri, Jan 24, 2020 at 11:41 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
>
> On Sun, Jan 12, 2020 at 08:59:04PM -0500, Eric Sunshine wrote:
> > On Sun, Jan 12, 2020 at 7:14 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com=
> wrote:
> > > On Sat, Jan 11, 2020 at 08:27:11PM -0500, Eric Sunshine wrote:
> > > > Taking a deeper look at the code, I'm wondering it would make more
> > > > sense to call wt_status_get_state(), which handles 'rebase' and
> > > > 'bisect'. Is there a reason that you limited this check to only
> > > > 'rebase'?
> > >
> > > What branch name does wt_status_get_state() return while bisecting?
> > > The branch where I started from?  Because that's what 'git status'
> > > shows:
> > > But am I really on that branch?  Does it really makes sense to edit
> > > the description of 'mybranch' by default while bisecting through an
> > > old revision range?  I do not think so.
> >
> > It's not clear what downside you are pointing out; i.e. why would it
> > be a bad thing to be able to set the branch description even while
> > bisecting -- especially since `git status` affirms that it knows the
> > branch?
>
> No, during a bisect operation 'git status' knows the branch where I
> _was_ when I started bisecting, and where a 'git bisect reset' will
> eventually bring me back when I'm finished, and that has no relation
> whatsoever to the revision range that I'm bisecting.
>
> Consider this case:
>
>   $ git checkout --orphan unrelated-history
>   Switched to a new branch 'unrelated-history'
>   $ git commit -m "test"
>   [unrelated-history (root-commit) 639b9d1047] test
>   <...>
>   $ git bisect start v2.25.0 v2.24.0
>   Bisecting: 361 revisions left to test after this (roughly 9 steps)
>   [7034cd094bda4edbcdff7fad1a28fcaaf9b9a040] Sync with Git 2.24.1
>   $ git status
>   HEAD detached at 7034cd094b
>   You are currently bisecting, started from branch 'unrelated-history'.
>     (use "git bisect reset" to get back to the original branch)
>
>   nothing to commit, working tree clean
>
> I can't possible be on branch 'unrelated-history' during that
> bisection.
>
>
> OTOH, while during a rebase we are technically on a detached HEAD as
> well, that rebase operation is all about constructing the new history
> of the rebased branch, and once finished that branch will be updated
> to point to the tip of the new history, thus it will include all the
> commits created while on the detached HEAD.  Therefore, it makes sense
> conceptually to treat it as if we were on the rebased branch.  That's
> why it makes sense to display the name of the rebased branch in the
> Bash prompt, and that's why I think it makes sense to default to edit
> the description of the rebased branch without explicitly naming it.
>
> With bisect that just doesn't make sense.

If the range you are bisecting belongs or lead to the current branch,
that still makes sense. And it's probably most of the time. So, I am
not sure your objection is valid enough here.



--=20
Marc-Andr=C3=A9 Lureau
