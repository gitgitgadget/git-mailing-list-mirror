Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5CFC433DB
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 11:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7FE1207A1
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 11:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgLaLS1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 06:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgLaLS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 06:18:27 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB23EC061573
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 03:17:46 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id g24so12608866qtq.12
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 03:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1dhxi8VnuXQuUFA+t6mkS0XXaIaHe0NkmNi1vxi01S8=;
        b=pNsakcM6cpeKUUD0rfprvtjE/fan/51nnfdOU0ZP7b1fQNiv8KJfjCOy05eB8tJbgd
         DQFldgiwu63brFGVDJpH02uCyUj4fVJIuaXRSigx12q/nFvp3E+8EZYaETJ1Gl5cj6Bb
         THAeblSt30/Ba0T4VdLyclxrFhnJfEXaM2byrUBqtiphbvXQGHDTFqcSjrEspCmsPwUu
         iz8RwnbG/AekHvek1GoLSDSIljzmELYMDe3jTmlseePdTrBP2/o3Pq2gTijs9ivENvQn
         ym5ycWlCNYKQCijvDElbLx0i7G0ggVes7n6GIycmzkta6N33uKremyB27esyWYUQZQQC
         a0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1dhxi8VnuXQuUFA+t6mkS0XXaIaHe0NkmNi1vxi01S8=;
        b=YA5tRIyT8LgtdRHBnBviV2Bxxb9gmUXO43m2yWV9lx/0t2UC6PZ/9k+QZHraSf+BOe
         jvv8FgwYz43xCMwcs269D0YGXGNNfdS/vOLsBe6Ue9AEZjcYGgxAT3abo00pWd923hVT
         +uj2t4/QswpaV43/BT0/XmwLhemLa/dbGT3kycARrmZBUAmRHZQ2wmwbWPVtik8po41H
         zvYm1ZAo4msxY+8VazGAH0B/pti3ptiPra142lXN/S+MYaE0EztlxZGUgS2EbbtsYGET
         TJ0FN9712hkUi3hjQNaeEWwEw9lXZlT2hjCrSqQtNLaHiEelB7hdb6A9MnvsSKVzxkcy
         8chw==
X-Gm-Message-State: AOAM533zlNOhgMMZa3z/IsnVCACQajjrpGqqlyX8W3W03wqPxq0op87S
        tvKrAcSHBOkJqjC02LeNVM5lB8UiXow=
X-Google-Smtp-Source: ABdhPJyYo+gVbCHfCFAmZGg6KuMtwNxEPbjxqnrIGZKZckMI/QXR7My2Et5LZoDlO7orZoLfDckLWg==
X-Received: by 2002:ac8:4986:: with SMTP id f6mr56186970qtq.43.1609413465467;
        Thu, 31 Dec 2020 03:17:45 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id b12sm29161671qtj.12.2020.12.31.03.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Dec 2020 03:17:44 -0800 (PST)
Subject: Re: [PATCH 01/10] merge-ort: handle D/F conflict where directory
 disappears due to merge
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
 <382a009c18efc8a46a9c0210754f2266c3116ee4.1608270687.git.gitgitgadget@gmail.com>
 <cb08fd8a-b4e1-77d6-7d8d-9f0431db2404@gmail.com>
 <CABPp-BFrct6hZW8bh5hhRpGSPhjeGO9viCjpO02gUyTqNnrAgg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <41ac7d44-e32b-99ed-c928-6325a02ba62c@gmail.com>
Date:   Thu, 31 Dec 2020 06:17:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFrct6hZW8bh5hhRpGSPhjeGO9viCjpO02gUyTqNnrAgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/30/2020 10:13 AM, Elijah Newren wrote:
> On Wed, Dec 30, 2020 at 6:06 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 12/18/2020 12:51 AM, Elijah Newren via GitGitGadget wrote:
>>> +     } else if (ci->df_conflict && ci->merged.result.mode != 0) {
>>>               die("Not yet implemented.");
>>>       }
>>>
>>>       /*
>>>        * NOTE: Below there is a long switch-like if-elseif-elseif... block
>>>        *       which the code goes through even for the df_conflict cases
>>> -      *       above.  Well, it will once we don't die-not-implemented above.
>>> +      *       above.
>>>        */
>>
>> This comment change might be a bit premature.
> 
> Or perhaps it should have been squashed into an earlier series that
> was already merged to next.
 
I think it works with the next patch, which removes the die() from the
if-elseif-elseif from immediately before the comment.

-Stolee
