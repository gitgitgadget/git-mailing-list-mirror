Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BE3EC8742
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 17:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243366AbjIGR0S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 13:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243418AbjIGR0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 13:26:16 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9661FD4
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 10:25:49 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-402be83929eso13540355e9.3
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 10:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694107504; x=1694712304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtRmbGHo5/K7ut6F03yLC1ztLgppW4ZLhf+8bTJJ3Hs=;
        b=QF5TNR0klC0aMqlz4RAxsD5N7l88R/iHeCByDIadqS1OSUFoCd2xaqsUjwI58Ftdoo
         Z3BWAPtXrEYlWOPFRKAVLmD86PCoMmWmhX/a6d1jBmKvzmrYOmdFNMZVFw5SSxZT5Fcj
         zZozXrWuxLMei6bp5ZfyO9ZBL+fEZt+Lw9i4XzMJ1DbB5kI7asjIexyv3c/OFFiOnyV/
         fXdDXrxRKIeqqYNkaec5hEg7gw8kS9IG3legNa2G8VStuEXIiUEfBgBiqxv7wVIqtAbC
         0LgJHVVmbeuRrpi7vOEBn62tm0KPnPsNMPt13Le3T3+UFbMC4M0NNiu7WaWCu3E7JK4k
         dlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694107504; x=1694712304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtRmbGHo5/K7ut6F03yLC1ztLgppW4ZLhf+8bTJJ3Hs=;
        b=laXqBx2za73HGLBPLIsmDAAk2usyskEsmfipEEw906mbePm7och1E1w562jzOgjbrC
         bSjjeaxna/Q+2gaY23//YrDt/AW5e+WHBLsI1CUzIeWa5tYfJRfktteYfBfEWMKhmo8J
         RnifDYCs1QwvJ/uBtEoepqbWcmfueB6Vw5krjfh8hQL5clz47EXPRkqw0vCUkzT4BvOy
         eJ6BtGgEl7vfQkfsctgzQ0vc9MEUp/TNuXqREUVCrlBTVq+xnB8gQUzZDBnp7OlD9Af2
         imH59scmNgctTO/QTmAgqQFT2JATlVrMYE95lAmsNsG4LI+yckZ/I8YuwbnToRkyQ26B
         e+Eg==
X-Gm-Message-State: AOJu0YxmTSLzDRMwkq0xNwqVsRdMmVH7JTdFxmbuKvbENzxH4/aeIJM3
        P81FyQT/ggMooe86IN2zORJ2n8kb8pZCsh8LnYhGrxkX
X-Google-Smtp-Source: AGHT+IEARiXsRa+XFdoo9Xvsl42B3tT79bF46CmQWwLCT1VhdfWdJFLBiGztZlIIRz5otROBTpIa0NYNv3pJY1muStM=
X-Received: by 2002:a17:906:3117:b0:9a1:c2fe:41d9 with SMTP id
 23-20020a170906311700b009a1c2fe41d9mr4042123ejx.47.1694075987673; Thu, 07 Sep
 2023 01:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230407072415.1360068-1-christian.couder@gmail.com>
 <20230407072415.1360068-12-christian.couder@gmail.com> <8daf2603-2818-9c9d-7a06-6af2872a045a@github.com>
 <89c78da5-388a-e52b-b20b-e376ac90de14@github.com> <CABPp-BGfG3VeY1gOugzig8PLan1AS66BMWnyFSOsLOy-zqLdXw@mail.gmail.com>
 <b9732826-5732-0f87-9527-f49c38514fd7@github.com> <CABPp-BG3xNmwbtu+tstLr8bT24rr0gG65ZvD1rEeus_V8OYk=Q@mail.gmail.com>
 <bbdd3697-bc10-f311-dbef-99917603ce4f@github.com> <CABPp-BH5rLZyjLD91Bn=xThMXHk=q+kGcqPjPDOT0-N4fHfquA@mail.gmail.com>
 <f5dd91a7-ba11-917a-39e2-2737829558cb@github.com> <CABPp-BFCKrbSZQtRD1MnXrwB91O2YK9ZuGd6BiYQZ2zrpLp+uw@mail.gmail.com>
 <58f7918f-6ca3-2158-7d9e-bfcd8eb24b0d@github.com> <CABPp-BGRtcBQ_6fkMrTskV9dk71ffycXZ8hEE_RaOrAdza_wLA@mail.gmail.com>
 <f74fb509-0e1a-9542-d80c-0bec2a1e6740@gmx.de>
In-Reply-To: <f74fb509-0e1a-9542-d80c-0bec2a1e6740@gmx.de>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 7 Sep 2023 10:39:36 +0200
Message-ID: <CAP8UFD2KMikjJJQ0FGXO1EYYHRNWHH2n70UATU_o61PJ411f2Q@mail.gmail.com>
Subject: Re: [PATCH 11/14] replay: use standard revision ranges
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>, John Cai <johncai86@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Sun, Sep 3, 2023 at 5:47=E2=80=AFPM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah & Stolee,
>
> On Sat, 29 Apr 2023, Elijah Newren wrote:
>
> > On Mon, Apr 24, 2023 at 8:23=E2=80=AFAM Derrick Stolee <derrickstolee@g=
ithub.com> wrote:

> > > Basically, I'm not super thrilled about exposing options that are
> > > unlikely to be valuable to users and instead are more likely to cause
> > > confusion due to changes that won't successfully apply.
> >
> > Oh, I got thrown by the "right now" portion of your comment; I
> > couldn't see how time or future changes would affect anything to make
> > it less (or more) confusing for users.
> >
> > Quick clarification, though: while you correctly point out the type of
> > confusion the user would experience without my overriding, my
> > overriding of rev.reverse (after setup_revisions() returns, not before
> > it is called) precludes that experience.  The override means none of
> > the above happens, and they would instead just wonder why their option
> > is being ignored.
>
> FWIW here is my view on the matter: `git replay`, at least in its current
> incarnation, is a really low-level tool. As such, I actually do not want
> to worry much about protecting users from nonsensical invocations.
>
> In that light, I would like to see that code rejecting all revision
> options except `--diff-algorithm` be dropped. Should we ever decide to ad=
d
> a non-low-level mode to `git replay`, we can easily add some user-friendl=
y
> sanity check of the options then, and only for that non-low-level code.
> For now, I feel that it's just complicating things, and `git replay` is i=
n
> the experimental phase anyway.

I would be Ok with removing the patch (called "replay: disallow
revision specific options and pathspecs")
that rejects all revision options and pathspecs if there is a
consensus for that. It might not simplify things too much if there is
still an exception for `--diff-algorithm` though. Also it's not clear
if you are Ok with allowing pathspecs or not.

The idea with disallowing all of them was to later add back those that
make sense along with tests and maybe docs to explain them in the
context of this command. It was not to disallow them permanently. So I
would think the best path forward would be a patch series on top of
this one that would revert the patch disallowing these options and
maybe pathspecs, and instead allow most of them and document and test
things a bit.

> And further, I would even like to see that `--reverse` override go, and
> turn it into `revs.reverse =3D !revs.reverse` instead. (And yes, I can
> easily think of instances where I would have wanted to reverse a series o=
f
> patches...).

I think this might deserve docs and tests too, so it might want to be
part of a separate patch series once the existing one has graduated.

At this point I don't think it's worth delaying this patch series for
relatively small issues like this. There are many different ways this
new command can be polished and improved. The important thing is that
it looks like we all agree that the new command makes sense and should
have roughly the basic set of features that Elijah originally
implemented, so let's go with this, and then we can improve and
iterate on top of this.
