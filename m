Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB29CE94139
	for <git@archiver.kernel.org>; Sat,  7 Oct 2023 01:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbjJGBc2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 21:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbjJGBc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 21:32:27 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CAFB6
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 18:32:25 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50444e756deso3608775e87.0
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 18:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696642344; x=1697247144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfjdcVpic+2pvXqlIre7fGrapyzLe77Y81xYJxN9Hs4=;
        b=d3MGdmZQSrMx/uikO7ojC99Olpjd5PE4zkpL6QWIOBeANoBNhppbjtp7BxOKvhOA8a
         FEQYsWCHhFXpXIh+GhJRmpoSo7yG2AIaLkh7xC+U0nn5BOD75FYizhkxFMX8oHliZFvU
         UugYbbsJkTaLUPqPmv3o60Wkbvhh/6Gp7Vkfyh4ZAQAIrjQIeDyjqANQZeYaLjj9Ew7e
         t/N3wtrA4EbGZ9HpnVK0jO5DxEpX8CdsOvRkB7NJuJ8BYZOyT6SaKrPSopuGYaeMdjXj
         L9zA0frG0GBs8YNVTQdIJi7v5RKNjbePUUYkaFc28ZbP8Gv1hoY1uqCev+WlcOhprt17
         R3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696642344; x=1697247144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CfjdcVpic+2pvXqlIre7fGrapyzLe77Y81xYJxN9Hs4=;
        b=ZhvimYsjnnWoxwaDuWIWPjI/L32do5JEMeXTrWKYF4pSRjqNWKkAjHG88GbXbmC4UX
         A4rAJfefKST+PfSSHKxaCkUQs6b9jOakiX45jgVRdA9Vr+4K7RcSm3L52zpZLISm49Gq
         SJMnVcH+eOwJrdeYu/sLaZSGK4r/e6t0T/pwd6tJdw2J7BWXHc7VsOcVeVjfiFYTJFKd
         LrV/SwO1kJO5mjPvW+tPOCtTZvxmyLNe8jB3IzwkP7mu5fegCEchXGNRNo3cbNtJ3+nR
         mNF1WmAqTuUxV9K6u22eA0QarSnttt1k6tHgVwnSDsVHSsKBa+bIYFenik04CTCLY6qM
         PclA==
X-Gm-Message-State: AOJu0YxUsBtUybTxjxcH8Y1hio9pqGhbG4tZS1Fg4E8soE+NiDRBRXfs
        LXJA0l0x9mB93NxyFgdQqnKHrd3bPzayPLPUaVs=
X-Google-Smtp-Source: AGHT+IHU7xCfRSFka+bjr6GKsjIeaUWElKWEQgQ00f0vLI1KmCXMcDF0SGlrYUWjyL6lmzJG9YY+wwMmA01uFPJzMyY=
X-Received: by 2002:a05:6512:250c:b0:503:55c:7999 with SMTP id
 be12-20020a056512250c00b00503055c7999mr10591721lfb.34.1696642343383; Fri, 06
 Oct 2023 18:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230909125446.142715-1-sorganov@gmail.com> <20231004214558.210339-1-sorganov@gmail.com>
 <20231004214558.210339-2-sorganov@gmail.com> <xmqq34yog3ux.fsf@gitster.g>
 <CABPp-BFsrt0zS3NHsVAyOSW6vGioe8Z-iN2M3_JNBpP2fWVq9g@mail.gmail.com> <xmqq7cnzaav0.fsf@gitster.g>
In-Reply-To: <xmqq7cnzaav0.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 6 Oct 2023 18:31:00 -0700
Message-ID: <CABPp-BGxVnhnmoajWyqY_gMvQ42W5S6VX5EOXq3PW=GLVQwe0g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] diff-merges: improve --diff-merges documentation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 6, 2023 at 11:01=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> > +--cc::
> >> > +     Produce dense combined diff output for merge commits.
> >> > +     Shortcut for '--diff-merges=3Ddense-combined -p'.
> >>
> >> Good.
> >>
> >> > +--remerge-diff::
> >> > +     Produce diff against re-merge.
> >> > +     Shortcut for '--diff-merges=3Dremerge -p'.
> >> ...
> > Perhaps:
> >
> > Produce remerge-diff output for merge commits, in order to show how
> > conflicts were resolved.
>
> I do not mind it, but then I'd prefer to see ", in order to show
> how" also in the description of "--cc" and "-c" for consistency.

The problem is it's really hard for me to come up with an answer to
that, in part because...

> A succinct way to say what they do may be hard to come by, but I
> think of them showing places that did not have obvious natural
> resolution.

In my opinion, --remerge-diff does this better; wouldn't we want a
rationale where these particular modes shine?  Is that a non-empty
set?  (It may well be, but to me, --cc was never worse than -c while
often being better, and likewise, --remerge-diff is never worse than
--cc while often being better, at least on anything I had thought to
use any of these for.  Maybe there are other usecases for -c and --cc
I'm just not thinking of?)
