Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2B4C2D0DB
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 15:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F142070A
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 15:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8vv9cpi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgAYPRK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 10:17:10 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36314 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgAYPRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jan 2020 10:17:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so5607578wru.3
        for <git@vger.kernel.org>; Sat, 25 Jan 2020 07:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+2GjCCAvWXedJ4q6ITaXZphuh8Hup/Q/LAV9mocBbwU=;
        b=P8vv9cpiSgdQ0UGmSRluCtL0l0WDP9fDMCWoV1wjfuv+qdli+BLeOqvAnAkhzCmyKM
         BFn3RFWP5vC1m5Y8tdGT8A6xMqQ6f9iAtUMhuHTB1gF+TZAD8teX4GXzEtCw731Egx5c
         DAxCaiE5raftbx8UO3bWC/XwG1RcDb+x5pSicMzGN3etX0gESOpu0KEeZhLfol3MNZCZ
         IKdUlxVVrzjTiq9NAyKh2TuHedvaAnUfZCWzJd1BqxymqRqSt8XW/u8WlTlg67NLocI4
         I8G0mn4qbupj/08gScfKjj8aCYQKnRiArxoYGg85DT1BMhdOUcYEd0uQ1iGF60W/GC/A
         9+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+2GjCCAvWXedJ4q6ITaXZphuh8Hup/Q/LAV9mocBbwU=;
        b=g+YmEZfmbg15vR4hCpzQYpJvsgXo1gux6A+e7CXf9UjC7K3GE5zoIqSwCGLRUZAvzf
         ETlNILXLgXBLXE8TUa/Kr9ZnS5cDHKNg3UGPbbO+220pnq2oPBT1ymPspIj+vMMq1fGz
         n9ISuopfiOG2k+wh661hyKbDQDWUCoK7JWraNarxBqiAyJTUVg9QbCDXwsatlh0VTGv0
         jj/tuaeuuna4dTdRBm9Mlp6oPsSAh4eCY0eObO3CJLsjYNQuRQ8XzrmjOeOXIFmwFfBw
         0XT89BDj0twP5yj9lK8n2pXRYSVCtUUR+jcGhCArYmZYlv3blXWJe2OgGRydqfbOtSAT
         W/oA==
X-Gm-Message-State: APjAAAVQ/dXRICY7OoSrXGKB6LSgpd6CxOG779IOQI0XysN44e9AEhlw
        VEyrPuHLSC1Lw060c3w6J6I=
X-Google-Smtp-Source: APXvYqy00dqOb3J9e3DBbwkWWx0LFLjzhKlrkX7uMs2nFKR0gi/RdjICHlF3Hg5vr1yQFd4/WIi2vg==
X-Received: by 2002:a05:6000:50:: with SMTP id k16mr10315685wrx.145.1579965427778;
        Sat, 25 Jan 2020 07:17:07 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-551-1-75-233.w92-146.abo.wanadoo.fr. [92.146.226.233])
        by smtp.gmail.com with ESMTPSA id b16sm12251648wrj.23.2020.01.25.07.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2020 07:17:07 -0800 (PST)
Subject: Re: [PATCH v4 2/2] rebase-interactive: warn if commit is dropped with
 `rebase --edit-todo'
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20191202234759.26201-1-alban.gruin@gmail.com>
 <20200111173917.15690-1-alban.gruin@gmail.com>
 <20200111173917.15690-3-alban.gruin@gmail.com>
 <fa4cecb1-4b42-d75b-e1e4-e0fa3bd13c6a@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <19b94763-0072-ba1b-c0a0-300ccf6a94df@gmail.com>
Date:   Sat, 25 Jan 2020 16:17:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <fa4cecb1-4b42-d75b-e1e4-e0fa3bd13c6a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Le 19/01/2020 à 17:28, Phillip Wood a écrit :
> Hi Alban
> 
> On 11/01/2020 17:39, Alban Gruin wrote:

>> @@ -121,10 +125,26 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
>>   	if (initial && new_todo->buf.len == 0)
>>   		return -3;
>>   
>> -	/* For the initial edit, the todo list gets parsed in
>> -	 * complete_action(). */
>> -	if (!initial)
>> -		return todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo);
>> +	if (todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo)) {
>> +		fprintf(stderr, _(edit_todo_list_advice));
>> +		return -4;
>> +	}
>> +
>> +	if (incorrect) {
>> +		if (todo_list_check_against_backup(r, new_todo)) {
>> +			write_file(rebase_path_dropped(), "");
>> +			return -4;
>> +		}
>> +
>> +		if (incorrect > 0)
>> +			unlink(rebase_path_dropped());
>> +	} else if (todo_list_check(todo_list, new_todo)) {
>> +		write_file(rebase_path_dropped(), "");
> 
> We also need to create a backup from todo_list otherwise we'll be using
> a stale backup file for the in the clause above when the user edits the
> todo list to fix it. This test fails
> 
> test_expect_success 'rebase.missingCommitsCheck = error when editing for a second time' '
> 	test_config rebase.missingCommitsCheck error &&
> 	(
> 		set_fake_editor &&
> 		FAKE_LINES="1 break 2 3" git rebase -i A D &&
> 		cp .git/rebase-merge/git-rebase-todo todo &&
> 		test_must_fail env FAKE_LINES=2 git rebase --edit-todo &&
> 		GIT_SEQUENCE_EDITOR="cp todo" git rebase --edit-todo &&
> 		git rebase --continue
> 	)
> '
> The second edit complains that commit B is missing even though we have
> already pick it. This is because we're using a stale backup file.
> 

Good catch.  Fortunately this time, the fix is trivial, and the reroll
will come very soon.

> Sorry to be the bearer of bad tidings
> 

No worries, this series wouldn't get very far without your feedback.

> Phillip
> 
>> +		return -4;
>> +	} else {
>> +		todo_list_write_to_file(r, todo_list, todo_backup, shortrevisions, shortonto,
>> +					-1, flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP);
>> +	}
>>   
>>   	return 0;
>>   }

Thank you,
Alban

