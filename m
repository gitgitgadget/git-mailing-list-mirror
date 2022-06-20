Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D280C43334
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 08:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239425AbiFTIcI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 04:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239340AbiFTIcG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 04:32:06 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4369612771
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 01:32:05 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z7so14013621edm.13
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 01:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=64+WH9CuZOWyZAPKlFui2ykxOpoTNB0mOCFW9ywpArM=;
        b=N+EXaUI5s0Qv08iAlLOApTkNQ2LijigvQm0BnXj9BjvTh4hNRoFZITC0qkdUtHDC4Q
         e7Iv6OZTT5OQw7UH1AsrHaLwPnTkkbVCluuipUo9n0MIxWVHtvCHlro69AOVE2PyxaS/
         kxpC3nzjyLwZSBys894P/h8SrIQUG3IY+YKvCUABQfk3lE0Elr8MO8Fll5s3LyEUSuW1
         0XEdVA+ymdOge2fo8AugoYI3Sr0EI6h6TVE/QCis1fuWZAOVfL7IdUPTYW5/9QeBh3AN
         6nZxtouyuQD/kJ6S1imJSfnQ5hzOKnPNDHlVEzEettrhwieCLnNljubewSY7hDMykK8T
         tbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=64+WH9CuZOWyZAPKlFui2ykxOpoTNB0mOCFW9ywpArM=;
        b=hUqdK0xEz7t70I9E7CaOrYSbAdGQxWdMjX7G9VajZe5lFsTt4yg1ITRotFeHPWQWa9
         /MTUMCeVh0NTIOePU5Oag+3Sr+skVnrpigdLCny/JTcOZ3DesC/l31r4rVA7HLr908/c
         oBmCTsdQZ/Moo7gJM4gUDf0NCIlbJgqjB5fnnu0uGUchPzDt+GQCX4WYXyvK1LjiLa9v
         pr4XB/rTp9p23Q1OcWIBS/PvDmySAoWxW9YiMo83VN3vck4ViK3r36Y7+Z9+j3nMHe6d
         vlheODn73oV3PlqcRfh4z39TgwR5SKA3Ij0/aS9xMzXHgKRw9+bDGKcUee6p47qgKTTT
         QVog==
X-Gm-Message-State: AJIora9ZOXy+/S1fCw0Oqx1GxlCh20U5hk7Bao0wQyFvdE/qMnFKJ6sR
        pt1Ce/ogPHOZGLgaOqnVBCA=
X-Google-Smtp-Source: AGRyM1u7+56AnopYaoE/IW2uvnLvOacoMIG6OQg0indOOzJ5kM7NmQj1wcv9c5i+qeMwHsSg1XzVdw==
X-Received: by 2002:a05:6402:2706:b0:430:6238:78d5 with SMTP id y6-20020a056402270600b00430623878d5mr28672215edd.413.1655713923719;
        Mon, 20 Jun 2022 01:32:03 -0700 (PDT)
Received: from localhost (78-131-14-143.pool.digikabel.hu. [78.131.14.143])
        by smtp.gmail.com with ESMTPSA id ep16-20020a1709069b5000b006f3ef214e72sm5513488ejc.216.2022.06.20.01.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 01:32:03 -0700 (PDT)
Date:   Mon, 20 Jun 2022 10:32:02 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/7] gitweb: fix "make" not including "gitweb" without
 NOOP run slowdowns
Message-ID: <20220620083202.GB1689@szeder.dev>
References: <220527.861qwf489s.gmgdl@evledraar.gmail.com>
 <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com>
 <xmqqa6ap8z55.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqa6ap8z55.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 06, 2022 at 10:44:54AM -0700, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> 
> > The $subject is a proposed re-roll of SZEDER's
> > https://lore.kernel.org/git/20220525205651.825669-1-szeder.dev@gmail.com;
> > As noted downthread of that fix having the Makefile invoke "make -C
> > gitweb" again would slow us down on NOOP runs by quite a bit.
> 
> It would be nice to hear comments SZEDER and others, even if the
> comments are clear negative or positive.

Well, my itch is scratched, so I'm fine with it :)

I think Peff has a point by questioning whether we should build and
install gitweb by default...  I don't have an opinion about that, but
if we do want to build it by default, then IMO doing it in the main
Makefile is the way to go, so I think in that case this patch series
goes in the right direction.


On a related note: this is not the first time when something was not
generated during a regular 'make' but only during 'sudo make install',
see e.g. 2530afd351 (Makefile: generate Git(3pm) as dependency of the
'doc' and 'man' targets, 2018-02-15).  Perhaps it would be worth to
extend the CI jobs with a 'make install/install-doc' command, and
error out if it generated any files that were not present before, so
we could catch similar issues early on.

