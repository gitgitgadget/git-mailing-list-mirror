Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF8AE207D6
	for <e@80x24.org>; Tue,  2 May 2017 03:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750926AbdEBDHQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 23:07:16 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34880 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbdEBDHP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 23:07:15 -0400
Received: by mail-pg0-f67.google.com with SMTP id c2so8337310pga.2
        for <git@vger.kernel.org>; Mon, 01 May 2017 20:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0U2EowifOfijDMhcZ+19DNsf+R/O4kWBO2pNO2Tqpng=;
        b=cTaE6C2e0s6TvW2FP/XrNXX+7xyHvlZu+bRKLeaBvYkxKPbWs1T2rIPfDY1HksCFqm
         lBt2GXxmC4wSrjbU94fqDMVvcl40UqNgeA9FfEz54WlEHuK5l4kCdkdr7OEyyzzHahWZ
         PfE2rGz+N4v/M3VpZk/iv5KqnxizYTRrQGYFdzbtFK8BXV+uaVpdn2aemnMudnIy/8ZO
         Dhh8gxuazYUKCnlm+5b1/cHyfMgQei+vBJiPu56NJaG/sjVLQy155xJ4NJSqQ3AiQdnG
         8de+K1hd4SLvsYJ01K9ggwfPSRodsUGbk1GDNfyFST0/QyfeZZSoM2bWeFNE48FOkf8I
         +Oyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0U2EowifOfijDMhcZ+19DNsf+R/O4kWBO2pNO2Tqpng=;
        b=PR48/LfOpPCvq/EvunEE5RJdAkUPmdJ5StF6ZuV7QiEzq3GYm6UTT1FJ13rAn3y1uP
         f/SUaDs1XbI5/Kv78mqx4ylaeby6E5eztCrQBREFa3LA4IXcs9qKnemWi6RR3ydPLlOA
         klMITP6p1N6QH4ZtoW0BcdnQyl+z2+xzHGi+y7P5DUIsgBgSUDr9nJ3ofluxjuJ6746J
         NNB3AI1LvKDhLwLD8t9XzfE6RpDt0vI1YvJzz6x5yonnLRGeGFY0jrUFPN/dol7ftuuJ
         X/YmXjOCgXveZh139guEoptmqfFE6mr18BXu5DCmc15emppQqUcOMa7ZtPtfy1d4ulYR
         SJww==
X-Gm-Message-State: AN3rC/4YhSvyAC2AF1qxTJ0mjmJzE2bXtmU7MpTFLCrg8gpJKjQTTnu6
        +MMBrjzj/A/oHg==
X-Received: by 10.99.254.69 with SMTP id x5mr30510726pgj.2.1493694434710;
        Mon, 01 May 2017 20:07:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3c5e:d1c1:579c:ef99])
        by smtp.gmail.com with ESMTPSA id h7sm33053499pfc.99.2017.05.01.20.07.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 20:07:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>, jrnieder@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH 1/5] submodule_move_head: fix leak of struct child_process
References: <20170501180058.8063-1-sbeller@google.com>
        <20170501180058.8063-2-sbeller@google.com>
        <20170501180610.GF39135@google.com>
Date:   Mon, 01 May 2017 20:07:13 -0700
In-Reply-To: <20170501180610.GF39135@google.com> (Brandon Williams's message
        of "Mon, 1 May 2017 11:06:10 -0700")
Message-ID: <xmqqpofsdkim.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 05/01, Stefan Beller wrote:
>> While fixing the leak of `cp`, reuse it instead of having to declare
>> another struct child_process.
>> 
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>
> This shouldn't be needed as 'finish_command' does the cleanup for you by
> calling 'child_prcoess_clear()'.

Yes, indeed.  

It might not hurt to update the code so that the cp is reused in the
second run instead of using a separate instance cp1, but that is a
topic separate from fixing a non-existing leak.

>> ---
>>  submodule.c | 15 +++++++++------
>>  1 file changed, 9 insertions(+), 6 deletions(-)
>> 
>> diff --git a/submodule.c b/submodule.c
>> index d3299e29c0..cd098cf12b 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -1466,17 +1466,19 @@ int submodule_move_head(const char *path,
>>  		goto out;
>>  	}
>>  
>> +	child_process_clear(&cp);
>> +
>>  	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
>>  		if (new) {
>> -			struct child_process cp1 = CHILD_PROCESS_INIT;
>> +			child_process_init(&cp);
>>  			/* also set the HEAD accordingly */
>> -			cp1.git_cmd = 1;
>> -			cp1.no_stdin = 1;
>> -			cp1.dir = path;
>> +			cp.git_cmd = 1;
>> +			cp.no_stdin = 1;
>> +			cp.dir = path;
>>  
>> -			argv_array_pushl(&cp1.args, "update-ref", "HEAD", new, NULL);
>> +			argv_array_pushl(&cp.args, "update-ref", "HEAD", new, NULL);
>>  
>> -			if (run_command(&cp1)) {
>> +			if (run_command(&cp)) {
>>  				ret = -1;
>>  				goto out;
>>  			}
>> @@ -1492,6 +1494,7 @@ int submodule_move_head(const char *path,
>>  		}
>>  	}
>>  out:
>> +	child_process_clear(&cp);
>>  	return ret;
>>  }
>>  
>> -- 
>> 2.13.0.rc1.1.gbc33f0f778
>> 
