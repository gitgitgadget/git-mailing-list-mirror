Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4790DC432BE
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 05:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0846C60F25
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 05:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbhH1FXt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Aug 2021 01:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbhH1FXs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Aug 2021 01:23:48 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B735CC0613D9
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 22:22:58 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id fz10so6087442pjb.0
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 22:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mIdpiz0vCcZLg78K6Uvew/9WS9CmK7NT5JMxh164LFk=;
        b=YhPGyfj5HMsdKZDO/BzNxvdQUt+UbdI3pRiqc3zrP3vi6cWuf5eJ9IGLKol3IPdoo4
         TffQf67oETrwxex9ol4H1lqghFJXD+qd0XXLZy88DkT62nT9W+O0emtIADmjmfErAm79
         es2sjkOGRZkw/vwAqy+KoT4wAqaYcFqm4rGmc/5L00cD1uLFkczFAsj9qw4D3dvMAdJX
         VrNu/+L7VgI8PCgJchHi/kTPBorvwYMRxZPaOYOsAsq7aCiMf6A1/OE1GBkjNaW8KbCA
         JWiNW6gTvnymp3K4AN9/6AvgKKIPdeANuSCODMUWmWU0UnrIcZBe5aTYsoZXcozcqBjZ
         mRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mIdpiz0vCcZLg78K6Uvew/9WS9CmK7NT5JMxh164LFk=;
        b=PFyje0EpFwKICWoSWE/sL8Pxpojv3wFrHDPOihcrwxt1D7Z0fXPAkKUB3anP/S6SdA
         Azt+ixviO8h3CGaSZC9yu5tudnnaKZH9LWbpvMG414zqq5QNBdFtcmGEw1Q10Pgv/82F
         oY1LwnJU+65YP+G+f/9sefxX4787/3PdFEsSQjCdeWBsan3qsvftQQ3KvndhaPY+/drW
         iDxzHz6moBKyAPWVFIOOG/KN/5dr6Vh2nxgwC1mHsAh3LPsy7OQTER+3FJYVozPh/jaY
         KUI8I7xqEkHm4M1r+78k9I3q/7w8XhzMYNI1M8isoQrqP2GNcBXH5uqwmDPIcXGMCZvf
         cVLw==
X-Gm-Message-State: AOAM5306nw0vOCZpAZjpYOQm0N58NbD9P5WIYdQnNQSunkmQf4IXZGl6
        QjtdxKHznZPYvhxbLRHFEm/kv6GF/wO1QA==
X-Google-Smtp-Source: ABdhPJxS5wQYA95wi3P/POI6b0hDTKcrrIFLbqndoJzBTy8wWYMVAdqGf1Rd54nvRJVgbtVeJCY4Mw==
X-Received: by 2002:a17:90a:1b2a:: with SMTP id q39mr14430658pjq.219.1630128178029;
        Fri, 27 Aug 2021 22:22:58 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-10.three.co.id. [180.214.232.10])
        by smtp.gmail.com with ESMTPSA id y8sm8434625pfe.162.2021.08.27.22.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 22:22:57 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] send-email docs: add format-patch options
To:     Thiago Perrotta <tbperrotta@gmail.com>, gitster@pobox.com
Cc:     git@vger.kernel.org
References: <xmqqmtpbub07.fsf@gitster.g>
 <20210828030839.2989-4-tbperrotta@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <f54fdc77-e87a-75cd-dffa-719e30067495@gmail.com>
Date:   Sat, 28 Aug 2021 12:22:52 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210828030839.2989-4-tbperrotta@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/08/21 10.08, Thiago Perrotta wrote:
> @@ -19,7 +20,8 @@ Takes the patches given on the command line and emails them out.
>   Patches can be specified as files, directories (which will send all
>   files in the directory), or directly as a revision list.  In the
>   last case, any format accepted by linkgit:git-format-patch[1] can
> -be passed to git send-email.
> +be passed to git send-email, and options understood by
> +linkgit:git-format-patch[1] can be passed.

Better say "..., as well as options understood by 
linkgit:git-format-patch[1].".

-- 
An old man doll... just what I always wanted! - Clara
