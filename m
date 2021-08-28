Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F82C432BE
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 14:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F48760EE0
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 14:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhH1OvK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Aug 2021 10:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhH1OvH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Aug 2021 10:51:07 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40E8C061756
        for <git@vger.kernel.org>; Sat, 28 Aug 2021 07:50:15 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id g11so7810572qtk.5
        for <git@vger.kernel.org>; Sat, 28 Aug 2021 07:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C7YqPKktvuSjU9O+OnsWPrcXIFHNQgQKE0YgJWQULqc=;
        b=c+CjhjOWIghW5LeLq6tnY2I19tey2WnhFHc89cZe0u7cA14c0qXbCwEbYdu8kL5fpE
         IppCH5Tu7Fy/AhxL1O4mStnoaTvzGWS35V6cD768FV9zbwz5+nFV0CoB1fFg2Wb0AqEp
         hkUvnyzRMlKdQ8mZqxjOO0FV4kk5AAgllbUgRx+BnIznVKzhJ9rLFf9Q8IDtyLWZCMpn
         T1Y3NA32Aw+7k7Gi+TMJwE7yx4SkEkxLlAQR7Frxd4SNN2W3TeEy+xyQkIfjwmZaH1T1
         UwwTykV6vvviYYrj8czw0Tz0bBbJrTkL3ruPrD0cpiDq1V/XpSh/s58Hp6pkBWh/JZ4g
         x+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C7YqPKktvuSjU9O+OnsWPrcXIFHNQgQKE0YgJWQULqc=;
        b=dbrU4oYh6a9zHC07F8YETgFyuV7y2XYTlbYYVkw81KFKtDaO2ZOU3ELp1T7BrvCHLn
         UXPnts9sBeK5A3+sy419rhksOb8/WvbSxcdc29z48/tNOgHYEFqY9az3pWiYZ7Ke7/dR
         zQ+H1GXXS98VdoG9ge645B6omSg910yTP61EQ6S024hLDvsCeE6V/IjdwKI9jkP5OPzm
         eadaX8ZbcLmy6JWDeYaqcX2cQo4NKHvl8gR3uTCDXlZKrOqxHqgotsDk7A5TMCx142MR
         AdQ/psuAMyqV5xrLMUJxetxTKjm+E0iNRBDqtozSCzwE2BJ/3LsJyPCOJXqHu5TyKyVb
         xpQg==
X-Gm-Message-State: AOAM530pXlvBWSAUD9YxZLSteSdMf+wyjFsS4qa4L4/3UFXbEFntpFvm
        PrW/P+N4msq+DsqeD2hYCz8=
X-Google-Smtp-Source: ABdhPJw8v/jbsm5Ge+FsnGyYRFkgOmNKwuTjtEQmRGic08dR1llCpL8UKyTSSUl5cEsjYXbuwJGPdQ==
X-Received: by 2002:a05:622a:394:: with SMTP id j20mr12969249qtx.196.1630162214974;
        Sat, 28 Aug 2021 07:50:14 -0700 (PDT)
Received: from [172.20.10.4] ([204.48.95.223])
        by smtp.gmail.com with ESMTPSA id f29sm5331556qtv.34.2021.08.28.07.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Aug 2021 07:50:14 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] test-lib-functions: optionally keep HOME, TERM and
 SHELL in 'test_pause'
To:     Elijah Newren <newren@gmail.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Arenas <carenas@gmail.com>, Jeff King <peff@peff.net>
References: <pull.1022.git.1629393395.gitgitgadget@gmail.com>
 <pull.1022.v2.git.1630111653.gitgitgadget@gmail.com>
 <00211457eceab756528abf0ca296af866cda00e7.1630111653.git.gitgitgadget@gmail.com>
 <CABPp-BFxDxD0Y5Ru+4VqebAJve4tjZk-4csN3JurC6hmRAUf4A@mail.gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <46a845ee-f97b-6aed-1886-07b0ead63e58@gmail.com>
Date:   Sat, 28 Aug 2021 10:50:28 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFxDxD0Y5Ru+4VqebAJve4tjZk-4csN3JurC6hmRAUf4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

Le 2021-08-28 à 03:27, Elijah Newren a écrit :
> On Fri, Aug 27, 2021 at 5:47 PM Philippe Blain via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> +#
>> +# Usage: test_pause [options]
>> +#   -t
>> +#      Use your original TERM instead of test-lib.sh's "dumb".
>> +#      This usually restores color output in the invoked shell.
>> +#      WARNING: this can break test reproducibility.
>> +#   -s
>> +#      Invoke $SHELL instead of $TEST_SHELL_PATH
>> +#      WARNING: this can break test reproducibility.
>> +#   -h
>> +#      Use your original HOME instead of test-lib.sh's "$TRASH_DIRECTORY".
>> +#      This allows you to use your regular shell environment and Git aliases.
>> +#      WARNING: this can break test reproducibility.
>> +#      CAUTION: this can overwrite files in your HOME.
> 
> Do you want to add an option that implies the other three, so that
> folks can do something like `test_pause -a` (or some other single
> letter) rather than `test_pause -t -s -h`?
> 
>>
Yes, that would be even better. I'll add that for next version.

Thanks,

Philippe.
