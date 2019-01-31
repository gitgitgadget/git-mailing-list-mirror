Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26BCE1F453
	for <e@80x24.org>; Thu, 31 Jan 2019 20:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfAaUq3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 15:46:29 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:53771 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfAaUq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 15:46:28 -0500
Received: from [192.168.2.240] ([92.26.116.186])
        by smtp.talktalk.net with SMTP
        id pJE9gK3bnwhzSpJE9gbrEH; Thu, 31 Jan 2019 20:46:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1548967586;
        bh=ApWUz5nMwz4t1XypXlx86d9oT+VmTVn/+kNcvCBIbfk=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jBhplgTdrl/kE1Gn38BQv22nVy8k6GcKtSGxDaU5IgmTgQdgODab5hR3W31wU9mmM
         K3ol7wnywStik+njibUn7LU9CDy/vKsa/p86305apGHsAXYwLDPAm178aiJ0yPXbKa
         wUqjIMwpKOjN1+s9Pne1FLJ1KTXSUTcglgFElYLw=
X-Originating-IP: [92.26.116.186]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=Pfo8oxCPEre7EYRssK5nbQ==:117
 a=Pfo8oxCPEre7EYRssK5nbQ==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=UlqV6C1OAAAA:20 a=tisMccnxu44uBSEnSt0A:9 a=QEXdDO2ut3YA:10
 a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 07/16] sequencer: refactor
 sequencer_add_exec_commands() to work on a todo_list
To:     Alban Gruin <alban.gruin@gmail.com>, phillip.wood@dunelm.org.uk,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20190123205821.27459-1-alban.gruin@gmail.com>
 <20190129150159.10588-1-alban.gruin@gmail.com>
 <20190129150159.10588-8-alban.gruin@gmail.com>
 <434cf0f7-1df6-7966-b460-e69e8f8b5e99@talktalk.net>
 <c5e3c1cc-12fa-ddf6-7008-ae47659ddc19@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <5f3c9739-8b12-bf27-681d-5b3563f1c75f@talktalk.net>
Date:   Thu, 31 Jan 2019 20:46:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <c5e3c1cc-12fa-ddf6-7008-ae47659ddc19@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfEHL7rCZJPLWwD2au5qq2s9ekqw632svv8mhHitjqEVxgClfARY3bl6qUYawJoVrgmg8mztdT234tbLJNJ6I8KU8ggFanEiogKoAUiZPvgsoNlxqlN52
 X8Jb72LH7QZ05eyqlAXqPZOjpo2sl/MJidC/yKG58Ly58NYZm6kRFfsFL/ZLtfccbKYNE1/09zt/IIPhf2iqc12JOf49+ZNRvivbHgSaE7nxB6qP7JOQujXJ
 0pu+/aHuSfbDBzJrU7ZShFF6FWADq5u7SoKzJk61+t7XuC48rkRDJPOqXEsJRkySrpBO/Dl7qqT9N+BVPBQeCA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

