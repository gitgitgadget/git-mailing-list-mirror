Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94293C77B72
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 02:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjDRCAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 22:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjDRCAj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 22:00:39 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05ABA8
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 19:00:36 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6a5f6349ec3so69716a34.0
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 19:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681783236; x=1684375236;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ij0U2ZfWINCeR3bfozkjdBxQscw2nU7j27t7X5JmIao=;
        b=EbjLScJCmiDMVht9YFR1OEn9Jart0y6NJ07ej8XW4wrtYRActkzcGdKcWyFwsYndZc
         Tgp7duPBzmEHuPSEhKsOfFmMaPhDWyPaQgfWmDyMIJL7g6aWG8l/lmR5GXr1LdRHfSm6
         mHpqyxf8Re3R1zlDPxsgvdi8MkwonB4QetelirARpZ7j4TuZ47H6u2M2ilR45lVtsNQQ
         PhUjOIJ76ufou5EILz9EbuBP/dxriHeEHFUFLgeyTzHA2Pfs6E8SQZP/NiG/NaF5qvHr
         549V7dljrr+n1fqxY6x73hbWdn1EuOliJTYB0gkjgXlzXZ25kSX11IwN8H03vS9CFGbv
         zTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681783236; x=1684375236;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ij0U2ZfWINCeR3bfozkjdBxQscw2nU7j27t7X5JmIao=;
        b=K55G2OvbcVGmtayB/UKxRSF+0UvG1ThVGPi+TWd6/P5SCwnCCHB7YO4HaSlPWC1Dzi
         vHx21HTiNfCogE9diu6+n3HLLNEYiwrABvhIiuIwx1IC+cJjU2Uq7uORX2h5yvfeY7TJ
         9PnanJaJyFoEziYhewXrBreRjn+eUMGsa8zg/L1DvrTRJJIHwbXBeMES3E2ceRKFHjzU
         oPqO5vF7LmOR9bKy03ov3Q6PJ4HextK6joFmXaCpK/ZsYVTMCSYYsZpsaCvLJECXtH1q
         IzCNZms7raWODMsNuYpuilQ14/7NsvE0zqKUwCDtYrSf0fU0R/zVn6W2iRHws5J2Wz21
         xGAQ==
X-Gm-Message-State: AAQBX9fNlqCLYG2JQy1scRvZpuxzml2mXR73cE7gAq+ZCox+aGhaeo4g
        bBEbzAKIa/bUnVdHcOs5PCM=
X-Google-Smtp-Source: AKy350b4ZVpxaZukT4ZV2MxNN4CgKpCyKi4ael3xNnioKxNcOUNhPlNKM8AeFxpsv1HpfBvC5dHIYA==
X-Received: by 2002:a9d:7ad0:0:b0:6a4:2dfa:360c with SMTP id m16-20020a9d7ad0000000b006a42dfa360cmr255386otn.1.1681783235850;
        Mon, 17 Apr 2023 19:00:35 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id f16-20020a9d5f10000000b0069f0a85fa36sm5039998oti.57.2023.04.17.19.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 19:00:35 -0700 (PDT)
Date:   Mon, 17 Apr 2023 20:00:34 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Stefan Haller <lists@haller-berlin.de>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Message-ID: <643df9c257293_19bb0294b7@chronos.notmuch>
In-Reply-To: <6a8b92d8-5b86-9cf3-3619-4c8bedfa2d47@haller-berlin.de>
References: <adb7f680-5bfa-6fa5-6d8a-61323fee7f53@haller-berlin.de>
 <d3895d9b-b45a-449d-a5e6-b8b8c5e6c4b8@app.fastmail.com>
 <6a8b92d8-5b86-9cf3-3619-4c8bedfa2d47@haller-berlin.de>
Subject: Re: Should --update-refs exclude refs pointing to the current HEAD?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Haller wrote:
> On 17.04.23 10:34, Kristoffer Haugsbakk wrote:
> > On Mon, Apr 17, 2023, at 10:21, Stefan Haller wrote:
> >> 2. I have a topic branch, and I want to make a copy of it to make so=
me
> >> heavy history rewriting experiments. Again, my interactive rebases w=
ould
> >> always rebase both branches in the same way, not what I want. In thi=
s
> >> case I could work around it by doing the experiments on the original=

> >> branch, creating a tag beforehand that I could reset back to if the
> >> experiments fail. But maybe I do want to keep both branches around f=
or a
> >> while for some reason.
> > =

> > I would use a lightweight tag, too, since this option doesn=E2=80=99t=
 touch tags.[1]
> > =

> > Why do you want to keep both branches around? =

> =

> Several reasons:
> =

> Maybe the original branch was pushed already, and I'm collaborating on
> it with a coworker. At the same time, I want to run my rebase experimen=
t
> in parallel on a copy.
> =

> Maybe I want to create github PRs for both of them, in order to run CI
> on them, or get feedback for both of them from my coworkers.
> =

> Also, it just seems to be the most natural workflow for many people. I
> have seen my coworkers do this a lot without thinking much whether ther=
e
> would be a better way.

I also do this, however, I often create a new branch to point to the prev=
ious
one (`git branch foo-1`). I know I can refer to it with `foo@{1}`, but th=
en I
have to keep track if I rebase more than once, or do any other reflog
operation.

If I've sent the series for review with my tool `git send-series`, then I=
 don't
have to worry about that because I have refs for every version I sent.

A notion of branch versions really comes in handy.

Cheers.

-- =

Felipe Contreras=
