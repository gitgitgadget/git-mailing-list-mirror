Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC2CC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 14:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E208060FF2
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 14:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbhHaObL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 10:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbhHaObF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 10:31:05 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A75AC061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 07:30:09 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 22so19803135qkg.2
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 07:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4gtrdYI/D+H0O790yyPhzpZKTtbm0CdFMV7prdyIPO4=;
        b=hgyyxO661i+QOsdghh3e5/gJCcgex5IWNw0RFoKZmiHIsO+qF8AOIhHhG9ZFx7dwBm
         NiRP0YS8HcvHCtum22ptF4tMazkurrKrIL6/PJbayuiptjfKvm9ZsmAwYuwpVRcTmCjo
         rYY7lsO26qOOZy5OmT2mH/AdcDYLk5tdyJolQViq1xxNTx2tH6N9YACdlP8SJyb16TU7
         QmRMhaE1kXHnKP9F0PsHA8ws6xkzSk+awfnDANtm/J8mfYft+yu4hE64kY04b5D6f0/6
         ciS2uBYFeoNbY72AxRSZuYeBCSuNYB5HYDhpzS16ppsOkiqRI+q3VUWFWOzgZrmtX9rd
         tnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4gtrdYI/D+H0O790yyPhzpZKTtbm0CdFMV7prdyIPO4=;
        b=e97J36noQt3QYp5Uxw9OUEuFeBjRWVy8d3OJtzpv/12Rl+pYJvb+VHQrmRNSjI2keT
         dMhD1LXg55B/pT4zZ0IAnYXU/PZWuI/Lu6eu3J1sGQD32JhEZxXX934qGDXiyJwKqlYH
         /M0bO++i2MnSi/3XUTZ/FNZrisaewGxh7QSGbqV10ai8Z8Ne9lJYZS976e2WI4U5cWZx
         hY/6+vxRTsfukG/fJIy1/fjL7mdTt3Cp4nDiB72hZPjAE3IJnDkyqProphLj3DHP4BDo
         0YI6qZQnau9UbO31uTeEinc61RtgkASEMAdkcxPSnfUbIBwDlObqFLYQfo+bxOePEznd
         Gs+w==
X-Gm-Message-State: AOAM531+1VaZ6hNMoqpSTaawM3wUx7G+XeexnK7Rf9UZFxa8M1PrcI8P
        +oNZcG3/jQfICijALAIpQKg=
X-Google-Smtp-Source: ABdhPJzzr3tF0msm9M9me6iwBbk4xw6xmyd3m8ysjYTJenRq9RMXCaRqEnSbSUtFThwmifsjkh4nlw==
X-Received: by 2002:a05:620a:110d:: with SMTP id o13mr3324760qkk.108.1630420208421;
        Tue, 31 Aug 2021 07:30:08 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7821:7d0e:d840:aa7e? ([2600:1700:e72:80a0:7821:7d0e:d840:aa7e])
        by smtp.gmail.com with ESMTPSA id e22sm10059894qte.57.2021.08.31.07.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 07:30:07 -0700 (PDT)
Subject: Re: [PATCH 15/15] scalar: accept -C and -c options before the
 subcommand
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
 <6455b18f1b623032b9066c1730dee045fbe7a3f3.1630359290.git.gitgitgadget@gmail.com>
 <871r6axban.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8a96c097-2261-7cc3-839c-b388b595f2d1@gmail.com>
Date:   Tue, 31 Aug 2021 10:30:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <871r6axban.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/31/2021 4:32 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Aug 30 2021, Johannes Schindelin via GitGitGadget wrote:
> 
>> The `git` executable has these two very useful options:
>>
>> -C <directory>:
>> 	switch to the specified directory before performing any actions
>>
>> -c <key>=<value>:
>> 	temporarily configure this setting for the duration of the
>> 	specified scalar subcommand
>>
>> With this commit, we teach the `scalar` executable the same trick.
>> [...]
>> +	while (argc > 1 && *argv[1] == '-') {
>> +		if (!strcmp(argv[1], "-C")) {
>> +			if (argc < 3)
>> +				die(_("-C requires a <directory>"));
>> +			if (chdir(argv[2]) < 0)
>> +				die_errno(_("could not change to '%s'"),
>> +					  argv[2]);
>> +			argc -= 2;
>> +			argv += 2;
>> +		} else if (!strcmp(argv[1], "-c")) {
>> +			if (argc < 3)
>> +				die(_("-c requires a <key>=<value> argument"));
>> +			git_config_push_parameter(argv[2]);
>> +			argc -= 2;
>> +			argv += 2;
>> +		} else
>> +			break;
>> +	}
> 
> This along with my earlier comment about the Makefile copy/pasting makes
> me wonder if an easier way to integrate this wouldn't be to refactor
> git.c a bit to have it understand either "git" or "scalar", then instead
> of "ls-tree" etc. as "git" the subcommands would become "built-ins".
> 
> Which would give us both "[git|scalar] [-c ...] <cmd>" for free, and
> elimante the need for the inevetable future divergence of wanting -p,
> -P, --exec-path etc. in both.
 
Such a change would likely eliminate the ability to not include Scalar
when building the Git codebase, which we tried to avoid by keeping it
within contrib and have it be compiled via an opt-in flag.

If we want to talk about integrating Scalar into Git in a deeper way,
then that is an interesting discussion to have, but it lives at a much
higher level than Makefile details.

The questions we are really looking to answer in this RFC are:

1. Will the Git project accept Scalar into its codebase?

2. What is the best place for Scalar to live in the Git codebase?

We erred on the side of keeping Scalar as optional as possible. If
the community is more interested in a deeper integration, then that
could be an interesting direction.

In my opinion, I think the current tactic is safest. We could always
decide on a deeper integration later by moving the code around. It
seems harder to do the reverse.

Thanks,
-Stolee
