Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C39C64E7B
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 13:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55262217A0
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 13:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgLBNXk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 08:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgLBNXj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 08:23:39 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A547DC0613CF
        for <git@vger.kernel.org>; Wed,  2 Dec 2020 05:22:59 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id v11so911736qtq.12
        for <git@vger.kernel.org>; Wed, 02 Dec 2020 05:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=fD173p2bIsxMnLH0XKF/xhZeyKpEqsq3XMdMQhyROqc=;
        b=ALISKpPWznTTe1XKceCgWgWBw7ZitNBfZQ3fTHI/TjAO6D9wumqQTRK54QDPowsSrK
         3zRPUMPqwTEWpZeXtOwUfdEPk6nwuanXzFPFeIdITfZ7k76KPyaXAxwzcSNrK22DYQ7F
         vd/D8j+yInk05CQsns1XjHLDq80ETU7WpVSHVROVyj7t0shVpAFT+tVv2LQYRCo369A4
         BsIQEHjddA0kHs5r42gI7C16yDWubIVYZxABUEMNaLlOOC5zKHA+33kJBk1NmZc+QmlI
         Qp3W0Ql66mB12p/TSte9YpSHSHfKXHBgbljyfGLvZlk3hpw9iUYKQux8bchdKjgzImUH
         QIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fD173p2bIsxMnLH0XKF/xhZeyKpEqsq3XMdMQhyROqc=;
        b=OlVv1fn8jUUsCxsEOlA1V417ZTtGT/2cj/xUNmdQbiSpv80BKr0mviO3tiTg5xH1Oq
         Gb9lK62AZ3ZEtbavBU1oqRN1E2n7BBvZPkpc1OmMMx5yqaxZGiFjVtTnnd1kqx5g/sh0
         ZQyioVHeXOc6ogT/nc+D/OM70vWwoAzx9po3EYP/2X3sTZ9+nzRBXSWkW9BES7UmywC0
         K8+as+bTm30Dsvy9eohLYI2hE8MAwrRXkHJIu83HHPFjEhMid1oeW3pN3KY7UUbejtUu
         o1+ClViMAZRuY2wqG/wZQttYLseqjLTtqJd11q0OUz47p8rZFmJqXyxxXOhhnnVmXYEJ
         lTpg==
X-Gm-Message-State: AOAM5326E6D1YgvDS3xeyYoCCwgykVOCAzNCaSi0uP48Qmj0XDofgg6x
        RR5Y08CSCYytjpUh1uE9mW4=
X-Google-Smtp-Source: ABdhPJzUK3XT+6np3Ws5POOuUICbEYe741ze1Fyl44Blc02fsCV1kYjAhipjN3nfdl6CSE0Lms1g5w==
X-Received: by 2002:aed:2b47:: with SMTP id p65mr2477431qtd.337.1606915378697;
        Wed, 02 Dec 2020 05:22:58 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id s68sm1668488qkc.43.2020.12.02.05.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 05:22:58 -0800 (PST)
Subject: ds/config-literal-value (was Re: What's cooking in git.git (Nov 2020,
 #06; Mon, 30))
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>
References: <xmqqtut6qf7q.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ee7a17a2-25a0-d8c9-f686-4ce3a22616e0@gmail.com>
Date:   Wed, 2 Dec 2020 08:22:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <xmqqtut6qf7q.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/1/2020 12:15 AM, Junio C Hamano wrote:
> * ds/config-literal-value (2020-11-25) 8 commits
>  - config doc: value-pattern is not necessarily a regexp
>  - config: implement --fixed-value with --get*
>  - config: plumb --fixed-value into config API
>  - config: add --fixed-value option, un-implemented
>  - t1300: add test for --replace-all with value-pattern
>  - t1300: test "set all" mode with value-pattern
>  - config: replace 'value_regex' with 'value_pattern'
>  - config: convert multi_replace to flags
>  (this branch is used by ds/maintenance-part-3.)
> 
>  Various subcommands of "git config" that takes value_regex
>  learn the "--literal-value" option to take the value_regex option
>  as a literal string.
> 
>  Expecting a (hopefully final) reroll.

Hi Junio,

Did this expectation of a reroll get updated since v3? My understanding
is that any remaining feedback is related to the angle brackets, which
are consistent with the surrounding documentation (and should be tackled
in a separate series). Do you mean that you want me to update the lines
I'm touching to use angle brackets?

Or, do you mean that I should re-roll to include the patch you sent [1]
for between patches 7 and 8?

[1] https://lore.kernel.org/git/xmqq7dq9ca94.fsf@gitster.c.googlers.com/

Thanks,
-Stolee
