Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B68C433FE
	for <git@archiver.kernel.org>; Tue, 12 Apr 2022 19:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352626AbiDLTdS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 15:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358719AbiDLTdM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 15:33:12 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B5F4830E
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 12:30:54 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u15so20677822ejf.11
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 12:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=NXujprYKJhSajiubVWqGznCVDOf0bG4SjHF3OkzH+bQ=;
        b=MHrLaZ7AbM8EOxOrgGXWCCc8PKjwpv7QKPAB+7JN67RWtjSoOAcTabqHIoKmTU3izq
         55qts+zJDQEttphey067QHtzhEUU0RsaKDQyGF02XvAVMsgKUMjtsPx7OjaxuKjln8im
         B9JvELCLeOFViZXFFWLY3oU6/NTXc7oyeiIT7+RChVD/bXocx0xSAI2yAL/YBRky9cD/
         rl/JRy/QYR/axD+XUoqDAK5G6JDj6Yt6LWufAroCn9L7EsoPDk2Hn5JZiahL+dT48zyM
         99CbKOHK8IbbxTaLSdOTO1IpyyI0vnM/NWaVM9G7t9sl2tRPCMPiCaC6rYeOGhW0xnQv
         rZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=NXujprYKJhSajiubVWqGznCVDOf0bG4SjHF3OkzH+bQ=;
        b=AH6HyvRVjgzU/NAFi1i+QCv3SNhB+O85s9ulgZGPHEkERc/jkOihzFUDP7KnVZg5SN
         py48hVT4GGlWXRq36IO2jpDSWyNFD3byY1NA3ZLWfl/aQNm+jwxDYCFg66cM1P3xd1L1
         HsGwhydYBL3e3n17yfh2UUXgzp2YL98plVR81mVeIbNyF77DAgutbH9Lfs10VsXN1eh4
         p3DvH1wWI36XryulO03wX3aYxWAWkadFB8n0DkN7axF9+1izwrDXVMt63fO8hCNWTraq
         uBf3zYXITGbQ1GRWsRtWoyCHCZhVG52nuM5losW/NJMC7s424n9IbWCQAi4NLN6dCTt5
         ulrg==
X-Gm-Message-State: AOAM531GuvpS1G2G5vLcKb5+KhQTKpG6iABvc8OKvUy4DmfVW1+O+J/L
        G1awXQ46ywTX8AeA17NN/OR8dTU2TvU=
X-Google-Smtp-Source: ABdhPJyvoTZP/8ejsGm67qec1cta2ppit0aoMEpaU7Qp34V/WPAz3FpiVLEmwAd5GL3uCxnaz1AyuA==
X-Received: by 2002:a17:907:6e19:b0:6e8:9104:246b with SMTP id sd25-20020a1709076e1900b006e89104246bmr11132911ejc.15.1649791852544;
        Tue, 12 Apr 2022 12:30:52 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s5-20020a170906284500b006cc551d6cabsm13487621ejc.63.2022.04.12.12.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 12:30:51 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1neMDz-004ncg-Gm;
        Tue, 12 Apr 2022 21:30:51 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan <git.jonathan.bressat@gmail.com>
Cc:     cogoni.guillaume@gmail.com, Matthieu.Moy@univ-lyon1.fr,
        git@vger.kernel.org, guillaume.cogoni@gmail.com,
        Jonathan <Jonathan.bressat@etu.univ-lyon1.fr>
Subject: Re: [PATCH 0/1] Be nicer to the user on tracked/untracked merge
 conflicts
Date:   Tue, 12 Apr 2022 21:24:34 +0200
References: <CAA0Qn1sBF=PAduCQCXbYkeu4cphw7O+AnvwFNMWijuKYskaT8g@mail.gmail.com>
 <20220412191556.21135-1-Jonathan.bressat@etu.univ-lyon1.fr>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220412191556.21135-1-Jonathan.bressat@etu.univ-lyon1.fr>
Message-ID: <220412.868rsagkus.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 12 2022, Jonathan wrote:

> When doing a merge while there is untracked files with the same name
> as merged files, git refuses to proceed. This patch make git overwrite
> files if their content are the same.
>
> We added a statement to check_ok_to_remove() (unpack-trees.c) 
> with ie_modified() (read-cache.c) to test if the untracked file 
> has the same content as the merged one. It seems to work well 
> with all three o->result, o->dst_index and o->src_index,
> We are not sure of what is the usage of those three, did we used it
> properly?
>
> Our tests need some improvement, for example using test_commit,
> and testing more possibilities, it's not a real patch, just 
> to comfirm if we are on the right track.
>
> The next idea is when it's a fastforward, attempt to merge the
> untracked file and the upstream version (like if the file had
> just been committed, but without introducing an extra commit).
>
> you can see this idea here: 
> https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#Be_nicer_to_the_user_on_tracked.2Funtracked_merge_conflicts

I left some comments on the patch itself, but structurally it wolud be
really nice to make this and similar changes:

 1. Test for current behavior
 2. Change behavior and relevant (new) tests

Rather than the current one-step, that would also communicate that wiki
link (and better) via code.

> Questions:
> The old behaviour was here for technical reasons?
> The new behavior that we introduce here become the default one?
> If the old behavior was important for some people or for some reasons,
> we can set a global variable to switch between the old and the new one.
> And if we define a global variable, should we print a warning to let 
> users know that there is a new behavior when a merge is called and that
> he can switch between the old and new one.

I don't know if we need a config etc., but FWIW my first reaction to
this is that it's a bit iffy/fragile, i.e. before this we'd basically
error out and say "fix your index/working tree".

But now just because the newly merged content happens to be identical
we'll silently merge it over that "staged" content?

Anyway, I can also see how that would be useful for some people.

I've personally been annoyed by a subset of this behavior in the past, I
can't remember if it's with merge or rebase that we'll refuse to do
anything because we have a locally modified/staged (can't remember) file
"X", even though "X" won't be touched at all if the merge/rebase
happens.

But I haven't wanted git to have quite this level of DWYM behavior in
this area, just my 0.02.

> For some reason, test_commit make the merge not working like if it's the
> old behaviour of merge, I dont understand why ?

Ah, I left some comments on "why not test_commit"...

Do you have an example of such a non-working case? I'm not sure why it
wouldn't work.
