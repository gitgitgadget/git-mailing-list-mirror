Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAE8C38142
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 14:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbjAXOsf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 09:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbjAXOse (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 09:48:34 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA535303E7
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 06:48:31 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 88so3554184pjo.3
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 06:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UT/LGbpFBrb8Qw7EUHnbOo03oXhEP2TTOVFKhBYISnA=;
        b=qbDOEpcXIRQjyzWNIi7THep6Yd92c1QIECROe/nOiGvJgKVrO99yxuXRYtbdAFThxh
         51Vv+EqcuGwqYXWbDr5Zdtqw7nWo95HL8O23jROKsgkybp8DLk3hSazL9qG99aYYooTu
         ndBaEyMFeGe9hnW+3chnarRvHGZtJi7G7OFHgHUDEQA2d6vK8brGFNM10nXqzxx7m1op
         Zu21YfJz/BFx6gaEPIQv20MQzryIpR7WM5Rn2NqdBl+NZySPGNCJ5j2TjTtcZRfJuuT/
         sHroAGSV9U+9vqjc5bCNM2gOE4EkrbsWzPnH1bNKUXg8vB+yDx8TC184yg1GpbCwpfnU
         u0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UT/LGbpFBrb8Qw7EUHnbOo03oXhEP2TTOVFKhBYISnA=;
        b=gg/jyqrfh7gpnV482IZUfPppr3wAc48LBTF3cg7k/1OB5RV+ajNsTtxDX/cOC4/mlp
         q026gtDlRD5P9ACV48tVnVYhw58Xg4atYT8sF3EewfJ8gxrsOq3SjKtMvw5L/S6uaSr9
         HIlA4qidSsv6HikTHWhnft2I/Cu5m80qJYoeTD3z5NP4MZmuhrqR2erCi4tQnuneK/1X
         Kqo3TXpHgzbYyAuAkQhGWiQPV9POl4g50GcTHCJRqwxqdzjSK66j9uE/ZOIidaXGveoB
         XGk24rcI2xDOt5sXZ//wTS+AWBWqSUeQMLxAhwxCIMitei7UvoqscX1vM1OegGN8DdEW
         2ZYg==
X-Gm-Message-State: AFqh2kot6z0Ur4xyVsNHieTIFastirK+xuf3LnNsYSI4AL4eLGg+jyhw
        6bhX3jRCGhZ5fpINT88rmyM=
X-Google-Smtp-Source: AMrXdXsbMKvNzVbztbVt05u8HvMy0p/sFECCJZkzMREO8jcZH5V3p1d3jWykCKYk9Wx68Ma3NU8WaQ==
X-Received: by 2002:a17:90a:db90:b0:22b:b3b6:cf76 with SMTP id h16-20020a17090adb9000b0022bb3b6cf76mr16133069pjv.17.1674571711193;
        Tue, 24 Jan 2023 06:48:31 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u30-20020a17090a51a100b0022badab0dbasm8332853pjh.3.2023.01.24.06.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 06:48:30 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v4 5/9] rebase: add coverage of other incompatible options
References: <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
        <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
        <5e4851e611ee18112bd71939ee900e02a8d590c5.1674367961.git.gitgitgadget@gmail.com>
        <759fb313-ce88-4eb7-96c0-4adeb75ca9f9@dunelm.org.uk>
        <CABPp-BE+wRgjmWknARQpNsdUFjNOz0ND9wgx_-_RTyK+EwJjXA@mail.gmail.com>
        <83d27162-59d4-d8c0-fde3-f522630d024d@dunelm.org.uk>
        <7b9ee972-2680-2e1b-bef3-201d8a1e4bdd@dunelm.org.uk>
Date:   Tue, 24 Jan 2023 06:48:30 -0800
In-Reply-To: <7b9ee972-2680-2e1b-bef3-201d8a1e4bdd@dunelm.org.uk> (Phillip
        Wood's message of "Tue, 24 Jan 2023 13:16:34 +0000")
Message-ID: <xmqqpmb4j8e9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> On reflection that is only true for (B). I agree that we should error
> out on (A) which we don't at the moment.
>
> I'd support a change that errors out on (A) and (C) but continues to
> allow (B) and (D). I think we can do that with the diff below

Thanks, both of you, for well reasoned design work and respectful
communication.
