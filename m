Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE739C2BB55
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 12:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8EA9208E4
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 12:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrI0jzWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636207AbgDPMq7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2636035AbgDPMqz (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 08:46:55 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102C1C061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 05:46:55 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id w12so2874909otm.13
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 05:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=08bexDA/xwhEsulA+akkTW0jt9gboGLwdSeGCu239ZA=;
        b=lrI0jzWhrvJQxMwL3ZJsgx/GLw3J9f79I38ozNkjKBT4h04Mt3B8U4rBu3hXCVslS7
         +Zpv7FVSXmBETI/eovMV+zAKUWkCwD2XvmIGuha8CigOqoHPZ2hMrr/ixtRNsWTGpNYk
         pSQoXSLZcNslRSqBKcWLhnIWkkRyt/E/ZT3SP1X2ihLojUtbfI/vaZQbWwO6FA/vi5ol
         np3mfV+54UG+kHoc8TeX/8OngjxJ3CY4xux8M3c3UpCrL74sibTByR9Aqkq0+E4mtm1l
         DfV8q7cVXHFbNnu9p5gN6yAp/tSpdd4yYKJBB+PMVDamKxIv1p9tdBwxJ0eM+NBedd5h
         EjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=08bexDA/xwhEsulA+akkTW0jt9gboGLwdSeGCu239ZA=;
        b=jiHyzTApkghJsZp+C7fcbjquE0mPmFhOSmQt+KDkaQKq0Y0Ocpwm2EWyGX+PMcC2fA
         XFS++D7f7jUeHpOhH3QoDmPfwNEfC9spQfex6CfVxBtdMYTbHANJ1o1H23Kd61gB/7ib
         Rhz4HYJBbTm15Ixk6DagaAZ20XNGkEYRJFVdpQ0ySg+9TYymfcIXqzvuSnqrMuUTzNhC
         NsFgnVb8qoNQn8Jlxqvi7T4ViD8cQeXKalLfIJHSsuPhzGZR77q4oCDW8RWRXo0zAFs+
         L8/q8YOp25voKUlIG69i3PoWQfbcITXpRj5re+0uvNtNKRv8xo6m//kV/rUDIcpH2dtc
         XUIw==
X-Gm-Message-State: AGi0Pubf0KLm8tZVvItT495mjCi7hrbQ/PYBY/1TJruhbfmsI/AFJtMv
        AWu5s6nHNYKn/9TQwo4P4tw=
X-Google-Smtp-Source: APiQypJ/u74RaMzMfA4Mt7f+a7K2Di3hsPxQ/6VEKtnRrx2Y8Cy8RcGNDecITay3mKTYLAOykG7BBA==
X-Received: by 2002:a9d:4b06:: with SMTP id q6mr13159789otf.31.1587041214184;
        Thu, 16 Apr 2020 05:46:54 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id t10sm975903oou.38.2020.04.16.05.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 05:46:53 -0700 (PDT)
Subject: Re: [PATCH v2] log: add log.excludeDecoration config option
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sluongng@gmail.com, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.610.git.1586791720114.gitgitgadget@gmail.com>
 <pull.610.v2.git.1586965463222.gitgitgadget@gmail.com>
 <xmqqftd47jce.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a8380ed7-d3a1-873d-7f65-099fd55a3988@gmail.com>
Date:   Thu, 16 Apr 2020 08:46:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <xmqqftd47jce.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/15/2020 1:24 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Add the 'log.excludeDecoration' config option so users can exclude
>> some refs from decorations by default instead of needing to use
>> --decorate-refs-exclude manually. The config value is multi-valued
>> much like the command-line option. The documentation is careful to
>> point out that the config value can be overridden by the
>> --decorate-refs option, even though --decorate-refs-exclude would
>> always "win" over --decorate-refs.
>>
>> Since the 'log.excludeDecoration' takes lower precedence to
>> --decorate-refs, and --decorate-refs-exclude takes higher
>> precedence, the struct decoration_filter needed another field.
>> This led also to new logic in load_ref_decorations() and
>> ref_filter_match().
> 
> All of the above makes sense to me.
> 
>> diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
>> index e9e1e397f3f..1a158324f79 100644
>> --- a/Documentation/config/log.txt
>> +++ b/Documentation/config/log.txt
>> @@ -18,6 +18,11 @@ log.decorate::
>>  	names are shown. This is the same as the `--decorate` option
>>  	of the `git log`.
>>  
>> +log.excludeDecoration::
>> +	Exclude the specified patterns from the log decorations. This multi-
>> +	valued config option is the same as the `--decorate-refs-exclude`
>> +	option of `git log`.
> 
> Can the config still be "the same as" that option, though, with the
> new "unlike --decorate-refs-exclude that always wins, config is at
> the lowest precedence" rule?

I thought I had updated this to make that clearer, but it looks like
I missed it when staging.

What I had meant to write was this:

log.excludeDecoration::
	Exclude the specified patterns from the log decorations. This is
	similar to the `--decorate-refs-exclude` command-line option, but
	the config option can be overridden by the `--decorate-refs`
	option.

>> diff --git a/log-tree.c b/log-tree.c
>> index 52127427ffe..bd8d4c07bb8 100644
>> --- a/log-tree.c
>> +++ b/log-tree.c
>> @@ -90,7 +90,8 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
>>  
>>  	if (filter && !ref_filter_match(refname,
>>  			      filter->include_ref_pattern,
>> -			      filter->exclude_ref_pattern))
>> +			      filter->exclude_ref_pattern,
>> +			      filter->exclude_ref_config_pattern))
>>  		return 0;
> 
> As there is only one caller of the ref_filter_match() helper, I
> wonder if we want to
> 
>  (1) move the helper to log-tree.c, make it static and remove its
>      definition from refs.h, and optionally rename it so that it is
>      clear that this is not part of the "ref_filter" API that drives
>      "for-each-ref" and friends;
> 
>  (2) instead of adding yet another pattern to the parameter list,
>      make the helper take the whole "filter" instance as a single
>      parameter.
> 
> as a clean-up.

