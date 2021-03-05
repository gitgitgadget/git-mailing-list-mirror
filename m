Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA12BC433E0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 11:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82DAC65015
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 11:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhCELRo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 06:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbhCELRh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 06:17:37 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0EBC061574
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 03:17:37 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id w9so2010106edc.11
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 03:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=1oW1LTGwZdF2ggjJ1vjDnKfg0g7vE6bMm6wJ8zEDcOc=;
        b=s0cdo3PjaEgwaBE+APFGHADOI+lBUbvjK09FfCc1ftCyT41z+wAylBVoB3xxS1TwKR
         DhTIbJ+I4CZedCit3lYOQJGMofhWqB0jXlL9+deNB92DE3B4w9O4PYF9BMjdT5lN6oWK
         LxBcK7J3AJn2wlBr9gF9VEUnjK6HBAjGc12SDPI/nWOHFnQysCLXBOiUYpj5YrDI6hP2
         VN3BawDyiN9CP3MrumMN5JplrbBvwqvgRReFz7q5C5uTOWHOXdi1V0DEb8/OGo2VVnXs
         oaDpCSPoNJqEpIwh3MkGBMnys6hSVgb8p7hBmUHn7XDlcATswjTi0T7A9FUSvkNaTRWr
         Yshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=1oW1LTGwZdF2ggjJ1vjDnKfg0g7vE6bMm6wJ8zEDcOc=;
        b=Osq4n8xobKlcGgN+sHD/WpPHI1ydTk3fNdZ3jN9OxnQtlu9QfKFlVuul48lx9mbmQT
         d8Gyg2U6BHS4bJXOTKLdlTC8r+B9N2Z5D++om08QRP6BsXYQaJkoWA1l7xhNEgfF2QS3
         YqiP5sqbqmkAsonV3HqusldfiEBOfckQ/mWRFKqjJs3iyzyJt/5JlyHxwZ/EhzEe03tZ
         b8z//4B7KnfBvS3w4iSodPMtcvWfRNHQm7A2QPKzJrL6CW0MLm4FDS2NMvl8N1jHLGA/
         pTqTs/n9+rBKHL0hP3XhYQqVU1fewPfwyYdCjgvpTcXpijkGjm96wy/SkWobu+z7Hdv3
         cl+Q==
X-Gm-Message-State: AOAM531HtqyKmt7RnUpj/ZWGHyYfO6ZBBUAGXJePqpwzYOBOqTRfanok
        zqBs8Uhk0BcR4/WuhofhqIM=
X-Google-Smtp-Source: ABdhPJzQmyrg3gruE0ckEd0XpjusC9SsfP3ElDOouNtB3fdf+ZVTkK6LfMecknUjClAybfl82vyupw==
X-Received: by 2002:aa7:d0d7:: with SMTP id u23mr8432835edo.255.1614943056013;
        Fri, 05 Mar 2021 03:17:36 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id de17sm1323837ejc.16.2021.03.05.03.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 03:17:35 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH] Makefile: fix bugs in coccicheck and speed it up
References: <20190506234334.GA13296@sigill.intra.peff.net>
 <20210302205103.12230-1-avarab@gmail.com>
 <xmqq35xacxt0.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqq35xacxt0.fsf@gitster.c.googlers.com>
Date:   Fri, 05 Mar 2021 12:17:34 +0100
Message-ID: <87mtvhu9wx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 05 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>> [...]
> Nice, so in short, we've been redundantly running the checker code
> over and over on the same header files wasting cycles.
>
> Even though I saw you mentioned something about preparing for a
> reroll, I'll tentatively queue this version to 'seen' for now.

Hopefully soon, was waiting to see if there were more comments & what
Jeff King thought of it, he's replied now. Will address that (haven't
read it yet) and re-roll as needed...
