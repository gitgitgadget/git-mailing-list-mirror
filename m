Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4429BC433B4
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 07:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 240F0613A9
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 07:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348589AbhDNHXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 03:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbhDNHXS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 03:23:18 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58230C061574
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 00:22:57 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id w10so13780957pgh.5
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 00:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XlW9LokbOnUWuU8TKg30wyxpSfm/yiSmmMQoLtHAP2E=;
        b=P35rZbdoMC5tD9Kmt9QremnpD5N66DY9JCdeXAcLKhJ1xXdJW7CHtEQv/nuWgfPw7Q
         a5HVCCg9jkRvJTPjDInmwX/5EAvgM3psEsis/EkBYf4hc5SgbD80crq6KK7nUCEXwk7P
         fEiqTyaAG6EhK52CewMRHGrZI9YNXNReKxj6CniWY/3TsNXR1Gp6RqaBUeBMem1oJPoq
         Q2tahcloim4cNxeXRwg9p3M45KjNQ6Oeq9NW/Bv4ZkU12ZXr8j4CjBQI1ojiOe1FEQqX
         u/mxfXwJp8xxavY7Jnso4EiBdMajLaVfheUPZGBQHvoTopNMM9hH44EwB8zqbCQjZjWM
         iHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XlW9LokbOnUWuU8TKg30wyxpSfm/yiSmmMQoLtHAP2E=;
        b=uOBNvk5jXDFIAzhLr9w2J9g7NRWAp5z7kScz7RTGl3EB0IXhmizepTrpM2GVMS3pqs
         FtbQ4ygXm/A9S9rcU29JJxmgdqNqai+syNo9FwxMgg6i8ofObgm0bPe/WZscoQdamC0f
         aR5AEEVGEf6iiNY2Y20dYpdBHg5Trr+C8uuwd24us742327AMRxnN+J4NQvOEnf572Py
         JCDmYoQwDvZfDUqNtRN8qonZkNdN84SjG84UTGNE5ZkxaudLh/VFqCE6p19P8ZNNLcO9
         1EEKuneAJrC0XBlCn0fuRyroCKclJ/UYQvxHo2Mv3SkcHTDcqQmDesaEZffldByYfHkN
         FBRg==
X-Gm-Message-State: AOAM5335F+rRYFCguTcjGUEvI5tfCxF8COkcgCeNhuzJtSoyyJzNM9y4
        Z9m3yBROg/g6z1nu5dJyqYo8CMAt4kparBFy
X-Google-Smtp-Source: ABdhPJzOSWdh7VhZyLjawdNPrSzdrtXXRzb5evyHKTaOORMjBbzp2t9esH1Fq+He/MNrunwpH7iZYA==
X-Received: by 2002:a63:ff52:: with SMTP id s18mr36438481pgk.163.1618384976724;
        Wed, 14 Apr 2021 00:22:56 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-24.three.co.id. [180.214.232.24])
        by smtp.gmail.com with ESMTPSA id s40sm11200008pfw.133.2021.04.14.00.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 00:22:56 -0700 (PDT)
Subject: Re: Pain points in Git's patch flow
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Raxel Gutierrez <raxelgutierrez09@gmail.com>, mricon@kernel.org,
        patchwork@lists.ozlabs.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git Users <git@vger.kernel.org>
References: <YHaIBvl6Mf7ztJB3@google.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <b562e614-add7-575f-3013-1dbc667bc5bf@gmail.com>
Date:   Wed, 14 Apr 2021 14:22:51 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YHaIBvl6Mf7ztJB3@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 14/04/21 13.13, Jonathan Nieder wrote:
> Those four are important in my everyday life.  Questions:
> 
>   1. What pain points in the patch flow for git.git are important to
>      you?

There is no lists of "beginner-friendly" issues that can be worked on by
new contributors. They had to search this ML archive for bug report
issues and determine themselves which are beginner-friendly.

>   2. What tricks do you use to get by with those existing pain points?
> 
>   3. Do you think patchwork goes in a direction that is likely to help
>      with these?

No, unrelated to beginner-friendly issues above.

>   4. What other tools would you like to see that could help?

Some sort of bug tracker systems like Bugzilla (used by Linux kernel
and many other projects) and Debbugs [1] (which is mail-centric and used by
Debian for its BTS).

[1]: https://bugs.debian.org/debbugs-source/

-- 
An old man doll... just what I always wanted! - Clara
