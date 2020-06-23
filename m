Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3363C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 16:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F61A20781
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 16:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUJ0kVRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732526AbgFWQ7N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgFWQ7N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 12:59:13 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA172C061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 09:59:12 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id rk21so5978823ejb.2
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 09:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=3QX9mo+70ZMHRnLXmed74ugrmrjyOxpieeTyq9qOLE4=;
        b=eUJ0kVRo3GudLt8bMo3TZYSg5g+NYEbXFnVhPW4JcojWSpiS8B3VrwIpXfUufQ2wdg
         vRBgz8NjnafNuZHSEGZh+DSVQqtt1HBx3a/yHm4FkaVObGfuAPTv48gsr6dbW7WWk/ty
         x/dh1oxwB/oIw0wQHs/ffqQUks3knxTGPtknGGY0t6W2lH1M2iAYaVbWB2OesEdNcTVE
         aHtxRmYFS0Czi7m6y/yx04wrrSdHjjdLeOzKucyONK8jh3oc3io6ODJ4foGwjgSs0/6i
         Uo8w3DuEi0TpiayKFtN30Y1r0dpQ5C2qBCHUuRhV+WBbWu0e5nV0gTEDjtf1Qg4NLqBz
         UvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=3QX9mo+70ZMHRnLXmed74ugrmrjyOxpieeTyq9qOLE4=;
        b=lbsuTzhloxKPcN2aBJ/KSWQgss/MkbrO+L2FiM94kuLyEmHD8xGV9tITmCInkytxXO
         sAiDTt1G6p5svkSnXY82BjzS1meFFhJj1Q7XgvKPN6w7W0HI3fG0bbBkzIRkxWUVKLrm
         xdIGOv/IeFD5uW40HJ75aFordkwuHIughsGwZlGz+ISUrqhjHKK/YCPfUmhYoeaXJH34
         dVT2PWINuhsqN3gEcyYq3Q0Kqe5ldfFMjqFybVJ/t5iDbJpduvuMbaUtOA3PjLpdN+J4
         9lok1XhKGrGDAGqHnGNFjxGtpm7im/eg917/OHao4rmv3Ci4xzILWC8ZeRVcctX0X8k2
         GINA==
X-Gm-Message-State: AOAM531OGmfPjyC6tUVprXk/ETS1dqwN0jsKUeyiNpeBVD2W2vgDPBEx
        L2gRHhkq6li0+xeKkKzGU9ftiDtAdWnL4hQei98YbV8m1IM=
X-Google-Smtp-Source: ABdhPJyuFPQcUR49Q2EwwotFoad4UUNnd4qhq157JTnl1tA6uozycF92oW1kzqLQIRewfvG2QVkDWWhZndNbcrFm3Rc=
X-Received: by 2002:a17:906:b0a:: with SMTP id u10mr22218212ejg.211.1592931550705;
 Tue, 23 Jun 2020 09:59:10 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 23 Jun 2020 18:58:59 +0200
Message-ID: <CAP8UFD1KfEps4hS8eadBK-E4e5WyWSh93XivRabZAVhiCuQimQ@mail.gmail.com>
Subject: [ANNOUNCE] Regarding Git and Branch Naming
To:     git <git@vger.kernel.org>
Cc:     Git at SFC <git@sfconservancy.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We at Git PLC [*1*] (who represents the project to our umbrella
organization, Software Freedom Conservancy) drafted a statement on
the subject matter with the Conservancy and it now is posted at the
conservancy's site at [*2*].  A copy of it is attached at the end of
this message.

It is important that discussions and decisions about what changes we
are going to make to the code happen on this list, just like any
other changes.

To that end, the patch series posted by Johannes Schindelin earlier
this month [*3*] to allow users to give a name of their choice to
the first branch "git init" creates and to configure the default for
that purpose seems like an obviously good starting point.  Hopefully
the series can be polished and included in the 2.28 release.

But it is just a starting point.  We need to keep the discussion
moving and reach a consensus on remaining issues, including

 - whether to change the default used as the name of the first
   branch created in a new repository away from 'master'?

 - if we were to change it, what should we change it to?

There may be more things that need to be decided.  Please be
respectful to each other and keep the discussion constructive
in the coming weeks.

Thanks.

[Footnotes]

*1* The current members of Git PLC are:

  - =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
  - Christian Couder <christian.couder@gmail.com>
  - Jeff King <peff@peff.net>
  - Junio C Hamano <gitster@pobox.com>

*2* https://sfconservancy.org/news/2020/jun/23/gitbranchname/

*3* https://lore.kernel.org/git/pull.656.git.1591823971.gitgitgadget@gmail.=
com/

-- >8 --

Existing versions of Git are capable of working with any branch name;
there's nothing special about =E2=80=98master=E2=80=99 except that it has h=
istorically
been the name used for the first branch when creating a new repository
from scratch (with the git init command). Thus many projects use it to
represent the primary line of development. We support and encourage
projects to switch to branch names that are meaningful and inclusive,
and we'll be adding features to Git to make it even easier to use a
different default for new projects.

As a first step, Git will add a mechanism to allow users to specify the
default used as the name of the first branch when creating a new
repository. Also, consistent with its project governance, Git has
undertaken a community process to explore changing the name of the
first branch created automatically for new repositories away from
'master'. That change is currently being discussed on our mailing list.
As always, changes in Git's core will minimize disruption for Git's
users and will include appropriate deprecation periods.

Meanwhile, Git as a project remains engaged in encouraging
participation of underrepresented groups in the development of Git
itself. Git continues their participation, which began four years ago,
in Conservancy's Outreachy initiative. Conservancy also continues to
explore and support other initiatives that can also assist in this
area.
