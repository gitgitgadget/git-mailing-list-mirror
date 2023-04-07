Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1EFC76196
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 00:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjDGAVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 20:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjDGAVw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 20:21:52 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE99983F2
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 17:21:51 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54601d90118so614569177b3.12
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 17:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680826911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1R7p9WEwp8OOQHwWCYOYV4ka+uA8HfDyxjxa640zsPg=;
        b=X8sG4GAvlRyzce5OG24d1kktxEoLMT8sC4x7jTo6IxGZNuP49ZJzaSwKQwk34ZByKc
         5vaaMeeKfz/hwjy/meF7DBWiIitvJb0qHIQiSucSVLw2k+sviKApv778LaJcUdfOOBHk
         jEDcmfvKYShGm7tytcMSYS0c/my13spvLivjl2veFX9PX1rczk26+2/vuWrvM+3AfUtZ
         kJCZkT8BqjkNojhHRqSxgsQ6Sw7atKX5/xMVMKyHV9Qx0nTY1YvEZvoCFW1pe5IWFkpe
         W4WR+p1nsZJTeC9tqdhodzMnVIRMtZuIktjM62smx73w/dJkZMTk0+sE+YbqYUZn9Kvc
         S3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680826911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1R7p9WEwp8OOQHwWCYOYV4ka+uA8HfDyxjxa640zsPg=;
        b=WF2SYrs5vR0hU4Pp2+xVb62X6dNUIh+O1qAGKgyCziXD6Z1qrwlDPHrhv72kmK0DW/
         8uaMNzOwihIDqyL57AYiHYHYdVtE96A7YqjA3wZ6wPRqHX/a8ymPafyvBEQ5hKloX4cy
         JYGbL7dYJN+mfbxljlQJfnh1khVJ94UA7yhrBrOQ7aAIGx/E1DtSN2pzts6/Mko0pSFI
         2CyZ5NSM2o81vy1FoizRE8nzYb7crOyiO47plWARDhINW6rq69PqSdpVSCdJO02TgeEH
         XkFo58LIXCLK3eSXnCOj7ciJNiFpUQxW3eIrHr14Z3E9K4D8IINoGIwJ0JixP7BWg0+K
         5/Dg==
X-Gm-Message-State: AAQBX9c2/ti670B088OmD7xgAxTMnLcUb+421srbyS+PGo/vtNHt1e6g
        K/CjBr2FNL63XL4YBM6qbtub8Dff1mQXKVu6G3nHecLQ
X-Google-Smtp-Source: AKy350bJXOijLw7mnzyLQWKNVTCmZA+OV/Cs4EP/i3CHEVxohzdz3qTwOHwdeLD0ZwR3ZhGbakFzBxhqTGuLs12OhL0=
X-Received: by 2002:a81:c904:0:b0:534:d71f:14e6 with SMTP id
 o4-20020a81c904000000b00534d71f14e6mr53105ywi.9.1680826910950; Thu, 06 Apr
 2023 17:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230323162235.995645-1-oswald.buddenhagen@gmx.de>
 <7bd63d7e-ad13-d5b8-54ea-ba5f81da0c17@gmx.de> <ZCMRpnS9gzN1Rlbh@ugly>
 <4fa6d2da-4885-09d9-dddb-6f19efda6398@gmx.de> <ZC2Qhi73YKSOJrM2@ugly> <230406.86zg7ls2jx.gmgdl@evledraar.gmail.com>
In-Reply-To: <230406.86zg7ls2jx.gmgdl@evledraar.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 6 Apr 2023 19:21:39 -0500
Message-ID: <CAMP44s13z=hZHzU+EB7qBZnqQcmRGe4aknF=wocOK9uh6NHbcA@mail.gmail.com>
Subject: Re: [RFC PATCH] rebase: implement --rewind
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 6, 2023 at 7:03=E2=80=AFAM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on <avarab@gmail.com> wrote:
> On Wed, Apr 05 2023, Oswald Buddenhagen wrote:

> Right now I do this sort of thing manually, i.e. note the SHA-1's I've
> got so far, --abort at 5/10, then start a rebase for all 10 again, but
> manually replace the SHA-1's for 1-5 with the ones I had already.

Couldn't this be considered a rerebase?

This is what I do most of the time, except I don't even bother saving
and replacing the SHA-1s, rerere reapplies my fixes so it's
straightforward to reach the desired state.

> Which, I suppose I could also do the other way around, i.e. at 5/10 I'd
> --edit-todo, wipe away 6/10, "finish" my rebase, then use "git rebase
> --onto" later when I'm done to transplant the remaining 6-10/10 on the
> 1-5/5 I'm now happy with.

With this approach the reflog wouldn't be an accurate representation
of what happened.

Most of the times I do a rebase I want to see the difference with the
previous state of the branch, so I do `git diff @{1}`, but this won't
work with this frankensteinian rebase which in true is comprised of
multiple subrebases.

> But here's the important bit: Sometimes I'm just wrong about my re-edit
> to 2/10 being the right thing, and it would actually just make things
> worse, as I might discover in my "nested" rebase once I'm at 4/5 or
> whatever.
>
> So being able to do an "--abort" ot that point to go back to the
> "un-nested" 5/10 (*not* "original" 5/10) and proceed from there would be
> nice.

Yes, this is something I often desire.


But I feel you guys are overcomplicating the problem.

Imagine there was a rebase log for each branch, then `git rebase`
could use that information to redo a previous rebase, even if that
rebase was aborted. To restart your current rebase you could do `git
rebase -i --redo 1` (1 being the previous one). If in the middle of
that you decide actually your original approach was better, you just
freely abort, and do `git rebase -i --redo 2`.

Wouldn't that solve all the problems?

The complication comes in trying to do that without the concept of
rebase history.

Cheers.

--=20
Felipe Contreras
