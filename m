Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099EBC43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 17:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF99E2464D
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 17:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+FD8bkD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbfLERFq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 12:05:46 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37247 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLERFp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 12:05:45 -0500
Received: by mail-qt1-f193.google.com with SMTP id w47so4217137qtk.4
        for <git@vger.kernel.org>; Thu, 05 Dec 2019 09:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=lkKm2/2uCgA4PakqbIIO2ontWoRRaMpaKAVjZl5iEjw=;
        b=k+FD8bkDjJSAYz75bfE2BaLO3E7t+NhCTqsgigES0HmgFBmrLOfr1vjzXA57ZVwrAW
         yHpDrnEgBTBSK6ri7AHn8hn+XkwcvtrFcmBC6COnZDpV4BVbdBUNApCMCkCHtEjpS8TY
         rceM8PZbszx8WqiGOtDtlqE43fGnQ7l1jViXUzDMBKzyMemX9d/7AR8McDLFKPe3wCcP
         5D/zVOy+7a62Ag7lCueECt9chMzM1sxWwXXegl9WPAbepMMNuqllzkvMqN/C/r/FwkHB
         t5U5HNX8vx3qmXORZkzoQTLZfUPN+bH+nNNW0c/O/mfuyXl9f5pakqtM+hybKCb/MVL1
         64LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=lkKm2/2uCgA4PakqbIIO2ontWoRRaMpaKAVjZl5iEjw=;
        b=fRZ0IBz52YJiYjnqgM33xU/tjcv9t6bMbMohu7BMNLWKdu3qsydREhQuF/GyE1tABy
         cfCXsgklDjfxIrvyB9xeib2MHp0w9Abvp9wCM2ALx9BvH7nFigiHEFnDw60o8FPU+NxC
         hNR6hf74g09J7kkgPbGvvUi27bO+k1faMxIrEpIMwsvz7sfPyCyxC7/CFg0Ufpxf7/7l
         UJi84WEP+PTHGnycqptKtvk24v8qKhz1sNFvmIr47q19KgKmMJmunsnhwi+mbomHm5Ot
         em/MWO+qrGaAAucdxZXyYQdoryp9QRkrd+oAyH5xB2qPn4eDq61jxDIz0hPmYqEihLsK
         FRNQ==
X-Gm-Message-State: APjAAAV/8j6YWfVxDSjVhFhRm7D5sa4d1FmqymAkQQMetbeUeOHqJGue
        xj4heLVNs8XbNXJRQ/97Bes=
X-Google-Smtp-Source: APXvYqxTpSSRIJV5ttzdSFR9I/tQKLvKE94fEEehfHUejKaVG3sSPR/RB9UYgxGkncBgFfoWDr32/A==
X-Received: by 2002:ac8:7443:: with SMTP id h3mr8280756qtr.202.1575565544643;
        Thu, 05 Dec 2019 09:05:44 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id t2sm5074955qkc.31.2019.12.05.09.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 09:05:44 -0800 (PST)
Subject: Re: [PATCH v4 02/11] git-p4: change the expansion test from
 basestring to list
To:     Denton Liu <liu.denton@gmail.com>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
 <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
 <0ef2f56b04803cad2e60bf881e86d8bdd69463a6.1575498577.git.gitgitgadget@gmail.com>
 <20191205102724.GB315203@generichostname>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <446aa222-a26c-99b9-6078-60b3376d3e6d@gmail.com>
Date:   Thu, 5 Dec 2019 12:05:43 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205102724.GB315203@generichostname>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 12/5/2019 5:27 AM, Denton Liu wrote:
> Hi Ben,
>
> On Wed, Dec 04, 2019 at 10:29:28PM +0000, Ben Keene via GitGitGadget wrote:
>> From: Ben Keene <seraphire@gmail.com>
>>
>> Python 3+ handles strings differently than Python 2.7.
> Do you mean Python 3?
>
>> Since Python 2 is reaching it's end of life, a series of changes are being submitted to enable python 3.7+ support. The current code fails basic tests under python 3.7.
> Python 3.5 doesn't reach EOL until Q4 2020[1]. We should be testing
> these changes under 3.5 to ensure that we're not accidentally
> introducing stuff that's not backwards compatible.


I changed my commit text to say support for version 3.5 (which is 
actually the version I am running the test with).


>> Change references to basestring in the isinstance tests to use list instead. This prepares the code to remove all references to basestring.
>>
>> The original code used basestring in a test to determine if a list or literal string was passed into 9 different functions.  This is used to determine if the shell should be evoked when calling subprocess methods.
> Once again, I'd swap the above two paragraphs. Problem then solution.
>
> Also, did you mean "invoked" instead of "evoked"?


Changed.  And yes, I meant 'invoked'. I wasn't trying to make my code 
feel anything!


>> Signed-off-by: Ben Keene <seraphire@gmail.com>
>> (cherry picked from commit 5b1b1c145479b5d5fd242122737a3134890409e6)
>> ---
>>   git-p4.py | 18 +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
> The patch itself looks good, though.
>
> [1]: https://devguide.python.org/#branchstatus
