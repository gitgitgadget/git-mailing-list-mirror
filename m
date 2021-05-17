Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82F3C433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 17:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C63A60FE9
	for <git@archiver.kernel.org>; Mon, 17 May 2021 17:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242032AbhEQRc4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 13:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbhEQRc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 13:32:56 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD11BC061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 10:31:39 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id s19so7185170oic.7
        for <git@vger.kernel.org>; Mon, 17 May 2021 10:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9RuFg/mQ1cChFDooRTBik72azvAx2R5VxCpFWHnWwXk=;
        b=pyD7iE1LovR3TVom7hQPr0Gr6DCExyfPQWZY4deoWlqJ4mN6hYZEAZjPpGQpvuYKKa
         GVjJhWHX9xmXdkD+Dtd3Vvola+gONVGQkJKNcMFat+Dv/g84Iswjy9Hpztmtf9uTM4Hd
         WrGwGQ7A4+LBr5DJ17m5tzN2gpi6EWvTv7eUdlOyE8PbGL9Ho5997jR1w72lFOpDjZXM
         zng6Qd+xr3juLw//bRxfcBbC3Vx0drELI8oh0plaBYnQDE7UDsHaz82TwUo5tXEaXcam
         tjoSWmHwP8MyDZ5g1pneA90MgKdRZ+egUqCVC/L260ew8EAk4zQ0hpvwGX26e+9LIg/H
         MGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9RuFg/mQ1cChFDooRTBik72azvAx2R5VxCpFWHnWwXk=;
        b=UG5oVi/w7JZBDBMmmFzcfdtGyVEGaPBxWVXtHhXhu6QAIkobZcMBcwcBxnFQDxAXft
         aAEgdOQ+BjvJUF7+HR1iy0yBZMSwt6392G5wRrJOy6QFShgH52GcVtU7U8RitnOm7xT4
         SWuCn0jeF+4W3WL5Bh9rgyU2qSHLMQD8lHwu9IOs9d3Vhc/vtGh5ZJPjAN5dT/WgsdGn
         rwTEe8lpj4ImEuiosVGcXby/Sa6fv62uxdMBRLkdlAo3CNCWwycjsWinhWBjAbn2QOBK
         xVrnRtY+pIzwsxo71P/ijGqkkyZF9T0NOFGBA6JIjGb8TwcDSQ7O+KtttPuXjszZg2Im
         vkwQ==
X-Gm-Message-State: AOAM530HWtpO2aYRGefX0umjvOgruL6zQN9pXIF30pexsY8yMVsxv/Ps
        FXCGoJLCV4OBy3j02R59lak=
X-Google-Smtp-Source: ABdhPJy+L8RhFWCCRw/Oz5pclw1cZmBa/QwVippA9mteNSBJ3XDJY3Uif/MxScP3f6OtpaCMyaFvvQ==
X-Received: by 2002:a54:4694:: with SMTP id k20mr688068oic.134.1621272699143;
        Mon, 17 May 2021 10:31:39 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:68e5:b0b1:d7d3:e820? ([2600:1700:e72:80a0:68e5:b0b1:d7d3:e820])
        by smtp.gmail.com with ESMTPSA id e22sm3247399otl.74.2021.05.17.10.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 10:31:38 -0700 (PDT)
Subject: Re: [PATCH 2/2] sparse-index.c: don't call prepare_repo_settings()
 twice in a row
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <cover-0.2-00000000000-20210505T121028Z-avarab@gmail.com>
 <patch-2.2-8bca02efcee-20210505T121028Z-avarab@gmail.com>
 <7954338a-bb44-1345-61b6-787782063c3c@gmail.com>
 <87v97wuto9.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a7580f20-1b81-36fb-9cb1-b23690fa9599@gmail.com>
