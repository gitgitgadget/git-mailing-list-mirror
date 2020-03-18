Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06059C10DCE
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 15:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBED620770
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 15:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxZpcqfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgCRPZr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:25:47 -0400
Received: from mail-qv1-f44.google.com ([209.85.219.44]:46299 "EHLO
        mail-qv1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgCRPZr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 11:25:47 -0400
Received: by mail-qv1-f44.google.com with SMTP id m2so13049581qvu.13
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 08:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a2SzkGe5EVwrLUYEXoEJtE5ELkefbm4R3hA5Jg4XsPE=;
        b=IxZpcqfHaSMtoLlJMAmI0dYIElahqGc04nCFQUfqjnx863VKDm+bK2F7Fft6PG+bSJ
         Y7mqXcd4cPW6MWCIQNKSou7Qbxg+HCBa9cT4c3gZdIFMtneHjVlIvktm1KfKrySEu41R
         937f52KOugwRc35bz8T8nG98sXjGEytxnTGhLGxpXZOU8LIwvMulsZzyC31M0tYrPOW4
         iGZ6pEJOvHRos8njED+20ZMLO4Orx+TxYALmkUZuOZ2LuvR/7XJYsnpPIh5KoHNH+j0F
         H3SXxGONPGrbyHs7JML0O49e1mDEIEJbUYe+PpdP1xHyD5BvIAQX3Of4MSuviIXsAmab
         qZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a2SzkGe5EVwrLUYEXoEJtE5ELkefbm4R3hA5Jg4XsPE=;
        b=Z84R4iwzcJTGljVXKSQMGS+QWv19xGgkboV7O89SI+xJZNzfWffZIBZj2bUTkwcz9U
         5b3z1stAIpiermVNnKhb+uMTkAUTxI8Y5DERfJ6nIHJdL7JvJhDsaYgoGfbgPu75Rxdc
         VtqcNDpIeAoQq6oFw9jCEV8Yl8NqJNi3Z6GEtSy4JlGYMU6jb5kJC1cDF7L5xLu7eU0H
         +SiS3BxbEIQkUxBJVsnftc3KkVHLNBgmAyFeWMQJRwMKRZy9/bLV8P39o1wa4/3GN+pP
         u8GQSR4BLoQvoyeBJNGfNfsVO2D8xySIFrWnVbt9vVto5/JKLs85hFAvz/QJ0Cc57Tf8
         L8Jg==
X-Gm-Message-State: ANhLgQ3/yVpKHPKCkJsaw5g/rjto7bAvRkAZoSPrjlSOFTfP1buup3YP
        NNxFRGmLELagBqQqZWcB874=
X-Google-Smtp-Source: ADFU+vuZR7rW7uloNHsT1aIyoLAg2/TfmTnVpk29no7oBYSe17w4q0sd8V/wfnIEuLH2+tHG2Ia3rw==
X-Received: by 2002:ad4:4c0c:: with SMTP id bz12mr180336qvb.8.1584545145531;
        Wed, 18 Mar 2020 08:25:45 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id m1sm5060157qtk.16.2020.03.18.08.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 08:25:44 -0700 (PDT)
Subject: Re: [RFC] Possible idea for GSoC 2020
To:     Jakub Narebski <jnareb@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
References: <86mu8o8dsf.fsf@gmail.com>
 <7d6a84c7-6b16-c2a9-11a1-3397422064d1@gmail.com> <86d09b7jx6.fsf@gmail.com>
 <CAP8UFD3BeS8bj8OGKJmVyKeDTCvqhCpBxLhTwuQ3zffejQkj7g@mail.gmail.com>
 <867dzj6p4y.fsf@gmail.com>
 <CAP8UFD1ihR1PtM2y24HTKa2woGXMVFq9MoVSj1cHVZCNWSH7EA@mail.gmail.com>
 <86mu8d6a39.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4c063495-0b01-dd0d-eb87-61e31a774cde@gmail.com>
Date:   Wed, 18 Mar 2020 11:25:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <86mu8d6a39.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/18/2020 9:55 AM, Jakub Narebski wrote:
> I have added 'Generation number v2' as one of alternative ways of
> working on the more generic "Commit graph labeling for speeding up git
> commands" idea -- as first task, because it fit better the narrative:
> https://github.com/git/git.github.io/commit/a6d59820709417081c334a5120342987ff046f1a
> 
> Could you (or Stolee) check current proposal, so that it can be merged
> in?  Thanks in advance.
> 
>   https://github.com/git/git.github.io/blob/soc-2020-idea-jnareb/SoC-2020-Ideas.md

Thanks for the updated write-up. I think the narrative is helpful, describing how
we landed on the definition of "generation number v2" before going into the interval
methods.

The only comment I have is about this statement at the end, which seems to be a
carry-over from your perspective of wanting intervals instead of v2:

	Before starting on this task, at the beginning of the GSoC, it might be
	[a (sic)] good idea to check that interval labels would provide significant
	performance improvements at least in some cases (and if it is not the case,
	switch to working on generation numbers v2).

The final parenthetical (switch to working on...) is a bit presumptive. Instead,
please recommend an exploration period to determine which methods have which
performance improvements using prototypes and/or the Python notebook. I'm usually
of the opinion that a prototype is more informative as it compares the results in
context, and the student would learn about the code that needs to change before
creating review-quality patches.

Thanks,
-Stolee
