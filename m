Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AB3C32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 06:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiIZG7w (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 02:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbiIZG7r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 02:59:47 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33170D135
        for <git@vger.kernel.org>; Sun, 25 Sep 2022 23:59:46 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id a80so5758010pfa.4
        for <git@vger.kernel.org>; Sun, 25 Sep 2022 23:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=XS23GWNF6oSUuKNHooHaOoZvjZmFqwP7KU5aIHJT+5A=;
        b=N3xumg+v+MDfLmqwJQDyw852919Qxupx6xIKexv4MdOhfVTtLKbKBmu9MnNW5sfENH
         kmi3MIDsRlCUuKIR9b/NS0SCZM3MJB4XsTfxdJJq9kFx9h3YgB1bqquLUPvdGjSgHoPQ
         M6VzbkE/413Qu1BTTVuIw09+6vRDXHujkhpWDM0hOMFH7672apWXqUDo+42l6bUjSrJB
         spU7IOG0WvUJ83SofDxPk5rrnzsP2iQiV5q6qOK0IqgL2HBpCFhtmenWgBs1vvsYFMoC
         Bytb7/z9sevay4u4rYzo0+Vm+us1SN+KB9NpLEBMqiPRA0qclb75mn7EKiUqwRd97XeC
         SclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XS23GWNF6oSUuKNHooHaOoZvjZmFqwP7KU5aIHJT+5A=;
        b=rNqROD93iNJXS5k8OCMnFutg+1Q0SUxaSDlglkXk6KFz8fa+DjkhWhbFjj2tY6dMHX
         Fac6bfDVbulGPIAoZKf2SeHjm/MFMhWFSBlfNQELZNXO1jTdGV0j+ttrgehHhxn6dznH
         VidbMfsoq6UzjhNv57ijEagR127wfGsG82MXfHfuDhRCs0Yx9RHJbGd/nxJQB+FSJ564
         rSjze6sB3aj5mC5gG5NIE9GAB3QG7WbWYIS0O4LrLcAHHtIX8hoGACsC6EsG/ykA/+23
         YaIX7MkgnZg7T8Xk1E+eaIpN6hhKjxsepmL7ruJaFchNznjGyOIpwBkv43uRjTB5xPq0
         Gh4A==
X-Gm-Message-State: ACrzQf2ilOnwqSrlNfKiX8C659FKrf7225yZAWTAgO7rj0L5euO5wpub
        Vvks9SMAu/Vs7tASsG2cp2n1xBJRrigk3ucHaM0=
X-Google-Smtp-Source: AMsMyM5ZYjXEzO0/HEqGayWA4fStOo9RSEsdOIEhvEPDuoRrikAWDKvLjI1tCpor6iQNo4h2mTI7o+lrMVqIGbOJIpw=
X-Received: by 2002:a63:4384:0:b0:43a:18ce:f98a with SMTP id
 q126-20020a634384000000b0043a18cef98amr18726033pga.273.1664175585713; Sun, 25
 Sep 2022 23:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <6ff29e96-7f8d-c354-dced-b1b363e54467@gmail.com>
In-Reply-To: <6ff29e96-7f8d-c354-dced-b1b363e54467@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 26 Sep 2022 08:59:34 +0200
Message-ID: <CAN0heSra_LsBzYCNFh0cZOZ0pmk1Wb9RtNTLwi93UM=f-53Uxw@mail.gmail.com>
Subject: Re: [PATCH] ref-filter.c: fix a leak in get_head_description
To:     =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 25 Sept 2022 at 00:53, Rub=C3=A9n Justo <rjusto@gmail.com> wrote:
>
> In 2708ce62d2 (branch: sort detached HEAD based on a flag, 2021-01-07) a
> call to wt_status_state_free_buffers, responsible of freeing the
> resources that could be allocated in the local struct wt_status_state
> state, was eliminated.
>
> The call to wt_status_state_free_buffers was introduced in 962dd7ebc3
> (wt-status: introduce wt_status_state_free_buffers(), 2020-09-27).  This
> commit brings back that call in get_head_description.

> +       wt_status_state_free_buffers(&state);
> +
>         return strbuf_detach(&desc, NULL);
>  }

Good catch, and excellent history digging. From the original submission
[1] of the patch that dropped this call, I get the feeling that it was
originally developed some time earlier. I suspect this call was then
accidentally dropped in a rebase before submission.

FWIW, this patch is

Reviewed-by: Martin =C3=85gren <martin.agren@gmail.com>

[1] https://lore.kernel.org/git/20210106100139.14651-1-avarab@gmail.com/

Martin
