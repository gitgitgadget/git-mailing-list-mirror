Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABB3C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 07:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B680261055
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 07:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbhHIH3e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 03:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbhHIH3c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 03:29:32 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAE2C0613CF
        for <git@vger.kernel.org>; Mon,  9 Aug 2021 00:29:10 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so24201243pjn.4
        for <git@vger.kernel.org>; Mon, 09 Aug 2021 00:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=n3BV5YXzYZ2Whs+O0mGAtNTLkugeqtQSeGJCd9iLN4E=;
        b=EKrZ6/IhNVysqIvEb8M/pmwSTn6e7MUicO+N7sJelbXRVhHWiAWyQLrpYSTTmao+Wg
         7KmZS7h/t5nxUyt0hp7zZKJcSDaLjZrmeLI3lU6zZmOOicJtC2mFgCcX5gJlqfDjn8TJ
         B1fZkHNL13U5CfgiTweeFiwG42McPSoXcLyS49uNf3PBphMtuICOzCEtMRdVNHuydjYW
         XkJLXjmi1L096KsAJBp95hU6bUCwMoAPyCQQsETXjNpyJjqyHagVxpN7WG3rb7ELzjYu
         9/JEMum3vmWxSDJvSPfvUzs9PxORG3yhiL2yJvsfwJd0PV7AMoq/35XKo435bM+zyOLi
         GReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=n3BV5YXzYZ2Whs+O0mGAtNTLkugeqtQSeGJCd9iLN4E=;
        b=bYVa8c/hA8baOVFwV+9K64va0QfFbbjCFwEKbfn3dZaTLvpKY7NFjKVCBPYtRTvUE4
         TDNtAf1AUHPMh5jYn1y/+RoyyzWiZelmp+2PnhPMyznYTfBiZc1blo9PTHoeosJuMiPa
         PWuU9tph+GvMkyfJJuruojop5ICQAvVXXOBFksvrrD9+vbpqwl9k8NVsUsaqUOk/p4Fx
         vR9Joq1Yuc2rh0uwqMogWTXo6ZSXGPWV3xJ3CPWuX4m4c/3fToq3nghe/UUK7K2XUTXU
         UcJFwmnYNs53KYgsqkiTt5SPSMvMFxhfvtcBcB3bXwZATQRbWknECE/yVrCDFL0TIrS0
         gLnA==
X-Gm-Message-State: AOAM531SQm4Jd8iMkB2tD5qkccX3hy3jIPK4ELYJ5X9pX9DNrSzS770d
        lCqONhv5cQHfyul7c6RqxGs=
X-Google-Smtp-Source: ABdhPJxUpRGLQ3Yv7KYLWJTR7oe9a50zmEIqBKcQs+RT1c2cUs+YXG4iNI6HfKc3ESAl2k7Qdb3mfw==
X-Received: by 2002:a65:42cd:: with SMTP id l13mr51641pgp.262.1628494150441;
        Mon, 09 Aug 2021 00:29:10 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id l13sm17302149pjh.15.2021.08.09.00.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 00:29:10 -0700 (PDT)
References: <20210806120147.73349-1-raykar.ath@gmail.com>
 <20210807071613.99610-1-raykar.ath@gmail.com>
 <20210807071613.99610-2-raykar.ath@gmail.com>
 <0752736f-11d5-103b-653f-a4bbe6436304@gmail.com>
 <187083ab-a2e3-0933-5bff-9b409b2946ea@gmail.com>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, avarab@gmail.com,
        christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        pc44800@gmail.com, periperidip@gmail.com,
        rafaeloliveira.cs@gmail.com, sunshine@sunshineco.com
Subject: Re: [GSoC] [PATCH v4 1/8] submodule--helper: add options for
 compute_submodule_clone_url()
In-reply-to: <187083ab-a2e3-0933-5bff-9b409b2946ea@gmail.com>
Message-ID: <m27dgvaxfj.fsf@gmail.com>
Date:   Mon, 09 Aug 2021 12:59:04 +0530
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> On 08/08/21 11:11 pm, Kaartic Sivaraam wrote:
>> On 07/08/21 12:46 pm, Atharva Raykar wrote:
>>> [...]
>> It took me a while to figure what "it" meant in the above sentence. Does it
>> refer to `compute_submodule_clone_url` or `resolve_relative_url`. After one
>> sees the patch and takes a look at `resolve_relative_url`, it's clear the "it"
>> indeed does refer to `resolve_relative_url`. But it might worth clarifying this
>> in the commit message itself.
>> Certainly not worth a re-roll on its own. May be Junio could amend this while
>> queing ?
>>
> Actually, I just noticed two other things which might be re-roll worthy. Read on ...

I'll keep re-rolling till the code is good, it's never a problem ;-)

>> -static char *compute_submodule_clone_url(const char *rel_url)
>> +static char *compute_submodule_clone_url(const char *rel_url, const char *up_path, int quiet)
>>  {
>>  	char *remoteurl, *relurl;
>
> I know this isn't new code. But there's already an argument names
> 'rel_url'. So, a variable named 'relurl' in the same scope is making it
> hard to distinguish between these two. Could you also try distinguishing
> these better by renaming 'relurl' to 'res' or something else?

Okay.

>>  	char *remote = get_default_remote();
>> @@ -598,10 +598,14 @@ static char *compute_submodule_clone_url(const char *rel_url)
>>   	strbuf_addf(&remotesb, "remote.%s.url", remote);
>>  	if (git_config_get_string(remotesb.buf, &remoteurl)) {
>> -		warning(_("could not look up configuration '%s'. Assuming this repository is its own authoritative upstream."), remotesb.buf);
>> +		if (!quiet)
>> +			warning(_("could not look up configuration '%s'. "
>> +				  "Assuming this repository is its own "
>> +				  "authoritative upstream."),
>> +				remotesb.buf);
>>  		remoteurl = xgetcwd();
>>  	}
>> -	relurl = relative_url(remoteurl, rel_url, NULL);
>> +	relurl = relative_url(remoteurl, rel_url, up_path);
>
> After reading 2/8 of the series, I just noticed that 'remoteurl' is always
> initialized in 'resolve_realtive_url'. It is either initialized to the return
> value of 'xgetcwd' or retains its assigned value of 'NULL'. But it looks
> like that's not the case here. 'remoteurl' could be used uninitialized
> when the above if block does not get executed which in turn could result in
> weird behaviour in case 'remoteurl' gets a value of anything other than 'NULL'
> at runtime.
>
> This again has nothing to do with the change done in this patch. Regardless, it
> looks like something worth correcting. Thus, I thought of pointing it out.
>

Right. I agree it should be corrected.

>>   	free(remote);
>>  	free(remoteurl);
>> @@ -660,7 +664,7 @@ static void init_submodule(const char *path, const char *prefix,
>>  		if (starts_with_dot_dot_slash(url) ||
>>  		    starts_with_dot_slash(url)) {
>>  			char *oldurl = url;
>> -			url = compute_submodule_clone_url(oldurl);
>> +			url = compute_submodule_clone_url(oldurl, NULL, 0);
>>  			free(oldurl);
>>  		}
>>
