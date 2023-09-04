Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F70C83F3F
	for <git@archiver.kernel.org>; Mon,  4 Sep 2023 14:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbjIDOha (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Sep 2023 10:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242649AbjIDOh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Sep 2023 10:37:29 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C05CFB
        for <git@vger.kernel.org>; Mon,  4 Sep 2023 07:37:25 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-401da71b83cso14941775e9.2
        for <git@vger.kernel.org>; Mon, 04 Sep 2023 07:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693838244; x=1694443044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fuh9itsd6M/8+aqYMeFb8llmv30O1M4wJ6xoZ5KAGNI=;
        b=VLUg0O47ds51+8/3SGGjCtxPqqwTLVNAkIDuFb5a4B03b35nBmJmA1N70x4xYVbV2P
         NAHY/f9gWqaCokX9fc0xvCRcC1UdwM0fx6JOIZWKFo2hRALH2Vf4DKLbZkv/D+ewCKWW
         Vq1ZP7Wa/7jN7SL+P6Mn4wdoYKiSCxWfy2/hSiCyGZHU5C/OTOw1mLkNYYlcZAZ/AarV
         W2S8RnlocMzPmapAW41zivXp4H8+OERZ2z0/awSqgHTGd2ZQev+hxhJGJD/FMpR5x77X
         fbCDu5pDNNwzdbaEwPVAyZbhoeJdL4UGERBt/lskXvE/dyGhP72hz+sptjExaX8GjqCT
         FUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693838244; x=1694443044;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fuh9itsd6M/8+aqYMeFb8llmv30O1M4wJ6xoZ5KAGNI=;
        b=a2eHXniWXas6PMZwFtqG9H30tRdbfSfG5OmKxcymv2SgKW70R42MHdzyXGk3g6jqZU
         zBeAlkQi3so+2JdosXFcsgvC+GLhLGDVJKzV8MJDQyXJ19tDaBa8CVnvNsrd3E4xuYmY
         gUEgg4xD6La7mCdkAGkeEuw17Z891GCkeipwZIbF4BqOOevaCRAjOrwpI5t7D5ZGGwji
         JFoSq+9XkwKGyt5O6OcDuhB5RpN1vOKCajNQJQaRbdxQIn5u2rc6c5xHmY9X1xPf0XTc
         tozxmP1lTP8iXMP47QNFjwJkO8FTOcbf1ikuCADuLLN7pu2BSCH2R14KSTcU4BBmS5O8
         J2Lg==
X-Gm-Message-State: AOJu0Yzkc7f9I9M5OiT9PdZi9oVjwTzINc1ngFVPTkhajXX4t5g1QaBr
        gphFL/zY5aCy+vWammCuZh8=
X-Google-Smtp-Source: AGHT+IF6AezyVUMM4hv84Xg7FxRkiqbf/29K9tNiRD66O7t/j7TeeLhFmOTfhNkaMBAeJv1Jrem8ow==
X-Received: by 2002:a1c:7417:0:b0:3f8:2777:15e with SMTP id p23-20020a1c7417000000b003f82777015emr6951349wmc.31.1693838243860;
        Mon, 04 Sep 2023 07:37:23 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id f22-20020a7bc8d6000000b00401c9228bf7sm14111094wml.18.2023.09.04.07.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 07:37:23 -0700 (PDT)
Message-ID: <02c28b26-4658-43c8-b1d1-7f1e09bda609@gmail.com>
Date:   Mon, 4 Sep 2023 15:37:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 6/7] rebase --continue: refuse to commit after failed
 command
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
 <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
 <2ed7cbe5fff2d104a1246783909c6c4b75c559f2.1690903412.git.gitgitgadget@gmail.com>
 <a5bfea5f-0d0d-f7ed-3f72-37e3db6f5b2c@gmx.de>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <a5bfea5f-0d0d-f7ed-3f72-37e3db6f5b2c@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 23/08/2023 10:01, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Tue, 1 Aug 2023, Phillip Wood via GitGitGadget wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> If a commit cannot be picked because it would overwrite an untracked
>> file then "git rebase --continue" should refuse to commit any staged
>> changes as the commit was not picked. This is implemented by refusing to
>> commit if the message file is missing. The message file is chosen for
>> this check because it is only written when "git rebase" stops for the
>> user to resolve merge conflicts.
>>
>> Existing commands that refuse to commit staged changes when continuing
>> such as a failed "exec" rely on checking for the absence of the author
>> script in run_git_commit(). This prevents the staged changes from being
>> committed but prints
>>
>>      error: could not open '.git/rebase-merge/author-script' for
>>      reading
>>
>> before the message about not being able to commit. This is confusing to
>> users and so checking for the message file instead improves the user
>> experience. The existing test for refusing to commit after a failed exec
>> is updated to check that we do not print the error message about a
>> missing author script anymore.
> 
> I am delighted to see an improvement of the user experience!
> 
> However, I could imagine that users would still be confused when seeing
> the advice about staged changes, even if nothing was staged at all.

If nothing is staged then this message wont trigger because is_clean 
will be false.

