Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0497DC433E0
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 00:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE4E420798
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 00:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbhACAdw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Jan 2021 19:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbhACAdw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jan 2021 19:33:52 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0541AC061573
        for <git@vger.kernel.org>; Sat,  2 Jan 2021 16:33:11 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id l7so11398849qvt.4
        for <git@vger.kernel.org>; Sat, 02 Jan 2021 16:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5/aHrfmlBPFXHIyaS5C9VpLVaLLRDFaN2e9pb/2298o=;
        b=PGVpn3dKNkzZPhsEMIz6ZQGRY573m2Q7UWTIfY/+kLtOBH4vJSfJd9Xl6QG3G6HDfz
         GzynDKT5p42MpGJM0fLMwEiXG4l5siTcgfvKEPpbci19WHdEJCtcToVBpYQ1pXIoVUU2
         /cRvnum1VVpCoVyj79RjQWFkE1geXJpEsO7r3FH8CzVKXhqW58waoNQAg0AsMoQgkLW3
         jCQgAz2gBIShI6YHnvNuGvkya1yKsanE4tSzYonkqbNu+jCGkja+tSn66WCVWz4TPNNV
         BJZzCO16QBAwXLUkHtpNf6QHodL+wMwj4fQNualQ75AoHXLdQfAtGRtK/mY2352c4s3M
         pyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5/aHrfmlBPFXHIyaS5C9VpLVaLLRDFaN2e9pb/2298o=;
        b=NuocMxcoJtyhOgMpZz2WSqcFWVW/FIDFTTGhJ/dWJG0ZHkKyGNZD09TwhSXwWVlIqi
         HPAyOQ8QNMT/x0uSWTQn5Lght5SI76jOOlRvB3DmzySvbI9Jd21lY8SGSsqNSMv1sHiq
         w8OY3bVY6WynKotkZcC0hvh9ApOo1g+B2iuG1ZYYctyRQ4hhFYmkgelJzdi2lF8utMnF
         rZeC/9JddZz+QPftVaqdCjtw95QED8AwKtHXKV29O+3L74IyQbqzI3HCmiWMBYViFjHn
         rxA62kKuTixOIo21NxLUuLPjcy9ZKB7GzsUPN7VY/BefE/zN11yA5Xsc5CeWthsoUKKa
         tgdA==
X-Gm-Message-State: AOAM533UbEaYCPK6Rqr+YyKaqebW60xMVBk5kccRCfn0Tg2jS4dqvEqa
        grmg/u+XY5H50ALWhbDd0kg=
X-Google-Smtp-Source: ABdhPJxJvE3Tn+wgp6SQRjn12GetXClJobjKntqx7u+gHR3OBL89lAq+4l8qPwsSNOxl7o+22yJWKw==
X-Received: by 2002:ad4:46e7:: with SMTP id h7mr70904724qvw.44.1609633990618;
        Sat, 02 Jan 2021 16:33:10 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id f10sm35004296qtg.27.2021.01.02.16.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jan 2021 16:33:10 -0800 (PST)
Subject: Re: [PATCH] gitmodules.txt: fix 'GIT_WORK_TREE' variable name
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Gustaf Hendeby <hendeby@isy.liu.se>,
        Felipe Contreras <felipe.contreras@gmail.com>
References: <pull.942.git.git.1609616245412.gitgitgadget@gmail.com>
 <CAN0heSqC3K6pJOr2ztz56+ZpKaMomA28rc4W5x8n0cC3K-rVgQ@mail.gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <2411086f-b6d6-98c3-bbb4-53ea8956c765@gmail.com>
Date:   Sat, 2 Jan 2021 19:33:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSqC3K6pJOr2ztz56+ZpKaMomA28rc4W5x8n0cC3K-rVgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin,

Le 2021-01-02 à 16:34, Martin Ågren a écrit :
> On Sat, 2 Jan 2021 at 20:39, Philippe Blain via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>
>> 'gitmodules.txt' is a guide about the '.gitmodules' file that describes
>> submodules properties, and that file must exist at the root of the
>> repository. This was clarified in e5b5c1d2cf (Document clarification:
>> gitmodules, gitattributes, 2008-08-31).
>>
>> However, that commit mistakenly uses the non-existing environment
>> variable 'GIT_WORK_DIR' to refer to the root of the repository.
> 
> Good catch! I wonder what we should conclude from this having gone
> unreported for so long.
> 
>> Fix that by using the correct variable, 'GIT_WORK_TREE'. Take the
>> opportunity to modernize and improve the formatting of that guide.
> 
> It's a small correctness fix and some prettifying while at it. While I
> read the diff and realized that it was more than just one or two
> asciidoc tweaks in the immediate vicinity, I started wondering if this
> should be presented the other way round: "Let's update the formatting
> and fix s/DIR/TREE/ while at it." Or to split it up. But I don't think
> it's worth thinking too much about -- what you have looks good to me.
> 
>> @@ -32,14 +32,14 @@ submodule.<name>.path::
> 
> Just above this point, you have another s/\.gitmodules/`&`/ waiting to
> be fixed.

Thanks, I added that.

> 
>>   submodule.<name>.url::
>>          Defines a URL from which the submodule repository can be cloned.
>>          This may be either an absolute URL ready to be passed to
> 
>>          dirty;; All changes to the submodule's work tree will be ignored, only
>> -           committed differences between the HEAD of the submodule and its
>> +           committed differences between the 'HEAD' of the submodule and its
>>              recorded state in the superproject are taken into account.
> 
> `git grep -B10 HEAD CodingGuidelines` suggests this should be `HEAD`,
> not 'HEAD'. Maybe you followed style -- there's an instance of 'HEAD'
> earlier. I think both should be `HEAD`.

Yes, `HEAD` has indeed more hits than 'HEAD'.

> 
>> -If this option is also present in the submodules entry in .git/config
>> +If this option is also present in the submodules entry in `.git/config`
>>   of the superproject, the setting there will override the one found in
>> -.gitmodules.
>> +`.gitmodules`.
> 
> Should "submodules entry" be "submodule's entry"? I've never worked with
> submodules, but that reading somehow seems more natural. (There are two
> hits for "submodules entry" in this document -- both might be worth
> looking at.)

I agree, I also added that.

Thanks,

Philippe.
