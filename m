Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EB9C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 16:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB8C2080D
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 16:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRZ71ZqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfLIQAU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:00:20 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42604 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfLIQAU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 11:00:20 -0500
Received: by mail-wr1-f67.google.com with SMTP id a15so16757093wrf.9
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 08:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IrlUKEPpKdeWPqR5MKZ3hor+ujUrvzzpXBa4+jSozOQ=;
        b=aRZ71ZqKhOhVDDTDiTIq8JsHII4dbVE3ziJBEa7SnDmWMKgvHBpSRIYcJB5Q8JOJ6e
         yQ9sFmsfxAIBPOWt855ulkotyCDmWydOVMIV9idWdoETO0dgVAZbmtYpJ24Pk5PWHFKQ
         ndj9qG0P4a3pgW+BY8niIpa3MpTi+R7atcf/EtMtxGsGOIPbm/M+7csYLiTvi26RtLy5
         xaYaGFHLkwEi99Iy9J+9CUTNgo02O7wZyEzs5mTTnDbNuVV9gnQcqwitf4VfDU4OzeGj
         /5zERBgejI2MMrmUGCfea6966S1Dnh68gqC0VMMG+pWkvmlbTpEXEizTxU3F55m1M6Lk
         zEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IrlUKEPpKdeWPqR5MKZ3hor+ujUrvzzpXBa4+jSozOQ=;
        b=oM5gY3qcBw9EYzX7CZ4z7kLsVEGZEC4mVKADgJOKzJB/mUSNgPBWHWf1MoAyk34DrD
         Slf+AThgHbeEnEwsfysagP3OAScCeo4kbdbLazD6iBL1II2Q4K5JZY+UJstlJlU1q7ed
         me58TvumVd4PD0qC1wBEMKvS0tbH54g70CXdywmexZxyw6YJCs5lOW7hKNEnTH61bctm
         Dpd74o+eHhdpPQLRb9kayrcujzfzOfJceviQLNJ66jaV6yeK48/76Giaz4yCuUEb+Om1
         h58eQn22Q2F3rhzKLtBKt2hoWIclSaa+AdvyQBTnG/iwHwA2dZrN3T4ho1pJ3XBbei/l
         NHLw==
X-Gm-Message-State: APjAAAU8t432ilGyDGBhboQzDOt8Cit3yit8465RVJ7/8Oxib74CIZzv
        bsStFVzDaguvN4ryfJCkD+ZN4UC4
