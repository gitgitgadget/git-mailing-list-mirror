Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01255C001DE
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 19:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbjHKTFI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 15:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbjHKTFH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 15:05:07 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FED30F0
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 12:05:06 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe94dde7d7so1995115e87.3
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 12:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691780704; x=1692385504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7riPNC9V5WQScm+RP71dQ/betuvC1kPkodgvAaGktU=;
        b=TbW47LsJOpp6qW9VStbcCBbMHS9PwkYRJJMWzLE7JurZpt9GJy4n44b5n0nYDfItI0
         nNfrgreCOu+ANnYvQNU3nY8aK1X3Js4c59/m0QEjdwqb10G/Yh7qKbZtPYSIYV4wXnku
         w/1L3xebpXn3i6ZC5xUj0uPo7EjQ89rzC0cQfatCRyMkH9UAXwRRJju1Z5beiH2alvd+
         ZDo/6uZXJETI0D+4L3mJJU0Yc9TiwjcJUrIxzVEcUtWzpXwWwUqPhqSVtF+J5WIOt9jx
         6i4/5eT7a+cXGChVZmOSyK4RiO+RuorHFdhU27mGROhZdFvoOH5AOLkL2+WDG97j0Gbq
         GVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691780704; x=1692385504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u7riPNC9V5WQScm+RP71dQ/betuvC1kPkodgvAaGktU=;
        b=ee821GXAwmQowi16410YzSPpWMy6lEkRBrdQFB0g0emz+cUfKx+FR1hWqj/lUrYtAP
         A4ablC5i5rmiTTq7D+ojgsrpjJLSIpz1BcFwRDV5tjTaHgOzoN6nywJiHQ9UwSOMW7xW
         xgu7ZUzkuKPCWp74YXRwsJrAijGZaTdTLUMBBWLjhTkiNkMR1kQ0AOjNYobsZDJarpXU
         oAEFCQybEsTTPdVHHJAFz0rJZG4zeskPk/qWXpBWeyzkrWXUd4YJc95kC1XRvVQEEGnx
         LTih+E0WtcEDi8ACVefvDoNBa2FdBL423ZN+1ZtEo3p8xKyoyCsP4Lv+S4wUcI1BEprd
         eDBg==
X-Gm-Message-State: AOJu0Ywi0mL83t1KAdmUmVdYzd2Jc2az3gce4+k11M65uJEY5uhPL7Xr
        fP7AMQE7EmoktVO6aEsP/FQH+D3Q1EMKwS878l4Fz/BL
X-Google-Smtp-Source: AGHT+IEnZkLBwue9LTDnno2oqv3EvVafxjWkUiP66Exn70ieh5Sg8sFLd3pOTlQR1Vi0bmOuJ9gsz0IFgquosNEBmdo=
X-Received: by 2002:a05:6512:4004:b0:4fd:fef7:95a1 with SMTP id
 br4-20020a056512400400b004fdfef795a1mr2390585lfb.53.1691780704226; Fri, 11
 Aug 2023 12:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230715103758.3862-1-andy.koppe@gmail.com> <20230715160730.4046-1-andy.koppe@gmail.com>
 <kl6l351j22dr.fsf@chooglen-macbookpro.roam.corp.google.com> <783011d8-53ea-15cb-a9c7-6cb0c15bd5aa@gmail.com>
In-Reply-To: <783011d8-53ea-15cb-a9c7-6cb0c15bd5aa@gmail.com>
From:   Andy Koppe <andy.koppe@gmail.com>
Date:   Fri, 11 Aug 2023 20:04:51 +0100
Message-ID: <CAHWeT-Zo3nTTGBfJPwNhg50KfLn-GAdpU8WZ96d7fT9_axAQXg@mail.gmail.com>
Subject: Re: [PATCH v2] pretty: add %(decorate[:<options>]) format
To:     phillip.wood@dunelm.org.uk
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 23 Jul 2023 at 17:26, Phillip Wood  wrote:
>
> On 19/07/2023 19:16, Glen Choo wrote:
> >>      case 'D':
> >> -            format_decorations_extended(sb, commit, c->auto_color, ""=
, ", ", "");
> >> +            format_decorations(sb, commit, c->auto_color,
> >> +                               &(struct decoration_options){"", ""});
> >
> > I don't remember if C99 lets you name .prefix and .suffix here, but if
> > so, it would be good to name them. Otherwise it's easy to get the order
> > wrong, e.g. if someone reorders the fields in struct decoration_options=
.
>
> That's a good suggestion. I think this would be the first use of a
> compound literal in the code base so it would be helpful to mention that
> in the commit message.

I've taken the suggestion, but then forgot to mention it in the commit
message. Will do in the next round.

> We've been depending on C99 for a while now so I'd support adding this
> compound literal as a test balloon for compiler support. =C3=86var report=
ed a
> while back that they are supported by IBM xlc, Oracle SunCC and HP/UX's
> aCC[1] and back then I looked at NonStop which seemed to offer support
> with the right compiler flag.

There are a number of uses of designated initializers already, so
hopefully compound literals aren't too much of an extra challenge.

Thanks,
Andy
