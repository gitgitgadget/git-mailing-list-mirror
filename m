Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5EFC07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 18:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DA13613B0
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 18:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhGMSZV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 14:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhGMSZU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 14:25:20 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D012C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 11:22:29 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gb6so43180915ejc.5
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 11:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Ot+rKsU1PjGUa5ujyVGUNHUm1SqXjAz7RE6EOXS777k=;
        b=LT4/O9+IFef0c/PgbsnV/kr2twYW0DeHgl6I0GOoLf29129vEVCBwCpiB68zt5iqAC
         iwVIRbimQ+2m/KkhXY8+uDKMwnigtJlQvsBQb8/60Nd778pjCVWMvshwWiTsxKY46vNP
         uy1aQmDU4Xcy4KJZrUgm2Rjgcmti33MjogvO/UooypEQwIgbrp1cXpSsx/E94FyW3NUA
         7ngnB9vL6cb2yW2PWAAqB66rCP4fbhLde6cvFFq988DmxPRaHIj/7usJCVE+Q+jZDQV4
         jcY/fzmmM53gDwF4lEv0qps/PMMbSeWcJtz8KAx2c2VVaJPHbT94aCmoy79QbIr0LYHo
         9WHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Ot+rKsU1PjGUa5ujyVGUNHUm1SqXjAz7RE6EOXS777k=;
        b=g3L2l7Mx5bfk7s4qcwZLsWnbN4Vt8SNGZCVQEzSS/4BRexyCuDf2GAJeDaqoS/mi7w
         q/p+vfqse64isA1CL1gfVFTJA0TKW63UHDLXEh0XVQsDePQK5ASBLrmNiUpZme5IwUiP
         a8OFzoDH6fkWhn9Z/TwJXCUnfTdx/TcTczJVyok1TsxAox0Dq1XYLqTFQlJYxhPr8DTJ
         b5MkiMiOdHcJw2oW3dUFWHdtnbExrQ191uQQ5Vtd+tvo/WrK8yHQYuNRSBRb0VAi8fXX
         1Z8jGDddecDmx97JhxQ0d321sgd8JyEsCo+fy3F59Puawg7rrBjk9k6Z14haV4gvK5QS
         eY9Q==
X-Gm-Message-State: AOAM532p3ShSFJDfHXA+G+OPrPESaUS0xV5HVpsZnE8ogmcAD38Pg9Q5
        NVVJ9tIHeR2N8esdQvFYO+s=
X-Google-Smtp-Source: ABdhPJxAnoQAeF+6YNxayr1jxQJTkWSsEh7ybqE8Fqs2L8wXzKUbjURQo9U/gSGQgsbWug0G6QaJhw==
X-Received: by 2002:a17:906:eb99:: with SMTP id mh25mr6173139ejb.330.1626200547546;
        Tue, 13 Jul 2021 11:22:27 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id k21sm8306970ejj.55.2021.07.13.11.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 11:22:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 24/34] t/perf/p7519: speed up test using "test-tool
 touch"
Date:   Tue, 13 Jul 2021 20:18:09 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <f1ef9656fc3adf079c8e40a74baeb5356bcf1586.1625150864.git.gitgitgadget@gmail.com>
 <87h7hdbpgb.fsf@evledraar.gmail.com>
 <c6793033-9bd4-e108-4a53-56c1dbd24a60@jeffhostetler.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <c6793033-9bd4-e108-4a53-56c1dbd24a60@jeffhostetler.com>
Message-ID: <87k0lu2hw8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 13 2021, Jeff Hostetler wrote:

> On 7/1/21 7:09 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
>>=20
>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>
>>> Change p7519 to use a single "test-tool touch" command to update
>>> the mtime on a series of (thousands) files instead of invoking
>>> thousands of commands to update a single file.
>>>
>>> This is primarily for Windows where process creation is so
>>> very slow and reduces the test run time by minutes.
>>>
>>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>>> ---
>>>   t/perf/p7519-fsmonitor.sh | 14 ++++++--------
>>>   1 file changed, 6 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
>>> index 5eb5044a103..f74e6014a0a 100755
>>> --- a/t/perf/p7519-fsmonitor.sh
>>> +++ b/t/perf/p7519-fsmonitor.sh
>>> @@ -119,10 +119,11 @@ test_expect_success "one time repo setup" '
>>>   	fi &&
>>>     	mkdir 1_file 10_files 100_files 1000_files 10000_files &&
>>> -	for i in $(test_seq 1 10); do touch 10_files/$i; done &&
>>> -	for i in $(test_seq 1 100); do touch 100_files/$i; done &&
>>> -	for i in $(test_seq 1 1000); do touch 1000_files/$i; done &&
>>> -	for i in $(test_seq 1 10000); do touch 10000_files/$i; done &&
>>> +	test-tool touch sequence --pattern=3D"10_files/%d" --start=3D1 --coun=
t=3D10 &&
>>> +	test-tool touch sequence --pattern=3D"100_files/%d" --start=3D1 --cou=
nt=3D100 &&
>>> +	test-tool touch sequence --pattern=3D"1000_files/%d" --start=3D1 --co=
unt=3D1000 &&
>>> +	test-tool touch sequence --pattern=3D"10000_files/%d" --start=3D1 --c=
ount=3D10000 &&
>>> +
>>>   	git add 1_file 10_files 100_files 1000_files 10000_files &&
>>>   	git commit -qm "Add files" &&
>>>   @@ -200,15 +201,12 @@ test_fsmonitor_suite() {
>>>   	# Update the mtimes on upto 100k files to make status think
>>>   	# that they are dirty.  For simplicity, omit any files with
>>>   	# LFs (i.e. anything that ls-files thinks it needs to dquote).
>>> -	# Then fully backslash-quote the paths to capture any
>>> -	# whitespace so that they pass thru xargs properly.
>>>   	#
>>>   	test_perf_w_drop_caches "status (dirty) ($DESC)" '
>>>   		git ls-files | \
>>>   			head -100000 | \
>>>   			grep -v \" | \
>>> -			sed '\''s/\(.\)/\\\1/g'\'' | \
>>> -			xargs test-tool chmtime -300 &&
>>> +			test-tool touch stdin &&
>>>   		git status
>>>   	'
>> Did you try to replace this with some variant of:
>>      test_seq 1 10000 | xargs touch
>> Which (depending on your xargs version) would invoke "touch"
>> commands
>> with however many argv items it thinks you can handle.
>>=20
>
> a quick test on my Windows machine shows that
>
> 	test_seq 1 10000 | xargs touch
>
> takes 3.1 seconds.
>
> just a simple
>
> 	test_seq 1 10000 >/dev/null
>
> take 0.2 seconds.
>
> using my test-tool helper cuts that time in half.

There's what Elijah mentioned about test_seq, so maybe it's just that.

But what I was suggesting was using the xargs mode where it does N
arguments at a time.

Does this work for you, and does it cause xargs to invoke "touch" with
the relevant N number of arguments, and does it help with the
performance?

    test_seq 1 10000 | xargs touch
    test_seq 1 10000 | xargs -n 10 touch
    test_seq 1 10000 | xargs -n 100 touch
    test_seq 1 10000 | xargs -n 1000 touch

etc.

Also I didn't notice this before, but the -300 part of "chmtime -300"
was redundant before then? I.e. you're implicitly changing it to "=3D+0"
instead with your "touch" helper, are you not?
