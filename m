Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D1BC43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 12:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F60C206F6
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 12:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTUx2OcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgC1MV7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 08:21:59 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:43685 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgC1MV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 08:21:59 -0400
Received: by mail-wr1-f49.google.com with SMTP id m11so9112405wrx.10
        for <git@vger.kernel.org>; Sat, 28 Mar 2020 05:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MfXBjadwZaTYJ4QHyzoec1QFKcoUpaEbhsthYw5GbC4=;
        b=mTUx2OcTaTYGRQa0J/Jq1aQtGB1Ku6WcOMHT/GnJciaiutEmTpXsFwjOPP5XDn48jZ
         QF1BdfuE4aBbcCWUnW1733g49XVQvUm8H8BLQqfEIUSwslwT/20vdRrBQIVZN4T0Bqsb
         3oPrcmAosdPDTCRNLAazVEBI5Y2cJ54gIlNGosW5XRqLgnsvs2qqG6IgElkv4Gbw8aCN
         x6yi8ieMNBQjN2OU/qeTYKbz/4yPCpFIEM1TnazwWuB8A7g4JyAeAJgjSgWAnEdzFV3J
         psXcYccpKvsCDViSMeRsvuczYJBBPCxaZcSqkZVmIRFGai8+boALIYUcgRSeCchvok+W
         hXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MfXBjadwZaTYJ4QHyzoec1QFKcoUpaEbhsthYw5GbC4=;
        b=b3mHL7+u9MiO91HXinPPbJPngncBRGOXeDozt+NZqQJtBgxa/MZThXteEGkn37ovDL
         ZyU3rWqMWpJUxGFoSi5LHvxXIEU1m+GU3sFWwDg1p0dz3aefAWc9Xurjy2wPXgrYp+rq
         QkCSrwzs6gYmZlwmehLR8x+hU6PYLVACQ7ZHl8U2oAjv4VQv1AwEohGpJFaGJ54BGtaI
         rLr06wJCvcM7Kg0ctgUmLcUmvFBbdTFGlWCZE9XpBeJCWZFNVyLLE1ygkUMdE38f/g1Y
         vH3s9R0HlMey4UxDA+se8afKnL33Cpn5DupM9jdJo58ElCrdh3sl2z73SgAXm6E2J6zM
         Tsow==
X-Gm-Message-State: ANhLgQ0yqBr3QtiKq6riPiNdC9oMUTeg1A0wWzvTvNpENSezFfUmSke/
        PPQKfjLloaay6/Z6+knWHyQ=
X-Google-Smtp-Source: ADFU+vswTEV0G8yeF7tWIPrDZrRIR6riSoTevspzeEXlGW5iFLCP3M4d/e54qVJUViP+GMHu0CQ+sg==
X-Received: by 2002:adf:a2d8:: with SMTP id t24mr4645301wra.366.1585398117660;
        Sat, 28 Mar 2020 05:21:57 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-654-1-428-45.w2-6.abo.wanadoo.fr. [2.6.211.45])
        by smtp.gmail.com with ESMTPSA id n124sm11563392wma.11.2020.03.28.05.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2020 05:21:57 -0700 (PDT)
Subject: Re: git rebase fast-forward fails with abbreviateCommands
To:     Elijah Newren <newren@gmail.com>
Cc:     "Jan Alexander Steffens (heftig)" <jan.steffens@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <9b4bc756764d87c9f34c11e6ec2fc6482f531805.camel@gmail.com>
 <a3cc46ca-824d-8cab-e333-83f51a7824ca@gmail.com>
 <CABPp-BEV0NxMLuM3U8fqECkEB_XHTvLMav1q_TiYveBWrpsr_w@mail.gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <4aeffccc-3a62-b92c-f6f5-0438995f676b@gmail.com>
Date:   Sat, 28 Mar 2020 13:21:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BEV0NxMLuM3U8fqECkEB_XHTvLMav1q_TiYveBWrpsr_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

Le 27/03/2020 à 19:39, Elijah Newren a écrit :

>> A third approach would be to change the meaning of an empty buffer, but
>> this would break some tests (at least t3404.3) and cause more confusion
>> for users than necessary.
> 
> Well, "error: nothing to do" probably makes sense if the user
> specifies a list of empty commands or sees a list of empty commands
> and agrees to pass these to the backend.  But I'm not sure that
> message makes sense for implicitly interactive runs as opposed to
> explicitly interactive ones.  Perhaps we could change the message to
> just be "Already up to date" if the buffer is empty and the run is not
> explicitly interactive?
> 
> 

Is this even supposed to happen in non-interactive mode?  When I try to
rebase an already up-to-date branch, rebase fails with the message
"Current branch … is up to date."

> Elijah
> 

Cheers,
Alban

