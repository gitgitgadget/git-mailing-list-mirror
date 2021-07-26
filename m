Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E863FC4320A
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 13:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8C8860F02
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 13:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhGZMxI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 08:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbhGZMxH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 08:53:07 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913F7C061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 06:33:35 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id k13so6942675qth.10
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 06:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HAuC+sx01wmwO/DGOX/OT5M7pTvi6hcM4YrB0sqhTnk=;
        b=ND6cuASOw1ltnv9kf53tB74aj3e4FiVZ8Vy+cf10087fRDNTm8n6MrQWC04kN5HHgT
         Z+XwbrrpTOkGdNLAAhmoU+lmqLNVGmFm3meycOTBxgK27hcKfGn9vwdq3eRU4P59XxQB
         iybvIKyA7Be6b+jpNnEtoNi9lXbEI2Pivus5TgscjnxCceXOXHCKCEnDiBh+XC0h/ASG
         8lh42N8wJ4pK2x3WdOE6eTiaMu2/ighV5955uwLIbBjuN0LEXi1538fiD0HOwIJA1aeC
         jhwFzWePyBiByPqeSIe+sXcB8pk32KWFBCjDZ1NC5Xmcnj20QyaT0GKCc+Vs2dessh0G
         uVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HAuC+sx01wmwO/DGOX/OT5M7pTvi6hcM4YrB0sqhTnk=;
        b=fa+ps55NU0M3sq6yUIMuBY3ZjUEfa4zY5WfFYjeekmsqF0GRqZuQuQ6n7usRNO4O0Q
         3O2bT8Ugr1dCJZb8ipKhcouQuhw6oZttFLTwzRtqyf0/bL4+LsA2jDX+71HYaIvlB2w+
         jMWIRnsrhE44rM0MTSqEG1Wn1/W5e+UNxw4PVrzQtbSOljz95AdLrFJwtjavJQVYDfEK
         UTrGwMsThTLSm1D5LhY7q7vM0TJrJQFib5MV3G4p8yhcT66JWcpT1ZjxxeiACB141qBg
         BrgRZ6K+ofuY6IigZ0amtO5it6IFVfxn/0jDz03/h3covEepJDX4+ERnW3iMxlulTMd2
         OLng==
X-Gm-Message-State: AOAM532mjkeYSTo7i/qbKag4XGth7RyDaRS85QXEkJrXRh7LlMFVMfUN
        ewI7KBM6GujkvYNG47JH5zY=
X-Google-Smtp-Source: ABdhPJxVrNVjAfS04EuCE82RPyJ2eXL/a6kXac3eLJSEVNXpC8jngLkXk5N1UkLwA+tY8140bMs3ZQ==
X-Received: by 2002:ac8:4b6f:: with SMTP id g15mr15077474qts.13.1627306414588;
        Mon, 26 Jul 2021 06:33:34 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:8509:d58a:ff00:9b31? ([2600:1700:e72:80a0:8509:d58a:ff00:9b31])
        by smtp.gmail.com with ESMTPSA id o15sm13054qtp.25.2021.07.26.06.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 06:33:33 -0700 (PDT)
Subject: Re: [PATCH 2/5] add: allow operating on a sparse-only index
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.999.git.1626901619.gitgitgadget@gmail.com>
 <791c6c2c9ade5b065fc0f367e00c52a493d086ef.1626901619.git.gitgitgadget@gmail.com>
 <CABPp-BHQ52WpCKc8dxaV+u1QZCeT-YieQynTmK_w84r_Tc=VGQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <26eb25b6-2805-6dff-fc59-f6bc52a03142@gmail.com>
Date:   Mon, 26 Jul 2021 09:33:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHQ52WpCKc8dxaV+u1QZCeT-YieQynTmK_w84r_Tc=VGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/23/2021 1:45 PM, Elijah Newren wrote:
> On Wed, Jul 21, 2021 at 2:07 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
...
>> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
>> index a3c01d588d8..a11d9d7f35d 100755
>> --- a/t/t1092-sparse-checkout-compatibility.sh
>> +++ b/t/t1092-sparse-checkout-compatibility.sh
>> @@ -340,13 +340,6 @@ test_expect_success 'status/add: outside sparse cone' '
>>
>>         test_sparse_match git status --porcelain=v2 &&
>>
>> -       # This "git add folder1/a" fails with a warning
>> -       # in the sparse repos, differing from the full
>> -       # repo. This is intentional.
>> -       test_sparse_match test_must_fail git add folder1/a &&
>> -       test_sparse_match test_must_fail git add --refresh folder1/a &&
>> -       test_all_match git status --porcelain=v2 &&
>> -
> 
> Why was this chunk removed?  Nothing in the commit message mentions
> this, and it's not clear to me the reason for it.
> 
> I tried adding it back in at the end of the series and it still works
> (and further I can't change test_sparse_match to test_all_match and
> have the test work).

I mentioned this in a reply to Junio, but this hunk removal is confusing.

As of this patch, this hunk causes a failure due to an error message not
matching, specifically this error:


+ diff -u sparse-checkout-err sparse-index-err
--- sparse-checkout-err 2021-07-26 13:30:50.304291264 +0000
+++ sparse-index-err    2021-07-26 13:30:50.308291259 +0000
@@ -1,5 +1 @@
-The following pathspecs didn't match any eligible path, but they do match index
-entries outside the current sparse checkout:
-folder1/a
-hint: Disable or modify the sparsity rules if you intend to update such entries.
-hint: Disable this message with "git config advice.updateSparsePath false"
+fatal: pathspec 'folder1/a' did not match any files


A similar test is added as a failure case in patch 4, then marked as success
in patch 5. This organization of test changes could be organized better, so
I will work on that in v2, along with your other suggestions.

Thanks,
-Stolee
