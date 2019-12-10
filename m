Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4177AC43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 13:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100E8207FF
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 13:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOOxJyuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfLJNp3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:45:29 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46681 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfLJNp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 08:45:29 -0500
Received: by mail-ot1-f68.google.com with SMTP id g18so15462762otj.13
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 05:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r2Aj4kdLXXvyOK29peCuI3LgaRN1nnOqnH3jD+il0BI=;
        b=hOOxJyuWN2GhJVPMo+dtl/884KffmAvRcYWE/pEHGy5EUrUZipBdCQIXpGOelFHYlv
         310rx3+pl+JgJ1ZwxcTrDrGzUT8vIWKI2YFrM/r/zeOT+x1z0udcjYzQzCk3xuNraaNZ
         rFApKM21JAemadpITW5JYPFEr66Y4EWJ6YpI8WtDAZgOatpdRkja2kBzcY7gcWgHeub3
         Af3vSfc1e2IlHsHZwAO+VdOw7WCdMSYP0+Y5zY8yRDBT3aAScBeYN4FaZVusiv6bNCsq
         bd8a24MT1/gBRgKYh4z91z8ZFu1pin40mvwNClrkebcc1PS8S5VeLqjVK/niQHWJ9Xu6
         n6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r2Aj4kdLXXvyOK29peCuI3LgaRN1nnOqnH3jD+il0BI=;
        b=JHT/nfTzfbCfc7A71nxTnnBiJZb0KwbK5Hm0YgZZGDlH+y8rnyt3nHxb3rvUwlBhH7
         hjYUsF/3h47u3nF47Yw1bdXCW1ho3k71GOSwio/hc9INr3p95QzlUn0G1NYWzd+V8UDO
         3Hu0HHey6fRl1vY9MsK6LcLcP7CRbPWxtahUjDx6diQzCn1vLrCP3fygB2wxXuFe9ri4
         1+7sO0Y7NAxoXL1tEDkrck364+/nHEFRr5MdObDYVAfx8zNX++MvbS9sdOZSGSaVtNXK
         /BoV180w45Vxgh/uCPhyLkZrDzmExncaLRqt3cW3yoR3C8jjLCKPAuR9PJ8YjAv5CsCG
         4SkQ==
X-Gm-Message-State: APjAAAV8CZHrWPkkjU316kzpM9IOAPxvhC/X5vvXk7jtAgLo0Zj6pEya
        14lWzJx5YeQZ+ryzKDq1a7Q=
X-Google-Smtp-Source: APXvYqyShVKiSIknWOnm/SY4HtjGQxu4SnQslUKzv13AL+fEPJ2zlQ/WUlnWRzktUNOO/WCiwbTP/A==
X-Received: by 2002:a9d:67d8:: with SMTP id c24mr10282153otn.172.1575985528538;
        Tue, 10 Dec 2019 05:45:28 -0800 (PST)
Received: from [192.168.1.76] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id b20sm1381169oib.1.2019.12.10.05.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 05:45:27 -0800 (PST)
Subject: Re: [PATCH v2 4/8] t3030-merge-recursive.sh: disable fsmonitor when
 tweaking GIT_WORK_TREE
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ukshah2@illinois.edu,
        Kevin.Willford@microsoft.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
 <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>
 <efc16962ee2595db50bf051fc84632b8c70036b3.1575907804.git.gitgitgadget@gmail.com>
 <20191210100732.GD6527@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b3e8ad07-b2cb-e024-405e-27d9f065f5fc@gmail.com>
Date:   Tue, 10 Dec 2019 08:45:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20191210100732.GD6527@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10/2019 5:07 AM, SZEDER Gábor wrote:
> On Mon, Dec 09, 2019 at 04:10:00PM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The fsmonitor feature allows an external tool such as watchman to
>> monitor the working directory. The direct test
>> t7619-status-fsmonitor.sh provides some coverage, but it would be
>> better to run the entire test suite with watchman enabled. This
>> would provide more confidence that the feature is working as
>> intended.
>>
>> Worktrees use a ".git" _file_ instead of a folder to point to
>> the base repo's .git directory and the proper worktree HEAD. The
>> fsmonitor hook tries to create a JSON file inside the ".git" folder
>> which violates the expectation here.
> 
> Yeah, there are a couple hardcoded paths in there, e.g.:
> 
>   open ($fh, ">", ".git/watchman-response.json");
> 
> and, worse, not only in the test helper hook in
> 't/t7519/fsmonitor-watchman' but in the sample hook template
> 'templates/hooks--fsmonitor-watchman.sample' as well.
> 
>> It would be better to properly
>> find a safe folder for storing this JSON file.
> 
>   git rev-parse --git-path ''
> 
> gives us the right directory prefix to use and we could then append
> the various filenames that must be accessed in there.

Adding another git process inside the hook is hopefully not
the only way to achieve something like this. The performance
hit (mostly on Windows) would be a non-starter for me. (Yes,
the process creation to watchman is already a cost here, but
let's not make it worse.)

Perhaps a better strategy would be to do something in-memory
instead of writing to a file. Not sure how much of that can
be done in the script.

-Stolee
