Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332FFC433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 04:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 097EB60D42
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 04:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhIMEic (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 00:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhIMEib (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 00:38:31 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A415C061574
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 21:37:16 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id n30so4938076pfq.5
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 21:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H9eqbn6qdYuxP6OgQ/3y/nJnv8/R3Qure+Yn79jN23g=;
        b=Na51tpdiaR1QuUzEtMuYieh38RMupxydefV8Lo8DWat6K8Ooj1LhFmdmLUqTpIooF5
         nF9EAaJQ+PlW/0mqWPjMdLEr8PJtLkuaTwFuoIL1UPttNhjQSeaARyjexiLzECmI6gPE
         OLbjvPoAFV61cY23VOB4V1AlgTPYySCLtSTsAypnXLsQrRoi9aLHKeqT24oLgWdINpOV
         uNio7F7gR6akN0wVOBoJqUZstJmOvPuL3oA/KNNEc8DKqKXQlrg4D5aZnlieIf91+6er
         xRGLYKwX+nk4Blq3g5UeaK+DaYmBUIDwTLaDJ9gLk9mrfc3Dykr7Ay0AsGjvT2fYxBmt
         lUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H9eqbn6qdYuxP6OgQ/3y/nJnv8/R3Qure+Yn79jN23g=;
        b=Dr29SBW3YKOmwZZD/FJeOB9iyK1vB2nf7hy8S2Y4Mc69mHdTl1sxmczkQKI6+UeAqx
         dlOeZ8/dfXBiDBk53cVF0A7g7e6lp7za0gsT79PcFDWBz0fBhdvxs8j0byrIXXYteBWI
         1B3SRU0i33kUnoEGg7eMWwG0qG35PEJeH427icKUtp1v9wMa5UuAT1ypFk3oWzco4TuL
         px+xRGpUMKKYlqzgfMxJ6T0pTHWhzgWYN0cbk45mPA3rFebhlWV8Q4450/AA4IciFFFz
         KvFUGYH+Bf6E6YHFUj/h5jsRmslfT3/7Ec8eNQptU4CETaeH6k/eydIKGlzAfyrDdpcC
         WeEg==
X-Gm-Message-State: AOAM531RtGQpgd8WaY4t8RXNFDa8cMpJmabq7r7p5QjcFG8GeLxSeF95
        KhdX+qzSlJ4/+5YpYA1EjvfzAtbjRgouGw==
X-Google-Smtp-Source: ABdhPJx4VoXlvIcgRrk/qBX4bbysQekuA5VRyqjmelXsFN8Gs5buzdR8c4gBPDfcnJPnDP5Rs8Mp1Q==
X-Received: by 2002:a63:3587:: with SMTP id c129mr9553513pga.127.1631507835667;
        Sun, 12 Sep 2021 21:37:15 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-18.three.co.id. [116.206.28.18])
        by smtp.gmail.com with ESMTPSA id k3sm4985439pjg.43.2021.09.12.21.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Sep 2021 21:37:15 -0700 (PDT)
Subject: Re: git tag -h fatal error with global tag.sort config
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Git Users <git@vger.kernel.org>, Jakub Wilk <jwilk@jwilk.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <0daf6907-b472-a756-1240-4c78f8f4d37e@gmail.com>
 <20210912132757.GC76263@szeder.dev>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <f6673745-a6da-60b5-0782-349b6b76608b@gmail.com>
Date:   Mon, 13 Sep 2021 11:37:11 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210912132757.GC76263@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/09/21 20.27, SZEDER Gábor wrote:
> Now, 'git branch' uses the same ref-filter sorting, but the equivalent
> 'git -c branch.sort=creatordate branch -h' command does show the usage
> as expected.  The relevant difference between cmd_branch() and
> cmd_tag() is that the former special-cases the '-h' option as well
> just before it would call git_config().  Doing the same in cmd_tag()
> like in the patch below seems to fix this issue, but I'm not sure that
> this is the right fix.

Also note: specifying the config above as local config (in .git/config) 
doesn't trigger the error.

-- 
An old man doll... just what I always wanted! - Clara
