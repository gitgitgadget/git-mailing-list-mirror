Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB53C0015E
	for <git@archiver.kernel.org>; Tue, 15 Aug 2023 23:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240506AbjHOXAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 19:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbjHOXAB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 19:00:01 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B9C1FCB
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 16:00:00 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1c4d1274f33so2058891fac.3
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 16:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692140400; x=1692745200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtP2NNinjh2F2DKNw96guPbCA6MhKHgY+L5L6gBjChg=;
        b=HUR6LWsWQnkY9LPk+NWHMALeNlRi/o+yLYysypQ4MTNblLWiniyLRj1qrKP6tE5st7
         yGXF7f3YnQLswRf3wqgF+f27P+Phl29xkmy4jsrAEw5XBkTY3yt/r/eqJeGRGudeZe2u
         SdLGAOr+kt40V4AkMYK/61KS3P2dDe4HMUsX/z2L6qINKfupYjVoohhjMxLU5MrT6Qny
         AjTocIzJQhZ2eOLJp0iJn06+HAcpsdNroxj86Khj4fN6q2oa8lgSRHzStj+1/L0XUWyW
         2sMTx7oVlIKcaQh+Wh1QphrCHIu+lyTi3g3WZLPQ+V89XXlo9eP80vtr0aQysiOlGsRk
         xAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692140400; x=1692745200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NtP2NNinjh2F2DKNw96guPbCA6MhKHgY+L5L6gBjChg=;
        b=QcJ8KOjaP4O8ijIB95nWVwSVK7UFqciu6DHQkx85D5cj621w5elAkGLKC8jb8KKZIo
         C7Ev1cwvk9Ebq2sRc+WxhYSgXrw5tSSVToxykOW9Yp5Cy+c7lkWkJUhtpu1KfpwTlzdh
         f59PRa5rSdbWlDeGsK002A45t7LNWF6I8A6IA+4qMpnHHDXdnLrxiTgZiHrkfssMbuum
         QPEy4HSLqk9LhM3x7QvvfVVdW+G+hxkoOLObAT/ZDG14mGxTIwqNvkJ5sdfLE3o6fSwf
         fLKAAaOV25rK58MRNhhDnniH3m0RNymx9kE8Tu80LWQSDB8iek7NaQLZt6xS9fJigC71
         yA8w==
X-Gm-Message-State: AOJu0YxmNDVZllMu1Ng3f6iJGvmSRinKKrsLbq9t6vHr5X4s4zpU1hKg
        5GkbuZl6YaMdwLhu++JDACdGKjBfEEtmsd5F5Pa/2NCkFfI=
X-Google-Smtp-Source: AGHT+IHkI7BIpFqiT6UatMMm+G56ERdi4nFHdvMZnFsOG0F8f0h0fHoWTwpp+6xFHvdWLzNrekv/Qhv2ZYvVLeBv+UU=
X-Received: by 2002:a05:6870:819b:b0:1b4:4935:653f with SMTP id
 k27-20020a056870819b00b001b44935653fmr42340oae.49.1692140399648; Tue, 15 Aug
 2023 15:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLa=ZQmjroDiOcUsu_MHtQ-88QHU9qeZPOPh+KJJ3dFoF2q0A@mail.gmail.com>
 <xmqqttt0hzl2.fsf@gitster.g> <ZNv3+xOCi920StXO@nand.local>
In-Reply-To: <ZNv3+xOCi920StXO@nand.local>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Wed, 16 Aug 2023 00:59:33 +0200
Message-ID: <CAOLa=ZTXjV3abbuLYF8oE3P_P_xSZUtyM4fpPSg55Dd_QXoWXQ@mail.gmail.com>
Subject: Re: [Bug] In `git-rev-list(1)`, using the `--objects` flag doesn't
 work well with the `--not` flag, as non-commit objects are not excluded
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 16, 2023 at 12:11=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrot=
e:
>
> On Tue, Aug 15, 2023 at 12:31:37PM -0700, Junio C Hamano wrote:
> > Karthik Nayak <karthik.188@gmail.com> writes:
> >
> > > If you notice here, the objects
> > > `8baef1b4abc478178b004d62031cf7fe6db6f903`,
> > > `086885f71429e3599c8c903b0e9ed491f6522879` and
> > > `7a67abed5f99fdd3ee203dd137b9818d88b1bafd` are included in the output=
,
> > > these objects are reachable from
> > > `91fa9611a355db77a07f963c746d57f75af380da` and shouldn't have been
> > > included since we used the `--not` flag.
> >
> > For performance reasons, we cannot afford to enumerate all objects
> > that are reachable from --not objects and exclude them from the
> > output.  So it is a balancing act to decide where to draw the line.
>
> As a hack, you can exploit the existing bitmap traversal routine to
> build up an exact mapping of what is and isn't on either side of your
> reachability query.
>
> IOW, if you run:
>
>     git repack -ad --write-bitmap-index
>
> and then repeat the rev-list query with `--use-bitmap-index`, you should
> get exact results.
>
> Note that this will only work if pack.useBitmapBoundaryTraversal is set
> to false, since the boundary-based traversal that is behind that
> configuration option is susceptible to the same one-sided error.
>
> Thanks,
> Taylor

Thanks! I tried using bitmap traversal and can confirm the issue doesn't
exist with this option.
