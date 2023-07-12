Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435ACEB64D9
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 04:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjGLErm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 00:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjGLErj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 00:47:39 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E1A1731
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 21:47:38 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1b056276889so5317619fac.2
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 21:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689137257; x=1691729257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8h+4qzyjIYlPDB9CUmRXTVafZat/vaxwW3xYznJYCoE=;
        b=UxmbvdtEE9/SkDclIRVfYneKbJXF/E3/8ztIXt/8HEU4bOH6tYrMm7LEeIiwFUnF7D
         IL8l+b54VxREaOQPm7cCAF8vMO+Yp3wFmxHMoc7OUITGEcKiSfubUWL28FmpAyOiP0JR
         eX3SNVAqLQO4JsdTdWLwWyx8cZ8tjqjHwkL20dB9DNrqAmpvysssZBgE8vgEOyxXqNdy
         VuF6PxLiXgesGdBl3iFrYgxZQlOI59+aRth3nHCcDDzG09NvETXN0VhHA1h7y0QhgY0+
         3s01oivyJn/Cteq+2IW2PFBqDrC+t0f5iQiNgIfbQTUffgqzJZo9EpOeIaVTTKsjLBne
         V7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689137257; x=1691729257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8h+4qzyjIYlPDB9CUmRXTVafZat/vaxwW3xYznJYCoE=;
        b=GYV+v0Ab1I8HqrGkF8COEzbDEbR2ZnvarqhwBVSfImuQgNh91d6YTP7brc7in8zL/6
         1HcWrolZlsELUC7JsrKba+Ld4uGAJHgJzrMdqKNP3iG76deIEtmCHwYfkbR1ohLAnLTF
         3OnP7Z7Gp5m7zAz1c56OvxuBuxY2xncGCCJFsjEyp2V5c3nqBcbnw1hmH+IZ36b56sy4
         tNLlqLn7edbQ/WHX7v5v9SBz0yTDVNl+Fib5VEXPlef2/gvQJPsyfPs+qkQUMe5cZd/M
         CpHyXpUU0AHikY60p7O2NcLy2Mh82oupzfar7vFVCHBOrJZN6ZY09u9WSiBGHXDKsM2F
         C7iw==
X-Gm-Message-State: ABy/qLbZzZxxnTa6pOkk0nh78mTelMtRkgfbFF3ofUxhGMIEtEaDFkj1
        4+z9pA5ZKKMk0ANafbdxKrhJHjuwqmQTTqGS1Ug=
X-Google-Smtp-Source: APBJJlEs/taPn/HeMt9b0pzZB+jRUQrRR7MWPI9OT4oIA6Kdra8lRem9XfLYeG6dNrYSkmXkL5BE8+Inje7Vo6EGPsk=
X-Received: by 2002:a05:6870:738a:b0:1ad:2e18:7090 with SMTP id
 z10-20020a056870738a00b001ad2e187090mr20678614oam.32.1689137256775; Tue, 11
 Jul 2023 21:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230704194756.166111-1-alexhenrie24@gmail.com>
 <20230706040111.81110-1-alexhenrie24@gmail.com> <20230706040111.81110-2-alexhenrie24@gmail.com>
 <xmqqttugbxds.fsf@gitster.g> <xmqqo7kobwpj.fsf@gitster.g> <CAMMLpeS9_P=XXMoOdTAM3jZbaxfLEJNwYArS6p9pMXisT3TRtw@mail.gmail.com>
 <xmqq8rbra9ti.fsf@gitster.g> <CAMMLpeQ2P+qQxo17dEdWhMHcmAfTiBoEifp2wUjWVrP+oGSzxQ@mail.gmail.com>
 <xmqqbkgl6f04.fsf@gitster.g> <CAMMLpeSwadTcd+z0-J1t=vUgz0wFiVaE5KaT-Wy1cckT3=fFGQ@mail.gmail.com>
 <xmqqsf9v2roa.fsf@gitster.g>
In-Reply-To: <xmqqsf9v2roa.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Tue, 11 Jul 2023 22:47:00 -0600
Message-ID: <CAMMLpeTNMaVk7M2nLSJJzDMWPDVdyOr27Ae2-Usky5tW-dRqJQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] remote: advise about force-pushing as an
 alternative to reconciliation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 10, 2023 at 6:55=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > On Sat, Jul 8, 2023 at 7:38=E2=80=AFPM Junio C Hamano <gitster@pobox.co=
m> wrote:
> >>
> >> Alex Henrie <alexhenrie24@gmail.com> writes:
> >>
> >> > I agree, showing this message in the middle of `git commit` is not
> >> > ideal. However, that's a separate issue that can be fixed later; it'=
s
> >> > not part of the problem I'm trying to solve in this series.
> >>
> >> That is debatable.  Even "by the way you can pull and reconcile
> >> early before you have fully finished working on the topic and are
> >> ready to push back" is irrelevant during `git commit`.  "Reconciling
> >> the differences is not the only way to deal with divergence; you may
> >> decide to simply discard what they have with push --force" is even
> >> less relevant at that time.  So it seems to be very much an integral
> >> part of the problem you are tackling, at least to me.
> >
> > I thought we just agreed that we don't need to mention force-pushing
> > in this particular message? I guess you're saying that we'd still be
> > over-encouraging `git pull` if we don't remove this message from `git
> > commit` altogether?
>
> I do not think so.
>
> I was saying that, when the user during `git commit` is wondering
> what to write in the log message of the commit they are working on
> (which may not yet make the current branch ready to be pushed to or
> integrated with the remote), the user is not ready to even choose
> between "forcing push to overwrite" and "integrate and then push".
>
> It can be fixed later, but it is a part of "how to avoid giving
> confusing message to users, especially the new ones" theme.  After
> all, "do not make it sound like they always have to integrate" is
> how you started this journey, no?

To me, one of those things is bad advice, and the other is irrelevant
advice. They're both confusing, but one of them is more likely to
cause trouble than the other.

Omitting this message from `git commit` isn't technically difficult,
my main worry is that that change will be picked to death in code
review and it will hold up the more important changes. I have to find
time for Git outside of work and I'm already feeling pretty burned out
trying to communicate the problem and integrate the feedback on this
series so far. Even so, because it's important to you, and because I
appreciate your willingness to work with me on this problem, I'm
willing to take a stab at fixing both the bad advice and the
irrelevant advice in the same series.

Just to be sure that we're on the same page, when I said "I thought we
just agreed that we don't need to mention force-pushing..." and you
replied "I do not think so", were you only saying that you think that
changes to `git commit` are essential, or were you also saying that we
have not come to an agreement about whether to include force-pushing
advice in this message?

Thanks,

-Alex
