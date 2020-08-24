Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E184C433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 14:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 121582065F
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 14:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ry/xr4xx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgHXOEB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 10:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHXOD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 10:03:56 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C037FC061573
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 07:03:55 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id d139so2397995qke.11
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 07:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pzI11uomCgNK6tPICX0LDcszrWSZ4KUC0kDTFjMpLX0=;
        b=Ry/xr4xxa82Ca+AzketYswoZNN654O+udG5rTLqxep5savnFS84XMItqgOBfxq7BK0
         I8kSV2aBT0py6VWBMGhUdIhLQ8r5dZsfmrH/WE2b9/fWPT/nB0W4VJdy7ZWXIBVJ/Zgs
         xrgpV4gXudDnPygRxUXy3fRLciyxGTt0kXlgFk556SI4w7gFY/sZCtbGHpQkT8HiQldH
         /5ozYj1ji++vVkDMg6ecm/H7qyU9cjzzM8bN4ybe05AAWtD0pnr+9sUVWWGZ0xv761M5
         AePPNPnR5UHPvqhm5hyOduTaExYEkgVnynj5G1BT+kVXG2d5P5rEfO8W4bRhBD74XFVp
         jvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pzI11uomCgNK6tPICX0LDcszrWSZ4KUC0kDTFjMpLX0=;
        b=Xb6AOiAUhFbg9dKSNVztwtxY2uLrdlakC1KnRFShOBmJI+j0v6LK5qOlFkB2XmBBKH
         FQPKxVL85ezXCX7YiI1gOirC01YZC4zwnppEgRKnxYBKpXrCreXHQHd+PaFsC5TPFSOC
         equMZlJLanJP0XtR36QPhjKzos6XONOHmNhp/s95j3/OTyO4VHGQEbAaochjRivnAXXs
         22soiSUA7GvKjitQcVfDJYISXUDNeN6S7d6ySq+5jTWBqv1wDfJz6g+UZKaeR0rBRgT4
         xo5lmsXqsP5X00UEUWQ2JRnogT9M9G6/XrAEPd+hfrqAD8Rvom1mPZJStUxehMYHsBOX
         eN+w==
X-Gm-Message-State: AOAM5314yBfLT7g4yT1iENHCKrr1Cf97pQo3PQB0BNQdmjL/IIFEK6mL
        ygKICheIG95T29umF/WSTo8=
X-Google-Smtp-Source: ABdhPJztmRdtlfn3VMXRQqUwB54FfbW4KLdUg2NhL5I5fWgIjUtaM+x1G1VX9nFgTz13bM+jpw50sw==
X-Received: by 2002:a37:8107:: with SMTP id c7mr4739069qkd.22.1598277832977;
        Mon, 24 Aug 2020 07:03:52 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:bd91:ce7a:f45a:6364? ([2600:1700:e72:80a0:bd91:ce7a:f45a:6364])
        by smtp.gmail.com with ESMTPSA id v136sm8606053qkb.31.2020.08.24.07.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 07:03:52 -0700 (PDT)
Subject: Re: [PATCH 3/7] maintenance: add --scheduled option and config
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.680.git.1597857408.gitgitgadget@gmail.com>
 <4473c93b118a0e0cdb205d1758aaaa2d8bf5139a.1597857412.git.gitgitgadget@gmail.com>
 <20200820145127.GC31084@danh.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <83b90c15-6d19-3d6e-cefe-4d271aaaac3a@gmail.com>
Date:   Mon, 24 Aug 2020 10:03:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200820145127.GC31084@danh.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/20/2020 10:51 AM, Đoàn Trần Công Danh wrote:
> On 2020-08-19 17:16:44+0000, Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com> wrote:
>> +static void fill_schedule_info(struct maintenance_task *task,
>> +			       const char *config_name,
>> +			       timestamp_t schedule_delay)
>> +{
>> +	timestamp_t now = approxidate("now");
> 
> I see this pattern in both previous patch and this patch,
> should we create a helper (if not exist) to get current timestamp
> instead, parsing "now" every now and then is not a good idea, in my
> very opinionated opinion.

Parsing "now" is not that much work, and it is done only once per
maintenance task. To make a helper that avoids these string comparisons
(specifically to avoid iterating through the "special" array in date.c)
is unlikely to be worth the effort and code duplication.

If you mean it would be good to use a macro here, then that would be
easy:

	#define approxidate_now() approxidate("now")

One important thing for using this over time(NULL) is that we really
want this to work with GIT_TEST_DATE_NOW.

>> +	char *value = NULL;
>> +	struct strbuf last_run = STRBUF_INIT;
>> +	int64_t previous_run;
>> +
>> +	strbuf_addf(&last_run, "maintenance.%s.lastrun", task->name);
>> +
>> +	if (git_config_get_string(last_run.buf, &value))
>> +		task->scheduled = 1;
>> +	else {
>> +		previous_run = git_config_int64(last_run.buf, value);
>> +		if (now >= previous_run + schedule_delay)
>> +			task->scheduled = 1;
>> +	}
>> +
>> +	free(value);
>> +	strbuf_release(&last_run);
>> +}
>> +
>>  static void initialize_task_config(void)
>>  {
>>  	int i;
>> @@ -1359,6 +1387,7 @@ static void initialize_task_config(void)
>>  
>>  	for (i = 0; i < TASK__COUNT; i++) {
>>  		int config_value;
>> +		char *config_str;
>>  
>>  		strbuf_setlen(&config_name, 0);
>>  		strbuf_addf(&config_name, "maintenance.%s.enabled",
>> @@ -1366,6 +1395,20 @@ static void initialize_task_config(void)
>>  
>>  		if (!git_config_get_bool(config_name.buf, &config_value))
>>  			tasks[i].enabled = config_value;
>> +
>> +		strbuf_setlen(&config_name, 0);
> 
> It looks like we have a simple and better named alias for this:
> 
> 	strbuf_reset(&config_name)
> 
> _reset has 400+ occurences in this code base, compare to 20 of _setlen

Makes sense. Thanks.

-Stolee

