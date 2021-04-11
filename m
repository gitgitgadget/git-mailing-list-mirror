Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C821CC433ED
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 14:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E51E610CA
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 14:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbhDKOLg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 10:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbhDKOLf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 10:11:35 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55719C061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 07:11:19 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id sd23so7288061ejb.12
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 07:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=98nHJTc/V5Le2/JK0fd939e5TrGakVbwsI164Iaugog=;
        b=O2Ng7rFVthjdTngSxz6Z9mAHAH2m2c2eLZMqrEXa4cHIvE6KznwKrqJqWrQHtgf5vA
         WP8N5UeEKrY7v4msN6Z9QTRR2VLlbt4LyLaA5Ny7iydepyZxgoOGTW/jMumSaP1cFpER
         FUZp5u3JMRiXuQQntLFzZTRT3tIhhvaBLRDlD6PiG14N5MRA1PRfi9lS1acFqOVIkT3h
         At3vhoe2aSGvP606Z+JQzhqkwgL+g8VkdhEEBHCNpDF/cYVgZs6K0OA+uzbfV7Lhc8M8
         eo3xq8IhtzRnKyPER3b3TSMOwe8ZYAXkskjx4e2oDeKUFASGfwHCK9wYeQU+uenaUmn7
         z9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=98nHJTc/V5Le2/JK0fd939e5TrGakVbwsI164Iaugog=;
        b=kig0+ykbK07+3OHy525eVeebOdt18OQtHTIk1w0TtCwh72rsbWT3tbXfO03do20b/3
         V9SuW+vycMGFJSKTzBQE0R6K61TRpf9OlV2N98TptBcGRyToEJ6dwtm4iMaoD0nCOz4Z
         nsGYIWMDtzeaW55fPfs0+tqJnhe2u27iXHCg0kkLsiVmJZR2y7TVcTY73j2fHOWcWu1h
         Aew7X+rzm5f/N2uIHEE4qW1ITGw2WwOeFhi6eOcHeMZg6wXEAyaADWAhu12sehAV12jS
         mINOGOes3sT5NhdsX7ZeV64VspENM03iCn9/WEX0h4wdTIyvIVsFRstXLaWfyjTgS6hg
         R6/g==
X-Gm-Message-State: AOAM530jCsO5eH1R1IsnHBzI72BWRDj8dzT1bMZFUOlK78hS697d5hbT
        J+8AquS5m3KQ9Tbn1wdBRnuq+Q7PtB4=
X-Google-Smtp-Source: ABdhPJxTIZZ56qYYVCgJiuXqsUyqKmCSc1QJti7odg2ZgxhJXny/AImvoUzNtBEh75bMqaxOBS+D7Q==
X-Received: by 2002:a17:906:2988:: with SMTP id x8mr23931988eje.168.1618150277281;
        Sun, 11 Apr 2021 07:11:17 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id q8sm575079ejd.79.2021.04.11.07.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 07:11:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] git-send-email(1): improve smtp-encryption docs
References: <20210411125431.28971-1-sir@cmpwn.com>
 <20210411125431.28971-2-sir@cmpwn.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210411125431.28971-2-sir@cmpwn.com>
Date:   Sun, 11 Apr 2021 16:11:14 +0200
Message-ID: <87h7kcgbct.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 11 2021, Drew DeVault wrote:

Subject nit: 1/3 is "git-send-email(1):", the rest
"git-send-email:". I'd suggest just "send-email:", we usually omit
"git-" from the subcommand, and don't use man sections to refer to our
own software.

> This clarifies the meaning of the 'ssl' and 'tls' values for this
> option, which respectively enable SSL/TLS, i.e. a standard "modern" SSL
> approach; and STARTTLS, i.e. opportunistic in-band TLS.
>
> Signed-off-by: Drew DeVault <sir@cmpwn.com>
> ---
>  Documentation/git-send-email.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 93708aefea..c17c3b400a 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -168,8 +168,11 @@ Sending
>  	unspecified, choosing the envelope sender is left to your MTA.
>  
>  --smtp-encryption=<encryption>::
> -	Specify the encryption to use, either 'ssl' or 'tls'.  Any other
> -	value reverts to plain SMTP.  Default is the value of
> +	Specify the encryption to use, either 'ssl' or 'tls'. 'ssl' enables

Starting a sentance with a quoted lower-case word makes for hard
reading. Maybe:

    When set to 'ssl' ...

Or something? 

> +	generic SSL/TLS support and is typically used on port 465.  'tls'
> +	enables in-band STARTTLS support and is typically used on port 25 or
> +	587.  Use whichever option is recommended by your mail provider.  Any
> +	other value reverts to plain SMTP.  Default is the value of
>  	`sendemail.smtpEncryption`.
>  
>  --smtp-domain=<FQDN>::

