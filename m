Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9A1C07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 06:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E52B61CA2
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 06:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhGGG3u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 02:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhGGG3t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 02:29:49 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51F7C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 23:27:09 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h1-20020a17090a3d01b0290172d33bb8bcso3075653pjc.0
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 23:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kuNwCKBkBWcMU8yC7DvkJv3bIfYF/XXYCzTR0Fr5ykc=;
        b=GH9DjKnR9V9iCinf+xdMpDtCOI8s//PJQHcgu+F/4rZUOemcYgwnYxzqGBjR1H5gea
         Jsgu4w2QpLFN+6runcF8kf+JOyhJT0HXLH1+vozou1IMvyfMT0/ue0n4lO7t8n/JtCat
         f5IpUpQ5rc1jzt3alRWZlzVI7lig4C+djzw3j4zr0ZhuTLpgEX3OlgiEBzGiw4wnkR30
         DPl9ehaabplz4lBrudmV9cCnBkKPLgROVmc1ltmwo7YtsMp0h26DZOsp86fWtJsN1ngG
         jrlvJwmGneFS4J7Kt9i1Vq8r0CksnoydbyPNEFlhWBWOse33rstMehlkO+NHXFeDM7GS
         /iLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kuNwCKBkBWcMU8yC7DvkJv3bIfYF/XXYCzTR0Fr5ykc=;
        b=oSw0hrRs9IiaL/O1YKkCj3PFJRWDMgrLuctNmQSA2r/Oww9O0z2k3VOf/KBj39wiKP
         V3fdTwG8aBkBECRDD5qr4cw80mEpEXDkFy55eWnFeJ7CpvXI0+rBTYmkfbu22v04RJ7X
         npAIMMfFqHrBN3EbcnmKOfR0y2BkBWAaxRkPr9nyRpY6dj9HrppQM9zW+3kVNDXUqHDA
         RPysUEPKp+Cqqt8WEDjLbZZRYo8DcYs0jGdDoQ4TzxzZtUAUaAXXvNWrVb/VgUzn6UL9
         TjRoGheFwlR67TA0CB6gYFy7BBvGWZEt7wspbw897YH2AmY7GFjgePvnV6EpxBZncKts
         1UPA==
X-Gm-Message-State: AOAM531QGGUlWKifBPNCXKmmpIacFMoqvC7jWZY1boWODDNNtUybhjcX
        vQDvwXNkXg5Aq0EkcSdrMhk=
X-Google-Smtp-Source: ABdhPJx44Dashyyu29+kLj59h/ZDI0+hAEY3xkLMG0TmJoddID+maUqSx3GBT3bfUFO85uvheAS1Sg==
X-Received: by 2002:a17:90a:43c3:: with SMTP id r61mr24397783pjg.1.1625639229248;
        Tue, 06 Jul 2021 23:27:09 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-18.three.co.id. [180.214.233.18])
        by smtp.gmail.com with ESMTPSA id u13sm18037907pfi.54.2021.07.06.23.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 23:27:08 -0700 (PDT)
Subject: Re: [PATCH] Add commit & tag signing/verification via SSH keys using
 ssh-keygen
To:     Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
References: <pull.1041.git.git.1625559593910.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <92d8ae43-f146-e938-d793-b8b67d810130@gmail.com>
Date:   Wed, 7 Jul 2021 13:26:52 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <pull.1041.git.git.1625559593910.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/07/21 15.19, Fabian Stelzer via GitGitGadget wrote:
> From: Fabian Stelzer <fs@gigacodes.de>
> 
> set gpg.format = ssh and user.signingkey to a ssh public key string (like from an
> authorized_keys file) and commits/tags can be signed using the private
> key from your ssh-agent.
> 
> Verification uses a allowed_signers_file (see ssh-keygen(1)) which
> defaults to .gitsigners but can be set via gpg.ssh.allowedsigners
> A possible gpg.ssh.revocationfile is also passed to ssh-keygen on
> verification.
> 
> needs openssh>8.2p1
> 

Why did you choose to implement SSH-based signing as GPG interface? Why 
not create similar one?

If at later times we need to implement other signing methods (besides 
GPG and SSH), we can refactor gpg-interface into generic signing 
interface (say `signing.h`) and let each signing methods implement from it.

-- 
An old man doll... just what I always wanted! - Clara
