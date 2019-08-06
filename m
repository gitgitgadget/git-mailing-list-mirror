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
	by dcvr.yhbt.net (Postfix) with ESMTP id 86B461F731
	for <e@80x24.org>; Tue,  6 Aug 2019 12:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfHFMDK (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 08:03:10 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41925 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfHFMDK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 08:03:10 -0400
Received: by mail-yw1-f68.google.com with SMTP id i138so30718177ywg.8
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 05:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9GtSQcPJyUXVsYJB7iHfRET8XueBIDosx5lI66D5dsQ=;
        b=GSJqAFAkCEVoFXFOiW7i6WnGcu+RcUBm6Ofrvb183JKtPST9lbfwWYPkBU2OelsYzD
         01q1LOeb3L0y8u431MalvfydqSq0wjIIHXtTofOVxiKA9klAGQgE/yL7ADbkRQg+SbKW
         nM+Rft2LqQowInUnnN4dBqJ3UPStAuOz7Fr2eMQ/YfjNWyUIUvH/8IF0AF3A0RAzgWCf
         xI50Mr4sQISPJoUqvP+eZ2Qv5nSWg1qd+DwQvWqAlhQoHQCEUaADbUAcGOl9TQSsOekM
         ZxVH2uD0WOQIMWEahoYeWB7QtXxBkSOnsuACQiQWks92C1+a1rI1TziHsjaLApM88FDP
         mXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9GtSQcPJyUXVsYJB7iHfRET8XueBIDosx5lI66D5dsQ=;
        b=PAXygJHjnfwxFx8P2mtemhTrgOulvOYDDMfSCitYxu8++AAMXNOxpAvmUJxSUip5H4
         0a2iMcrL/+HiR8vizaX2Mvv6itUfxWcGC0NT9Re4uUgTLHGjOswHRzV8OLdzzEyI29Rd
         8f1+Pfefbpx6RCoaT0HtwutRId4gbPDdOzD6KdcIpv86UWc2mKgTxmQ0wAbNlINaIfjI
         aWlTQMGSiiKX7yi6+fYpc6AtyBeKn9PF4q/4n8rYYVrq26oOzT2lextXgjcTqo8ciNTc
         tAf/hJXoMB8VFXoSkQ7lJYiJaPWbcFSmNDnJEkRfSyRJYd+oe2e5Bb1FnA4fHRyNQN8v
         A9kg==
X-Gm-Message-State: APjAAAXWfpZ9nQlLHZFtSAD/iemdLI3ifihOf6A+QJcWNta7KN4SeVhP
        Ymdupsz3/soGwwEom0rs/5o=
X-Google-Smtp-Source: APXvYqz5CpDwkObS1R2IwGO8VmYfnre8DE1hgywj0wYu/Bhy4eJCqrnVnXSkttlnuMZG8f6eLn6KxA==
X-Received: by 2002:a81:50c:: with SMTP id 12mr2130734ywf.380.1565092989642;
        Tue, 06 Aug 2019 05:03:09 -0700 (PDT)
Received: from [192.168.1.12] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id 84sm20002488ywp.45.2019.08.06.05.03.07
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 05:03:08 -0700 (PDT)
Subject: Re: [PATCH 1/1] commit-graph: fix bug around octopus merges
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.308.git.gitgitgadget@gmail.com>
 <6e913ac2b6ddc080c7796e93f019243bbdce1dff.1565023420.git.gitgitgadget@gmail.com>
 <20190806092159.GE20404@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ec14865f-98cb-5e1a-b580-8b6fddaa6217@gmail.com>
Date:   Tue, 6 Aug 2019 08:03:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190806092159.GE20404@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/6/2019 5:21 AM, SZEDER Gábor wrote:
> On Mon, Aug 05, 2019 at 09:43:41AM -0700, Derrick Stolee via GitGitGadget wrote:
> 
>> In such a case, the reading
>> process outputs the following message to stderr:
>>
>> 	warning: commit-graph chain does not match
>>
>> These warnings are output in the test suite, but ignored. By
>> checking the stderr of `git commit-graph verify` to include
>> the expected progress output, it will now catch this error.
> 
> There should be a better way to check this than relying on the number
> of progress lines, e.g. 'git commit-graph verify' could print
> something specific, like "Verified 3 commit-graph files, all OK", to
> its standard output, and the test should check only that.  Or check
> only that there is no warning on standard error.
> 
> On one hand, see the recent commits 077b979891 (t3404: make the
> 'rebase.missingCommitsCheck=ignore' test more focused, 2019-06-24) and
> bb431c3dad (t3420: remove progress lines before comparing output,
> 2019-07-04), where we started to exclude the progress output from
> verification in tests like this that are not specifically about
> progress output.
> 
> On the other hand, one of my fun side-projects is to run some
> semi-automated and souped-up CI builds of currently cooking topics,
> which include a custom GETTEXT_POISON mode [1], where the poisoned
> translated progress output in this new test looks like this [2]:
> 
>   V.e.r.i.f.y.i.n.g. .c.o.m.m.i.t.s. .i.n. .c.o.m.m.i.t. .g.r.a.p.h.: 100% (1/1),  d.o.n.e..
>   V.e.r.i.f.y.i.n.g. .c.o.m.m.i.t.s. .i.n. .c.o.m.m.i.t. .g.r.a.p.h.: 100% (5/5),  d.o.n.e..
>   V.e.r.i.f.y.i.n.g. .c.o.m.m.i.t.s. .i.n. .c.o.m.m.i.t. .g.r.a.p.h.:
>     100% (12/12),  d.o.n.e..
> 
> So this makes the progress lines almost twice as long, and as the last
> commit-graph file contains double-digit commits, the length of the
> progress line just happens to exceed the width of a 80 character
> terminal, and gets line wrapped.  This throws off the line count
> check, as there are now 4 lines on standard error instead of the
> expected 3.

Thanks for pointing out that the poison runs can change the number of lines.
My intention was to ensure "we got the amount of output we expected" but it
is enough to only use test_i18ngrep to check that no warnings occurred.

Thanks,
-Stolee
