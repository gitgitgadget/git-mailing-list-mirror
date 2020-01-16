Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03506C32771
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 01:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8D520723
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 01:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmGrgrPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbgAPBnc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 20:43:32 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34443 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729615AbgAPBnc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 20:43:32 -0500
Received: by mail-ot1-f66.google.com with SMTP id a15so17957937otf.1
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 17:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n5f1WSI91jUEr81qXWTcsdTKSb/K/BlRHBN7UtCfxOg=;
        b=TmGrgrPeWE4ZWx/CGsxrAZy4Uq0l6l6dKlldxw8D5Kqafn4HO+Gl+DDuyWehyj0Syy
         p6tjLSAvZI4HG1K7EHfb0XZWMow+fa7AaUJkBFF3P36zoEvfrk3Daj2BV1cnA7zM5blt
         7srbNxCrpaaeuOx9ZGo5lapWac4nLz7oSb4C+MZKL6KHwMmqwWHwCGiiSVK7JP3EzBMn
         9FinGe6G2kOaCLuR8O8plfZ4kbddC5itR2AIS86WcinfS7OzwqsxhFrPs9tfs6Ewv7mM
         FFxeOoGFgMFTZHVlbqzeLC1+dNsQk8e0pdqkCbdEzYLFdX9s7+hTnFMI2ptjHQ+7iZrp
         SGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n5f1WSI91jUEr81qXWTcsdTKSb/K/BlRHBN7UtCfxOg=;
        b=RexOZkjbV5AABlBIZCQzVVtcivlI12DyIT4E1aMNfe1RT9PO9UrEZzNtEoXlVkGdpS
         4PNCz6Ja+TXsk1Gb/ZdzJIO8hmoruL0xASq9dJ5wrzoqZsCXTd6jE8pGHYEpD+RwuGPi
         HdSKpVsM51rwHUixT04zPmdNkxVqFt4rGICoEvD8lAjDIZIhSMbiLZjCZ9yN4D3aaO77
         NlGwZiksEFKZLWZWL5VlrxAFomyK+9SfSFVOyq5jsdYlkKii96UgBufOxgWjzegNWZgG
         j6X0I45rFZzDWeCbv9tUhAUPeC1L3Nu6NMBSXcH+Z+c/bYpPSf5WJXd3krnJWqqmBtcH
         Dmsg==
X-Gm-Message-State: APjAAAV0FHeIt60Fr6clNYEXm6Z4qAdFyksn2YqDHfenYtEXSKmnGQ8W
        /WiMaVw3NlOxC4lvdZhrM6c=
X-Google-Smtp-Source: APXvYqxh9fPVRI8MjG6PcAwFCdCHHzyAx9YPKLSmEVqPVqA3VZpeOY4XLm6LFvDr3WXKG/W6ILgFJQ==
X-Received: by 2002:a05:6830:1d91:: with SMTP id y17mr178637oti.276.1579139011816;
        Wed, 15 Jan 2020 17:43:31 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id w192sm6283846oiw.8.2020.01.15.17.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 17:43:31 -0800 (PST)
Subject: Re: [PATCH] clean: demonstrate a bug with pathspecs
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Kevin.Willford@microsoft.com, newren@gmail.com
References: <pull.526.git.1579119946211.gitgitgadget@gmail.com>
 <20200116000312.GD146834@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <354fa43b-0e62-1ee5-a63f-59d9b2da7d3f@gmail.com>
Date:   Wed, 15 Jan 2020 20:43:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20200116000312.GD146834@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/15/2020 7:03 PM, Jonathan Nieder wrote:
> Hi,
> 
> Derrick Stolee wrote:
> 
>> b9660c1 (dir: fix checks on common prefix directory, 2019-12-19)
>> modified the way pathspecs are handled when handling a directory
>> during "git clean -f <path>". While this improved the behavior
>> for known test breakages, it also regressed in how the clean
>> command handles cleaning a specified file.
>>
>> Add a test case that demonstrates this behavior. This test passes
>> before b9660c1 then fails after.
> 
> Can this commit message say a little more about the nature of the
> bug?  For example, what kind of workflow does this come up in for
> end users?

I honestly don't know why anyone would call `git clean -f <path>` on a
file instead of using `rm <path>`. But, the behavior _did_ change, which
is why I'm bringing it up.

If the community instead said "this is not important functionality. We
should just expect the given pathspec to only match directories" then I
would accept that and just delete the file in another way. That seems
unlikely.

> [...]
>>     While integrating v2.25.0 into the microsoft/git fork, one of our VFS
>>     for Git functional tests started failing.
> 
> This is also useful information to put in the commit message: e.g.
> "Noticed via VFS for Git's functional test <test name>".  It provides
> useful context when looking at such a patch later.

I'm not sure the test [1] will shed much light on the issue. It sort of
accidentally reveals this bug because it happens to use "git clean -f <path>".

The test itself is holding a handle on <path> on a commit where <path>
is untracked, then tries to checkout a commit where <path> is tracked. On
Windows, this should fail. With the virtualization layer in VFS for Git,
Git doesn't actually try to write to <path> but instead VFS for Git tries
to update the virtualization at <path>, colliding with what Git is trying
to do. Hence, we need to make sure the Git command actually fails in this
attempt.

Perhaps that context isn't actually helpful. And you could understand why
I stared at this test for a long while before realizing that it was actually
a failure in "git clean -f" and then Kevin did the real work to find that
VFS for Git wasn't causing the issue.

-Stolee

[1] https://github.com/microsoft/VFSForGit/blob/1aec263033cc3c05d0389e1792b7958d9a2e70c6/GVFS/GVFS.FunctionalTests.Windows/Windows/Tests/WindowsUpdatePlaceholderTests.cs#L38-L72

