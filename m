Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDA0C4338F
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 11:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 633E261267
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 11:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbhHVLhn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Aug 2021 07:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbhHVLhm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Aug 2021 07:37:42 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24581C061575
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 04:37:02 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id g14so12848541pfm.1
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 04:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oiLHrr6r95EdQjX2TlStoU4lADzNV8VX/WyKEvOfiOk=;
        b=eUxtfhVCwmCutO8sjpXOl5ujqasXPT/GmmLlLcLkwxDCtO3WqmeNazHLCJp7zogi6r
         FyoeiuWfhBvNc1CrkJKhJnffej1/dcQfi46VchHa8joEFAv0EoVA4Aw6LfBfIVaYMYiK
         5BUSsJpgAX1RFuFroZrrEDmu5CNY5Cf7JiaxUtKF3YxXSQl5m8W+KYxi7o57vedIDbOg
         dmB/7P5v8kCl4NVz3Dr+U9oH/yf2pBAf/1kJqxqzSN8uTeOXSH5PHJVlCog3ldD6k+hU
         ezRqwHoJIf1SQxfwiPEoJPVUBWZRYqqJxSjzbL2exI6BHqSVrZ7HE7qgOvfMyiF/eAaW
         WaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oiLHrr6r95EdQjX2TlStoU4lADzNV8VX/WyKEvOfiOk=;
        b=jy8tW/4qiNezqxzUdi+J+8AgKXQTLVPWMW6nZxs4LAYPE284ai0ibVR7Cv4RvrX6Ml
         g0eucSPkzr6M0hZU8strYpTSNhihHbIVY3gLno06qr9+Dvk9EaxfnvlUkVzqOErJ+elJ
         g3fZx0RPZX8XTXF67b08YqrurAFmVIyP1QW+utwJnlQO1xE6gMMXB6XguiAJ/cUaFooG
         Vjf8Et11NEGddI36sqD9dvMAXPMhXMhg2uM8Iq44SLX0nCHvvV9YpXIqAtblQz5442y7
         rXk/y/h0Rc7AXO60ySAHV8PFX0KMO3Zw5K95c954PBQIB4R8HGGbRZWdFT5V7eeyP1Bo
         F3RQ==
X-Gm-Message-State: AOAM533fB2IdqCNnnPP9bvATRmlK+4UN0c99dpB1ZyRN9OWjoyBhisny
        n0k0yF9+bR4NuvIhddgxGepezqgkPmWuCPYk
X-Google-Smtp-Source: ABdhPJyh82EGTO+gE0qCd7nBEF01K16gG33Za8H1J0x3VxCjhxlAuRaoFVQXMk/JEeyGMumUTf6YVw==
X-Received: by 2002:a05:6a00:986:b0:3e1:3174:b05a with SMTP id u6-20020a056a00098600b003e13174b05amr29004354pfg.1.1629632221601;
        Sun, 22 Aug 2021 04:37:01 -0700 (PDT)
Received: from [192.168.208.38] ([183.82.188.255])
        by smtp.gmail.com with ESMTPSA id y4sm11075288pjw.57.2021.08.22.04.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 04:37:01 -0700 (PDT)
Subject: Re: [GSoC] The Final Git Dev Blog(s)
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>, Jeff King <peff@peff.net>,
        Shourya Shukla <periperidip@gmail.com>, git@vger.kernel.org
References: <m2lf4wys5o.fsf@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <a834f42e-e92a-ed2c-66db-971ea25bf1bf@gmail.com>
Date:   Sun, 22 Aug 2021 17:06:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <m2lf4wys5o.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/08/21 8:05 pm, Atharva Raykar wrote:
> Hello Git Developers,
> 
> This is my last week with Git under the Google Summer of Code banner.
> This week's update will be different from usual, as I have split it into
> two separate posts.
> 
> These are:
> 
> 1. The Technical Report: https://atharvaraykar.me/gitnotes/final-report
> 
>     This is a largely impersonal report that describes the current status
>     of my work.
>     Mentors: this is what I will be submitting to Google as my final work
>     product. 
> 

Thanks for the report! It's well written. Some comments:

> Portability: Non-POSIX systems like Windows don’t play nice with shell
> script commands like grep, cd and printf, to name a few, and these
> commands have to be reimplemented for the system. There are also
> POSIX to Windows path conversion issues.

I wonder if that's a valid claim. The shell script version of the
commands use a lot of *nix utilities to achieve their goal. This comes
as a hindrance to run the corresponding commands on other platforms such
as Windows which don't have these utilities. That doesn't mean those
platforms implement those utilities for their platforms. From what
I know,They just use an emulation layer in which the *nix commands would
be available. Using an emulation layer is costly and not an ideal solution.

> Miscellaneous

You could consider mentioning that the first two changes have been merged
to the 'master' and possibly also link to the corresponding commits.

> Structuring Patches

Structuring was indeed an overarching theme your work.
  
> This taught me how effective communication makes software scale—your
> changes should tell a story that’s easy to follow, so that the code
> can easily be picked up by others by a mere examination of its
> commit and list history.

Good point.

Speaking about structuring, I must mentioned that the structuring approach
has paid off very well till now. I'm inferring this from the fact that
the reviewers haven't expressed any concerns about patches being too
long-ish to review. Having taken a look at the patches that aren't on
list yet, they seem to be structured well for ease of review too.
So, good job!

> What I learned over the course of this project

Good to see that you had some good learnings from the project. :-)

> Do let me know if it is missing anything.

I don't think you missed anything. There's one thing which might
be worth including in the report, though. You could have a section
called "Organization of the work" or something like that which
gives some details about the branches that contain your work and
clarify which ones are still relevant at this point. This could
help future readers (including you!) to quickly get an idea of
the branches and code in your fork.

-- 
Sivaraam
