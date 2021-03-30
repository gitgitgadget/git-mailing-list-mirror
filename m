Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05692C433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 16:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D558F619A7
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 16:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhC3Qy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 12:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbhC3QyC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 12:54:02 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618F3C061762
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 09:54:02 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id x16so8487823qvk.3
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 09:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x/88YL1b77WdQ8de0IpfcX/7BpLI6TH3cVHiKbOZEX0=;
        b=bDg6WPvjJceFqz4kw8E36dVsl0X3YW6DE+mnLcuyx9UN1+tZhVlQMoZVFCiMlU1N9f
         3PAnAFD+yMseTCrFZPXGkr6wLiEMNh6EQ3C9ZO6RhJqaE+Kym9AMuh4B0f/ZTe9IdJm/
         eDXDoSsLXxmUIhcN+vb9M6vlk4HHYP+khzCf4SReQpMhzSTrD3rILiQBZoSfBJJ4yPHQ
         3rOKfD5Vf0iN/0MJtgidHokNzl9s4IimDTNmyHm+6Q+BXEvd4Q86PoSfuwwU5lpe1lzZ
         /2p2oA+oK8RJdnRUmfC5Tm2xifeMZ6LTmTb72QFlqEr2RblTaX/PHLUeGpfaCFbvCO/N
         t5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x/88YL1b77WdQ8de0IpfcX/7BpLI6TH3cVHiKbOZEX0=;
        b=uJR300jXVAfRDYq+SjEZT0NtiPQuJfovgJw5F6NTDR+nn3SVzXt0YjJ3cfysCtqOWF
         vwKUYZyKcx7kXdVjaa7wLRBUoHzEVx2TH8upZwWBTeRZrA3rJ19kaCr8Oa4WYdhZUBy1
         TF++knVp0pOhDCihpCFSgE0iQrgZlwEKbxRDfuQBy+KYjBatGL7uaGkrq4jCTwISdACR
         SoCWGFFEuiUsxySeHu0tNXhC/KcckEMnjRVPxASGEiph2rtM3bF8gSd2c9/Ocbxf/MV6
         SZWmpgHzrqUgL+Oh/OIl0M0NrO9oVm6BQhNvv2t7d49bp9EplcxY3D7dSyZnjvcSbLJY
         4JLg==
X-Gm-Message-State: AOAM532kV8OUd4nGGagCjm3+UpTu3zStue7gaTJccgwC5645Ge72KodO
        ++xV3gzrzT6ypFJDYH2MC7g=
X-Google-Smtp-Source: ABdhPJyuFJgOFQY4Kfb1kMUhGzP6K49kLjuxhd0QF2Gch80P95R+WZdhVsI2Xoy2yoyLoYbgkV4Tqg==
X-Received: by 2002:ad4:472d:: with SMTP id l13mr31036334qvz.17.1617123241489;
        Tue, 30 Mar 2021 09:54:01 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:51d7:1436:793b:b3c9? ([2600:1700:e72:80a0:51d7:1436:793b:b3c9])
        by smtp.gmail.com with ESMTPSA id p66sm16528472qka.108.2021.03.30.09.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 09:54:01 -0700 (PDT)
Subject: Re: [PATCH 01/27] *: remove 'const' qualifier for struct index_state
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
 <628e16dd3fc7be96d40a7b3201573a71ae7fbbd6.1615929436.git.gitgitgadget@gmail.com>
 <xmqqwnu2lux2.fsf@gitster.g> <xmqq8s6ilhgs.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9cf7775f-189d-8350-ee7a-0bd4444175aa@gmail.com>
Date:   Tue, 30 Mar 2021 12:53:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <xmqq8s6ilhgs.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/19/2021 9:52 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: Derrick Stolee <dstolee@microsoft.com>
>>>
>>> Several methods specify that they take a 'struct index_state' pointer
>>> with the 'const' qualifier because they intend to only query the data,
>>> not change it. However, we will be introducing a step very low in the
>>> method stack that might modify a sparse-index to become a full index in
>>> the case that our queries venture inside a sparse-directory entry.
>>>
>>> This change only removes the 'const' qualifiers that are necessary for
>>> the following change which will actually modify the implementation of
>>> index_name_stage_pos().
>>
>> This step has a bit of interaction with Matheus's "git add/rm" work
>> in sparse checkout (mt/add-rm-in-sparse-checkout), which I believe
>> is still in a bit of flux.  I didn't check potential conflicts the
>> remainder of the series may have with other in-flight topics.
>>
>> So, I may throw review comments at the patches in this topic as if
>> they are standalone, but please do not be upset if it didn't appear
>> in the 'seen' topic.
> 
> Tonight's pushout will have this topic in 'seen', but I consider the
> branch a series of trial merges (there are other first-time topics).
> The result seems to compile for me, but other than that, I have not
> much confidence in conflict resolution.  Please give them an extra
> set of eyeballs.

I looked at your merge, and recreated and equivalent one in my own
merging. Thanks for working through all those details. I trust that
your rerere data will remember those changes and help avoid trouble
when replaying new versions.

Otherwise, I could create a new version of this patch with the
intention of playing directly on top of mt/add-rm-in-sparse-checkout,
then keep future versions of this series on top of a merge of that
series and ds/sparse-index.

I have a v2 of this series ready to send, but I'll give it a day to
see how things shake out on ds/sparse-index and if you have another
suggestion for this conflict.

Thanks,
-Stolee
