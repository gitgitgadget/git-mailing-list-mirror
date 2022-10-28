Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C3CC38A02
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 16:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJ1QkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 12:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJ1QkS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 12:40:18 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF2142AEA
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 09:40:16 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j7so1489162pjn.5
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 09:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i46PUzF4y0FKZL1qIJj4e0MerCvWjIKkd2/UUDaUSL8=;
        b=Cu7arkfg7Yd4b061kMa2mlvg5tq0epst1Ec/+4c4io/hMIHUki9XLZzin5H69fmbjb
         ONsSdLZIwSmERjnUF33UMOWWxo3EBVbydY3ZfiR2S5N41fax2H3gnjysPU4UU/EwjweC
         xfh+kpTdp+4RWaflFHPawwjfHYpCsmmutIWQdFGAgzAuV1ioYnpUqDFrSdKZA5bnmh++
         TeDJV2UiBSFYc1Q3OyZ00tAxY1MOHU3zE03QF90AIM5tCUc+/7BiskAW7wiNNN9i+byB
         O7mZo9qEYyhBG+cApTDrKqKTxEPuHO27rsSW64vrRm+o0hhkEYgAZDj8VW/DmnJqrBKw
         sjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i46PUzF4y0FKZL1qIJj4e0MerCvWjIKkd2/UUDaUSL8=;
        b=YjSw5ctfe21oeg9xx8zHvbMe3sFFNqIgIJbMnUJ74WT+wfxOtVC/DEHh2wvW2USkpB
         v491iIQPVHNgZJvdC+d7TST0wkhSdG1K3VBOQ5vUGNhJZNfl9IG+87wOINOJaDGnSQnG
         g2UzhhirAOducbk8tAt5KmNlJMX3VvTkYHs56hapUN4IaFw0O/ebDy59AnUs2Gph5RYR
         AXq/1uJPCbaHCdkMn+QWh2A/SWynpscBoKDj5CtRbfcJ0bVqJBHrGQxrVfuUanJta3eS
         Efz5Ch9Qor2guqVEW3L42/SDaYh4deABQHauVnWQ9Q7U35Mrmuf4GE3rnH05vut3AFXy
         bmPg==
X-Gm-Message-State: ACrzQf1a/az43X91kTE28Ihrq12sgY9qDnmUM94UH4WB/YsnkolUhasG
        ygyn+tQYBIDTzb79gl2/rd0=
X-Google-Smtp-Source: AMsMyM5s672s/sBi1JOOg81aqsg3LpoqD2fFuJiPqD/3eGjWu78RPP1ZwZmuz8CkAqJFt+8CLnzAmw==
X-Received: by 2002:a17:902:ee8b:b0:186:a226:7207 with SMTP id a11-20020a170902ee8b00b00186a2267207mr189130pld.49.1666975216280;
        Fri, 28 Oct 2022 09:40:16 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id s17-20020a17090a881100b0020b7de675a4sm2747396pjn.41.2022.10.28.09.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 09:40:15 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] receive-pack: use advertised reference tips to
 inform connectivity check
References: <cover.1666967670.git.ps@pks.im>
Date:   Fri, 28 Oct 2022 09:40:15 -0700
In-Reply-To: <cover.1666967670.git.ps@pks.im> (Patrick Steinhardt's message of
        "Fri, 28 Oct 2022 16:42:19 +0200")
Message-ID: <xmqq8rkzkikw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series improves the connectivity check done by stateful
> git-receive-pack(1) to only consider references as reachable that have
> been advertised to the client. This has two advantages:
>
>     - A client shouldn't assume objects to exist that have not been part
>       of the reference advertisement. But if it excluded an object from
>       the packfile that is reachable via any ref that is excluded from
>       the reference advertisement due to `transfer.hideRefs` we'd have
>       accepted the push anyway. I'd argue that this is a bug in the
>       current implementation.

I agree that it is bad to accept an incoming pack that depends on an
object that is *only* reachable by a hidden ref, but what you said
above is a bit stronger than that.  Use transfer.hideRefs does not
have to be to hide objects (e.g. I could hide the tip of the
branches that holds tips of older maintenance tracks, just to
unclutter, and giving a pack that depends on older parts of history
is just fine).

Let's let it pass, as the cover letter material won't become part of
the permanent history ;-)

>     - Second, by using advertised refs as inputs instead of `git
>       rev-list --not --all` we avoid looking up all refs that are
>       irrelevant to the current push. This can be a huge performance
>       improvement in repos that have a huge amount of internal, hidden
>       refs. In one of our repos with 7m refs, of which 6.8m are hidden,
>       this speeds up pushes from ~30s to ~4.5s.

Yes.

> One downside is that we need to pass in the object IDs that were part of
> the reference advertisement via the standard input, which is seemingly
> slower than reading them from the refdb. I'm discussing this in the
> second commit.

Interesting.
