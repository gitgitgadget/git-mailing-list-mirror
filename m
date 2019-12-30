Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CA9C2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 13:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B834520663
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 13:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsQ65J+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfL3NL7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 08:11:59 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40886 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfL3NL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 08:11:59 -0500
Received: by mail-qt1-f196.google.com with SMTP id e6so29599021qtq.7
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 05:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=puDRbHsEWCSSbaTEqhVSCiWumRU8FMDlsnYBwrR5Bf8=;
        b=lsQ65J+UXUYbGt7rgtgtOvhLtDxK3gYnX8BaT8IoZRk0fY4NVtqayLVSK/whGQ/9dX
         ET+D4zSx4/JMEvxZymYL99itcCu2axWvl1WW6Pn/f8Y9uR1hcl4IyLEQ714haS7Y8VFk
         kUCS+/fb8c7dURx2wotHTwNrwcIWTzmyM+d8kX8jIvDA09YpUJ0k6YRsmKaC5FiJGAuT
         PwdqN/BGgmmflhLkT7tyMLYGGGSvgq4AjrzQ420O6jtc9runf4UnHq0UkW6zrZ+8K4Ud
         qDdzuc7TqJsAAKnJlAf5Qqm0LMqzNOzVyaxkuRz4a632+trx9ZWxUgzQHEVIa8YkSn9A
         +oVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=puDRbHsEWCSSbaTEqhVSCiWumRU8FMDlsnYBwrR5Bf8=;
        b=AxPmUYF+aRujYdlxTDFgxgumW59k6K2QgOxI5RBvZs/HzHQ8t42/HkYDHJMunISqtp
         y5hyrZ6XgpCa/hmwWorT/EOlIsxmmE2IeYlblOtObQJxt7uWABIM+aqwHv8AbLIP3FVn
         8rzU/PzHNENPvbGIW51GcZS6+h/Lm2BUw/Y/ZhaWIts+Vjd3yfhfZOhyt0tctF2dFLH0
         4W2yJjiIJIONgzE3lTKj3c+W3BsQMaG1di4F2C7QdQFP51EQWqj3SWh+ejKvRDw8vNjM
         OHjGcPBTkwlO50E1YgPq7+UY44MbtxVzclVABj0Oib9Ztpym3sl3JnWf2yNkubo4Xk2x
         Ug3Q==
X-Gm-Message-State: APjAAAVhcfz/ginZX646NRSz+toz6bUEzaEsuB5mir80cuId7JuCImBs
        AiT8tu3ApfgSrB16FhXsSU4=
X-Google-Smtp-Source: APXvYqymMxKwQWBOMQXhY/YgynpJ9Sv1IfRn8B2f7qaDEFpvTjn4UEOG7ztvevQGkpfamd5er/aTWw==
X-Received: by 2002:aed:22c8:: with SMTP id q8mr49864402qtc.133.1577711518285;
        Mon, 30 Dec 2019 05:11:58 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:8072:d2a0:e229:7f78? ([2001:4898:a800:1010:31a8:d2a0:e229:7f78])
        by smtp.gmail.com with ESMTPSA id d8sm13527978qtr.53.2019.12.30.05.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2019 05:11:57 -0800 (PST)
Subject: Re: [PATCH v2 2/2] sparse-checkout: document interactions with
 submodules
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jon Simons <jon@jonsimons.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.500.git.1577393347.gitgitgadget@gmail.com>
 <pull.500.v2.git.1577472469.gitgitgadget@gmail.com>
 <331bb7d6fbec6f2f429feb36cf32e0931307ae0b.1577472469.git.gitgitgadget@gmail.com>
 <CAPig+cTvFW_84TqKsOPjjBM37cX1OL9uX15APcEYpuKVjvM+dg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d934ac0a-d6d7-cf65-5d61-1196abc63ff8@gmail.com>
Date:   Mon, 30 Dec 2019 08:11:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cTvFW_84TqKsOPjjBM37cX1OL9uX15APcEYpuKVjvM+dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/27/2019 3:20 PM, Eric Sunshine wrote:
> On Fri, Dec 27, 2019 at 1:48 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
>> @@ -340,4 +340,32 @@ test_expect_success 'cone mode: set with core.ignoreCase=true' '
>> +test_expect_success 'interaction with submodules' '
>> +       ...
>> +       cat >expect <<-EOF &&
>> +               a
>> +               folder1
>> +               modules
>> +       EOF
> 
> You would normally use \-EOF rather than -EOF to make it clear that no
> interpolation is needed/expected within the here-doc body. However,
> this script is already full of -EOF when \-EOF ought to be used, so
> being consistent with existing tests may override an objection.
> 
> Likewise, please note for future reference that the usual way
> here-docs are formatted in Git test scripts is to indent the body of
> the here-doc to the same level as the command which opens it. That is:

Thanks for pointing out the difference, except...
 
>     cat >expect <<\-EOF &&

This should be <<-\EOF

>     a
>     folder1
>     modules
>     EOF
> 
> But, again, this script is already full of these malformatted
> here-docs, so maintaining consistency with the existing test in the
> script is probably okay.

Hm. Having these lines have the same tabbing hurts my eyes (it is
harder to see where the contents end, much like if we didn't tab
inside a subshell or an if block).

This is also a place where we are inconsistent, and it's not just
my fault for writing the test script in my own style. Here are a
few scripts that tab the same way as here:

	t0008-ignore.sh
	t4124-apply-ws-rule.sh
	t9400-diff-highlight.sh

These are definitely the minority. I just mention them so anyone
who does a cleanup of this whitespace inconsistency takes the time
to look for all examples.

For now, I'll fix the here-doc interpolation issue for this test,
but keep the whitespace matching the rest of the test script. I'll
add this concern to my next series.

Thanks,
-Stolee
