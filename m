Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F6DC4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 20:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A1420739
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 20:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INfJ7k7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgCTUia (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:38:30 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38280 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbgCTUi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 16:38:29 -0400
Received: by mail-oi1-f196.google.com with SMTP id k21so7971069oij.5
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 13:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lptAwG1jvg0mbVOGwHdfmBXf7dqWcE2x2ocYSBC11y4=;
        b=INfJ7k7uaFe6+Fw4BqJvmavegQgnr5MSLmdA1Pt+RZSqEvHg9Fl0RoUxT7PBqv/79n
         u46bK+xAon2Ra+UtPuuRKPxxdESunC5uvJU+3UEaYK5skWp9B4UnkRZr8EUINGtFEpY0
         FRwDGWrHmY7q6ZXtzyz+T4fAzbH1zEIMdHeq+lrHfUPe+nRritEy5iwNPdMT9skivvTw
         tzvKShW3Z/nk8zEDFw/lcpYGtcFSTcgsAOoMtjT5iKaUm3O6ofz+FzvQXw4+X6H+KXcT
         y8hWX/Z3Os+FvtXoZq5fZSkmSnce1H/Hf4/gA5q7oBA0ZsyXADrOkG6MOBas5yiZFntk
         z3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lptAwG1jvg0mbVOGwHdfmBXf7dqWcE2x2ocYSBC11y4=;
        b=VXlRlam7CrjO+7hO/rJhGAd1L5L41G+sjoc3Kwy7H1Dcxn931KhmC+SMpUp2VdRb26
         tjLVGQwNx77InZVN86E9k077pGPs67rTt5UNyCw5qLXOwhHtyfqX2xVqdeDNy3UaND4j
         wjL4hrfnLWaHKedkShb662PWicplqH8LWHnhzeHA/qmq4ygDBgH5QzFaU7a/LLMNhFFn
         O45RK5nI+CLnp1RsJF5LtahBCnlaXAUgZ5b9lH57c0zZJcDArUK2QNADV0QYhEVx6m/F
         ieR0EkC+Dv3A+ctjizOlUykVjT1dk3tcjHswe7dXn3yiB+OzZ1imouUkFiZT/WbgK/a4
         qzRw==
X-Gm-Message-State: ANhLgQ2Zc0MmOYOtl5xS9LM7xh6/bGkRxe5Dx2aDutiz1DigeQnDbzWQ
        D6FfOcDOmTDM0CRMgoZ+QkVMSkneDHE=
X-Google-Smtp-Source: ADFU+vuA/o+D11OdAcEIN7OAMKdJhprCh8y1hCO2RgIkFpb6ShJ1Klha/ITrcxxEmODfhIzAGS+bqQ==
X-Received: by 2002:aca:3c56:: with SMTP id j83mr8377854oia.52.1584736708851;
        Fri, 20 Mar 2020 13:38:28 -0700 (PDT)
Received: from [192.168.1.76] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id q6sm2271787otm.13.2020.03.20.13.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2020 13:38:27 -0700 (PDT)
Subject: Re: [PATCH 1/2] partial-clone: set default filter with --partial
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, jonathantanmy@google.com,
        christian.couder@gmail.com, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.586.git.1584638887.gitgitgadget@gmail.com>
 <6f340d9aadf71d394ad320ad162f1d140b632f2c.1584638887.git.gitgitgadget@gmail.com>
 <xmqqr1xmbwn1.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2a75325b-ea50-a6f6-87dc-12184e706ac2@gmail.com>
Date:   Fri, 20 Mar 2020 16:38:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <xmqqr1xmbwn1.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/20/2020 4:26 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
>> index 256bcfbdfe6..a71716ef75e 100644
>> --- a/list-objects-filter-options.c
>> +++ b/list-objects-filter-options.c
>> @@ -270,6 +270,24 @@ int opt_parse_list_objects_filter(const struct option *opt,
>>  	return 0;
>>  }
>>  
>> +int opt_set_blob_none_filter(const struct option *opt,
>> +			     const char *arg, int unset)
> 
> Isn't the convention to use "opt_parse_" for canned parse-options
> callbacks?

I can do that.

>> +{
>> +	struct strbuf filter_arg = STRBUF_INIT;
>> +	struct list_objects_filter_options *filter_options = opt->value;
>> +	
>> +	if (unset || !arg || !strcmp(arg, "0")) {
>> +		parse_list_objects_filter(filter_options, "blob:none");
>> +		return 0;
> 
> If "--no-partial" were allowed, it should be usable to countermand
> "--partial" earlier on the command line or perhaps configured
> default.  But the above (especially the "unset ||" part) makes
> "--no-partial" a synonym to "--filter=blob:none", no?

I should have been more careful about the use of "unset" (which
would never be true with the current option parsing).

>> +	}
>> +	
>> +	strbuf_addf(&filter_arg, "blob:limit=%s", arg);
>> +	parse_list_objects_filter(filter_options, filter_arg.buf);
>> +	strbuf_release(&filter_arg);
> 
> I would have expected the body of the function to read more like
> this:
> 
> 	if (unset) {
>         	... clear filter_options stored in opt->value ...
> 	} else {
> 		struct strbuf filter_arg = STRBUF_INIT;
> 		if (!arg)
> 			strbuf_addstr(&filter_arg, "blob:none");
> 		else
> 			strbuf_addf(&filter_arg, "blob:limit=%s", arg);
> 		parse_list_objects_filter(filter_options, filter_arg.buf);
> 		strbuf_release(&filter_arg);
> 	}

This is a better organization and I will use it.

> Specifically, I find it unsatisifying to see the "0" optimization at
> this level.  Shouldn't it be done in parse_list_objects_filter() to
> parse "blob:limit=<num>" and after realizing <num> is zero, pretend
> as if it got "blob:none" to optimize?  That way, people can even say
> "--partial=0k" and get it interpreted as "--filter=blob:none", right?

I suppose it would be worth checking the recent server-side improvements
to see if they translate a limit=0k to a "size 0" and then ignore the
size check and simply remove all blobs.

>>  #define OPT_PARSE_LIST_OBJECTS_FILTER(fo) \
>>  	{ OPTION_CALLBACK, 0, CL_ARG__FILTER, fo, N_("args"), \
>>  	  N_("object filtering"), 0, \
>> -	  opt_parse_list_objects_filter }
>> +	  opt_parse_list_objects_filter }, \
>> +	{ OPTION_CALLBACK, 0, CL_ARG__PARTIAL, fo, N_("size"), \
>> +	  N_("partial clone with blob filter"), \
>> +	  PARSE_OPT_OPTARG | PARSE_OPT_NONEG , opt_set_blob_none_filter }
> 
> PARSE_OPT_NONEG means "--no-partial" is forbidden and the callback
> won't see unset==1 at all, right?

You're right. I'm being inconsistent. Your reasons above point to a
good reason to have --no-partial available.

Thanks,
-Stolee
