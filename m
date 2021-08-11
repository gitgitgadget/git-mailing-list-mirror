Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72197C432BE
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 06:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5528860FC0
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 06:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbhHKGp2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 02:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbhHKGp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 02:45:28 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D092C061765
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 23:45:05 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id nt11so1884807pjb.2
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 23:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=47RyfJYXTkuPc2ucw6XqyxdQbbHxF+BWIm+CO2L0+VY=;
        b=qGyVMX7BldoOkaiopOOQUnXeC4O3gs1e1/BxPuAOvGEHaU/ihNr6zxW8C6432UfNGB
         Su5hgHCi7OGMTBajMZMCDWPayrfvab8zbt2NHp44T5pv2SPGRn2Hs3OqXsHsR8c+gXiq
         eFppAqVEcNDGSECiALURC7aBAh/9BImUFbSzu5B7lbLyePtXFslQ1d/x7lDCGHAhyD/Y
         K4iWZrkGFSk73UOYtvogk1vf37nLJzUmcs7MfON/9cSVJR20VgaKEl1AULFHLU6upkFT
         +lPxmSICU2QAN5H7I++v7sp4UX2WvCkvMjtYO8WSsTKpjWPl1h2RJos11tMLSms+zGWb
         FitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=47RyfJYXTkuPc2ucw6XqyxdQbbHxF+BWIm+CO2L0+VY=;
        b=sslzyUlexh2syy6jRkJPeb74ua0eBhSGxdF8gYEFCleG56G71Mpj4iwtNsn9eRlfC/
         9VBN5d2b0DJOiSy1rlREP3i0OwoJ28I/NJ05w00hp7z7crt9vjJ14WxJTxUDluWZNIRJ
         nMGgKWEVWyxoqzYLmXwOyZ+t92b4vqfaUs9is/kp4a8BlpIsQOnRBa7kflGGNWOW2mox
         OiT5K6O+VOHSOMo/r4YYcfvkXWi0HF4CYVHZqhckAdb4rNejccSJfd+l+6/F0reuevP2
         gykbCs4iebRxNDARHdR6Ic0odMkTo7/40VeuWDKIgOnZXJiSYthhSodV73CKPADHUARX
         eOww==
X-Gm-Message-State: AOAM531jPJ8R4wwmBGFw+M3T7V3oTYtliIn3neZJfmv39pZgzuPFo7tA
        34OcWXcUEVf6if0f+OLG1oQ=
X-Google-Smtp-Source: ABdhPJxHcAtGN1XFGfrTurv43zzOyTU5ngBjdsVDlzd4y6QNEBq3q9C/mcUC7sDp+/D0lXFJQ5VIcw==
X-Received: by 2002:aa7:8e56:0:b029:3cd:c2ec:6c1c with SMTP id d22-20020aa78e560000b02903cdc2ec6c1cmr7832200pfr.80.1628664304634;
        Tue, 10 Aug 2021 23:45:04 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-23.three.co.id. [180.214.233.23])
        by smtp.gmail.com with ESMTPSA id q21sm29729416pgk.71.2021.08.10.23.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 23:45:04 -0700 (PDT)
Subject: Re: [GSoC] [PATCH v5 1/9] submodule--helper: add options for
 compute_submodule_clone_url()
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
References: <20210807071613.99610-1-raykar.ath@gmail.com>
 <20210810114641.27188-1-raykar.ath@gmail.com>
 <20210810114641.27188-2-raykar.ath@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <21917b01-94f7-2698-b904-2d75f37af447@gmail.com>
Date:   Wed, 11 Aug 2021 13:44:59 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210810114641.27188-2-raykar.ath@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/08/21 18.46, Atharva Raykar wrote:
>   	if (git_config_get_string(remotesb.buf, &remoteurl)) {
> -		warning(_("could not look up configuration '%s'. Assuming this repository is its own authoritative upstream."), remotesb.buf);
> +		if (!quiet)
> +			warning(_("could not look up configuration '%s'. "
> +				  "Assuming this repository is its own "
> +				  "authoritative upstream."),
> +				remotesb.buf);
>   		remoteurl = xgetcwd();
>   	}

Why did you split warning message? We could keep that in one line.

-- 
An old man doll... just what I always wanted! - Clara
