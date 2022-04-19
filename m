Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB849C433F5
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 15:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353811AbiDSP2T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 11:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353806AbiDSP1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 11:27:25 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751613B006
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 08:24:33 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id v133so12430131vsv.7
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 08:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aV2lG3+65TQRRxFa9wlPpbpvjlwBTJuyn2WWLRfsP7g=;
        b=QvbT3N0t7H2z2DAUOrD/46aXLuEIDXpnca4aj0BOMwdtSbxNAu8n7SmidF0MWX0ew0
         2SeP2ylgYxEv3AmF5tYJWC75A21oklZCwN2i5iBl2rAkdH9iDC3t5fHQ80ic9SCmBq5f
         lL50lL0cc3hWjO8NYuIC3CWkhidln3JCBebDCgLkg4fUtMLK3IZ+/QOsPSDRE8jvgb1k
         XggRpUxs5atAC5DUQWFPMEmj2lSwOCvrHoPo/OvL+/coMpjBB9+/dCeNASClensT+jOo
         VhfmUu4y8uupl8IluUVG74bPFA0x3rOi/xsYLPytT79vgh7IxcVUphtIYSzwrrM7GcMA
         IkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aV2lG3+65TQRRxFa9wlPpbpvjlwBTJuyn2WWLRfsP7g=;
        b=oo+kiJEWQt20pPtt09jRTCiGLPExYcBOxcIez5ULbU2G/tmBnQ35Rw5a4u2LQ/DKwd
         rqkxWGyHWEEHWTKJYjN/uWfXSAYA0zICcSxmk3ORpceC+DxkrPuTd95YWR0Ufv+P62Xd
         xsJSLq+wxh6ufkRC7AgNrdttMxDeCJVVOLIxxLholDsd1Dt9dr9DDHg9V1BQ02JHW6/O
         G8PZWfK+I8Intnz+ySaSpEHVbkkBs82rMc4ZZysG6OumjrsFWz2p85wCCEuCbLwXDTBL
         7t70YBeC3ipRwl93bmofUrns3ekjpS90Bq2jLXr0Ob6F1UpwnHcszBk5JMz5che33uG2
         Gc5g==
X-Gm-Message-State: AOAM533w6lUBAJgihrB3bE71sVbPZGjBZ3+S7OVMMBbVy/KLnYnemaZg
        fbRQFTNOhnX2yHrA/LnOc9gbTspRarMfqa/xbHCafZZy9WU=
X-Google-Smtp-Source: ABdhPJwQ4NH4ddRWBGiFK5IrF9kALpj/RrUgIolO4HLCVCiXWA3xfr99scyxDi4+rBTls65Pz4UrLHrzU45dZCf7p6s=
X-Received: by 2002:a67:f842:0:b0:32a:492e:332e with SMTP id
 b2-20020a67f842000000b0032a492e332emr4413714vsp.47.1650381872570; Tue, 19 Apr
 2022 08:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpojjs4sjKdN6DAJFSwERdjq9XQgi35CcqkXu7HijadHa1Q@mail.gmail.com>
 <87h76qwd8a.fsf@osv.gnss.ru>
In-Reply-To: <87h76qwd8a.fsf@osv.gnss.ru>
From:   Martin von Zweigbergk <martinvonz@gmail.com>
Date:   Tue, 19 Apr 2022 08:24:21 -0700
Message-ID: <CANiSa6jAjbPRii8GYYLzU88K9P-TG5GGBJGY-H1CwmPkb+yU-w@mail.gmail.com>
Subject: Re: Current state / standard advice for rebasing merges without
 information loss/re-entry?
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Tao Klerks <tao@klerks.biz>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 19, 2022 at 5:25 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> Tao Klerks <tao@klerks.biz> writes:
>
> > Finally, Martin von Zweigbergk mentions his git-like VCS [5] which
> > stores conflict data in some kinds of commit as part of a general
> > "working state is always committable and auto-committed"
> > state-management strategy; I may be misunderstanding something, but I
> > *think* the resulting conflict-resolution information ends up being
> > reusable in a manner theoretically equivalent to the strategy
> > described by Buga as referenced above.
>
> I still think that Git got it right by *not* storing things like that
> (e.g., renaming paths / moving contents),

My VCS doesn't store that either. Maybe you're thinking of Darcs or
Pijul? [1] explains what my VCS stores. FYI, [2] explains other
benefits of first-class conflicts; being able to rebase merge commits
is much less important than the other benefits, IMO (but it's still
important).

> so I'd still propose to
> *rebase* merge *commits* as *content*, without any additional info being
> used, if at all possible.

Rebasing is about applying changes from some commit onto some other
commit, as I'm sure you know. What Elijah and I are proposing is to
consider the changes in the commit to be relative to the auto-merged
parents (regardless of the number of parents - auto-merging a single
parent commit just yields that commit), although I don't think Elijah
phrased it that way.

> As I wrote in the aforementioned discussion,
> we should not confuse "merge-the-process" and "merge-the-result". It's
> the latter, the commit, that should be rebased no matter what
> particular process has been used to get to this commit, in accordance
> with general Git philosophy.
>
> Besides, merge algorithms themselves are subjects to change, so a merge
> performed 2 years ago might end-up being rather different when attempted
> with a new algorithm today, rendering information stored from an old
> algorithm useless.

I agree with all of that.

[1] https://github.com/martinvonz/jj/blob/main/docs/technical/conflicts.md
[2] https://github.com/martinvonz/jj/blob/main/docs/conflicts.md
