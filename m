Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF42C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 23:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA34A6136D
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 23:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236981AbhGMX7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 19:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbhGMX7J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 19:59:09 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2455CC0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 16:56:19 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id ca14so617150edb.2
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 16:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=77rZfFTcMAvdehIks100FviKz+zwIZ2iru9DGhWJqMc=;
        b=H1O0dF00WRDUL0SB+v+ybeeGqnAEUvjPGVbYBAvX062Ko7FbgTOs1jlmiL/YvBXkV5
         oAqJdwTtTv5TmIPJ2jng6Mr2ICK4PdlafI0kMgmHlWYAALETW/4ShenTOyWMUSbsbf8q
         5NnJjsiTAOGYk6v6YT0V6sFa5d+G1uM5Ug3NqhuUoo5NBiR8Qr8RpIlXPX4qiTsi7+V1
         db3dweWVEV2ap70jJaFSUXaExXktbKPrHDjP2fmIktHn4yQz36gYiEcjmEjlbg+YHVgC
         CrxQ3dGkUgI84kFsyNc+jHmsw8Gd/nnZ//4Q5bkV5aYSvKVPdgAMHqxZnLIKNzhLrdaT
         qeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=77rZfFTcMAvdehIks100FviKz+zwIZ2iru9DGhWJqMc=;
        b=jlZG99b+ieSMRGSjSghfCJ8YMkv30/O+5qMilpXhw52XBLhbICe/tRdlEQLZhZC0CL
         oV3suHE9lQQseo4XbFtYYOMYmiNhzWnpPez6X6EanSZCIgNHGxPuNhV1IBkCCAjGwxTc
         9DrpunYmtqad2vDhPj+o3J8iR4LYPs7XqtPnWlF/Qcffa+SH6k06qX6+kWzXl6enJ6lN
         yYt9TPQVHf2kPcjCnshAjpl4Ec/idCUEjrJxd8wpVcYvQHJwbs9ZBdofpp3Crvoo9VCs
         h+cAfY+Vd0X9/OUfuYXqIfJc8bXR3M84AVprFzUcRf3wMFomgrjf6IOD0RZRbd2U5yhu
         4dzg==
X-Gm-Message-State: AOAM5327vz3qTRFzaFxJWKOJgPSt2cx9ONx7heyXfdXeh64VzHNFYw96
        IbpdwSkIxZ5Eu1p9w9YXKSU=
X-Google-Smtp-Source: ABdhPJzW4HXfj2j1ztuYFgtUDLTLafxMO+cBhEkbjC1wk+1o3k/o/lFWYnqOm0HtKI83CA8eS6cX/g==
X-Received: by 2002:a05:6402:30ba:: with SMTP id df26mr9307714edb.310.1626220577579;
        Tue, 13 Jul 2021 16:56:17 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g8sm190488edw.89.2021.07.13.16.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 16:56:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/5] tests: replace remaining packetize() with
 "test-tool pkt-line"
Date:   Wed, 14 Jul 2021 01:52:09 +0200
References: <cover-0.5-00000000000-20210707T101549Z-avarab@gmail.com>
 <cover-0.5-00000000000-20210712T164208Z-avarab@gmail.com>
 <patch-4.5-a44e1790f2a-20210712T164208Z-avarab@gmail.com>
 <YO3+dBHL5ZBe/NbU@coredump.intra.peff.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YO3+dBHL5ZBe/NbU@coredump.intra.peff.net>
Message-ID: <8735sh3h09.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 13 2021, Jeff King wrote:

> On Mon, Jul 12, 2021 at 06:44:19PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Move the only remaining users of "packetize()" over to "test-tool
>> pkt-line", for this we need a new "pack-raw-stdin" subcommand in the
>> test-tool. The "pack" command takes input on stdin, but splits it by
>> "\n", furthermore we'll format the output using C-strings, so the
>> embedded "\0" being tested for here would cause the string to be
>> truncated.
>>=20
>> So we need another mode that just calls packet_write() on the raw
>> input we got on stdin.
>
> Makes sense. Lacking this "raw" version was the sticking point in the
> past for using the helper in more places.
>
>> +static void pack_raw_stdin(void)
>> +{
>> +	struct strbuf sb =3D STRBUF_INIT;
>> +	strbuf_read(&sb, 0, 0);
>> +	if (strbuf_read(&sb, 0, 0) < 0)
>> +		die_errno("failed to read from stdin");
>
> What's up with the two reads here?
>
> It looks like just a duplication. And it happens to work because each
> one tries to read to eof, making the second one generally a noop.

Yes oops, just a copy/paste error I didn't spot.

>> diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
>> index 2dde0348816..b52afb0cdea 100755
>> --- a/t/t5570-git-daemon.sh
>> +++ b/t/t5570-git-daemon.sh
>> @@ -193,10 +193,12 @@ test_expect_success 'hostname cannot break out of =
directory' '
>>  '
>>=20=20
>>  test_expect_success FAKENC 'hostname interpolation works after LF-strip=
ping' '
>> -	{
>> -		printf "git-upload-pack /interp.git\n\0host=3Dlocalhost" | packetize
>> -		printf "0000"
>> -	} >input &&
>> +	printf "git-upload-pack /interp.git\n\0host=3Dlocalhost" >has-null &&
>> +	test-tool pkt-line pack-raw-stdin >input <has-null &&
>> +	test-tool pkt-line pack >>input <<-\EOF &&
>> +	0000
>> +	EOF
>
> This is a minor style nit, but I really prefer redirecting output from
> a block (as in the original) rather than iterative appending (in the
> result). IMHO it makes it more obvious what is going into the file and
> what is not.
>
> I.e.:
>
>   {
>           printf "git-upload-pack /interp.git\n\0host=3Dlocalhost" |
> 	  test-tool pkt-line pack-raw-stdin &&
> 	  printf "0000" | test-tool pkt-line pack
>   } >input
>
> (again here the packing of "0000" is pointless, but I'm OK with it for
> consistency).

Sure, I can use {} blocks, but re the reply on 3/5 about "0000"
v.s. "0000\n" you'd like to move back to print not-a-newline here
v.s. having the helper eat lines ending with \n like everywhere else?

It's not incorrect in this case, it just seems less obvious to
me. I.e. the printf in the former case is because we explicitly care
about the exact raw input, if there's a trailing \n or not, in the
latter case we don't, so I think it's clearier to use the usual <<-\EOF
pattern rather than printf.
