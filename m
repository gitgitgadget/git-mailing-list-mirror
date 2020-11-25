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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F54C83017
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 15:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4599E2087C
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 15:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1v3REaK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731739AbgKYPmD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 10:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730641AbgKYPmC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 10:42:02 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181F9C0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 07:42:02 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id 11so2579989oty.9
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 07:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BE58KGRxOdnI696graLVJbSP+gT8krNAkiZawqajvUY=;
        b=D1v3REaK4s6a2C6K6KCIClup24usog0RCNsanB8w6+W5VrWietnDWEZ18rQ/hVRR2O
         L/nvdnE1x8uzR0gISHAl9WC+L5csse8LcEdv+Fh8tI5yWtc5pgSdf12l1RHlwMNv0jsr
         8JZZniFWTix8XMLKtc4U6E2JG5heTgzF0GTcy/AH0VtnPCNvhWTjXNxq4+X/G0h0mir7
         oJNoiD5HVzvgXWI487XQUOs6pU5drKj4BWD9ewb/RSUycsLqOPbTMcURFRAEoGS5dRPs
         kccQKSdfQotF/5qFMmAYlAvakbOJ4T0Xx0Mc99Fv91+3NRr65rfkhqbP7z4cKgvPkpqo
         9bWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BE58KGRxOdnI696graLVJbSP+gT8krNAkiZawqajvUY=;
        b=l5ncpiIHt7kp035yUJ46Sfp2hwaS0rqIGc6wYK4bBaDWDKhFum8909RvgO33rmIWDw
         oionAn+V0a7J8p8WnwBWDxe/CWx3AF55W9GRcibSYihWaDaOU+QIjHN9+A+Nk3ZD6RB3
         Da2lSDcvuHkJ9Ee/GheJEvtbF0QydZjR37fAzPp88mPBD9pISZAxq88C0kkl6U9wOn3s
         FcJ+QPUHbyVQ7DpHfKjnNJsJjSS/NzHnBElwJrNEg+eGvGIfq6oGF5Gi3HAKXhf1lKh4
         SjBqEUc8EL7yU2/YCrho2Q6q+PtDdf54esf1y+fOjxfHxzYECCrR9hMc6xooUA31ngKL
         McYg==
X-Gm-Message-State: AOAM53039IzF/nAaPJf8SPms06SRq3FYmR5qzmaBbdy5gu+1cjbMrLjq
        Qn9pLYxEJQ8D0ZBUNWXOaTE=
X-Google-Smtp-Source: ABdhPJyaZFMeodSNhcatRjqjrikTQXxeU2TunGV9Fos6Wa/NriHpyr4gokmG8+TZ58M8y0UaIulkBg==
X-Received: by 2002:a9d:3d3:: with SMTP id f77mr3335866otf.125.1606318920908;
        Wed, 25 Nov 2020 07:42:00 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:b5e9:7f83:ac96:1a69? ([2600:1700:e72:80a0:b5e9:7f83:ac96:1a69])
        by smtp.gmail.com with UTF8SMTPSA id b28sm1603071oob.22.2020.11.25.07.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 07:42:00 -0800 (PST)
Subject: Re: [PATCH v2 5/7] config: plumb --fixed-value into config API
To:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
 <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
 <39718048cd8f5be053a13ff73f531e3400b80b25.1606147507.git.gitgitgadget@gmail.com>
 <20201123222123.GE499823@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d18a2f7f-67e9-05eb-95d1-ce0b4bd0b187@gmail.com>
Date:   Wed, 25 Nov 2020 10:41:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <20201123222123.GE499823@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/23/2020 5:21 PM, Emily Shaffer wrote:
> On Mon, Nov 23, 2020 at 04:05:05PM +0000, Derrick Stolee via GitGitGadget wrote:
>> +
>> +		flags = CONFIG_FLAGS_FIXED_VALUE;
> 
> I wonder whether using |= here will save someone from a headache later,
> when they want to add another flag value or move the
> CONFIG_FLAGS_MULTI_REPLACE calculation out of the tail calls below.

