Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F49C433B4
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 06:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 562CE611C9
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 06:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349223AbhDNGXN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 02:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347687AbhDNGXH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 02:23:07 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB394C061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 23:22:45 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id m3so22254548edv.5
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 23:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=LNv57ZN5SDURfFduoUwTePro4cocInVVO0Yx5uXmW0Y=;
        b=QGztWEAb2yHpxPCVeJZ1lY4CCM7Zeg0TfKedLKBV4p0hL1rWnb2HSy/jOrOgkJlrAP
         QeLYDrQmIUyUZwfnjQ2dCEKwpmpmQvVA466FyxXC0tP9WnmVB92fmjz1nVP5ZaC4C9Qc
         sihDcDp7ucPoVFD0Ae4I9J19AIGnFaxUb0Abiy1tHBwVZjqXBX6lQmnCbrJdir1odDWY
         nWYEOrlHHimlK9Ps801xz8p2r/T1THRjyn9lsF4mkkHGDUYGG++FLgCQ+mPXFP6piMV+
         lC1O/nhkeVqCbcCrOQ/Wl3DnZOi60xkB52BrVEiQuRzHKlyQRjfRUP4B2yszRtz4dovY
         lFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=LNv57ZN5SDURfFduoUwTePro4cocInVVO0Yx5uXmW0Y=;
        b=PTzssbtYdeJanrX6XBdqv06JIC618IBa63Fw1y4tnVDfrXbwToIUReK5TMULVg/QsA
         4NQSrQim2NWtU4sPhbP35rGhoLnP6qoz2gWsD94z++iQHaJ0dXhmyeDRAfcweVgRUoOk
         t9OjBV2C6W09woQ8Zajj1xYKj5t2Tipkkvm+rw+FKeSSYEzg8fTAqm0CKeYEx3oF9o9L
         MHUWKt3OtzN9+7AWTjWSgzEvDuoDrlDOCdIu3am0ICZ5KctHKikzap6ATJN7rkebn1wd
         5NZ84SJ95x/oQHpXK2jRQLc4+Ba7Uf6fk53AUleAbA6KbXYitbf+ilxExCssoaAN9kns
         p8PA==
X-Gm-Message-State: AOAM533wNUFa4xKvbbvQmus8dWPTdPKUTylDteDuZwYb1Ve4JrLfn4om
        mu8vlvIir6mVRQMLqfKWsvY=
X-Google-Smtp-Source: ABdhPJyAK1toJ4Lkr7nEw64ZwMDhmpdvkmfSgHycBwWh8H/8sMc8oBMC1T3aFGygXjWNACA/oVpYOA==
X-Received: by 2002:a50:f19d:: with SMTP id x29mr30975458edl.102.1618381364555;
        Tue, 13 Apr 2021 23:22:44 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id s20sm10835069edu.93.2021.04.13.23.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 23:22:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] diff tests: rewrite flakyness-causing test "aid"
References: <patch-1.1-f0542cd902c-20210413T121930Z-avarab@gmail.com>
 <cover-0.2-00000000000-20210413T122645Z-avarab@gmail.com>
 <patch-2.2-c2cb52b6605-20210413T122645Z-avarab@gmail.com>
 <CAHd-oW4G+7z3UM3qjhPp=2oqOPE4a49fweew0n+gheGtQEy5VA@mail.gmail.com>
 <87fszu2elw.fsf@evledraar.gmail.com>
 <CAHd-oW6D7Tmp2TmrmGvXDt-NnT_wxhfr_bn_P_7=ot=m_2eyyA@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAHd-oW6D7Tmp2TmrmGvXDt-NnT_wxhfr_bn_P_7=ot=m_2eyyA@mail.gmail.com>
Date:   Wed, 14 Apr 2021 08:22:43 +0200
Message-ID: <874kg92xn0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 13 2021, Matheus Tavares Bernardino wrote:

> On Tue, Apr 13, 2021 at 4:01 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Tue, Apr 13 2021, Matheus Tavares Bernardino wrote:
>>
>> > On Tue, Apr 13, 2021 at 9:31 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> > <avarab@gmail.com> wrote:
>> >>  t/t4013-diff-various.sh | 25 +++++++++++++++----------
>> >>  1 file changed, 15 insertions(+), 10 deletions(-)
>> >>
>> >> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
>> >> index 67f6411aff9..228ff100c61 100755
>> >> --- a/t/t4013-diff-various.sh
>> >> +++ b/t/t4013-diff-various.sh
>> >> @@ -200,10 +200,12 @@ do
>> >>         esac
>> >>         test=3D$(echo "$label" | sed -e 's|[/ ][/ ]*|_|g')
>> >>         pfx=3D$(printf "%04d" $test_count)
>> >> -       expect=3D"$TEST_DIRECTORY/t4013/diff.$test"
>> >> +       expect_relative=3D"t4013/diff.$test"
>> >> +       expect=3D"$TEST_DIRECTORY/$expect_relative"
>> >>         actual=3D"$pfx-diff.$test"
>> >>
>> >>         test_expect_$status "git $cmd # magic is ${magic:-(not used)}=
" '
>> >> +               test_when_finished "rm $actual" &&
>> >
>> > Nit: before these two patches, "$actual" was only removed when the
>> > test succeeded. So, in case of failure, the failed output files would
>> > still be there for debugging. It might be interesting to keep this
>> > behavior and only remove "$actual" at the end of the test.
>>
>> Either I'm missing something or you are, that's how test_when_finished
>> works.
>>
>> It's skipped under e.g. "--immediate --debug". See b586744a864 (test:
>> skip clean-up when running under --immediate mode, 2011-06-27)
>
> I was mostly thinking about the `artifacts` zip we get from our CI
> when a test fails. I find the final trash dir quite useful for some
> post-mortem analysis, especially to debug WIP tests that only fail
> occasionally or test failures on OSes I don't have quick access to.

Ah, yes that's a problem we should solve, but I think we should not put
off migration to test_when_finished because of that.

The whole reason we use it is to clean up the work area for the next
test.

Thus if we do:

    git something >expected &&
    test_cmp expected actual &&
    rm expected actual

And "git something" segfaults it's only dumb luck that subsequent tests
don't fail in non-obvious ways due to the files being left behind.

If we could rely on this in general we could make everything under
test_when_finished a noop, but I think you'll find that'll fail a lot of
things in the test suite if we do that.

But the problem you cite is legitimate, but we should solve it with
something like:

 1. If we fail tests 58 and 67 out of 100 we should/could run these
    again at the end under some more exhaustive debugging mode where
    we'd save away all the intermediate files.

 2. Or, and test_when_finished helps here, we could set $PATH when it
    runs to a directory with a custom "rm", which would save away the
    temporary files, expecting that we'll tar them up if any of the
    tests whose files we saved failed (we'd delete the other ones).

 3. Similarly, wrap "rm" in some "cat and rm" for common cases like
    actual/expected files, and improve the verbose output to some
    "verbose if fails".

