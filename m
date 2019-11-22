Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E29C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4689220707
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ko4FybWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfKVTIj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:08:39 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36927 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfKVTIi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 14:08:38 -0500
Received: by mail-wr1-f68.google.com with SMTP id t1so9917643wrv.4
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 11:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=iRlPWgx7yX1LTJcFXCOA6riGR7WIyKr8I/Ksnkb8Go8=;
        b=ko4FybWtvTq5YJFpCiVLVtVR6HID7whdbALUzUzlWIwJ7b1lCyzkm28K4zqX70VnDz
         QLMArDqUG3IlyHaTPVtN2abuLmXw9uSq9MtjAWYm/ZkMee47XHXghV4L/8a1PLngi0NF
         YNgEHKmXEQgnCztZyT6YHejcRW6DbI/AJT8aiWLY14MnxSZWUUd71fPvZGuIa2YA23ks
         NEBB5oUEodHYh4s0uCVRC/PiQuqZJeNbu8I9GtxT7MjbyzpyL3HK9oWwBs42IPmtmHpk
         5m5WBlTnzhyMPSDgvtpYrwm+E3EZefbCevycJcX8sAchz5dXeoTx8bSjNo8P7IA/5jqP
         ryRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=iRlPWgx7yX1LTJcFXCOA6riGR7WIyKr8I/Ksnkb8Go8=;
        b=SfxJX13V8yI6lopcUldLVnUIxEg9wI8CmR/q/8UPb3+SZLmv4k0mq4qFHbCZU9d4Wc
         oX+As/c5DX6nLvYQZfsqtYAQkrdkYnQ4RLOH8gMMet7p4ugV4ydbBQsjDXh0Os0QuY7C
         51YCKZUzV0T8o1C9KkPHE1V+nzpYngO90ZU/2Upv0yu2TCy55/KsyxVrJaPeYLny91fe
         8AzEeidFvhRGKVg2BWZs8uEef8h8RbREoSMnsfd2VwjZecyncZdcsHT2fHXlz/PB0YsY
         FsVUlXDL8oWVChkCxvT+UYaP6YDV/6UjS93zD81NhGk5Hdvl7B6juDq9Rqtywfv7Y265
         59uA==
X-Gm-Message-State: APjAAAUOHNWOFdjJwiD92l1nROZG6/oHBA94Bz+KE0wRO/WRn9VFZoQA
        4hMWJURgdxswHm2ilUWApBg=
X-Google-Smtp-Source: APXvYqw/cM9xYsBTHYjl2v7DrdutCEXZcOhWaOHdDmNOLiYrbJv+bw/Fh2fXEyL0DrC9zMNz9JSbuQ==
X-Received: by 2002:a5d:4a8c:: with SMTP id o12mr2739940wrq.43.1574449716529;
        Fri, 22 Nov 2019 11:08:36 -0800 (PST)
Received: from [192.168.221.164] ([185.79.217.61])
        by smtp.gmail.com with ESMTPSA id l4sm4326085wme.4.2019.11.22.11.08.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 11:08:35 -0800 (PST)
Subject: Re: [RFC PATCH v2 2/4] rebase: prepare cmd before choosing action
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        phillip.wood@dunelm.org.uk, predatoramigo@gmail.com
References: <20191114163549.7648-1-rybak.a.v@gmail.com>
 <20191120095238.4349-3-rybak.a.v@gmail.com>
 <xmqqimne9efm.fsf@gitster-ct.c.googlers.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <b6d8fe84-cba1-543e-b387-4842b61829f6@gmail.com>
Date:   Fri, 22 Nov 2019 20:08:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqimne9efm.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-11-21 03:00, Junio C Hamano wrote:
> Andrei Rybak <rybak.a.v@gmail.com> writes:
>> When git rebase is started with option --exec, its arguments are parsed
>> into string_list exec and then converted into options.cmd.
>>
>> In following commits, action --edit-todo will be taught to use arguments
>> passed with --exec option.  Prepare options.cmd before switch (action)
>> to make it available for the ACTION_EDIT_TODO branch of the switch.
> Hmph.  With or without this change, when we hit the run_rebase label
> in this function and call into run_rebase_interactive(), opts->cmd
> does contain what came from the --exec option.  In that function, I
> see ACTION_EDIT_TODO calls edit_todo_file() that edits the on-disk
> file without paying attention to opts->cmd (the only thing in the
> function that pays attention to this field is ACTION_ADD_EXEC).
>
> So I am not sure what makes this step necessary.  I guess it is not
> wrong per-se, but if the objetive of this series is to add what
> came from the --exec option when the user interacts with the editor
> in rebase-interactive.c::edit_todo_list(), wouldn't it be sufficient
> to skip this step, pass opts to edit_todo_file() and let the helper
> use opts->cmd while preparing the todo_list it passes to underlying
> edit_todo_list() function?
>
> I am not claiming that it would be a better way---I wouldn't be
> surprised if it is an incorrect approach---but it is unclear why
> this step is needed and why the tweak of the todo list must be done
> in the "switch (action)" we see in the post context of the first
> hunk in this patch.

I would guess that it had something to do with passing this value to the helper
binary rebase--interactive before libification.  I couldn't figure out this
mechanism before commit 460bc3ce73 ("rebase -i: run without forking
rebase--interactive", 2019-04-17), so that's just a guess.

I will look into possible simplification of this to avoid the chain of
conversions string_list -> char * -> string_list.

> Thanks for working on this.

Thank you for review :-)
