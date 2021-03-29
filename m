Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2FEC433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 19:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F2EB6196E
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 19:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhC2TKp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 15:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbhC2TKb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 15:10:31 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4092AC061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 12:10:30 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id y19-20020a0568301d93b02901b9f88a238eso13289021oti.11
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 12:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E4Ax2TUy0zFyvFXWE6NIQ03WdLfL8j+mDq6rZ0SjQSI=;
        b=u/J6ez/VrkSb8k3LmySdixQHVxVXr4zJe5LsiBX/AGENKmVmNk092TSBrlk5s2m8PR
         yHdCBumiijT6FQHiOVtpcSarKInDsIG5WRFcKZwAKbIp5JJlgw/J+h23dI0IJNDPsa66
         YTS+hL6iHba9Uo2nvhAnwAIaTX5Ab7BS/wx7nzqzEHyixzkYQYXqBteAbVqhU1GZTCLP
         LPeErxft9e+XUynosKldmiTPDeVfiC3+/RiXecMKKg88lpnFC1yqm4DB8QfwbSlAmSpR
         leTHRPe2Gq2w6gneS2vGrd/XAViONSqRe1WFfSK4JJiwCVyNPdz/Hh4OuajVKPvfUECk
         8s/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E4Ax2TUy0zFyvFXWE6NIQ03WdLfL8j+mDq6rZ0SjQSI=;
        b=CX//cnkT82BXsG7Ur4UkEsy30i5WuWn02xEubQKvGD2d9TvOTpJ6hNXS2qHnEaisrE
         yN/zUH95coUymQHEkpZX+yTlJpMM57UVCn7QmpAme+1rtl4xJHMDanOJ4EcLGPvZchA8
         Sb2Lq/PbkE8WZxCUzIbNMSZpBtXtE7FK6o/EUrHVnJIgg8DXaV3quwZWJJ+sDkTjOJdD
         v1J9elEu0rVobyTUVRYaWquNrmdFZu+pd10BRn+MYqIMBWDvcXFmbF0P2KFM4EpugqFK
         UcJ9Bpea4AiTV0zBpa0bGvUpft1QdAhVy5rp0d9YFMWEoT+zIklXcEuJ5yCj6a9WmjB2
         Rfww==
X-Gm-Message-State: AOAM53383ZloNWwHPZz8Pt+oeR6zQ5uPs/i/4QuNmi/tlkA5+xjDhPNZ
        P5MzSmIBloMeAV3DGgtyVdg=
X-Google-Smtp-Source: ABdhPJz3tdSrkefpJzTevq98AqOaxBUfDxSe+aJ0MMCX4CvDM67TBOj8Q9Qk997rOKtWuGf4vRoXfg==
X-Received: by 2002:a05:6830:1093:: with SMTP id y19mr23716641oto.337.1617045029508;
        Mon, 29 Mar 2021 12:10:29 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:18fb:da6e:ec24:b27d? ([2600:1700:e72:80a0:18fb:da6e:ec24:b27d])
        by smtp.gmail.com with ESMTPSA id w21sm3624175oiw.33.2021.03.29.12.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 12:10:28 -0700 (PDT)
Subject: Re: [PATCH 2/3] read-cache: use hashfile instead of git_hash_ctx
From:   Derrick Stolee <stolee@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.916.git.1616785928.gitgitgadget@gmail.com>
 <e2611bbc007a4583af55e006136c2bc74351a7de.1616785928.git.gitgitgadget@gmail.com>
 <8b368872-bb36-db61-20d7-47aa5af0ec37@gmail.com>
Message-ID: <244d8b93-9d53-d660-ce08-d8b2362f75a8@gmail.com>
Date:   Mon, 29 Mar 2021 15:10:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <8b368872-bb36-db61-20d7-47aa5af0ec37@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/29/2021 11:04 AM, Derrick Stolee wrote:
> On 3/26/2021 3:12 PM, Derrick Stolee via GitGitGadget wrote:
>>  
>> -	if (ce_flush(&c, newfd, istate->oid.hash))
>> -		return -1;
>> +	finalize_hashfile(f, istate->oid.hash, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
>>  	if (close_tempfile_gently(tempfile)) {
>>  		error(_("could not close '%s'"), get_tempfile_path(tempfile));
>>  		return -1;
> 
> It was bothering me all weekend why this change made index writes
> slower. The reason was this CSUM_FSYNC. Other performance measurement
> (instructions, branches, branch misses, etc.) are all really close to
> the old code, so this I/O is the only explanation. And truly, it is
> the case.
> 
> It seems that we avoid an fsync() on the index exactly for this perf
> reason, but we don't on other applications of the hashfile API because
> writes are not critical paths.
> 
> I'll update this series in a v2 soon that has some other improvements
> that I noticed while digging deep into things.

Small update: the pull request [1] has the latest changes that I
think will work for these needs. However, they will conflict with
the upcoming changes to ds/sparse-index to use index extensions.

[1] https://github.com/gitgitgadget/git/pull/916

I'll pause this series and re-send on top of ds/sparse-index
after it solidifies.

Thanks,
-Stolee
