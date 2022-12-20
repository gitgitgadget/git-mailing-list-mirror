Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6BFC4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 00:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbiLTAyP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 19:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbiLTAxy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 19:53:54 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883E1164B6
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 16:52:41 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso10559932pjh.1
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 16:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydzkp9NdOJYaKyvxXlJVbMnS7LxXKDFIxNnmAGlaS78=;
        b=hEBlQG4/+gjs124mQoxp2E8epM7oOLpC1A0lBHaxiOTb/q7iyNWReeueadvfznj67s
         aWRl7hHN2Zilrl//CiYWyoJpw8N8PKCxoCvzLGHjBfsZBg4xX3nQZSFDhVkfwTYopX4I
         LVqV6IlOz0jdC8sVxmWJJZLmRc01DdjJCU2wNhUrMGIhL4GabwlDnn0gIwRm6qKirsfH
         vhAn9Jbih9ybOPnmtaQlZfA90Gr+ZvPZ2Fd2LTtKs1nAibkf0uHwmwGBymczHyxOC9/9
         ykKTntoWGadPtA9vD91AOeHl99GGr/cIzN/nRZXkNK7hhURn53aJDOEy3LAspOuwuk4I
         uisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ydzkp9NdOJYaKyvxXlJVbMnS7LxXKDFIxNnmAGlaS78=;
        b=BiGlopnd84f9DuX46ApDTKlRNGjfsTYxwhcmepweUepawtCpGUo4CO8IwHjVmFGGvD
         qEuQwjYewC6p7H001X4xGYVmFn0+Z0cDA1PMtNO2rtIqV6y/2b95McpZTmOnd86tUj8Q
         v/CuWb9GaEgSowhG+ir/OqJkT8Rb8kTX/MYH/J8PCCTYNxMWYKRJgu4k+UDh3qe5aqWP
         1xva3shMhz1TnUwQoQyjWEQzVG1rgU3opFv6GVnRAVBmHJdYOTvUZItywX2hNO+v1kRV
         qtHQmsCoP1L0hFsFfC7nk7kgrqMn19UI5Cj8Gi8yiKre2qSw9lFTLtyYOVpBg7aGXUbe
         hWdg==
X-Gm-Message-State: AFqh2kq6KcY4ipWp8TDNKD4HElTds0CM6+5M3qMWLNEsT3Evq073lEG/
        4qlu6Mm2djHavwlLtejPOtJ1Kmo/ZcECJQ==
X-Google-Smtp-Source: AMrXdXuzjD6G8oJYFwA6utzn8CE+rrU6qTEO8hpKS+2AWJ6znX120hCPq1youwKsxLluyprKxHNjMQ==
X-Received: by 2002:a17:90a:7006:b0:223:dfbf:e86c with SMTP id f6-20020a17090a700600b00223dfbfe86cmr2150024pjk.36.1671497557536;
        Mon, 19 Dec 2022 16:52:37 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id j3-20020a17090a694300b002190eabb890sm9857472pjm.25.2022.12.19.16.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 16:52:37 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, phillip.wood@dunelm.org.uk,
        peff@peff.net, me@ttaylorr.com, phillip.wood123@gmail.com,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: only run win+VS build & tests in Git for Windows' fork
References: <pull.1445.git.1671461414191.gitgitgadget@gmail.com>
Date:   Tue, 20 Dec 2022 09:52:36 +0900
In-Reply-To: <pull.1445.git.1671461414191.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Mon, 19 Dec 2022 14:50:14
        +0000")
Message-ID: <xmqqv8m6zyjv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>     Ævar and I have brain-stormed off-list what would be the best way to
>     resolve the mounting frustration with CI failures that are caused by
>     needing to mirror Makefile changes into the CMake-based build, a burden
>     that the Git project never wanted to bear.

Thanks, both.

>     A very welcome side effect is to reduce the CI build time again, which
>     became alarmingly long as of recent, causing friction on its own.

;-)
