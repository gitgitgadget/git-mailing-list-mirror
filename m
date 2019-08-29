Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E11CF1F461
	for <e@80x24.org>; Thu, 29 Aug 2019 14:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfH2O2p (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 10:28:45 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46121 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfH2O2o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 10:28:44 -0400
Received: by mail-qk1-f194.google.com with SMTP id p13so3045162qkg.13
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 07:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MX8RMjiouy53drYcVEJQYNLuKoju1J6c0P8Nn3EX80o=;
        b=NRA3bxw0Wzh12u83TdtKY18aMCW+WOiG0HWZgG7qDoQWATj6BpH6cpRCw+HVQpvTqs
         pDIdbTerMVLG9bl1SBkEy/J5ncLW8nm6kTkRB+VGZ/DmE+ZFVFX8zrLpa8tD0nA43drO
         qIgzBUiU1Zjwgn3gxZdhqfR8LJmTgVouyF3dTkSGj9e68xgUdsSZ3cHlhjxCEiAKYpO4
         K+eQK/eMbN+MEmgYz/My3aP0zTktNqR9HzvQNPeosoiPGtSlW3XeYBuW0MB+mYdkgPGS
         lDWgUHmAhMjKkJE4qOvSaD1Ov8GNAkjw0Qy/0ThOXgb4dvMIZg1FKwlEosdCRaSe0p8a
         8dmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MX8RMjiouy53drYcVEJQYNLuKoju1J6c0P8Nn3EX80o=;
        b=h4Cq+IHl55/8bh5tk9TLS43Z9JLhEgQtMB4hvrImiQFBurWCHnH5fyQf2AbZ6WFKdc
         iFZjf8fZdzO7rcPZAqpKdR9o/fmvjdxpvmazLrdDdr2ORY0EyfjOdTOjLlTw9Vtf5mAK
         Qf6lzKhy7DhOBvL4Tgbet9OFXF8naFZUbQJnah4Fcw2fipbrzwWWneF0TrFScgZWdr2L
         uXrQaJsRMFuJ7+4Xw3PnAlE70sf9h01X/+JN3XmWGCv6KslWYIU1XofrF4sLWJVZHPpC
         wYQ//OirFqBv432lzfkbM6+28KmyKeTzKbwAf9esEu5gH+qLl3B2CydUsPmx7+dCMGj+
         8dZA==
X-Gm-Message-State: APjAAAVzAEiY4a6z5m58lvTAPtzzkZuVj4RjuWVr0j65qQsLbeL6TgiX
        5f1O6vx1fLT8GrqcCuewwiLS8cgaAhI=
X-Google-Smtp-Source: APXvYqwQK7uNEXq6FJAfueam7FR90k89ysBnNIhXYlEfLgH6KJ5pmu1ba/hTXEVVTR9eIhwnzwn/aQ==
X-Received: by 2002:ae9:d606:: with SMTP id r6mr9463975qkk.364.1567088923933;
        Thu, 29 Aug 2019 07:28:43 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:f9f6:adc0:ae8d:8f1f? ([2001:4898:a800:1012:ab2a:adc0:ae8d:8f1f])
        by smtp.gmail.com with ESMTPSA id 20sm1352285qkg.59.2019.08.29.07.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2019 07:28:43 -0700 (PDT)
Subject: Re: [PATCH 2/2] list-objects-filter: handle unresolved sparse filter
 OID
To:     Jeff King <peff@peff.net>
Cc:     Jon Simons <jon@jonsimons.org>, git@vger.kernel.org,
        me@ttaylorr.com
References: <20190828201824.1255-1-jon@jonsimons.org>
 <20190828201824.1255-3-jon@jonsimons.org>
 <164fa8bc-bcf1-4cce-1b49-94b64535d332@gmail.com>
 <20190829134439.GA1797@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2ed6a754-07ef-9131-2655-6d3fd3308623@gmail.com>
Date:   Thu, 29 Aug 2019 10:28:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190829134439.GA1797@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/29/2019 9:44 AM, Jeff King wrote:
> On Thu, Aug 29, 2019 at 09:12:38AM -0400, Derrick Stolee wrote:
> 
>>> +test_expect_success 'partial clone with unresolvable sparse filter fails cleanly' '
>>> +	test_must_fail git clone --no-local --no-checkout --filter=sparse:oid=master:sparse-filter "file://$(pwd)/sparse-src" sc1 2>err &&
>>> +	test_i18ngrep "unable to read sparse filter specification from sparse:oid=master:sparse-filter" err &&
>>> +	test_must_fail git clone --no-local --no-checkout --filter=sparse:oid=master "file://$(pwd)/sparse-src" sc2 2>err &&
>>> +	test_i18ngrep "unable to parse sparse filter data in $(git -C sparse-src rev-parse master)" err
>>
>> Just as a sanity check: when we use test_i18ngrep, how does it know how to
>> separate the part that is translated and which part is not?
>>
>> 	translated: "unable to read sparse filter specification from"
>> 	not translated: "sparse:oid=master"
> 
> It doesn't know. By default we run the suite in LOCALE=C and it checks
> the whole string. Under a GETTEXT_POISON build, it checks nothing at
> all.
> 
> The poison stuff is really about helping people not accidentally mark a
> plumbing string (that we expect to get parsed by a machine) as
> translatable. So the idea is you'd build with GETTEXT_POISON and then
> run the test suite to see if anything breaks. But that means we also
> have to annotate the test suite with "yes, I know this will be gibberish
> in a poison build, but that's OK because it's meant for humans". And
> that's what test_i18ngrep is.
> 
> test_i18ngrep could be more clever about matching the gibberish, but
> there's not much point. The LOCALE=C run already covered the correctness
> of checking the message.

Thanks for clearing this up for me!

-Stolee
