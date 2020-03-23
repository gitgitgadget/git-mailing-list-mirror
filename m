Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A887C3F2CD
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 18:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0212F2051A
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 18:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwGF0E5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgCWSW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:22:56 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37910 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgCWSWz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 14:22:55 -0400
Received: by mail-oi1-f196.google.com with SMTP id w2so4765733oic.5
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 11:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PkyhDDpZTlPelbGEI0tqg4FfirLwkJC0Jp5VMa/C8KQ=;
        b=mwGF0E5Ll8VgK22BHvgevnCgCknDlXyx/5tQdwuPvgc0NrwnujzMYg7VzK2ECoqBB8
         NNAPdK6PD0OgQzSeS7MmjlLIw/nJiHVn0KYus7Y5tf2kREzJLGdlwDPIOCUWCp8BPVhB
         bPfR8c2gp1bb9P7ZBvENIuKXDUjsIX3t1mKf29oUBX6Aa9c79wbF6qfklFPdvtOI0QYD
         Dl8au7bh4Rsr7OvOFtOIksjajTrRMSadEdXitJHQ7uTkD7pXMWiS/T/sNsGmQaeSTBEl
         QtTW/JG7HeWtJv3iqCXmAq/SpRrPRfZNTzBF54LkSKEwRBtxVzgJKmPqLyNSPYz34FMw
         5A6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PkyhDDpZTlPelbGEI0tqg4FfirLwkJC0Jp5VMa/C8KQ=;
        b=uPr7WuLOLFFnNi44E89AlbbZiNGm5ry2t10paeObmHnQRDlFLYkydnvf74xk+kfUNo
         7ldEtkoAw3yHwdes6DQfjxzyYGKo6JQ15AmkNNi9fsr8uCz/eevXU6C+EHX+L0VY8oz5
         7rroaFSaa04P1ZQxUJzrtgbov5LJPe5wgZCEY/BCexw2L5q6fDm1J+6lKVwI+Fbyb4ta
         pL3VS33kpPZ6ve3u2kGXXdTv+cbyM2LWSnNaJXGArh4K8PzPeWghpSrIujW4bdt5wZWS
         jm7lvnTFsAC+CJd+3PoENw89K/RypMj+FqkfZH/eidEFWj3tamUHjlZFRPmE1pGL+Cth
         k/Gg==
X-Gm-Message-State: ANhLgQ18fuDe5W4VvKg5V9R5GtjYP9k+2XH/MIZJ75HLOpdyqfqTV4RH
        8y5Vn7FFKULQw/6kTiFm+pA=
X-Google-Smtp-Source: ADFU+vuz+bxgLjeo0qV+j1NTEFq3BGP4ycWnGIYqr6VRmR3JkQ1nS+FkiW+/8Ssilkvv79GYDyiFcQ==
X-Received: by 2002:aca:47c8:: with SMTP id u191mr534218oia.170.1584987773297;
        Mon, 23 Mar 2020 11:22:53 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id s27sm5195253otg.38.2020.03.23.11.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 11:22:52 -0700 (PDT)
Subject: Re: [PATCH v2 10/18] sparse-checkout: use new update_sparsity()
 function
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
 <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
 <27ed4a3f7a28c66d8185cb4c484e8b0af81b15c6.1584813609.git.gitgitgadget@gmail.com>
 <45021041-eab4-6e0e-5966-11db06333ab2@gmail.com>
 <CABPp-BH1BMZjLN91F5Ece6v30dw8RczrBY+9GnmPWCCdeH6Stg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bae7c3ba-d835-864f-4f6f-51dbde0e338b@gmail.com>
Date:   Mon, 23 Mar 2020 14:22:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BH1BMZjLN91F5Ece6v30dw8RczrBY+9GnmPWCCdeH6Stg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/23/2020 2:14 PM, Elijah Newren wrote:
> On Mon, Mar 23, 2020 at 11:07 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> Should the "error" messages we grep for be more specific? Are they
>> the same as the "Cannot update sparse checkout"?
> 
> The two lines are checking for the same message, it's just that the
> error message is split across multiple lines and thus requires two
> greps.  The error messages are actually a bit of a mess, particularly
> when they are triggered for multiple paths.  That's something that
> subsequent commits will clean up.

I see that now! The very next commit cleans this up nicely.

> I can add a note about this to the commit message.

Thanks!