> Could you introduce a new advice message specifically for the case where
> untracked files are in the way and prevent changes from being applied?

We have an advice message now that is printed when the rebase stops in 
that case. The message here is printed when the user runs "rebase 
--continue" with staged changes and we're not expecting to commit 
anything because the commit couldn't be picked or we're containing from 
a break command or bad exec/label/reset etc.


> P.S.: To save both you and me time, here is my ACK for patch 7/7
> (actually, the entire patch series, but _maybe_ you want to change
> "impove" -> "improve" in the cover letter's subject) ;-)

Thanks for taking the time to read through the patches and for you 
comments. I'll fix the typo when I re-roll

Best Wishes

Phillip

>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   sequencer.c                   |  5 +++++
>>   t/t3404-rebase-interactive.sh | 18 +++++++++++++++++-
>>   t/t3430-rebase-merges.sh      |  4 ++++
>>   3 files changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index e25abfd2fb4..a90b015e79c 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -4977,6 +4977,11 @@ static int commit_staged_changes(struct repository *r,
>>
>>   	is_clean = !has_uncommitted_changes(r, 0);
>>
>> +	if (!is_clean && !file_exists(rebase_path_message())) {
>> +		const char *gpg_opt = gpg_sign_opt_quoted(opts);
>> +
>> +		return error(_(staged_changes_advice), gpg_opt, gpg_opt);
>> +	}
>>   	if (file_exists(rebase_path_amend())) {
>>   		struct strbuf rev = STRBUF_INIT;
>>   		struct object_id head, to_amend;
>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>> index 6d3788c588b..a8ad398956a 100755
>> --- a/t/t3404-rebase-interactive.sh
>> +++ b/t/t3404-rebase-interactive.sh
>> @@ -604,7 +604,8 @@ test_expect_success 'clean error after failed "exec"' '
>>   	echo "edited again" > file7 &&
>>   	git add file7 &&
>>   	test_must_fail git rebase --continue 2>error &&
>> -	test_i18ngrep "you have staged changes in your working tree" error
>> +	test_i18ngrep "you have staged changes in your working tree" error &&
>> +	test_i18ngrep ! "could not open.*for reading" error
>>   '
>>
>>   test_expect_success 'rebase a detached HEAD' '
>> @@ -1290,6 +1291,11 @@ test_expect_success 'rebase -i commits that overwrite untracked files (pick)' '
>>   	test_cmp_rev REBASE_HEAD I &&
>>   	rm file6 &&
>>   	test_path_is_missing .git/rebase-merge/patch &&
>> +	echo changed >file1 &&
>> +	git add file1 &&
>> +	test_must_fail git rebase --continue 2>err &&
>> +	grep "error: you have staged changes in your working tree" err &&
>> +	git reset --hard HEAD &&
>>   	git rebase --continue &&
>>   	test_cmp_rev HEAD I
>>   '
>> @@ -1310,6 +1316,11 @@ test_expect_success 'rebase -i commits that overwrite untracked files (squash)'
>>   	test_cmp_rev REBASE_HEAD I &&
>>   	rm file6 &&
>>   	test_path_is_missing .git/rebase-merge/patch &&
>> +	echo changed >file1 &&
>> +	git add file1 &&
>> +	test_must_fail git rebase --continue 2>err &&
>> +	grep "error: you have staged changes in your working tree" err &&
>> +	git reset --hard HEAD &&
>>   	git rebase --continue &&
>>   	test $(git cat-file commit HEAD | sed -ne \$p) = I &&
>>   	git reset --hard original-branch2
>> @@ -1330,6 +1341,11 @@ test_expect_success 'rebase -i commits that overwrite untracked files (no ff)' '
>>   	test_cmp_rev REBASE_HEAD I &&
>>   	rm file6 &&
>>   	test_path_is_missing .git/rebase-merge/patch &&
>> +	echo changed >file1 &&
>> +	git add file1 &&
>> +	test_must_fail git rebase --continue 2>err &&
>> +	grep "error: you have staged changes in your working tree" err &&
>> +	git reset --hard HEAD &&
>>   	git rebase --continue &&
>>   	test $(git cat-file commit HEAD | sed -ne \$p) = I
>>   '
>> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
>> index 4938ebb1c17..804ff819782 100755
>> --- a/t/t3430-rebase-merges.sh
>> +++ b/t/t3430-rebase-merges.sh
>> @@ -169,6 +169,10 @@ test_expect_success 'failed `merge -C` writes patch (may be rescheduled, too)' '
>>   	grep "^merge -C .* G$" .git/rebase-merge/done &&
>>   	grep "^merge -C .* G$" .git/rebase-merge/git-rebase-todo &&
>>   	test_path_is_missing .git/rebase-merge/patch &&
>> +	echo changed >file1 &&
>> +	git add file1 &&
>> +	test_must_fail git rebase --continue 2>err &&
>> +	grep "error: you have staged changes in your working tree" err &&
>>
>>   	: fail because of merge conflict &&
>>   	git reset --hard conflicting-G &&
>> --
>> gitgitgadget
>>
>>
