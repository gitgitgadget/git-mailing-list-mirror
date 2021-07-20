Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238AFC07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 19:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF57A6101B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 19:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhGTSxm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 14:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhGTSxl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 14:53:41 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8978BC061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 12:34:17 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id qb4so35957408ejc.11
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 12:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ctI0zzfBSdWvX463ys4wqQ7l489XMW/C8CYmGNfNLFo=;
        b=Zz+ABBbSsCiiskqoxhMn41j/jHrlvXKhLgqxXhOLdy71VOqV3osUHaG5trBTQ4tZgW
         SzZEjkkcrnvXazBD3X34Wvy+D/sthD5ONbNiBfQKtPOTfT19dhn1Hv2jZ8fGnjKB14lO
         fqwlM681TJ8nn4VmbdJti0Ra/J7I4xyifTJvFs/oMC5JFZLXcRmhIm9KflmzLi3bP88h
         XgHnuJKfX7/m9gK/0+i8qgrexUYxDlJnj4T+u81DE04qgTA9RJvtOCPEFhEw9efs8Z90
         AHOGsVPh7F3/TIaBYo1xrWOV8vtP5EP9kiVOwzATM5djV2mnPHn1kSI3mRzqNowtGEcL
         ZbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ctI0zzfBSdWvX463ys4wqQ7l489XMW/C8CYmGNfNLFo=;
        b=YIoiedxf+xFo1TSFa4SCmQ1L4CNCjq9Kbj3ggwpCTW8kvA70XqMbWQt7VznXUqze41
         qmPleMgsrdX3rai6s9fn5iM3KSh8cSRB7QP3chb0WkLF74dTkDFQSeLcRMGC/y+Ol5Us
         +sk+lqhLBBVGSIF0o5+n2lHG41V9AqPwtnFylP5znwojTzOl5OVY+7pphGgqFISyRmzw
         q1MVLNMRkET3Yn6i92epNe5VgEj4b32Mn6ErVqE/sfVIRYZY4t41E1BUa1+wX/2wGjUM
         Xd5aoENj6DYmpIkelzGDcmWBDhrufNtrRjtxQIzevjw04hbvD7fCYLHQBeUD+kBrKZVl
         7X5g==
X-Gm-Message-State: AOAM532jFo4v82IWXJbpsf7BnxoCmTQMFJl3pB/WNSKyhrdy2+CdlJ+b
        UpJF/tT+I5sP/CylMdoOMPM=
X-Google-Smtp-Source: ABdhPJxTfRCeUq+t9uDYAnimlZpU+i1ZPeh+JmIXllkwbjVnteDQEk3ebvWzSr1rRbxdjCqKS+WbwQ==
X-Received: by 2002:a17:906:f743:: with SMTP id jp3mr33780813ejb.370.1626809655947;
        Tue, 20 Jul 2021 12:34:15 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id f15sm7480656ejc.61.2021.07.20.12.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 12:34:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 24/34] t/perf/p7519: speed up test using "test-tool
 touch"
Date:   Tue, 20 Jul 2021 21:18:56 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <f1ef9656fc3adf079c8e40a74baeb5356bcf1586.1625150864.git.gitgitgadget@gmail.com>
 <87h7hdbpgb.fsf@evledraar.gmail.com>
 <c6793033-9bd4-e108-4a53-56c1dbd24a60@jeffhostetler.com>
 <87k0lu2hw8.fsf@evledraar.gmail.com>
 <fc37043d-5a6c-ae8a-09a9-8498c3715d43@jeffhostetler.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <fc37043d-5a6c-ae8a-09a9-8498c3715d43@jeffhostetler.com>
Message-ID: <87wnpkvkxj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 13 2021, Jeff Hostetler wrote:

