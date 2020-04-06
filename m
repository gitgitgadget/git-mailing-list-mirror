Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFC1C2BA1A
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 12:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FFC3221E8
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 12:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0SlTkFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgDFMsL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 08:48:11 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45912 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgDFMsK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 08:48:10 -0400
Received: by mail-qt1-f193.google.com with SMTP id 71so5818701qtc.12
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 05:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k/58GvzDUScdC87+B48TwaHYAWlTQis77iRn1/ejSeQ=;
        b=H0SlTkFosU0VN2dL9oTBvXbhD8l3T1ZEDTT+pSPNypyKqLWHwHXAXpTwgdE4D62mhf
         mGTVnUt9OkTzwM8LW6xbCGcgLoZnRGQcwsylfDUeFdZYBSyAeYD/iEzvptEuK8fee5Ca
         PEeAoVmTHx4+eMVDKfArgT2N/WHkCBF2b/T6dAWZusWz6TLLsNRw2wfqUPk22VR/FUsL
         aqcCMgzRQMglkYSmZrvlis6vGUcFnTaVNlZIp1el4kWM3u/Cpgx46cw1drpsXE+UGaOw
         +yyAJIhy3JqorH22GjavLlj5YHrL8Pc082lUPMzD0WEos8Lz963EvU60GR8fi2pFxXnx
         S6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k/58GvzDUScdC87+B48TwaHYAWlTQis77iRn1/ejSeQ=;
        b=m3Eeee2Nnp+LbSOlHkcRFpo+As+/1nPjHqPIGLOBjYVh25dCAr6rJNhPCEVBAvm7Cc
         0ix5E4qVN/Z+HEZSc5ja0HCoytOUD0t0KNWZpGQam5igcpHw94Yhyzrv/Bw8SPxY0Bm7
         vgngmE6gVBxb3cJEJHoQ2hoX7RJeuWQUm4hD9XeFfj7xiICZh5IJI5ndU5Y8jKeMC6Du
         t/yUx1biUkkhZ2M0N/paMCqipixcklPu+ypdrKbGKp74utWB2AfQJxm9hADW9Ite62Lt
         SrXaXF8R1SxnDwcap0dPiyjy2CT+oytp+VWHOoQnxZfgxWview0HvVJHrTVl027AQ6Ou
         0NQQ==
X-Gm-Message-State: AGi0Pub8NRcNQTAJOhTRE3QMDRMszuNbxn0MihfhtPgza94pQrXN/MqU
        knN9J0fXYsqzZrE2ShWxfpg=
X-Google-Smtp-Source: APiQypIhrzNA9EUIIONl3D6/Q1kAF/QGaDz2i8DLDipfqOYTjbjDIDBQKCtOhfK51dkD6mGYz4osCQ==
X-Received: by 2002:ac8:f23:: with SMTP id e32mr381986qtk.368.1586177289056;
        Mon, 06 Apr 2020 05:48:09 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id j32sm7556124qtb.20.2020.04.06.05.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 05:48:08 -0700 (PDT)
Subject: Re: [PATCH 03/15] run-job: implement fetch job
To:     phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@google.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
 <77b1da5d3063a2404cd750adfe3bb8be9b6c497d.1585946894.git.gitgitgadget@gmail.com>
 <0e924507-e77e-bff9-196a-e73f296a99d9@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e023974a-e1a0-31f6-e7ac-daf74312fb2c@gmail.com>
Date:   Mon, 6 Apr 2020 08:48:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <0e924507-e77e-bff9-196a-e73f296a99d9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/5/2020 11:14 AM, Phillip Wood wrote:
> Hi Stolee
> 
> On 03/04/2020 21:48, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>> RFC QUESTIONS:
>>
>> 1. One downside of the refs/hidden pattern is that 'git log' will
>>     decorate commits with twice as many refs if they appear at a
>>     remote ref (<remote>/<ref> _and_ refs/hidden/<remote>/<ref>). Is
>>     there an easy way to exclude a refspace from decorations? Should
>>     we make refs/hidden/* a "special" refspace that is excluded from
>>     decorations?
> 
> Having some way to specify which refs outside of refs/{heads,remote,tags}/ to show or exclude from decorations would be useful I think. Fetching to a hidden ref is a good idea (as are the other steps you outline above) but as you say we don't want it to show up in the output of 'git log' etc.

I'll work on this first. It seems less controversial.

>> +static int fill_remotes(struct string_list *remotes)
> 
> Isn't there a easy way to get this using the config api rather than forking 'git remote'?

You're right. I should have used the config here. I've been overly
biased to how we do it in the C# layer of Scalar _plus_ how I wanted
the job-runner to run "outside" a Git repository. This could be much
simpler with the config API.

Thanks,
-Stolee
