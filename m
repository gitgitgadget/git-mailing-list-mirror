Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42D3C433DF
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 13:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 863142074B
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 13:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXkaQh3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgG3NND (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 09:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgG3NNC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 09:13:02 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89797C061794
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 06:13:02 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id d27so20234522qtg.4
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 06:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QrMGvPslb3T2uewlhX33EH5HS//X15qCpM9s/yXCjnw=;
        b=aXkaQh3YUtR6qnNehEJJRLhkhsdJh9HBm4LuzWzwRv/tgtEtSXnEInFzKyS7u4Rxkc
         IMqp4CMN1JFL9jCaqiX/Q9MvEDKBZ1yRuI4+V+7tUxkFwUUjCZP06wIwrlV/DNIBvOEz
         /jcHAJv4ag6jBE1Mg81a4C9fyl3J8TvNUugA5/ICFECz5mmTk/SHZ5Qd07/DA/eDVLrK
         bKCBTEqbez4R6z4ovJUi9Wi9ZbqU2SQboIoKlcTRg3qqbPfDs0tQtgk+Sd9tR2u78g9Y
         j+jx9AO8ZAf5+xcQI3eooAD54etxzAz5llUrys+aNkTt2BX2nz3bUVccGpczxZxQ+ZnN
         iOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QrMGvPslb3T2uewlhX33EH5HS//X15qCpM9s/yXCjnw=;
        b=PWAafcE/hI5G5LOGcwogF30bcJ/OKF7rTzwkt+vCvGgorSYjsNC9Yz+qpeWByVtiV/
         zckSK/D6ZdLbnkMfRYY2sCwApQh1UjciSfQnMXi/1y7KkFwtkdDWFWUFyvcgPpG27+9J
         kU4PwgY2M778A7xFXjKSUX8JEFVpcuiGCqCFuRHllPJRiEz6H2U1ICbrgOTutQvVu6WW
         XXke3agz0EC9R2ESMjYF56TFoMv+KxYFeJ9yNFSRhBpueV85yyyfaxS79MsN7xiix62E
         cBp4qQW/udepCRftekjhzrhw/TDZB5HhjPnvlocU/uMvcZc1PYHu1EeQf/YWgqgxVJu4
         qZUg==
X-Gm-Message-State: AOAM532iQWgMAT68GFLBMkmF1AFy/sfzbmaSFB5Zm0ScWCbkE6mWyUc6
        PiiQqvxrqQwUBMQxFG187Sc=
X-Google-Smtp-Source: ABdhPJxvPw93aSdJbMpMuYiMmNduscDS8iRaqx5gSDueEVr+QVRpxDVeyjXL6ETgSjfmVSQztWx/6w==
X-Received: by 2002:ac8:5505:: with SMTP id j5mr2504220qtq.326.1596114779663;
        Thu, 30 Jul 2020 06:12:59 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7cc2:825e:4cec:e949? ([2600:1700:e72:80a0:7cc2:825e:4cec:e949])
        by smtp.gmail.com with ESMTPSA id j15sm4077059qkl.63.2020.07.30.06.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 06:12:58 -0700 (PDT)
Subject: Re: [PATCH v2 01/18] maintenance: create basic maintenance runner
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <63ec602a07756a41f8ccddd745562c567a4b3ed7.1595527000.git.gitgitgadget@gmail.com>
 <20200729221905.GB519065@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5cbdb559-3897-961f-4dd3-0bab11848c5b@gmail.com>
Date:   Thu, 30 Jul 2020 09:12:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <20200729221905.GB519065@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/29/2020 6:19 PM, Jonathan Nieder wrote:
> Hi,
> 
> Derrick Stolee wrote:
> 
>> [Subject: maintenance: create basic maintenance runner]
> 
> Seems sensible, and a good way to set up for the later patches.  Let's
> take a look at how it does that.
> 
> [...]
>> --- /dev/null
>> +++ b/Documentation/git-maintenance.txt
>> @@ -0,0 +1,57 @@
> [...]
>> +SUBCOMMANDS
>> +-----------
>> +
>> +run::
>> +	Run one or more maintenance tasks.
> 
> [jrnieder] How do I supply the tasks on the command line?  Are they
> parameters to this subcommand?  If so, it could make sense for this to
> say something like
> 
> 	run <task>...::

Hopefully this is documented to your satisfaction when the ability
to customize the tasks is implemented.

> What is the exit code convention for "git maintenance run"?  (Many Git
> commands don't document this, but since we're making a new command
> it seems worth building the habit.)

Is this worth doing? Do we really want every command to document
that "0 means success, everything else means failure, and some of
those exit codes mean a specific kind of failure that is global to
Git"?

> [...]
>> --- a/builtin/gc.c
>> +++ b/builtin/gc.c
>> @@ -699,3 +699,62 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
> [...]
>> +static struct maintenance_opts {
>> +	int auto_flag;
>> +} opts;
> 
> Packing this in a struct feels a bit unusual.  Is the struct going to
> be passed somewhere, or could these be individual locals in
> cmd_maintenance?

This will grow, and I'd rather have one global struct than many
individual global items. It makes it clearer when I use
"opts.auto_flag" that this corresponds to whether "--auto" was
provided as a command-line option.

> [...]
>> +
>> +static int maintenance_task_gc(void)
>> +{
>> +	int result;
>> +	struct argv_array cmd = ARGV_ARRAY_INIT;
>> +
>> +	argv_array_pushl(&cmd, "gc", NULL);
>> +
>> +	if (opts.auto_flag)
>> +		argv_array_pushl(&cmd, "--auto", NULL);
> 
> These are both pushing single strings, so they can use argv_array_push.

Thanks. I noticed a few of these myself. Luckily, I'll be going
through all of these invocations and replacing them with new
methods soon ;)

[1] https://lore.kernel.org/git/30933a71-3130-5478-cbfd-0ca5bb308cf2@gmail.com/

> [...]
>> --- /dev/null
>> +++ b/t/t7900-maintenance.sh
>> @@ -0,0 +1,22 @@
>> +#!/bin/sh
>> +
>> +test_description='git maintenance builtin'
>> +
>> +GIT_TEST_COMMIT_GRAPH=0
>> +GIT_TEST_MULTI_PACK_INDEX=0
> 
> Why does this disable commit graph and multipack index?  Is that setting
> up for something that comes later?

Yes, these don't need to be here yet.

> [...]
>> +test_expect_success 'gc [--auto]' '
>> +	GIT_TRACE2_EVENT="$(pwd)/run-no-auto.txt" git maintenance run &&
>> +	GIT_TRACE2_EVENT="$(pwd)/run-auto.txt" git maintenance run --auto &&
>> +	grep ",\"gc\"]" run-no-auto.txt  &&
>> +	grep ",\"gc\",\"--auto\"]" run-auto.txt
> 
> This feels a little odd in two ways:
> 
> - the use of "git gc" isn't a user-facing detail, so this is testing
>   implementation instead of the user-facing behavior.  That's okay,
>   though --- it can be useful to test internals sometimes.

Consider this a "unit test" of the builtin. I'm testing whether the
command-line arguments had an effect on the child process.

> - the way that this tests for "git gc" feels brittle: if the trace
>   emitter changes some day to include a space after the comma, for
>   example, then the test would start failing.  I thought that in the
>   spirit of fakes, it could make sense to write a custom "git gc"
>   command using test_write_script, but that isn't likely to work
>   either since gc is a builtin.
> 
> Perhaps this is suggesting that we need some central test helper for
> parsing traces so we can do this reliably in one place.  What do you
> think?

I'm specifically using GIT_TRACE2_EVENT, which is intended for
consumption by computer, not humans. Adding whitespace or otherwise
changing the output format would be an unnecessary disruption that
is more likely to have downstream effects with external tools.

In some way, adding extra dependencies like this in our own test
suite can help ensure the output format is more stable.

If there is a better way to ask "Did my command call 'git gc' (with
no arguments|with these arguments)?" then I'm happy to consider it.

Thanks,
-Stolee
