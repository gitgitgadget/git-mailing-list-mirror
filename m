Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C63AC4320A
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 07:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC0B260E8B
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 07:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244504AbhH0Hv6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 03:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244468AbhH0Hv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 03:51:56 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F110C061796
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 00:51:08 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id y23so5310171pgi.7
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 00:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ic8F9rJB9sscDgQp4F0f/i6dharFTxtLX34SF+U93BE=;
        b=asxQqMKmMxNouXhvGSVKBXHT244aHb1LLCuVSTffO4OZtW+MBHPdj9kR1uGWDd1oQ3
         eoHa7TwKmEr8hCRGZN2vvaPFJdVwao0FAokcEaVF5dla/cl7i+yA8cX+8W5jbZi1vXQN
         gIbX6dobrMGxru09DvewKTimSlFDdVAoKbdtHATrjVq7ut2NnkJlmQkG6Q3owSlW5IXi
         6zMX3VmeFXE+bEmWYAIwy+bTLvcbhWZzvvqhGDxlIUO02B8U3JqUjzOCm7dKuALTh+/J
         FwjU4aQ1E8PCLOS6440QWkhSmULbPVnNfeFsKuEakvA+FQgmxS6Bcn6fdQQhCIXgd4WD
         N+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ic8F9rJB9sscDgQp4F0f/i6dharFTxtLX34SF+U93BE=;
        b=I93ua8Zc4i6GTrU5rYTVToRxrmf73AX0HteaTptGDMFMhQps1/kuT33pU6e4dgHTg4
         i4PQz+Lc/z3N2GPyi1A1c/KVf+VStYILIJ57hEjCbCv6jksD4hj27GlQVoWGGBck4OE4
         bsDBng337XF/CdlrF5dBzFOjPzpoRJeUo/tG10DmLE2Mmwk810awPlPIe6UYpu4DoFQj
         LQA/SFUprbk83Hg2m5j6rp7SqrvuMZi9V/FZ4H94MkeULjs3rGO8/4aVc+x58RHFwLeM
         v+Qi1vSHUkBRi5g/hvpttJy8r6iOwzXwr3Z6GDZXF04Nh2jdYzj3pMG1VSwlg111FDob
         Ggyg==
X-Gm-Message-State: AOAM530w9x/wkeusdasyw94U1ZHvTTa/O94C82yPRzsBjT0eQdrH3OsV
        vs4QyEfSyCKGsZmax1hO1eeXUM0re+c=
X-Google-Smtp-Source: ABdhPJz8mYGzLnNGCUlUSMyInlPmQkj4g4e5KzolkEIRJKXnODb6gE2Jn2AhagptFeXtWWa3OajMGw==
X-Received: by 2002:a05:6a00:228d:b0:3e1:aba4:8e3 with SMTP id f13-20020a056a00228d00b003e1aba408e3mr7898979pfe.49.1630050667936;
        Fri, 27 Aug 2021 00:51:07 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-65.three.co.id. [180.214.233.65])
        by smtp.gmail.com with ESMTPSA id x40sm5314144pfh.145.2021.08.27.00.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 00:51:07 -0700 (PDT)
Subject: Re: [PATCH] submodule: absorb git dir instead of dying on deinit
To:     Mugdha Pattnaik via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Mugdha Pattnaik <mugdhapattnaik@gmail.com>
References: <pull.1078.git.git.1630002794889.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <10db0fb4-56c7-670f-c208-adf5cec4b0fc@gmail.com>
Date:   Fri, 27 Aug 2021 14:51:04 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <pull.1078.git.git.1630002794889.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/08/21 01.33, Mugdha Pattnaik via GitGitGadget wrote:
> Currently, running 'git submodule deinit' on repos where the
> submodule's '.git' is a folder aborts with a message that is not
> exactly user friendly. Let's change this to instead warn the user
> to rerun the command with '--force'.

Maybe the case of "repo inside the repo", with submodule as repo?

-- 
An old man doll... just what I always wanted! - Clara
