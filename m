Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BFAC07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 19:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2835B6135E
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 19:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbhGJTyo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 15:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbhGJTyo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 15:54:44 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FCAC0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 12:51:58 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id i5-20020a9d68c50000b02904b41fa91c97so9093263oto.5
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 12:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Y1bm5FoAz004gCAK3zoZcAdYgowXFmfMGOa+00taCUY=;
        b=LMXyUK14nIEVV8njegBVn90GBIChShRTAE59IDFGtbfWy9H1YoOxEXCJM/6WEnzW3B
         iHgXBb/ZaI2+mwdLhUeht+ePO2X06zW4j+PsWMZkQVZt37JxXPNAuOTiBwqwCQ0E5P8h
         usxVqtVpjxYf7I5f/BjW+/cmrJA61rnRArEyLUF4+ub+j6gozCvZdFDCK/QdRypFviNR
         sEu25giksN25q0zQoOH8HWSDZPrlUsX4+BcP5/imKHQwGSd58CFqPEdnqyVgbvVeZpiu
         cFNrsefJCKJQ4EoeC5yL219BvD3nvfPjszSEnHz1+s2vdc14MRp151qVuklPe3LVrhgk
         8QuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Y1bm5FoAz004gCAK3zoZcAdYgowXFmfMGOa+00taCUY=;
        b=gWn5FjEpUMzCeQeAuRXYd69C8lcyC+V1ZEl4CAxvLHtiuOfVv4OuQZmSNC9O0p1Uhr
         Tl6883Ylg8mkTPcNj9ge7i1uL9MpBA1uiDIX4NThae/R1TokCZIMgaRt3aoxwRZl8/wB
         Lq9Lsyviigz5fbnG9yJi1BadRQzAABMyQKwSy8Ua02IvH6rbe0qar+Ijq4jx2/ty3icR
         grTUnTUggC3VK9qU//kl02vDcl6GmxkHaf7UVQ7TIKU4yyGc1MpJwJw4NdH9/YdkIM94
         UoNvSSazyKDOoo84NWrREs10xLfgLIs1QbAU0+Nr/56ZweMd4mJywQSTmqodHcyrI2Nj
         7GDQ==
X-Gm-Message-State: AOAM533DboDZV3N85LdvcXgE0s1N84Pxbco5KSX7OLwHMsO8bfD+KTZM
        gZwXEHHJBMDuUTju/FceZcY=
X-Google-Smtp-Source: ABdhPJxh6yQkq+Cadli8fUxpamWdNFOV+n5eF2KCixyCMEWcp0dNcbQigpydWeBfBEQS/uG/gHsNuA==
X-Received: by 2002:a9d:2d82:: with SMTP id g2mr35148310otb.30.1625946718039;
        Sat, 10 Jul 2021 12:51:58 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id g1sm1997891otq.22.2021.07.10.12.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 12:51:57 -0700 (PDT)
Date:   Sat, 10 Jul 2021 14:51:45 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>, Martin <git@mfriebe.de>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <60e9fa5132e14_7ef20849@natae.notmuch>
In-Reply-To: <87im1ieaba.fsf@osv.gnss.ru>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <xmqqpmw4uwh2.fsf@gitster.g>
 <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
 <xmqqy2arrmba.fsf@gitster.g>
 <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
 <87wnqaclz8.fsf@osv.gnss.ru>
 <60e5f3981de5f_301437208bc@natae.notmuch>
 <87bl7d3l8r.fsf@osv.gnss.ru>
 <60e61bbd7a37d_3030aa2081a@natae.notmuch>
 <877di13hhe.fsf@osv.gnss.ru>
 <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
 <60e67389a4adc_306ac1208fd@natae.notmuch>
 <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
 <60e736e72da68_30939020850@natae.notmuch>
 <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
 <60e762243aab1_30a7b02089@natae.notmuch>
 <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
 <60e79c31aaa72_30b8a4208c1@natae.notmuch>
 <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
 <60e874e1c6845_215320861@natae.notmuch>
 <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
 <87im1ieaba.fsf@osv.gnss.ru>
Subject: Re: PATCH: improve git switch documentation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> Martin <git@mfriebe.de> writes:
> =

> > On 09/07/2021 18:10, Felipe Contreras wrote:
> >> Martin wrote:
> >>> As for "git switch -C"
> >>> This should IMHO change to (the 2nd arg, actually depends on the po=
int
> >>> "1" above)
> >>>      git switch (-c|-C) <branch-name> [<base-commit>]
> >>>
> >>> I suggest to not call it "new-branch-name" because, it might be an
> >>> existing name.
> >> I think the name is all wrong. As =C3=86var pointed out --new (-n) i=
s much
> >> better. Also it doesn't make much sense to use "create" or "new" for=

> >> something that already exists.
> >
> > The n versus c issue is IMHO separate. Maybe tiny overlaps.
> >
> > I see it mostly in the light of -c should be for "copy".
> >
> > On "git checkout" it is "-b" for branch. That works, if you perceive
> > "branch" as a verb. "The action of branching creates a new branch".
> >
> > If needs must, that would work as "git switch -b" to.
> >
> > Actually, "new" or "create" would make sense in "git branch". But in
> > git switch, they actually raise the question "create what?" / "new
> > what?".
> =

> I believe that's because "git switch" tries to do too much. "git switch=
"
> should rather switch between existing branches, and do nothing else.

I don't know if it's trying to do too much. I know `git checkout` is
trying to do too much, and I've been trying to use `git switch` instead
for a while. I often create branches and switch to them using
`git switch -c` (which I think should be `git switch -n`).

In my mind it's "switch to a new branch".

So, how would I do this operation (create a new branch and switch to
it), without using `git checkout` or `git switch -c`?

> As I said once in this discussion already: trouble writing good
> documentation is often indication of some flaws in the design.

Completely agree. But I believe the difficulty is in the semantics of
what a branch means in git, not anything to do with `git switch` per se.

> Creating (a branch) is fundamentally different operation than switching=

> to (a branch), and that's why the former doesn't fit into "git switch".=


Not in my mind. Instead of switching to an existing branch, I'm switching=

to a new branch, which is easily understood by
`git switch --new branch`.

-- =

Felipe Contreras=
