Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7612C6379F
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 22:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjARWzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 17:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjARWzG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 17:55:06 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E4A93F5
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 14:55:05 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id bj3so632793pjb.0
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 14:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqFn9Ld/MXEPCzabPFAbyPt0VcTQ6hCzVNoCpM//eJ4=;
        b=AUGg42aqV+1Kf9SvpdlwsMgkLQGNoosCnqqDLkEFm7S8krMJe4Azf84YvE8kHB15KK
         1CK5M+9A7LL8g6NAayP3m6Byi/uO9h5EUGzBWeARmZZ3R3qZq5giCVaEQxXQtgm5pmqA
         Gcb/pqne4YmmcPSJtbZ767fKaLpO6KSCAizEB6q9b+fzPAo9eYrbLEShPHEaYbwtPIJ/
         SsNS1ey0FFD/L/mB9HVOzq7IqibAvSi/rA/CCeiLrvOVohdC2+pv0omvCxcKPg/+UZFa
         mDyqa40cW2u40WTUuVKcIFNVsGs7VssB7lvEFRuYuwpz7KkLoHZeWJb4qQLMAVpvbZYl
         KZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AqFn9Ld/MXEPCzabPFAbyPt0VcTQ6hCzVNoCpM//eJ4=;
        b=NqvfObp8eJ9DL9kHmirTSw4SjJl+xJRA5uMcUUsPdvgul6qqUCDUgBhRofrvVv9S+J
         W1BpDQYB6yq7zrvJgX2OTQj7HGMUli+ph1FgK7cxw4zHDkOs0oGRNG0l2MuIQUYrEVOv
         xug62Wk7bDkPPn57NnIbESnzKhvfFmygSVoSxYO2s3u/1EMXI/E14QpKNpEtw77L3y1U
         0esgJKEDM+HW0UYIJUHsyiZUmyteyL1ZtfEDTbCYvIXEG2BzW2sLM8MoXH0Sr9DmrLMG
         f8+2LaCP8iyEYjmBdEw5sRyt/vu2EI0QEFAebu7lKz5y2UQxU11PQWP0W4quR34ResB2
         MPBA==
X-Gm-Message-State: AFqh2komIVfBbaDSdgeuSpJ6Rx65H11fTpVmuvOVxDGnG4Rz86c+1hwB
        ZikRXdYw7eMM3IKzi8X9/9I=
X-Google-Smtp-Source: AMrXdXt6kIgIdOOog/ERB7lxo60QjsBF80V6xXN8a6veCrvacW+ap1IwjBmxu3hijLv3vAixGFMGKg==
X-Received: by 2002:a05:6a20:a00d:b0:9d:efbf:6623 with SMTP id p13-20020a056a20a00d00b0009defbf6623mr10119806pzj.49.1674082505059;
        Wed, 18 Jan 2023 14:55:05 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 35-20020a630d63000000b004cc95c9bd97sm6028689pgn.35.2023.01.18.14.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 14:55:04 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Jinwook Jeong <vustthat@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] checkout/switch: disallow checking out same branch
 in multiple worktrees
References: <20230116172824.93218-1-carenas@gmail.com>
        <20230118061527.76218-1-carenas@gmail.com>
Date:   Wed, 18 Jan 2023 14:55:04 -0800
In-Reply-To: <20230118061527.76218-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Tue, 17 Jan 2023 22:15:27 -0800")
Message-ID: <xmqqbkmv4fnb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Belón  <carenas@gmail.com> writes:

> Changes since v1
> * A much better commit message
> * Changes to the tests as suggested by Eric
> * Changes to the logic as suggested by Rubén

I queued this topic at the tip of 'seen' as 2fe0b4e3 (Merge branch
'cb/checkout-same-branch-twice' into seen, 2023-01-18), on top of
4ea8693b (Merge branch 'mc/credential-helper-auth-headers' into
seen, 2023-01-18).

 - 4ea8693b - https://github.com/git/git/actions/runs/3952916442
 - 2fe0b4e3 - https://github.com/git/git/actions/runs/3953521066

Comparing these two runs, inclusion of this topic seems to introduce
new leaks, as t1408 and t2018 (neither of which was touched by this
topic) that used to pass are now failing.

>  builtin/checkout.c      | 24 +++++++++++++++++-------
>  t/t2400-worktree-add.sh | 18 ++++++++++++++++--
>  2 files changed, 33 insertions(+), 9 deletions(-)

Thanks.  
