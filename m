Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B889BC77B7F
	for <git@archiver.kernel.org>; Thu, 11 May 2023 15:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238445AbjEKPJl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 11:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238482AbjEKPJk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 11:09:40 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5472133
        for <git@vger.kernel.org>; Thu, 11 May 2023 08:09:31 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-b9d8730fe5aso11244834276.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 08:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1683817771; x=1686409771;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BGh26smpmKGTtTgBZ2rC9YyNP02k2xNINdHNJCHN77U=;
        b=FrL9bUGKDe5p3/KSAhmCB/5ZAllLc+8UPUXOu0SkKIFuOPERBVVcXAB0AWol+69RID
         B9Uscv+lfzffBJBOIrv1TVuYyvpYqiSohhWjUMZDwVQvcW2C4WMdcLMbtX0c2+fk8w4d
         uZl60LN2jBDBOMB3UJ09qZ2lZ1T8NY5xgjVtOG37OTzLQfDI+cMyGuYggewmkVhILBI6
         Cg3gPLY3/QGbN6SKiLsSw9+waGjyQCAhnEXGBCtOArk4ZAGn7ehPrAqZlrcNAJWBUpTm
         7Ig/iUX2MGZSt+Os8k0xaou/2PwSB1DjfKuJGP6vxkUhr68qEqcBxLpdRHEwDVS4z+WU
         xNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683817771; x=1686409771;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGh26smpmKGTtTgBZ2rC9YyNP02k2xNINdHNJCHN77U=;
        b=DMQbCR8yGy+m+Kwyk4gIzpS+GGa0GOCkj1P8i6Y7Ajg8xqV6Xf/YuNvP3tbKLGdFMF
         KDuKElAt+kQeu9mqSGT3n0UeL4WwEL+QpXnjUHv3x2rkESLCC2cnGEa3VyBsFxG3taRO
         /CfhjiO2Tpek9jCp9K3guRPsuZo3v69y6yrsuQIpHUzHvLGyGfIXXafEDcTyMmV+0TGR
         Ia1lBSx2LQqkBxH162xWRWj6zJK2JEzngJIwSXQBEOnAZqzEWpWOj6/vRpoqIchXgzCx
         39VQ5PFsjkd7Jzfj1XklzTzFA+rkW7/iRWkS4LjfVkDnuBCJpSup7/KevXqEaY35iLpM
         mpYg==
X-Gm-Message-State: AC+VfDzLuctGxI+blHXSLlmnABXTMQaTChPieX0WJfZ5LiwpvAGl/8un
        yXUISpNLEHTe0nypzcDuLEhf
X-Google-Smtp-Source: ACHHUZ6GroT893epTzvFKRN4ZaAK+UrELXYnZhB1xqoaFZY0/lSPuUUaGg6D0on1lidG9seW51/zvg==
X-Received: by 2002:a25:b02:0:b0:ba6:a77c:4d0 with SMTP id 2-20020a250b02000000b00ba6a77c04d0mr1398057ybl.61.1683817770679;
        Thu, 11 May 2023 08:09:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:c583:6563:bc4f:3e20? ([2600:1700:e72:80a0:c583:6563:bc4f:3e20])
        by smtp.gmail.com with ESMTPSA id b12-20020a25b84c000000b00b8f6ec5a955sm4376578ybm.49.2023.05.11.08.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 08:09:30 -0700 (PDT)
Message-ID: <015dcb79-9630-e188-65cf-23b005184db1@github.com>
Date:   Thu, 11 May 2023 11:09:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] merge-tree: load default git config
Content-Language: en-US
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, christian.couder@gmail.com
References: <pull.1530.git.1683745654800.gitgitgadget@gmail.com>
 <645bfed357efc_3819294e1@chronos.notmuch>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <645bfed357efc_3819294e1@chronos.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/10/2023 4:30 PM, Felipe Contreras wrote:
> Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> The 'git merge-tree' command handles creating root trees for merges
>> without using the worktree. This is a critical operation in many Git
>> hosts, as they typically store bare repositories.
>>
>> This builtin does not load the default Git config, which can have
>> several important ramifications.
> 
> For the record, I had already sent a better version of this patch almost 2
> years ago [1], not just for `git merge-tree`, but other commands as well.
> 
> The obvious fix was completely ignored by the maintainer.
> 
> The reason why it should be git_xmerge_config and not git_default_config, is
> that merge.conflictstyle would not be parsed if you call git_default_config.

As mentioned by Elijah in a different thread, the merge machinery loads
the merge config as needed. I confirmed by creating this test, which I
may submit as an independent patch:

test_expect_success 'merge-tree respects merge.conflictstyle' '
	test_commit conflict-base &&
	for branch in left right
	do
		git checkout -b $branch conflict-base &&
		echo $branch >>conflict-base.t &&
		git add conflict-base.t &&
		git commit -m $branch || return 1
	done &&

	test_must_fail git merge-tree left right >out1 &&
	test_must_fail git -c merge.conflictstyle=diff3 merge-tree left right >out2 &&

	tree1=$(head -n 1 out1) &&
	tree2=$(head -n 1 out2) &&

	git cat-file -p $tree1:conflict-base.t >conflict1 &&
	git cat-file -p $tree2:conflict-base.t >conflict2 &&
	! test_cmp conflict1 conflict2 &&
	! grep "||||||" conflict1 &&
	grep "||||||" conflict2
'

Thus we do not need to use git_xmerge_config at this point in the
process.

Thanks,
-Stolee
