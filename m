Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65888C4743C
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 03:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FEFF6141D
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 03:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhFEDm6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 23:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhFEDm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 23:42:58 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8A6C061766
        for <git@vger.kernel.org>; Fri,  4 Jun 2021 20:40:55 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id q25so8827307pfh.7
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 20:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6SznltNiNgqHylngIbfEEkRnWaWWa5KQB/yKq4zaqjU=;
        b=r7jTdyqn7HYKzVwYr+GMALxJmVQjR8DiR6hbnnQi8uiIXuuouW3kbIWCJ+U74hGO9T
         +m+qZOT7UQlwbCVsr0L6E3pc4cncFB4C8bqhJaNlAmuQOb9txS13Q52Ks84GmrrmK7xY
         3vgebUx2PCM38a8dbDYB+EUKemTEVnVUn3pymu40gB78B4T7PWDHapc/zqxY6ePGP1S+
         aFvt+RSKE04p7yoVPO08avcf1ig29NkC45trqx49inwYLdoMD4h+qzBO85STLzJqIVxJ
         QmudUsdCe1qtUptriyR/j5437maKWV1X+UPEiv6kzz1imUNxIlD5cBFpye4qLqZZbLk2
         tQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6SznltNiNgqHylngIbfEEkRnWaWWa5KQB/yKq4zaqjU=;
        b=aZK9PU3eAdINq12mYGcgzqZ6lpy83hGUkUp7eBinbqT/DzCdQhERlFb+iJtwP2kUMY
         EWgmN4LcDsugRRavelJ7SCH5EWccd5YOGTEMJ2gbII+IhfGUW0VojH2B/nns+hzIQFaI
         yRu3uyJ4ssk8alqFsT/NlbM9X1GYIcWuDe2wP/E/50Zm0yaWBgqj/Pm2e5OGsh9P/2zE
         i96BrMHfXhHJiipWqt/iIBQhhW9Yx7fd+7a3R+XWGWMmV4UCunEGOyt0bQp7ExpiYKqG
         EJEu6LdxVk7zsMdM7XiZKZwFO7KyeO+3FbEHwDtZUSUroWNFInVG4RwHQq2mngbnOgq6
         uLFw==
X-Gm-Message-State: AOAM533DnjdSVB+nrWyOSYYPO1fsD7sSRlcbIeyIPfNlWVNUCTdSP9vp
        tOAHhYL+tSlkYYV2y2zD8lg=
X-Google-Smtp-Source: ABdhPJxVkW6dFDJGoCCg47nmVHQv8IvCRL4d131NJCHxvyW4Yg5Mha9EyIYbAk3aJgMYpnvN9IX7fw==
X-Received: by 2002:a63:5d5c:: with SMTP id o28mr7987867pgm.22.1622864454568;
        Fri, 04 Jun 2021 20:40:54 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-80.three.co.id. [180.214.233.80])
        by smtp.gmail.com with ESMTPSA id d5sm2845013pfd.115.2021.06.04.20.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 20:40:54 -0700 (PDT)
Subject: Re: [PATCH 0/3] Make CMake work out of the box
To:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.email>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Danh Doan <congdanhqx@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
References: <pull.970.git.1622828605.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <6a9150ca-5c1a-1874-5f8b-35187f197d47@gmail.com>
Date:   Sat, 5 Jun 2021 10:40:50 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <pull.970.git.1622828605.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 05/06/21 00.43, Matthew Rogers via GitGitGadget wrote:
> This pull request comes from our discussion here[1], and I think these
> patches provide a good compromise around the concerns discussed there
> 
> 1:
> https://lore.kernel.org/git/CAOjrSZusMSvs7AS-ZDsV8aQUgsF2ZA754vSDjgFKMRgi_oZAWw@mail.gmail.com/
> 
> CCing the people involved in the original discussion.

This focused on improving CMake support, especially on Visual Studio, right?

Then so we have three ways to build Git:
1. plain Makefile
2. ./configure (really just wrapper on top of Makefile)
3. generate build file with CMake

If we want to support all of them, it may makes sense to have CI jobs 
that perform build with each options above.

-- 
An old man doll... just what I always wanted! - Clara
