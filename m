Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F2BC433FE
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41363604E9
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243011AbhIQT1W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 15:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhIQT1W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 15:27:22 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88ED4C061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 12:25:59 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g21so33890808edw.4
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 12:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=h+PTteYJzJOC1qqcowuatHhnO2ZMXYTWDnGMPVuLbNE=;
        b=f399HTIJgEdf+WQEkY7dgKMdRkF3AaG0et4mnbwp3OxQusx1u8iLFqfnGUs/P8EaGL
         GvPnCp/u69l+id/Q4+2rxCpEMRZ2gq1Ei8i+Q0mkO+8NShRB7GrGXgROGb34CNSbftFS
         n+ivVMuZNwFiMLXUsFbeN9GpgFrMvPa2b9MFTDADy/xNpJvulBFvuh2WcFls0UUnLgDT
         SU7gG0ZdPNFj9onNXWjpdRME0dfiXqBj0ElYEO2CiWBRpYWk7g+x1tyYsmQNBReQpdlU
         aE3PAXkl6ktCmdCTgaTf3EF7byVDZMKE/KGjr15zYoT0KlqE1xTvwlOAXtu8J9Xyixcm
         1ngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=h+PTteYJzJOC1qqcowuatHhnO2ZMXYTWDnGMPVuLbNE=;
        b=KpCw55ON88QiM8APIBDCCI3ZzUQzVzayX1Tr1EqblNSTqGv/ODsaVvHlLfBvhhVS04
         zqbYUm7VG91zD/V85wSB+1ReRkX57EU34ilz7vMiXdH0W864b6ICZeIxEKjkNO3hNWER
         jUXJcE1Es5cmLfVyiWsCyQ8I5b8fUIgLTWis5WO3I+WEH49Yh/wjUSElm3hLKunTA8eu
         H4dCE3ljFx4R/rdzVQYI/CjO4fQ1U/Iox2qcYWC+wdcDfxd9AZK6gul0tCDuhxlGhyL8
         5swxyhgoCpJBWr/iK0tval9/uAayy30QA4Kb1Nl9lWbKRoLOfYGfy2KSpZmCyXcEiM8s
         8YIg==
X-Gm-Message-State: AOAM531SKnPVcUUsGWfHufIbnx+ncY3uQNd2ksrbLupv1wke9Uqd8A0m
        CuQGwa6+4wjU1PSUGHH5APvIUx0NTtk=
X-Google-Smtp-Source: ABdhPJyjsF9ahi35w0ISvUzw2P4vKwtDL1cAri6mo6hWe/6q0f4ts6rpVt1v/5FfDnFuQ8mNOwomug==
X-Received: by 2002:a17:907:9604:: with SMTP id gb4mr14279539ejc.142.1631906758005;
        Fri, 17 Sep 2021 12:25:58 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 10sm2691400eju.12.2021.09.17.12.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 12:25:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 4/4] t5326: test propagating hashcache values
Date:   Fri, 17 Sep 2021 21:22:51 +0200
References: <cover.1631049462.git.me@ttaylorr.com>
 <acf3ec60cb6f151a9f121d242f38fef6711cced4.1631049462.git.me@ttaylorr.com>
 <87zgsnj0q0.fsf@evledraar.gmail.com> <YTggYXtyS/AW4JRF@nand.local>
 <87y27veeyj.fsf@evledraar.gmail.com> <YUTRHaHDjCaxmQyY@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YUTRHaHDjCaxmQyY@nand.local>
Message-ID: <878rzvdmwq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 17 2021, Taylor Blau wrote:

> On Fri, Sep 17, 2021 at 10:56:09AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> >> It seems the need for this "rm -fr repo" dance instead of just relying
>> >> on test_when_finished "rm -rf repo" is because of a 3x tests in a
>> >> function in tb/multi-pack-bitmaps that should probably be combined in=
to
>> >> one, i.e. they share the same logical "repo" setup.
>> >
>> > Yeah. There's definitely room for clean-up there if we want to have ea=
ch
>> > of the tests operate on the same repo. I have always found sharing a
>> > repo between tests difficult to reason about, since we have to assume
>> > that any --run parameters could be passed in.
>> >
>> > So I have tended to err on the side of creating and throwing away a new
>> > repo per test, but I understand that's somewhat atypical for Git's
>> > tests.
>>
>> Just in an effort to make myself clear here, because between your note
>> in https://lore.kernel.org/git/YUOds4kcHRgMk5nC@nand.local/ and
>> re-reading my mail here I can barely understand what I meant here :)
>
> Thanks for clarifying; if I could summarize I would say that this
> discussion got started since a new test I added starts with:
>
>     rm -fr repo &&
>     git init repo &&
>     test_when_finished "rm -fr repo"
>
> where the first rm is designed to clean any state left behind from the
> split-up tests added in c51f5a6437c.
>
> I understand your suggestion, and I even think that it may be worth
> doing, but I'm not sure that I buy that any such cleanup is related to
> this series for any reason other than "you happened to add a new test in
> this file which extended the pattern".
>
> So let's pursue the cleanup, but outside of this series (and maybe once
> the dust has settled more generally on the MIDX bitmaps topics to avoid
> having the maintainer deal with any conflicts).

