Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E76EC433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 03:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7B69206D8
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 03:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgH0Djd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 23:39:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38512 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgH0Djd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 23:39:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id d22so2417775pfn.5
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 20:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1/PnXroXdL9r+lflKUecjRT1SbuPR1BjY4vErSVeb/8=;
        b=rJY/qqEM4vDT9xu/Smb2YK691gnJciALYBUB0BGNS0+FDos5RyOqug02JhuaL1nFYN
         z8sGdeFVro0MLrH4cw1UsA6jUWyv62TTN00XN5qiCxRB+bvKHWLp06oX9B7tFsoI8CQ/
         3R8mxP2qGDXTljfxFFbdzGsaQgPw2INhcVLn3V9z91sWvD/opTAHLi4Vi/K5D6riL3Jo
         bcb3coO4Gr9FKyGTicIvh0PXzgfwlz1Wnx+F2LnHcwhzHT/KXD8OXQEBULObz4CZMs7L
         /Uzl6tOq3FMYFGy+G20Gle5xVig2eNmArdScJ4aN4MKz68zatWdPPoDUmrd4DXwMae75
         2lVA==
X-Gm-Message-State: AOAM531a8dHbMwOhkgWAwHC+tF43zUfT6KlReKXvgU82cwkt9K33jyGD
        4ZUgWu2djlPt6HTFyiBmVqc=
X-Google-Smtp-Source: ABdhPJxuJ0qrxGnYuwwaglmcqNxyvpo8yrjGf1h8B4LwJf2K9JrTkxc4veybJQfpTFOb2zCcjav60w==
X-Received: by 2002:a17:902:7888:: with SMTP id q8mr127976pll.113.1598499572769;
        Wed, 26 Aug 2020 20:39:32 -0700 (PDT)
Received: from localhost.localdomain (50-125-94-129.hllk.wa.frontiernet.net. [50.125.94.129])
        by smtp.gmail.com with ESMTPSA id a69sm704254pfa.116.2020.08.26.20.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 20:39:32 -0700 (PDT)
From:   Sean Barag <sean@barag.org>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com, sean@barag.org,
        stolee@gmail.com
Subject: Re: [PATCH] clone: add remote.cloneDefault config option
Date:   Wed, 26 Aug 2020 20:38:54 -0700
Message-Id: <20200827033854.130005-1-sean@barag.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <xmqqeentuqk5.fsf@gitster.c.googlers.com>
References: <xmqqeentuqk5.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Derrick Stolee <stolee@gmail.com> writes:
> 
>> On 8/26/2020 2:46 PM, Junio C Hamano wrote:
>>> "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>> This commit implements
>>>> `remote.cloneDefault` as a parallel to `remote.pushDefault`,
>>>> with prioritized name resolution:
>>> 
>>> I highly doubt that .cloneDefault is a good name.  After reading
>>> only the title of the patch e-mail, i.e. when the only available
>>> information on the change available to me was the name of the
>>> configuration variable and the fact that it pertains to the command
>>> "git clone", I thought it is to specify a URL, from which "git
>>> clone" without the URL would clone from that single repository.
>>> 
>>> And the name will cause the same misunderstanding to normal users,
>>> not just to reviewers of your patch, after this change hits a future
>>> Git release.
>>> 
>>> Taking a parallel from init.defaultBranchName, I would probably call
>>> it clone.defaultUpstreamName if I were writing this feature.
>>
>> I was thinking "clone.defaultRemoteName" makes it clear we are naming
>> the remote for the provided <url> in the command.
>
>I 100% agree that defaultremotename is much better.

Perfect, I'll move forward with `clone.defaultRemoteName`.  Thanks for
the recommendation.  This would be the first config variable inside
the a "clone" subsection -- is there anything special that needs to
happen when a new subsection is added?

>>>> ...  For example
>>> 
>>> 	git -c remote.cloneDefault="bad.../...name" clone parent
>>> 
>>> should fail, no?
>>
>> This is an important suggestion.
>
> To be fair, the current code does not handle the "--origin" command
> line option not so carefully.

Agreed - I'm sorry for not including those tests.  They'll be present
in v2.  I'll be sure to include some validation for
`clone.defaultRemoteName` within `git_config` as well.

> It is somewhat sad that we have the git_config(git_default_config)
> call so late in the control flow.  I wonder if we can update the
> start-up sequence to match the usual flow
> ...
> One oddity "git clone" has is that it wants to delay the reading of
> configuration files (they are read only once, and second and
> subsequent git_config() calls will reuse what was read before [*]) so
> that it can read what clone.c::write_config() wrote, so if we were to
> "fix" the start-up sequence to match the usual flow, we need to
> satisfy what that odd arrangement wanted to achieve in some other way
> (e.g. feed what is in option_config to git_default_config ourselves,
> without using git_config(), as part of the "main control flow uses the
> variable" part), but it should be doable.

Sounds like a pretty big change! I'm willing to take a crack at it,
but given that this is my first patch I'm frankly a bit intimidated :)
How would you feel about that being a separate patch?

Thanks for all the guidance, folks.
Sean
