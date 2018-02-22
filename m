Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03A191F404
	for <e@80x24.org>; Thu, 22 Feb 2018 19:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751340AbeBVTbI (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 14:31:08 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:39835 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeBVTbF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 14:31:05 -0500
Received: by mail-wr0-f180.google.com with SMTP id w77so11716970wrc.6
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 11:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dcU0rHGYd0xQgth9Z4YGZOoHHrOMUOt9JLLoopYGjHA=;
        b=ko3+GnuhQxgr2ZgK/Hcd/oPfehzW6mLDw+zyT3ku5DC2UJ/q8ZENEg6PwwV/ya3GOj
         RkS6zvz52VNuHsuoTroO09jnuW4NNc8On9NwNYp0NNv8iLX6MAi/LgyJuY96XlANLuSH
         IejJ+MjCQgRLBfM6hwatwVQZ3h0q85o2Coqjn/4cmR8HxHjHuro1inLnRYOj1gMnj3mp
         sPE7FXqdK4MTfxdlhEo7+gngqHZPWPwd1y8owVPddtYoY5oT32+MeJse/5p0x5SVHhF5
         3l3pduuk44z2hvhNoblDDFkabCJvKg1oMiJHOZEsCBzYbHXIr/S2XyFluNmnaUsdOmtJ
         2ycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dcU0rHGYd0xQgth9Z4YGZOoHHrOMUOt9JLLoopYGjHA=;
        b=kLUMCSO4DvVZz5IPgOpFLb2vBr+Io88HFY3tS/ueagFq6vpMeV5vT6dA+vGJAhILFW
         6SAr9SltZZZlsUxx7WidfZ7kjUQUOgOFX/5t//4gcQiVtD+B3GihDBgztTU3HlDQc+7u
         aTVdhpzz4Mq39B1xI1Jm3brRAaER4RhEkRYJL8xwVyLbHNRIDnKya5TSu+YiTA1TZFeb
         EfiBvvhEgNiomxSO2U6xScXpbBh2qK9/4AFQEv3pSIrwvNlTNakksuFKxW//eLr+svAw
         ugpOCuvl0gugeo2DqnKWpjhPcW1149yVgPGZVldwj/DJgZBUbnxsXKbqIHbIBzQvI4PE
         n42Q==
X-Gm-Message-State: APf1xPCBe+0UONU3RtEQks+iaO3chjWriokP7hwvan2zuy9KymzDAeL1
        IX7KzemLZG7orhr/5JEhxK/MRL1ov7Tas9HxNcGfNA==
X-Google-Smtp-Source: AH8x2260T3yvhQdRyKVsyIeVzjBwfrfv7485qK1lDTlwOGzo4bATYh+l+pgSgU+vhkzMQ5y7UBgS6Vjqh1AZ1G9LZX8=
X-Received: by 10.223.132.103 with SMTP id 94mr7512309wrf.115.1519327864204;
 Thu, 22 Feb 2018 11:31:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.179.2 with HTTP; Thu, 22 Feb 2018 11:31:03 -0800 (PST)
In-Reply-To: <20180207011312.189834-6-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-6-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 22 Feb 2018 11:31:03 -0800
Message-ID: <CAGZ79kanWXGa3v4oJmoerh3XzisS+3V2oyO7WXK-tPTiHgSgxg@mail.gmail.com>
Subject: Re: [PATCH v3 05/35] upload-pack: factor out processing lines
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 6, 2018 at 5:12 PM, Brandon Williams <bmwill@google.com> wrote:
> Factor out the logic for processing shallow, deepen, deepen_since, and
> deepen_not lines into their own functions to simplify the
> 'receive_needs()' function in addition to making it easier to reuse some
> of this logic when implementing protocol_v2.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>

Reviewed-by: Stefan Beller <sbeller@google.com>
for the stated purpose of just refactoring existing code for better reuse later.

I do have a few comments on the code in general,
which might be out of scope for this series.

A close review would have been fastest if we had some sort of
https://public-inbox.org/git/20171025224620.27657-1-sbeller@google.com/
which I might revive soon for this purpose. (it showed that I would need it)


> +               *depth = (int)strtol(arg, &end, 0);

strtol is not used quite correctly here IMHO, as we do not
inspect errno for ERANGE

Thanks,
Stefan
