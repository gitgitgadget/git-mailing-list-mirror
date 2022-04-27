Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D5EC4332F
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 16:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242647AbiD0QU2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 12:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242915AbiD0QS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 12:18:58 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBE27C276
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 09:14:36 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e24so3187053wrc.9
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 09:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+4FIH2z+sdtq1L9irLeh1OY9QRdBn9uKGTpWKpIDQIc=;
        b=MkH+g8xez1zw7qeQpc0YRDW/9mFTvejpUsCOoySKDF9WkA6Vr3cPXbeUmqORjMB3Jp
         oO8cGlZeQgjC+d6rJSwW5Y9101DoaHPfc43Qu/I0yDRWWt4lJXw8MMnAUtQqxD9BP3/n
         ql1+Tv/6+suKN3UvweGco5CyoEButVuBwnrYSEULASKSLfaULK7dphAlxFiAFluPfosT
         Ii+TFXfcRJzu0lYxILORlfF+l6/FISlYlcTmZaGYuPVmuYYqTfjyW3JIehjTM10VGWOM
         mv7jHxlU3Y+18ldqKv01DJDC+mBa3uMRncL4/+iT4kXmWeJic6e5q74L5XybSOM0q76e
         2CUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+4FIH2z+sdtq1L9irLeh1OY9QRdBn9uKGTpWKpIDQIc=;
        b=ro9W2Y10N1g3Kykh9ZDip+dlAl/Sws8wjdpfm5XQKIDv7739r//JSS5fQaT9WolAPa
         vsaLfqOPiWy2c9ZiVRToJWf7ydvkxcR+vyvg8f05Ay9NinRMe0dM8iBuBu7bBDdRaayz
         qY283CQiROeWXCK4yqttz5Kr4tEK9OXFEWhBqqgWW3+A34n+qKY+3CnvyjEEjetE8YEs
         UR8xZAdV7wuAYey24MA0tTNhjJpuvl3ipjkJMcueGp+FDIFc+GkVT/1eOcgfNRh7GKjX
         kqP3c6q0ciHb/IA1fFxQKvG+QZjWzUE1kRpQefBdKFJZDNQRf5R26UBJPNGR+GPMyEEQ
         36hA==
X-Gm-Message-State: AOAM531DEfVNIsM3bc9DMjYjuny8eGqF3ojz2s294FHa9NoS2UL9mDj9
        agWKZCHUO0daTDXyTf/ZXXQ=
X-Google-Smtp-Source: ABdhPJx5ptxHdpplhckMzYTrLhsHpiqw3FS2k0dW+Nie3Vv8pTBB7fpiwPkNwBox6TIxKtC2CcVWdQ==
X-Received: by 2002:a05:6000:144e:b0:20a:83f0:46d with SMTP id v14-20020a056000144e00b0020a83f0046dmr24064785wrx.32.1651076068638;
        Wed, 27 Apr 2022 09:14:28 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id bi26-20020a05600c3d9a00b0038ed39dbf00sm1812697wmb.0.2022.04.27.09.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 09:14:28 -0700 (PDT)
Message-ID: <b0a80f47-f441-fc6e-3695-58ea83dea2b8@gmail.com>
Date:   Wed, 27 Apr 2022 17:14:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] git-compat-util: avoid failing dir ownership checks if
 running privileged
Content-Language: en-US
To:     Carlo Arenas <carenas@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, philipoakley@iee.email, me@ttaylorr.com,
        guy.j@maurel.de, szeder.dev@gmail.com, johannes.Schindelin@gmx.de,
        gitster@pobox.com, derrickstolee@github.com,
        Randall Becker <rsbecker@nexbridge.com>
References: <20220426183105.99779-1-carenas@gmail.com>
 <20220427000522.15637-1-carenas@gmail.com>
 <6522673b-494a-951c-be5e-3ca01577c12b@gmail.com>
 <fcd26e80-daee-2d66-cbdc-b004c478357d@gmail.com>
 <CAPUEspiHWTTAvNyqqLzcC854UccH=bkPLPBzPaPfzFKn_yt4aA@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAPUEspiHWTTAvNyqqLzcC854UccH=bkPLPBzPaPfzFKn_yt4aA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/04/2022 16:58, Carlo Arenas wrote:
> On Wed, Apr 27, 2022 at 5:30 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> You are ignoring any errors when parsing the environment variable - that
>> is not a good idea in a security check.
> 
> which errors are you concerned about?, if anything in this code

I was confused by the fact that the helper function returns a 
success/failure value which we ignore. However euid is not overwritten 
if strtol fails so it is safe I think.

> worries me from a security point of view is the fact that we are
> relying in getenv not being racy (as mentioned in the original RFC),
> but there are no errors set there AFAIK.
> 
> not ignoring errno in strtol is an option, but as mentioned before I
> decided instead to reject bogus values and therefore not the clobber a
> previous errno,

strtol() will set errno if there is a range error ignoring it does not 
change that. In any case is_path_owned_by_current_uid() already clobbers 
errno if stat() fails.

Best Wishes

Phillip

> since I was using strtol as a wider version of atoi.


> Carlo

