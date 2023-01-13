Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8DEC54EBD
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 04:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjAMEoP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 23:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjAMEoM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 23:44:12 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4D5B7FB
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 20:44:11 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id b3so31463269lfv.2
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 20:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AFB96E4JWhWPUabwHB3hbHWeXUKTbhnGQOImxgxYm9k=;
        b=alJsCuRW8of4A7zNEhxSj/3EAWv70tDEqEe9WsT/QTbudNG3zxhdCYSor0Y1COL78t
         DctdjVZojlXksxEzymGUEVpC6gwpTo9DUSzIlOzqY9m35dVDQG9xKF9+tWjiPg9VADzK
         nsVgGlkHBZN7P6QEYsgzcncxmPVmVpEu4mruC2BUztiPynPBTTLlm2lSFCdTyxlCq7vM
         BNFCtVQ6blwrhAw/0Gi2q8zSGyM7RMPT8cQgdr4JYZcV1UydONfNwxWknaySNmcN/5UX
         hOgcVSLF2tp0eJr7YFo5gIysZT7BfxJVGhIArF1uDpJcg5DpdoZtFwR5eds0joZCuAz7
         +XEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFB96E4JWhWPUabwHB3hbHWeXUKTbhnGQOImxgxYm9k=;
        b=hVqoLSCATKUgULceBW3r4SajDJg7J7wE/ekuXgIQWutaqsWWk1SekQRsavtcnhph3d
         oWw8atfPCeKJqEVPTdZBBOiSsB4UaI6ravhqeGppEPLc/l+sKcn4dT9clxPZdpMusZXv
         BN+AdxfFaG2CTVp6/wLC2q3xLt/ofW/drVjct4gGaTswy33V1Ych6YKyLPh/Ywgs3tNt
         1PxE+IAdMwnjJe4jj0gTML60K+wrZHP1NDI4IPkAzbPCFrKKusP8MuTItfN68V4uuisH
         OCD/xiwYVtQu2NZEL3nIugvw5qvv0O4Fvu9XQDWGue17IVOO6L3/shP6Ryief5zkJVck
         ye+Q==
X-Gm-Message-State: AFqh2koCtAQQU4hgfUVtrzBR+/eLlfDQLXiX8mXQjnlmjTN79UEkwQl5
        TYsg2iLfsHBckspEknEUHMYY8iZkK2xjxjHIuJP2RKIQ6gU=
X-Google-Smtp-Source: AMrXdXsf6OEiQVaIXnyAmd6HeYxvyE3iMM/DnVqI8Mef47q3tP5bCLQHoEG0kVzHKUcOPI4RjSyRwiDq9IwOacYVop8=
X-Received: by 2002:a05:6512:368c:b0:4cb:d46:94b7 with SMTP id
 d12-20020a056512368c00b004cb0d4694b7mr2564666lfs.405.1673585050053; Thu, 12
 Jan 2023 20:44:10 -0800 (PST)
MIME-Version: 1.0
References: <pull.1458.git.1673451741587.gitgitgadget@gmail.com>
 <CABPp-BGsD=6PiJtnsuYPsiZJ1rm2X8yTeu-YeP4q5uu5UDw2og@mail.gmail.com> <xmqqwn5rseyd.fsf@gitster.g>
In-Reply-To: <xmqqwn5rseyd.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 12 Jan 2023 20:43:57 -0800
Message-ID: <CABPp-BEvK7MFws9=XMfghjo8PgHL6nkiFKmYBiG+218809T2Pw@mail.gmail.com>
Subject: Re: [PATCH] ls-files: add %(skipworktree) atom to format option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 12, 2023 at 11:58 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Given my above comments, I personally don't buy this as justification
> > for adding a new way of reporting on the skip-worktree bit.  It may
> > still make sense to add this feature or something like it, but I
> > personally think it deserves separate justification from "`ls-files
> > -t` is semi-deprecated".
> > ...
> > To be honest, I don't yet see any compelling reason to use this new
> > option.  Even if this patch is accepted, I'd just continue using "git
> > ls-files -t" (both directly and in scripts) in preference to this.
> > However, you have inspired me to try to fix up the ls-files
> > documentation and remove the "semi-deprecated" label for the -t
> > option.
>
> Thanks.  I think that would be the better way forward between the
> two (i.e. adding this one-shot new feature vs resurrecting -t).

Submitted over here:
https://lore.kernel.org/git/pull.1463.git.1673584914.gitgitgadget@gmail.com/
