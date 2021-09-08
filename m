Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D33C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 17:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA7FB60F6C
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 17:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347202AbhIHRwP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 13:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhIHRvu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 13:51:50 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FC2C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 10:50:42 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id s15so2591716qta.10
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 10:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=tkS8dUhEbNAUum8OZMDgccAV/bjsWHuD6cSIhRkb3LI=;
        b=nGhCdPut1tm7ekAaEu5k07YjTsHmlRKZO8HtccMyKlkxM6kthhY1Jnf0s9Wr0ixuFb
         5fZMcS0p0yAcqoZuCNYNDNhajBus/x7SXR6vd/NTJrEDiBvXXt0+GEkjqCO6wKJfon1/
         XTPR4ZgPzozi3wHJEkCdmAG9Upm4pazeBABAF72vNtJ+K2SQ2wNPGuEV2dWA4RyDNNy8
         JMkHPISirXdZcY7ZxELioLepva5BtxWlNmEpL56FsPpu5EbF2F78tAtve/CqxSnZ4oMh
         iS2ZLaC2CWg7r6RtYn9CpkkhUXjdS9oPmsd/yejfG1sY8HH3sjOxWNrl3HEqKCTndYhd
         sJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tkS8dUhEbNAUum8OZMDgccAV/bjsWHuD6cSIhRkb3LI=;
        b=WoDceGDa5YHHNlei10ca4UrKY0v517gSM1zex2iBmiEs95WCE8jAH/2HvbVyykLG4V
         vySc1iVsWdMnzJPyCxbXjc0vbZ1GLjyv4wQhApDvwc9RDFEC9pEYeJ6qYieaipCip7+O
         +jP39KejcTwnK5vx7woaXukQx8T0314+CAWSwrxxtnq0waDdu1K7ygLXiH40vMw1Toqy
         4Cwf8JNLJwQsyniSJ39XA+JlaDxKTOAn992mocvX8X1+b5uENst0yBO2EBCL/XvOnzNP
         24WyZmsHLZVlWJf+bd3BdMlEmtnkE+x5pJtswB4xRX9ahdBFwL+XwCusGfF/gKbwR1jF
         mYGg==
X-Gm-Message-State: AOAM532xeJq+7iEd8iD9B5FEFhxwTBiwcMH7ECo3c3t/IVIZ/1t3xmSH
        hDiLnRdoNDwaeoV0r4pv0bR4pVCjt/M=
X-Google-Smtp-Source: ABdhPJy9uriVAiDnRLj1Q10kKV83GiP3pTz3IEDn+VRHh5V1VFV0xHk5UJhgNm9FRFz/OS/r/vJfkw==
X-Received: by 2002:ac8:5947:: with SMTP id 7mr4989283qtz.177.1631123440997;
        Wed, 08 Sep 2021 10:50:40 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id i18sm2217211qke.103.2021.09.08.10.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 10:50:40 -0700 (PDT)
Subject: Re: What's cooking in git.git (Sep 2021, #02; Wed, 8)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqsfyf5b74.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <67055f8a-b7ad-90f6-4b61-302e83f8e93b@gmail.com>
Date:   Wed, 8 Sep 2021 13:50:39 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <xmqqsfyf5b74.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2021-09-08 à 11:38, Junio C Hamano a écrit :
> 
> * pb/test-use-user-env (2021-09-07) 3 commits
>   - test-lib-functions: keep user's debugger config files and TERM in 'debug'
>   - test-lib-functions: optionally keep HOME, TERM and SHELL in 'test_pause'
>   - test-lib-functions: use 'TEST_SHELL_PATH' in 'test_pause'
> 
>   Teach test_pause and test_debug to allow using the HOME and TERM
>   environment variables the user usually uses.

The name of the debug helper is 'debug', not 'test_debug' ;)

Also, technically with my v5 'debug' does not use the full $HOME but
just $HOME/.[g|ll]dbinit, but for this merge message I guess it does
not matter much, and I don't have anything better to propose :)

> 
>   Will merge to 'next'?
> 

 From my part I think it's ready, I think I've adressed all feedback.

Thanks,
Philippe.
