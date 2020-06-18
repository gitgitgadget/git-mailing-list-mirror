Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40BCC433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 20:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B79C208C3
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 20:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbgFRUkU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:40:20 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42898 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731613AbgFRUkO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 16:40:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id k6so2937603pll.9
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 13:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:from:to:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HuIyO7lH2+gvWNcKcqB18EuiJNUX7b0DpeMAsprGlCM=;
        b=C6o5d9ExpeD0aditZueIQZkMzc+Y4zOiGDx/52KXucjyL0EnbAQx4+HdqLheJVIiBo
         uuSK7/0EUqgUoOjvFwjMovHtPTDpJSLAxtvA1QqlKumU0Lzidndqr3KnAJ7Tdo3es6MV
         RuO9CCrI5H1kuqsRAOxgPaiStLq4aSM++0snb1nJcHH32Wwcp++/KYBdOK6etJhHdmxj
         3bNVVepq6ymwBUzXdLS/ttRJ4CAAz1VRXywLhDTSkc41ms/wWPDQ2HNNv6SfWMbAUscS
         c2TCtltxVHniSObd0L5PzgXv5Lqb1pQ1h2OMT2IoIQUz39S+Ts/9A5gI6ogNKD/aAiie
         5zzw==
X-Gm-Message-State: AOAM531Eu2zOJR8EmQCaCei0jAbkrH0oL27QjidkQqJ9WqeRY55s7TCh
        X/rGF0zNgpoDZHpqM/ODzBwfwkSwEwM=
X-Google-Smtp-Source: ABdhPJxlOs2EtEnzKdeR0RJ3nwOJ+61m/Gk0iO64rOnzbPz3lf2pwip2ij2/nUy4cHpjpbCmOKk2zQ==
X-Received: by 2002:a17:90b:3842:: with SMTP id nl2mr114677pjb.111.1592512812465;
        Thu, 18 Jun 2020 13:40:12 -0700 (PDT)
Received: from ?IPv6:2601:647:4902:640:5dd6:323c:6306:86b1? ([2601:647:4902:640:5dd6:323c:6306:86b1])
        by smtp.gmail.com with ESMTPSA id y7sm3203152pjy.21.2020.06.18.13.40.11
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 13:40:11 -0700 (PDT)
Reply-To: pss@acm.org
Subject: Re: git config not following include paths by default
From:   "Paul S. Strauss" <pss@acm.org>
To:     git@vger.kernel.org
References: <6aab7843-7ece-5499-c074-a5fa8ef68beb@acm.org>
Message-ID: <b9f47155-e6ef-5868-898d-f5a703e2fd94@acm.org>
Date:   Thu, 18 Jun 2020 13:40:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <6aab7843-7ece-5499-c074-a5fa8ef68beb@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update:

The problem is related to my having GIT_CONFIG set to a file other than 
~/.gitconfig - when I unset GIT_CONFIG and copied my config file to 
~/.gitconfig, the include worked as expected.

So, to reproduce:

    Do NOT have a ~/.gitconfig file
    Set GIT_CONFIG to a configuration file with [include] statements
    Then the behavior I mentioned will occur



On 6/18/20 1:25 PM, Paul S. Strauss wrote:
> Using git version 2.25.1 in a bash shell on Ubuntu 20.04 (focal).
>
> My global git config file has an [include] with path set to additional 
> configuration.
>
> "git config --list --show-origin --includes" shows all of my configuration, 
> including items from the included file.
>
> "git config --list --show-origin" shows only the items in my main config file. 
> Not sure why "--no-includes" is the default, but not a huge deal either way.
>
> What is a big deal is that none of the configuration in my included config 
> file is available to me. I have lots of aliases and other settings in the 
> included file, but none of them work.
>
> This can't be the expected behavior, can it? If so, then including config 
> files is pretty useless.
>

-- 
Paul S. Strauss                                  pss@acm.org

