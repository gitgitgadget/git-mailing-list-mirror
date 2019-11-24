Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C75C432C0
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 10:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0155E2071A
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 10:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msQZxhk5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfKXKoR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 05:44:17 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40774 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfKXKoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 05:44:16 -0500
Received: by mail-wm1-f68.google.com with SMTP id y5so12515459wmi.5
        for <git@vger.kernel.org>; Sun, 24 Nov 2019 02:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rUAWGm2vdqKm/K+9Syny/QXxdgIUAyShJs7Rh3jgrFo=;
        b=msQZxhk5zIk9RBKKzN8IFy1nDltZzMvpXnSl6Xq4c0GSM7VfB1ssu/6y7W7qCWv4UJ
         MmpVgi4jRE/PmEO8acWNaW0uYXrSzAiUlmrJOCBaRkH2wskOUhWirSLCDx0yYC1sjmjj
         Rz9h1bMNxHYrGDSdXOthsGjz0Ls9/dk3KgdXNTcQeFrGSr0EPUrkruSg8WrBv8tvm9o9
         m18nm1yMqabf838MCi7nSlOlzZiXcklU5zSQxh4py49FKj0zyvx2+iRzAEXsJNgl7aOv
         YjVdId67CWVBX2rPFAYzOS1pF/TAnUrbqj1yfsiPWDl0Wdn5r683ssI0dYR8RoppQmHJ
         KGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rUAWGm2vdqKm/K+9Syny/QXxdgIUAyShJs7Rh3jgrFo=;
        b=TjyymO0nqpFk3CAtC0eyqIu3tovtpL7JcJxW65hCh5lsMcVP8pIoDhXhT0wjAWQSh8
         BP5ERTmt94LGgOXb6FU+ScHgZ7pLuaOf8w9F0BQ4r8a83hf1uIwVF1l849ELxtfp67wv
         FJIW7gSK7jiC+WhtJuamPGwwt8/rkAABiD9GnA15Q3DShTV5JwT7U0bIoRFurbA1P3og
         3JQ9mX+UjCxzLWV/NzNuVpNzkAc7eXoyvdjM6xJMVn3zE9UJu4QPQ3UHTEljsDHLix7Q
         4R/PLYT/5KLt/7Nfk4BpW9/RZv2VwKZGwOst/UQEJcxY+w2T5jbat+/iTUi23xSPwGY4
         L3vA==
X-Gm-Message-State: APjAAAVmpU7rnfwZVBMTk/brhYU/ZVAv3SmhYsDyzrNJwykzCR1j52CR
        5lVSJgSZHy901zqTdh0ZS90=
X-Google-Smtp-Source: APXvYqzaEkq37Y3ZQ2v80s2llCByF+HfH5g6qWt3ehLWNew/6MF8B1MCmiVfxlm/NOvGdX4lmNNrwg==
X-Received: by 2002:a05:600c:2143:: with SMTP id v3mr24011205wml.3.1574592253450;
        Sun, 24 Nov 2019 02:44:13 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-28-211.as13285.net. [92.22.28.211])
        by smtp.gmail.com with ESMTPSA id b63sm4586573wmb.40.2019.11.24.02.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2019 02:44:12 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer: don't re-read todo for revert and cherry-pick
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <e7c01e0f-8466-c2c5-b53a-a93f941dfb1c@gmail.com>
 <20191123172046.16359-1-szeder.dev@gmail.com>
 <xmqqk17p280y.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <8c21662f-6548-a46e-9c87-eb364355cb78@gmail.com>
Date:   Sun, 24 Nov 2019 10:44:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqk17p280y.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/11/2019 04:49, Junio C Hamano wrote:

Thanks for working on this Gábor

> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
>> When 'git revert' or 'git cherry-pick --edit' is invoked with multiple
>> commits, then after editing the first commit message is finished both
> 
> "commits, then after editing the first commit message, both of" I
> would say.
> 
>> these commands should continue with processing the second commit and
>> launch another editor for its commit message, assuming there are
>> no conflicts, of course.
>>
>> Alas, this inadvertently changed with commit a47ba3c777 (rebase -i:
>> check for updated todo after squash and reword, 2019-08-19): after
>> editing the first commit message is finished, both 'git revert' and
>> 'git cherry-pick --edit' exit with error, claiming that "nothing to
>> commit, working tree clean".
>> ...
>>    - When invoking 'git revert' or 'git cherry-pick --edit' with
>>      multiple commits they don't read a todo list file but assemble the
>>      todo list in memory, thus the associated stat data used to check
>>      whether the file has been updated is all zeroed out initially.
>>
>>      Then the sequencer writes all instructions (including the very
>>      first) to the todo file, executes the first 'revert/pick'
>>      instruction, and after the user finished editing the commit
>>      message the changes of a47ba3c777 kick in, and it checks whether
>>      the todo file has been modified.  The initial all-zero stat data
>>      obviously differs from the todo file's current stat data, so the
>>      sequencer concludes that the file has been modified.  Technically
>>      it is not wrong, of course, because the file just has been written
>>      indeed by the sequencer itself, though the file's contents still
>>      match what the sequencer was invoked with in the beginning.
>>      Consequently, after re-reading the todo file the sequencer
>>      executes the same first instruction _again_, thus ending up in
>>      that "nothing to commit" situation.
> 
> Hmph, that makes it sound as if the right fix is to re-read after
> writing the first version of the todo file out, so that the stat
> data matches reality and tells us that it has never been modified?