X-Google-Smtp-Source: APXvYqwfTmOddx12SL6emazGfabl408TfkaDEXEbHZ27YMHhsDAjNVk6joegrazTKm6YIKoC+EsxiQ==
X-Received: by 2002:adf:f484:: with SMTP id l4mr2967668wro.207.1575907216221;
        Mon, 09 Dec 2019 08:00:16 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-0-192.as13285.net. [92.22.0.192])
        by smtp.gmail.com with ESMTPSA id 5sm29226004wrh.5.2019.12.09.08.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 08:00:15 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] rebase-interactive: warn if commit is dropped with
 `rebase --edit-todo'
To:     Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20191104095449.9964-1-alban.gruin@gmail.com>
 <20191202234759.26201-1-alban.gruin@gmail.com>
 <20191202234759.26201-3-alban.gruin@gmail.com>
 <xmqqk17b5263.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <64aa4049-ee35-df4c-1e6c-80707f4f9070@gmail.com>
Date:   Mon, 9 Dec 2019 16:00:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqk17b5263.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban and Junio

On 04/12/2019 19:19, Junio C Hamano wrote:
> Alban Gruin <alban.gruin@gmail.com> writes:
> 
>> When set to "warn" or "error", `rebase.missingCommitsCheck' would make
>> `rebase -i' warn if the user removed commits from the todo list to
>> prevent mistakes.  Unfortunately, `rebase --edit-todo' and `rebase
>> --continue' don't take it into account.
>>
>> This adds the ability for `rebase --edit-todo' and `rebase --continue'
>> to check if commits were dropped by the user.  As both edit_todo_list()
>> and complete_action() parse the todo list and check for dropped commits,
>> the code doing so in the latter is removed to reduce duplication.
>> `edit_todo_list_advice' is removed from sequencer.c as it is no longer
>> used there.
>>
>> This changes when a backup of the todo list is made.  Until now, it was
>> saved only before the initial edit.  Now, it is always performed before
>> the todo list is edited.  Without this, sequencer_continue() (`rebase
>> --continue') could only compare the current todo list against the
>> original, unedited list.  Before this change, this file was only used by
>> edit_todo_list() and `rebase -p' to create the backup before the initial
>> edit, and check_todo_list_from_file(), only used by `rebase -p' to check
>> for dropped commits after its own initial edit.
>>
>> Three tests are added to t3404.  The tests for
>> `rebase.missingCommitsCheck = warn' and `rebase.missingCommitsCheck =
>> error' have a similar structure.  First, we start a rebase with an
>> incorrect command on the first line.  Then, we edit the todo list,
>> removing the first and the last lines.  This demonstrates that
>> `--edit-todo' notices dropped commits, but not when the command is
>> incorrect.  Then, we restore the original todo list, and edit it to
>> remove the last line.  This demonstrates that if we add a commit after
>> the initial edit, then remove it, `--edit-todo' will notice that it has
>> been dropped.  Then, the actual rebase takes place.  In the third test,
>> it is also checked that `--continue' will refuse to resume the rebase if
>> commits were dropped.
>>
>> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
>> ---
>>   rebase-interactive.c          | 22 ++++++----
>>   sequencer.c                   | 24 +++++-----
>>   t/t3404-rebase-interactive.sh | 83 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 110 insertions(+), 19 deletions(-)
> 
> Let me see if I understand the primary idea behind this change by
> trying to paraphrase the log (read: this is not to suggest a better
> phrasing of the log message proposed in your message).
> 
>   * rebase-interactive.c::edit_todo_list() does not perform "did the
>     user delete a pick, instead of turning pick into drop?" but after
>     the end-user edits the file is the most logical place to do so.
>     Let's do that there.
> 
>   * The sequencer used to perform "did the user delete a pick,
>     instead of turning pick into drop?" check in complete_action().
>     We drop that call but for this particular codepath it does not
>     make any behaviour difference due to the next item.
> 
>   * New code does the check in sequencer_continue(), which is called
>     at the end of complete_action(), as well as many other places,
>     like builtin/rebase.c, builtin/revert.c, and sequencer_skip().
>     Because the check is only done when we are running "rebase-i",
>     this is safe---it only affects complete_action().
> 
> I hope I got it more-or-less correctly ;-)
> 
>> diff --git a/rebase-interactive.c b/rebase-interactive.c
>> index ad5dd49c31..80b6a2e7a6 100644
>> --- a/rebase-interactive.c
>> +++ b/rebase-interactive.c
>> @@ -97,7 +97,8 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
>>   		   struct todo_list *new_todo, const char *shortrevisions,
>>   		   const char *shortonto, unsigned flags)
>>   {
>> -	const char *todo_file = rebase_path_todo();
>> +	const char *todo_file = rebase_path_todo(),
>> +		*todo_backup = rebase_path_todo_backup();
>>   	/* If the user is editing the todo list, we first try to parse
>> @@ -110,9 +111,9 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
>>   				    -1, flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP))
>>   		return error_errno(_("could not write '%s'"), todo_file);
>>   
>> -	if (initial && copy_file(rebase_path_todo_backup(), todo_file, 0666))
>> -		return error(_("could not copy '%s' to '%s'."), todo_file,
>> -			     rebase_path_todo_backup());
>> +	unlink(todo_backup);
>> +	if (copy_file(todo_backup, todo_file, 0666))
>> +		return error(_("could not copy '%s' to '%s'."), todo_file, todo_backup);
> 
> We used to copy ONLY when initial is set and we left old todo_backup
> intact when !initial.  That is no longer true after this change, but
> it is intended---we create an exact copy of what we would hand out
> to the end-user, so that we can compare it with the edited result
> to figure out what got changed.

I think it would be better to only create a new copy if the last edit 
was successful. As it stands if I edit the todo list and accidentally 
delete some lines and then edit the todo list again to try and fix it 
the second edit will succeed whether or not I reinserted the deleted lines.

We could add this to the tests to check that a subsequent edit that does 
not fix the problem fails

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 969e12d281..8544d8ab2c 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh

@@ -1416,6 +1416,7 @@ test_expect_success 'rebase --edit-todo respects 
rebase.missingCommitsCheck = er
                 test_i18ncmp expect actual &&
                 test_must_fail git rebase --continue 2>actual &&
                 test_i18ncmp expect actual &&
+               test_must_fail git rebase --edit-todo &&
                 cp orig .git/rebase-merge/git-rebase-todo &&
                 test_must_fail env FAKE_LINES="1 2 3 4" \
                         git rebase --edit-todo 2>actual &&


> 
> We unlink(2) unconditionally because the only effect we want to see
> here is that todo_backup does not exist before we call copy_file()
> that wants to do O_CREAT|O_EXCL.  I wonder if we want to avoid
> unlink() when initial, and also if we want to do unlink_or_warn()
> when !initial (read: this is just "wondering" without thinking long
> enough to suggest that doing so would be better)
> 
>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>> index 29a35840ed..9051c1e11d 100755
>> --- a/t/t3404-rebase-interactive.sh
>> +++ b/t/t3404-rebase-interactive.sh
>> @@ -1343,6 +1343,89 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
>>   	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
>>   '
>>   
>> +test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = ignore' '
>> +	test_config rebase.missingCommitsCheck ignore &&
>> +	rebase_setup_and_clean missing-commit &&
>> +	set_fake_editor &&
>> +	FAKE_LINES="break 1 2 3 4 5" git rebase -i --root &&
>> +	FAKE_LINES="1 2 3 4" git rebase --edit-todo 2>actual &&
> 
> OK, so we lost "pick 5" but with missing-check disabled, that should
> not trigger any annoying warning or error.
> 
>> +	git rebase --continue 2>actual &&

This clobbers actual which hasn't been used yet

>> +	test D = $(git cat-file commit HEAD | sed -ne \$p) &&
> 
>> +	test_i18ngrep \
>> +		"Successfully rebased and updated refs/heads/missing-commit" \
>> +		actual
>> +'
>> +
>> +test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = warn' '
>> +	cat >expect <<-EOF &&
>> +	error: invalid line 1: badcmd $(git rev-list --pretty=oneline --abbrev-commit -1 master~4)
>> +	Warning: some commits may have been dropped accidentally.
>> +	Dropped commits (newer to older):
>> +	 - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
>> +	To avoid this message, use "drop" to explicitly remove a commit.
>> +	EOF
>> +	tail -n4 expect >expect.2 &&
>> +	test_config rebase.missingCommitsCheck warn &&
>> +	rebase_setup_and_clean missing-commit &&
>> +	set_fake_editor &&
>> +	test_must_fail env FAKE_LINES="bad 1 2 3 4 5" \
>> +		git rebase -i --root &&
>> +	cp .git/rebase-merge/git-rebase-todo.backup orig &&
>> +	FAKE_LINES="2 3 4" git rebase --edit-todo 2>actual.2 &&
>> +	head -n5 actual.2 >actual &&
>> +	test_i18ncmp expect actual &&
> 
> OK, so we lost "pick 1" while discarding "bad", and we should notice
> the lossage?  I see "head -n5" there, which means we are still
> getting "invalid line 1: badcmd", even though FAKE_LINES now got rid
> of "bad"?  Puzzled...

Is the bad there to stop the rebase so we can edit the todo list? If so 
it would be better to use 'break' instead.

Best Wishes

Phillip
