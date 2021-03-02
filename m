Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90505C43603
	for <git@archiver.kernel.org>; Tue,  2 Mar 2021 15:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6792664F2F
	for <git@archiver.kernel.org>; Tue,  2 Mar 2021 15:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578542AbhCBPY6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Mar 2021 10:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238702AbhCBJgP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Mar 2021 04:36:15 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37ECC061788
        for <git@vger.kernel.org>; Tue,  2 Mar 2021 01:34:55 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id c6so24363099ede.0
        for <git@vger.kernel.org>; Tue, 02 Mar 2021 01:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=A1P8Gs89AG5u+FIUx5aeZ7w8KBJyCvShGK3fnEOFc04=;
        b=rmpBKIdU87tCxWLaVcSYPolOpNzFjhj9TDo255UKs22/YB6cFHl92nFiDPsFYlg3F/
         WIk/gHQevvCl3DyCl9e+vQFn0uL+M3o+00ZTzl9GegB2ZSVUOuL9Iw1ao++UyfIfIehN
         wBKZ75BpVES4RUhHuNGWxJuI3wSIAOzak19AZ8gWe+Y37IW8cE13VXpLyDLUNNLKrPzT
         m6c+PkSnQHG0R67Br1fXOqdtliHx9Lfdj+FfnoCcMRP15HFFuu7ATkV7XAX54lflnfyg
         GPYLoTOUBDw0Ms8YMm993+fMkF45ByZ/r5LXz3Bt0ZKrNGz21ntTY6A77MtvNu2CSS+v
         3LVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=A1P8Gs89AG5u+FIUx5aeZ7w8KBJyCvShGK3fnEOFc04=;
        b=nM0ulkXYIAkNlUPsYzulTVlKt7JDUklmcalXztVEgSFPoo35YfrFTS8pplK/MEVnVw
         NPL5QXNYDJsqXzI1JWBIxAe7lLwFSDRYZZ+dhBFGkE/xtRIted7me3GaCwwPLUydFhTs
         Nt3cvdRW/fDEdIDLT9+LVxe9ZYD9gDvxQDk9C6piZOtLgW5zrbsIV3zpV1KUUKSE5rgS
         dt6ohqhopytDDUkxserySUPC+WMT/zWpjr2jZc1neZkz6ECL62A3BFQR5k5rDsdXITSO
         4ljIZ2lKU+VKDrw4HERbIBf2JOmFU+PnMoloHARenmsvyYrKUoyy206IX76g6miSbS14
         899Q==
X-Gm-Message-State: AOAM53001HcYeummpR6Bk+U72fy9bE0/E3Z5OokBNJkf5IVpyN101IVL
        +F6yUxfCkLqCOHSHhF8ydBc09CfOry4=
X-Google-Smtp-Source: ABdhPJz64Jve5qlI+LQNysmLosIN+bjwkjpukUW0Hov5Si5C8sWyRWT/OjXBIbz2kg5yns2oEp0oTA==
X-Received: by 2002:a05:6402:3549:: with SMTP id f9mr20000461edd.110.1614677694547;
        Tue, 02 Mar 2021 01:34:54 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id mc10sm3477074ejb.56.2021.03.02.01.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 01:34:53 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Benno Evers <benno@bmevers.de>, Jean Privat <jean@pryen.org>,
        =?utf-8?Q?Ren=C3=A9_Sch?= =?utf-8?Q?arfe?= <l.s.r@web.de>
Subject: Re: [PATCH 04/10] test-lib functions: add an --annotated-tag option
 to "test_commit"
References: <20200223125102.6697-1-benno@bmevers.de>
 <20210228195414.21372-5-avarab@gmail.com>
 <xmqqr1kyo8l8.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqr1kyo8l8.fsf@gitster.c.googlers.com>
Date:   Tue, 02 Mar 2021 10:34:53 +0100
Message-ID: <87czwhkif6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 01 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> @@ -220,6 +225,9 @@ test_commit () {
>>  		--no-tag)
>>  			no_tag=3Dyes
>>  			;;
>> +		--annotated-tag)
>> +			annotated_tag=3Dyes
>> +			;;
>
> A new option is welcome, but shouldn't we be straightening out the
> variables that keep track of the options around tagging?  It's not
> like it is possible to have 4 (two variables that can independently
> set to 'yes') possibilities, so something along the lines of ...
>
>          test_commit () {
>         +	tag=3Dlight &&
>                 notick=3D &&
>          ...
> 		while test $# !=3D 0
> 		do
> 			case "$1" in
> 			...
> 			--no-tag)
> 	-			no_tag=3Dyes
> 	+			tag=3Dnone
> 				;;
> 	+		--annotated)
> 	+			tag=3Dannotated
> 	+			;;
> 		...
> 	-	if test -z "$no_tag"
> 	-	then
> 	+	case "$tag" in
> 	+	none)
> 	+		;;
> 	+	light)
> 			git ${indir:+ -C "$indir") tag "${4:-$1}"
> 	+		;;
> 	+	annotated)
> 	+		git ${indir:+ -C "$indir") tag -m "$1" "${4:-$1}"
> 	+		;;
> 	+	esac
> 		...
>
> after this step (meaning, we may want to start from fixing the no_tag=3Dy=
es
> to tag=3Dnone before introducing this new feature).

Yeah, as noted in the last paragraph of the commit message:
=20=20=20=20
    The placement of --annotated-tag after "notick" in the case of the
    documentation, and then after "no_tag" in the case of the code is
    slightly inconsistent. It's to evade a merge conflict with two other
    commits adding a --printf option, and another one adding documentation
    for --no-tag.

So the existing patch + not doing a bigger refactoring is because I
didn't want to cause conflicts for you to solve with other in-flight
topics. It would be easier with ab/pickaxe-pcre2 merged down :)

I'd prefer to keep this as-is for now, and just refactor this function a
bit after the current topics land.

In particular I'd like to make the the "message file contents tags"
arguments optionally have --long-option versions, so e.g. tests that
need a separate --commit-message and --tag-message can use the helper,
there's also quite a few that could use a --file=3D<existing file>
v.s. echo-ing a "message" to a "file".


>> @@ -244,7 +252,15 @@ test_commit () {
>>  	    $signoff -m "$1" &&
>>  	if test -z "$no_tag"
>>  	then
>> -		git ${indir:+ -C "$indir"} tag "${4:-$1}"
>> +		if test -n "$annotated_tag"
>> +		then
>> +			if test -z "$notick"
>> +			then
>> +				test_tick
>> +			fi &&
>> +			test_tick
>> +		fi &&
>> +		git ${indir:+ -C "$indir"} tag ${annotated_tag:+ -a -m "$1"} "${4:-$1=
}"
>>  	fi
>>  }

