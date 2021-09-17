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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58951C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 09:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43DEA610A6
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 09:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241119AbhIQJ1a (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 05:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245727AbhIQJXd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 05:23:33 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA861C06178A
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 02:20:06 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id h17so27608056edj.6
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 02:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=kDJbKBJ4sd9SMSbGnkunppL27CWBGWq1pKWwS4y5JYo=;
        b=f9O/95Hxd2pIIYVvkyAkC9KF9LLWHs1wG3+2L5UyzURFZjxQ7LT5LULkYCr18GBA8w
         w8uFnk7wpxG4vsM6bi76058WVRRJLk4v/t99TFD2HV44BIV1PwyQvrLEquxK8WFGo1sn
         M131HsMHztvMg1aTvnDPJlJrgNpBXAd3M/Y+OnJ8aGZZk4MEpj/h4aa+TznSue6aHxis
         8iC8lTwBc5lkO+r0z16Hl+XwdvBw2MuMI7cuHiAF1gngZRk0vLblRSRR/h8sVdaZnjwn
         sxK1/pW0E1miq9SQ0JF+8rFBH0FtGaIYXXpP0JSA7/9gyG57jstO2dSSdSZ6FngEaJOI
         kZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=kDJbKBJ4sd9SMSbGnkunppL27CWBGWq1pKWwS4y5JYo=;
        b=kI38f8BL7NoQI8n3pwPuSecA53P8OVXZ6wXRL74euUE3+G8L0kcEmGi6QmkOo/Yqnx
         YPoGK9aARCc84bRa+zY3oKN0cwklDbegVABLYC2iDvJYMuQvDLUrpHewhDJqBESQZgrq
         hikCX2eXiVq9Dye7T9Zpkw4oAiz+a9w/rDMH8z1qezmfYDJUvToEPEoag/TIC267keyW
         g8THK92djukKSifDb9kxi7ER4SOY4u+2M/NMkpKzlxQCLh+EtBhHM4x1HTaBN10uhsmM
         JjdYoeUb6tGFez+9tgMmhQaoLsmBtJbVRSKN6fxAVMmg6DTfZ2O9gUKCD01SKBEIj0kx
         Wniw==
X-Gm-Message-State: AOAM531CueDVdlS9g/wBHIOr///O8gnR3ELoz49SufIQQ0gI9Y17i9f3
        n10/AxFMl8iK8E9N6XMvMnw=
X-Google-Smtp-Source: ABdhPJwsi5AmqPT6U2T5etbEDygeVTQFgkbZk+HS3wvIZlGi0zMjAIrO3K/J4Un+V3QJIOwqyDaSbg==
X-Received: by 2002:a50:bae6:: with SMTP id x93mr11422853ede.232.1631870405365;
        Fri, 17 Sep 2021 02:20:05 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v8sm2058310ejy.79.2021.09.17.02.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 02:20:04 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 4/4] t5326: test propagating hashcache values
Date:   Fri, 17 Sep 2021 10:56:09 +0200
References: <cover.1631049462.git.me@ttaylorr.com>
 <acf3ec60cb6f151a9f121d242f38fef6711cced4.1631049462.git.me@ttaylorr.com>
 <87zgsnj0q0.fsf@evledraar.gmail.com> <YTggYXtyS/AW4JRF@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YTggYXtyS/AW4JRF@nand.local>
Message-ID: <87y27veeyj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 07 2021, Taylor Blau wrote:

