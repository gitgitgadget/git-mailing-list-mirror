Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE7FC2BB1D
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 10:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07C72063A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 10:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNBP4JeM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgDGKyi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:54:38 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46306 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgDGKyi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 06:54:38 -0400
Received: by mail-ot1-f67.google.com with SMTP id 111so1228824oth.13
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 03:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2Glp5svA5PrDFvOkqRxGYeusiRyD7u20Ef+/J5rivuE=;
        b=QNBP4JeMH4NDMU/LCY7gIqN6XRzRg7QKuqFHncMfZ5cGD7GWltIy0eZunRmK0QO0XT
         5Q0sHunZMFhgCZCUpDsT6iZhyPGyHkaIoseNBoIJn6xQYGvS4iVXXmwDRmJGGaZ9Aqq7
         awuQcTneEujAEsFwF0Urd/KCf4NKj6Pa/GkFJMPDOnTRwfN5mnyi13tpjsCVaLkqYLIK
         cfggz8gdCmg2Quj8gWMRX8BlWJH1YvndIJp8EH04og1iELIn6mLG1fASDOotCYNMPdAq
         9WrLjFGjl1eIxidJgaVKP15LtWwZUF9K3YpKCNdnotAEVLpmKpALpBaAxnvovxCWYIqD
         KHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2Glp5svA5PrDFvOkqRxGYeusiRyD7u20Ef+/J5rivuE=;
        b=muJ//EemkZwDqum7LVRnY4iWtp2JC5EyM/rlnXzAs9Pm7hFFobVRk3vW+PYQYq1TVC
         lD/Rf2iOcrhTFqmZeO+aZcmq+t2LCmsNt4qzI8+X9wSOuYwYBmdXSwRRg+sEMJ43l1F6
         txkoVGNZ5K2HlLYeo2EUB1+lZrDBaqVq6eAQiiYt1+P6fvqP6Ep2wM2LAXCGrTloxohz
         +TRr1DMT8lMDem6dhUbf6hsykarhVV58LjnwvegFuD0VclyaeqAy8OO6hlclUuQhSgTf
         2aJm5IDD0lC08v5efPk4kGNVEp/tScTG3PQ+nhagUSWaVvCTgHY7FztwVF4PZH0Qjtqi
         KQ2Q==
X-Gm-Message-State: AGi0PuZycqbJuHs01N1YhDnnVPWMvNb5NcqoBBeSxYuns3rbnbzrdJgT
        iu8PCmvQMKHvyukc+7/WJfEnwHmqnGQ=
X-Google-Smtp-Source: APiQypJi6oFYiHjlDG9jQhE569AWSM0vKavGe0GF3G2HiwdWkE+3lhMHvEK24VwfAl2TkD+v36Dy/A==
X-Received: by 2002:a4a:aece:: with SMTP id v14mr1329456oon.48.1586256877162;
        Tue, 07 Apr 2020 03:54:37 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id q18sm3615966otl.65.2020.04.07.03.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 03:54:36 -0700 (PDT)
Subject: Re: [PATCH 01/15] run-job: create barebones builtin
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
 <665da239774419074a9bae49b9c92b340885bfa3.1585946894.git.gitgitgadget@gmail.com>
 <fc5e6823-ebb3-df58-d7fc-6fb2b58cffe8@gmail.com>
 <xmqqimidybzu.fsf@gitster.c.googlers.com>
 <208bdbc7-9c8e-5105-0627-7db86135db7b@gmail.com>
 <20200407005828.GC2568@danh.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <806dc7e9-9980-2c05-461f-9f3a62598244@gmail.com>
Date:   Tue, 7 Apr 2020 06:54:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <20200407005828.GC2568@danh.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/6/2020 8:58 PM, Danh Doan wrote:
> On 2020-04-06 10:42:23-0400, Derrick Stolee <stolee@gmail.com> wrote:
>> Of course, not every platform has "cron" but that just means we need a
>> cross-platform way to launch Git processes on some schedule. That could
>> be a command that creates a cron job on platforms that have it, and on
> 
> There's Unix system that doesn't have cron.
> People could use other scheduler mechanism.
> 
> A lot of systemd users uses systemd-timer.
> I'm using snooze.

Thanks for listing some alternatives. I'll look into these.

> Each of those set of utilities have different grammar and
> configuration.
> 
>> Windows it could create a scheduled task instead.

>> 2. "run-on-repos" uses command-line arguments or config to launch "git
>>    -C <dir> maintenance run" for all configured directories. The
>>    intention is that this is launched on some schedule by a platform-
>>    specific scheduling mechanism (i.e. cron).
> 
> So, IIUC, Git will have a _hard_ dependencies on cron on *nix?
> Else, we're gonna received a bug-report that some tools doesn't work?

No. Such a dependency would be unacceptable. I'm just using cron
as an example when available.
 
> I've seen some bug report in our distro that "git add -p" doesn't work
> like documented, because it's in "git-perl" packages.
> When we merge "git-perl" back to git, other people (who never use
> "git add -p" and git-sendemail) complain why does we add a hard dependencies
> on perl to git.

Good news: "git add -p" is becoming a builtin with a lot of work by
some determined contributors.

Thanks,
-Stolee