I think we should update the stat data after we write the todo list. 
ag/sequencer-todo-updates changes the rebase startup sequence to avoid 
the initial read that populates the stat data. There's a subtle 
difference in the todo list handling between rabese and 
cherry-pick/revert. The list written by rebase does not include the 
commit currently being picked but it does for cherry-pick/revert. This 
means that rebase is not subject to this bug in 
ag/sequencer-todo-updates as although it re-reads the todo list because 
the stat data is zero the list does not contain the commit we've just 
picked.

> 
>> The todo list was never meant to be edited during multi-commit 'git
>> revert' or 'cherry-pick' operations, so perform that "has the todo
>> file been modified" check only when the sequencer was invoked as part
>> of an interactive rebase.
> 
> OK.  That is a valid fix, I think, but the explanation given in the
> second bullet point gives a wrong impression that it is merely a
> workaround (iow, we are assuming that the user would behave, instead
> of making sure we can detect when the user touches the list), when
> it is *not*.
> 

I'd be happier not to set check_todo in the first place unless we're 
rebasing (though one could argue that Gábor's version is more future-proof)

>> diff --git a/sequencer.c b/sequencer.c
>> index 2adcf5a639..3b05d0277d 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -3791,7 +3791,7 @@ static int pick_commits(struct repository *r,
>>   							item->commit,
>>   							arg, item->arg_len,
>>   							opts, res, 0);
>> -		} else if (check_todo && !res) {
>> +		} else if (is_rebase_i(opts) && check_todo && !res) {
> 
> It is a bit sad that setting of check_todo is not something a single
> helper function can decide, so that this is_rebase_i(opts) can be
> taken into account when that helper function (the logical place
> would be do_pick_commit()) decides to set (or not set) check_todo.
> 
> Unfortunately, that is not sufficient, I suspect.  Why did a47ba3c7
> ("rebase -i: check for updated todo after squash and reword",
> 2019-08-19) decide to flip check_todo on when running TODO_EXEC?

I'm not sure what you mean by this

This is what I had before I saw Gábor's patch (the tests are pretty 
similar but I think we should check that the messages of all the picks 
are actually edited with --edit - that does not seem to be checked by 
the current tests) Note this does not include updating the stat data 
after writing the todo list yet as I've only just thought about that.
Gábor are you happy to take this forward?

Best Wishes

Phillip


--- 8> ---

diff --git a/sequencer.c b/sequencer.c
index f2abe2a366..b363b45366 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1999,7 +1999,7 @@ static int do_pick_commit(struct repository *r,
                         res = do_commit(r, msg_file, author, opts, flags);
                 else
                         res = error(_("unable to parse commit author"));
-               *check_todo = !!(flags & EDIT_MSG);
+               *check_todo = is_rebase_i(opts) && !!(flags & EDIT_MSG);
                 if (!res && reword) {
  fast_forward_edit:
                         res = run_git_commit(r, NULL, opts, EDIT_MSG |
diff --git a/t/t3508-cherry-pick-many-commits.sh 
b/t/t3508-cherry-pick-many-commits.sh
index b457333e18..fd9d626779 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -40,6 +40,31 @@ test_expect_success 'cherry-pick first..fourth works' '
         check_head_differs_from fourth
  '

+test_expect_success 'cherry-pick --edit first..fourth works' '
+       git checkout -f master &&
+       git reset --hard first &&
+       test_tick &&
+       GIT_EDITOR="echo edited >>" git cherry-pick --edit first..fourth &&
+       git log --pretty=format:%B -3 >actual &&
+       cat >expect <<-\EOF &&
+       fourth
+
+       edited
+
+       third
+
+       edited
+
+       second
+
+       edited
+       EOF
+       test_cmp expect actual &&
+       git diff --quiet other &&
+       git diff --quiet HEAD other &&
+       check_head_differs_from fourth
+'
+
  test_expect_success 'cherry-pick three one two works' '
         git checkout -f first &&
         test_commit one &&
@@ -153,6 +178,37 @@ test_expect_success 'revert first..fourth works' '
         git diff --quiet HEAD first
  '

+test_expect_success 'revert --edit first..fourth works' '
+       git checkout -f master &&
+       git reset --hard fourth &&
+       test_tick &&
+       GIT_EDITOR="echo edited >>" git revert --edit first..fourth &&
+       git log --pretty=format:%B -3 >actual &&
+       cat >expect <<-EOF &&
+       Revert "second"
+
+       This reverts commit $(git rev-parse second).
+
+       edited
+
+       Revert "third"
+
+       This reverts commit $(git rev-parse third).
+
+       edited
'

+test_expect_success 'revert --edit first..fourth works' '
+       git checkout -f master &&
+       git reset --hard fourth &&
+       test_tick &&
+       GIT_EDITOR="echo edited >>" git revert --edit first..fourth &&
+       git log --pretty=format:%B -3 >actual &&
+       cat >expect <<-EOF &&
+       Revert "second"
+
+       This reverts commit $(git rev-parse second).
+
+       edited
+
+       Revert "third"
+
+       This reverts commit $(git rev-parse third).
+
+       edited
+
+       Revert "fourth"
+
+       This reverts commit $(git rev-parse fourth).
+
+       edited
+       EOF
+       test_cmp expect actual &&
+       git diff --quiet first &&
+       git diff --cached --quiet first &&
+       git diff --quiet HEAD first
+'
+
  test_expect_success 'revert ^first fourth works' '
         git checkout -f master &&
         git reset --hard fourth &&



