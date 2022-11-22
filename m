Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9700C4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 22:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbiKVWKU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 17:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiKVWKS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 17:10:18 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FAAB4B1
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 14:10:16 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id n20so38985632ejh.0
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 14:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/cC7I5qKVrJAybBAYRIrTHJHNHoI8MTRypaLwceLBps=;
        b=UUEZFaAr0utPCav7N+jf5Oq927zawaojJDGEAciEPpvx6xhGINPM1ZnBat1exoFZrG
         Bt5LRoTLUP1MPrVesXoJ2g8iva3vRQKv1aWLgPORQkU6/n4Btc93ITr5aQoeqiAThmoG
         Glx9EOV/ot1IUlkrz/udTOv62QUc7A6zhg28zjpxTojLT72Convyxc3lIAxQNCfuvtsI
         uJMtbZAANmK1rdl+HW6HJZ7GZqVhth+JGeYUZqheJ1hotqYQ6cqaD0f7gm2lWdQrp9iU
         W9MafELqS4zmZ9lb5d5iKEfvkw+tYvF8hKZ28e2xk1sBarSJr6lHSa87wyvnvErctQoj
         igQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/cC7I5qKVrJAybBAYRIrTHJHNHoI8MTRypaLwceLBps=;
        b=o1hIXBsY7I1+LCZgzwAOJsHgiXCXcXXQiBqXPFw+wI13GJV0PvX6b2nJZKdGYV0DIA
         vcE0nDrZlsmcpHzmaFA5zPlz02drKYrZtGH4v56VZtkyMknVJ2ozevM+kogAEZ8ZaJzE
         AAhiInJda0XnP6iN/qd8WnSRx8je/STBVhTEIY+tpfHVrFja6h+iuNulEzCM4eOP4VF5
         YJG/3jJQC9/XG50E0bxmnbHjOjGWqjuXoAnRKClIKPyZcuqmkDpjMrh+ZMdetteGlRFT
         hJf4cZegUnRJmLtJ5idtUtZR3WDaCltaWAbCUF8O9joBQ+ygopAdldWYXi96aKIY5SYs
         Jlog==
X-Gm-Message-State: ANoB5plz5tiG7GOE6hj1gI+JICt/JY2w9fL5X93nStBAQsG/Kny/LQFx
        TDvKoHNnD+WD7q0XdoerZ3sq4nwDgXI=
X-Google-Smtp-Source: AA0mqf7CRSZ1QIpXcHXeX0Ycu+8RHaQpl8Z3yZ7CqalQMSoeXP0J500kt2UocvnvL/bKcAKyc+bdqA==
X-Received: by 2002:a17:906:524f:b0:7ae:59dd:e3f4 with SMTP id y15-20020a170906524f00b007ae59dde3f4mr10004076ejm.755.1669155015300;
        Tue, 22 Nov 2022 14:10:15 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id x4-20020aa7cd84000000b004677b1b1a70sm6753473edv.61.2022.11.22.14.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 14:10:14 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oxbT4-000nYp-1T;
        Tue, 22 Nov 2022 23:10:14 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Sarah Julia Kriesch <sarah.kriesch@opensuse.org>,
        Git List <git@vger.kernel.org>
Subject: Re: git can not be built for s390x since update to git-2.38.0
Date:   Tue, 22 Nov 2022 23:01:55 +0100
References: <4657a19c-89c3-2237-9e6b-db897a492072@opensuse.org>
 <CAPig+cT92EokWeVA_Ou1P6kkaq90wneRrgPqnKLbkHnc=U56Vg@mail.gmail.com>
 <221122.86zgcj9hmc.gmgdl@evledraar.gmail.com>
 <CAPig+cTniT+_7MxMm3Kc2C_oEtQGg-WA3870baL8990Av6HmJQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CAPig+cTniT+_7MxMm3Kc2C_oEtQGg-WA3870baL8990Av6HmJQ@mail.gmail.com>
Message-ID: <221122.86v8n6abeh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 22 2022, Eric Sunshine wrote:

> On Tue, Nov 22, 2022 at 9:41 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> On Mon, Nov 21 2022, Eric Sunshine wrote:
>> > The empty "chainlinttmp/tests" file also sounds suspicious. If you
>> > haven't already done so, I would recommend following the advice in [1]
>> > and running each command individually which Makefile would have run;
>> > this might allow you to isolate the problematic command or shell
>> > construct if such exists.
>>
>> I can also reproduce this on gcc202. It's the same issue with ending up
>> with an empty "tests" file.
>
> Were you able to determine why the "tests" file is empty? The creation
> loop is simple enough:
>
>     for i in $(CHAINLINTTESTS); do \
>         echo "test_expect_success '$$i' '" && \
>         sed -e '/^# LINT: /d' chainlint/$$i.test && \
>         echo "'"; \
>     done >'$(CHAINLINTTMP_SQ)'/tests && \
>
> and the file is never changed after that (or shouldn't be).

Sorry. I meant that the result of running *against* the non-empty test
file is empty. I.e.:

	$ perl chainlint.pl chainlinttmp/tests ; echo $?
	0

Anyway, the "fix" here can also be:

	 $jobs =3D ncores() if $jobs < 1;
	+$jobs =3D 1 if $jobs < 1;

I.e. it's another case of bad /proc/cpuinfo parsing.

On that platform, this also works:
=09
	diff --git a/t/chainlint.pl b/t/chainlint.pl
	index 976db4b8a0..e6bc476fc5 100755
	--- a/t/chainlint.pl
	+++ b/t/chainlint.pl
	@@ -656,7 +656,7 @@ sub ncores {
	        # Windows
	        return $ENV{NUMBER_OF_PROCESSORS} if exists($ENV{NUMBER_OF_PROCESS=
ORS});
	        # Linux / MSYS2 / Cygwin / WSL
	-       do { local @ARGV=3D'/proc/cpuinfo'; return scalar(grep(/^processor=
\s*:/, <>)); } if -r '/proc/cpuinfo';
	+       do { local @ARGV=3D'/proc/cpuinfo'; return scalar(grep(/^(?:CPU\d+=
|processor\s*):/, <>)); } if -r '/proc/cpuinfo';
	        # macOS & BSD
	        return qx/sysctl -n hw.ncpu/ if $^O =3D~ /(?:^darwin$|bsd)/;
	        return 1;

But a generic guard against parse failure seems prudent.

>>         avar@gcc202:/run/user/1632/git/t$ uname -a
>>         Linux gcc202 6.0.0-4-sparc64-smp #1 SMP Debian 6.0.8-1 (2022-11-=
11) sparc64 GNU/Linux
>>         avar@gcc202:/run/user/1632/git/t$ lsb_release -a
>>         No LSB modules are available.
>>         Distributor ID: Debian
>>         Description:    Debian GNU/Linux bookworm/sid
>>         Release:        n/a
>>         Codename:       bookworm
>
> This is one of the compile-machines to which you have access?

Yes, and you can get access to it too. The GCC farm is open for free
software development, you only need to send in an E-Mail request, ssh
key etc.

>> The change at the tip of
>> https://lore.kernel.org/git/221122.86cz9fbyln.gmgdl@evledraar.gmail.com/
>> fixes it for me, i.e. getting rid of the perl threads stuff...
>
> I'm confused. How does a change to chainlint.pl -- which only reads
> the "tests" file -- fix the empty "tests" file?

It doesn't, sorry, see above.
