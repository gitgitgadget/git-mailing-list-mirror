Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D349C433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 17:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239341AbiBYRYP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 12:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237449AbiBYRYP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 12:24:15 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8881637C0
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 09:23:40 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6FC1C17DE66;
        Fri, 25 Feb 2022 12:23:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lz2hjfzfSGgn
        IcRWI1Vhp8iCKnuSqOVkCtekKb6YuQo=; b=Lsu5xcNb/x7i0dr60U2XCgd1AP1K
        uC8SED5yKZbiXU3NVHWf+2QT3hHfQaD5yGX2qEJRKgLEPi+1XrGpoKsXYyuxHZGS
        yJrQ2OKPWnl4mTqt1W4c0G2NPd3N0rI0GzeLT1PwDRpoSDQRXmJbHFtzU4WrR1Mw
        ZR5HXxd06RKagGw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 678D917DE65;
        Fri, 25 Feb 2022 12:23:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A611B17DE64;
        Fri, 25 Feb 2022 12:23:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     John Cai <johncai86@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 1/3] stash: add test to ensure reflog --rewrite
 --updatref behavior
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
        <pull.1218.v2.git.git.1645554651.gitgitgadget@gmail.com>
        <6e136b62ca4588cc58f2cb59b635eeaf14e6e20d.1645554652.git.gitgitgadget@gmail.com>
        <220223.864k4q6jpr.gmgdl@evledraar.gmail.com>
        <xmqq4k4ptgsv.fsf@gitster.g>
        <220223.86ley1b653.gmgdl@evledraar.gmail.com>
        <865928A5-3F54-4B51-B502-07E24D98CEDB@gmail.com>
        <220225.86lexz88sp.gmgdl@evledraar.gmail.com>
Date:   Fri, 25 Feb 2022 09:23:36 -0800
In-Reply-To: <220225.86lexz88sp.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 25 Feb 2022 12:45:19 +0100")
Message-ID: <xmqq5yp2g8rr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AB05A50C-965F-11EC-967C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Curious what your thoughts are on an effort to isolate these tests fro=
m each other.
>> I like your approach in t/t1417 in creating a test repo and copying it=
 over each time.
>> Something like this?
>
> That looks good to me if you're willing to do that legwork, probably
> better in a preceding cleanup commit.

Yup.  Thanks for helping other contributors.  I agree with many
things you said in your review.

>> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
>> index ac345eced8cb..40254f8dc99c 100755
>> --- a/t/t3903-stash.sh
>> +++ b/t/t3903-stash.sh
>> @@ -41,7 +41,9 @@ diff_cmp () {
>>         rm -f "$1.compare" "$2.compare"
>>  }
>>
>> -test_expect_success 'stash some dirty working directory' '
>> +test_expect_success 'setup' '
>> +       git init repo &&
>> +       cd repo &&

We do not want to "chdir" around without isolating it in a
subprocess.  If this test fails after it goes to "repo" but before it
does "cd ..", the next test begins in the "repo" directory, but it
is most likely not expecting that.

>> -cat >expect <<EOF
>> -diff --git a/file b/file
>> -index 0cfbf08..00750ed 100644
>> ---- a/file
>> -+++ b/file
>> -@@ -1 +1 @@
>> --2
>> -+3
>> -EOF
>> +test_stash () {
>> +       cp -R repo copy &&
>> +       cd copy &&
>> +       test_expect_success "$@" &&
>> +       cd ../ &&
>> +       rm -rf copy
>> +}

This will create an anti-pattern, because you would want to have the
part between "cd copy" and "cd .." in a subshell, but you do not
want to do test_expect_success inside a subshell.  Hence, this is a
bad helper that does not help and should not be used, I would think.

>> -test_expect_success 'parents of stash' '
>> +test_stash 'parents of stash' '
>>         test $(git rev-parse stash^) =3D $(git rev-parse HEAD) &&
>>         git diff stash^2..stash >output &&
>>         diff_cmp expect output
>>  '
>
> For this sort of thing I think it's usually better to override
> "test_expect_success" as a last resort, i.e. to have that
> "test_setup_stash_copy" just be a "setup_stash" or whatever function
> called from within your test_expect_success.
>
> And instead of the "rm -rf" later, just do:
>
>     test_when_finished "rm -rf copy" &&
>     cp -R repo copy &&
>     [...]

Yup.  I think this is how we would write it:

	test_expect_success 'parents of stash' '
		test_when_finished "rm -fr copy" &&
		cp -R repo copy &&
		(
			cd copy &&
			... the real body of the test here, like ...
			test $(git rev-parse stash^) =3D $(git rev-parse HEAD) &&
		)
	'

> The test still needs to deal with the sub-repo, but it could cd or use
> "-C".

I am not sure about this.  test_expect_success does not take "-C".
