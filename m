Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32004C43461
	for <git@archiver.kernel.org>; Mon,  3 May 2021 15:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3D20611AC
	for <git@archiver.kernel.org>; Mon,  3 May 2021 15:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhECPlH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 11:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbhECPlG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 11:41:06 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494AEC06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 08:40:13 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id c12-20020a4ae24c0000b02901bad05f40e4so1326479oot.4
        for <git@vger.kernel.org>; Mon, 03 May 2021 08:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=oUj8YzGVBAPxWnHN9ZyRFXVmXemZd2BDRxa3de+NhVA=;
        b=d19R/BbVm94XsOe49/uk57uG8cJop1aMHcH2kt6V6xNGrypFl1GSUueAL60I4f8agb
         oEptNx3MqO02AbheMwMIBH7KMe6KYlEm7RcU6to5gB3T7CNRFVfHdW+gtb+BJioniLMi
         ckf8VJ31wrjlTyrChXSs+ST9UDJeTLOFEBeTsED2bYtBrT//YoxYmvNqyMZkqhxbEZym
         93raTIOx40te2rpUPJSMgCXuHNZINlrd0E9/UWLDmDX2Wb8+589nWC5CC0eW60i6nrI2
         6dF0JU2MoBMQ77NUZbz5vRtMTFuaWWjDfHLLj8Fdmq6xpW4bZQeOXmt7wqz7zAwPoRuc
         Ow+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oUj8YzGVBAPxWnHN9ZyRFXVmXemZd2BDRxa3de+NhVA=;
        b=TFl6cnRgU4xcSHrinl9wxovs0K5a47KFCWYwTmjoQwvVs7g0G3yqtxNusntVZQb9wo
         L26UeQ2oJuNeUbP3L7q7A6UneBQnL0BixGMgee3pCw3Cu/KRIdrijs9FmR1X2cMWs2mM
         C+69wodjlO2wqd7EOR4En8pfr/wXPQb2/EIIOfhM7jNC7wJn6SljiDyKNcRArnghQxkf
         YpZt8yHHbkCng2tEdtiY4nW2JBTvpwh2w23zMmquY2V/jQMBsqxm7yg4fwKnGcw2hder
         NHS/mx8Es3HfZ9nmo7rnKZ6BrCqGH/6/d+DSWKw73HjVyNrbhadVdYUKUtz1RB6gmiwS
         Bm6A==
X-Gm-Message-State: AOAM531XcdNPv7hr+qOpw6bpa94Sb+V3CPbt2hI5A215y3ZKykKVjUJX
        FT31poXSzRLFTQ7AsriokcZH89l0YWFydQ==
X-Google-Smtp-Source: ABdhPJxcsryNqhGhmUTjZ77+IYEwvNHXPX90Bhu1owx+i9pxlkSjT/H6bM6pqw5rJD/lxiP7jEHeTA==
X-Received: by 2002:a4a:eaca:: with SMTP id s10mr16147269ooh.22.1620056412236;
        Mon, 03 May 2021 08:40:12 -0700 (PDT)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:7dc8:8c84:e13f:8092])
        by smtp.gmail.com with ESMTPSA id p2sm16503ool.15.2021.05.03.08.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 08:40:11 -0700 (PDT)
Subject: Re: [PATCH 5/6] fetch: teach independent negotiation (no packfile)
From:   Derrick Stolee <stolee@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <cover.1617929278.git.jonathantanmy@google.com>
 <4696c8e901808853d17af10d5a6d95cd4711c6d5.1617929278.git.jonathantanmy@google.com>
 <cb441f5b-33db-90a7-1492-e86c4ec1ed1a@gmail.com>
Message-ID: <d30876b3-e94a-3a80-db0d-c20ec510e92a@gmail.com>
Date:   Mon, 3 May 2021 11:40:10 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <cb441f5b-33db-90a7-1492-e86c4ec1ed1a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/3/21 11:25 AM, Derrick Stolee wrote:
> On 4/8/21 9:10 PM, Jonathan Tan wrote:
>> Currently, the packfile negotiation step within a Git fetch cannot be
>> done independent of sending the packfile, even though there is at least
>> one application wherein this is useful. Therefore, make it possible for
>> this negotiation step to be done independently. A subsequent commit will
>> use this for one such application - push negotiation.
> ...
>> diff --git a/transport-helper.c b/transport-helper.c
>> index 4cd76366fa..4be035edb8 100644
>> --- a/transport-helper.c
>> +++ b/transport-helper.c
>> @@ -684,6 +684,16 @@ static int fetch(struct transport *transport,
>>  		return transport->vtable->fetch(transport, nr_heads, to_fetch);
>>  	}
>>  
>> +	/*
>> +	 * If we reach here, then the server, the client, and/or the transport
>> +	 * helper does not support protocol v2. --negotiate-only requires
>> +	 * protocol v2.
>> +	 */
>> +	if (data->transport_options.acked_commits) {
>> +		warning(_("--negotiate-only requires protocol v2"));
>> +		return -1;
>> +	}
>> +
> 
> This method continues to do a lot that doesn't seem specific to
> --negotiate-only. The warning message seems incorrect to me, but
> is also seems like this would break several cases when using
> protocol v0. It is equally possible that I'm misunderstanding
> what is going on here.

I didn't see this cause any failures when running the test suite
with GIT_TEST_PROTOCOL_VERSION=0, but I _do_ see failures in your
tests added in PATCH 6 with that environment variable set. You
might want to set it manually in the important test cases.

Thanks,
-Stolee

