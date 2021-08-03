Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDCCC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 03:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79BCB60EEA
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 03:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbhHCDIo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 23:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbhHCDIn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 23:08:43 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A19C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 20:08:32 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id em4so5114468qvb.0
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 20:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=//uGJOMTFsZiDAtUQsLyP20WTU0uVMz6ZD0l6+785rw=;
        b=fntYEyGmW68jP96LoMG+AcUd7WdlcDsF8tvRjVjfTYFqvtO8gdxpKuMTHAqRi1WQ4Y
         567qxRHmV+GFZbWxIt7ftnlfG2EzPid58N+UnZyMrl2H9/aPtO0s9VakJttTFRHwoscp
         OHYxLfPLgF76Zroe75VeANomrJySdA3vIu4lCc/2NdRhzDqIWTSwTNGwqwC3bPIPs6Uq
         qx+kKzWteoSCba/1gpL9mOaOgb+n1Y2yod7/3W+w0kXIFtMNGTrYSLK9c9OtbDtjgAyP
         2FCAANDMZGbU/QBbWGxyCfy6HzB/+OFX8J7N5IYO4cD5xnLexbpUnXFZW8Ke8XW5pqu2
         8Vtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=//uGJOMTFsZiDAtUQsLyP20WTU0uVMz6ZD0l6+785rw=;
        b=lY8lfsyKYttmhdxStO67OFvzb4ckAAgibWz/laSCjrE+Ofba4F2AvExoPBPnP3AOqk
         IY1+H5gpCeIoYWTexCw7Y5zPQbO7wVqGuBZVd2o+5wVEVz22hr6h5mg7ihcc3siXsOuO
         Di6LNU8fo2lOIl70MZLWrtunOAzi6sICWbgbezt/7vHVFIR416jUI2toI76hXDqKOhu9
         vGL5jnnUiiwQymZOYYzc945G1fSpM93CxSeRTOV1lIw/sTyDO0r6psWJpNv39QnXbfLR
         kwuwKRih5f9aOsdZuGzr/eCB7PapVqfYXSdTDBcIOhL7QYnG33js0iKCP5TU8MrPZF8y
         LaZw==
X-Gm-Message-State: AOAM531zV6TwO9FhEq1Qi8jdjkGRnnO1y0G7pZq9c1kJda71W8yT7VhP
        uAP0Wg3nR2vUFOQbUg8yY4CvaogvL0MhAA==
X-Google-Smtp-Source: ABdhPJwe4RGkkQCGgcSpFJPQvupzePjsPJg2Qcm8d+kMs0evrBpPNvwtozsx2MtL9YuidUufRjU4VQ==
X-Received: by 2002:a05:6214:10c4:: with SMTP id r4mr12841114qvs.58.1627960110371;
        Mon, 02 Aug 2021 20:08:30 -0700 (PDT)
Received: from [192.168.89.76] ([198.168.101.205])
        by smtp.gmail.com with ESMTPSA id h2sm7518198qkf.106.2021.08.02.20.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 20:08:29 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] clone: update submodule.recurse in config when
 using --recurse-submodule
To:     Mahi Kolla via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1006.v2.git.1627943914.gitgitgadget@gmail.com>
 <pull.1006.v3.git.1627946590.gitgitgadget@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <5e42756e-09bb-d51e-71c1-3aab93c2d27a@gmail.com>
Date:   Mon, 2 Aug 2021 23:08:28 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <pull.1006.v3.git.1627946590.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mahi,

Le 2021-08-02 à 19:23, Mahi Kolla via GitGitGadget a écrit :
> When running 'git clone --recurse-submodules', developers expect various
> other commands such as 'pull' and 'checkout' to also run recursively into
> submodules.The submitted code updates the 'submodule.recurse' config value
> to true when 'git clone' is run with the '--recurse-submodules' option.
> 
> Signed-off-by: Mahi Kolla mahikolla@google.com
> 
> Mahi Kolla (4):
>    clone: update submodule.recurse in config when using
>      --recurse-submodule
>    clone: update submodule.recurse in config when using
>      --recurse-submodule
>    clone test: update whitespace according to style guide
>    clone: update whitespace according to style guide


This could all be done in a single patch. As long as the patches are not merged
to the 'next' branch, you can simply force-push and re '/submit' on Gitgitgadget.

> 
>   builtin/clone.c          | 1 +
>   t/t5606-clone-options.sh | 7 +++++++
>   2 files changed, 8 insertions(+)

I think this change would require a mention in the 'git-clone(1)' man page.

I'm very much in favor of a change like this. It is a pretty big change in
behaviour, but I really believe this is a good way forward. Thanks for getting
the ball rolling on this!
