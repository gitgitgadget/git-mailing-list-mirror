Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834A5EB64DD
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 09:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjGUJcC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 05:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGUJcB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 05:32:01 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB01730C0
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 02:31:58 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fc0aecf15bso15171805e9.1
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 02:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689931917; x=1690536717;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ozbpl9l9oXN1Met4rfzKueq9FxbpTf5LHUxWoneFR0g=;
        b=jFCO1j2G6+ezJFsgy3zOA1aPnvobhNDDhMDHq6Qx6ntnFYX7/q5qqw55VAcygTPTaq
         RFECbblq97bjBDCSCDQdEDVV8MpGoigkwdj6dDTqwbIaFM6lKNQ2ztiZFBLt5sv08AvE
         j5CZEDCoo/wDj1jU6noTKr5ytK+TvgudJo31aYadz3nRkReFzINWClOotq/XvSour4xi
         bjA9cGbj6GPAQVv089x8O157ZE0BBhMXM3CE4I2v4BKrlgrWDcnoqtxMc53vVMZs6doF
         CCTqtPT91oiR7m2BAo6mFVnnIA0M3eYpo9L8J+fB3Kuba2pJXQ6fctHhGhLBNVh/Leh2
         R2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689931917; x=1690536717;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ozbpl9l9oXN1Met4rfzKueq9FxbpTf5LHUxWoneFR0g=;
        b=ZFP7pKrV7FgRF1p0f8cP6gckqAS8vzh6UhC7nnA96smDVxlnZ9hQLmCNSFdOSuyiK2
         PDDSgz/PDxfNw/LTY9WOEmmvs+EUg8Zav5C6KCJn+wU7gu9yyxvVKNWE2NPW2IQ5ej5F
         yAb9ciYKHQuiFC4tq7+QD368Trg5BWSBd/HYOWxQdI7YgLTrsRT08sxKHrbmlG9zy3Cp
         Gr+WMPnIqZggi0C7xkrgfLyimJ1y2IR7RBr4f9OUXQVZikdtj14F2+r3iK5PIUzndiC5
         4UeGT85nY0oTyOg5uQSx1BSvPJULLU1NcHtY0qhJPj/Y9mlD0vUa+FlIdcDrEQkweJT8
         LPMQ==
X-Gm-Message-State: ABy/qLavDEPA3k+vcdxSVDM5eJHg2A3XsN/mZQORI3Q79d72oVQy2TKW
        bk4CA53YiVfYkAnjv61r+Hs=
X-Google-Smtp-Source: APBJJlENP+SgmukGtdmL3/XfKLAsTg/l5PjO6bq84Ks+D8u/ehbWDkVACiG65qFwCXgNBeDXXobrEg==
X-Received: by 2002:a7b:c30c:0:b0:3fb:c9f4:1506 with SMTP id k12-20020a7bc30c000000b003fbc9f41506mr1020111wmj.1.1689931917163;
        Fri, 21 Jul 2023 02:31:57 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id a5-20020adfdd05000000b0031433d8af0dsm3647292wrm.18.2023.07.21.02.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 02:31:56 -0700 (PDT)
Message-ID: <c7b7f078-6561-5081-9c23-0cec65b71c97@gmail.com>
Date:   Fri, 21 Jul 2023 10:31:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer: finish parsing the todo list despite an
 invalid first line
Content-Language: en-US
To:     Alex Henrie <alexhenrie24@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, alban.gruin@gmail.com, gitster@pobox.com
References: <20230719144339.447852-1-alexhenrie24@gmail.com>
 <395274b4-37a9-8c95-203f-94178c99772a@gmail.com>
 <CAMMLpeSN_M1HW1D3HyuY+S+GwUrQ_4dP9qoSQ72hbQv3pwK5kg@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAMMLpeSN_M1HW1D3HyuY+S+GwUrQ_4dP9qoSQ72hbQv3pwK5kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 20/07/2023 23:37, Alex Henrie wrote:
