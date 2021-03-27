Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7F7C433C1
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 00:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00F1561999
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 00:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhC0Amr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 20:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhC0AmW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 20:42:22 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3451C0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 17:42:21 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id z6-20020a1c4c060000b029010f13694ba2so3820396wmf.5
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 17:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=T0Kx9e7+fjIUsvONIPLFaY8hlAN1ltkQJUWthdseNnQ=;
        b=oAuvdEtU7wbeSMMfP7ZSSVXsvSgkEqV5y5pO5xlHg89/yvjWigooliuxc38cPvJd7M
         dXbor2xgMfhUpMNJ0og9VH0MmfCO9NFe/pDjJQJohGXx2gDhVTyouHOsepAM6QxPLB98
         o0OsRMeM5vZTJ815dOoRRtnNAcLwrdc1WHTvMO6AwHPKaPcsByOdCaDjdlBugUnaO2Mr
         jxRl2WQiWzd8vzF14KiEiuTB+ZstI7ayIvNhtlAx9yGmk7r9AiUN9knyx/mhFswA1EM+
         Ltt9WFOObcUF8rF5OXPLXX+XsLO12zTOHYHgsJnX9MQktM+FlZ59KhimeWtqtmDuvXPS
         3LFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=T0Kx9e7+fjIUsvONIPLFaY8hlAN1ltkQJUWthdseNnQ=;
        b=Ui5NQgu6janQNA6ajxQ7WQKsMX8DQey8SlsXnNSYEKd3UQZs0dpVBsVWMAxfPulXH4
         s1seeRunFcjUIlW6GZi38eWD7oypK8y/+uB/S+S7g2xbIrMbkbybiFI9xDDCO5beIrfj
         hY4FYqhqqkkog5oLCzNQdWSlvhsx4IV/VYqbjfcbgHam2Uf785RYsQYNnI/jWvfYOzXa
         kHpGlUOqDjjBom0U3Zfi97NLzdc1jNFUxsm0qZCN+5QC6yjJsZv4eRLZpixLolk32CQU
         0b1dVF1SFngOArRdGvgHUaATadsqrIvUudLaYCQEezufIsiI+rv0VYB5wamtiO9hHvWn
         Kadw==
X-Gm-Message-State: AOAM531MrHnJohPaiVPkVUJ0ERgSxVAuftAPuZzuCERouI5FMLLL6mLo
        fKOPWN++X82Cex2q9LYp+GoCQn4ZBJI4hDzDI4sBNqof1bq3zA==
X-Google-Smtp-Source: ABdhPJyc8DEW7SWpmbug2CiVFO9s3b1wLrQ1303OKWnEqO8Ol/IZJB4fQdaUwqI3i0oZ7GVKh+mWZN2HzJCDeUsBZbg=
X-Received: by 2002:a1c:b006:: with SMTP id z6mr14532019wme.19.1616805740460;
 Fri, 26 Mar 2021 17:42:20 -0700 (PDT)
MIME-Version: 1.0
From:   ama bamo <pythoncontrol@gmail.com>
Date:   Sat, 27 Mar 2021 01:42:09 +0100
Message-ID: <CAJxd1DPcCD96NSqzXvh3cgA93d1nCNFQbFWduTCqfx1zi_1o=w@mail.gmail.com>
Subject: exporting git commands in parsable format for constructing
 language-specific API for git CLI
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While using git commands in my applications and reimplementing the
same stuff i found out i can just parse git docs then generate
structures and classes based on that; i have done similiar for
wordpress and its `wp-cli`, for example see:
https://github.com/bukowa/gowpcli/tree/master/generated

But `wp-cli` allows exporting all of the commands in a json format,
see: https://github.com/bukowa/gowpcli/blob/master/generate/dump.json

Is there anyone who thinks that would be benefical to do something
similiar for git, or maybe there's something done already and i missed
that? (parsing manpages / generated htmldocs is still a pain).

Thank you,
Mateusz Kurowski
