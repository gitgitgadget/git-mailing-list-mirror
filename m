Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB4951F453
	for <e@80x24.org>; Tue, 29 Jan 2019 12:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfA2MHx (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 07:07:53 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:54022 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729496AbfA2Ljw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 06:39:52 -0500
Received: from [192.168.2.201] ([92.22.27.120])
        by smtp.talktalk.net with SMTP
        id oRk5g7jgzAGVroRk5gYm1g; Tue, 29 Jan 2019 11:39:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1548761990;
        bh=DYx1ZvZjezXWv7t7ghpE+rMQ/9x1/AyfCWCKHwqdwPM=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WkoYJCPqv2GVb68u6I6NtGxq9Qrb4IbtIfX88NxWrajPFw/BDqe8W/+1ONSe7cIpE
         43eINAHJ4ueKwySh4qzHEJyQOSYx15GKZ66e989kbkWOmLPrQJbddM0427uGqsWOQw
         4rZh/fgh/J8Avp6/w8ELIUfEFf0XTGTD7I1a6owY=
X-Originating-IP: [92.22.27.120]
X-Spam: 0
X-OAuthority: v=2.3 cv=DtN4Bl3+ c=1 sm=1 tr=0 a=Dos57XaWGaBQ6LzLGuzouw==:117
 a=Dos57XaWGaBQ6LzLGuzouw==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=-UZpQIRBeMNV4b-4GTwA:9 a=Yt_TTmrmviDYWeMS:21
 a=643uWmlkyxUKPcX5:21 a=QEXdDO2ut3YA:10 a=SHUmGpGg8TAA:10
 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -x: sanity check command
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20190128102620.18222-1-phillip.wood@talktalk.net>
 <xmqqd0ogbpzn.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1901282253200.41@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <4e4e46b3-9745-a3db-56cb-58763f7cf994@talktalk.net>
Date:   Tue, 29 Jan 2019 11:40:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1901282253200.41@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKLrEe3ooMrkCB1rF20UFFWWRkZ+uOGx7YON9dlGVbDvMGIJyyHpsezrCcLOX/W/m0MXM3/RTwImXx8b1ZSokyYS1zbsJsn1ugTHKJT/JK4sGUD/VTSP
 iyuJDVFrtnbpZtfOfS1fGI2KyOXAKzu8YA4XepKT2IN9aNTH1evIAMn/KWJ5KcJvMCiBS1v7kGss3y1V6YKVSeAVRkz1kdBvGPng17Sts0RvxqL0xbHvCawL
 OYl+GHmJo1qBfrQSJ9Zve8cMaKzz/yRr/er54WBrQL9FqPjAAzhN2Z/S0NzLCBcM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Junio & Dscho

On 28/01/2019 21:56, Johannes Schindelin wrote:
> Hi Junio,
> 
> On Mon, 28 Jan 2019, Junio C Hamano wrote:
> 
>> Phillip Wood <phillip.wood@talktalk.net> writes:
>>
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> If the user gives an empty argument to --exec then the rebase starts to
>>> run before erroring out with
>>>
>>>   error: missing arguments for exec
>>>   error: invalid line 2: exec
>>>   You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
>>>   Or you can abort the rebase with 'git rebase --abort'.
>>
>> Hmph.  I do agree that the above makes an unfortunate end-user
>> experience, but I would sort-of imagine that it would even be nicer
>> for such an empty exec to behave as if it were "exec false" but with
>> less severe error message, i.e. a way for the user to say "I want to
>> break the sequence here and get an interactive session".  We may not
>> even need to add the "break" insn if we go that way and there is one
>> less thing for users to learn.  I dunno, but I tend to prefer giving
>> a useful and safe behaviour to interactive users other than erroring
>> out, when there _is_ such a safe behaviour that is obvious from the
>> situation, and I feel that an empty "exec" is such a case.
> 
> That would make things unnecessarily confusing. An empty command is not
> `false` with a gentler error message. An empty command is a missing
> command.

I agree that having a special meaning to the empty command would be
confusing. Also giving it on the command line only helps if you want to
stop after each pick and my impression is that people want to break
after specific commits to amend a fixup or something like that.

> I am, however, concerned that special-casing an empty command will not
> make things better: if the user called `git rebase --exec=fasle`, they
> will *still* have to clean up their edit script.

The empty commands create an invalid todo list which git cannot parse,
this patch is not a step down the path of checking that the command
exists or is valid shell - I don't think that would be possible in the
general case.

Best Wishes

Phillip

> Or just `git rebase --abort`, which I would do whether I had forgotten to
> specify a command or whether I had a typo in my command.
> 
>>> Also check that the command does not contain any newlines as the
>>> todo-list format is unable to cope with multiline commands. Note that
>>> this changes the behavior, before this change one could do
>>>
>>> git rebase --exec='echo one
>>> exec echo two'
>>
>> It is very good to check the input, regardless of what an empty
>> "exec" should do.
> 
> Should we then also check for incorrect quoting, missing commands, other
> errors? I am not sure that this path leads to sanity.
> 
> Ciao,
> Dscho
> 

