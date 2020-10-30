Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF50C2D0A3
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 01:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 474C420731
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 01:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mutual.io header.i=@mutual.io header.b="O7dtvWW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgJ3B0T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 21:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ3B0S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 21:26:18 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC73CC0613CF
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 18:26:16 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id za3so6412971ejb.5
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 18:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mutual.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XgqTBWHmNumEv+E5rI+t7/tOGCOAv2KXpI58qQMbMyU=;
        b=O7dtvWW7Yikw80meZsJOe3Ir2Od/8tNQytm57ndcSrWCM3wyA6b4erbQavpW+vbEXT
         Hs34wMkky3XyCST5SjOrdtBoNrgUjH+mPLrDW1+ARFZM5REma9ep6lPrwlSRbGi0tUO9
         AZ5AACfXuu/AeSLLMZMvwiAyqZekRPJmtgAcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XgqTBWHmNumEv+E5rI+t7/tOGCOAv2KXpI58qQMbMyU=;
        b=EGbXF9Ha7WaIdsIR4cGqpuuAYbGr8IFmQz3k3L9qVvBibgnG1GB2v5/mJkw1PUw00W
         MNaMnWX37XB7NKMyXFPxZ4egIeX7/91XWn9PnKqBVlOI+A1fZsYZM6dDe3x/Z8aEvYQC
         rI9P3BcU2FR7VxWS897HAeHelNCm8xn3kHoX7Fbi2XemaWHaaNJ0Q/uAleKzU3AmdTkz
         XzLtzFzmh0cSTOeHnxgK+kMPwLXyXZ61JzeNQaa2Kyp1cnAM7XdjsGNf/Us2ueWccNxO
         VmZ1nXc/kZt7dXMdWpX1fJYk5P0VZVO6O/Wim0WOwhd9QYMVRgGSyk7qtFUzkDGY2sVj
         Xi0w==
X-Gm-Message-State: AOAM533csvH+i+NCovkpwIf7FCVyNYUllXA0uWjoESaT2OgoUc/XGKiW
        A7smerLAt3AIYMjKvbFCb/Y/8pnDtGlag0WV6Zgapg==
X-Google-Smtp-Source: ABdhPJxH/utTy9tfFZrYCxk7dRRh1hJ9CM3oA8hyhGlolQmhxaxJki7i4khW7ivhZD/KURAbEw0MCYB+tEL0N34a1w4=
X-Received: by 2002:a17:906:512:: with SMTP id j18mr148140eja.370.1604021175369;
 Thu, 29 Oct 2020 18:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <CANo+1gtVRj30-JNPFpqc_m3BSEFzcb8-T+-uJTFvnNuBZYYxQQ@mail.gmail.com>
 <CAGyf7-HOkt3bCkJ+qshb0AFZSt2f=NmvHb3Gh1m2dzLWpYHozQ@mail.gmail.com>
In-Reply-To: <CAGyf7-HOkt3bCkJ+qshb0AFZSt2f=NmvHb3Gh1m2dzLWpYHozQ@mail.gmail.com>
From:   Daniel Duvall <dan@mutual.io>
Date:   Thu, 29 Oct 2020 18:26:04 -0700
Message-ID: <CANo+1gsdyU5sMRmV5OZxRZm5fqOFL3y-qFQN-PemdPKHFrJ8Mw@mail.gmail.com>
Subject: Re: [PATCH] Fix upload-pack EOF death in normal stateless negotiation
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Bryan. I did read the guide but not thoroughly enough it
seems. I'll give it another read and re-submit.

On Thu, Oct 29, 2020, 5:32 PM Bryan Turner <bturner@atlassian.com> wrote:
>
> On Thu, Oct 29, 2020 at 4:53 PM Daniel Duvall <dan@mutual.io> wrote:
> >
> > Hi there,
> >
> > I noticed while debugging an issue in Phabricator where shallow git
> > fetches over HTTP were failing with 500 errors that `git-http-backend`
> > seemed to exit abnormally after the first request even though the
> > response was otherwise correct=E2=80=94and when the error is not surfac=
ed to
> > the client, the packfile negotiation via `git-remote-curl` seems to
> > continue normally.[1]
> >
> > I think this patch fixes the issue by having `upload-pack` gently
> > handle EOFs at a specific point in negotiation=E2=80=94after shallow/un=
shallow
> > lines have been returned to the client (followed by flush) but before
> > the client sends its haves.
> >
> > This is my first contribution here so hopefully I'm understanding the
> > packfile negotiation protocol correctly and included my test in the
> > right place.
>
> Have you read Documentation/SubmittingPatches? It has some guidelines
> (like submitting patches inline, rather than as attachments) you'll
> want to ensure you've followed.
>
> >
> > Kindly,
> > Daniel
> >
> > [1] https://discourse.phabricator-community.org/t/git-fetches-with-dept=
h-over-http-results-in-500-errors/4317
