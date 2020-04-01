Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A47EC43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 20:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A6D20658
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 20:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+xoWGH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732860AbgDAUvP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 16:51:15 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42887 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732345AbgDAUvP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 16:51:15 -0400
Received: by mail-qk1-f195.google.com with SMTP id 139so1591695qkd.9
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 13:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AFAhlTZuqU3LjBESMBnAPwmGXTXfLpQSN1tF3BWzUZA=;
        b=G+xoWGH37xRGPdH1mgp91PlXdInVtvSrFiNvTF908j7Dl7EmdFsZGnjet0Pt4lKNVT
         bBvLyDjBm+1kBs9igH+FUVIK81Hh2vEfROu5bW2Yfz0pbsbZDlI5SusgJ2wZsPA6ztqP
         C8s+2hJEmrYWrSGymd5c1d2+mIu5quHFIScJQsQydopatPDuoECwh5rwS6nmXhAt+YGB
         bZipvtMv60l0tGGtFZq7OyVRNq7Mgze3xI+Gvl8mXMcJgCJnIQ+pOwtmwIyQvoaL8PcD
         zjbV+LG6E/td0oW9QOO1RqSPkZkA10YAnRnzsbzWQdr4LDEbuu8YKLnAldvxcU89LLVa
         LsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AFAhlTZuqU3LjBESMBnAPwmGXTXfLpQSN1tF3BWzUZA=;
        b=p/buvZmLlCv557H/Ddj9VsdMRuuw9icKbq7pyIrrohhMQRVRsrCE/42zwq1cPWE4ez
         IEfJ4wIeMJsaEbzzuI6DypexH48NLpDEZQ+/dLfXEAjoZfHabClZAOPbHfJvp4IkCTMV
         b3yNnYnusXiMbjoOQKe1fJTRGUMsofqbzs11NsLOwAUDcrv3BHwy3ltF3sDZitYKMdf9
         LQN8Y2qBa8LuhVPYQpqUhOGaxS9RtCRRPMnQqYSmWlMkA1Fvq8bX5ORSN4a0JeT+AB43
         ZB3clp5q9iopSpE+aKLtSjErdoGXrKoQLI+xHKOwV0HJOYLM4aFoQuPHf7nUDszx8SzZ
         C7jg==
X-Gm-Message-State: AGi0Pua4MQfh+N1I3HTnNRR1PAAbM8B0BGXB7cUGJuTHCY69ABibEgF4
        vzXs+FtDbkREv8A3sPUQd2o=
X-Google-Smtp-Source: APiQypJgYzyEOQe/tkxNXRTUWBit8kvHlO5PihwsffnGc0y17TBh9wPlfcax2RIT08/eqTBH5fp3rg==
X-Received: by 2002:a37:27cd:: with SMTP id n196mr221365qkn.144.1585774272277;
        Wed, 01 Apr 2020 13:51:12 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 145sm2155676qke.126.2020.04.01.13.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 13:51:11 -0700 (PDT)
Subject: Re: [PATCH] commit-graph: fix buggy --expire-time option
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.596.git.1585764695643.gitgitgadget@gmail.com>
 <xmqqo8sb56m2.fsf@gitster.c.googlers.com>
 <20200401195708.GA3063415@coredump.intra.peff.net>
 <xmqqk12z54k2.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6028eb86-5172-a00e-860b-2d6f6d093f44@gmail.com>
Date:   Wed, 1 Apr 2020 16:51:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <xmqqk12z54k2.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/2020 4:33 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> On Wed, Apr 01, 2020 at 12:49:25PM -0700, Junio C Hamano wrote:
>>
>>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>
>>>> diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
>>>> index 53b2e6b4555..4e4efcaff22 100755
>>>> --- a/t/t5324-split-commit-graph.sh
>>>> +++ b/t/t5324-split-commit-graph.sh
>>>> @@ -210,8 +210,10 @@ test_expect_success 'test merge stragety constants' '
>>>>  		git config core.commitGraph true &&
>>>>  		test_line_count = 2 $graphdir/commit-graph-chain &&
>>>>  		test_commit 15 &&
>>>> -		git commit-graph write --reachable --split --size-multiple=10 --expire-time=1980-01-01 &&
>>>> +		touch -m -t 201801010000.00 $graphdir/extra.graph &&
>>>
>>> We have "test-tool chmtime" since 17e48368 (Add test-chmtime: a
>>> utility to change mtime on files, 2007-02-24) and refrained from
>>> using "touch -t" anywhere in our tests.  Can we use it here, too?
>>
>> There are a couple new ones added last year in t5319. Nobody has
>> complained yet, but I wonder if it's a matter of time.
> 
> Indeed.  We should fix them (#leftoverbits).

I'm adding a patch to fix that now.

-Stolee

