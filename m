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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36778C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 01:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2DB064E2F
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 01:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhBQBdz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 20:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhBQBdz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 20:33:55 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C119C061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 17:33:14 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id i23so13400952ejg.10
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 17:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=UC6Pl2O3nd1JzX+GzCFCL95YX1K+3oB0PRQJkh39Y0U=;
        b=bRP/Ms+65SAXtKLx+8ehx1cHyjWrT2LkcIOmiKNE8DTuPQLfWtPs0VYZfqC5zHCQaD
         vPZ8TmyutZduxOl4thO7UQkO2ke2YSqLz6cfKl8JcwXw6CGNIqZWjAupFYyAaR4bCkG3
         zzUc3e4AjZzJQuEQU6iwNPVEIz1Ft2pGtVz786shwfXFnIt1oVNu6KXEPvVSFAZ8NhlV
         glnW4dNL85orTTkdhjfH3kKoeNYkP0lTdZq8MT7fvAZbCotTlSiCXG9rGU3hWKeRx6KX
         1egjr4h7QBrwEizoH4n6WfApCi71vLc9LWuAtrnLNRa10U0EieqWlTRVg4Ur0bAHbRXL
         0LXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=UC6Pl2O3nd1JzX+GzCFCL95YX1K+3oB0PRQJkh39Y0U=;
        b=qnNPPjm/kOqUk9n5fg7o4VBa3wGhjq+eSX5RdUE3JxXU9MHWRHD3wmyNhVpdUHW5+T
         ejPsuYQvKM80LjDw5hFJywZqpXn7PP2YkgsvTie8NLlwZgywrShg209E007MPR06BNjH
         /rNXZF4KM1cBqtypmIHbV7Qpnvp1f9ZyjDYOma9TZgKuwluPv3Q9cNLeZs9nRiKMyMZL
         bqzytbzI23ClgSzJ4u1IcTSuptKFR7NNnev5nFBp1e+wIACq0Jzwg9Pa7h38tw1GKoTu
         2mPNcxiGdoN2ssVpvwpx8Ua8hgEBZyjm9vM3m222H8xALHTSFsMFtDEwDz5cNHuV2c3f
         WrRw==
X-Gm-Message-State: AOAM531jJcb5xzs8d2Q6VrrHCsXRAimbFOpoNRRc5VLoPOjDock9c88B
        zpj2C6i8OtU7TpwFfcXBDHw=
X-Google-Smtp-Source: ABdhPJwhFspy3Xk4gnXHZKP9pmS8Qz3cma8JQ434H0syh231MGUhj6/nYcAnPIK5jMTzv8qLCEqv+g==
X-Received: by 2002:a17:906:cf84:: with SMTP id um4mr4182421ejb.61.1613525593048;
        Tue, 16 Feb 2021 17:33:13 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id u15sm286426ejy.48.2021.02.16.17.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 17:33:12 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 11/27] blame tests: simplify userdiff driver test
References: <20210215005236.11313-1-avarab@gmail.com>
 <20210215154427.32693-12-avarab@gmail.com>
 <c1e637d5-ad69-1726-2b38-476d0192ca02@kdbg.org>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <c1e637d5-ad69-1726-2b38-476d0192ca02@kdbg.org>
Date:   Wed, 17 Feb 2021 02:33:11 +0100
Message-ID: <87eehfa36w.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 15 2021, Johannes Sixt wrote:

> Am 15.02.21 um 16:44 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> Simplify the test added in 9466e3809d (blame: enable funcname blaming
>> with userdiff driver, 2020-11-01) to use the --author support recently
>> added in 999cfc4f45 (test-lib functions: add --author support to
>> test_commit, 2021-01-12).
>> We also did not need the full fortran-external-function content,
>> let's
>> cut it down to just the important parts, and further modify it to
>> demonstrate that the fortran-specific userdiff function is in effect
>> by adding "WRONG" lines surrounding the "RIGHT" one.
>> The test also left behind a .gitattributes files, let's clean it up
>> with "test_when_finished".
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>   t/annotate-tests.sh | 36 +++++++++++++++---------------------
>>   1 file changed, 15 insertions(+), 21 deletions(-)
>> diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
>> index 04a2c58594..4a86e0f349 100644
>> --- a/t/annotate-tests.sh
>> +++ b/t/annotate-tests.sh
>> @@ -479,32 +479,26 @@ test_expect_success 'blame -L ^:RE (absolute: end-=
of-file)' '
>>   	check_count -f hello.c -L$n -L^:ma.. F 4 G 1 H 1
>>   '
>>   -test_expect_success 'setup -L :funcname with userdiff driver' '
>> -	echo "fortran-* diff=3Dfortran" >.gitattributes &&
>> -	fortran_file=3Dfortran-external-function &&
>> -	cat >$fortran_file <<-\EOF &&
>> +test_expect_success 'blame -L :funcname with userdiff driver' '
>> +	cat >file.template <<-\EOF &&
>> +	def WRONG begin end
>>   	function RIGHT(a, b) result(c)
>> +	int WRONG(void) {}
>>     	integer, intent(in) :: ChangeMe
>> -	integer, intent(in) :: b
>> -	integer, intent(out) :: c
>> -
>> -	c =3D a+b
>> -
>> -	end function RIGHT
>>   	EOF
>> -	git add "$fortran_file" &&
>> -	GIT_AUTHOR_NAME=3D"A" GIT_AUTHOR_EMAIL=3D"A@test.git" \
>> -	git commit -m "add fortran file" &&
>> -	sed -e "s/ChangeMe/IWasChanged/" <"$fortran_file" >"$fortran_file".tmp=
 &&
>> -	mv "$fortran_file".tmp "$fortran_file" &&
>> -	git add "$fortran_file" &&
>> -	GIT_AUTHOR_NAME=3D"B" GIT_AUTHOR_EMAIL=3D"B@test.git" \
>> -	git commit -m "change fortran file"
>> -'
>>   -test_expect_success 'blame -L :funcname with userdiff driver' '
>> -	check_count -f fortran-external-function -L:RIGHT A 7 B 1
>> +	fortran_file=3Dfile.f03 &&
>> +	test_when_finished "rm .gitattributes" &&
>> +	echo "$fortran_file diff=3Dfortran" >.gitattributes &&
>> +
>> +	test_commit --author "A <A@test.git>" \
>> +		"add" $fortran_file \
>> +		"$(cat file.template)" &&
>> +	test_commit --author "B <B@test.git>" \
>> +		"change" $fortran_file \
>> +		"$(cat file.template | sed -e s/ChangeMe/IWasChanged/)" &&
>> +	check_count -f $fortran_file -L:RIGHT A 3 B 1
>>   '
>>     test_expect_success 'setup incremental' '
>>=20
>
> I don't get the point. What do you need the tokens "WRONG" for when
> they are not checked anywhere? Instead of adding unrelated lines (that
> do not even look like Fortran), couldn't you just not remove some of
> the others? In particular, the last one that contains "RIGHT" as well
> may be useful to keep in order to show that the code is not confused
> by it.

Isn't the point of the test to assert that we're using a userdiff driver
over the built-in xdiff rules here?

We can imagine that a change to its default heuristics would be to find
the first non-whitespace line, but it jumping over non-whitespace lines
in search of a fortran-looking line doesn't seem like it would ever
happen. Hence the WRONG lines.

> Please place "$fortran_file" in dquotes on the check_count line.

Why do we need to dquote a convenience variable defined in the test
itself that'll never contain spaces or other funny things we'd get if we
had $(pwd) or whatever in there? It wouldn't hurt, but maybe I'm missing
some reason for why it's necessary or desired here.

