Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B7BC433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 17:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239498AbhKWSCE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 13:02:04 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54043 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239024AbhKWSCE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 13:02:04 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A936CFCF28;
        Tue, 23 Nov 2021 12:58:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8PJd1VdiuIG2
        DEkhtdGJNBww9Q+nb3cg31KcqIn5Pak=; b=nyRF1wSVfQ+Vcoc+xx0cNIm8v3tC
        KfCJt8873SsshszuTAlp+sj7tDbbyo1oJrFZA7sMT4Ho0XL4fzvdbnsvQyPa24bd
        j5PeDV611YFs7SFvMIL87OJ3SHx6dC+hPLMuTZcCXBvOmtHlrcrQTl7xfZKpFJbZ
        KDYrChOE31wAeCg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A0A49FCF27;
        Tue, 23 Nov 2021 12:58:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 021B9FCF26;
        Tue, 23 Nov 2021 12:58:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] fixup??? Merge branch 'ab/ci-updates' into seen
References: <pull.1081.git.1637578930464.gitgitgadget@gmail.com>
        <211122.86ee78yxts.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2111222257430.63@tvgsbejvaqbjf.bet>
        <211123.8635nnydmm.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2111231215020.63@tvgsbejvaqbjf.bet>
        <211123.86ilwjujmd.gmgdl@evledraar.gmail.com>
Date:   Tue, 23 Nov 2021 09:58:53 -0800
In-Reply-To: <211123.86ilwjujmd.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 23 Nov 2021 13:18:09 +0100")
Message-ID: <xmqqo86a92jm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0637F3EE-4C87-11EC-A2E6-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I'm pointing out that your patch to "master" has a logic error where yo=
u
> added the scalar tests after that case/esac, but on "master" any new
> "make new-test" needs to be added thusly:
>
>     diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
>     index cc62616d806..37df8e2397a 100755
>     --- a/ci/run-build-and-tests.sh
>     +++ b/ci/run-build-and-tests.sh
>     @@ -34,21 +34,28 @@ linux-gcc)
> ...
>      *)
>             make test
>     +       make new-test
>             ;;
>      esac
>     +"and not here, as it would run under pedantic"
>     =20
>      check_unignored_build_artifacts
>     =20
> As a result if you look at your own CI run's "pedantic" job at
> https://github.com/gitgitgadget/git/runs/4292915519?check_suite_focus=3D=
true
> you'll see that it runs the scalar test, which is not the
> intention. That job should be compile-only job with the -pedantic flag.

I think the above shows that it is a bug in the topic itself, but
the presense of the ab/ci-updates topic makes the issue harder to
see.  It makes the problem manifest in quite a different way.  The
band-aid we saw from Dscho does "fix" the manifestation after two
topics get merged (i.e. scalar build or test must follow the primary
build and cannot be done by itself), without correcting the original
bug (i.e.  scalar test is done in a wrong CI job).

Also, when writing recipes for CI, if you know that scalar build or
test must be preceded by primary build, I wonder if it is with more
good manners to write

	make test
-	make -C scalar test
+	make && make -C scalar test

to make the dendency clear?  In addition, it would be courteous to
the fellow developers to make the public entry points like "all" and
"test" self contained.  The Makefile of scalar knows as well as, or
better than, the developers that going up to the top-level of the
working tree and running "make" is required before "all" target can
be built, so automating that would help everybody from the trouble,
and the silly ugliness of "make && make -C there" I suggested above.

I do not, for example, mind at all if something silly like this was
done in contrib/scalar/Makefile:

    all: ../../git
    ../../git:
	$(MAKE) -C ../..
    test: all
	...

which is with clearly broken dependencies (e.g. if you edit
revision.c, scalar will not be rebuilt or the change would not
affect scalar's tests), but for the purpose of "letting CI build and
test from scratch to smoke out problems early", it is good enough.

Perhaps =C3=86var's suggestions were a lot more perfectionist than what
pragmatic me would say, and didn't mesh well with the test of Dscho
who is even more pragmatic than me?  In a separate message, Dscho
talks about weeks of delay, but it does not look to me that it is
solely =C3=86var's fault.

We know we hope to be able to make scalar as part of the top-level
offering from the project someday, but before that, we should make
sure it is as good as it has been advertiesed so far, and by not
even being able to easily integrate "correctly" (i.e. in line with
the design of the surrounding code) with the CI, we are stumbling at
the first step.

Thanks, both.
