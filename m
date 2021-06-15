Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA8DC48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 09:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A7E961441
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 09:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhFOJkH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 05:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbhFOJjs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 05:39:48 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4212DC0613A3
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 02:37:19 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 3-20020a05600c0243b029019f2f9b2b8aso1601769wmj.2
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 02:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=sZK3y2NCFpEv0PGDFf6gJZYqzplBuB8cxAA18rDeSy0=;
        b=h65kI6OwoqHjXIW1SS+38Nok/zMFjDdPPRBdCF00cssf7XlwLP6ywHnC1/qjsoz+cU
         kGkjFqDGh3g9aAjFZN8jn6h6G4hbOB2XfRRctPzvBAf/fvPOef2FnXz7P6rNvEye+iOe
         UYPJhyRLOF6zF+6TWdZmdTnaiXdrrHVlWeoWONFW8/JuE7HWRuyNVh938hTSeGqiZqS+
         FeIUIsS29gGkwLYvGwk13aA+m1vT9c8csGFZTXqTA3sOGXcKmb926SCr0W/5dg0hMDnI
         ih523SE3QYEIvdBHyTDTHrTZhijQSoCkAp1UemlvVeWLUSS/oP5y9G/Rjg7H8emSwmqD
         JC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=sZK3y2NCFpEv0PGDFf6gJZYqzplBuB8cxAA18rDeSy0=;
        b=KW7xtLHHkhnIQAdffc3jP2hQ1F7ib8e37Jz/xLgypEl9c7fTIJSPODtErL7K7EMMPc
         rfFUf70DJx3HBIcBa51BH0aet6dTCYYPsMu0Xsv/wkRRnnxoGQW7vqsQ9i9DbcZCu9TT
         WEwfEemT6eOEciOZZLcn7B6GFali1gZjNBB7dYuhmALAEcEmJTKt8YA4OF/5XlYEW1o1
         G8byfaGQHylCLEQFAe6tsQ+seQ4XqqQrKsO2nS9YVFa2jk4T/RhWrnAjCMHG13zN6BzN
         So+W6HfvBHg9jTOtH8yjZ+RqG5ZWGHdnnMm6PGX5QBciEEZFiLEyKaTQy2Celb00liag
         1uLg==
X-Gm-Message-State: AOAM531iBexR375jtpumzLtTmjOGQyZqFntuJJlPomlJ5S9m9S1U+pSz
        D2AOsl6GZhXGPys7tLgORwg=
X-Google-Smtp-Source: ABdhPJz2w4UCAJstY8BfPcNks5BsjS8/QiswnZPugYAajEn9c356isBrB8tg+lYEoTAc8LSD3X667Q==
X-Received: by 2002:a1c:770b:: with SMTP id t11mr4187647wmi.79.1623749837896;
        Tue, 15 Jun 2021 02:37:17 -0700 (PDT)
Received: from cpm12071.local ([79.140.114.214])
        by smtp.gmail.com with ESMTPSA id k42sm1987970wms.0.2021.06.15.02.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 02:37:17 -0700 (PDT)
References: <20210610083916.96243-1-raykar.ath@gmail.com>
 <20210614125157.99426-1-raykar.ath@gmail.com>
 <20210614125157.99426-4-raykar.ath@gmail.com>
 <gohp6kh7i0xm08.fsf@cpm12071.fritz.box>
 <CAPig+cQQXEU2QvP6PGB7v=RGQDiu_s0kctFyqSHWvLe2ep0w9Q@mail.gmail.com>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH v4 3/3] submodule--helper: introduce add-config subcommand
In-reply-to: <CAPig+cQQXEU2QvP6PGB7v=RGQDiu_s0kctFyqSHWvLe2ep0w9Q@mail.gmail.com>
Message-ID: <gohp6k35tjqxix.fsf@gmail.com>
Date:   Tue, 15 Jun 2021 11:37:11 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Jun 14, 2021 at 3:53 PM Rafael Silva
> <rafaeloliveira.cs@gmail.com> wrote:
>> Just as an example, here's a diff to demonstrate the argument:
>> -- >8 --
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> @@ -2934,6 +2934,14 @@ static int add_clone(int argc, const char **argv, const char *prefix)
>> +void add_config_in_submodules_file(const char *keyfmt, const char *submodule,
>> +                         const char *value)
>> +{
>> +       char *key = xstrfmt(keyfmt, submodule);
>> +       config_set_in_gitmodules_file_gently(key, value);
>> +       free(key);
>> +}
>
> The new function should be `static`, of course.

Good catch! Indeed, it should be `static`. 

-- 
Thanks
Rafael
