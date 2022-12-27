Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD67C46467
	for <git@archiver.kernel.org>; Tue, 27 Dec 2022 18:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiL0S1C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Dec 2022 13:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiL0S1A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2022 13:27:00 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF18B7DB
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 10:26:59 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id u9so33753470ejo.0
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 10:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lM9BWYnDd4/iM275GJ+UR3FBFdU+ZRUisq2fbYjzigY=;
        b=NFxGbydqzSV9nvGOGpZEXZZ8xGKlAU4CgheUGGEYACcJ63lcITk45o3hdx05lHhfda
         JXpCYcoAYRZp2w61xCXWqtlR3iRNm0We9PuMBi2XdN8WVEeNVqn60mzyVzKkdSV09bKL
         DvLYQv2G+jTXryPEhV4CCKQOmArxHGA5WnupslO6t+0yE3OMzh7wYOhNYZ8JQ2wLPmzS
         QsyPAJW/35BVDd3g46xYY1hq1BN3vXsfU6Zo92zVqclHZvNTeTeybIAmgN5XVy8fMpZE
         O4hTumUMS3qe/prZSpHEOBf1LrD/ObiEzcUA5fh1YPwP2G16SCuMzZ5rImQCyK44pNnE
         OAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lM9BWYnDd4/iM275GJ+UR3FBFdU+ZRUisq2fbYjzigY=;
        b=acD8RPWcS9Y2bKMXbs5G1Ap/DMz3d1T5prjLTiLiOsVhzFnDPjfXC8XKbwZn7rBl9p
         eRRy/tUts9pXbeLf9ZiSB8qHhf66AaLJjnRl61cEOnjGDF2BIezaYwznViiY+8dVytxB
         aHglGMBChxhGJwAy4ISPAPUqd/eJfJeFTYPm1fWnvpmrlkAN8W1VpaIA18dxlbwekhBJ
         l41GqXMCIy1qTrlQqx8yHkWpbjEcGNvogmD4Z0gy9vJhRM6R9J++KOlHE2D34/NvNi8L
         cwgPWGVwAGgBkDNfwmmEu2003Il/uOH/McC1qkZGZVTbqRF2a7cJw17oFLshQa5nPBFS
         uYHA==
X-Gm-Message-State: AFqh2krsjnuO/xBIVgA6R/l5jvJ65sqfnAuf3srWa0iAO1QNuCczbSAl
        KI/kSKRupNcTQCGf0L8XeH8=
X-Google-Smtp-Source: AMrXdXsDdYA0EiABQ8RTxTPpkKWDAgrYGHcj8gjBwAIqYq9MVh6XQL1czRJNBvQrq6wvcT5I8J5U4w==
X-Received: by 2002:a17:906:bc47:b0:78d:f455:3110 with SMTP id s7-20020a170906bc4700b0078df4553110mr16969922ejv.56.1672165618452;
        Tue, 27 Dec 2022 10:26:58 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id l22-20020a1709065a9600b00780982d77d1sm6359288ejq.154.2022.12.27.10.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 10:26:57 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pAEfB-009Mom-1a;
        Tue, 27 Dec 2022 19:26:57 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 6/6] tests: don't lose misc "git" exit codes
Date:   Tue, 27 Dec 2022 19:18:18 +0100
References: <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
 <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>
 <patch-v4-6.6-94df7a1764e-20221219T101240Z-avarab@gmail.com>
 <6efe13ea-8782-2337-1626-9687e2219680@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <6efe13ea-8782-2337-1626-9687e2219680@dunelm.org.uk>
Message-ID: <221227.86cz84vh1q.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 27 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> On 19/12/2022 10:19, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Fix a few miscellaneous cases where:
>> - We lost the "git" exit code via "git ... | grep"
>> - Likewise by having a $(git) argument to git itself
>> - Used "test -z" to check that a command emitted no output, we can use
>>    "test_must_be_empty" and &&-chaining instead.
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> [...]
>> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
>> index 5841f280fb2..f1fe5d60677 100755
>> --- a/t/t3701-add-interactive.sh
>> +++ b/t/t3701-add-interactive.sh
>> @@ -296,9 +296,11 @@ test_expect_success FILEMODE 'stage mode and hunk' '
>>   	echo content >>file &&
>>   	chmod +x file &&
>>   	printf "y\\ny\\n" | git add -p &&
>> -	git diff --cached file | grep "new mode" &&
>> -	git diff --cached file | grep "+content" &&
>> -	test -z "$(git diff file)"
>> +	git diff --cached file >out &&
>> +	grep "new mode" out &&
>> +	grep "+content" out &&
>> +	git diff file >out &&
>> +	test_must_be_empty out
>
> "git diff --exit-code file" would suffice here, we don't need to
> redirect the output and check that it is empty.

Correct.

Or even "git diff-files -s --exit-code", which might make things clearer
still, or have this use the "diff_cmp" helper defined in the test file,
as most of its siblings do.

But as with a sibling comment of mine I wanted to avoid starting to
refactoring these tests for general betterment, and just to narrowly
avoid losing the exit code.