> On Wed, Sep 08, 2021 at 03:46:29AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>
>> On Tue, Sep 07 2021, Taylor Blau wrote:
>>
>> > Now that we both can propagate values from the hashcache, and respect
>> > the configuration to enable the hashcache at all, test that both of
>> > these function correctly by hardening their behavior with a test.
>> >
>> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
>> > ---
>> >  t/t5326-multi-pack-bitmaps.sh | 32 ++++++++++++++++++++++++++++++++
>> >  1 file changed, 32 insertions(+)
>> >
>> > diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmap=
s.sh
>> > index 4ad7c2c969..24148ca35b 100755
>> > --- a/t/t5326-multi-pack-bitmaps.sh
>> > +++ b/t/t5326-multi-pack-bitmaps.sh
>> > @@ -283,4 +283,36 @@ test_expect_success 'pack.preferBitmapTips' '
>> >  	)
>> >  '
>> >
>> > +test_expect_success 'hash-cache values are propagated from pack bitma=
ps' '
>> > +	rm -fr repo &&
>> > +	git init repo &&
>> > +	test_when_finished "rm -fr repo" &&
>>
>> It seems the need for this "rm -fr repo" dance instead of just relying
>> on test_when_finished "rm -rf repo" is because of a 3x tests in a
>> function in tb/multi-pack-bitmaps that should probably be combined into
>> one, i.e. they share the same logical "repo" setup.
>
> Yeah. There's definitely room for clean-up there if we want to have each
> of the tests operate on the same repo. I have always found sharing a
> repo between tests difficult to reason about, since we have to assume
> that any --run parameters could be passed in.
>
> So I have tended to err on the side of creating and throwing away a new
> repo per test, but I understand that's somewhat atypical for Git's
> tests.

Just in an effort to make myself clear here, because between your note
in https://lore.kernel.org/git/YUOds4kcHRgMk5nC@nand.local/ and
re-reading my mail here I can barely understand what I meant here :)

What I mean is that the whole "rm -rf" dance at the start of tests is
fallout from an earlier call you made in c51f5a6437c (t5326: test
multi-pack bitmap behavior, 2021-08-31) to split up three tests that
really are the same logical test in terms of setup/teardown.

If they were to be re-combined as shown in the diff-on-top at the end
here none of the tests need a "rm -rf repo" at the beginning, because
they can all rely on a starting pattern of:

    test_when_finished "rm -rf repo" &&
    git init repo &&
    ( cd repo ... )

Or, you can also just not re-use the "repo" name, which is what I did in
the fsck tests at
https://lore.kernel.org/git/patch-v6-01.22-ebe89f65354-20210907T104559Z-ava=
rab@gmail.com/;
then you don't even need test_when_finished "rm -rf[ ...]".

None of this requires fixing here or a re-roll, unless you happen to
think this diff is the best thing since sliced bread (assume my
Signed-off-by).

But just as a general musing on patterns to use in tests, I see why you
used that 1x test as 3x, because you want "test_expect_success" to give
you the label on for each "step".

I think that would be worth fixing in test-lib.sh, there's no inherent
reason we couldn't support "checkpoints" or "subtests" within
"test_expect_success" (the latter being a part of the TAP protocol).

But until then IMNSHO this sort of thing is an anti-pattern,
i.e. needing to write things like:

    test_expect_success '[...]' 'A'
    test_expect_success '[...]' 'B'

Where a part of what B needs to do is to clean up the mess left behind
A, or relies on its setup.

That's just added verbosity and context when reading the code. Ideally
you'd just need to read the "setup" at the start, and then individual
tests, with this pattern you need to read the preceding test(s) to see
where the crap they're cleaning came from, and if it's even needed etc.

