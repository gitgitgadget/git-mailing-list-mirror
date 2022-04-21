Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16130C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 19:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386671AbiDUTTb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 15:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiDUTT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 15:19:29 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4184B41A
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 12:16:38 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g23so742585edy.13
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 12:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=gkWTLxXs68/CinGpeydEhHMVb65ipoA3yVoFFmcsGjA=;
        b=GsUYomrOafHXB1l9ymU2ES1DM7NWycs788/TbB8GcdHlUp7IFDrgjRsR1E6Y1X5nKj
         y1Sl+DTbPMl8N7KLXJzRUTTYpaVdXZsIf03U/Yc3RssyMKK3iv9d7ZMdZtMUkUFNuRwE
         eymMJM9QyQuQGS9SfCLJLqwD8OagWKCI6BBw41VmMBYO+/HZ9p2NiwBNUvHdPCaniGiT
         dwnfv9nDFDXOcDombu1+Iy/WpLKT9numbzoguFQE9vdnzeiJ0NBHCAF9fftaGSD8KlHq
         dRsjEGEEEoDSjX04eJ2huH9wT9Hgon4aGsQt+wH8nKj3eZoy9VuvzlQCQ+F+QUckrvOc
         9pAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=gkWTLxXs68/CinGpeydEhHMVb65ipoA3yVoFFmcsGjA=;
        b=n4hPfEwcp+ouUYtsnXpxdcKN/gGRY+LdLJEZoJHV4ROcfADZqH8Sx4/gzsjJpxcI78
         ls8PUCMznGky418OEm+jSBcZ19Qw9FnzpMX/BBikvOJ4twFBTtvUScd7GUm8Ey9lf6am
         vHCGIQH2FKhZXSZHtQPjFWZiWnPMBdXpQVpi30fomUb1yoqQgaaPrNWbj3SEpZrBrc5r
         Yuaq4r/vZV7a9nVn6Q4lQHIamdLeC7ZuSpXHLfQ9VmcxTB1mv9Tn7+ZOI8GNV+3KrK0Z
         /QQ8pdbJGOaSO+9Qk2DHMcXHG3h88ad6BCDrWKVqle4qFH6tsIG6ESBhxauLsZc3aSQM
         87xQ==
X-Gm-Message-State: AOAM5309Xn7TmlAoh5dI3Eh+6/xPQ0VwgOY+yaAs++FSYOXbocy0Fi43
        6moOWMyQfGu7afeP9IrOMvo=
X-Google-Smtp-Source: ABdhPJwVzWQxZsj/9SXyZPBmQcyNAcicUNtPkC4rBBViarxqKUxCITeLEX5CO2489ezqjndJrEeOow==
X-Received: by 2002:a05:6402:516e:b0:41d:79f1:ff43 with SMTP id d14-20020a056402516e00b0041d79f1ff43mr1089442ede.141.1650568597397;
        Thu, 21 Apr 2022 12:16:37 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y19-20020a056402359300b00423e51be1cesm6792122edc.64.2022.04.21.12.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 12:16:36 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nhcI8-0089rT-4Q;
        Thu, 21 Apr 2022 21:16:36 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Carlo Arenas <carenas@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH v2] CI: select CC based on CC_PACKAGE (again)
Date:   Thu, 21 Apr 2022 21:13:57 +0200
References: <patch-1.1-d89ad4d5b7c-20220421T130310Z-avarab@gmail.com>
 <patch-v2-1.1-92acf9420a9-20220421T174733Z-avarab@gmail.com>
 <xmqqzgkegspg.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqzgkegspg.fsf@gitster.g>
Message-ID: <220421.867d7i6ycr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 21 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Fix a regression in 707d2f2fe86 (CI: use "$runs_on_pool", not
>> "$jobname" to select packages & config, 2021-11-23).
>>
>> In that commit I changed CC=3Dgcc from CC=3Dgcc-9, but on OSX the "gcc" =
in
>> $PATH points to clang, we need to use gcc-9 instead. Likewise for the
>> linux-gcc job CC=3Dgcc-8 was changed to the implicit CC=3Dgcc, which wou=
ld
>> select GCC 9.4.0 instead of GCC 8.4.0.
>
> Thanks for diagnosing how things were broken.
>
>> On Thu, Apr 21 2022, Phillip Wood wrote:
>>
>>> CC is set in .github/workflows/main.yaml for the ubuntu and macos jobs
>>> so I think they will not fallback to using CC_PACKAGE and therefore
>>> not pick up the correct compiler.
>> ...
>> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
>> index c35200defb9..f12819a00d7 100644
>> --- a/.github/workflows/main.yml
>> +++ b/.github/workflows/main.yml
>> @@ -236,7 +236,6 @@ jobs:
>>            - jobname: linux-TEST-vars
>>              cc: gcc
>>              os: ubuntu
>> -            cc_package: gcc-8
>>              pool: ubuntu-latest
>>            - jobname: osx-clang
>>              cc: clang
>> diff --git a/ci/lib.sh b/ci/lib.sh
>> index cbc2f8f1caa..86e37da9bc5 100755
>> --- a/ci/lib.sh
>> +++ b/ci/lib.sh
>> @@ -122,7 +122,7 @@ then
>>  	test macos !=3D "$CI_OS_NAME" || CI_OS_NAME=3Dosx
>>  	CI_REPO_SLUG=3D"$GITHUB_REPOSITORY"
>>  	CI_JOB_ID=3D"$GITHUB_RUN_ID"
>> -	CC=3D"${CC:-gcc}"
>> +	CC=3D"${CC_PACKAGE:-${CC:-gcc}}"
>>  	DONT_SKIP_TAGS=3Dt
>>=20=20
>>  	cache_dir=3D"$HOME/none"
>
> OK, so we favor CC_PACKAGE (from the matrix.vector.cc_package) if
> set, and then cc (again, from the matrix.vector.cc) if set, and then
> finally use "gcc" as a fallback.  In the osx-gcc job, cc_package is
> set to gcc-9 while in the osx-clang, cc is gcc that confusingly calls
> for clang.  That sounds like it would do the right thing for two
> macs.

Yes.

> For other jobs with different settings for cc and cc_package, does
> this have any effect?  I do not think I saw any mention in the
> proposed log message.
>
> 		vector.cc	vector.cc_package	old	new
> linux-clang	clang		-			clang	clang
> linux-sha256	clang		-			clang	clang
> linux-gcc	gcc		gcc-8			gcc	gcc-8
> osx-clang	clang		-			clang	clang
> osx-gcc		gcc		gcc-9			clang	gcc-9
> linux-gcc-default gcc		-			gcc	gcc
>
> So, linux-gcc job used to use whichever "gcc" the platform gave us,
> but now it explicitly asks for gcc-8, which may or may not be
> different from what linux-gcc-default uses, and there is no other
> difference by this change.  We may get a better test coverage (if
> the default gcc is not gcc-8) or no improvement (if the default is
> gcc-8), so it is a strict improvement worth recording as an intended
> side effect in the proposed log message to help future developers.
>
> Other than that, looks good to me.

I'm happy to rephrase it however you'd like, but I'm a bit confused by
the "saw any mention in the proposed log message". I'm fairly sure
paragraph 2 onwards covers this, i.e. how linux-gcc's behavior is
changed (as it also regressed).

What I suppose is left undiscussed is that jobs that don't define
CC_PACKAGE at all won't be impacted, is that what you wanted to be
explicitly mentioned?
