Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AAFC7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 18:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238687AbjEKSJL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 14:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238840AbjEKSJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 14:09:09 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684B2AD
        for <git@vger.kernel.org>; Thu, 11 May 2023 11:08:40 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-24ddf274039so6199201a91.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 11:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683828515; x=1686420515;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tf8yzCwrqvBJBAzv+wfk2qnungUIWXWQO6p54yRgTxc=;
        b=CzzbKB+2zRMPJyYhWz+bcDwRactNXpc7jg8j+4ijqNgFmbnIIjGvcLaYNSoqlJI6Em
         hkRGXoJ0arFeYSCcok730EvlVUeFYcDVQokXxIiY6dHfB2gBj/3Z/RZDfY+13cEMm4of
         kQgJf8GojE0BbEdvCdGQ8WoYoH58eVyZ2e3bzuTqiBa7WLhF13OfgXq86lOuJU5BsUox
         nrs3IRswb5LXyKYJ+W36kMnyLvTnhYTVF0zb+B9sf+g2Co8o3O2JwSLqCBS+PaPxQddO
         Cv2zF7uLj3lHo+zAZLl5BXmqTM0VmwqGLx+t8eoKke4GlUzagKt6b2zWYxiyE76M9jdn
         7/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683828515; x=1686420515;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tf8yzCwrqvBJBAzv+wfk2qnungUIWXWQO6p54yRgTxc=;
        b=NbAAGHGVqkh414C7a/4TZUI37fR33t9TXhENXzov5gTVai5HqCuPWpQBHrc6+0w/Bt
         ob7mbfm2jLzxjFQJPK/1wm09uIsN8cjgypRyITldY1QWfj28BGey/iizlcsMCHZCd4ki
         RMiC/2ZXCx9Mfsw5hVEKt4kMCf0dA8UT+xAZbjNPBxODkRsvZ6XtFwjl86/KCf3m07tu
         8C2wehrGUfEG3dfsH8Ot8swlSI353phc+Xbd/jzDqRAoJGaBX5Yhs3ZxEco0/BJwX08Z
         Jfsq9utTdoJWFYnarQSL702Qse2XPxZFHSDKrJLWYJD8UGqR+3s4ERWPqYCX0ylWqxnj
         rcTw==
X-Gm-Message-State: AC+VfDxyWKdRIa/Uy/KayrRr29SPW1yiNUjnF+JgfY96xUeda6NNsjsw
        XbWUUxkX6d3fVKvFzu6Rirw=
X-Google-Smtp-Source: ACHHUZ5cpCYNBPRZ8d/zG6//lTWpNXGXDrT8tq+JU8PeO37B0C1KXxT75e++q4wPo9uFxnch+3s9AQ==
X-Received: by 2002:a17:90a:b297:b0:24d:ff56:f8c1 with SMTP id c23-20020a17090ab29700b0024dff56f8c1mr22560097pjr.13.1683828514572;
        Thu, 11 May 2023 11:08:34 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id v5-20020a17090a7c0500b0024e4f169931sm15445563pjf.2.2023.05.11.11.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:08:34 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] rebase -r: fix the total number shown in the progress
References: <pull.1531.git.1683759338.gitgitgadget@gmail.com>
        <d12d5469f8cbc21ce1efbffc8e7569c534b5a305.1683759339.git.gitgitgadget@gmail.com>
        <b481d212-89c5-5c8e-c99f-6df3909523c7@gmail.com>
Date:   Thu, 11 May 2023 11:08:34 -0700
In-Reply-To: <b481d212-89c5-5c8e-c99f-6df3909523c7@gmail.com> (Phillip Wood's
        message of "Thu, 11 May 2023 15:13:44 +0100")
Message-ID: <xmqqsfc2wxjx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> @@ -2609,7 +2609,7 @@ int todo_list_parse_insn_buffer(struct repository *r, char *buf,
>>   	char *p = buf, *next_p;
>>   	int i, res = 0, fixup_okay = file_exists(rebase_path_done());
>>   -	todo_list->current = todo_list->nr = 0;
>> +	todo_list->current = todo_list->nr = todo_list->total_nr = 0;
>>     	for (i = 1; *p; i++, p = next_p) {
>>   		char *eol = strchrnul(p, '\n');
>> @@ -2628,7 +2628,8 @@ int todo_list_parse_insn_buffer(struct repository *r, char *buf,
>>   			item->arg_offset = p - buf;
>>   			item->arg_len = (int)(eol - p);
>>   			item->commit = NULL;
>> -		}
>> +		} else if (item->command == TODO_COMMENT)
>> +			todo_list->total_nr--;
>
> This feels a bit fragile, I think it would be better to count the
> commands properly in the first place rather than adjusting the total
> here. We could do that by not incrementing "todo_list->total_nr" in
> append_new_todo() and then doing
>
> 	if (item->command != TODO_COMMENT)
> 		todo_list->total_nr++;
>
> here. We may want to stop counting invalid commands as well by only
> counting commands whre "item->command < TODO_COMMENT".

OK.

>> @@ -6088,11 +6090,13 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>>   		return -1;
>>   	}
>>   +	new_total_nr += count_commands(&new_todo);
>> +	new_todo.total_nr = new_total_nr;
>> +
>>   	/* Expand the commit IDs */
>>   	todo_list_to_strbuf(r, &new_todo, &buf2, -1, 0);
>>   	strbuf_swap(&new_todo.buf, &buf2);
>>   	strbuf_release(&buf2);
>> -	new_todo.total_nr -= new_todo.nr;
>
> I think if we just change this line to
> 	
> 	new_todo.total_nr = 0;
>
> we don't need any other changes to this function. This is because
> complete_action() is only called at the start of a rebase so we don't
> need to worry about "total_nr" including commands that have already
> been executed. The reason we need to set it to zero here is that we
> re-parse the todo list below which increments "total_nr" by the number
> of commands parsed.
>
> Thanks for working on this.
> Best Wishes
>
> Phillip

Thanks both for working on the fix and reviewing the patch.
