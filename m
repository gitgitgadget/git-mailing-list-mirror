Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257DFC433F5
	for <git@archiver.kernel.org>; Sun, 15 May 2022 19:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238347AbiEOTWL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 May 2022 15:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiEOTWK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 May 2022 15:22:10 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDE622280
        for <git@vger.kernel.org>; Sun, 15 May 2022 12:22:09 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id w124so13515685vsb.8
        for <git@vger.kernel.org>; Sun, 15 May 2022 12:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yhV2SrnLKmqFxBJkSZyykomDZVU2g0zioH0RfYsxcW0=;
        b=NG+cpWR/6bdiXz8DQI5RF8RkFLTPgPkAijAnckybnD8jp8mwNSCm2Oj61cKDRPmpFa
         Dk54WQ8lxvKuvEb6nZAyiRztikRJ5EPWeagUeOZJBMYf65Xb9DX/mK/iJUP86EzodKwq
         NPSE4cd/O1CnU38y2GE1UF2VWSuwp1nrm5WoMmxsz3LZxHkVMAvPqkn2QcQwxpsn9zw+
         IF1ZiHvWkjZy0AYnJJGYsCa+D4fKzAnaD32yjADidtn9Bg9jHvBislDw25nEhHlr59a+
         CTNMkPoS0qLuYX2fdLWHAgJ3xxfaB2/hT9F0q1Hr2Li9dxPbe05fFzUnR5tbpVNy3AS4
         P3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yhV2SrnLKmqFxBJkSZyykomDZVU2g0zioH0RfYsxcW0=;
        b=cUzAdG75jHC00ksHkYMdyNaoX5VLMajOutzih/GWv53vZZ5L5fbhV8I1QOvz6V3yI5
         3J3SR34IRY/9ftmatjnacLSS4TOrnkSgZ+6SHiGr/2CZmpOcVfie0WCgRlQb8o+FG3G9
         L5cgUyerFULT8+ftL1rmhi2DICxnxj9jE2yvdugGqaGNA3v3/3fYjsnEyKtSWp23Q7YF
         JSat0jIcvKvVMGC9gDXj2UYm+1ZshoxR0P4xWGQ04uz7GQF1u79N7TZVeq5scM1cBFAw
         6vxjUwQvvPdWRpSyJmBsAGNS2l5rrkgs+b8atzdkXhiRO9YnMkvln+wX0cYlFFUiH/9A
         HvLw==
X-Gm-Message-State: AOAM530XUmGG5zCE0h4r5HGLEMNiI92hrZULeMSVeXwPB48MtXEXNd7w
        zuEs4XT+AX3EF/hneQDYwNjk7mGPi/cgg+9nPh3zqILM
X-Google-Smtp-Source: ABdhPJwWr90GNE0WKomkDz4+ejzZyUFAfuidJkgMhI196yPPAbI19N4e1dgdYddWhLw6Ud8ZFuAMd0Ps9fexaGB+zdc=
X-Received: by 2002:a67:d303:0:b0:32d:3d07:17c4 with SMTP id
 a3-20020a67d303000000b0032d3d0717c4mr5136518vsj.52.1652642528202; Sun, 15 May
 2022 12:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220510174616.18629-1-carenas@gmail.com> <20220513010020.55361-1-carenas@gmail.com>
 <20220513010020.55361-4-carenas@gmail.com> <xmqqee0ycjos.fsf@gitster.g>
 <CAPUEspj1JTG2Ujuk4O6ogo6qEQEwe-2aHF8J95xjX+OpY4cenQ@mail.gmail.com> <xmqqr14u7n4l.fsf@gitster.g>
In-Reply-To: <xmqqr14u7n4l.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sun, 15 May 2022 12:21:55 -0700
Message-ID: <CAPUEsphNOf37WB_xUuRNdfcz1TRRsSocbUoCbrmA3OjS_BTpdw@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] t0034: add negative tests and allow git init to
 mostly work under sudo
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com,
        johannes.Schindelin@gmx.de,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 15, 2022 at 9:54 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo Arenas <carenas@gmail.com> writes:
>
> > On Thu, May 12, 2022 at 6:20 PM Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> Heh.  I am a bit surprised that double sudo would become a separate
> >> prerequisite,
> >
> > It is because it goes away in the optional patch 4, since it won't be
> > needed anymore after that.
>
> Hmph, it may not be needed, but it should still work, in which case
> it probably is still worth testing, even with the optional patch #4.

Just because it works, it doesn't mean we have to test it.

IMHO tests are better reserved for things that might not work or that
should work, so this gets in the same bucket than "triple sudo" would
go, and interestingly enough we could add that test without having to
add a new prerequisite too!

> No?

Your call, my assumption was (since this patch is part of this series,
albeit optional), that the "double sudo" need will be short lived and
therefore better not to have this test to begin with, or remove it as
soon as the need is gone, which in practice would be the time between
when this series (without the optional patch) is released, and the
time that optional path gets released (maybe as part of another
series, since it might be dropped from this one).

alternatively we can make it not optional, and then the test will
NEVER be needed.

Carlo
