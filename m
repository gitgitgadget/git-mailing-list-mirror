Return-Path: <SRS0=OIeF=BS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBF7C433DF
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 14:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E94920748
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 14:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7PgbhOI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgHHOkO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 10:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgHHOkN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 10:40:13 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1843AC061756
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 07:40:13 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bh1so2554566plb.12
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 07:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y05BMQ8WkWYgiSElI2f3qXzpiYO5vzwAp59WLznndkc=;
        b=i7PgbhOIVN7VYsftuzym43DnF7Wwrm6mTP2wJtRLmgMuw0CGcls8TmQI5yBB3vAj3X
         tmFmDTDW9t3TItqerPdDiI/ADp3PSAHQE5oRhdHCF9K1V7AdHFA8i6MtWG5b339nfi9b
         CYe66XRav1LDDzF8sdejuL6oK6sha30AkjSOFsYk2l2BhZzVNh05uf2YBZMrfMSsnxOk
         owtvhPWFatHY01b9LwlCJTtkXSeF40v3A/Bbq3lcJ7gBTguVwgd/8+7m1sDoihoD8hUE
         pqObucYPU1rpIopVDc9/GBuXGlFLyEjm7UmLRwggZtAiqBlMdO/spIh1l0Yr/a4d8x1c
         2VvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y05BMQ8WkWYgiSElI2f3qXzpiYO5vzwAp59WLznndkc=;
        b=M7AnEpVGuCpeTHMPgHXDn5ZNPW7K6NSZEJBCG6iEz8Fk5NorgSJHOiYGJBQZwqUZl/
         k/Ed1Qew/sr4SaL4SGkSJgsxAwOQ1Q3eMn/tKbV7yz/x3uPsHRlJHZOpBQZfp/Jk6c6U
         7Nfr+EDAAD0oJ6ZVZnoo2kizs/nbssi6+C6XHxcI//RodWHKq1wBywfkCYRV8aYDfixT
         OSaqLXjvaHAb12lgLRML8e6aFUztI9uqwE/LlT72nScFL9R3FAUb41wvKZ8wXXDidCfm
         batCcF/ZWRqkFKDmy54otfhzMRBBGmwVR8NlXv/M67ai6nXxzRKULDqN1kcCJt5TUIe+
         JhGQ==
X-Gm-Message-State: AOAM532muXWCRbt10lVTsR2Mcq/jrYLtVcI1dAE9nVZlGRXB/JuLGcer
        igp4IpLizBXK4RhQv4qrnAU=
X-Google-Smtp-Source: ABdhPJwqLseaEuKxUCFFQdqweGPpyQ0I81nYsyME7+/I6nmg09g15PGdLxX0t9/z4fXPexJyJ1TEow==
X-Received: by 2002:a17:90a:9405:: with SMTP id r5mr489006pjo.74.1596897612660;
        Sat, 08 Aug 2020 07:40:12 -0700 (PDT)
Received: from [192.168.208.37] ([49.207.140.106])
        by smtp.gmail.com with ESMTPSA id h1sm17621873pfr.39.2020.08.08.07.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Aug 2020 07:40:12 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] submodule: expose the '--for-status' option of
 summary
To:     Shourya Shukla <shouryashukla.oo@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, liu.denton@gmail.com,
        Christian Couder <chriscool@tuxfamily.org>
References: <20200806164102.6707-1-shouryashukla.oo@gmail.com>
 <20200806164102.6707-2-shouryashukla.oo@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <831df9f2-0663-0dfc-0871-d34864d1ecde@gmail.com>
Date:   Sat, 8 Aug 2020 20:10:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200806164102.6707-2-shouryashukla.oo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06-08-2020 22:10, Shourya Shukla wrote:
> The 'for-status' option is used to compute the summary of submodule(s)
> in a superproject by skipping the ignored submdules i.e., those with
> 'submodule.<name>.ignore' set to 'all' in the '.gitmodules' or
> '.git/config', with the latter taking precedence over the former.
> 
> The option was introduced in d0f64dd44d (git-submodule summary:
> --for-status option, 2008-04-12), refined in 3ba7407b8b (submodule
> summary: ignore --for-status option, 2013-09-06) and finally perfected
> in 927b26f87a (submodule: don't print status output with ignore=all,
> 2013-09-01). But, it was not mentioned in the 'git submodule'
> Documentation.
> 
> Expose the '--for-status' option accepted by the command 'git submodule
> summary'.
>

I've had one concern about exposing '--for-status'. As of now, the name
of the option has no relation with the behaviour that we get as a
consequence. So long, the option has been internal and this wasn't a
problem. Now that we're considering to expose it in the docs, usage and
autocomplete, I would say it should be done after renaming it
appropriately given that it's easy to do now than later. As to name
suggestions, I really don't have any.

Also, as to whether exposing this would be useful at all, I really don't
know.

-- 
Sivaraam
