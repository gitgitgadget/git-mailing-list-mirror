Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D79AC4708F
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 03:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26CF66120F
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 03:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhFDDrv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 23:47:51 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:40809 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhFDDrv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 23:47:51 -0400
Received: by mail-oi1-f169.google.com with SMTP id f30so7194557oij.7
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 20:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=LeVGqQzp5nPLl414AeRnZ7MZVljz6R5VkO1wcTw9fZw=;
        b=lt5VVrxmcuZvM6S0PDrS39pcW7Xl3a5fc1wraUl45mxlu+MMnbXL6GB3L7XIA6TIgk
         haHEbNVea3eyuxIf3lvoYqza9m4hLjCzFobBbWCiPakasbHQFIiAjRU2fTLBaLa3ZtqY
         W6xEA4oiGA/KLbNeU6d3b/olnNowoVkk5jUwVvheO9VyZFN6QmB1blhAnrXKSkL4e9pA
         gWtYKc0zvAuoAXXh7zmF4raD8+II1fufopKJ/2fXN6SKZ9hWnFcximdTFtl6dl4uAAfX
         CPV6Zy3C7STsyj1bBqdYHuEzEZdiWMONlF2ZtwsOpx1bcGEI1uRiNmglibCCvt0fJUE4
         fV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=LeVGqQzp5nPLl414AeRnZ7MZVljz6R5VkO1wcTw9fZw=;
        b=fTmnDUyrCumFxPl4gCIqbFP3czSI50PODgw+hAv7ZFHdnTzu2HeHETsEQN6Y2IyKWu
         9dj9qOVnOec43CmpQuRAUwbbLoYAOOqRt6u4o5O/jjhZr+hkYVDoElhTIbQOmnzo9pLQ
         PS+zQVLEFswTCGKFiU9aGFugzx2nVFJvkjsz8EV9RfDS86AlLngiy4vqHjq+MjOX6ccg
         9WJoyO/G2sbdC1TFIkOVYw23Mtv5Nl0Nf40Wo+wMwOX7Yn1GLKa8zF56ybboYAmj/+Y/
         QeJ41zhOZ6UcXJsXxne4AqHhwMBMpt3ZSsNjIMjwXftI/caFeLGMXpBUyOEDAPtZP2he
         0GFw==
X-Gm-Message-State: AOAM532ZltM13TkKaY90cKolS6FYn0a7HmzSgLEsAACH/Zv15OhezgJA
        V5Ps6i4/ZuWR7pfNY+gMYo4=
X-Google-Smtp-Source: ABdhPJzjsUXc+dtPhU/NLB2RYDNofrXtcrWd48xTwC4yp5Ednq9mU2DFPg54mWyqyspT2MT8DP3PSg==
X-Received: by 2002:a54:4602:: with SMTP id p2mr1734143oip.3.1622778292464;
        Thu, 03 Jun 2021 20:44:52 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id m66sm223501oia.28.2021.06.03.20.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 20:44:52 -0700 (PDT)
Date:   Thu, 03 Jun 2021 22:44:50 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Git <git@vger.kernel.org>
Message-ID: <60b9a1b2e402b_3a3b7e20899@natae.notmuch>
In-Reply-To: <YLmSd7ADvhdh33/O@google.com>
References: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com>
 <YLhx7nIptHUwXfBD@google.com>
 <878s3r73g3.fsf@evledraar.gmail.com>
 <YLmGo8PZDAT90hj+@google.com>
 <YLmSd7ADvhdh33/O@google.com>
Subject: Re: Gmail OAuth2 in git send-email
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:
> Jonathan Nieder wrote:

> >                                                      That would be
> > helpful to other programs that want to send email as well, and it
> > would help users who are not as patient as we are in trudging through
> > the multi-step process required.  For example, it's nice that KMail,
> > Apple's Mail.app, and so on have their own API keys instead of every
> > user of those programs having to generate their own.
> 
> There's a sendgmail tool in
> https://github.com/google/gmail-oauth2-tools.  It requires generating
> your own API key but I suppose someone could package it up with an API
> key for their package if they wish to.

API keys and client secrets are supposed to be *secret*. You must not
generate *public* packages with them.

I don't know why people insist on using something that isn't supposed to
be used.

If you want to use a 2FA-enabled account with git, then generate an app
password, and use that.

Cheers.

-- 
Felipe Contreras
