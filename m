Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C5A820248
	for <e@80x24.org>; Tue,  2 Apr 2019 05:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfDBFm1 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 2 Apr 2019 01:42:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32861 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfDBFm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 01:42:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so14875596wrp.0
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 22:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yXVZxFsktGBWmgOf9ikSvnIvHaTneb7MboZ32nW9kDY=;
        b=I2K1XOKlal8Uu2sPGBdpYbVP7exaHxFB1lSMixNZs1tLD9qRkvnS+dzptNTQ80PaDB
         Z0XRMUi9cuUuaJOT52BwVtqQdVyBGaTFFwLYlTDZwQFADDLMQmf59+5696CaYyVxyCWY
         OqSq1JeBzJRmOYDdZf8u6Be8yxnMwEKeiSfq08dL5b6oRKZXvYLIknW+EdWWdVYjQV7a
         Mkv7qgAa++PQYPl9QUVn7utVPiGMeKGnOvEZFHaP/LCX5oV+K1vWwQmej1LtBO+Av6wG
         q3Fy3ZI6VNx5/kpxlkx69hHF3LIp+BQ68iMMexeuPOAClhoToNF6V/l01P6LfH4c3kJJ
         QP3Q==
X-Gm-Message-State: APjAAAXNPsNFJCcR9QCC4V/u83bzQdQy9bkrNMD6/AlSKGANhWgdlmBh
        hHWaftu2XN679s5S5ZZ73R7y1R7CXk0586fFmeU=
X-Google-Smtp-Source: APXvYqzR9LOFcL1ip13QyvVVLnQASniBalqY6bAfvzLMVHL/8sJDsHtynbnjhu6erVztq7J55ofz0WwQnOSdO4c/8fo=
X-Received: by 2002:adf:d848:: with SMTP id k8mr47615490wrl.185.1554183745190;
 Mon, 01 Apr 2019 22:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190325103844.26749-1-szeder.dev@gmail.com> <20190401115217.3423-1-szeder.dev@gmail.com>
 <20190401115217.3423-2-szeder.dev@gmail.com>
In-Reply-To: <20190401115217.3423-2-szeder.dev@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 2 Apr 2019 01:42:12 -0400
Message-ID: <CAPig+cSF8A0-rSM3q1AvpE7xjkFcrMEBdsGTe+qkd2rU_uxcEg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] progress: make display_progress() return void
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Luke Mewburn <luke@mewburn.net>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 1, 2019 at 7:52 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> [...]
> Let's make display_progress() return void, too.
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
> diff --git a/progress.c b/progress.c
> @@ -78,12 +78,12 @@ static int is_foreground_fd(int fd)
> -static int display(struct progress *progress, uint64_t n, const char *done)
> +static void display(struct progress *progress, uint64_t n, const char *done)
>  {
>         if (progress->delay && (!progress_update || --progress->delay))
> -               return 0;
> +               return;

This 'return' needs to stay, but...

> @@ -100,7 +100,7 @@ static int display(struct progress *progress, uint64_t n, const char *done)
>                         progress_update = 0;
> -                       return 1;
> +                       return;
>                 }
>         } else if (progress_update) {
> @@ -109,10 +109,10 @@ static int display(struct progress *progress, uint64_t n, const char *done)
>                 progress_update = 0;
> -               return 1;
> +               return;
>         }
>
> -       return 0;
> +       return;
>  }

... these three 'returns' can all go away. (In fact, the first two
mysteriously disappear in patch 2/4.)
