Return-Path: <SRS0=m/NF=B2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761D0C433E1
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 12:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BDFB20708
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 12:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfOQdhAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgHPMVg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Aug 2020 08:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgHPMVe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Aug 2020 08:21:34 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF82C061786
        for <git@vger.kernel.org>; Sun, 16 Aug 2020 05:21:33 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id g6so14465599ljn.11
        for <git@vger.kernel.org>; Sun, 16 Aug 2020 05:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bTx6HxxQU1f4ZlwfHTi6SFqeX5SakfCAmWnmC12UcO0=;
        b=dfOQdhAilJVGna4LwDn+pGh5H0uWPk4If00KLjuvaEtKpCTnZa3K77RqMJeQofPGCx
         5ZcLeqTb7QerPEMKHsMAIEJjn0Zqski4MucqP7TCQDAT8gOyYdgzoLiKhKTgn6l61la8
         eOr3BJMlpEw1p2nG/yvF7VljAYIZBztMdvVNZbMy6qdHPn+7OVYV/Bd+597MGLnSPTo5
         b3WZ3PMHmNQmEtqj6/wmmKranbzj54+J51BD/l5JQ/eWHeo69tUI/WUr1g2wBEIjNpUo
         Sa9seRy5AFrrvXSzNSXMYH6n5scf2POa4tHo3de+9ps5XYNqsfY5yotJVUWRerCQ0Avh
         NTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=bTx6HxxQU1f4ZlwfHTi6SFqeX5SakfCAmWnmC12UcO0=;
        b=od4uurygyDqWws56CGijXq5Z1sjlSGHkcZ0rrJJtJxI42S/frV4UKrxUgC3h4dBg2Y
         rYptG9+T0Df3YBt3r3+O0YRFE7kZ3yU6+2Q2QzWrqfytEakAPufNqWlHHAz0Ya0kqXCw
         FcjJRG6vWiPtu8NKspX6MNKDwKYHaI4UpALSfXzpnhGMlc5RcdZhnkJ5nT/4frNzK5Is
         tqrtr3UvJwWdp/YhZ5vNvM2wafNyrHXMekLwQ45p4JA7H4g573RkK4n01UCrEUSgMxv5
         ZX4tFxGjSX3IVEnNq3xAG6kps10LOr3yntL/w/2IEqp3moAQ8fuKRrQkXbb0167cM/S4
         tAuA==
X-Gm-Message-State: AOAM530Z72zvCWdtBLrBDADRtZMYatmDaLPSgfJAMGV8TXi1dl7vQVuB
        jZYKm5Bc9KeRpzz4HJrPJzE=
X-Google-Smtp-Source: ABdhPJwOMNcZL0NRndq+4Gc9RTGRg18RTSVgOLmVls4VyFAfvFaFimsUhwUVRWHwbcgnVxKh6sFidA==
X-Received: by 2002:a2e:b04e:: with SMTP id d14mr5690010ljl.16.1597580491361;
        Sun, 16 Aug 2020 05:21:31 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id l13sm3957605lfk.18.2020.08.16.05.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 05:21:30 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        solly.ucko@gmail.com
Subject: Re: rebase -i: quick/inline reword
References: <87sggab031.fsf@osv.gnss.ru>
        <20200816001401.1144752-1-aclopte@gmail.com>
Date:   Sun, 16 Aug 2020 15:21:29 +0300
In-Reply-To: <20200816001401.1144752-1-aclopte@gmail.com> (Johannes
        Altmanninger's message of "Sun, 16 Aug 2020 02:14:01 +0200")
Message-ID: <87mu2upyra.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Altmanninger <aclopte@gmail.com> writes:

>> >   !f() { GIT_SEQUENCE_EDITOR=true git rebase -i --autosquash "$@"; };f
>> 
>> These are very good and useful features indeed, and they are examples of
>> batch processing that is very handy for automation, but lacks
>> interactivity. What I rather have in mind is being able to put all the
>> messages /simultaneously/ into my favorite text editor and edit them
>> more or less freely till I'm satisfied, then "commit" the overall result
>> by passing it back to git. Essentially "git rebase -i" on steroids.
>
> git-revise is a third-party tool that can do this
>
> https://git-revise.readthedocs.io/en/latest/
>
> For example, "git revise -ie" allows you to edit all commit messages in
> @{u}..HEAD in a single buffer.

Yeah, exactly what is needed! And there are packages for it both in
Debian and Ubuntu, double win! Thanks for sharing!

-- Sergey
