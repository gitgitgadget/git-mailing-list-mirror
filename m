Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F23C433F5
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 06:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD13D60EC0
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 06:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239389AbhIFGQm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 02:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239281AbhIFGQl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 02:16:41 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8350CC061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 23:15:37 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g14so4832347pfm.1
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 23:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GyTL9EwIOanZyrlYii7C++wdFBrmiM73Hs570ntEavQ=;
        b=GWMP6+NuoX/kzQb6MWOmw6c7N8kwSZxCtSw+lq9AKuzf9VgrLb7gykeCWAy0P9FqXQ
         /q9EjqtyisBNyj3Wx/qm7iJSY3KFUwbltMRhq2LxHXucvtOJfFh93URRD1jHiOj7L3mt
         GTRvIGz+7ysf+DPqVYCWsSzpsnVCoHPjOmn2J1K2z3q5Ds6W+U7ehEsTGht0TJkvQ97X
         gSsJ7DYemlfhyb+lqTvHMpuIm8SzM4xxCbJY/0UKRgOHb3jWPKIR62rB/jkK2vxfivQ5
         ecRNANG5FMiqp+ELyVHcmnFrTJVuWVLh6xX1wd/B0oc7GWGr3gULMe2AJ2JhRHaKl8p3
         E+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GyTL9EwIOanZyrlYii7C++wdFBrmiM73Hs570ntEavQ=;
        b=SLY+uTvNrEkkonaeIoU4F6o1KjOMlS7Kt/yJ0hrRu/tv5J0kvTkF+yCxf7G8+ucTIm
         LCkLJ1HMy9ifh9RT9cXHB4r5lZ2WDGJvawZlreZ42CLMGEeAyQXJm0oSdk6mHrogwwm4
         qPzf3k4l7XCT7F+fScPauVwQNPeWnoMCmjrNs5giDaC8YZyLfP4CdyMG2ZzW62T1xMXo
         OocFOjpSeK7hMjmhkwD6btej1Levxu5Q01P66fSFEMz2MBRiDEhseS+G5amVBzgM1TcO
         tLI9I+WrloLVYLStWLnQrM7puyCFPbDZ2FCRCylPZaYB6ldWu4Rj1C8vQcvRzxmfTvHB
         QDNg==
X-Gm-Message-State: AOAM530spFx/ulyfPlziRlJxjCFoY3vzwROcEnI/L72Z6aI+X/17WcOP
        hZ8xznaYmiWy/ZCYpbarnUA=
X-Google-Smtp-Source: ABdhPJzdqcvbywBpxpvCi+iuwI83jICkrxwsYcHe2xNbJWe1RHZMaUmgXUFOmFKbWunC17Lrtf58Mw==
X-Received: by 2002:a63:7455:: with SMTP id e21mr9772051pgn.188.1630908936947;
        Sun, 05 Sep 2021 23:15:36 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-68.three.co.id. [180.214.233.68])
        by smtp.gmail.com with ESMTPSA id j1sm6226713pjz.36.2021.09.05.23.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Sep 2021 23:15:36 -0700 (PDT)
Subject: Re: [PATCH 2/4] Makefile for list-object-filter extensions
To:     Andrew Olsen via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Andrew Olsen <andrew232@gmail.com>,
        Andrew Olsen <andrew.olsen@koordinates.com>
References: <pull.1031.git.1630885899.gitgitgadget@gmail.com>
 <43415de761ac029b67645d9131b38e761ef6ae21.1630885899.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <20713339-ba53-38e2-b20c-befe68dc147e@gmail.com>
Date:   Mon, 6 Sep 2021 13:15:29 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <43415de761ac029b67645d9131b38e761ef6ae21.1630885899.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/09/21 06.51, Andrew Olsen via GitGitGadget wrote:
> From: Andrew Olsen <andrew.olsen@koordinates.com>
> 
> Custom list-object-filter extensions can be compiled into Git using the
> FILTER_EXTENSIONS Makefile argument.
> 

This can be squashed to previous patch.

-- 
An old man doll... just what I always wanted! - Clara
