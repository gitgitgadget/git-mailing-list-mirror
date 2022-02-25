Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4E8C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 11:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240278AbiBYLuy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 06:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240249AbiBYLuu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 06:50:50 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F9514FFFD
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 03:50:17 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id p15so10342311ejc.7
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 03:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=bEl7tk4XTDBe42I5y7CYYeWJ9QomA8F2Mb5pRopLkWY=;
        b=pKsPVM0e8pjV4bSnYql4LAPHvn7Ag8Sx5Z0M0WfMTJagU+K+qoTaenhJ3ciPf3Iwhv
         tVSyNEVgwHKjEF+d/uzEmLNGRK8zY1A+is653Uguohnv9iGrEXo3BUXZXJUM6eMYc3AD
         dQ1INRmEdWY2Pfk60FmiW1zcPzm5snQqBHlaBmOPrH++rHtsOgjGhhU1PklrTBVt0leP
         JIWzjmhs7kC0sOtreVg6RDosKOsba79h885t37nBEFnDcdF4mwxAaTCMjqZRsOxEDmCB
         SXrswmBtIwNpUKtfiX5RhOHUt5Xs40HHTnciizgIKEinYtbQzRteaoehPKW6+VI6OpOR
         8tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=bEl7tk4XTDBe42I5y7CYYeWJ9QomA8F2Mb5pRopLkWY=;
        b=5WbzC29cpqLt3AANgBry1lYon8vpIdhSEqm3B7pW/VjA0lW2q8oOUvEe+UOgJOUvgP
         A42sGsls4yerLnMnbJO0iaLY3A4Te/BrQJLWKxBa3yft9RQI0AJF7MFuHclPtmQjV34+
         c01yW+lc5/WAcu0/AV0NU5QknM8UXdPOe8ddFebilCKypFSSRN4thau6z00GtuYjtevZ
         yrWl/rHmdwJZeADtxliW+hX9WaUy8s2HncH5S806NunsWxfnBFJ7H6ctpyYZcrYmgTPp
         H3ZZmhR5sSjqkBRuOfwZETQ2n/5+M4Xcb65bZ4DyDBcvvFJV+MIGaamoVPyD/HyHxZFm
         7etQ==
X-Gm-Message-State: AOAM532PwJqpBRcl4eoiAulgi0Q8GO938wCcb1TQK38+5alIrNFyZqO2
        K81cECjGCs8Il593yoNa5aM=
X-Google-Smtp-Source: ABdhPJzrXoj2Iy/R3+iOykfmmI7GLkG9YGOJQiYA8phiNA5FIcRzHcfl9EfCCbmMxSXtz77LHDROHg==
X-Received: by 2002:a17:906:65d5:b0:6ba:3133:dfb9 with SMTP id z21-20020a17090665d500b006ba3133dfb9mr6041921ejn.56.1645789815994;
        Fri, 25 Feb 2022 03:50:15 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w11-20020a056402128b00b00412ec3f5f74sm1233806edv.62.2022.02.25.03.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 03:50:15 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nNZ70-000UVJ-Sa;
        Fri, 25 Feb 2022 12:50:14 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     John Cai <johncai86@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 1/3] stash: add test to ensure reflog --rewrite
 --updatref behavior
Date:   Fri, 25 Feb 2022 12:45:19 +0100
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
 <pull.1218.v2.git.git.1645554651.gitgitgadget@gmail.com>
 <6e136b62ca4588cc58f2cb59b635eeaf14e6e20d.1645554652.git.gitgitgadget@gmail.com>
 <220223.864k4q6jpr.gmgdl@evledraar.gmail.com> <xmqq4k4ptgsv.fsf@gitster.g>
 <220223.86ley1b653.gmgdl@evledraar.gmail.com>
 <865928A5-3F54-4B51-B502-07E24D98CEDB@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <865928A5-3F54-4B51-B502-07E24D98CEDB@gmail.com>
Message-ID: <220225.86lexz88sp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 24 2022, John Cai wrote:

