Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E104EE57EC
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 10:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239870AbjIHKDq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 06:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbjIHKDp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 06:03:45 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AE61BFC
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 03:03:06 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31f737b8b69so1263542f8f.3
        for <git@vger.kernel.org>; Fri, 08 Sep 2023 03:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694167380; x=1694772180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2bNDlffXvkVBwnyhbBl5VtuOHR7ukOTBKb1WEQo499E=;
        b=QREcNT1XWvtH0kaUeGVL4Ezn8WkksRyN9+c0PFJbvzO1Iu1gz/3rLez+DsJ8wbJ4zI
         HHKbJbnIpxcdA/wF97f68lUk9tJ9M5x6jpoqpaGEsdUi3TWy9P9pzmKIrMTD09Us7re6
         nM1CpWbycfHZtnnxixqPhwVnTHiGNvbTKZeny1GzmMwBTtYaSLLhM2316h8wfvdSDu6k
         U4Vhms6Tq0BppePFvFFavAbzzPwVeU7fiqA3yK7XJijpXF7M64dhzYJ2X7KUZHCvfiHa
         HBGL3NDpqanQNlnFuYlJPZQjJ5GIpyfnVmAC1iEvJrT3XS3bhZW4T5ZzKg/xp3UtMp1s
         kuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694167380; x=1694772180;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2bNDlffXvkVBwnyhbBl5VtuOHR7ukOTBKb1WEQo499E=;
        b=Qq1YRhinaYIGgLQOamKixVmQSTETL+L+eJiQGAXNlsw+Eumz1kxEDZqxwXo1+UEK4R
         bMgHCHmTOdD4b+JX+gCSEKYJaBzbMu0+Z5EeW5mx3GPwLXzN1muSNu8HPnU+BzOW20ik
         hGk40Y/+96q0+Q0oxslRny4Zhomyl7BqZ3OROd1sAozXFdJkQjexgntHa4krR/IFeAdw
         nxdrI6W8drA7psygTohuFtDKGJ1hueP8/b0yH1G7zUqMBhRelxHUSmbtW/i/XBvqxPDq
         sltMrEI3xVXZyarRmZScEfkZdEBY18l3HkkcyBqh6hpciMDTCSD/82QEHF472iec+xef
         zUZA==
X-Gm-Message-State: AOJu0YzEuwxZiEcXprk7WvNHoqZpM1X8f78KQ6e0B/XF9gLdClv0oi27
        DmZRIXtN2jttAXCZnTj3jpw=
X-Google-Smtp-Source: AGHT+IGbqu588bx2nIcirZDYHqIc2du6b1UXtyjsombDsIe59fXf8uOUx41QPJgVs8XaMCpnLMER7A==
X-Received: by 2002:a5d:6412:0:b0:316:f24b:597a with SMTP id z18-20020a5d6412000000b00316f24b597amr1489145wru.46.1694167379808;
        Fri, 08 Sep 2023 03:02:59 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id n3-20020a5d4203000000b0031c3ee933b5sm1632554wrq.108.2023.09.08.03.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 03:02:59 -0700 (PDT)
Message-ID: <4fecbf96-aa04-41bd-a589-bf7c368d586c@gmail.com>
Date:   Fri, 8 Sep 2023 11:02:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: ignore signals when forking subprocesses
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1581.git.1694080982621.gitgitgadget@gmail.com>
 <912205bc-37c5-edbf-2f85-f26991ad65eb@gmx.de>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <912205bc-37c5-edbf-2f85-f26991ad65eb@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes

On 07/09/2023 13:57, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Thu, 7 Sep 2023, Phillip Wood via GitGitGadget wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> If the user presses Ctrl-C to interrupt a program run by a rebase "exec"
>> command then SIGINT will also be sent to the git process running the
>> rebase resulting in it being killed. Fortunately the consequences of
>> this are not severe as all the state necessary to continue the rebase is
>> saved to disc but it would be better to avoid killing git and instead
>> report that the command failed. A similar situation occurs when the
>> sequencer runs "git commit" or "git merge". If the user generates SIGINT
>> while editing the commit message then the git processes creating the
>> commit will ignore it but the git process running the rebase will be
>> killed.
>>
>> Fix this by ignoring SIGINT and SIGQUIT when forking "exec" commands,
>> "git commit" and "git merge". This matches what git already does when
>> running the user's editor and matches the behavior of the standard
>> library's system() function.
> 
> ACK

Thanks

>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>      rebase -i: ignore signals when forking subprocesses
>>
>>      Having written this I started thinking about what happens when we fork
>>      hooks, merge strategies and merge drivers. I now wonder if it would be
>>      better to change run_command() instead - are there any cases where we
>>      actually want git to be killed when the user interrupts a child process?
> 
> I am not sure that we can rely on arbitrary hooks to do the right thing
> upon Ctrl+C, which is to wrap up and leave. So I _guess_ that we will have
> to leave it an opt-in.

Peff pointed out it doesn't play well with "gc --auto" either. Do you 
have any thoughts (particularly about the implications for Windows) on 
his suggestion to put the child in it's own session, or putting the 
child in its own process group and making that the foreground process 
group of the controlling terminal?

> However, we could easily make it an option that `run_command()` handles,
> much like `no_stdin`.

That's an interesting idea.

Best Wishes

Phillip

