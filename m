Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DFDC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 13:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE15960249
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 13:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346096AbhIHNRI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 09:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343914AbhIHNRH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 09:17:07 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E5AC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 06:15:59 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id x5so1732351qtq.13
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 06:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+4eu1xYIA3FiXN/HQmsL11Qvap6vP7Czax866okiUBI=;
        b=CLLZx+ujRlTR64jAvL7NhQnKQoSNgXl5TS4JucFUG9WgNMcbHwm8kttbqjxJGxE3nr
         f3iMC/XCu68+TCJI1yslg93SoKb9RZ3Fxxqs+KjA2n9CnVwpQfCmltsVGBMNQNqatmaB
         nBiA3dXcFcDvdWO33HK/cZ9x7MnW2eg3vivcf+IXAuWPuPZogcHcXW9xxoSiClvOtMWO
         HVYP46oKLJGalzDK0S2FXNY+cGnexKMQ5i3s68K+I406n6KFLVNre1lTTK1kU/dT6Y1a
         l6aZ4rGGJiP0K95IK5whsQUPPTvgKZSp/lJKj+ZrcDgZWqbYfxfs/oIWmH33U2aL/BQd
         AWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+4eu1xYIA3FiXN/HQmsL11Qvap6vP7Czax866okiUBI=;
        b=CdPBLV/a5TnAIua8NfZ5cQYIjUf23Eiz41IEtuHWUyDZcka+ix96446q8KZC+eEnfW
         GJOOpRqZk+Pwqfd5Djyj2EZBqpcp5ndLN7sgdesRnVukxOmPrNhDB9lBVu+xwLmQ87EP
         UImuagnVI3AioOPS87LuWyBBLEkVBcGqe6Y4HqpC0ehoN8JKAq8WluxWbgbaHQFdSAuL
         S5nmtABxZrgaPJmkWwSRMYtrEkkz/u6TXII3/OGJmEaWgf/MqqkUEpm1g3cRPbDWj19p
         T55JXGDHVCvNqkiFOfcilee4khJok0Ji9Zr2Rs2yLAuG6uWOBTCrvTncaa1UriDiGAeD
         1AhQ==
X-Gm-Message-State: AOAM5310fSM/k0O4RxbEScdCSVNrjhhA3AIchLR6x7tqKo/lw+89GOgC
        72pTjruVzZydltME1ot9wpujyn7kXo8=
X-Google-Smtp-Source: ABdhPJxypiAQFHxBKmtVhCuteAlTiIDWCVxN1JE0cIRJp7kYnD+f+MXzbSr4Kk1y4VZbsmNiPC2UIg==
X-Received: by 2002:ac8:5845:: with SMTP id h5mr3645101qth.91.1631106958726;
        Wed, 08 Sep 2021 06:15:58 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:79fe:8f64:ef46:a881? ([2600:1700:e72:80a0:79fe:8f64:ef46:a881])
        by smtp.gmail.com with ESMTPSA id a189sm1631557qkf.114.2021.09.08.06.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 06:15:58 -0700 (PDT)
Subject: Re: [PATCH 0/3] Fix D/F issues in stash
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
References: <pull.1086.git.git.1631065426.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2109081003270.55@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c39e1b86-479f-2a07-9e9b-9da2bf1c9493@gmail.com>
Date:   Wed, 8 Sep 2021 09:15:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2109081003270.55@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/8/2021 4:04 AM, Johannes Schindelin wrote:
> Hi Elijah,
> 
> On Wed, 8 Sep 2021, Elijah Newren via GitGitGadget wrote:
> 
>> This series fixes a few D/F issues in the stash command. These were some
>> issues I found while working on unintentional removal of untracked
>> files/directories and the current working directory, and I'm just submitting
>> them separately.
> 
> Awesome work! Apart from asking for an additional clarification in the
> commit message of the second patch, I have nothing else to offer but my
> sincere thanks for working on the `stash` code.

I found what is probably a typo in a commit message, but otherwise this
looks great.

Thanks,
-Stolee
