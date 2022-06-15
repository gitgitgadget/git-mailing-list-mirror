Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6995C433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 18:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245372AbiFOS3Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 14:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358479AbiFOS3W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 14:29:22 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB9F40E41
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 11:29:20 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 40C0912493B;
        Wed, 15 Jun 2022 14:29:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Hukm/MHfhFnV
        /c7mBc3KnFti1nG36v3mahKA35Rcda8=; b=rJRoN3w9HZd+tnqwrZgoNtDWkhPg
        o21JXjZLzxxBDSPtVz089Fqx7y/uouI+7V1FYEXb1tnnru/HO5kgiMYmjR3ViKod
        gKcpU/hSmuEhIKWYeIM9CLwJo+wLaUlgB9RWQvuDuxezpLUpil+vb09RgMqmYIzL
        +17etoDzHo8QbAo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 37FA812493A;
        Wed, 15 Jun 2022 14:29:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 83C41124939;
        Wed, 15 Jun 2022 14:29:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/1] tests: add LIBCURL prerequisite to tests needing
 libcurl
References: <cover-0.1-00000000000-20220615T103609Z-avarab@gmail.com>
        <patch-1.1-353c384d2b1-20220615T103609Z-avarab@gmail.com>
Date:   Wed, 15 Jun 2022 11:29:16 -0700
In-Reply-To: <patch-1.1-353c384d2b1-20220615T103609Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 15 Jun
 2022 12:36:32 +0200")
Message-ID: <xmqq35g5232b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1165F750-ECD9-11EC-A598-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The existing "CURL" prerequisite is only used in one place, and we
> should probably name it "CURL_PROGRAM",

True.  It probably wants to become a lazy prerequisite defined only
in that program.

> then rename "LIBCURL" to
> "CURL" as a follow-up, but for now (pre-v2.37.0) let's aim for the
> most minimal fix possible.

OK.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/lib-httpd.sh        | 2 +-
>  t/t5516-fetch-push.sh | 4 ++--
>  t/t5601-clone.sh      | 4 ++--
>  t/test-lib.sh         | 1 +
>  4 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
> index 782891908d7..1f6b9b08d1d 100644
> --- a/t/lib-httpd.sh
> +++ b/t/lib-httpd.sh
> @@ -29,7 +29,7 @@
>  # Copyright (c) 2008 Clemens Buchacher <drizzd@aon.at>
>  #
> =20
> -if test -n "$NO_CURL"
> +if ! test_have_prereq LIBCURL
>  then
>  	skip_all=3D'skipping test, git built without http support'
>  	test_done

This is not strictly needed in "the most minimal fix possible", is
it?  Just checking.

> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index dedca106a7a..c1220b2ed35 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1834,7 +1834,7 @@ test_expect_success 'refuse to push a hidden ref,=
 and make sure do not pollute t
>  	test_dir_is_empty testrepo/.git/objects/pack
>  '
> =20
> -test_expect_success 'fetch warns or fails when using username:password=
' '
> +test_expect_success LIBCURL 'fetch warns or fails when using username:=
password' '

This _is_ needed.

> -test_expect_success 'push warns or fails when using username:password'=
 '
> +test_expect_success LIBCURL 'push warns or fails when using username:p=
assword' '

So is this.

> -test_expect_success 'clone warns or fails when using username:password=
' '
> +test_expect_success LIBCURL 'clone warns or fails when using username:=
password' '

And this too.

> -test_expect_success 'clone does not detect username:password when it i=
s https://username@domain:port/' '
> +test_expect_success LIBCURL 'clone does not detect username:password w=
hen it is https://username@domain:port/' '

And this too.

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 736c6447ecf..02bc88c72b4 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1572,6 +1572,7 @@ esac
>  test_set_prereq REFFILES
> =20
>  ( COLUMNS=3D1 && test $COLUMNS =3D 1 ) && test_set_prereq COLUMNS_CAN_=
BE_1
> +test -z "$NO_CURL" && test_set_prereq LIBCURL

And this, of course.

>  test -z "$NO_PERL" && test_set_prereq PERL
>  test -z "$NO_PTHREADS" && test_set_prereq PTHREADS
>  test -z "$NO_PYTHON" && test_set_prereq PYTHON
