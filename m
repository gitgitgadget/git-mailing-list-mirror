Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1B0C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 15:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbiGUPze (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 11:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbiGUPzc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 11:55:32 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B01EDF0E
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 08:55:31 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id oy13so3935792ejb.1
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 08:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=eOoImsrXM/ZwlYyRxNKmy8jwQrytLrqQQFV1nbJLjr8=;
        b=DeMWQ15UBOc7TwEu53ksy8GK+58ig5GxEWKWhxO8m/LPFgGc74PtsZo3ySC+zcyhyK
         iSnDWLZWSx0iXrWoYkfVWrTcYNnHUCsHdYx+IEBRGF+GtJREWAi5QP22VCnBsAVFc1vV
         qnU2IZ5HtX2GsTB5zlgaYw2TAlZIehKBMoJ2irxjOLZJXkhJIGm59BdjmWCacPOPAaEn
         QVPdLxMv/nB1SlU/K+fLBwTzAAUwRja0959Vq720reG9tTPu5Ru5YeNIAyr+RG6CXWPW
         lA/nOzNlPJypTcQDPOIgPtVzuNciciPownm8me42LTky6Sn+cwh0/jBR+tBdbKwZfQVe
         R/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=eOoImsrXM/ZwlYyRxNKmy8jwQrytLrqQQFV1nbJLjr8=;
        b=T13rIfyxplqW95He1zTWoK6FPVa+7rFxqqPH7iiEbb38IAEDyocCa1pMQRHVeoGrUS
         5JqbGliiKcQ1BQ9/m8GyPf9aRNh5YEjFtvq7C+j4IFLQ6lvPpSnT2X389WvSQ9MXZmyi
         nbb4IjNrQp7sD+PbfLg2OEzf4ffOcJkAH6+Zyje+tEhKv8eUS4Rm/H6zTcsPLq92B9Ys
         GVZ6z5vqWVf+nFBb62/lbtRWo9b8Ep2Juq/aJeqlHDssqBxjNNi7gOWY3SlskZFdc8Zt
         tL7Gy8Nu0hldHivcIUDVy2aYYZqp5yA1A+5sd5iBqHQc4RR0u2fe4sK7SafGMfLW6VWq
         yNOw==
X-Gm-Message-State: AJIora8mWnwk7rd8DU9t+QdWn0J+e0XRE2WKtpWleMfCafpOx53/Dloi
        bydgvebNLGlr5V9SzZzPjPxVJDxmaySMfg==
X-Google-Smtp-Source: AGRyM1tK+0bjfnfNVrtFQuob9DWkZYlrmp0q0S4ibiXq5aWOWbpHqGNU/wtSHBt8xRVjCJGaEzbgeg==
X-Received: by 2002:a17:907:724d:b0:72f:2366:be86 with SMTP id ds13-20020a170907724d00b0072f2366be86mr22125783ejc.146.1658418929547;
        Thu, 21 Jul 2022 08:55:29 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ha3-20020a170906a88300b0072b6d93b9afsm946333ejb.210.2022.07.21.08.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 08:55:28 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oEYWO-004fvx-1i;
        Thu, 21 Jul 2022 17:55:28 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gersha?= =?utf-8?Q?usen?= 
        <tboegi@web.de>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v8] ls-files: introduce "--format" option
Date:   Thu, 21 Jul 2022 17:54:07 +0200
References: <pull.1262.v7.git.1657692472994.gitgitgadget@gmail.com>
 <pull.1262.v8.git.1658334983053.gitgitgadget@gmail.com>
 <xmqqbktj3ct7.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqbktj3ct7.fsf@gitster.g>
Message-ID: <220721.86ilnqtq8f.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 20 2022, Junio C Hamano wrote:

> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> It's been quite many iterations, so I'll just comment on the range-diff.
>
>>      -+			usage_msg_opt("--format cannot used with -s, -o, -k, -t"
>>      ++			usage_msg_opt("--format cannot used with -s, -o, -k, -t, "
>>       +				      "--resolve-undo, --deduplicate, --eol",
>>       +				      ls_files_usage, builtin_ls_files_options);
>
> Looks good.

Although a nit I didn't spot before: missing _() & this should be marked
for translation, surely...

>>       +	git commit -m base
>>       +'
>>       +
>>       +test_expect_success 'git ls-files --format objectmode v.s. -s' '
>>      -+	git ls-files -s | awk "{print \$1}" >expect &&
>>      ++	git ls-files -s >files &&
>>      ++	cut -d" " -f1 files >expect &&
>
> Either "awk" or "cut" is fine and flipping between them is a bit
> distracting.  Cutting the pipe into two is a good move.

That "cut" suggestion saw mine, sorry about the churn...

> But is this testing the right thing?

On this...

>> +test_expect_success 'git ls-files --format objectmode v.s. -s' '
>> +	git ls-files -s >files &&
>> +	cut -d" " -f1 files >expect &&
>> +	git ls-files --format="%(objectmode)" >actual &&
>> +	test_cmp expect actual
>> +'
>
> It only looks at the first column of the "-s" output, and we are
> implicitly assuming that the order of output does not change between
> the "-s" output and "--format=<format>" output.  I wonder if it is
> more useful and less error prone to come up with a format string
> that 100% reproduces the "ls-files -s" output and compare the two,
> e.g. 
>
> 	format="%(objectmode) %(objectname) %(stage)	%(path)" &&
> 	git ls-files -s >expect &&
> 	git ls-files --format="$format" >actual &&
> 	test_cmp expect actual
>
> I do not know if the $format I wrote without looking at the doc is
> correct, but you get the idea.

Past rounds moved some tests towards that, maybe that's a good thing
here too I didn't look deeply this time around...
