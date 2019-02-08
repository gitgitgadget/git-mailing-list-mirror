Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AABC71F453
	for <e@80x24.org>; Fri,  8 Feb 2019 10:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfBHK4z (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 05:56:55 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:26037 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfBHK4z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 05:56:55 -0500
Received: from [192.168.2.201] ([92.22.16.34])
        by smtp.talktalk.net with SMTP
        id s3pygUP8UAGVrs3pygfoun; Fri, 08 Feb 2019 10:56:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1549623412;
        bh=Alx66Is8cWbD8NDv3GblMrOGNBsr1ep1+GgWxChrKd8=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=nn2SVE9ZxtZoRawYOMhCnJF5EI7ueRjG9Uord5gvgwRWe9KpDiHlQuqjUApihigT1
         4j5P1iIpG8oP7+z20BaG0syT0jpV6+M5SiiAhbr3v2UupdqX0VGAbywEgsf0+j4s5p
         I0G4FJGMPUG9acyoAj3/RNRJql44wbt1PrP1D5cI=
X-Originating-IP: [92.22.16.34]
X-Spam: 0
X-OAuthority: v=2.3 cv=DtN4Bl3+ c=1 sm=1 tr=0 a=W5dqCoKFvwrB3nI5M4amZw==:117
 a=W5dqCoKFvwrB3nI5M4amZw==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=p2fjKOgulplG_nRdmXAA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 14/16] rebase-interactive: rewrite edit_todo_list() to
 handle the initial edit
To:     Alban Gruin <alban.gruin@gmail.com>, phillip.wood@dunelm.org.uk,
        Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20190123205821.27459-1-alban.gruin@gmail.com>
 <20190129150159.10588-1-alban.gruin@gmail.com>
 <20190129150159.10588-15-alban.gruin@gmail.com>
 <f3652f60-dde4-0e5a-50ab-81536af9bae0@talktalk.net>
 <571e5823-32a0-930c-909d-bb18a3b70a71@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <32bf73bb-7650-0906-093e-d20e22a81d95@talktalk.net>
Date:   Fri, 8 Feb 2019 10:56:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <571e5823-32a0-930c-909d-bb18a3b70a71@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfNC99pnXkpCtHF8pmWqV82kSZ0mfk7gt0JugKbhFB5t3dYfomQwjibQGFH3zKBoNrWjKB/BqXDLY1ra2EDUBLJFbp1NbclrEr20/FnEWI06X04t7VW3R
 xV515Envv34RZcamz851HyT8L+L09zqcsC5A2xi3k5B/JgvIF9JsZ/nIfLNN1Qb1jEVs02B82OsxWQSJJpN29Fvv2ZDicfz7z+aVAQpN+3ZChRIU0FqHEtOi
 n3JtQnXAr/fB1dQTtEFV+5+PYsScqyELYVlXxUBqxJL9Ltnrk3IQ7KeKzAlE44lNjhaK6DTbjMVXr+wJCnyb5g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

