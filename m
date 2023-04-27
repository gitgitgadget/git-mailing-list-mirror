Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6FBC77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 16:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243825AbjD0Qcm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 12:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243284AbjD0Qck (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 12:32:40 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526E04483
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 09:32:39 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b4dfead1bso7215241b3a.3
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 09:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682613159; x=1685205159;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZSPWA5gezA1PpAR//JxLkgQmufiBkTXTGXzp9lTV08=;
        b=FP30GJIJ2AeLvzJuWiwib+3RKhP2uLUSb14/tgHmBqFGmCdNFnW6btxQEDK3uCNP4U
         GFTCoBSu9cRoeEZvF/kkbrffy8/rqaUR+QTbjDug8QjjzgQfGzTtneEG5PMiHK0bM4hY
         VHJ2tK2hhoWdZO1xSmaK4GSjh4wxAWktR/jqeJpWnhIKuLGO1jamXUsu55+mnJiangP+
         IUNxajHbACSLIf1jrvgJovV1VT9J6Uy/bOCtoQR80QDAODhrNBmlsw23HG83F57PDMdv
         5xfcsVsxEZmT+fR8y8i8GuEJqqHpoJH4QEIy3Rt5Oe8AaIlAMvGViu5IbLqESNLcLKPr
         95jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682613159; x=1685205159;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pZSPWA5gezA1PpAR//JxLkgQmufiBkTXTGXzp9lTV08=;
        b=WyW/j3JljPeuxnERrlqseMP0fgCKr2rA7ECqMMxdphEWKKq+MMBLQ3zjme0HlGRr7X
         klHVYmFJGxolNKfM+Ps5jSlI2Bg5fi6DDzNOa4lmva2yAWMmTcyCM4zrwEV2mwQ1zvuR
         fnWSziV1C/ypK0s1jMj4Ndjl/4yzKtFXy152LJrimd1ZISkYKDA/YW5ljCE9klOyotDg
         +hUUdrQ3qeJ3yfUfBHA4VQzD7l3Y9lbIHOnPHhrgdQTTjY0H2liQdasN2qYxZcjkjjDA
         hGI7OcMPnOLGBFUGRN6xdFShI0n48jgBW8lk+PxxycOr72HrWWmADX4sLJ7+r4FKty9l
         KpPA==
X-Gm-Message-State: AC+VfDyKPacaG0E6SVhZFb59LemX3iRmu4DRjCmZ9iy/eEDBouAy7LXs
        nJOD51rTMdiIVE2PHsSOtfU=
X-Google-Smtp-Source: ACHHUZ6KlWaBeDuD1zUV5Tv8vWFg9QK6hQblGHzekTf+Wudoo/X3p+VEaMD9fbMNVJ/k+rWXsvmnkw==
X-Received: by 2002:a05:6a21:78a8:b0:f0:a5b8:59f9 with SMTP id bf40-20020a056a2178a800b000f0a5b859f9mr2734286pzc.15.1682613158746;
        Thu, 27 Apr 2023 09:32:38 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id m1-20020a655641000000b0052871962579sm4578782pgs.63.2023.04.27.09.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 09:32:38 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Thomas Bock <bockthom@cs.uni-saarland.de>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 0/4] fixing some parse_commit() timestamp corner cases
References: <20230425055244.GA4014505@coredump.intra.peff.net>
        <20230425055458.GC4015649@coredump.intra.peff.net>
        <06bc5530-55b0-7299-a6e6-fde1deab6605@gmail.com>
        <xmqqttx43q08.fsf@gitster.g>
        <20230426113658.GC130148@coredump.intra.peff.net>
        <xmqqildiveu6.fsf@gitster.g>
        <20230427081330.GA1461786@coredump.intra.peff.net>
Date:   Thu, 27 Apr 2023 09:32:37 -0700
In-Reply-To: <20230427081330.GA1461786@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 27 Apr 2023 04:13:30 -0400")
Message-ID: <xmqqh6t1l1zu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So here's a v3. I was tempted to add the fix on top of the existing
> patch, since it's somewhat its own case, and could be explained
> separately. But they really are two versions of the same problem, so I
> just rolled it all into patch 3.
>
> Patch 4 needed small updates to its comment to match. The first two
> patches are the same.
>
>   [1/4]: t4212: avoid putting git on left-hand side of pipe
>   [2/4]: parse_commit(): parse timestamp from end of line
>   [3/4]: parse_commit(): handle broken whitespace-only timestamp
>   [4/4]: parse_commit(): describe more date-parsing failure modes

Thanks for a pleasant read.  Looking very good.

Will queue.