(For the "setup" part I've suggested a test_expect_setup, see
https://lore.kernel.org/git/8735vrvg39.fsf@evledraar.gmail.com/).

The "needs the setup" part of this has the negative side-effect of
breaking the semantics of the --run option. As noted in the E-Mail
linked in the last paragraph it doesn't work well in general because of
things like this, but let's steer in the right direction.

I.e. with this change you can run:

    ./t5326-multi-pack-bitmaps.sh --run=3D111-113

Which is great, usually you need at least 1,<nums you want> ,r
1-10,<nums you want> to get the setup. But because you split them this
breaks:

    ./t5326-multi-pack-bitmaps.sh --run=3D112-113

I.e. we'll run only the 2nd and 3rd test in a sequence that needs the
1st for setup.

For context: My preference for this isn't just an asthetic or
theoretical thing. It's really nice to be hacking some code, find that
I've broken the bitmap code somehow in your test #112, and be able to
just run (since running the whole thing takes 13s on my box, and I'd
like to test in a tight loop):

    ./t5326-multi-pack-bitmaps.sh --run=3D112

But that breaks as noted above, so I need read earlier tests (I was
probably looking at test #112 already at this point) and see how their
setup works etc.

Anyway, as with so many things in git.git being able to just assume
--run works like this isn't something you can rely on in the general
case, but just as a matter of where we should be headed...

>> > +	(
>> > +		cd repo &&
>> > +
>> > +		git config pack.writeBitmapHashCache true &&
>>
>> s/git config/test_config/, surely.
>
> No, since this is in a subshell (and we don't care about unsetting the
> value of a config in a repo that we're going to throw away, anyways).
>
> (Side-note: since this has a /bin/sh shebang, we can't detect that we're
> in a subshell and so test_config actually _would_ work here. But
> switching this test to run with /bin/bash where we can detect whether or
> not we're in a subshell would cause this test to fail with test_config).

Yes, you're 100% right here. This was purely a misreading on my part, I
managed to somehow not see/take into account the subshell. Using
test_config makes no sense here.

The diff-on-top for discussion mentioned above:

diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 24148ca35b3..a6bb0abb387 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -133,8 +133,8 @@ bitmap_reuse_tests() {
 	from=3D$1
 	to=3D$2
=20
-	test_expect_success "setup pack reuse tests ($from -> $to)" '
-		rm -fr repo &&
+	test_expect_success "setup/build/verify ($from -> $to) pack reuse bitmaps=
" '
+		test_when_finished "rm -rf repo" &&
 		git init repo &&
 		(
 			cd repo &&
@@ -148,13 +148,9 @@ bitmap_reuse_tests() {
 				git multi-pack-index write --bitmap
 			else
 				git repack -Adb
-			fi
-		)
-	'
+			fi &&
=20
-	test_expect_success "build bitmap from existing ($from -> $to)" '
-		(
-			cd repo &&
+			# Build
 			test_commit_bulk --id=3Dfurther 16 &&
 			git tag new-tip &&
=20
@@ -164,13 +160,9 @@ bitmap_reuse_tests() {
 				git multi-pack-index write --bitmap
 			else
 				git repack -Adb
-			fi
-		)
-	'
+			fi &&
=20
-	test_expect_success "verify resulting bitmaps ($from -> $to)" '
-		(
-			cd repo &&
+			# Verify
 			git for-each-ref &&
 			git rev-list --test-bitmap refs/tags/old-tip &&
 			git rev-list --test-bitmap refs/tags/new-tip
@@ -183,9 +175,8 @@ bitmap_reuse_tests 'MIDX' 'pack'
 bitmap_reuse_tests 'MIDX' 'MIDX'
=20
 test_expect_success 'missing object closure fails gracefully' '
-	rm -fr repo &&
-	git init repo &&
 	test_when_finished "rm -fr repo" &&
+	git init repo &&
 	(
 		cd repo &&
=20
@@ -217,9 +208,8 @@ test_expect_success 'setup partial bitmaps' '
 basic_bitmap_tests HEAD~
=20
 test_expect_success 'removing a MIDX clears stale bitmaps' '
-	rm -fr repo &&
-	git init repo &&
 	test_when_finished "rm -fr repo" &&
+	git init repo &&
 	(
 		cd repo &&
 		test_commit base &&
@@ -245,8 +235,8 @@ test_expect_success 'removing a MIDX clears stale bitma=
ps' '
 '
=20
 test_expect_success 'pack.preferBitmapTips' '
-	git init repo &&
 	test_when_finished "rm -fr repo" &&
+	git init repo &&
 	(
 		cd repo &&
=20
@@ -284,9 +274,8 @@ test_expect_success 'pack.preferBitmapTips' '
 '
=20
 test_expect_success 'hash-cache values are propagated from pack bitmaps' '
-	rm -fr repo &&
-	git init repo &&
 	test_when_finished "rm -fr repo" &&
+	git init repo &&
 	(
 		cd repo &&
=20
