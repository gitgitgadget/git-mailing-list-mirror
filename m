Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33E561FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 02:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751096AbdFTCfQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 22:35:16 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33387 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbdFTCfE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 22:35:04 -0400
Received: by mail-io0-f194.google.com with SMTP id j200so13289474ioe.0
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 19:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kfuM9QITG+IRXRGb1AJ387aQt7BaIDiaAbJFsf87pDc=;
        b=BLedIkdigat/XtFkXY17F9zePOLAJ79yl5w+q9dJKuXN4KFi/swnvk0riXXMSz4eVb
         iIDkkdc0Vk/nJvwebbfksqn2cNy2S7Utwa4xXyCI8r/IkPoS+gwrW0g+fGzg++mjOc1Z
         Yrb54Bmsey4AUzuPqiKkBlWDAbExRnh3MguS2gQ+fQMcfIv6JzzMX/iU0w4YFC81HJ2F
         gghiYLW2U0JbLM6VBJa+uJzdQASKUu/7+pGF8NUgXss3wS0qDn2XsV1dWPeDq7QWvckn
         wDCnCwFw7T+L2M39mr29vwNURoXOr/frnUntz9JdUIPAYS5XaHH320wQV3my5U/xSTI/
         RoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kfuM9QITG+IRXRGb1AJ387aQt7BaIDiaAbJFsf87pDc=;
        b=Hf9FFvnJCXPwKfNZY80AOrWYHPhwI3wdSxFHuB55lUI7FCFDJPjWAxuVmNExoXUB77
         C/G2jDHs/KHpAgv4MBwWYybWkvizapYxr/DazxV70g4idlCOQulx1JfobeWe0/sPxOOG
         wN0ketWW5eZrBvjRumOWvArBG8uVXgLirmEfRgYQ8XZYpiSHVXuOJqpd9SUeacWRj/P8
         ZFUdQDvS5SZ73LWHrNThukAdvBzVRen3oPZafh8WWicXooy8toXyomaFGPu+77Had1i4
         KCiFjjf8EOmMlADrwMPNfOe39ZAVgsNK3dvFWGrfy8UmNUfoEWBVejXq7dJb0OXmDh1+
         HVwA==
X-Gm-Message-State: AKS2vOyzfLDKTPSMaxLrsV5eHHqwjUsobMnpaRWqkKSnl36cHNc96OOr
        G4udkk0SumTN5Ma94I4wyw==
X-Received: by 10.107.19.135 with SMTP id 7mr23412305iot.81.1497926103637;
        Mon, 19 Jun 2017 19:35:03 -0700 (PDT)
