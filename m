Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C79C282DD
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 14:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9022F2072E
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 14:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nv0qXq8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgAJOoe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:44:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32841 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbgAJOoe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 09:44:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so2079968wrq.0
        for <git@vger.kernel.org>; Fri, 10 Jan 2020 06:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=njX4dr0QdwANDsGEzACB+3YeQ06jm4KGYHQOb3fsNLc=;
        b=Nv0qXq8/6KFadybAmcAjcvKojBJiqwjNsazHpqpypHKpCPWExbrsWHrvjz25BG+Vk1
         ECHesxdKQdELyoB8ETj1FQoG0Uuu6bvds3vnN9XAgQctNyW7nUhgh89idHnyUhhlSScp
         bRREUjgNPYKOKdaIooBcaLZIXIbSJcpQD5JxpslozbTiwC7/nYyfqFbcXGfbr5/MGsWk
         tO/FQgWkL0n0oMJhRGU4cqP3ZPf8P13Z0fYPGQm3qnf+3C6ToMvH2e6Cp9CdXQuEd+Po
         0YOi1t0jpAsA8IP+0xCc6pUkng9L2AtiqfUqg+GF/4GaRSoxwzHUymxjYeMWko7bEp9Y
         isCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=njX4dr0QdwANDsGEzACB+3YeQ06jm4KGYHQOb3fsNLc=;
        b=Q7xmC8aocDL1FsltK9Oh4I5VMOnwzmRQquEfBS6d0Q2bOt9HtIvFX+NreEy2jq8eB7
         ZBdGMj/k+o1qAo1VTIEbNu61oaLYifqmxKRJmYt0OyDPEld1slL10gXsExNyfy1VKxZU
         A6vf5SXNO/kZp8kepLo4EPoWyP1suMtqV+VkSfWpPBkCg7cSw2XM9bJEbrUA7/YraLAt
         6asmP/7bj2S0cdhth36zkdIiy6u5ao5YGLhnBuz6GUtsCQKx4xuhjk7Jyz+GLUi1UZRX
         G8RlPpWyzIBwqYH834u0zeflP0MK1/OHW1dyA27kEBMs3+nhR4gUVZiSlWbUi/jUGAS9
         kwCA==
X-Gm-Message-State: APjAAAV/61G9fiHxBP1cuh+h7LwzP8vZ871MKfVBf8JQcpt+7rEBC/1m
        kcfo2wnI0xULCX5yAFmktAA=
X-Google-Smtp-Source: APXvYqyJASiuuSHzDwpqI5Fv1wfnU4RdTs5S+koeC17AbI3v9pjUHcS/cY5yxNvny+vMKmRtC4yKDQ==
X-Received: by 2002:a5d:5091:: with SMTP id a17mr3996006wrt.362.1578667471808;
        Fri, 10 Jan 2020 06:44:31 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-12-92.as13285.net. [92.22.12.92])
        by smtp.gmail.com with ESMTPSA id x6sm2379063wmi.44.2020.01.10.06.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 06:44:31 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 00/17] merge: learn --autostash
To:     Denton Liu <liu.denton@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cover.1571246693.git.liu.denton@gmail.com>
 <cover.1577185374.git.liu.denton@gmail.com>
 <xmqqo8vpfpri.fsf@gitster-ct.c.googlers.com>
 <4032e4bd-fa3d-54eb-fe95-38549dff3aaa@gmail.com>
 <20200108060842.GA51465@generichostname>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <f545a13f-4b3c-9603-7511-ff80ad950ee9@gmail.com>
Date:   Fri, 10 Jan 2020 14:44:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200108060842.GA51465@generichostname>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

On 08/01/2020 06:08, Denton Liu wrote:
> Hi Phillip,
> 
> Sorry for the late reply. I'm back in school so I've been pretty busy
> lately.
> 
> On Tue, Dec 31, 2019 at 10:34:30AM +0000, Phillip Wood wrote:
>> For `merge --autostash` I think we need to consider the interaction of
>> `--no-commit` with `--autostash` as `stash pop` will refuse to run if the
>> merge modified any of the stashed paths.
> 
> The only time when we run the `stash pop` is when we either commit the
> merge or abort it. With this in mind, what do you think of the following
> test cases? If they look good, I can squash them into the appropriate
> patch and send in a reroll.

Ah I misunderstood what happened with --autostash and --no-commit, the 
tests basically look fine (I've got one comment below).

One other thing - if the user runs `git reset` or `git checkout 
<branch>` then cleanup_branch_state() removes MERGE_HEAD, MERGE_MSG etc. 
If we're not already doing so then I think we should remove 
MERGE_AUTOSTASH as well or you can get into a situation where the user 
does something like

   git merge --autostash <something> # results in conflicts
   git reset --hard <somewhere else>
   git merge <something> # succeeds and confusingly pops previous stash

Running `git reset` doesn't make sense unless they want to discard the 
stashed changes as well. This is a difference with rebase where you 
cannot lose the stashed changes by running `git reset`, the only way 
they can get lost is by running `rebase --quit`.  We could always add a 
warning about it throwing away the stashed changes in the future.

I still not keen on the name `--autostash` as it's not automatic. 
`--stash` would make more sense to me. We'd have to deprecate `rebase 
--autostash` in favor of `rebase --stash` to change it but it if we want 
to change the name it would be better now before adding `--autostash` to 
merge and pull - what do you think?

> 	diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> 	index e0c8a0bad4..af5db58e16 100755
> 	--- a/t/t7600-merge.sh
> 	+++ b/t/t7600-merge.sh
> 	@@ -727,6 +727,33 @@ test_expect_success 'conflicted merge with --autostash, --abort restores stash'
> 		test_cmp file.1 file
> 	 '
> 	
> 	+test_expect_success 'completed merge with --no-commit and --autostash' '
> 	+	git reset --hard c1 &&
> 	+	git merge-file file file.orig file.9 &&

Is this a complicated way of getting some unstaged changes so we can 
stash them or have I missed something?

Best Wishes

Phillip

> 	+	git diff >expect &&
> 	+	git merge --no-commit --autostash c2 &&
> 	+	git stash show -p MERGE_AUTOSTASH >actual &&
> 	+	test_cmp expect actual &&
> 	+	git commit 2>err &&
> 	+	test_i18ngrep "Applied autostash." err &&
> 	+	git show HEAD:file >merge-result &&
> 	+	test_cmp result.1-5 merge-result &&
> 	+	test_cmp result.1-5-9 file
> 	+'
> 	+
> 	+test_expect_success 'aborted merge with --no-commit and --autostash' '
> 	+	git reset --hard c1 &&
> 	+	git merge-file file file.orig file.9 &&
> 	+	git diff >expect &&
> 	+	git merge --no-commit --autostash c2 &&
> 	+	git stash show -p MERGE_AUTOSTASH >actual &&
> 	+	test_cmp expect actual &&
> 	+	git merge --abort 2>err &&
> 	+	test_i18ngrep "Applied autostash." err &&
> 	+	git diff >actual &&
> 	+	test_cmp expect actual
> 	+'
> 	+
> 	 test_expect_success 'merge with conflicted --autostash changes' '
> 		git reset --hard c1 &&
> 		git merge-file file file.orig file.9y &&
> 
> Thanks,
> 
> Denton
> 
>>
>> Best Wishes
>>
>> Phillip