On 06/02/2019 21:11, Alban Gruin wrote:
> Hi Phillip,
> 
> I’ve just reread this message and have a couple of additionnal comments.
> 
> Le 01/02/2019 à 12:03, Phillip Wood a écrit :
>> Hi Alban
>>
>> This looks good apart from some missing error handling.
>>
>> On 29/01/2019 15:01, Alban Gruin wrote:
>>> edit_todo_list() is changed to work on a todo_list, and to handle the
>>> initial edition of the todo list (ie. making a backup of the todo
>>> list).
>>>
>>> It does not check for dropped commits yet, as todo_list_check() does not
>>> take the commits that have already been processed by the rebase (ie. the
>>> todo list is edited in the middle of a rebase session).
>>>
>>> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
>>> ---
>>>   builtin/rebase--interactive.c | 24 +++++++++++++++++-
>>>   rebase-interactive.c          | 48 ++++++++++++++++++-----------------
>>>   rebase-interactive.h          |  4 ++-
>>>   sequencer.c                   |  3 +--
>>>   sequencer.h                   |  1 +
>>>   5 files changed, 53 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/builtin/rebase--interactive.c
>>> b/builtin/rebase--interactive.c
>>> index 2dbf8fc08b..645ac587f7 100644
>>> --- a/builtin/rebase--interactive.c
>>> +++ b/builtin/rebase--interactive.c
>>> @@ -13,6 +13,28 @@ static GIT_PATH_FUNC(path_state_dir, "rebase-merge/")
>>>   static GIT_PATH_FUNC(path_squash_onto, "rebase-merge/squash-onto")
>>>   static GIT_PATH_FUNC(path_interactive, "rebase-merge/interactive")
>>>   +static int edit_todo_file(unsigned flags)
>>> +{
>>> +    const char *todo_file = rebase_path_todo();
>>> +    struct todo_list todo_list = TODO_LIST_INIT,
>>> +        new_todo = TODO_LIST_INIT;
>>> +
>>> +    if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
>>> +        return error_errno(_("could not read '%s'."), todo_file);
>>> +
>>> +    strbuf_stripspace(&todo_list.buf, 1);
>>> +    if (!edit_todo_list(the_repository, &todo_list,
>>> +                &new_todo, NULL, NULL, flags) &&
>>> +        todo_list_write_to_file(the_repository, &new_todo, todo_file,
>>> NULL, NULL,
>>> +                    -1, flags & ~(TODO_LIST_SHORTEN_IDS)) < 0)
>>> +        return error_errno(_("could not write '%s'"), todo_file);
>>
>> If edit_todo_list() fails then the function returns 0. I think you need
>> to do
>>
>> if (edit_todo_list() || todo_list_write_file())
>>     return error...
>>
>> todo_list_write_file() forwards the return value of write_message()
>> which is 0/-1 so there is no need for the '< 0'
>>
> 
> With your proposed condition, if edit_todo_list() fails, the error
> "could not write '%s'" will be shown, if I’m not mistaken.

Yes, you're right but as edit_todo_list() will have already printed an
error I decided it didn't matter too much, but it would be better to
avoid it as you suggest.

> But in my
> version, if edit_todo_list() fails, the return value is 0.  Perhaps I
> should write something like this instead:
> 
>     int res = 0;
>     …
>     res = edit_todo_list();
>     if (!res && todo_list_write_to_file())
>         return error;

If you did
	ret = error...;
instead then we always free the todo lists before exiting the function.

>     …
>     return res;
>>> +
>>> +    todo_list_release(&todo_list);
>>> +    todo_list_release(&new_todo);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   static int get_revision_ranges(const char *upstream, const char *onto,
>>>                      const char **head_hash,
>>>                      char **revisions, char **shortrevisions)
>>> @@ -242,7 +264,7 @@ int cmd_rebase__interactive(int argc, const char
>>> **argv, const char *prefix)
>>>           break;
>>>       }
>>>       case EDIT_TODO:
>>> -        ret = edit_todo_list(the_repository, flags);
>>> +        ret = edit_todo_file(flags);
>>>           break;
>>>       case SHOW_CURRENT_PATCH: {
>>>           struct child_process cmd = CHILD_PROCESS_INIT;
>>> diff --git a/rebase-interactive.c b/rebase-interactive.c
>>> index 807f8370db..3301efbe52 100644
>>> --- a/rebase-interactive.c
>>> +++ b/rebase-interactive.c
>>> @@ -87,35 +87,37 @@ void append_todo_help(unsigned keep_empty, int
>>> command_count,
>>>       }
>>>   }
>>>   -int edit_todo_list(struct repository *r, unsigned flags)
>>> +int edit_todo_list(struct repository *r, struct todo_list *todo_list,
>>> +           struct todo_list *new_todo, const char *shortrevisions,
>>> +           const char *shortonto, unsigned flags)
>>>   {
>>>       const char *todo_file = rebase_path_todo();
>>> -    struct todo_list todo_list = TODO_LIST_INIT;
>>> -    int res = 0;
>>> -
>>> -    if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
>>> -        return error_errno(_("could not read '%s'."), todo_file);
>>> -
>>> -    strbuf_stripspace(&todo_list.buf, 1);
>>> -    todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list);
>>> -    if (todo_list_write_to_file(r, &todo_list, todo_file, NULL, NULL,
>>> -1,
>>> -                    flags | TODO_LIST_SHORTEN_IDS |
>>> TODO_LIST_APPEND_TODO_HELP)) {
>>> -        todo_list_release(&todo_list);
>>> -        return -1;
>>> +    unsigned initial = shortrevisions && shortonto;
>>> +
>>> +    if (initial) {
>>> +        todo_list_write_to_file(r, todo_list, todo_file,
>>> shortrevisions, shortonto,
>>> +                    -1, flags | TODO_LIST_SHORTEN_IDS |
>>> TODO_LIST_APPEND_TODO_HELP);
>>
>> This has lost the error handling when we cannot write the file
>>
>>> +
>>> +        if (copy_file(rebase_path_todo_backup(), todo_file, 0666))
>>> +            return error(_("could not copy '%s' to '%s'."), todo_file,
>>> +                     rebase_path_todo_backup());
>>> +    } else {
>>> +        todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list);
>>> +        todo_list_write_to_file(r, todo_list, todo_file, NULL, NULL, -1,
>>> +                    flags | TODO_LIST_SHORTEN_IDS |
>>> TODO_LIST_APPEND_TODO_HELP);
>>
>> error handling again
>>
> 
> I agree for todo_list_write_to_file(), but todo_list_parse_insn_buffer()
> already shows an error, and here it should not return -- we want to edit
> the todo list to remove an error, but git would fail because the todo
> list has an error.

Ah yes, that is what the original was doing


Best Wishes

Phillip

> 
> -- Alban
> 

