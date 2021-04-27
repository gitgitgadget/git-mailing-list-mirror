Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219C2C433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 13:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB824613D8
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 13:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbhD0NhI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 09:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235875AbhD0NhH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 09:37:07 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4D9C061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 06:36:24 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso53395264otb.13
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 06:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2YxB8tBhcehKJoWDgacmb4ccVvzTanDpLIkr3tZXYc8=;
        b=hPRfb5jlU0UgIjNXpgIWbriYbj38rxiFJIhaJJvNMkAzYTMYCQRgM+TUsTGdOuSYQy
         C4NSI8kdsPbYGNIfRDswUDe4B7LiKQlxwd+witMDvTF3DvXPtQG27sjZ3gNCcE9T0j4J
         yniZvbFmE0PhXp+wp4y5ooSZz7O7g5eHHyoH70XNdA0UNEHOmynqznbf8X/3QDS3UizE
         GZgDq4DC3CLf1jaKK951lKjiGyZrYUMsyv9Bz5qNcQaCn7/+6MQwhJ+/8t7IokmhcKYJ
         9sRkEXMvmnup3BY0YN8FUjsCl0i4WqxgIM4Tkodh7bJZqgw7b39vJpwIw3jKMqxuwYNV
         RBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2YxB8tBhcehKJoWDgacmb4ccVvzTanDpLIkr3tZXYc8=;
        b=rgVWSqgNAOvEO9sG+6fmsJuK+H3mRVMB7FfuojeoZvICD8q6+T1S9drfojPe4p0y9X
         fXHn9qtZJqNwFG933HKgDdJMaK2uRIxbHqsALZOEoK3GLFD7VTN+UEO93qadHY/hgkVg
         9Oc/Ktmchh1hEC0aI/UeIcJHCIxNo3ZHH2qOS+7s2v5lGLf3DmggLlbZ6d0/zadRJIP2
         ALJW+XD9mlsonwvkMbq5MYQJM2XC1/D9K/XNLJNKiyccI/s70Sp3Tl0XAl1iT/+bMWpf
         tmJjUPtGokWzLimMbiuVtudoPUndwTAkBOakITm23ul1a3wpUMRjHxXLjBkBrpOCgkYC
         R/6g==
X-Gm-Message-State: AOAM533koiZe3+N3EtjBOMK1N1ThvH5AxLfGP2UmtZGSHzIZZnR7PYmF
        HgI+uOCMmfxegX5HHYOlANM=
X-Google-Smtp-Source: ABdhPJyUGCVR0D3WpRLqaO8EptHiJ0E9TqYoqvgpaJAWfWRbr/2GX+4ySh1FyOCKz6xyOcvdPCqpDA==
X-Received: by 2002:a05:6830:108d:: with SMTP id y13mr19358313oto.162.1619530583570;
        Tue, 27 Apr 2021 06:36:23 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3839:9ece:547d:49e5? ([2600:1700:e72:80a0:3839:9ece:547d:49e5])
        by smtp.gmail.com with ESMTPSA id u195sm3711272oif.55.2021.04.27.06.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 06:36:23 -0700 (PDT)
Subject: Re: [PATCH 18/23] fsmonitor--daemon:: introduce client delay for
 testing
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <c6d5f045fb5644306a3676e5fa4145ba4c6e9b93.1617291666.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e09104e9-a75c-e7ec-09cf-18dae9b56a23@gmail.com>
Date:   Tue, 27 Apr 2021 09:36:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <c6d5f045fb5644306a3676e5fa4145ba4c6e9b93.1617291666.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/2021 11:41 AM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Define GIT_TEST_FSMONITOR_CLIENT_DELAY as a millisecond delay.

This is a second delay introduced in this feature, but the units
are different. Could we put a unit in the name? Perhaps a "_MS"
suffix.

> Introduce an artificial delay when processing client requests.
> This make the CI/PR test suite a little more stable and avoids
> the need to load up test scripts with sleep statements to avoid
> racy failures.  This was mostly seen on 1 or 2 core CI build
> machines where the test script would create a file and quickly
> try to confirm that the daemon had seen it *before* the daemon
> had received the kernel event and causing a test failure.

Isn't the cookie file supposed to prevent this from happening?

Yes, our test suite interacts with the filesystem and Git commands
more quickly than a human user would, but Git is used all the time
by scripts or build machines to quickly process data. The FS
Monitor feature should be robust to such a situation.

I feel that as currently described, this patch is only hiding a
bug that shows up during heavy use.

Perhaps the test failures are limited to a small number of
specific tests that are checking the FS Monitor daemon in a
non-standard way, especially in a way that circumvents the
cookie file. In this case, I'd like to see _in this patch_ how
the environment variable is used in the test suite.

I understand that it is difficult to simultaneously build a new
feature like this in small increments, but the biggest issue I
have with the series' organization so far is that we are 18
patches deep and I still haven't seen a single test. This is
a case where I think this only serves the purpose of the test
suite, so it would be good to delay until only seeing its value
in a test script.

Looking ahead, I see that you insert it as a blanket statement
in the t7527 test script, which seems like it has potential to
hide bugs instead of being an isolated cover for a specific
interaction.

As for the code, it all looks correct. However, please update
t/README with a description of the new GIT_TEST_* variable.

Thanks,
-Stolee
