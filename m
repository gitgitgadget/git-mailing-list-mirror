Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D01FC77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 23:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240622AbjELXVz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 19:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240614AbjELXVr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 19:21:47 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61741A9
        for <git@vger.kernel.org>; Fri, 12 May 2023 16:21:45 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6436e075166so7954961b3a.0
        for <git@vger.kernel.org>; Fri, 12 May 2023 16:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683933705; x=1686525705;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ew6QBmFIYaWS+wwPmoaqKTkOWiD6qH76IF9Xko8fi2Q=;
        b=IHk1mEdY5+pGkkH7nPsFY+7uH61nSseLkkytSzYrLHaRxSB3d5zhq3YEA3TQY1UNKG
         G+5uWv/Ja0AQvADlGLhYKPVyYX0C8xWPHk0rzH5+3FiCTIAjO8gq84SOyXNu/wugIXTT
         TclGLznvkKXqLkMvjndqWN0XpcAnGdfTE0ZnPUmep+IEqoRprOxgGjEK5PuYPYKei3Kg
         SwgNHCk2HQynvP2MgLUWtLb/U8Pl65M1roSugDaB/BCmXZHMDpjboyYNZAaD2lliwPcD
         8S298+pWVgF/0xyueqW0sLq8R6Xl4TIHe4pvoLOv+B1fTnBBck4Oumhq4Qpq+CgWFw+B
         74dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683933705; x=1686525705;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ew6QBmFIYaWS+wwPmoaqKTkOWiD6qH76IF9Xko8fi2Q=;
        b=XJBnBH2JhOryaHueNDQ/LGjmjkStWCuA7Z+v1cHc6dqTLEY8Dqx4rfMMfFsWj83KQ8
         +C5N717C7GDqFuHJGLDX6WY9og9fm74VirOgwSM5aN7efeXtxpJoXPZ0P+unUMCgJA+i
         3R3p7FisymPm6QfV2opJ+eR7frwtGhLmkqQJRK7cz2SEf0/POrniOTSJKiUhjMMnwcRo
         tLVyJfqm2kBOuSAh1WZuWPeqR//baIMXC3WpUpozS9JXoZITpsqPo+OwMx7UUc4xYVsL
         NZkDVx23xNCD/uJ8X3OQ+dWH89+2CACqUKhidYrJCukU8QBhnvA+mOoZJZqRCiAyKLvg
         G4UQ==
X-Gm-Message-State: AC+VfDyIpZ/06WNSAqslsLGKfvrv6zTOWy42zc66x23H/lcMBzVTV3SB
        pymH4KbaQ0bZcqX7Lzl6gis=
X-Google-Smtp-Source: ACHHUZ5ung+RMOkw9QZNqV35GlomMJR3unZSHnMm0K8SK1Webg0Q6vSWQib8wZUBtTedrBq09+FO6g==
X-Received: by 2002:a05:6a20:8e24:b0:100:214c:d76e with SMTP id y36-20020a056a208e2400b00100214cd76emr26232335pzj.53.1683933704726;
        Fri, 12 May 2023 16:21:44 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id f8-20020a631008000000b004fab4455748sm7294437pgl.75.2023.05.12.16.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 16:21:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 2/2] builtin/pack-objects.c: introduce
 `pack.recentObjectsHook`
References: <cover.1683847221.git.me@ttaylorr.com>
        <2ce8a79fa4bf98947728da4e6e22304a2f203fac.1683847221.git.me@ttaylorr.com>
        <20230512212456.GA2495860@coredump.intra.peff.net>
        <20230512214542.GB2495860@coredump.intra.peff.net>
        <20230512220117.GA2971903@coredump.intra.peff.net>
Date:   Fri, 12 May 2023 16:21:44 -0700
In-Reply-To: <20230512220117.GA2971903@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 12 May 2023 18:01:17 -0400")
Message-ID: <xmqq4johnnjr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It does make me wonder why "git prune --expire=never" does not simply
> exit immediately. Isn't there by definition nothing useful to do?

I think the answer to the question is "no", but if I have to guess
why such a low-hanging fruit optimization possibility has not been
exploited so far is because it does not optimize a useful case,
perhaps?  IOW, falling into "if it hurts, then don't do it" category?

