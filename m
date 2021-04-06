Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D73C433B4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 11:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A67CE613CD
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 11:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbhDFLPo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 07:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbhDFLPl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 07:15:41 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D570FC06174A
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 04:15:32 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id c16so14688363oib.3
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 04:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MZwLop7pzwycpWvRnRTBRwW6FitXwMUapdkSuLv9jb4=;
        b=S6JBwPwpWk9n646/MIuWAiVzRhUooWltPxd1qsAKWsQOi8OxIvPYUukI7+U/DQjqKZ
         GeVJhJPkdziL7vtLnfdGCvpG33N1wAs3APCTZ+Hf/CqiS79X240TdQ0wp1yI8n41LOc/
         L4Zm9o//pfHEDixtZlG/LdbLw4qT16HQPh1/UuGpYQpIb8e1v7/7fhNEtBPqPQW6Xg3P
         LngigmyYpnuXf4QGOJCXgE/Z3u8Y35l64YlT+PJcg2/Uz+DLMA3LaJIpR1u5Srv6qrW2
         2s78a4+oGxBqjBAYMNXagXHOF546lpWHwAGNywVqLcjm58sI4ql2QIticT49UjPzpztc
         WCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MZwLop7pzwycpWvRnRTBRwW6FitXwMUapdkSuLv9jb4=;
        b=qZupNTswHVFTXBIirG6rDlA5GQ2vxR2B/wbUCX8ms+Ed3wjGF8/MFEFZ9ZDw6Q5Q10
         k0ir8QtNcDJB024UTLWjKfQxOrhuf++aakqBoMyUyieDlc/ieXcw4+p6dyNGJc7WisRH
         URMfZTbQjJLn87zSssXhrcNbMbyOCcl3BsHElvhgEXCGirkWmW6iL0KxBEpdWbhkxk8b
         hFaOA5+66hM2bouNNGDam7Q30zYGBvd7ie7SxdKjdBDes0iAMu/KydbhtTU4wHo2W4Oc
         xN8gOgb4zdpuJy40c05bA9nPJLtriTAaKbG82+5SOG/PEDiJp3s5HyE2LM9lAGm1WO+f
         AWOQ==
X-Gm-Message-State: AOAM532409NOMmzJJcT3ocIEo34Gv7mPkiiZub0AGk8YWZgKddwtIAMD
        MIaCOChVP8wAZU3c1cmMC8M=
X-Google-Smtp-Source: ABdhPJzH5MQ9TD2K2AsfYUk6ID772P+zuu0yqUDjiZSAtsMnELsWgA1ehFxM8F0uMlZhRxCFcQPggg==
X-Received: by 2002:aca:f041:: with SMTP id o62mr2927487oih.114.1617707732292;
        Tue, 06 Apr 2021 04:15:32 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7d35:99dc:7770:379a? ([2600:1700:e72:80a0:7d35:99dc:7770:379a])
        by smtp.gmail.com with ESMTPSA id l24sm4485433otr.31.2021.04.06.04.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 04:15:31 -0700 (PDT)
Subject: Re: [PATCH 5/5] maintenance: allow custom refspecs during prefetch
To:     Tom Saeger <tom.saeger@oracle.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
 <7f6c127dac48409ddc8d30ad236182bee21c1957.1617627856.git.gitgitgadget@gmail.com>
 <20210405171652.xp63czmtsswqor2m@brm-x62-17.us.oracle.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <41a4b531-d315-9743-34cc-d9f86c335f7d@gmail.com>
Date:   Tue, 6 Apr 2021 07:15:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210405171652.xp63czmtsswqor2m@brm-x62-17.us.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/5/2021 1:16 PM, Tom Saeger wrote:
> On Mon, Apr 05, 2021 at 01:04:15PM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>> +		strvec_push(&child.args, refspec_item_format(&replace));
> 
> see comment on 3/5, think refspec_item_format is leaking here.
> this code looks fine though.

I will respond to the comments on patch 3, but this is the reason
a static strbuf is used: we can print like this without needing
to store the buffer in a variable and free() it here. Seemed like
an easier-to-use API for a non-critical area of code. I'll
continue the discussion over on that patch thread.

Thanks,
-Stolee
