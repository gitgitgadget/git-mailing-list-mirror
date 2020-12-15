Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B499C4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 19:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3920B22ADC
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 19:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731917AbgLOTLi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 14:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbgLOTLV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 14:11:21 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E93C0617A7
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 11:10:41 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id y2so13871121pfr.12
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 11:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc:content-transfer-encoding;
        bh=7IWLeMhpMs85ULJJuM6uBpiluO4I0dyYtG+PZdYlkC4=;
        b=TKHJdsPRnCsPjTJrVhRd0PCv4CI0rNFJzq3kAn/774rS1lerq4kRW+1LC6eyn2Gxcb
         jK4R102JWC1iVfeTL/261+0zVs0CdrLivVK/fX2tDoECl6aL+qt9ZkqrNLzuRJ6Perf3
         qAPQ3zrX1W5vXc2Iix+lBhKiuFEdsqjBtTP3sATO6zHZMz5XIuJsLBvuUn/oclBi9oW4
         beWR9I/iL0lq0u9QOxOPmeNSFn7MWkR3a2EH5K8be0NeE2ZdXjuUEAZU05dAhX0GZTyW
         nt08uj1phGGny33Bo7gIH6nUAJyc0vUNCXSNAPpDFfp/xjpNEAWF6SSGUKEBstLN1fMJ
         IbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=7IWLeMhpMs85ULJJuM6uBpiluO4I0dyYtG+PZdYlkC4=;
        b=USPjXSv402LpdUufJmYEovhqtippp6kSsEfMMvWQ0JRY4VL0vD/DboVlJvi26Dsbhb
         23K72CQS7bhrOZy2/rA6No6bbq0A61V8TR9J5BRDQdVu7+DAt8PkcCtMVuWvOkyYAVCu
         DDdZ4yB90oRcwhpP3jY8/iApe6lful/WnhA6oLrdooK4ANE64XGqJvtTEsRmMo6UlrWP
         mkbg4EQ5D1il0BlHPly+/rAVZBGW99wRn0vc4CHfPHAdHyeO0Afh79z1Sw37NIYWMYvm
         0AUtwn5t6f+/nkECJqyUl+/mNENHWyEU15NgOoMWPO3MzMed1dX/ADpsboNcPcA9NcPU
         fp7A==
X-Gm-Message-State: AOAM532e8Vmvtgi0vgc+psp7gbdS63a+Zy74qp9R1BzCwJKwXY77+C+r
        IA6KMTHhc1ucUc/r7EokUogF1sdbtey2/8MdUH66
X-Google-Smtp-Source: ABdhPJzZmcZRg2QHX2UqrWDBYLWcG/ia0G7lzcoRXVywaawatmIErEg/9SdY4eHZerbsOHLtM8KJZULaV3oXhbrWk9AT
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:ead1:: with SMTP id
 ev17mr313460pjb.51.1608059440667; Tue, 15 Dec 2020 11:10:40 -0800 (PST)
Date:   Tue, 15 Dec 2020 11:10:35 -0800
In-Reply-To: <X9gREadU/cxBYREY@coredump.intra.peff.net>
Message-Id: <20201215191035.513219-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <X9gREadU/cxBYREY@coredump.intra.peff.net>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: Re: [PATCH] clone: in protocol v2, use remote's default branch
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Subject: Re: [PATCH] clone: in protocol v2, use remote's default branch
> >=20
> > When cloning an empty repository, a default branch is created. However,
> > it is named after the locally configured init.defaultBranch, not the
> > default branch of the remote repository.
>=20
> Your subject line puzzled me at first, because I thought we already did
> that. And indeed we do, but this is about adding the unborn case. I
> think this contributed to =C3=86var's confusion.
>=20
> Maybe:
>=20
>   Subject: clone: respect unborn remote HEAD
>=20
>   When cloning, we choose the default branch based on the remote HEAD.
>   But if there is no remote HEAD, we'll fall back to using our local
>   init.defaultBranch. Traditionally this hasn't been a big deal, because
>   everybody used "master" as the default. But these days it is likely to
>   cause confusion if the server and client implementations choose
>   different values (e.g., if the remote started with "main", we may
>   choose "master" locally, create commits there, and then the user is
>   surprised when they push to "master" and not "main").
>=20
>   To solve this...
>=20
> makes the current state more clear, as well as motivating why we care.
>=20
> It might also be worth breaking the patch up a bit. E.g., implement the
> capability in upload-pack, then infrastructure for the client to use the
> capability and surface the info to transport callers, and then finally
> surface it to in the program logic of ls-refs, then clone, etc.
>=20
> Not strictly necessary, but it make it easier to see what is being
> changed at each step.

All this sounds good.

> > Currently, symrefs that have unborn targets (such as in this case) are
> > not communicated by the protocol. Teach Git to advertise and support th=
e
> > "unborn" feature in "ls-refs" (guarded by the lsrefs.unborn config).
> > This feature indicates that "ls-refs" supports the "unborn" argument;
> > when it is specified, "ls-refs" will send the HEAD symref with the name
> > of its unborn target.
>=20
> It's probably also worth mentioning that v0 won't get any support here,
> and why.

OK - thanks for your comments. I'll send out an updated version soon.
