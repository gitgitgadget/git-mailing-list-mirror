Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A0691F406
	for <e@80x24.org>; Fri, 11 May 2018 22:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751698AbeEKWm6 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 11 May 2018 18:42:58 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:43563 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeEKWm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 18:42:57 -0400
Received: by mail-qk0-f170.google.com with SMTP id h19-v6so5629699qkj.10
        for <git@vger.kernel.org>; Fri, 11 May 2018 15:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zzHm8uvZl45zblLN3UdBr3I2aCqJzIYrR6a7uhtvxK4=;
        b=hI6WgUyDETaPw9MR56e2bRNbQrumZa8/dHjU5Xbn/EWEKZ31zEnLnD7Zb7BwwuS6FC
         sPh+jm8IZao619gmwWH1N+CanSipQ0egaan6qYN5/0s/AHsTVJBcUF4qlI4n8VW2lMbB
         PRS19iEubTFwGmXaaZWY0lNUje/gP1A6QhhmvwJ2w3o+wlPaRDF+32cnNNO3aEJa02EA
         MWbAsflw4lkvYYzdHcqrOucTyCvqRZBWUPJ1tR8PIowAJqlWQU2l9nsC03M3BJxAL0zE
         l9m0dGhQxHLItIJFlSgT0GtXBp2J71kbjEG6E1ahgBg0SgPnoNqA94DfOPYM4/WK/lgL
         QLGA==
X-Gm-Message-State: ALKqPwe5hpuaLhb75thzFWtpF0nM6ZB3sXe0l0PcuOFBUMhh1wn9L9mo
        xbJ1KXZDGLMbETzNgDbs1okxhmXfTbrXbUKY+xw=
X-Google-Smtp-Source: AB8JxZrl/miIblIgqcCz7RkmdanS/DTAJh6CivfNu2ViQNlAdKSAUuRkDgiwBpAVjknz/LgJRb0+OjFDghoHiJKOuRY=
X-Received: by 2002:a37:6c02:: with SMTP id h2-v6mr6478073qkc.145.1526078576958;
 Fri, 11 May 2018 15:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180510141927.23590-1-pclouds@gmail.com> <20180510141927.23590-7-pclouds@gmail.com>
In-Reply-To: <20180510141927.23590-7-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 11 May 2018 18:42:46 -0400
Message-ID: <CAPig+cSE_efq71V5ZskORgX5teP5FmUBYB49EdVrveSU8qxnVg@mail.gmail.com>
Subject: Re: [PATCH 6/9] am: move advice.amWorkDir parsing back to advice.c
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 10, 2018 at 10:19 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
wrote:
> The only benefit from this move (apart from cleaner code) is that
> advice.amWorkDir should now show up in `git help --config`. There
> should be no regression since advice config is always read by the
> git_default_config().

> While at there, use advise() like other code. We now get "hint: "
> prefix and the output is stderr instead of stdout (which is also the
> reason for the test update because stderr is checked in a following
> test and the extra advice can fail it).

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
> diff --git a/builtin/am.c b/builtin/am.c
> @@ -1827,15 +1827,12 @@ static void am_run(struct am_state *state, int
resume)
>                  if (apply_status) {
> -                       int advice_amworkdir = 1;


Nit: Maybe also delete the blank line following the removed declaration...

>                          printf_ln(_("Patch failed at %s %.*s"),
msgnum(state),
>                                  linelen(state->msg), state->msg);
