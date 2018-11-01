Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 718001F453
	for <e@80x24.org>; Thu,  1 Nov 2018 23:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbeKBIg5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 04:36:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41082 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbeKBIg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 04:36:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id x12-v6so154484wrw.8
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 16:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g8uzFduzvViaHPUA6jdsRpLBLlGqQdSbE4uL1nsXMEI=;
        b=RHn274A5AOgQRnbczLssxmzMqu3N8+4g2KgB4QMpqyMqTY2KEEPjVl7/xW5BXFp3fl
         HTk3Q+kuiGzR7qrkKIdKwgXzo02+e081f33ACiGXhjfgoKvov2GXCuZzITeNWlGqX9j1
         Gl0Nk8OtUoX32QAy2GySdSnP/3U31g/9QeIAzqfMrny/lKiv7nuOv00Ow4sAN6im0F5m
         BBvTHIgDJOJzPHB6juWBQP/uH2ZT4aPi6j3D8Di+aoInz6MzEwWDbdqcPqSYEeTIhcvh
         SFddNDXnvpKZeJxRKWujaJjUc41i0HTMmlv7dzt2ATrMfjoOmRrvlbhdIaDzdHGPehpT
         ZTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=g8uzFduzvViaHPUA6jdsRpLBLlGqQdSbE4uL1nsXMEI=;
        b=F6TVmKEpj00i9EM48jb+xovOvakVjVlKBD6HkOArLR27hwWdOQcVvLH0LO0KKiJ9rB
         /zpyQrM2I30A0JJqV8POTaJ/SqPnTZXbQIUba3Oq1MdBC/4fOmN+3rN41XayhSOqOfv7
         lkNYKnZSPPAt5fh+lQ0ZwHDprReOl7T8Hr9erhAqWpJXsF9guruigZ1a+OJRLogcXtJn
         p50o9luG8e8Wsddma0/qwTmgCv4blL03MfihbiCdNPGmw+RKSWYsJFFF3lN4K3iy9TEQ
         gyR2HoLVz+QsUjBo7tVNQ4//gKBFHVAtBNJUveHtKrftSAlH3Mp8QAqdDumr/qJdDIaq
         6jCw==
X-Gm-Message-State: AGRZ1gLDbh3lIaB91dTzdscvwR/QY1gtcm+dTyrQCrP1WjOtCaIew92S
        yxJCC1IOcQ/33DBiEHwaND0=
X-Google-Smtp-Source: AJdET5epDlvpLWQtSltC/rbg6PK13OiKGZCAgxQpscbBvWWDb6ajI2ljmg0Wto8NEcPwZkDnUYSG6g==
X-Received: by 2002:adf:e888:: with SMTP id d8-v6mr8045472wrm.104.1541115110718;
        Thu, 01 Nov 2018 16:31:50 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-658-1-25-2.w86-222.abo.wanadoo.fr. [86.222.24.2])
        by smtp.gmail.com with ESMTPSA id l9-v6sm14048363wrf.4.2018.11.01.16.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 16:31:50 -0700 (PDT)
Subject: Re: [PATCH v2 06/16] sequencer: refactor
 sequencer_add_exec_commands() to work on a todo_list
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
 <20181027212930.9303-1-alban.gruin@gmail.com>
 <20181027212930.9303-7-alban.gruin@gmail.com>
 <12e849d3-351b-7673-1f14-742d0fbb1ac1@talktalk.net>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c57384de-0996-2294-db8f-0204f9c16226@gmail.com>
Date:   Fri, 2 Nov 2018 00:31:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <12e849d3-351b-7673-1f14-742d0fbb1ac1@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 30/10/2018 à 17:47, Phillip Wood a écrit :
> On 27/10/2018 22:29, Alban Gruin wrote:
>> This refactors sequencer_add_exec_commands() to work on a todo_list to
>> avoid redundant reads and writes to the disk.
>>
>> An obvious way to do this would be to insert the `exec' command between
>> the other commands, and reparse it once this is done.  This is not what
>> is done here.  Instead, the command is appended to the buffer once, and
>> a new list of items is created.  Items from the old list are copied to
>> it, and new `exec' items are appended when necessary.  This eliminates
>> the need to reparse the todo list, but this also means its buffer cannot
>> be directly written to the disk, hence todo_list_write_to_disk().
> 
> I'd reword this slightly, maybe
> 
> Instead of just inserting the `exec' command between the other commands,
> and re-parsing the buffer at the end the exec command is appended to the
> buffer once, and a new list of items is created.  Items from the old
> list are copied across and new `exec' items are appended when necessary.
>  This eliminates the need to reparse the buffer, but this also means we
> have to use todo_list_write_to_disk() to write the file.
> 
>> sequencer_add_exec_commands() still reads the todo list from the disk,
>> as it is needed by rebase -p.  todo_list_add_exec_commands() works on a
>> todo_list structure, and reparses it at the end.
> 
> I think the saying 'reparses' is confusing as that is what we're trying
> to avoid.
> 
>> complete_action() still uses sequencer_add_exec_commands() for now.
>> This will be changed in a future commit.
>>
>> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
>> ---
>>   sequencer.c | 69 +++++++++++++++++++++++++++++++++++++----------------
>>   1 file changed, 49 insertions(+), 20 deletions(-)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index e12860c047..12a3efeca8 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -4216,6 +4216,50 @@ int sequencer_make_script(FILE *out, int argc,
>> const char **argv,
>>       return 0;
>>   }
>>   +static void todo_list_add_exec_commands(struct todo_list *todo_list,
>> +                    const char *commands)
>> +{
>> +    struct strbuf *buf = &todo_list->buf;
>> +    const char *old_buf = buf->buf;
>> +    size_t commands_len = strlen(commands + strlen("exec ")) - 1;
>> +    int i, first = 1, nr = 0, alloc = 0;
> 
> Minor nit pick, I think it is clearer if first is initialized just
> before the loop as it is in the deleted code below.
> 
>> +    struct todo_item *items = NULL,
>> +        base_item = {TODO_EXEC, NULL, 0, 0, commands_len, 0};
>> +
>> +    strbuf_addstr(buf, commands);
>> +    base_item.offset_in_buf = buf->len - commands_len - 1;
>> +    base_item.arg = buf->buf + base_item.offset_in_buf;
> 
> I think if the user gives --exec more than once on the command line then
> commands will contain more than one exec command so this needs to parse
> commands and create one todo_item for each command.
> 

Ouch, you’re right.  Thanks for the heads up.

>> +
>> +    /*
>> +     * Insert <commands> after every pick. Here, fixup/squash chains
>> +     * are considered part of the pick, so we insert the commands
>> *after*
>> +     * those chains if there are any.
>> +     */
>> +    for (i = 0; i < todo_list->nr; i++) {
>> +        enum todo_command command = todo_list->items[i].command;
>> +        if (todo_list->items[i].arg)
>> +            todo_list->items[i].arg = todo_list->items[i].arg -
>> old_buf + buf->buf;
>> +
>> +        if (command == TODO_PICK && !first) {
>> +            ALLOC_GROW(items, nr + 1, alloc);
>> +            memcpy(items + nr++, &base_item, sizeof(struct todo_item));
> 
> I think it would be clearer to say
>     items[nr++] = base_item;
> rather than using memcpy. This applies below and to some of the other
> patches as well. Also this needs to loop over all the base_items if the
> user gave --exec more than once on the command line.
> 

I agree with you, it’s way more readable, IMO.  But for some reason, I
thought it was not possible to assign a struct to another in C.

> Best Wishes
> 
> Phillip
> 

Cheers,
Alban

