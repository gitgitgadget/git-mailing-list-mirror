Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7C1C77B7A
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 17:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236924AbjFBRUh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 13:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236913AbjFBRUe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 13:20:34 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED271A8
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 10:20:25 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-25669acf204so1997919a91.2
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 10:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685726425; x=1688318425;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8G7nxk6vFZ3h0dG9gQQtaP/msCiKQ4K7wNmrFTCX8SI=;
        b=6kebWgD/kinDLPEY2uh5cQJLgdoe3VJzXqg7pL3seTf3tpsUllwxfDAY4N7aTKF057
         WdFAmHCsIFEaTqLFueEY54Chzh3PjEPuVj27tHYUY923BLy9+KYeSDU/upP3+8FgvdM0
         orWmSEcx8xo5Vb1aVgMonKwsOtP4gZ4puDxObS1ZwDMp086vJ/LX5uVirY/2MvAmh4fr
         R6gFoe7RJq//TtBhi+IuGX/evJGuowrO5hap1gCdq7In1a7Czuiuua20UpRq1gUdftjS
         yMq19QDam9xkOV1HoJjcnLz5duqzFrJbQem7h4JSmDwTUf5qqlswwevXlYSBfbvZF4qO
         lncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685726425; x=1688318425;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8G7nxk6vFZ3h0dG9gQQtaP/msCiKQ4K7wNmrFTCX8SI=;
        b=WqAz3pNiBJtzzws1r99wpTHXWN7Yz4/quKG700/xVM2MYcIYx/G3qVGlHGDcc9+HSY
         JWUkJLEwBizcbsrfwO47Nt4usqR+ZRjnxLBUegRCdzdCXX7dZim4JpUEHCVcn0KHpzke
         /czODB+HcHlrqWyUoBJ6rduKPirUKztq62i/87V5Vtm27O5Odx7312kWDltyY6jkjpxO
         brxR9LCfdiYfC3zMMTV/Y8/wpI8cxoeC9fWXNA7ipeYbEkMvuY+0RFILEHnzpWfIRPSo
         ZjAkGHZjU75mWBkRFC7wzhFs6IKsKEqIrS38CfKCbD7QWtQOVxgiFTtYBwSA7fJOGzax
         +0ig==
X-Gm-Message-State: AC+VfDx4NTmt808am03eB6USZf9ReicBPdf878aPbD4vfLblYBC+9GKK
        RyRqNY1DUG85Ytzmd5d+trAGfy4j5YvPvQ==
X-Google-Smtp-Source: ACHHUZ6byYbG+k3IA7Gfvol3belUYz21UsKU/RNXKwVHEI0TnreteEaEmhTr0DoWp7S3gwRsfkKrMq+PoyYaoA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:90b:e82:b0:256:4689:e358 with SMTP id
 fv2-20020a17090b0e8200b002564689e358mr153207pjb.1.1685726425200; Fri, 02 Jun
 2023 10:20:25 -0700 (PDT)
Date:   Fri, 02 Jun 2023 10:20:23 -0700
In-Reply-To: <20230602000841.434702-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20230602000841.434702-1-jonathantanmy@google.com>
Message-ID: <kl6lsfb9zsq0.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 14/14] config: pass source to config_parser_event_fn_t
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Emily Shaffer <nasamuffin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Thanks for this series. Overall I had some minor comments, but things
> look good overall.

Thank you so much. I appreciate the thorough effort and all of the
suggestions.