Yes I agree, FWIW I didn't look carefully at what was in-flight where at
the time, or the series this depends on was itself in "seen", I can't
remember which..

>> Or, you can also just not re-use the "repo" name, which is what I did in
>> the fsck tests at
>> https://lore.kernel.org/git/patch-v6-01.22-ebe89f65354-20210907T104559Z-=
avarab@gmail.com/;
>> then you don't even need test_when_finished "rm -rf[ ...]".
>
> TBH, I think that this is the most appealing thing to do. It's easy and
> doesn't require us to think too hard about test_expect_setup or
> sub-tests or anything like that where I'm not sure the complexity is
> warranted.
>
> I would probably do something like this:

Yeah, that bypasses the cleanup bit, but leaves --run broken as I
described. For new code I think it's good practice to have --run work
too.

Again, I think that's a non-issue here considering the rest of the
dumpster fire in the test suite when it comes to that, so I'm not
suggesting a re-roll or whatever.

I just used the upthread as a jumping off point since you had a question
about these patterns in the other topic, and perhaps you/some bystander
would be convinced and follow that pattern in the future.

> --- >8 ---
>
> diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
> index ec4aa89f63..11845f67ae 100755
> --- a/t/t5326-multi-pack-bitmaps.sh
> +++ b/t/t5326-multi-pack-bitmaps.sh
> @@ -132,12 +132,12 @@ test_expect_success 'clone with bitmaps enabled' '
>  bitmap_reuse_tests() {
>  	from=3D$1
>  	to=3D$2
> +	repo=3D"bitmap-reuse-$from-$to"
>
>  	test_expect_success "setup pack reuse tests ($from -> $to)" '
> -		rm -fr repo &&
> -		git init repo &&
> +		git init $repo &&
>  		(
> -			cd repo &&
> +			cd $repo &&
>  			test_commit_bulk 16 &&
>  			git tag old-tip &&
>
> @@ -154,7 +154,7 @@ bitmap_reuse_tests() {
>
>  	test_expect_success "build bitmap from existing ($from -> $to)" '
>  		(
> -			cd repo &&
> +			cd $repo &&
>  			test_commit_bulk --id=3Dfurther 16 &&
>  			git tag new-tip &&
>
> @@ -170,7 +170,7 @@ bitmap_reuse_tests() {
>
>  	test_expect_success "verify resulting bitmaps ($from -> $to)" '
>  		(
> -			cd repo &&
> +			cd $repo &&
>  			git for-each-ref &&
>  			git rev-list --test-bitmap refs/tags/old-tip &&
>  			git rev-list --test-bitmap refs/tags/new-tip
> @@ -183,7 +183,6 @@ bitmap_reuse_tests 'MIDX' 'pack'
>  bitmap_reuse_tests 'MIDX' 'MIDX'
>
>  test_expect_success 'missing object closure fails gracefully' '
> -	rm -fr repo &&
>  	git init repo &&
>  	test_when_finished "rm -fr repo" &&
>  	(
> @@ -217,7 +216,6 @@ test_expect_success 'setup partial bitmaps' '
>  basic_bitmap_tests HEAD~
>
>  test_expect_success 'removing a MIDX clears stale bitmaps' '
> -	rm -fr repo &&
>  	git init repo &&
>  	test_when_finished "rm -fr repo" &&
>  	(
> @@ -284,7 +282,6 @@ test_expect_success 'pack.preferBitmapTips' '
>  '
>
>  test_expect_success 'hash-cache values are propagated from pack bitmaps'=
 '
> -	rm -fr repo &&
>  	git init repo &&
>  	test_when_finished "rm -fr repo" &&
>  	(

