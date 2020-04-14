Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16A7C2BA19
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 13:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F73920644
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 13:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpM5lmqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388025AbgDNNns (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387950AbgDNNnq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 09:43:46 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53810C061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 06:43:46 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 103so12814123otv.0
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 06:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dlZLRABhBmHEmfpZtz2/RW4JL7Va06k1p3x1+Tn2MEw=;
        b=XpM5lmqzhuV0+wevpano+L29Jn9JRjEyxmHCwJBF6B4GqWX4r1MqeQpx7heGIa6oZY
         fp9c6I4zbp9hynly9P/DHPnLazDSxoczkNBLVIqm1bVbVzRef6TvJ7FFPcCAlGmJZsjN
         3tuhgKs+7LVxsSsCvaOEdTjx+UBVlo3vSDhfAL1zyJr98KCuB3MkbYVvv/qooO3TItk1
         LbaBZsCnCN+YQ+HpDRjgTlt8x3yEOifKDYD0BSDs5qsbdHmCKXKPx7zZZ7ZvmdqVnms1
         5OpqRyXC0qIBtpbZxwmhOObgtz+MsACKejOgca8ig9PS8mnbROFk2UqT9K2lyfeN2XEI
         lmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dlZLRABhBmHEmfpZtz2/RW4JL7Va06k1p3x1+Tn2MEw=;
        b=qDLv++TZyRmzGYTf7TKmXBSYk8a05vm6kvU22SpOIVnTPNsw2GwpIuBOu5gfIWPYNI
         KsccIBu+j2bE8+NxKfntPAECjK+arZMzDqqvHsFR2evxb9e+s1YyGXmSGnMEtnYvuRPT
         M6ohmhZlK0u4tI9yXd13661nkSx2AJ13nrpvK+Dkdr2hdJc9GnyZk+8JxciKnhW7mxAU
         Po2/L8zKEAn7b45qzckTVvkfkcMR0U8LhAppTTMJbcvM+60c0b1Cj2OnRMf7Pj9UcdjV
         Wj60UCU5e6dQcosgw+s4aIiEe9ZlwbT4QmVDZ1+id+BjbsQ+87yYNw7I5dsrvfElbNbj
         XSNQ==
X-Gm-Message-State: AGi0PuaZcQHOeigFXiF6ZJZuahCf+Apz/1XCSoikiB9Vpzohm3I33WTz
        /rnI35KL/j+Iojn/ooYMtsw=
X-Google-Smtp-Source: APiQypKZY2eByz7WZU9I3stvgdDb0E3Lqy+MSh9Xc/0R3U/+s39N69Oe4UxFMnfU+jJKq95sC4dHbA==
X-Received: by 2002:a9d:798e:: with SMTP id h14mr17906416otm.88.1586871825574;
        Tue, 14 Apr 2020 06:43:45 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id e64sm5585907oif.10.2020.04.14.06.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 06:43:45 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] clone: document partial clone section
To:     Junio C Hamano <gitster@pobox.com>,
        Teng Long via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Teng Long <dyroneteng@gmail.com>
References: <pull.745.git.git.1585792946341.gitgitgadget@gmail.com>
 <pull.745.v2.git.git.1586791560.gitgitgadget@gmail.com>
 <xmqqd08batub.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e77309ef-68a4-0ebd-0d82-051b07838fd5@gmail.com>
Date:   Tue, 14 Apr 2020 09:43:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <xmqqd08batub.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/13/2020 6:45 PM, Junio C Hamano wrote:
> "Teng Long via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Partial clones are created using 'git clone', but there is no related help
>> information in the git-clone documentation during a period. Add a relevant
>> section to help users understand what partial clones are and how they differ
>> from normal clones.
>>
>> The section briefly introduces the applicable scenarios and some precautions
>> of partial clone. If users want to know more about its technical design and
>> other details, users can view the link of git-partial-clone(7) according to
>> the guidelines in the section.
>>
>> Derrick Stolee (2):
>>   partial-clone: set default filter with --partial
>>   clone: document --partial and --filter options
>>
>> Dyrone Teng (1):
>>   clone: document partial clone section
> 
>> base-commit: 6c85aac65fb455af85745130ce35ddae4678db84
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-745%2Fdyrone%2Fmaster-v2
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-745/dyrone/master-v2
>> Pull-Request: https://github.com/git/git/pull/745
>>
>> Range-diff vs v1:
> 
> Can you remind readers which thread was the v1?  Hopefully it is not
> this one, right?
> 
>   https://lore.kernel.org/git/20200322192234.GC671552@coredump.intra.peff.net/
> 
> it concluded that it is not a great idea to set default filter with
> "--partial", and the discussion led to a v2 with a reduced scope at
> 
>   https://lore.kernel.org/git/pull.586.v2.git.1584906606469.gitgitgadget@gmail.com/
> 
> and that one is already cooking.

Yes, sorry about that. I started working with Dyrone on this
when my v1 was still being reviewed, so his commits are based
on that branch. Then when I force-pushed my branch his GGG PR
"grew" with the old commits.

Thanks,
-Stolee
