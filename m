Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18B9C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 17:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E402067C
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 17:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOA77mNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgCLRei (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:34:38 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41067 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgCLRei (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 13:34:38 -0400
Received: by mail-qk1-f195.google.com with SMTP id b5so7588566qkh.8
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 10:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fyk0qcO0CXPGcHkNVhwPWApkgcIZKvH+fajrQrWY+EA=;
        b=bOA77mNCdcb5IetxX8++rPwqltgYSnUeQY7YdOhsX/aqZC9Mc4yid0FvoH0IUKrn8m
         Ubk/Yfj3wDcDVceoaOXSQVd1AL/O1zlKypW+xHImZ7R0i3hCN38Du4FFCyLXnajBUw/s
         4OPj7r+TYgdpHtEimUfqISG07k3u2eKSGD8n+BDQP3uyu1xert+iwI1JVXO0Ds41Rcep
         PkEQwyu5MfMX45MNfZWHMaFY9KqEBJCfTqLfr3e1TPM72r8TmOKxm087MdNfISfAzEao
         eW7CU5towB/MzhyqHddROYtOI1iAF6M7DQoAdWamOkrOG/+Y7Bbi2zU5t0ZqSu2MmZ1C
         cTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fyk0qcO0CXPGcHkNVhwPWApkgcIZKvH+fajrQrWY+EA=;
        b=rmSSYAeikIpG+qj2uImnHvVBhhenl06r0TAk/XScky0VNXGEb6FyGHbObQPZU0bu96
         QX7+hZf7prBmK1QvKR70a4yOVXbSFfIFxUqFYrHfKgytjxxL9l4ghl8fyBgLR8H/mkPu
         +WU/yYt599vfsRhkeYV/OPbXcdy0j3jTyI4h4k7AgO5fV5gerLjphI1islK6Y9+2fyWe
         UAUtztFvBD/ESzTl0y6o8BCKuoekA5xbf0BGSGkVZaDCSAeaMQLu72vk8yt3Qz3QRoP9
         amXdErceD6pnwvyW/uvcpGuFrP2ZvIQ1qFOTRtykYygZ8z631/raKNq2A70du+N6Be4S
         JqrQ==
X-Gm-Message-State: ANhLgQ1wzJ6zJyepLCUIp9SGL3jbMWgJZ0XWCXYoNiNnp2kb/JzoBWXL
        UPsaTowF+fUulQuAHuWk2Qs=
X-Google-Smtp-Source: ADFU+vt7qetaU7RRe5SiRUcwyxW01PUfkIDGOBXxMqWTyxVOusJMX32lUbAevhchuAqZFeHMeTGYiA==
X-Received: by 2002:a05:620a:15ef:: with SMTP id p15mr3189221qkm.64.1584034477261;
        Thu, 12 Mar 2020 10:34:37 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id l2sm4129241qtq.69.2020.03.12.10.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 10:34:36 -0700 (PDT)
Subject: Re: [PATCH] connected.c: reprepare packs for corner cases
To:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, me@ttaylorr.com, dstolee@microsoft.com
References: <pull.579.git.1584027403779.gitgitgadget@gmail.com>
 <20200312163939.176298-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fea393f7-de8a-73a3-6139-aa1f6a78089b@gmail.com>
Date:   Thu, 12 Mar 2020 13:34:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <20200312163939.176298-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/12/2020 12:39 PM, Jonathan Tan wrote:
>> Placing a reprepare_packed_git() call inside chck_connected() before
>> looping through the packed_git list seems like the safest way to
>> avoid this issue in the future. While reprepare_packed_git() does
>> another scan of the pack directory, it is not terribly expensive as
>> long as we do not run it in a loop. We check connectivity only a
>> few times per command, so this will not have a meaningful performance
>> impact. In exchange, we get extra safety around this check.
> 
> This also means that check_connected() now does the equivalent of
> reprepare_packed_git() in both its branches (the rev-list one, which
> spawns a new process and thus rereads the pack directory, and the fast
> one). This will at least help callers to reason about its behavior more
> simply, so it sounds like a good change to me.
> 
>>     I included how I found this (integrating v2.26.0-rc0 into Scalar), but I
>>     am able to reproduce it on my Linux machine using real fetches from
>>     github.com. I'm not sure why I was unable to reproduce the issue in test
>>     cases using the file:// URLs or the HTTP tests.
> 
> If you remember how to reproduce it using real fetches from github.com,
> could you give us reproduction steps?

Sure. Run `git init`, then replace the `.git/config` file with this:

[core]
        repositoryformatversion = 1
        filemode = false
        bare = false
        logallrefupdates = true
        symlinks = false
        ignorecase = true
        repositoryFormat = 1
[protocol]
        version = 1
[remote "origin"]
        url = https://github.com/derrickstolee/TreeSearch
        fetch = +refs/heads/*:refs/remotes/origin/*
        promisor = true
        partialclonefilter = blob:none
[branch "master"]
        remote = origin
        merge = refs/heads/master

then run "git fetch origin". I purposefully put a very small repo that
I have laying around, but this repros with git/git.

Thanks,
-Stolee
