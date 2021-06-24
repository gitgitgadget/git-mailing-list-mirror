Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F965C48BDF
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 04:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08E97613CC
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 04:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhFXEJ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 00:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhFXEJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 00:09:26 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015FCC061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 21:07:08 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t19-20020a17090ae513b029016f66a73701so5064352pjy.3
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 21:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bAs2waycnHiCpzY2rtRTshYA1opmKBpEGjOD/AcWiJQ=;
        b=MNpxYpz8XpN6nijf2gsYXcCHBoutVU4zjb9PhAEYsYBaGWB0184BIncd+gOh/EOdxo
         IbHZnonVxkhHPdVUOQTytzZclviXmDVyFkhfPMh96zYTReS9EaY6tHuuAEt7X69Ow0th
         PyzJRqIRQZ6MJtea2Ay5jtXpAZufgd7vfCXZ8bRdRe8uJm8hHQJ/7O81axCB0HOlDair
         F6Rsyqo8gIIXVUYa8r1z7LbVHa9sK7Cq3gOTVhm9lcnDcfKHiZwBTOeufZfG9/mTJ/S4
         +WMgbk90sjLh/+bSr3OUS1XxZfytmk5cFkOpkLY01Lr8uHV3rBjFysCiotBdZbDj+XCs
         //EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bAs2waycnHiCpzY2rtRTshYA1opmKBpEGjOD/AcWiJQ=;
        b=mJuH3A/OzlMjmcOp6UxjsNtoD+z7KjBZpwii7C+auobjvhmDkRpbFmql+DV8J74gK6
         5EPSapO7JihmoZHLQapuu3HBkMkaqbGVqq9p9ryR6V97qOIRX0qNgYmzNlAQXMqWTIu4
         s+wqRfMU3v4EWK870naN4NSScm9g6HImxv1Ytsu6vYhCbwbReHnmdLeFgOEODMHUWk42
         TH+DKzHq44YFbuxfqEA14IugVAtAIetlkyU3vZYe5DMZM6BaQ3+no9vpOiYBMEVxUjuf
         9RpkIlkq9h1UDKnpDs1eZPdCRhjlu+xWAM0+/jal1OWAM0MTpnT4+bb642eVrDfwFcbt
         EeGw==
X-Gm-Message-State: AOAM531Gjd/79xjyr+8n/Tv6uwC/kj9c6gZPLLulvkUyM8hiIS2xqW3r
        b3yUbny8ggEDr9m+SEIekHk=
X-Google-Smtp-Source: ABdhPJwUjSDjkKlOxU4lKbV5LLaj5xS2ty56YqerjVzPYt1xFn2sN1dbH57XQjcST6kkrKI7xIx94A==
X-Received: by 2002:a17:90a:8a95:: with SMTP id x21mr3167738pjn.154.1624507627569;
        Wed, 23 Jun 2021 21:07:07 -0700 (PDT)
Received: from [192.168.43.80] (subs09a-223-255-225-70.three.co.id. [223.255.225.70])
        by smtp.gmail.com with ESMTPSA id k19sm916761pji.32.2021.06.23.21.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 21:07:07 -0700 (PDT)
Subject: Re: [PATCH v4 11/14] [GSOC] cat-file: change batch_objects parameter
 name
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.980.v3.git.1624086181.gitgitgadget@gmail.com>
 <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
 <069aa203666a4701e22078e9bc35a8c1ff4d5f15.1624332055.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <88fc452c-77be-cfaa-0587-ed752049674b@gmail.com>
Date:   Thu, 24 Jun 2021 11:07:02 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <069aa203666a4701e22078e9bc35a8c1ff4d5f15.1624332055.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/06/21 10.20, ZheNing Hu via GitGitGadget wrote:
> From: ZheNing Hu <adlternative@gmail.com>
> 
> Since cat-file reuses ref-filter logic later will add the
> formal parameter "const struct option *options" to
> batch_objects(), the two synonymous parameters of "opt"
> and "options" may confuse readers, so change batch_options
> parameter of batch_objects() from "opt" to "batch".
> 

Better say "Because later cat-file reuses ref-filter logic that will add 
parameter ... ".

-- 
An old man doll... just what I always wanted! - Clara
