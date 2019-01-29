Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73AA21F453
	for <e@80x24.org>; Tue, 29 Jan 2019 11:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfA2LeN (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 06:34:13 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:58401 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfA2LeN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 06:34:13 -0500
Received: from [192.168.2.201] ([92.22.27.120])
        by smtp.talktalk.net with SMTP
        id oRebg7jA3AGVroRebgYlrW; Tue, 29 Jan 2019 11:34:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1548761650;
        bh=aY/ARyt8LiWf1jkn8oUNf8Q0yl8F2vsE0f/m9Xruk3I=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Fdf1vM2OD+V95tzO7UwOv6Ly0Xn3q62gCilAW55h2bEHukCP+rvncES3MQs2fR9ly
         bBRLdMalq7NOx/N9AyCac5OR6v1yNOQUcYMH53Wwh8gb1WOkuIIqRtb3PM9a2nQOxu
         P1xmFAqL4oDxU8BcnzVCZWENnYULReAJCD4LUKUs=
X-Originating-IP: [92.22.27.120]
X-Spam: 0
X-OAuthority: v=2.3 cv=DtN4Bl3+ c=1 sm=1 tr=0 a=Dos57XaWGaBQ6LzLGuzouw==:117
 a=Dos57XaWGaBQ6LzLGuzouw==:17 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8
 a=MrW86JimT0ll1OXXSQsA:9 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -x: sanity check command
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20190128102620.18222-1-phillip.wood@talktalk.net>
 <nycvar.QRO.7.76.6.1901282257570.41@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <13f14cc6-e437-3f18-7f24-1d6edda1cb23@talktalk.net>
Date:   Tue, 29 Jan 2019 11:34:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1901282257570.41@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDHOuGxDhCx4tDvQgj+wuFtdDpBvmsXCKLviS4JkZwW8CWRfUT7rPmRCB1kilTZWPGsf5EFzBUYWTS9y7/9EU+XiEsKXnyqK+KwNnKnmsV6TlwgCObRH
 grS+svLvtmZXxF9RdvOMx1WHa+k1juCCiSZLjeTw/TAhiOs8aFK/cM/nedpPJcngtKKAseEWjbhK9z6jBhV5/QaJlNjvvFu/fdai514iA2QKYkhJ0K6Kj/rq
 1OE8HqpdsmQ8tcmetSkja/ygzUYpONIn+PiWGjDCV1jt45PStTgLeOKQ9Ao8l2tY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 28/01/2019 22:03, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Mon, 28 Jan 2019, Phillip Wood wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> If the user gives an empty argument to --exec then the rebase starts to
>> run before erroring out with
>>
>>   error: missing arguments for exec
>>   error: invalid line 2: exec
>>   You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
>>   Or you can abort the rebase with 'git rebase --abort'.
> 
> And that's the same if you specify an incorrect command.

Not quite, the issue is that the todo list is invalid, not that the
command fails - it never gets that far. Those errors are coming from
parse_insn_line() and parse_insn_buffer().

> 
> In both cases, I would probably heed the second line of the advice: git
> rebase --abort.
> 
>> Instead check for empty commands before starting the rebase.
>>
>> Also check that the command does not contain any newlines as the
>> todo-list format is unable to cope with multiline commands. Note that
>> this changes the behavior, before this change one could do
>>
>> git rebase --exec='echo one
>> exec echo two'
>>
>> and it would insert two exec lines in the todo list, now it will error
>> out.
> 
> This, however, makes a ton of sense to me.
> 
>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>> index 00de70365e..b6c54b03c1 100644
>> --- a/builtin/rebase.c
>> +++ b/builtin/rebase.c
>> @@ -793,6 +793,24 @@ static void set_reflog_action(struct rebase_options *options)
>>  	strbuf_release(&buf);
>>  }
>>  
>> +static int check_exec_cmd(const char *cmd)
>> +{
>> +	int non_blank = 0;
>> +
>> +	while (*cmd) {
>> +		if (*cmd == '\n')
>> +			return error(_("exec commands cannot contain newlines"));
>> +		if (!isspace(*cmd))
>> +			non_blank = 1;
>> +		cmd++;
>> +	}
>> +
>> +	if (non_blank)
>> +		return 0;
> 
> We are not in a performance critical path here, so I would prefer the
> readability of this code:
> 
> 	if (strchr(cmd, '\n'))
> 		return error(...);
> 
> And if you *really* must,
> 
> 	/* Does the command consist purely of whitespace? */
> 	if (!cmd[strspn(cmd, " \t\r\n")])
> 		return error(...);
> 
> But as I suggested also in a reply to Junio's answer: where would we stop
> to validate the commands?

I'm not trying to validate the command (and I don't think we can/should)
- just generate a todo list that can be parsed.

Best Wishes

Phillip

> 
> Ciao,
> Dscho
> 
>> +
>> +	return error(_("empty exec command"));
>> +}
>> +
>>  int cmd_rebase(int argc, const char **argv, const char *prefix)
>>  {
>>  	struct rebase_options options = {
>> @@ -1130,6 +1148,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>>  		}
>>  	}
>>  
>> +	for (i = 0; i < exec.nr; i++)
>> +		if (check_exec_cmd(exec.items[i].string))
>> +			exit(1);
>> +
>>  	if (!(options.flags & REBASE_NO_QUIET))
>>  		argv_array_push(&options.git_am_opts, "-q");
>>  
>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>> index 7a440e08d8..c98f64eb2d 100755
>> --- a/t/t3404-rebase-interactive.sh
>> +++ b/t/t3404-rebase-interactive.sh
>> @@ -147,6 +147,25 @@ test_expect_success 'rebase -i with the exec command checks tree cleanness' '
>>  	git rebase --continue
>>  '
>>  
>> +test_expect_success 'rebase -x with empty command fails' '
>> +	test_when_finished "git rebase --abort ||:" &&
>> +	test_must_fail git rebase -x "" @ 2>actual &&
>> +	test_write_lines "error: empty exec command" >expected &&
>> +	test_i18ncmp expected actual &&
>> +	test_must_fail git rebase -x " " @ 2>actual &&
>> +	test_i18ncmp expected actual
>> +'
>> +
>> +LF='
>> +'
>> +test_expect_success 'rebase -x with newline in command fails' '
>> +	test_when_finished "git rebase --abort ||:" &&
>> +	test_must_fail git rebase -x "a${LF}b" @ 2>actual &&
>> +	test_write_lines "error: exec commands cannot contain newlines" \
>> +			 >expected &&
>> +	test_i18ncmp expected actual
>> +'
>> +
>>  test_expect_success 'rebase -i with exec of inexistent command' '
>>  	git checkout master &&
>>  	test_when_finished "git rebase --abort" &&
>> -- 
>> 2.20.1
>>
>>