> On 7/13/21 2:18 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Tue, Jul 13 2021, Jeff Hostetler wrote:
>>=20
>>> On 7/1/21 7:09 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
>>>>
>>>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>>>
>>>>> Change p7519 to use a single "test-tool touch" command to update
>>>>> the mtime on a series of (thousands) files instead of invoking
>>>>> thousands of commands to update a single file.
>>>>>
>>>>> This is primarily for Windows where process creation is so
>>>>> very slow and reduces the test run time by minutes.
>>>>>
>>>>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>>>>> ---
>>>>>    t/perf/p7519-fsmonitor.sh | 14 ++++++--------
>>>>>    1 file changed, 6 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
>>>>> index 5eb5044a103..f74e6014a0a 100755
>>>>> --- a/t/perf/p7519-fsmonitor.sh
>>>>> +++ b/t/perf/p7519-fsmonitor.sh
>>>>> @@ -119,10 +119,11 @@ test_expect_success "one time repo setup" '
>>>>>    	fi &&
>>>>>      	mkdir 1_file 10_files 100_files 1000_files 10000_files &&
>>>>> -	for i in $(test_seq 1 10); do touch 10_files/$i; done &&
>>>>> -	for i in $(test_seq 1 100); do touch 100_files/$i; done &&
>>>>> -	for i in $(test_seq 1 1000); do touch 1000_files/$i; done &&
>>>>> -	for i in $(test_seq 1 10000); do touch 10000_files/$i; done &&
>>>>> +	test-tool touch sequence --pattern=3D"10_files/%d" --start=3D1 --co=
unt=3D10 &&
>>>>> +	test-tool touch sequence --pattern=3D"100_files/%d" --start=3D1 --c=
ount=3D100 &&
>>>>> +	test-tool touch sequence --pattern=3D"1000_files/%d" --start=3D1 --=
count=3D1000 &&
>>>>> +	test-tool touch sequence --pattern=3D"10000_files/%d" --start=3D1 -=
-count=3D10000 &&
>>>>> +
>>>>>    	git add 1_file 10_files 100_files 1000_files 10000_files &&
>>>>>    	git commit -qm "Add files" &&
>>>>>    @@ -200,15 +201,12 @@ test_fsmonitor_suite() {
>>>>>    	# Update the mtimes on upto 100k files to make status think
>>>>>    	# that they are dirty.  For simplicity, omit any files with
>>>>>    	# LFs (i.e. anything that ls-files thinks it needs to dquote).
>>>>> -	# Then fully backslash-quote the paths to capture any
>>>>> -	# whitespace so that they pass thru xargs properly.
>>>>>    	#
>>>>>    	test_perf_w_drop_caches "status (dirty) ($DESC)" '
>>>>>    		git ls-files | \
>>>>>    			head -100000 | \
>>>>>    			grep -v \" | \
>>>>> -			sed '\''s/\(.\)/\\\1/g'\'' | \
>>>>> -			xargs test-tool chmtime -300 &&
>>>>> +			test-tool touch stdin &&
>>>>>    		git status
>>>>>    	'
>>>> Did you try to replace this with some variant of:
>>>>       test_seq 1 10000 | xargs touch
>>>> Which (depending on your xargs version) would invoke "touch"
>>>> commands
>>>> with however many argv items it thinks you can handle.
>>>>
>>>
>>> a quick test on my Windows machine shows that
>>>
>>> 	test_seq 1 10000 | xargs touch
>>>
>>> takes 3.1 seconds.
>>>
>>> just a simple
>>>
>>> 	test_seq 1 10000 >/dev/null
>>>
>>> take 0.2 seconds.
>>>
>>> using my test-tool helper cuts that time in half.
>> There's what Elijah mentioned about test_seq, so maybe it's just
>> that.
>> But what I was suggesting was using the xargs mode where it does N
>> arguments at a time.
>> Does this work for you, and does it cause xargs to invoke "touch"
>> with
>> the relevant N number of arguments, and does it help with the
>> performance?
>>      test_seq 1 10000 | xargs touch
>>      test_seq 1 10000 | xargs -n 10 touch
>>      test_seq 1 10000 | xargs -n 100 touch
>>      test_seq 1 10000 | xargs -n 1000 touch
>
> The GFW SDK version of xargs does have `-n N` and it does work as
> advertised.  And it does slow down things considerably.  Letting it
> do ~2500 per command in 4 commands took the 3.1 seconds listed above.
>
> Add a -n 100 to it takes 5.7 seconds, so process creation overhead
> is a factor here.

Doesn't -n 2500 being faster than -n 100 suggest the opposite of process
overhead being the deciding factor? With -n 2500 you'll invoke 4 touch
processes, so one takes 2500/3.1 =3D~ 0.8s to run, whereas with -n 100 you
invoke 100 of them, so if the overall time is then 5.7 seconds that's
5.7/100 =3D~ ~0.06s.

Or am I misunderstanding you, or does some implicit parallelism kick in
with that version of xargs depending on -n?

>> etc.
>> Also I didn't notice this before, but the -300 part of "chmtime
>> -300"
>> was redundant before then? I.e. you're implicitly changing it to "=3D+0"
>> instead with your "touch" helper, are you not?
>>=20
>
> Right. I'm changing it to the current time.

If that "while we're at it change the behavior of the test" is wanted I
think it should be called out in the commit message. Right now it looks
like it might be an unintentional regression in the test.
