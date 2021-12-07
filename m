Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20CBC433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 20:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbhLGVBZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 16:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbhLGVBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 16:01:25 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592A4C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 12:57:54 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id bk14so924838oib.7
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 12:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aTYrekIWH7bojHZ47qG+aYrVYzR/LrCw+M85lLc3XHc=;
        b=ogtUdNE7DlQOgc7qWoW1XxnUI5/i8FsjNauiyE7EXZyhgD6DdlK3uSEGDyrUeQ1glM
         ZOGPTKVnxr5AHQ8uUej+W2Y96D6ldaaMtz5YcRnYC0Zc+Pg5T6FfoRZYjPKfN58LF9Gw
         1F/7WopHm7K+g2l/Jli6ezhJ1KTuColPIMxJTGm0g5H4U61QtWbLOpucT2rfRvhrYJJr
         wWPlHgJ8s8Vz3DddwEiBTfFMVVen1SGU1OSoaZPppkHF7e3FoPhryJ8BiUSXm88O+WLb
         03BtHdR6XVuZbELNJRr+anWNMTXMHWS5NWHDiYUygHPiotXV6aDxEhDX8JJnKqFxCiAP
         QmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aTYrekIWH7bojHZ47qG+aYrVYzR/LrCw+M85lLc3XHc=;
        b=f4IdNz6xcKPmLsTfL2PLMFxI8RL1q5PL000+4KwZA3rf4JPRqJTSzGF+WNyMkaktDM
         Zvi7TN0b/tx5RZ6Tc0Dyqf5+3qcwjnuPRRTM12qUw5QUeQrywCORAUCbqma6jbmiIpN6
         yHQro1ZjtSawxK+pogFbC0RS/H5T637FUzwd+QJMCEVygFsgYZrXWV3PSY89IzcGhF3L
         T9PSaTGXZjNYWJMIffPjZQC38fYugNmUZEFaM06NLINY5JRZWYzKtwtcNLVNRwld3wil
         K07m0nt20l/+HS+JqX4kG+/Hqq2o7bmYJ+gR+90tMFFfezuZnHg++4wxtiR9kp6jyGgv
         GkFg==
X-Gm-Message-State: AOAM5339L9uFkotzhR0OSUL++p4DuHykUjf8tgUDZjKINFONgOGa7xCT
        MXWeqPNhfUj9qdN9IVUEwog=
X-Google-Smtp-Source: ABdhPJwKPPMSZvqGRZ2GE2nYCPrdUDd/V7WKMKR7yrwiIF8O/zqyjYNgV4B90TZPq/dmYJb70dbzsQ==
X-Received: by 2002:aca:ab84:: with SMTP id u126mr7332430oie.41.1638910673527;
        Tue, 07 Dec 2021 12:57:53 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1d54:16a5:5c65:4b5? ([2600:1700:e72:80a0:1d54:16a5:5c65:4b5])
        by smtp.gmail.com with ESMTPSA id u6sm194354oiu.34.2021.12.07.12.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 12:57:53 -0800 (PST)
Message-ID: <31bef4f9-2313-83a2-14e9-4ed1cc73a59c@gmail.com>
Date:   Tue, 7 Dec 2021 15:57:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v5 00/11] Avoid removing the current working directory,
 even if it becomes empty
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
 <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
 <aa85e35d-143e-93e4-f54b-146b38dd4b88@gmail.com>
 <211207.86tufkmfc2.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <211207.86tufkmfc2.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/7/2021 1:30 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Dec 07 2021, Derrick Stolee wrote:
>> test_expect_success 'remove cwd' '
>> 	init_repos &&
>>
>> 	test_sparse_match git sparse-checkout set deep/deeper1/deepest &&
>> 	for repo in sparse-checkout sparse-index
>> 	do
>> 		(
>> 			cd $repo/deep/deeper1 &&
>> 			test-tool getcwd >"$TRASH_DIRECTORY/expect" &&
>> 			git sparse-checkout set &&
>>
>> 			test-tool getcwd >"$TRASH_DIRECTORY/actual" &&
>> 			test_sparse_match git status --porcelain &&
>> 			cd "$TRASH_DIRECTORY" &&
>> 			test_cmp expect actual
>> 		)
>> 	done
>> '
>>
>> Please do not let this test delay the advancement of this series. As we
>> find these kinds of issues, we can fix them one-by-one as needed.
> 
> Not to pile on about "the core idea", just a question while this is
> fresh in your mind:
> 
> I think that those cases would per [1] be ones where a more isolated
> change of reading the $PWD from the environment would make all those
> commands work as expected. Or would the "$TRASH_DIRECTORY" also
> otherwise go away in this examples?

I have read this message and the one you are referring two twice and
I cannot understand what you are trying to say here.

> Anyway, just per [1] and the potential future follow-ups is this (I
> don't think so, but maybe I'm wrong) or other examples you have things
> that specifically need the "retain the getcwd()" part of this series?
> 
> Or just (as I think would be the case with that "git status") to not
> have setup.c die quite as eagerly as it does now when getcwd() fails,
> but it can find its way back to the .git via the environment's $PWD?

Are you implying that Git will be the only thing broken by a missing
directory after we leave in this state? I doubt that is true, and we
should be good citizens here by leaving the directory around.

> There *are* definitely cases where not-just-that-setup.c change but also
> the "don't remove the CWD" is an inherently better & more complete
> solution. But I think that's mainly to do with 3rd party shellscripts &
> other programs outside of our control.

Exactly. We should take this change because it is valuable to not cause
a confusing error in other tools.
 
> I'm assuming that you were working with this on Windows, where
> presumably there's fewer/none such shellscripts you rely on, but that's
> now two presumes in a row, so... :)

I'm working on Ubuntu, where I do all of my Git development unless there
is a platform specific reason to do so.

Thanks,
-Stolee
