Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BBAC433E7
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 18:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 303D5221FE
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 18:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YF4g6rFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgJHSPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 14:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgJHSPp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 14:15:45 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2518BC061755
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 11:15:44 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id t77so7302189oie.4
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 11:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OmKlzQBThI0bEYpOLkJkYEZTS2KScCBjbDJKhMabZ5A=;
        b=YF4g6rFxPkRWyrcd/HH9/61pOA3U0X45f9C5ubcx3/T6gAbFh9IKV63Dgxp0TAIYEf
         kxjkho/vMYAjJK9mSjY5Er00epF1ETg+eRDjT2rK4KywIuroo3xnRCr8atw7YIekitkE
         +0+olAduN34og46K0HQwMotYvdpMMF7QTptuPwDhCDaISZKQeOQmdDdC2kpx4VYKZ5cf
         UqfJRGz4PMkE5+I+DAEXr6hK1ZR4dq9QWEFUnrxG2ALr4GPuiYiWonsJJkV5b1K9dlhI
         FRnJKv4GLQQrC9P0WyXoWjr2QWOfH1WVDT8NLfItRaDU6Fvsx+gh2hnVy58ItjGZW80L
         Oy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OmKlzQBThI0bEYpOLkJkYEZTS2KScCBjbDJKhMabZ5A=;
        b=oihXOdD4dRZb374sTxbpuZQdSBqbk7uTz/Nl2CHO6hkeAkSUr+15qAOMRB5Ptk64P3
         fytV3yH5FVNyye93dWxNCEVAgdtaZCQQGI9W3CNsZg6vYafOT7GK8jBlOFbRJi99ZJs5
         R3+c+CEpNDBhRTB6p9L4LNwlXBh7nLmY63QEUfyTcOXQL3hptIqscCK1npPo09BHrYvi
         aiD3GjCsY7TCVr2nJ3CptkBuwIJbVRM05S6ODFS7TMZjxr/9fh4Wd10rJsLjj/jdIhxN
         3imso4Fzhtav6L22TwRTw/G7GH78H0bOobWKprJCXcfEJ6yNCIOLQarX0lJNGlrBNEuo
         H5wQ==
X-Gm-Message-State: AOAM532jb54tZgotp/+dfii/NUYZVI2TWPyHVnJsDiUSOe80kG83DdGY
        paxYukr/13J7dkeOoqtzZZ49mojPaKu+tQ==
X-Google-Smtp-Source: ABdhPJwjSJhrN9DjE17jpvW1A076P9ypPS1aG6+jl1qvqRf5HmnFROWGcWByMdhij9YBH0RqLs+4Ng==
X-Received: by 2002:aca:120f:: with SMTP id 15mr46487ois.155.1602180942952;
        Thu, 08 Oct 2020 11:15:42 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:859b:7143:ba12:a6eb? ([2600:1700:e72:80a0:859b:7143:ba12:a6eb])
        by smtp.gmail.com with UTF8SMTPSA id q81sm5332087oia.46.2020.10.08.11.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 11:15:42 -0700 (PDT)
Subject: Re: [PATCH 2/2] tests: avoid using the branch name `main`
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.743.git.1601888196.gitgitgadget@gmail.com>
 <6045ceb938836355b7d43bc2088ca2504b05dde4.1601888196.git.gitgitgadget@gmail.com>
 <20201005095930.GO1166820@google.com>
 <nycvar.QRO.7.76.6.2010080957100.50@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4d093b96-cdb3-e71a-c669-ee54fbd58ab7@gmail.com>
Date:   Thu, 8 Oct 2020 14:15:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2010080957100.50@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/8/2020 4:05 AM, Johannes Schindelin wrote:
> On Mon, 5 Oct 2020, Jonathan Nieder wrote:
>> Johannes Schindelin wrote:
>>> -	git switch -c main &&
>>> +	git switch -c primary &&
>>
>> Is there a secondary corresponding to this primary?
> 
> Nope, of course not ;-)
> 
>> I guess the idea is that this is the trunk that other branches branch
>> from?  Looking at the history, it seems that this test was added
>> relatively recently and it may have had the upcoming branch name change
>> in mind (or in other words if it were an older test it might be expected
>> to use "master").
> 
> I guess that Stolee (Cc:ed) had something like that in mind.
> 
> When I look at 8d049e182e2 (revision: --show-pulls adds helpful
> merges, 2020-04-10), I get the impression that does not _really_ care
> about the name of the main branch, it just wants to know the name so it
> can switch back and forth.

The branch name here is not important, so please replace it
with whatever works best for you.

What _is_ important is keeping the commit messages in agreement with
the commented ASCII-art DAG above this test. It does not mention the
branch names, so this change will not cause an inconsistent comment.

Thanks,
-Stolee
