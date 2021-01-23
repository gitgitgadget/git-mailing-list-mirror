Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7375C433E6
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 03:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9955E23B26
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 03:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbhAWDr4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 22:47:56 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59269 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbhAWDrc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 22:47:32 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 769CE112611;
        Fri, 22 Jan 2021 22:46:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3IEPje5yn3o2
        26ekw6zKWcUclWE=; b=GrsgbnoCBYQgljJpm5Mcfx5cijRfU3Tk7pAZjWQi6Mul
        jh2jEc+cQHQYwLRyV0Aqa/O0gK1rwI+Ll7mRSUy6RoaI0SnwA7TByhLWCWGvS13n
        llVHfMSwONCDi9tEur36lsG8/9xfmT2+eFBn2AIs2dgMZ/3Ydwu0BS+O69bV3/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=kFsN8r
        3TwWTyTuIgurE6RVIQJrEkjxjFfjr/8JVEHbgtlWbF+Qa+uF0N1WhFiwMeAsh96J
        KJuG3ZnQdEobY6mOzqx6LIcKWIDzPX3c7AFyGa2eB5JL9KAo4Df+Ck8SSRog1qHk
        0bbdyF2ubikp2zjoI/BoHEpU4ORZqnp48ApbA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6EF14112610;
        Fri, 22 Jan 2021 22:46:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B7AB611260F;
        Fri, 22 Jan 2021 22:46:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 11/11] tests: add a "set -o pipefail" for a patched bash
References: <20210114233515.31298-1-avarab@gmail.com>
        <20210116153554.12604-12-avarab@gmail.com>
Date:   Fri, 22 Jan 2021 19:46:43 -0800
In-Reply-To: <20210116153554.12604-12-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 16 Jan 2021 16:35:54 +0100")
Message-ID: <xmqq5z3o5n8c.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9D3A5830-5D2D-11EB-B823-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> -test_expect_success !MINGW 'a constipated git dies with SIGPIPE' '
> +test_expect_success !MINGW,!BASH_SET_O_PIPEFAIL 'a constipated git die=
s with SIGPIPE' '
>  	OUT=3D$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
>  	test_match_signal 13 "$OUT"
>  '
> =20
> -test_expect_success !MINGW 'a constipated git dies with SIGPIPE even i=
f parent ignores it' '
> +test_expect_success !MINGW,!BASH_SET_O_PIPEFAIL 'a constipated git die=
s with SIGPIPE even if parent ignores it' '
>  	OUT=3D$( ((trap "" PIPE; large_git; echo $? 1>&3) | :) 3>&1 ) &&
>  	test_match_signal 13 "$OUT"
>  '

The above have already !MINGW

> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
> index 4f7e62d05c..7b5d92add5 100755
> --- a/t/t3600-rm.sh
> +++ b/t/t3600-rm.sh
> @@ -251,7 +251,10 @@ test_expect_success 'choking "git rm" should not l=
et it die with cruft' '
>  		i=3D$(( $i + 1 ))
>  	done | git update-index --index-info &&
>  	OUT=3D$( ((trap "" PIPE; git rm -n "some-file-*"; echo $? 1>&3) | :) =
3>&1 ) &&
> -	test_match_signal 13 "$OUT" &&
> +	if ! test_have_prereq BASH_SET_O_PIPEFAIL
> +	then
> +		test_match_signal 13 "$OUT"
> +	fi &&
>  	test_path_is_missing .git/index.lock
>  '

but this one does not.  Yet, we've been using test_match_signal on 13
without issues, it appears.

And somehow with the lazy prereq on SET_O_PIPEFAIL, this part starts
to break, like so:

  https://github.com/git/git/runs/1752687552?check_suite_focus=3Dtrue#ste=
p:7:37042

The output captured in OUT is 0 as we can see on #37032 in the test
log.

I am tempted to eject 11/11 and probably 10/11 out of the topic, as
the earlier patches before them look more or less uncontroversial
cleanups, and 11/11 seems to be more trouble than it is worth at
this moment.

It's not like this would allow us to loosen the rule that we
shouldn't put a "git" invocation of the git subcommand being tested
on the upstream side of a pipe---not everybody is running bash, and
it is unrealistic to tell our developers "if you want to make sure
your tests are good, you must install and use this patched bash".

Thanks.
