Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A677C07E9B
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 20:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6522361356
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 20:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhGJUpn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 16:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhGJUpn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 16:45:43 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACD0C0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 13:42:57 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id b18so13527784qkc.5
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 13:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N/E2sMSDXQBGbsQ+b4f4BiiIH+9wc+OWxYgA9MOuHow=;
        b=IHcMLH2VgabsbAAPUwHtD/0Nvwcp7Z6uWotd1pzxbdTbiI7uZ0p4ttHeqdFPQypYCA
         OrjiwnyCnFKU8mG6IgYDCVeLV7hli1OpzNABLO5G4dGjauZR9LjCdqqF9Q36PfhQSa19
         aErmlZWcxW2DN7aZ3N5P7h+wtLwKOZgDyeiLCm9AztInVfJUjKOQE0qb6iNclrEjww6Q
         fmOT2ipeKO8+abfhh6P7TitO3T6Qks1YlknpLqtoiPQNrxeCDFAK7jF8eQFjRiMEpcGj
         aviM/OnfxAimQQXss4WX0S5pp3hjUsRKA22258YmCARTnhOWyfk4e/crmipWGKigB2oT
         uyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N/E2sMSDXQBGbsQ+b4f4BiiIH+9wc+OWxYgA9MOuHow=;
        b=X/NxHARpxapogePL8lF5EWnTjqVcSMmMyqLvyaiIDyzNbfDZqtJS8f5Ad4AzsgkLYt
         nEUpAaczOz0kpIy9GpLtq9awvIsHS9Y5BV332N3lE/8HdEILJkGsayZQEsft3f7BGOaC
         l7a+vvAPAiAWqg7SY9vi52emORtPsr0wmbPo+rNq2+V4pOuMVSHzgdjp50JpRR89BK2R
         TOghvt5oh76tzmE5P2HOTxtxg9RVEKXuk6Kl+lwSJVSSky4sRoj3FwW7m1r6ISg17sKK
         oVaBFgwH0E4NlHC6bpsXcXO3xzpwfVLuDIWe1xNnw6c7sX4Eg5lqa2EbeYOu3UsR4sAh
         cgyw==
X-Gm-Message-State: AOAM530QwWDzxpoJMU5ALEuF9QJDkKDFlIAGn6jpEz6sA+wsBNtJYnc3
        HH2kn+DIc+P6XntxLs1WHO8ruz+hxu8SHKLJ
X-Google-Smtp-Source: ABdhPJyT8k+Lk3tmCHcX1avzLRzW2X11LoHV4hlMLS1Ciiyv/LXHf9IQEmwlwTsoWGe5MDa0utUTow==
X-Received: by 2002:a05:620a:1479:: with SMTP id j25mr20663586qkl.339.1625949776728;
        Sat, 10 Jul 2021 13:42:56 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id z17sm3710357qts.24.2021.07.10.13.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jul 2021 13:42:56 -0700 (PDT)
Subject: Re: unit tests / cirrus ci fails
To:     Fabian Stelzer <fs@gigacodes.de>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
References: <a7aca5f5-3a5e-b13c-ccae-3e515c774420@gigacodes.de>
 <YOhmAGig//yfABWv@danh.dev>
 <db030e49-edb0-8f4b-0e51-a89b2a4a47a8@gigacodes.de>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <dba84da7-f6ec-37b3-4322-378af9249d54@gmail.com>
Date:   Sat, 10 Jul 2021 16:42:55 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <db030e49-edb0-8f4b-0e51-a89b2a4a47a8@gigacodes.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Fabian,

Le 2021-07-09 à 12:04, Fabian Stelzer a écrit :

> The new tests themselves are failing now and i have no idea why on freebsd :/
> Are there detailed logs publicly available from the CI runs?

the logs should be accessible on the "Checks" tab of your PR
  if you are logged into GitHub. But I don't think there is more
to see than what's shown there.

> Or is my only option to set up a freebsd 12 vm to try to replicate this?
> Does the ci simply run "make test" or is there another mechanism involved?
> 

I managed to log into the Cirrus-CI FreeBSD VM using tunshell [1].
I found out about it at [2]. Here's the commit in my fork [3]

0. Create a Cirrus-CI account and give it access to your fork of Git
1. Create the tunshell session at [1]
2. Run the local script on your local host
3. Copy the remote script in '.cirrus.yml' in you branch
    (ex. as the first step of the "test_script:" section), commit and push to GitHub
4. wait for the build to start on Cirrus and the tunshell client on your machine
    should connect you to the VM.
5. Go to /tmp/cirrus-ci-build in the VM to find the git.git checkout

Caveat: your public IP will be viewable in the Cirrus log.

[1] https://tunshell.com/go
[3] https://github.com/phil-blain/git/commit/b47d803ee1ba83100702cb80c93e18c74d787dce
[2] https://github.com/cirruslabs/cirrus-ci-docs/issues/432