Date:   Mon, 17 May 2021 13:31:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87v97wuto9.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/6/2021 4:49 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, May 05 2021, Derrick Stolee wrote:
> 
>> On 5/5/2021 8:11 AM, Ævar Arnfjörð Bjarmason wrote:
>>> Change code added in 58300f47432 (sparse-index: add index.sparse
>>> config option, 2021-03-30) to only call prepare_repo_settings()
>>> once. We know that our own set_sparse_index_config() has just finished
>>> calling it, so we don't need to call it if we're acting on "test_env".
>>
>> I'm not sure about the value here. prepare_repo_settings() returns
>> quickly if the settings have already been prepared, so a second call
>> is negligible in cost.
> 
> I changed that while I was at it to make it easier to read, it's not an
> optimization. I.e. one wonders what the side-effect is of calling
> prepare_repo_settings() twice, discovers there isn't one...

This is typical of the "prepare_" pattern, such as prepare_packed_git()
or prepare_commit_graph(). It's saying "be sure this is initialized"
and that initialization only needs to happen once.
 
>>> @@ -133,11 +133,12 @@ int convert_to_sparse(struct index_state *istate)
>>>  	test_env = git_env_bool("GIT_TEST_SPARSE_INDEX", -1);
>>>  	if (test_env >= 0)
>>>  		set_sparse_index_config(istate->repo, test_env);
>>> +	else
>>> +		prepare_repo_settings(istate->repo);
>>
>> The change presented here to either call set_sparse_index_config()
>> _or_ prepare_repo_settings() seems like it knows too much about
>> how set_sparse_index_config() works.
> 
> It seems reasonable to assume that a function to set config has
> initialized (or died, if it couldn't) enough of our config state to do
> its job.
> 
> Besides, it's a few lines above the changed code in the same file. 
> 
> But looking at this again 2/3 callers of set_sparse_index_config()
> aren't checking the return value. Wouldn't something like [1] on top be
> a good idea here?
> 
> Also, is GIT_TEST_SPARSE_INDEX=true itself supposed to work? Running the
> test suite with it fails 3 test files for me, all /sparse/, i.e. tests
> that (presumably) assume it's not already turned on by this code.

I haven't ensured that this works in all cases. I was going to try and
find a way to make the tests be better about having a meaningful data
shape that applies to the sparse-index, but I should go and verify that
the tests work with this enabled.

> 
> 1. 
> 
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index a4bdd7c4940..bea1e7dd00e 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -280,8 +280,9 @@ static int set_config(enum sparse_checkout_mode mode)
>  				      "core.sparseCheckoutCone",
>  				      mode == MODE_CONE_PATTERNS ? "true" : NULL);
>  
> -	if (mode == MODE_NO_PATTERNS)
> -		set_sparse_index_config(the_repository, 0);
> +	if (mode == MODE_NO_PATTERNS &&
> +	    set_sparse_index_config(the_repository, 0) < 0)
> +		die(_("could not set index.sparse=0"));

This seems reasonable, because we are in a builtin saying "please disable
the sparse-index". Is there not an instance here that _enables_ it?

I would change the string to be "could not disable index.sparse" or
something similar.

>  	return 0;
>  }
> diff --git a/sparse-index.c b/sparse-index.c
> index 5bad05de645..3938bcec962 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -131,10 +131,13 @@ int convert_to_sparse(struct index_state *istate)
>  	 * index.sparse config variable to be on.
>  	 */
>  	test_env = git_env_bool("GIT_TEST_SPARSE_INDEX", -1);
> -	if (test_env >= 0)
> -		set_sparse_index_config(istate->repo, test_env);
> -	else
> +	if (test_env >= 0) {
> +		if (set_sparse_index_config(istate->repo, test_env) < 0)
> +			die(_("could not set index.sparse based on GIT_TEST_SPARSE_INDEX=%d"),
> +			    test_env);
> +	} else {
>  		prepare_repo_settings(istate->repo);
> +	}

This one, I'm not so sure. There might be reasons why the GIT_TEST_*
variable won't work to set the config and we don't want that to be
a reason the test fails. There is no need for a translated string
here, either.

Thanks,
-Stolee
