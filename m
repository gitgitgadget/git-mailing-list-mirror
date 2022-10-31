Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD12C38A02
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 13:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiJaNAh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 09:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiJaNAe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 09:00:34 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67CAE0BE
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 06:00:33 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id 13so29237887ejn.3
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 06:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mvNUyhgLMtjMUC0zPjP4gciTt7Oyvv1OJcu5IDqRZbo=;
        b=NZ93zBju9akswj0QjaXbrEsT0dr342/L19lJNWBvVhZPpj2UtMCc3e6iMV4Oz0e0um
         F68CTpMjKScdxyKHgldJ5yvOBKNrDssqxvwbggCaaYMzFQJd11HTOiPcMpN0+etMUxxf
         mg/0gREwvuiq3DDYlR6rXkURLdFwkyiAy3kd41U4s/RXdikdE5iJKOl060USMZq4wYX7
         iTOmtg/rj6JTUTrN7skjhQiKiCaW6UYyPP+VAWewThksghsQHiY93DWgNgn2yawA2+lK
         m1En4pxDlHEBCChCasy47bXmpTY18mew6e5cl+WGTYqVHOIivm0eFPGD+C8n+13AGGT3
         /HpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mvNUyhgLMtjMUC0zPjP4gciTt7Oyvv1OJcu5IDqRZbo=;
        b=IykbB9/eUxF6kEj847iAXRbt/P7t9y+iElnoE6AER7uot2ytAA1XUYJtkXe0xXFRcX
         WW7e0fxGpsKGgLGY4Npsx/4CPZQqe5V5W0vLTHxz+Q4M29CXK1d3h3Mqr8ov0u+Ex/eG
         /o2RjF6+vOFsGS6lUUU3BOs5Yds0eISbn+LBP4K5UF2kH5RSzV5A1L61+c4ea25TG1f1
         wd49GW96Zs1Xh+hSkKtTMRhuSYpRsvK55INgSMkq3NeTLXnvJ7nLopiuUr6KZI4YL+YW
         uJetGtSsPO5LZdYyJalpyx0JX3yQvRfKM+bHt3FpGpfr6pGgZI+SxwizdeFKQOD6uWy3
         3RCA==
X-Gm-Message-State: ACrzQf3XMc62NfWkP2lv7Csl/snNzy2IiHkcsWQKbba3fOkkXn4AzM5F
        iY3p16WuUYO15ov0IXs+jaw=
X-Google-Smtp-Source: AMsMyM6kDTRUOtMEg9cVHZr+Y3OqO0AgkbhdgjFDBAKx9Pltz6ZyNpx3MpzRhMrxrxgwbO0oOvksQA==
X-Received: by 2002:a17:906:8a48:b0:7a5:a8f5:b870 with SMTP id gx8-20020a1709068a4800b007a5a8f5b870mr12230985ejc.458.1667221232325;
        Mon, 31 Oct 2022 06:00:32 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id b25-20020a17090630d900b00780f24b797dsm2961804ejb.108.2022.10.31.06.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 06:00:31 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1opUP1-00AbDH-1D;
        Mon, 31 Oct 2022 14:00:31 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH 2/3] submodule tests: reset "trace.out" between "grep"
 invocations
Date:   Mon, 31 Oct 2022 13:50:07 +0100
References: <cover-0.3-00000000000-20221029T025520Z-avarab@gmail.com>
 <patch-2.3-708375e3104-20221029T025520Z-avarab@gmail.com>
 <Y12JfADN/YRr9IaJ@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y12JfADN/YRr9IaJ@nand.local>
Message-ID: <221031.86pme86tcg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Oct 29 2022, Taylor Blau wrote:

> On Sat, Oct 29, 2022 at 04:59:46AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
>> index 75da8acf8f4..b9546ef8e5e 100755
>> --- a/t/t5526-fetch-submodules.sh
>> +++ b/t/t5526-fetch-submodules.sh
>> @@ -178,6 +178,7 @@ test_expect_success "submodule.recurse option trigge=
rs recursive fetch" '
>>  '
>>
>>  test_expect_success "fetch --recurse-submodules -j2 has the same output=
 behaviour" '
>> +	test_when_finished "rm -f trace.out" &&
>>  	add_submodule_commits &&
>>  	(
>>  		cd downstream &&
>> @@ -705,15 +706,22 @@ test_expect_success "'fetch.recurseSubmodules=3Don=
-demand' works also without .git
>>
>>  test_expect_success 'fetching submodules respects parallel settings' '
>>  	git config fetch.recurseSubmodules true &&
>> +	test_when_finished "rm -f downstream/trace.out" &&
>
> These two seem OK to me, but...
>
>>  	(
>>  		cd downstream &&
>>  		GIT_TRACE=3D$(pwd)/trace.out git fetch &&
>>  		grep "1 tasks" trace.out &&
>> +		>trace.out &&
>> +
>
> I fail to see why these hunks are necessary. If we specify GIT_TRACE,
> and don't have a test_must_fail around the execution, then why should we
> feel obligated to clean up the trace.out after every execution?

Because the trace file isn't clobbered by each git command that
specifies GIT_TRACE, so these tests are basically doing:

	(echo foo; echo bar) >>trace &&
	grep foo trace &&

        (echo bar) >>trace &&
	grep bar trace

Now, it just so happens that the earlier command isn't echoing "bar" to
the file, so this is currently working out.

But it's a bad pattern to be pretending as though you care about the
last output (which was the intent of the test), when really what you're
testing is the combined output of all preceding commands.

This would also be a potenital landmine with "test_must_fail", just
because the command failed we're not guaranteed to have written nothing
to the log (and usually we'd get as far as to write something).

>
> If we really are concerned about not cleaning up after ourselves, how
> about writing to a separate file each time?

Better yet would be to refactor this into a function, set that up and
"test_when_finished" nuke it every time.

But I'm just going for the most minimal change here to not leave this
landmine in place. My 51243f9f0f6 (run-command API: don't fall back on
online_cpus(), 2022-10-12) already started using this pattern, and is on
"master". I think a good incremental step is to do the bare minimum to
do the same for the rest, and guard any subsequent test from being
affected by the "trace.out".

So, unless you insist I'd rather just change nothing about this series,
and not get stuck in various re-rolls/commentary about what's the ideal
refactoring, once we're starting to do that anyway...
