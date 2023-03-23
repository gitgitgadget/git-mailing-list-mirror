Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575ACC74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 20:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCWUiF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 16:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjCWUiE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 16:38:04 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872C430EA
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 13:38:03 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5418d54d77bso414988757b3.12
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 13:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679603883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywMf0UU/wD6CEkxkE3H8MIZu/4fma+CmGKJz+tnnZiI=;
        b=HnBxrNAcAHpHltZFZWD+DSfu0NxC+4Ib58fU1pFbgKFjKvsejy9k4GFwHJxjinqE2M
         V3M+hxPYxt2WgPS1bb7UGXscXla6NdzBsneHLNehbWNyrhFd5ik3ln82CIYOa0/PJRO0
         ea67rw8fVnChlxlKMnWh29ONakRrxRRL58tjlhL7ZHpGc5hvBly5mnppbUz4Q7eJxQfj
         1Hl/H/Uz8RCwN3SuAd/W5IFx6invomNAnud2PtXytKThdlcbyfr8X0rkkXMIaZOxHgJN
         1knucPz2RSg+K17r8axz4p0wcwluzfNcD05bNi94LqyqGJh/oEsKIf/KaSm/RZJ6rBjP
         EiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679603883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywMf0UU/wD6CEkxkE3H8MIZu/4fma+CmGKJz+tnnZiI=;
        b=h8ZaQWLWOBeCpQA9plZfSsvGuKcdDcgzbDIKBy7apFo3rL/VSgfLxx6Hf7ys+yS2g5
         VtcM041BeLu+DWbDFP4OWkdrH5zE3zmK/Q6p1Qiz5055K0IxBbC30GppMrJfFDJllWZv
         Xck1l65pEQwnvvANk7He9SjowKQaaxtpMJE06CeQ37uYb8LnygtiRlxR2vjrBVmSQHWV
         1x8p0CBkMzxl9DR9yzOw2X9wBzytiT/JPZavhU5rnfnBOdfX+k7mVbLiFdtp7Muo4QOW
         /fFsdC7DbgoSUAJSQPzje0TPSAsY6xYyKifhcGK/tKwNR5ClDSRRgEMxWcs+eltUcijF
         RZFg==
X-Gm-Message-State: AAQBX9cvgOsViBczKsOxHhNANiYnICpnodZ7RepZnl9Jbw7cuCy5GGcE
        1PL9b0kdJKDBWAMm0tQkrPBKt6AbrzRexfJfWc8=
X-Google-Smtp-Source: AKy350bHrJ174jJ73uWp9xQ9JSG5mB1DaFzXJhzKsB4ekgrJdPYPplXUiMux1sz8REODzEvDssXXdp1vA7kyN4j1/6g=
X-Received: by 2002:a05:690c:3:b0:541:698b:7bdb with SMTP id
 bc3-20020a05690c000300b00541698b7bdbmr2970692ywb.2.1679603882799; Thu, 23 Mar
 2023 13:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VfTQZ8vFQXZKgbsedG2BOad-pv9fCVkNkX+kFAxhnhhXQ@mail.gmail.com>
 <CAHp75VcZJPysc2-NXTC53XvOwbx-UfPO9SbsBJFb72JGHFyO1A@mail.gmail.com>
 <CAHp75Vc419vikJ184syJHN7rxyaspHzgtT9a_uFA=CT=cdqo-w@mail.gmail.com>
 <20230320170158.GA2614670@coredump.intra.peff.net> <CAHp75VeMoXZdr++6BiOMhOnSqm5rPe+t0bNzpLJsCuGp8NU=wA@mail.gmail.com>
In-Reply-To: <CAHp75VeMoXZdr++6BiOMhOnSqm5rPe+t0bNzpLJsCuGp8NU=wA@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 23 Mar 2023 14:37:51 -0600
Message-ID: <CAMP44s2hEudOpOcyXzZQNYtQSHXOd4NiPBboH=90RHEgF_Lamg@mail.gmail.com>
Subject: Re: git rebase issue
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2023 at 12:11=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Mar 20, 2023 at 7:02=E2=80=AFPM Jeff King <peff@peff.net> wrote:

> > Adding its author to the cc, who may be able to say more. But my
> > understanding is that this was probably fixing a bug (though I don't
> > know all the implications of having a branch checked out in multiple
> > worktrees).
>
> Note, in my case it's "checked" in the BARE repository, which means
> it's actually not.
> This case shouldn't be an impediment or racy AFAIU.

In that case I agree it should work, but when I tried to reproduce the
issue the bare repository is ignored, only worktrees are considered.

Are you sure the branch isn't checked out in other worktree(s)?

--=20
Felipe Contreras
