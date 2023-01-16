Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDEFC46467
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 02:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjAPCuh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 21:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjAPCua (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 21:50:30 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422B07AAC
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 18:50:27 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id d13so5001837qkk.12
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 18:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRyLoK19On8QOJ2EemnoKaorp70O/V2VBykMPFtpE9o=;
        b=oomKjkGnJWmJ+fbt3v+t6UIy46MO1wOFQvlH4ykBQPPvFzbHscHgkSsbXxJO1BhvN/
         dDZ1jv99W16jZhf2Q9NKEWZQHOUP6A1KupZiwaMhP0orUODA6Axht11cR1Y97+SXYr6i
         ChIOvOaaVb1fTnNBwfDXdh6ZzODiE5uiltIkTe9K89ZvRW1CyPDtDGcmHr6AWmEUaQM3
         MglzByqvVcGp+wqUz38AGJT1N3GAbTIEW9WcTxJ6V+RAZ8GewOZxITNouKbwzNREhsNl
         gzrvXoMFXOdEn8k8VVC0k1Q58CDLD3RAAAe8Q/oV12KoFow+IcSGecsg9XWocUUbNCZC
         F4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRyLoK19On8QOJ2EemnoKaorp70O/V2VBykMPFtpE9o=;
        b=Smh1m3BY1rf43/6TzX36CMZ8jB1nWcIGwN9MKRsqLjSGaQVi20qxIt/wkT2a54xPLV
         gphlAM/o5O2asnXhwTOT7VEdm0LyAT081i76wAyN0mnSij458V4OXGv1SaYuw5Ov3Shb
         Rno8rYmOYUe8uldkIXZ8ub61Lras/5QjmGiWn0hFyB+i+4mwOeDBpc6SSj4f+ohP/gVh
         h+pzvSHUoppuoeclBXWfLFkDnAul1uTes1g8Ej9RCYx1tIcH40OiQ+ac/FAlVta9LVeS
         /MG7oa3WMsQPBVhnyQ+dBdIoy7vEW0bilZ9ukRaSa5EeXZhtXhE6Io3/tyCZfiKxWXQ/
         Z/oA==
X-Gm-Message-State: AFqh2kpVaV1gSveBYL3+39AR1FTVfMYEt7ZankuSC/yXmNww9MUr9XJc
        WewUOeBMsl5ITCYJGK+mUBCkL7B84olDSO7Smdc=
X-Google-Smtp-Source: AMrXdXukMKJUD186YvOFZ7QlcjPDnY7F59KSp5b5mLk1VhvSZSFg7Qq5uaroV/YIGmllLFO004IXTkPZ/169SJTekks=
X-Received: by 2002:a05:620a:278c:b0:702:15b4:c8e3 with SMTP id
 g12-20020a05620a278c00b0070215b4c8e3mr5172779qkp.344.1673837426252; Sun, 15
 Jan 2023 18:50:26 -0800 (PST)
MIME-Version: 1.0
References: <CAA3Q-aaO=vcZd9VLFr8UP-g06be80eUWN_GjygfyGkYmrLx9yQ@mail.gmail.com>
 <20230116001144.dt76xk6hkwn45klz@Carlos-MacBook-Pro-2.local>
In-Reply-To: <20230116001144.dt76xk6hkwn45klz@Carlos-MacBook-Pro-2.local>
From:   Jinwook Jeong <vustthat@gmail.com>
Date:   Mon, 16 Jan 2023 11:50:10 +0900
Message-ID: <CAA3Q-aazO1ko4uBSUs5W_rjn8AP_=fc2jAYrMsaeMtpnm54ExA@mail.gmail.com>
Subject: Re: bugreport: "git checkout -B" allows checking out one branch
 across multiple worktrees
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 16, 2023 at 9:11 AM Carlo Marcelo Arenas Bel=C3=B3n
<carenas@gmail.com> wrote:
>
> On Sat, Jan 14, 2023 at 06:45:34PM +0900, Jinwook Jeong wrote:
> > What did you do before the bug happened? (Steps to reproduce your issue=
)
> >
> > 1. `cd` into any git repo that has at least one commit.
> > 2. Identify the current branch, say main
> > 3. $ git branch foo # a new branch
> > 4. $ git worktree add ../new_worktree foo
> > 5. $ cd ../new_worktree
> > 6. $ git checkout -B master HEAD
>
> Was your intention to get this worktree's content back to what is in
> master's HEAD?, then the command should had been

Sorry for confusion. These steps didn't reflect my real use case but
rather are for demonstration.

I encountered this issue by chance, not knowing how that command would
work under multiple worktrees.
