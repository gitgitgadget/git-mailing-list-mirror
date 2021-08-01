Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240FBC4338F
	for <git@archiver.kernel.org>; Sun,  1 Aug 2021 09:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F07976109F
	for <git@archiver.kernel.org>; Sun,  1 Aug 2021 09:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhHAJ5V (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Aug 2021 05:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhHAJ5R (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Aug 2021 05:57:17 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E425C06179A
        for <git@vger.kernel.org>; Sun,  1 Aug 2021 02:56:20 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id c16so17711291wrp.13
        for <git@vger.kernel.org>; Sun, 01 Aug 2021 02:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=RJ+mA0xDwzk1gi+XDMQHJuNaMl/nPa4C9ya7Y4N6amU=;
        b=BqktMn1xJPCmzBOX+zHKslmI/ZyDPPaoO60+CmsASJjOTVyPAEWlzowQtnPms5Fcrb
         o4UTWufVK5uh++/BzBsT3VsMa17QNdIvTmRZI4zHKuFGbssaRdUwgpfSqmnXw2P+J9NK
         vIfwDCesTMYliA+NVSPVhWzXjPvlVTpY6dH3DbZwOpjHYuCUa+N3hS+SlNkmNmaSzwm7
         1ixM6R2l4OcLGrZyPR8HYHLxxPu+ePySoIW+cYDJk2KD1xLkPYXxg8t/u9b+xe5c3Dtf
         Rp03NJOvpIVOhqM4q2NykmAJMnrXJX82BsLwi94p8RGGLq2qvOE4a7bvne0gnCrLF9pr
         hDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RJ+mA0xDwzk1gi+XDMQHJuNaMl/nPa4C9ya7Y4N6amU=;
        b=gUaQmUX4zycJYSnPMoln/9w4Q611CEayRj6dtrSzyXlPxzYvWY3QPtdCtWiUechfiU
         axwEoodOTi7WmgSBZ6FJDyufSFfUGg7I3IPPaWZsYSgAgVCU/5aYaRjR4cYBc8uLE79X
         IdEbkM0z47GTnRRSb+MXmUFw5v1L8Y9SwlaBypfz+/KrsDYc6++5I0VWAfDFfFkmE96w
         CKMR3BDquqJIcqDqswQ3H/iLqimNd/8PvrlmjAdOqxN8qnR6sNSnElCneMZmMDkQ0Mzm
         4OeKqd0veNA4O3FkThhXsi1nqoWaF9mz2eynLPW4Xpv3bczpKXWd5lVC8vWKRX/uuKXF
         QGbA==
X-Gm-Message-State: AOAM5338gqTJA0OSE3TqntPZpPlI537OjjG0GgmMP7nmtHa/oA2Z/+Pv
        JDWt3uBzSZmaAcv1lZSJoaFPxKr1wCI=
X-Google-Smtp-Source: ABdhPJwAKItFWNWqvvKSm5e9vc4tdYwN8EWNugpxvemevICLiVCzgqyJyRsK16WE9YStIufAAc8M/Q==
X-Received: by 2002:adf:fc10:: with SMTP id i16mr11906596wrr.229.1627811778820;
        Sun, 01 Aug 2021 02:56:18 -0700 (PDT)
Received: from [192.168.1.14] (host-2-98-21-22.as13285.net. [2.98.21.22])
        by smtp.gmail.com with ESMTPSA id n5sm6960400wme.47.2021.08.01.02.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Aug 2021 02:56:18 -0700 (PDT)
Subject: Re: [BUG] 'git rebase -i ---rebase-merges' can leave MERGE_MSG behind
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
References: <20210731062322.GB23408@szeder.dev>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <80afcf4f-fc5a-7722-1a4d-c3e1f1de1e09@gmail.com>
Date:   Sun, 1 Aug 2021 10:56:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210731062322.GB23408@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/07/2021 07:23, SZEDER Gábor wrote:
> Hi,
> 
> 'git rebase -i --rebase-merges' leaves a stray '.git/MERGE_MSG' file
> behind after it re-created an unchanged merge commit.  The test script
> below demonstrates this issue (it doesn't fail, but look at its
> verbose output to see what the issue and its consequences are).
> 
> This issue is as old as --rebase-merges, I see the same output with
> v2.18.0, the first release containing this feature.
> 
> I suspect that fixing this is merely a matter of adding a missing
> unlink(".git/MERGE_MSG") to the right place, but I won't dive into the
> sequencer machinery to figure out where that right place might be :)

Looking at do_merge() in sequencer.c .git/MERGE_MSG is written before it 
checks if it can fast-forward. If it does fast-forward then 'git commit' 
is not run and .git/MERGE_MSG is not removed. I think the best way to 
fix it would be to move the fast-forward code so it comes before the 
code that writes .git/MERGE_MSG. That way we'll not write the message if 
we can fast-forward.

Best Wishes

Phillip

> 
>    ---  >8  ---
> 
> #!/bin/sh
> 
> test_description='test'
> 
> . ./test-lib.sh
> . "$TEST_DIRECTORY"/lib-rebase.sh
> 
> test_expect_success '--rebase-merges leaves MERGE_MSG behind' '
> 	# A-B-M-D-E-F
> 	#  \ /
> 	#   C
> 	test_commit A &&
> 	test_commit B &&
> 	git checkout -b branch HEAD^ &&
> 	test_commit C &&
> 	git checkout master &&
> 	git merge --log branch &&
> 	test_commit D &&
> 	test_commit E &&
> 	test_commit F &&
> 
> 	# Rewrite a commit after the merge:
> 	write_script todo-editor <<-\EOF &&
> 	sed -i -e "/^pick .* E$/ s/^pick/edit/" "$1"
> 	EOF
> 
> 	# No MERGE_MSG present before starting the rebase, good:
> 	test_path_is_missing .git/MERGE_MSG &&
> 
> 	# Start rebasing before the merge, so the sequencer has to
> 	# re-create an identical merge commit.
> 	GIT_EDITOR=./todo-editor git rebase -i --rebase-merges A &&
> 
> 	# Just to make sure that the history so far is unchanged:
> 	test_cmp_rev E HEAD &&
> 
> 	# BUG: now there is a stray MERGE_MSG file:
> 	cat .git/MERGE_MSG &&
> 
> 	# And it interferes with the next "git commit", because its
> 	# content is included in the commit message template:
> 	echo foo >>E.t &&
> 	GIT_EDITOR=cat git commit -a
> '
> 
> test_done
> 
