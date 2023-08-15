Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECA1C0015E
	for <git@archiver.kernel.org>; Tue, 15 Aug 2023 22:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240494AbjHOW57 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 18:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240465AbjHOW50 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 18:57:26 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698A0198E
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 15:57:25 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1a1fa977667so4556431fac.1
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 15:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692140244; x=1692745044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7i0eemkyrWa6E+E4e/PH+5zjOq15a+yu/nPKNqQ62s=;
        b=Dnv1vUEL52tnvgQpiyBGL7mJvCi/Nfcoh/rFvcDDPAxlyg/RHVd4vAjHPLuv1iBDXA
         lnLPIRHHyVSOOsiVAC5EvnlrYECHIC2IiHCUW3vp7GtL6rpW7CZNoSrtZUVtO//7y+50
         vFdlIxDvfYafYrZxSEGrRE0IbLZ9DqwkmsjKxINf4hL0bJ7KdwLOL1AsPEUX1bk8ZRGu
         wzx8U1NY4ANGNmbATG4OSvIUjIgpOIlYl19N/p1uvzqiai+fD8kxEO8z54pFktwl0Pe/
         bT72PAsDBR4yP4ZUIEWChHQHW9ApZjdK9y/2x9u9y7puFY9mLnYX4Qsxd8G1jf0p32A4
         TdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692140244; x=1692745044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7i0eemkyrWa6E+E4e/PH+5zjOq15a+yu/nPKNqQ62s=;
        b=cH+H2M8AVWE25S5OObHboitA2aui6Kv2uTYNGuZjmPGSjJ7qkSYOTT3+VDc0Cl4r3G
         wVjYUv6pANz8Sim2N2CLE2gn+WAeDm58JPQM6Kr+V/YQw1pZnrPiEn7yKt0GPyrIMJFl
         0eL0Alkdpu/JfD11gcFkyyPdjLjh5UORPQKYURNw4T7HUTopGKP/iHtwbsjjKDV7Sjky
         HMDuR9oMlWYgJooxEPvN2ciSpQN2Au9tvQcO9mI7RJlVW38zX617cgA8RNe/6SGRfMj6
         9vR+BenNu/txUF0dtqqHGbL/sqw6MiZyKyniP8fwlZ8eNmHTVp5+WgmZ3ZtmAB9P9UyG
         yqjg==
X-Gm-Message-State: AOJu0YyJzI1PNqoC/LfbJhjNhr5qw4voomziez1f6t35ADpNWcfst7go
        qWxNmX7wBwfDtG1fvgIHSxHIVM4zI0YM+m1Ys/nb6EGA2OBCUA==
X-Google-Smtp-Source: AGHT+IGTRIqC+mwd+vgssZL3VdS7W7si+0qIyUbC3YdUfUO+S+f7AQw02f/8QKxT07Y050CLfd21GXifuzgPvFyoSNk=
X-Received: by 2002:a05:6870:82a9:b0:1b3:f370:79c7 with SMTP id
 q41-20020a05687082a900b001b3f37079c7mr86545oae.37.1692140244443; Tue, 15 Aug
 2023 15:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLa=ZQmjroDiOcUsu_MHtQ-88QHU9qeZPOPh+KJJ3dFoF2q0A@mail.gmail.com>
 <xmqqttt0hzl2.fsf@gitster.g>
In-Reply-To: <xmqqttt0hzl2.fsf@gitster.g>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Wed, 16 Aug 2023 00:56:58 +0200
Message-ID: <CAOLa=ZQPmtqT9OHxh5uFq0rg+9L02tnmh1UE52em-rXPmFR6yg@mail.gmail.com>
Subject: Re: [Bug] In `git-rev-list(1)`, using the `--objects` flag doesn't
 work well with the `--not` flag, as non-commit objects are not excluded
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2023 at 9:31=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> > If you notice here, the objects
> > `8baef1b4abc478178b004d62031cf7fe6db6f903`,
> > `086885f71429e3599c8c903b0e9ed491f6522879` and
> > `7a67abed5f99fdd3ee203dd137b9818d88b1bafd` are included in the output,
> > these objects are reachable from
> > `91fa9611a355db77a07f963c746d57f75af380da` and shouldn't have been
> > included since we used the `--not` flag.
>
> For performance reasons, we cannot afford to enumerate all objects
> that are reachable from --not objects and exclude them from the
> output.  So it is a balancing act to decide where to draw the line.
>
> Spending more cycles and heaps for traversing the --not side deeper
> may make the --objects output smaller and more precise, but there of
> course is cost associated with it.  And --objects do not promise
> that it gives absolute minimum---the reason it exists is to make
> sure the objects listed are sufficient to fill gaps between the
> --not tips and positive ones, which is the primary reason for its
> existence.
>