Good catch.

>> @@ -2803,6 +2806,8 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
>>  			store.value_regex = NULL;
>>  		else if (value_regex == CONFIG_REGEX_NONE)
>>  			store.value_regex = CONFIG_REGEX_NONE;
>> +		else if (flags & CONFIG_FLAGS_FIXED_VALUE)
>> +			store.literal_value = value_regex;
> 
> Ah, so we use .literal_value instead of pulling the string from
> value_regex because value_regex undergoes some special parsing and is
> packed into a regex_t instead.

Reminds me to call this 'fixed_value'.

>> +test_expect_success '--fixed-value uses exact string matching' '
>> +	GLOB="a+b*c?d[e]f.g" &&
>> +	rm -f initial &&
> This tells me that when you used 'initial' earlier you probably should
> have done something like 'test_when_finished rm initial' in this test
> and your earlier ones. Whoops.

Good idea. Will do.

>> +	cp initial config &&
>> +	git config --file=config --fixed-value fixed.test bogus "$GLOB" &&
>> +	git config --file=config --list >actual &&
>> +	printf "fixed.test=bogus\n" >expect &&
> It is jarring to me to see a printf here when everywhere else we use
> heredocs. 'git grep' tells me it's not unheard of, but it looks like
> those are cases where the whole file doesn't use heredocs.

I can use a heredoc just to be consistent.

(To also respond to Eric's message, I tend to use printf instead
of echo because echo starts a process while printf does not.)

>> +	test_cmp expect actual &&
>> +
>> +	cp initial config &&
>> +	test_must_fail git config --file=config --unset fixed.test "$GLOB" &&
>> +	git config --file=config --fixed-value --unset fixed.test "$GLOB" &&
>> +	test_must_fail git config --file=config fixed.test &&
> Is this one supposed to verify that there is a 'fixed.test' value
> already in 'config'? I'd prefer to see that explicitly checked with 'git
> config --get' rather than watching for a symptom, that is, fail to set.
> This comment applies to the next case too.

If no value is provided, then 'git config <name>' _is_ a query. It's not a
failed set. 'git config <name> ""' would be the way to try and set the value
to an empty string.

>> +
>> +	cp initial config &&
>> +	test_must_fail git config --file=config --unset-all fixed.test "$GLOB" &&
>> +	git config --file=config --fixed-value --unset-all fixed.test "$GLOB" &&
>> +	test_must_fail git config --file=config fixed.test &&
>> +
>> +	cp initial config &&
>> +	git config --file=config --replace-all fixed.test bogus "$GLOB" &&
>> +	git config --file=config --list >actual &&
>> +	cat >expect <<-EOF &&
>> +	fixed.test=$GLOB
>> +	fixed.test=bogus
>> +	EOF
>> +	test_cmp expect actual &&
> Hm, isn't this the same functionality as the tests you added at the
> beginning of this series? I guess you are setting up for the last case
> with --replace-all...

This is specifically demonstrating the difference that --fixed-value
provides. The tests here show "the match doesn't work by default, but
then works with --fixed-value". I'll make this clearer in the commit
message.

>> +
>> +	cp initial config &&
>> +	git config --file=config --replace-all fixed.test bogus "$GLOB" &&
>> +	git config --file=config --list >actual &&
>> +	cat >expect <<-EOF &&
>> +	fixed.test=$GLOB
>> +	fixed.test=bogus
>> +	EOF
>> +	test_cmp expect actual &&
> 
> Is this one identical to the previous one? I think it is, but if it
> isn't and I can't tell, all the more reason that each case here should
> either be labeled with a comment or separated into its own test. (Bonus
> - you could extend the individual tests from patch 1 to make sure they
> work correctly with --fixed-value too ;) )

Yes, accidentally over-zealous copy/paste.

I'm less in favor of splitting the tests, since they rely on a shared
initial config. Any failure in one part of this test is likely to also
fail the rest of the commands, so grouping them by this toggle makes
sense to me.

Thanks,
-Stolee