> Hi =C3=86var,
>
> On 23 Feb 2022, at 16:50, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Wed, Feb 23 2022, Junio C Hamano wrote:
>>
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>>
>>>> This test was already a bit broken in needing the preceding tests, but
>>>> it will break now if REFFILES isn't true, which you can reproduce
>>>> e.g. with:
>>>>
>>>>     ./t3903-stash.sh --run=3D1-16,18-50 -vixd
>>>>
>>>> Perhaps the least sucky solution to that is:
>>>>
>>>> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
>>>> index ec9cc5646d6..1d11c9bda20 100755
>>>> --- a/t/t3903-stash.sh
>>>> +++ b/t/t3903-stash.sh
>>>> @@ -205,13 +205,19 @@ test_expect_success 'drop stash reflog updates r=
efs/stash with rewrite' '
>>>>  	cat >expect <<-EOF &&
>>>>  	$(test_oid zero) $oid
>>>>  	EOF
>>>> -	test_cmp expect actual
>>>> +	test_cmp expect actual &&
>>>> +	>dropped-stash
>>>>  '
>>>
>>> If "git stash drop", invoked in earlier part of this test before the
>>> precontext, fails, then test_cmp would fail and we leave
>>> dropped-stash untouched, even though we did run "git stash drop"
>>> already.
>>
>> Yes, that's an edge case that's exposed here, but which I thought wasn't
>> worth bothering with. I.e. if you get such a failure on test N getting
>> N+1 failing as well isn't that big of a deal.
>>
>> The big deal is rather that we know we're adding a REFFILES dependency
>> to this, which won't run this at all, which will make the "stash pop"
>> below fail.
>>
>>> Why does the next test need to depend on what has happened earlier?
>>
>> They don't need to, and ideally wouldn't, but most of our test suite has
>> this issue already. Try e.g. running it with:
>>
>>     prove t[0-9]*.sh :: --run=3D10-20 --immediate
>>
>> And for this particular file running e.g. this on master:
>>
>>     ./t3903-stash.sh --run=3D1-10,30-40
>>
>> Will fail 7 tests in the 30-40 range.
>>
>> So while it's ideal that we can combine tests with arbitrary --run
>> parameters, i.e. all tests would tear down fully, not depend on earlier
>> tests etc. we're really far from that being the case in practice.
>>
>> So insisting on some general refactoring of this file as part of this
>> series seems a bit overzelous, which is why I'm suggesting the bare
>> minimum to expect and work around the inevitable REFFILES failure, as
>> Han-Wen is actively working in that area.
>
> Curious what your thoughts are on an effort to isolate these tests from e=
ach other.
> I like your approach in t/t1417 in creating a test repo and copying it ov=
er each time.
> Something like this?

That looks good to me if you're willing to do that legwork, probably
better in a preceding cleanup commit.

> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index ac345eced8cb..40254f8dc99c 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -41,7 +41,9 @@ diff_cmp () {
>         rm -f "$1.compare" "$2.compare"
>  }
>
> -test_expect_success 'stash some dirty working directory' '
> +test_expect_success 'setup' '
> +       git init repo &&
> +       cd repo &&
>         echo 1 >file &&
>         git add file &&
>         echo unrelated >other-file &&
> @@ -54,48 +56,54 @@ test_expect_success 'stash some dirty working directo=
ry' '
>         test_tick &&
>         git stash &&
>         git diff-files --quiet &&
> -       git diff-index --cached --quiet HEAD
> +       git diff-index --cached --quiet HEAD &&
> +       cat >expect <<-EOF &&

nit: you can add \ to that, i.e. <<-\EOF. Helps readability, i.e.  it's
obvious right away that no variables are in play..

> +       diff --git a/file b/file
> +       index 0cfbf08..00750ed 100644
> +       --- a/file
> +       +++ b/file
> +       @@ -1 +1 @@
> +       -2
> +       +3
> +       EOF
> +       cd ../
>  '
>
> -cat >expect <<EOF
> -diff --git a/file b/file
> -index 0cfbf08..00750ed 100644
> ---- a/file
> -+++ b/file
> -@@ -1 +1 @@
> --2
> -+3
> -EOF
> +test_stash () {
> +       cp -R repo copy &&
> +       cd copy &&
> +       test_expect_success "$@" &&
> +       cd ../ &&
> +       rm -rf copy
> +}
>
>
> -test_expect_success 'parents of stash' '
> +test_stash 'parents of stash' '
>         test $(git rev-parse stash^) =3D $(git rev-parse HEAD) &&
>         git diff stash^2..stash >output &&
>         diff_cmp expect output
>  '

For this sort of thing I think it's usually better to override
"test_expect_success" as a last resort, i.e. to have that
"test_setup_stash_copy" just be a "setup_stash" or whatever function
called from within your test_expect_success.

And instead of the "rm -rf" later, just do:

    test_when_finished "rm -rf copy" &&
    cp -R repo copy &&
    [...]

The test still needs to deal with the sub-repo, but it could cd or use
"-C".

It's bad to add "cd .." in a &&-chain, because if earlier steps fail
we're in the wrong directory for the next test, so either -C or a
sub-shell...

> Not sure if it's worth it though?

Maybe not, which is why I suggested upthread to maybe go for some
smallest possible change here and focus on the lib-ificitaion :)

>
>
>>
>>>>  test_expect_success 'stash pop' '
>>>>  	git reset --hard &&
>>>>  	git stash pop &&
>>>> -	test 9 =3D $(cat file) &&
>>>> +	if test -e dropped-stash
>>>> +	then
>>>> +		test 9 =3D $(cat file)
>>>> +	else
>>>> +		test 3 =3D $(cat file)
>>>> +	fi &&
>>>>  	test 1 =3D $(git show :file) &&
>>>>  	test 1 =3D $(git show HEAD:file) &&
>>>>  	test 0 =3D $(git stash list | wc -l)