I understand this, this makes sense from how rev-list is internally
used. But from a user
facing command perspective, it's not doing what it says. So either we
add to the docs
saying that there are quirks using `--not` with `--objects`  or we fix this=
.

So I would still consider it a bug in that sense.

> > The diff below fixes the issue:
> >
> > @@ -3790,11 +3833,12 @@ int prepare_revision_walk(struct rev_info *revs=
)
> >          commit_list_sort_by_date(&revs->commits);
> >      if (revs->no_walk)
> >          return 0;
> > -    if (revs->limited) {
> > +    if (revs->limited && !revs->tree_objects) {
> >          if (limit_list(revs) < 0)
> >              return -1;
> >          if (revs->topo_order)
>
> This might change the size of the output and "fix" the output in
> your particular small test case, but I am not sure what kind of bugs
> this will introduce in the more general codepath.
>
> Not calling limit_list() when the .limited bit is on is breaking one
> of the most fundamental assumptions in the revision traversal.  When
> a feature is enabled that needs to paint the graph upfront before it
> can compute its result, the code that enables the feature flips the
> .limited to ask this part of the code to make sure it calls
> limit_list() to paint the graph with UNINTERESTING bit.
>
> This area to paint uninteresting trees have changed quite
> drastically at d5d2e935 (revision: implement sparse algorithm,
> 2019-01-16).  Some of what it removed may be contributing the "over
> counting" of trees that are relevant in your example.
>

I never proposed this as the solution, this was merely me trying to underst=
and
why it is working the way it is, hence calling it a _naive_ fix.

> The differences in commit object names become distracting, but I do
> not think your example depends on them, so a minimum reproduction
> recipe should be
>
>         $ rm -fr new ; git init new ; cd new
>         $ echo foo >foo
>         $ git add -A; git commit -m one; git rev-parse HEAD:
>         205f6b799e7d5c2524468ca006a0131aa57ecce7
>         $ echo moo >moo
>         $ git add -A; git commit -m two; git rev-parse HEAD:
>         672d0aa883d095369c56416587bc397eee4ac37e
>         $ mkdir bar; echo goo >bar/goo; echo abc >abc
>         $ git add -A; git commit -m three; git rev-parse HEAD:
>         0c16a6cc9eef3fdd3034c1ffe2fc5e6d0bba2192
>         $ git rm moo; git commit -m four; git rev-parse HEAD:
>         ff05824d2f76436c61d2c971e11a27514aba6948
>
>         $ git rev-list --objects HEAD^..HEAD
>         5a1b93c9c4c0c9e5c969f8e0b92a02184f8f9aab
>         ff05824d2f76436c61d2c971e11a27514aba6948
>
> that output lists HEAD and HEAD^{tree} in this order, which seems to
> be what you are expecting.
>
> I am consistently getting the same result with Git 2.42-rc2, 2.41,
> 2.21, and 2.20 (I do not have ones older than 2.20 around).

The provided reproduction recipe unfortunately uses a linear history and
therefore, is not the same as the example provided by me. Here is a reprodu=
cible
recipe following the same commands you used:

$ rm -fr new ; git init new ; cd new
$ echo foo >foo
$ git add -A; git commit -m one; git rev-parse HEAD
26fb965d7439c1760677377bf314d8933de0b716
$ mkdir bar; echo goo >bar/goo
$ git add -A; git commit -m two; git rev-parse HEAD
$ git checkout -B branch
$ git reset --hard @~1
HEAD is now at 26fb965 one
$ git add -A; git commit -m three; git rev-parse HEAD
91ef508167eb683486c3df6f8d07622b61ed698d

$ git rev-list --objects HEAD ^master
91ef508167eb683486c3df6f8d07622b61ed698d
ff05824d2f76436c61d2c971e11a27514aba6948
8baef1b4abc478178b004d62031cf7fe6db6f903 abc
086885f71429e3599c8c903b0e9ed491f6522879 bar
7a67abed5f99fdd3ee203dd137b9818d88b1bafd bar/goo

$ git cat-file -p HEAD^{tree}
100644 blob 8baef1b4abc478178b004d62031cf7fe6db6f903    abc
040000 tree 086885f71429e3599c8c903b0e9ed491f6522879    bar
100644 blob 257cc5642cb1a054f08cc83f2d943e56fd3ebe99    foo

$ git cat-file -p master^{tree}
040000 tree 086885f71429e3599c8c903b0e9ed491f6522879    bar
100644 blob 257cc5642cb1a054f08cc83f2d943e56fd3ebe99    foo

> So, there is something else going on in *your* build of Git, or the
> repository you prepared for testing, or both.
>

$ git version
git version 2.41.0

So the issue definitely exists, this is on an unmodified git. You can see t=
hat
the objects `086885f71429e3599c8c903b0e9ed491f6522879` and
`7a67abed5f99fdd3ee203dd137b9818d88b1bafd` are still shown (which shouldn't
have been shown).
