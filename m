Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3599C433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 15:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAFEF613DD
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 15:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237595AbhD0PwE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 11:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhD0PwD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 11:52:03 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC2AC061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 08:51:20 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id z7so7915845oix.9
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 08:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HcflwbuAH0n+tyXZyx+bl9zZPnpV1PZUx4D8BnnKfLU=;
        b=WKTnv0oW3Cj7E6/c33bXC4Vcj8eJKEQfxbRVsDgZsryFFfjL5x018Vj+Syw3pLdso8
         ZdDskSQwxFsdu53S0T06C8OVpbrcndyVuAFpUjo/taaJ9Jvk+zy17DQdYK8hEnqn1B1z
         +XiKLOqgb2XuVUIYwfP8x1pG8IXl1xw4I4mFNmZTdh0mR7T2yF7VGeTYKnuDpevi0dtv
         nW9mElV9xG6OJiIHhcZyLiQWq3I/DBce+TbaPBWp9wRJNu4mzjqw/NivjMjulj316QsZ
         0LAhUD+B9QPi1bbjsbb8z1JMsaBe9xZTpHihSkJWe2lsJ+VHwwMbaIan1lKCHbzm0kQX
         eB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HcflwbuAH0n+tyXZyx+bl9zZPnpV1PZUx4D8BnnKfLU=;
        b=Z4vvqojxb2axKXE2+eIbc1/nvJ/BtDkcdCZFdQQNBwFK7Sz4VsvHdm2F0WSZ4vhloV
         AP1EkiD5ABpKmEWtxTAAhnAj6Qzt7ZoY/3vLDUu6VQW0v2EKLY5pa2yQ066vWBQCFH6v
         kB2pxaR2d9E728m4SaLV27TGUTkkT9M+nV6xwen4MxASvA7OQ2PZg3K0gVHQRWSe2AtI
         NcEAcPAjc+fT0JesQPqJT5bHJYXm2OhexoX5TVFELy3IWTq36m941Y+VLNDLqsz7q48y
         crCQVWpYfv7m3aXm8cmed4gCK32qvTPKVvas4JMMTD7YtY2bLxC6wz3KpRN+NeXG4+HX
         4h6A==
X-Gm-Message-State: AOAM531sMIVBFJHkLrsZM9EqtXvKilpHbNt1ae0t/OV0JaeqHU9aXmsN
        lZU5AKWb3pUDg+nBdeLybEQ=
X-Google-Smtp-Source: ABdhPJxzKHeTi6fd+2LwKDic4eFCpv3mWEMkvN+3rQbCEltAk+DH9Rp8aDRKyouiIj3GNyb4zHSV0g==
X-Received: by 2002:aca:a914:: with SMTP id s20mr2943296oie.62.1619538679411;
        Tue, 27 Apr 2021 08:51:19 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3839:9ece:547d:49e5? ([2600:1700:e72:80a0:3839:9ece:547d:49e5])
        by smtp.gmail.com with ESMTPSA id a10sm48166otl.15.2021.04.27.08.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 08:51:19 -0700 (PDT)
Subject: Re: [PATCH 23/23] t7527: test status with untracked-cache and
 fsmonitor--daemon
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <3eafd0b5cb09dbba8af2abf1a8d602ad27ad3bc4.1617291666.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <14045741-64ea-5274-ae6f-aec832272024@gmail.com>
Date:   Tue, 27 Apr 2021 11:51:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <3eafd0b5cb09dbba8af2abf1a8d602ad27ad3bc4.1617291666.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/2021 11:41 AM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Create 2x2 test matrix with the untracked-cache and fsmonitor--daemon
> features and a series of edits and verify that status output is
> identical.

I value the detail here. It also signals that there is something
interesting going on with the untracked cache, which I have also
discovered in my testing of this feature. I'll follow up in a
response to the cover letter.

Thanks,
-Stolee
