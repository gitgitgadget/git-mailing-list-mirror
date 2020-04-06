Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8686BC2BA19
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 12:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A89E20780
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 12:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G00UXGZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgDFMth (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 08:49:37 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40720 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgDFMth (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 08:49:37 -0400
Received: by mail-qt1-f195.google.com with SMTP id y25so12638835qtv.7
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 05:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=akJq6cgdfzapys8TZRDZ/pk4nXCCOB7/sIAFD1WcqIk=;
        b=G00UXGZB5hwj+4cUdG8mdO4vXwSjIdhpWZ05Y/4yXMKDLonbdIGOh0GcjW6E69XOjR
         CJkmZ9nuTKy+7BON1oYuGATyzaydFHOkVL8sVqOQjomcAbJj2DfF2hZKcu+Anu7LNRqm
         zYEUcSksX8/Rm/SdSqawYNAKuoxpWVPNC0hG8ZJHwasQCDCXxkEaZ4uEXX9XD3PArdVG
         UvaMMq9IwYt0/XqyncuQJRuh6CdX5ZTkIqD93uu7GnJp6iYoaDS/3HeYjcqLBpHKAgYN
         fL9dv9RvkxegyCFL5XvCI85oHyiLj4InD7AfbEaFs+OqaJ12tY6cMkS76/OsKCEPMGqz
         gGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=akJq6cgdfzapys8TZRDZ/pk4nXCCOB7/sIAFD1WcqIk=;
        b=deVOBDZMY1BxP9HNE0uGPH6HCEG/Wgnaw5npetv+WXMWnW6EsloxeFi7rbBJ/xd7n7
         UTYgMqLIx3hFf3WCZan+mBPVu38Hv4R7/0nP7K86C43IUh5TunvJEGRQfjGp0oV65ylv
         odzdtLs+vAFcvbVm085Vhc7z1iJNhAXCJBXx2NUt/fHZHAXGditQ3aWz/0oqzBX9ounp
         chb1MTuLSTokNzexSqWaogRzITN9wDFpOyNos1Q4iRmtkzxv7wyn2cvyNZIIk4qKdZi5
         87Ff4kn9P+gakHLoASY+riZIfaerrmQofHBNliANEGlAOFpRNlwcsadGfkDJXb5138V/
         KdSw==
X-Gm-Message-State: AGi0PubzxNJ0VygSB55KAl6Uuo4AVhwMC8jh4qv6MQXoRS9Si+Q8GqN3
        wyayNRZsrSd++YOnBmOPH+k=
X-Google-Smtp-Source: APiQypLXYIYNCVpoKD8IB8BxgWme8ohc3eIxQ0ddbUc/x6op2N6JErdZHAoOVRD3OoIxRKYhkGFb9g==
X-Received: by 2002:ac8:70d6:: with SMTP id g22mr5886092qtp.27.1586177375808;
        Mon, 06 Apr 2020 05:49:35 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f68sm14379951qtb.19.2020.04.06.05.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 05:49:35 -0700 (PDT)
Subject: Re: [PATCH 09/15] job-runner: load repos from config by default
To:     phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@google.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
 <9104ae46371a08967805f6ce27586ccade37972a.1585946894.git.gitgitgadget@gmail.com>
 <29e32e80-a546-6e43-8d03-bafca03681ec@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <92e8290c-a8ff-fc4f-1da3-1ee8c2636bce@gmail.com>
Date:   Mon, 6 Apr 2020 08:49:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <29e32e80-a546-6e43-8d03-bafca03681ec@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/5/2020 11:18 AM, Phillip Wood wrote:
> Hi Stolee
> 
> On 03/04/2020 21:48, Derrick Stolee via GitGitGadget wrote:
>>   +    config_repos = git_config_get_value_multi("job.repo");
> 
> Does this really re-read the config files as the commit message suggests or just return the cached values? Perhaps the runner could exec itself with a --run-jobs option to actually run the jobs so that it sees any updated config values.

You're right, I need to double-check that. I'm guessing that you are
right and it uses the cached values. This should use the run_command()
pattern to ensure the config is as new as possible.

Thanks,
-Stolee

