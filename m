Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C157C4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 08:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06ADF20724
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 08:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuSmaCIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCSInk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:43:40 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:43393 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgCSInj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 04:43:39 -0400
Received: by mail-pl1-f169.google.com with SMTP id f8so758273plt.10
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 01:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=32JEzhd2CyfrB1mGFgQzHYC8IK9fmcYIXKNpiNg6oLk=;
        b=UuSmaCIJPyj3nrwYT8gn/yk+4+cN/AO3+W4jL96T1peK+oTMRauu17Aoc5UWjINlGK
         0EgpHvE+krJsynaqaQPNWWVHFeo6rq+SjngzldmJWXQ4dYDlu0AvpFN1Ect5Rf/vH2/p
         RtLcaT+d83EVMa28Ce0J9Op5Dlrqye0agv54Lr6E2Clk3yxJMlAcom8XODg9UFD13scQ
         1oc3pjtGjuU9GJxh10BVsjxnN5GHZw8iaAlA4vI8xJT6rA6USSIv65TJJ8QDmTvXfqxj
         8O7k//ObBBs5HMSH8t4ClyEUJArQ+5J4HDy3BPZ1FilEbHLPuuPD0FIN7BRR7w78ojla
         +Z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=32JEzhd2CyfrB1mGFgQzHYC8IK9fmcYIXKNpiNg6oLk=;
        b=nrbDakUdh1GA/914u0UkVJdVa+uJtZyZH1jPyTJXfqS97Py/isxOaRfbsItRBg9TCc
         23q9VASJdx4eG8N1HiWIVt1EfKDwKNw0JoB2ZdgNiBm4zXPNq0cswwSYNcZf5YCygUZ2
         P28yMx62VLpzFbRkOreRld/ZhRkG5oS4mVkTd7ThukNCZpty4+ov3MFKrrMNKM0V1qVJ
         uD3CH2XxtN1sjHNNa6nkxhpXj+cnLqIhIDwNgptzKHePvsFn86O2yVyy162Y6apvkMCH
         IVcL2oP/TW4SrCn8eEnm6vEskFoBPO6yvGLXjVEBIi2czsGvMsZvB6rcyPQBIrOmRiNL
         FwVg==
X-Gm-Message-State: ANhLgQ3EE+tT+snqZrZJ1D6GfBMMmdDSUubpToc5ixFF5Rdr9FGIhTXg
        lYKm0RBx5fFOc2MApiyI58c=
X-Google-Smtp-Source: ADFU+vu+Tntp87Ssg4/VqmMdVCPN9wkbUvNKGvTv11NtasZhC8+Zpyh/S+KvNS6Sni4xqq/Hh9+cIQ==
X-Received: by 2002:a17:902:7441:: with SMTP id e1mr2259033plt.291.1584607418388;
        Thu, 19 Mar 2020 01:43:38 -0700 (PDT)
Received: from [192.168.43.191] ([106.198.9.151])
        by smtp.gmail.com with ESMTPSA id w5sm1583559pfq.80.2020.03.19.01.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 01:43:37 -0700 (PDT)
Subject: Re: [GSoC][RFC] Convert mergetool to builtin
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>,
        christian.couder@gmail.com
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <CAHk66fu7dZ4H8tvnbxfdBRcRdx-3f_cJSdVAoKrE3UbR3nehfA@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <1bb8e4f9-6e6e-0874-b1ef-47eccf93a98b@gmail.com>
Date:   Thu, 19 Mar 2020 14:12:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHk66fu7dZ4H8tvnbxfdBRcRdx-3f_cJSdVAoKrE3UbR3nehfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abishek,

Just wanted to share a general suggestion which is not related to your 
proposal. In future, when you quote a portion of the e-mail retain the 
complete meta information about the quote (like the one you see below) 
or the person who wrote the quoted portion at the very least. It helps 
people who join late in the discussion to *quickly* get up-to-speed with 
the discussion.

Anyways, good luck with your proposal. :)

On 18-03-2020 22:00, Abhishek Kumar wrote:
>>> ### Conversion of mergetool--lib
>>>
>>> As mentioned earlier, conversion of the mergetool-related scripts has to be
>>> spread over 2-3 SoC or similar projects due to the size of scripts involved.
>>> Conversion of mergetool would set up most of the plumbing required for
>>> mergetool--lib and makes the subsequent conversion possible.
>>
>> I wonder if it would be better to convert git-mergetool--lib.sh first
>> and then git-difftool--helper.sh and git-mergetool.sh that are using
>> it.
> 
> I had been agonizing over this decision while I was initially writing
> the proposal.
> 
> My justifications for mergetool.sh over mergetool--lib.sh at the time were:
> 
> 1. mergetool.sh makes many more calls to git subcommands than mergetool--lib.
> Therefore, its performance improves from both moving from bash to C and use of
> git internals.
> 2. I had *incorrectly* counted overall lines to be over 1,700 with
> 1,200 lines for mergetool--lib + difftool--helper + mergetools/ whereas it
> actually stands at rather manageable 1,000 lines with mergetools/ being fairly
> formulaic.
> 
> There are solid reasons to consider the conversion of mergetool--lib too:
> 1. The code path of difftool-helper would be entirely in C, improving its
> performance on Windows particularly well.
> 2. It has two well-defined entry points, which makes conversion straightforward
> and with less code churn.
> 3. It could be done with the more frequently-adopted approach of script
> calling the builtin.
> 
> As it stands now, I am open to converting either scripts.
> 
> I have CC'ed Johannes as well. I am sure he would like to weigh in
> this discussion.
> 
--
Sivaraam
