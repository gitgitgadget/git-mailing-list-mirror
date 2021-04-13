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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6F0C433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 19:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DFD4613C7
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 19:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347899AbhDMTB4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 15:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhDMTBy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 15:01:54 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15164C061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 12:01:34 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u21so27625460ejo.13
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 12:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=iN+qMbmMP1e3L4Qd6Lu0rmMy4kw/OQaX8Nk4msBXB/Q=;
        b=kjqj5HPs9Jq6yEeS3kq3eywEJvdTNCbIq7g5J1/FZhtmUrY2CsKbekA+3Q/jh6k7jk
         uYDxpqPyoecnFQAjzh8u9gm+VTn6JkpuoZGbgiqeR6FditAbcZyXk3eVHYT00wvvxjE6
         EDZjAWXdt3SpvvnMZLsUTReZsppt97ljS4nwTV/YU0txs56iYQjSAN+z2ivibF0yEI/u
         Am9eXybFLJAYmrNJLKQPTQW2mkjWzEnvuyINVPmQwbTh0yKY05ftiEIe68Gt3vESOm8S
         +ofS+qQMTQlj/MEdsuine2iow2YcSarEBSGNtuRO0TzkOfcV7N+2N03mPmdjUoSH7QaF
         lo/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=iN+qMbmMP1e3L4Qd6Lu0rmMy4kw/OQaX8Nk4msBXB/Q=;
        b=DguMc5Re953mzDNQFDipsJLwFDP5fvbR7el/m0NyZnaMwMRkuVtouF7VL3wcB3+CEy
         Xqf/ibeFtzziPO7LhtJrfn9krUNaiHJCM2ITB4tYrhFD+E/lzYcQuSz+nhQdYgJPqoq6
         JJsC3MwbYfoKF3FXZJydyk8xxQ0gXP/+4YohEP1t4MB+iy4kxanbz8g34t/LlR0xEg17
         Sg8EfDwhYhRNnL9Krnc8b4Q4QiYfAJrpui9IiHPwAlP/ZS4Dolu88vtAeOWN3fRadXZy
         n9E7OFd+6h7/N+N0eg6tALmacFRlP3gGAcXopoz00BIVBYgI7zcKvfgT8u6dhATmE5R2
         wx6A==
X-Gm-Message-State: AOAM531zol+jMGkoVXGUFMNgLNhUdLdh59Orpt/WKhUP7W3myZ5oWDaj
        ovS3wEETMHALwqIzrBDJkzw=
X-Google-Smtp-Source: ABdhPJxrc/y87jY1VJID9e6m1KW3qqIwuadoWHKAJiqVt8uUMH+LYJriXq1um41SGHsyP5OFoXTP1Q==
X-Received: by 2002:a17:906:fa07:: with SMTP id lo7mr17832389ejb.321.1618340492706;
        Tue, 13 Apr 2021 12:01:32 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n5sm8524761ejj.73.2021.04.13.12.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 12:01:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] diff tests: rewrite flakyness-causing test "aid"
References: <patch-1.1-f0542cd902c-20210413T121930Z-avarab@gmail.com>
 <cover-0.2-00000000000-20210413T122645Z-avarab@gmail.com>
 <patch-2.2-c2cb52b6605-20210413T122645Z-avarab@gmail.com>
 <CAHd-oW4G+7z3UM3qjhPp=2oqOPE4a49fweew0n+gheGtQEy5VA@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAHd-oW4G+7z3UM3qjhPp=2oqOPE4a49fweew0n+gheGtQEy5VA@mail.gmail.com>
Date:   Tue, 13 Apr 2021 21:01:31 +0200
Message-ID: <87fszu2elw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 13 2021, Matheus Tavares Bernardino wrote:

> On Tue, Apr 13, 2021 at 9:31 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> If a new test is added to this "while read magic cmd" test facility
>> added in 3c2f75b590c (t4013: add tests for diff/log family output
>> options., 2006-06-26) but no test file is added it'll fail the first
>> time, but then succeed on subsequent runs as a new file has been added
>> in t4013.
>>
>> Let's accomplish the same aim in way that doesn't cause subsequent
>
> s/in way/in a way/ ?

*nod*

>> test runs to succeed. If we can't find the file we'll BUG out, and
>> suggest to the developer that they copy our "expect.new" file over,
>> unlike the previous "expect" file this won't be picked up on
>> subsequent runs.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  t/t4013-diff-various.sh | 25 +++++++++++++++----------
>>  1 file changed, 15 insertions(+), 10 deletions(-)
>>
>> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
>> index 67f6411aff9..228ff100c61 100755
>> --- a/t/t4013-diff-various.sh
>> +++ b/t/t4013-diff-various.sh
>> @@ -200,10 +200,12 @@ do
>>         esac
>>         test=3D$(echo "$label" | sed -e 's|[/ ][/ ]*|_|g')
>>         pfx=3D$(printf "%04d" $test_count)
>> -       expect=3D"$TEST_DIRECTORY/t4013/diff.$test"
>> +       expect_relative=3D"t4013/diff.$test"
>> +       expect=3D"$TEST_DIRECTORY/$expect_relative"
>>         actual=3D"$pfx-diff.$test"
>>
>>         test_expect_$status "git $cmd # magic is ${magic:-(not used)}" '
>> +               test_when_finished "rm $actual" &&
>
> Nit: before these two patches, "$actual" was only removed when the
> test succeeded. So, in case of failure, the failed output files would
> still be there for debugging. It might be interesting to keep this
> behavior and only remove "$actual" at the end of the test.

Either I'm missing something or you are, that's how test_when_finished
works.

It's skipped under e.g. "--immediate --debug". See b586744a864 (test:
skip clean-up when running under --immediate mode, 2011-06-27)

Maybe there's some edge case where we'd like to keep the files that it's
not covering, but then we should patch it to do the right thing, not use
manual "rm" at the end instead.

>>                 {
>>                         echo "$ git $cmd"
>>                         case "$magic" in
>> @@ -216,16 +218,19 @@ do
>>                             -e "s/^\\(.*mixed; boundary=3D\"-*\\)$V\\(-*=
\\)\"\$/\\1g-i-t--v-e-r-s-i-o-n\2\"/"
>>                         echo "\$"
>>                 } >"$actual" &&
>> -               if test -f "$expect"
>> +
>> +               if ! test -f "$expect"
>>                 then
>> -                       process_diffs "$actual" >actual &&
>> -                       process_diffs "$expect" >expect &&
>> -                       test_cmp expect actual
>> -               else
>> -                       # this is to help developing new tests.
>> -                       cp "$actual" "$expect"
>> -                       false
>> -               fi
>> +                       expect_new=3D"$expect.new" &&
>> +                       cp "$actual" "$expect_new" &&
>> +                       BUG "Have no \"$expect_relative\", new test? The=
 output is in \"$expect_new\", maybe use that?"
>> +               fi &&
>> +
>> +               test_when_finished "rm actual" &&
>> +               process_diffs "$actual" >actual &&
>> +               test_when_finished "rm expect" &&
>> +               process_diffs "$expect" >expect &&
>> +               test_cmp expect actual
>>         '
>>  done <<\EOF
>>  diff-tree initial
>
> The rest LGTM, thanks.

Thanks a lot for the review!