> On Thu, Jul 20, 2023 at 3:42 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> 
>> On 19/07/2023 15:43, Alex Henrie wrote:
>>> ddb81e5072 (rebase-interactive: use todo_list_write_to_file() in
>>> edit_todo_list(), 2019-03-05) made edit_todo_list more efficient by
>>> replacing transform_todo_file with todo_list_parse_insn_buffer.
>>> Unfortunately, that innocuous change caused a regression because
>>> todo_list_parse_insn_buffer would stop parsing after encountering an
>>> invalid 'fixup' line. If the user accidentally made the first line a
>>> 'fixup' and tried to recover from their mistake with `git rebase
>>> --edit-todo`, all of the commands after the first would be lost.
>>
>> I found this description a little confusing as transform_todo_file()
>> also called todo_list_parse_insn_buffer(). transform_todo_file() does
>> not exist anymore but it looked like
>>
>> static int transform_todo_file(unsigned flags)
>> {
>>           const char *todo_file = rebase_path_todo();
>>           struct todo_list todo_list = TODO_LIST_INIT;
>>           int res;
>>
>>           if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
>>                   return error_errno(_("could not read '%s'."), todo_file);
>>
>>           if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
>>                                           &todo_list)) {
>>                   todo_list_release(&todo_list);
>>                   return error(_("unusable todo list: '%s'"), todo_file);
>>           }
>>
>>           res = todo_list_write_to_file(the_repository, &todo_list,
>> todo_file,
>>                                         NULL, NULL, -1, flags);
>>           todo_list_release(&todo_list);
>>
>>           if (res)
>>                   return error_errno(_("could not write '%s'."), todo_file);
>>           return 0;
>> }
>>
>> If it could not parse the todo list it did not try and write it to disc.
>> After ddb81e5072 this changed as edit_todo_list() tries to shorten the
>> OIDs in the todo list before it is edited even if it cannot be parsed.
>> The fix below works around that by making sure we always try and parse
>> the whole todo list even if the the first line is a fixup command. That
>> is a worthwhile improvement because it means we notify the user of all
>> the errors we find rather than just the first one and is in keeping with
>> the way we handle other invalid lines. It does not however fix the root
>> cause of this regression which is the change in behavior in
>> edit_todo_list().
>>
>> After the user edits the todo file we do not try to transform the OIDs
>> if it cannot be parsed or has missing commits. Therefore it still
>> contains the shortened OIDs and editing hints and there is no need for
>> edit_todo_list() to call write_todo_list() when "incorrect" is true.
> 
> When the user first runs `git rebase`, the commit template contains
> the following message:
> 
> # However, if you remove everything, the rebase will be aborted.
> 
> When running `git rebase --edit-todo`, that message is replaced with:
> 
> # You are editing the todo file of an ongoing interactive rebase.
> # To continue rebase after editing, run:
> #     git rebase --continue
> 
> The second message is indeed more accurate after the rebase has
> started: Deleting all of the lines in `git rebase --edit-todo` drops
> all of the commits; it does not abort the rebase.

Oh, good point

> It would be nice to preserve as much of the user's original input as
> possible, but that's not a project that I'm going to tackle.

I think with your patch we do that anyway as other invalid lines are 
already passed through verbatim.

> As far as
> a minimal fix for the regression, we can either leave the todo file
> untouched and display inaccurate advice during `git rebase
> --edit-todo`, or we can lose any long commit IDs that the user entered
> and display equivalent short hex IDs instead. I would prefer the
> latter.

That's fine but the commit message should explain that decision and 
clarify why ddb81e5072 caused the regression as 
todo_list_parse_insn_buffer() is unchanged by that commit. The 
regression is caused by ddb81e5072 trying to shorten the OIDs and add 
the correct advice even when we cannot parse the todo list. That is a 
worthwhile change that we want to keep but means we need to tweak 
todo_list_parse_insn_buffer() in order to avoid truncating the todo list.

>>> +             test_i18ngrep "cannot .fixup. without a previous commit" \
>>> +                             actual &&
>>> +             test_i18ngrep "You can fix this with .git rebase --edit-todo.." \
>>> +                             actual &&
>>> +             grep -v "^#" .git/rebase-merge/git-rebase-todo >orig &&
>>> +             test_must_fail git rebase --edit-todo &&
>>> +             grep -v "^#" .git/rebase-merge/git-rebase-todo >actual &&
>>> +             test_cmp orig actual
>>
>> We check that the uncommitted lines after running "git rebase
>> --edit-todo" match the uncommitted lines after the initial edit. That's
>> fine to detect if the second edit truncates the file but it will still
>> pass if the initial edit starts truncating the todo list as well. As we
>> expect that git should not change an incorrect todo list we do not need
>> to filter out the lines beginning with "#".
>>
>> To ensure we detect a regression where the first edit truncates the todo
>> list we could do something like
>>
>>          test_when_finished "git rebase --abort" &&
>>          cat >todo <<-EOF &&
>>          fixup $(git log -1 --format="%h %s" B)
>>          pick $(git log -1 --format="%h %s" C)
>>          EOF
>>
>>          (
>>                  set_replace_editor todo &&
>>                  test_must_fail git rebase -i A 2>actual
>>          ) &&
>>          test_i18ngrep "cannot .fixup. without a previous commit" actual &&
>>          test_i18ngrep "You can fix this with .git rebase --edit-todo.." actual &&
>>          # check initial edit has not truncated todo list
>>          grep -v "^#" .git/rebase-merge/git-rebase-todo >actual &&
>>          test_cmp todo actual &&
>>          cat .git/rebase-merge/git-rebase-todo >expect &&
>>          test_must_fail git rebase --edit-todo &&
>>          # check the list is unchanged by --edit-todo
>>          test_cmp expect .git/rebase-merge/git-rebase-todo
> 
> To me it seems pretty far-fetched that a future bug would cause the
> _initial_ commit template to be missing anything.

Indeed but I'm talking about the initial todo list _after_ it has been 
edited by the user, not the initial template. If we started trying to 
lengthen the OIDs and remove the advice after the initial edit even when 
the list cannot be parsed then we'd have exactly this problem.

Best Wishes

Phillip

> But if you're
> concerned about it, would you like to send a follow-up patch to revise
> the test as you see fit?
> 
>> We could perhaps check the error message from "git rebase --edit-todo"
>> as well.
> 
> That sounds like another good change for v2.
> 
> Thanks for the feedback,
> 
> -Alex
