Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2C0C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 21:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhLTVG0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 16:06:26 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61365 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhLTVGV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 16:06:21 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8B15F17A6AA;
        Mon, 20 Dec 2021 16:06:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Xx6TWBhX4yM4
        rrk+llbAz/aSrRfltNYSYzCprmIY9bs=; b=stn8UHW8u34/wECgaNtwuq+CyHU1
        /mJl/gevosIXSwgQfChdinNevAoxwcug9gCvmJ7eRlSUc4S6ccvxBSHbp2w4BU3+
        zYQbaA5PzZxC0olNS5mv+FFoU8/UQs6H6s0Q0Y74U8O6qFFgIP9SsyeisJ3KbszI
        lAgojynjNTn49s0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 83E9117A6A9;
        Mon, 20 Dec 2021 16:06:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E01A417A6A8;
        Mon, 20 Dec 2021 16:06:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH RESEND] t/perf: do not run tests in user's $SHELL
References: <f22f978a-26eb-8fe9-cab4-3fd60df69635@web.de>
        <211220.86bl1bwkp9.gmgdl@evledraar.gmail.com>
        <20211220131121.mdxe7o6p3y25fzbw@gmail.com>
Date:   Mon, 20 Dec 2021 13:06:15 -0800
In-Reply-To: <20211220131121.mdxe7o6p3y25fzbw@gmail.com> (Johannes
        Altmanninger's message of "Mon, 20 Dec 2021 14:11:21 +0100")
Message-ID: <xmqqilvjugu0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AC122C7E-61D8-11EC-9016-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Altmanninger <aclopte@gmail.com> writes:

> On Mon, Dec 20, 2021 at 12:56:58PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>>=20
>> On Mon, Dec 20 2021, Ren=C3=A9 Scharfe wrote:
>>=20
>> > From: Johannes Altmanninger <aclopte@gmail.com>
>> >
>> > The environment variable $SHELL is usually set to the user's
>> > interactive shell. We never use that shell for build and test script=
s
>> > because it might not be a POSIX shell.
>> >
>> > Perf tests are run inside $SHELL via a wrapper defined in
>> > t/perf/perf-lib.sh. Use $TEST_SHELL_PATH like elsewhere.
>> >
>> > Signed-off-by: Johannes Altmanninger <aclopte@gmail.com>
>> > Acked-by: Jeff King <peff@peff.net>
>> > ---
>> > Original submission:
>> > https://lore.kernel.org/git/20211007184716.1187677-1-aclopte@gmail.c=
om/
>>=20
>> This LGTM & I think it could be picked up as-is.
>>=20
>> Just a nit in case af a re-roll. I think it would help to summarize th=
e
>> history a bit per
>> https://lore.kernel.org/git/YV+1%2F0b5bN3o6qRG@coredump.intra.peff.net=
/. I.e. something
>> like:
>>    =20
>>     In 342e9ef2d9e (Introduce a performance testing framework, 2012-02=
-17)
>>     when t/perf was introduced the TEST_SHELL_PATH was not part of
>>     GIT-BUILD-OPTIONS.
>
> (but SHELL_PATH was, which is what we should have used back then)
>
>>     That was added later in 3f824e91c84 (t/Makefile:
>>     introduce TEST_SHELL_PATH, 2017-12-08). We will always have that
>>     available in perf-lib.sh since test-lib.sh will load it before thi=
s code
>>     is executed.
>
> yes that's a good thing to point out

Care to redo the patch in a final form, then?

Thanks.

>
>>=20
>> >  t/perf/perf-lib.sh | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
>> > index 780a7402d5..407252bac7 100644
>> > --- a/t/perf/perf-lib.sh
>> > +++ b/t/perf/perf-lib.sh
>> > @@ -161,7 +161,7 @@ test_run_perf_ () {
>> >  	test_cleanup=3D:
>> >  	test_export_=3D"test_cleanup"
>> >  	export test_cleanup test_export_
>> > -	"$GTIME" -f "%E %U %S" -o test_time.$i "$SHELL" -c '
>> > +	"$GTIME" -f "%E %U %S" -o test_time.$i "$TEST_SHELL_PATH" -c '
>> >  . '"$TEST_DIRECTORY"/test-lib-functions.sh'
>> >  test_export () {
>> >  	test_export_=3D"$test_export_ $*"
>>=20