On 31/01/2019 20:37, Alban Gruin wrote:
> Hi Phillip,
> 
> Le 31/01/2019 à 15:30, Phillip Wood a écrit :
>> Hi Alban
>>
>> On 29/01/2019 15:01, Alban Gruin wrote:
>>> This refactors sequencer_add_exec_commands() to work on a todo_list to
>>> avoid redundant reads and writes to the disk.
>>>
>>> Instead of inserting the `exec' commands between the other commands and
>>> re-parsing the buffer at the end, they are appended to the buffer once,
>>> and a new list of items is created.  Items from the old list are copied
>>> across and new `exec' items are appended when necessary.  This
>>> eliminates the need to reparse the buffer, but this also means we have
>>> to use todo_list_write_to_disk() to write the file.
>>>
>>> todo_list_add_exec_commands() and sequencer_add_exec_commands() are
>>> modified to take a string list instead of a string -- one item for each
>>> command.  This makes it easier to insert a new command to the todo list
>>> for each command to execute.
>>>
>>> sequencer_add_exec_commands() still reads the todo list from the disk,
>>> as it is needed by rebase -p.
>>>
>>> complete_action() still uses sequencer_add_exec_commands() for now.
>>> This will be changed in a future commit.
>>>
>>> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
>>> ---
>>>   builtin/rebase--interactive.c |  15 +++--
>>>   sequencer.c                   | 110 +++++++++++++++++++++-------------
>>>   sequencer.h                   |   5 +-
>>>   3 files changed, 82 insertions(+), 48 deletions(-)
>>>
>>> diff --git a/builtin/rebase--interactive.c
>>> b/builtin/rebase--interactive.c
>>> index df19ccaeb9..53056ee713 100644
>>> --- a/builtin/rebase--interactive.c
>>> +++ b/builtin/rebase--interactive.c
>>> @@ -65,7 +65,7 @@ static int do_interactive_rebase(struct replay_opts
>>> *opts, unsigned flags,
>>>                    const char *onto, const char *onto_name,
>>>                    const char *squash_onto, const char *head_name,
>>>                    const char *restrict_revision, char *raw_strategies,
>>> -                 const char *cmd, unsigned autosquash)
>>> +                 struct string_list *commands, unsigned autosquash)
>>>   {
>>>       int ret;
>>>       const char *head_hash = NULL;
>>> @@ -116,7 +116,7 @@ static int do_interactive_rebase(struct
>>> replay_opts *opts, unsigned flags,
>>>           discard_cache();
>>>           ret = complete_action(the_repository, opts, flags,
>>>                         shortrevisions, onto_name, onto,
>>> -                      head_hash, cmd, autosquash);
>>> +                      head_hash, commands, autosquash);
>>>       }
>>>   
>>>       free(revisions);
>>> @@ -139,6 +139,7 @@ int cmd_rebase__interactive(int argc, const char
>>> **argv, const char *prefix)
>>>       const char *onto = NULL, *onto_name = NULL, *restrict_revision =
>>> NULL,
>>>           *squash_onto = NULL, *upstream = NULL, *head_name = NULL,
>>>           *switch_to = NULL, *cmd = NULL;
>>> +    struct string_list commands = STRING_LIST_INIT_DUP;
>>>       char *raw_strategies = NULL;
>>>       enum {
>>>           NONE = 0, CONTINUE, SKIP, EDIT_TODO, SHOW_CURRENT_PATCH,
>>> @@ -221,6 +222,12 @@ int cmd_rebase__interactive(int argc, const char
>>> **argv, const char *prefix)
>>>           warning(_("--[no-]rebase-cousins has no effect without "
>>>                 "--rebase-merges"));
>>>   
>>> +    if (cmd && *cmd) {
>>> +        string_list_split(&commands, cmd, '\n', -1);
>>
>> This whole splitting and later skipping 'exec ' is a bit of a shame - it
>> would be much nicer if we could just have one exec command per -x option
>> but I think that is outside the scope of this series (If I have time I'd
>> like to look at calling do_interactive_rebase() directly from
>> builtin/rebase.c without forking rebase--interactive).
>>
> 
> Yes, I completely agree with you.  I thought to do this in preparation
> to drop rebase -r.
> 
>>> +        if (strlen(commands.items[commands.nr - 1].string) == 0)
>>
>> I'd be tempted just to test the string using !* rather than calling
>> strlen.
>>
> 
> Right.  I’m still not used to this pattern.
> 
>> Also is there ever a case where the last string isn't empty?
> 
> I don’t think so.  When rebase.c prepares the arguments for
> rebase--interactive, it always add a newline at the end[1].  Do you want
> me to drop this check?

I think that would be clearer

> 
> 
>>> +            --commands.nr;
>>> +    }
>>> +
>>>       switch (command) {
>>>       case NONE:
>>>           if (!onto && !upstream)
>>> @@ -228,7 +235,7 @@ int cmd_rebase__interactive(int argc, const char
>>> **argv, const char *prefix)
>>>   
>>>           ret = do_interactive_rebase(&opts, flags, switch_to,
>>> upstream, onto,
>>>                           onto_name, squash_onto, head_name,
>>> restrict_revision,
>>> -                        raw_strategies, cmd, autosquash);
>>> +                        raw_strategies, &commands, autosquash);
>>>           break;
>>>       case SKIP: {
>>>           struct string_list merge_rr = STRING_LIST_INIT_DUP;
>>> @@ -262,7 +269,7 @@ int cmd_rebase__interactive(int argc, const char
>>> **argv, const char *prefix)
>>>           ret = rearrange_squash(the_repository);
>>>           break;
>>>       case ADD_EXEC:
>>> -        ret = sequencer_add_exec_commands(the_repository, cmd);
>>> +        ret = sequencer_add_exec_commands(the_repository, &commands);
>>>           break;
>>>       default:
>>>           BUG("invalid command '%d'", command);
>>> diff --git a/sequencer.c b/sequencer.c
>>> index 266f80d704..3a90b419d7 100644
>>> --- a/sequencer.c
>>> +++ b/sequencer.c
>>> @@ -4446,25 +4446,27 @@ int sequencer_make_script(struct repository
>>> *r, FILE *out,
>>>       return 0;
>>>   }
>>>   
>>> -/*
>>> - * Add commands after pick and (series of) squash/fixup commands
>>> - * in the todo list.
>>> - */
>>> -int sequencer_add_exec_commands(struct repository *r,
>>> -                const char *commands)
>>> +static void todo_list_add_exec_commands(struct todo_list *todo_list,
>>> +                    struct string_list *commands)
>>>   {
>>> -    const char *todo_file = rebase_path_todo();
>>> -    struct todo_list todo_list = TODO_LIST_INIT;
>>> -    struct strbuf *buf = &todo_list.buf;
>>> -    size_t offset = 0, commands_len = strlen(commands);
>>> -    int i, insert;
>>> +    struct strbuf *buf = &todo_list->buf;
>>> +    size_t base_offset = buf->len;
>>> +    int i, insert, nr = 0, alloc = 0;
>>> +    struct todo_item *items = NULL, *base_items = NULL;
>>>   
>>> -    if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
>>> -        return error(_("could not read '%s'."), todo_file);
>>> +    base_items = xcalloc(commands->nr, sizeof(struct todo_item));
>>> +    for (i = 0; i < commands->nr; ++i) {
>>> +        size_t command_len = strlen(commands->items[i].string);
>>>   
>>> -    if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
>>> -        todo_list_release(&todo_list);
>>> -        return error(_("unusable todo list: '%s'"), todo_file);
>>> +        strbuf_addstr(buf, commands->items[i].string);
>>> +        strbuf_addch(buf, '\n');
>>> +
>>> +        base_items[i].command = TODO_EXEC;
>>> +        base_items[i].offset_in_buf = base_offset;
>>> +        base_items[i].arg_offset = base_offset + strlen("exec ");
>>> +        base_items[i].arg_len = command_len - strlen("exec ");
>>> +
>>> +        base_offset += command_len + 1;
>>>       }
>>>   
>>>       /*
>>> @@ -4473,38 +4475,62 @@ int sequencer_add_exec_commands(struct
>>> repository *r,
>>>        * those chains if there are any.
>>>        */
>>>       insert = -1;
>>> -    for (i = 0; i < todo_list.nr; i++) {
>>> -        enum todo_command command = todo_list.items[i].command;
>>> -
>>> -        if (insert >= 0) {
>>> -            /* skip fixup/squash chains */
>>> -            if (command == TODO_COMMENT)
>>> -                continue;
>>> -            else if (is_fixup(command)) {
>>> -                insert = i + 1;
>>> -                continue;
>>> -            }
>>> -            strbuf_insert(buf,
>>> -                      todo_list.items[insert].offset_in_buf +
>>> -                      offset, commands, commands_len);
>>
>> In a todo list that looks like
>> pick abc message
>> #pick cde empty commit
>> This inserts the exec command for the first pick above the commented out
>> pick. I think your translation puts it below the commented out pick as
>> it ignores the value of insert. I think it's probably easiest to add an
>> INSERT_ARRAY macro to insert it in the right place. An alternative might
>> be to track the last insert position and only copy commands across when
>> there is another exec to insert but that might get complicated in cases
>> such as
>>
>> pick abc message
>> #squash cde squash! message //empty commit for rewording
>> fixup 123 fixup! message
>> #pick 456 empty commit
>>
> 
> I could do this with MOVE_ARRAY(), no?

Yes, if you extend the array first then you could use MOVE_ARRAY() and 
COPY_ARRAY() to move the comment down and then insert the exec commands 
so maybe we don't need a new macro after all.

I've looked through most of the rest of this series (I think I've got 
three patches left to check) and they all look fine, I'll try and look 
at the rest tomorrow, but if not I'll get round to it next week.

Best Wishes

Phillip

>> Best Wishes
>>
>> Phillip
>>
> 
> [1] https://github.com/git/git/blob/master/builtin/rebase.c#L1182-L1191
> 
> Cheers,
> Alban
> 
> 

