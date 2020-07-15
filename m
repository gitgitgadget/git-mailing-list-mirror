Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2556EC433DF
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 18:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 020612065F
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 18:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biYsfjjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgGOSnq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 14:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgGOSnp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 14:43:45 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C7FC061755
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 11:43:45 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id r22so2781950qke.13
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 11:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rZzUWVavBqR+JnnQtvz+MCt7pHjJX/zHoGIYLFtmFZg=;
        b=biYsfjjyjihonDbxzoly/VFMjA4DTYSyith4w12smAILUK4nSHwjf1P1sK8yeS5ERs
         wuYk7e7TRwOrmrEiRckCbdUxhXbusMMlEBa+KZod4ConPGlsfIXw8OGykRcYj6oVb2A1
         UoDrsQEi884wgERUzQp561j22bCdoNDogXirrbYb8iqt+FJhlzoXeF7awZTZzIURJ74f
         +J9v8+VlFji1ha8nMJ2980J0psBtLGWPyvJBSpIgOJkXErcnWEXkRfWPHVOYUT4ypltN
         RkxJk6qDU4VWwWJ5RmJNojk3JMhufQdvjpJf6uIGAPx8rfNADZaxvlKIe5yuxnYnKtDV
         K++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rZzUWVavBqR+JnnQtvz+MCt7pHjJX/zHoGIYLFtmFZg=;
        b=s4SlVAA/lEuMzgpJmx4ITIy1TmtQRdpO8eWK78u8Ty42//SyC/yTk0lkNbaL6WrOu0
         2U6xfJoTS8GyPSaZRbTybuoKbvAtNPA4ARRuuSVjlkEwYehFrjw0W8RMFMIH8UFO8BzK
         cOvXkM0+nenRyxc9JPlRy2Mj4Ga+wtgnWjPUs4Q9C5AIhJr6gwBkeRCYJcMN6CrTsK8h
         eAweKsIiE8XeawyU+6f6ojFIYw7cp0MJY1VmduEQn9n1cuwrZvFGAdUp8jOt7QjjycjK
         meLw535GL6zs4oOuFt3LleRAS0s68/cOP4NAAmJhxFudDWjTJ738evHXKbD3twC+WmbA
         Rl+w==
X-Gm-Message-State: AOAM5320myCQAPGzB7OfSQeBr5F5j8oxxYjrhs01ZhV+jT8z04IxCdy8
        Dw40rDIXv7Bx717wmVMLNMKmhftiXzI=
X-Google-Smtp-Source: ABdhPJz2+zJG4th+CmBEyL1AR5OlYgWDXhL3jQ6hQ3Rm6qAwQQemE74Nk5cOexoJEvfVrfRp+g/ecA==
X-Received: by 2002:a05:620a:7d6:: with SMTP id 22mr433180qkb.311.1594838624423;
        Wed, 15 Jul 2020 11:43:44 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id z18sm4120995qta.51.2020.07.15.11.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 11:43:43 -0700 (PDT)
Subject: Re: [PATCH] commit-graph: fix "Collecting commits from input"
 progress line
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, dstolee@microsoft.com,
        peff@peff.net, git@vger.kernel.org
References: <56403dd377b996d21a4da1e01ffd6e691ac120bd.1589407014.git.me@ttaylorr.com>
 <20200710190238.16376-1-szeder.dev@gmail.com>
 <20200715183347.GH11341@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d343c802-bb5a-5bad-5914-5cbcd50b80e5@gmail.com>
Date:   Wed, 15 Jul 2020 14:43:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200715183347.GH11341@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/15/2020 2:33 PM, SZEDER Gábor wrote:
> Junio,
> 
> it looks like this patch hasn't been picked up, but it fixes a minor
> bug introduced in this release cycle.

Thanks for the ping. I forgot to chime in with my :+1: on
this patch. Outside of the small typo in the commit message,
this is ready to ship.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

> On Fri, Jul 10, 2020 at 09:02:38PM +0200, SZEDER Gábor wrote:
>> To display a progress line while reading commits from standard input
>> and looking them up, 5b6653e523 (builtin/commit-graph.c: dereference
>> tags in builtin, 2020-05-13) should have added a pair of
>> start_delayed_progress() and stop_progress() calls around the loop
>> reading stdin.  Alas, the stop_progress() call ended up at the wrong
>> place, after write_commit_graph(), which does all the commit-graph
>> computation and writing, and has several progress lines of its own.
>> Consequintly, that new

s/Consequintly/Consequently/

>>
>>   Collecting commits from input: 1234
>>
>> progress line is overwritten by the first progress line shown by
>> write_commit_graph(), and its final "done" line is shown last, after
>> everything is finished:
>>
>>   $ { sleep 3 ; git rev-list -3 HEAD ; sleep 1 ; } | ~/src/git/git commit-graph write --stdin-commits
>>   Expanding reachable commits in commit graph: 873402, done.
>>   Writing out commit graph in 4 passes: 100% (3493608/3493608), done.
>>   Collecting commits from input: 3, done.
>>
>> Furthermore, that stop_progress() call was added after the 'cleanup'
>> label, where that loop reading stdin jumps in case of an error.  In
>> case of invalid input this then results in the "done" line shown after
>> the error message:
>>
>>   $ { sleep 3 ; git rev-list -3 HEAD ; echo junk ; } | ~/src/git/git commit-graph write --stdin-commits
>>   error: unexpected non-hex object ID: junk
>>   Collecting commits from input: 3, done.
>>
>> Move that stop_progress() call to the right place.
>>
>> While at it, drop the unnecessary 'if (progress)' condition protecting
>> the stop_progress() call, because that function is prepared to handle
>> a NULL progress struct.
>>
>> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
>> ---
>>  builtin/commit-graph.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
>> index 75455da138..796954da60 100644
>> --- a/builtin/commit-graph.c
>> +++ b/builtin/commit-graph.c
>> @@ -251,7 +251,7 @@ static int graph_write(int argc, const char **argv)
>>  			}
>>  		}
>>  
>> -
>> +		stop_progress(&progress);
>>  	}
>>  
>>  	if (write_commit_graph(odb,
>> @@ -264,8 +264,6 @@ static int graph_write(int argc, const char **argv)
>>  cleanup:
>>  	string_list_clear(&pack_indexes, 0);
>>  	strbuf_release(&buf);
>> -	if (progress)
>> -		stop_progress(&progress);
>>  	return result;
>>  }
>>  
>> -- 
>> 2.27.0.547.g4ba2d26563
>>