This is a good idea. I was thinking the code was "smelly" when I had
to jump through so many hoops to get it working. I'll add a refactor
patch in front of this one.

>> diff --git a/refs.c b/refs.c
>> index 1ab0bb54d3d..63d8b569333 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -339,9 +339,11 @@ static int match_ref_pattern(const char *refname,
>>  
>>  int ref_filter_match(const char *refname,
>>  		     const struct string_list *include_patterns,
>> -		     const struct string_list *exclude_patterns)
>> +		     const struct string_list *exclude_patterns,
>> +		     const struct string_list *exclude_patterns_config)
>>  {
>>  	struct string_list_item *item;
>> +	int found = 0;
>>  
>>  	if (exclude_patterns && exclude_patterns->nr) {
>>  		for_each_string_list_item(item, exclude_patterns) {
>> @@ -351,7 +353,6 @@ int ref_filter_match(const char *refname,
>>  	}
>>  
>>  	if (include_patterns && include_patterns->nr) {
>> -		int found = 0;
>>  		for_each_string_list_item(item, include_patterns) {
>>  			if (match_ref_pattern(refname, item)) {
>>  				found = 1;
>> @@ -362,6 +363,16 @@ int ref_filter_match(const char *refname,
>>  		if (!found)
>>  			return 0;
>>  	}
>> +
>> +	if (!found &&
>> +	    exclude_patterns_config &&
>> +	    exclude_patterns_config->nr) {
>> +		for_each_string_list_item(item, exclude_patterns_config) {
>> +			if (match_ref_pattern(refname, item))
>> +				return 0;
>> +		}
>> +	}
> 
> Hmph.  Do we still need "found" here? ...

You included an excellent update in another response, which I have
squashed locally.

>>  /*
>> + * Returns 0 if the refname matches any of the exclude_patterns.
>> + *
>> + * Returns 0 if include_patterns is non-empty but refname does not match
>> + * any of those patterns.
>> + *
>> + * Returns 0 if refname matches a pattern in exclude_patterns_config but
>> + * does not match any pattern in inclue_patterns.
>> + *
>> + * Otherwise, returns 1.
>>   *
>>   * This has the effect of matching everything by default, unless the user
>>   * specifies rules otherwise.
>>   */
> 
> The above is not wrong per-se, but feels somewhat roundabout way to
> define what it does, from the viewpoint of somebody who may want to
> call or understand it.  "What matches one of the exclude patterns is
> excluded.  If the include patterns is empty, what did not match
> exclude patterns is included unless it matches one of the exclude
> configs.  But if the include patterns is not empty, what did not
> match exclude patterns is included only if it matches one of the
> include patterns."

Your new logic for the method makes this a bit simpler to write:

/*
 * Returns 0 if the refname matches any of the exclude_patterns.
 *
 * Otherwise, returns 1 if the refname matches any of the include_patterns.
 *
 * Otherwise, returns 0 if include_patterns is non-empty.
 *
 * Otherwise, returns 0 if the refname matches any of the patterns
 * in exclude_patterns_config.
 *
 * Finally, if none of the above apply, return 1.
 */

However, if I pull this method into a static helper method, then
the documentation is unnecessary.

Thanks for the careful review!

-Stolee