Received: from [192.168.2.102] (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id f193sm7501116itb.8.2017.06.19.19.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jun 2017 19:35:02 -0700 (PDT)
Subject: Re: [PATCH v5 08/10] rebase -i: skip unnecessary picks using the
 rebase--helper
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <cover.1497444257.git.johannes.schindelin@gmx.de>
 <72bbfcae2abcb14f6b1288051a244faadbee29e0.1497444257.git.johannes.schindelin@gmx.de>
 <a12767b9-a947-e0a2-fc82-fc25992fd0d1@gmail.com>
 <alpine.DEB.2.21.1.1706161551030.4200@virtualbox>
 <529f6cc7-ab2b-72bb-bc51-f4cca4e98652@gmail.com>
 <alpine.DEB.2.21.1.1706191127450.57822@virtualbox>
From:   Liam Beguin <liambeguin@gmail.com>
Message-ID: <7e5cd36f-772e-b73e-12cd-d52878bdf52c@gmail.com>
Date:   Mon, 19 Jun 2017 22:35:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1706191127450.57822@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 19/06/17 05:45 AM, Johannes Schindelin wrote:
> Hi Liam,
> 
> On Sat, 17 Jun 2017, Liam Beguin wrote:
> 
>> On 16/06/17 09:56 AM, Johannes Schindelin wrote:
>>
>>> On Thu, 15 Jun 2017, Liam Beguin wrote:
>>>
>>>> On 14/06/17 09:08 AM, Johannes Schindelin wrote:
>>>>> diff --git a/sequencer.c b/sequencer.c
>>>>> index a697906d463..a0e020dab09 100644
>>>>> --- a/sequencer.c
>>>>> +++ b/sequencer.c
>>>>> @@ -2640,3 +2640,110 @@ int check_todo_list(void)
>>>>>  
>>>>>  	return res;
>>>>>  }
>>>>> +
>>>>> +/* skip picking commits whose parents are unchanged */
>>>>> +int skip_unnecessary_picks(void)
>>>>> +{
>>>>> +	const char *todo_file = rebase_path_todo();
>>>>> +	struct strbuf buf = STRBUF_INIT;
>>>>> +	struct todo_list todo_list = TODO_LIST_INIT;
>>>>> +	struct object_id onto_oid, *oid = &onto_oid, *parent_oid;
>>>>> +	int fd, i;
>>>>> +
>>>>> +	if (!read_oneliner(&buf, rebase_path_onto(), 0))
>>>>> +		return error(_("could not read 'onto'"));
>>>>> +	if (get_sha1(buf.buf, onto_oid.hash)) {
>>>>
>>>> I missed this last time but we could also replace `get_sha1` with
>>>> `get_oid`
>>>
>>> Good point!
>>>
>>> I replaced this locally and force-pushed, but there is actually little
>>> chance of this patch series being integrated in a form with which I
>>> would be comfortable.
>>
>> Is there any chance of this moving forward? I was hoping to resend my
>> path to abbreviate command names on top of this.
> 
> We are at an impasse right now.
> 
> Junio wants me to change this code:
> 
>         revs.pretty_given = 1;
>         git_config_get_string("rebase.instructionFormat", &format);
>         if (!format || !*format) {
>                 free(format);
>                 format = xstrdup("%s");
>         }
>         get_commit_format(format, &revs);
>         free(format);
>         pp.fmt = revs.commit_format;
>         pp.output_encoding = get_log_output_encoding();
> 
>         if (setup_revisions(argc, argv, &revs, NULL) > 1)
> 	...
> 
> which is reasonably compile-time safe, to something like this:
> 
> 	struct strbuf userformat = STRBUF_INIT;
> 	struct argv_array args = ARGV_ARRAY_INIT;
> 	...
> 	for (i = 0; i < argc; i++)
> 		argv_array_push(&args, argv[i]);
>         git_config_get_string("rebase.instructionFormat", &format);
>         if (!format || !*format)
> 		argv_array_push(&args, "--format=%s");
> 	else {
> 		strbuf_addf(&userformat, "--format=%s", format);
>                 argv_array_push(&args, userformat.buf);
>         }
> 
>         if (setup_revisions(args.argc, args.argv, &revs, NULL) > 1)
> 	...
> 	argv_array_clear(&args);
> 	strbuf_release(&userformat);
> 
> which is not compile-time safe, harder to read, sloppy coding in my book.
> 
> The reason for this suggestion is that one of the revision machinery's
> implementation details is an ugly little semi-secret: the pretty-printing
> machinery uses a global state, and that is why we need the "pretty_given"
> flag in the first place.
> 
> Junio thinks that it would be better to not use the pretty_given flag in
> this patch series. I disagree: It would be better to use the pretty_given
> flag, also as a good motivator to work on removing the global state in the
> pretty-printing machinery.
> 
> Junio wants to strong-arm me into accepting authorship for this sloppy
> coding, and I simply won't do it.
> 
> That's why we are at an impasse right now.
> 
> I am really, really sorry that this affects your patch series, as I had
> not foreseen Junio's insistence on the sloppy coding when I suggested that
> you rebase your work on top of my patch series. I just was really
> unprepared for this contention, and I am still surprised/shocked that this
> is even an issue up for discussion.
> 
> Be that as it may, I see that this is a very bad experience for a
> motivated contributor such as yourself. I am very sorry about that!

It's not such a bad experience, I've found the people on the list to 
be quite welcoming and supportive.

> 
> So it may actually be better for you to go forward with your original
> patch series targeting git-rebase--interactive.sh.

I'll wait a bit longer to see how this goes and if it doesn't move, I'll
try re-sending an update to that series.

> 
> My apologies,
> Dscho
> 

Thanks,
Liam 
