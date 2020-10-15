Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24F2C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 16:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DB1C22255
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 16:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jg76dhqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389725AbgJOQnW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 12:43:22 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53823 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388946AbgJOQnW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 12:43:22 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 43999F6363;
        Thu, 15 Oct 2020 12:43:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=L/rbIubeEKXK
        jRisuROM/Ofzq1Y=; b=Jg76dhqvnb7M4eg7BWpV/3fmDGdfrvLilTZyCBUrZOFb
        oRraS2oUTD8ETsQ7Typw5H2ShKZLYpmatQQ34JxTRWm6lTEmKUaxSlFHd+UFSB6C
        qHdO5sehqhJRukPro1nJKcr8DURvDOTAEl2J7ibAXwgQWZLlfieRzElZJ3VEP+g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Mgjoe3
        K9ILH2xsb5iIbqZtn0erjGX+drZGmwvI7Yq6hbBRdaxu3mFV56zkUG7533S/FFuh
        VmayH4MaRD7YP1uAkqccEYxTp1vuFJKqigfEBa9f+YrMyxzhqHCun0qHPRjry2IM
        BK+uuUrvOTPwqpDypjjt8eaKhWO3wav4PYJr4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3C496F6362;
        Thu, 15 Oct 2020 12:43:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 86B59F6361;
        Thu, 15 Oct 2020 12:43:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel =?utf-8?Q?=C4=8Cavoj?= <samuel@cavoj.net>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 1/3] t3435: use `test_config` instead of `git config`
References: <20201013213021.3671432-1-samuel@cavoj.net>
Date:   Thu, 15 Oct 2020 09:43:15 -0700
In-Reply-To: <20201013213021.3671432-1-samuel@cavoj.net> ("Samuel
 =?utf-8?Q?=C4=8Cavoj=22's?=
        message of "Tue, 13 Oct 2020 23:30:22 +0200")
Message-ID: <xmqqlfg7h23g.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 86CBA4DA-0F05-11EB-9C1B-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel =C4=8Cavoj <samuel@cavoj.net> writes:

> Replace usages of `git config` with `test_config` in t3435 to prevent
> side-effects between tests.
>
> Signed-off-by: Samuel =C4=8Cavoj <samuel@cavoj.net>
> ---
> changed v2 -> v3:
>     - added this patch
> ---
>  t/t3435-rebase-gpg-sign.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

As I already said, I think this is not needed.

The way the existing tests protect themselves from what previously
happened is to explicitly set up _their_ expectation in them before
running the part that is affected by the configuration setting,
which is an approach that is easy to read and understand because it
is explicit in what these tests care about.

> diff --git a/t/t3435-rebase-gpg-sign.sh b/t/t3435-rebase-gpg-sign.sh
> index b47c59c190..696cb6b6a4 100755
> --- a/t/t3435-rebase-gpg-sign.sh
> +++ b/t/t3435-rebase-gpg-sign.sh
> @@ -27,7 +27,7 @@ test_rebase_gpg_sign () {
>  	shift
>  	test_expect_success "rebase $* with commit.gpgsign=3D$conf $will sign=
 commit" "
>  		git reset two &&
> -		git config commit.gpgsign $conf &&
> +		test_config commit.gpgsign $conf &&
>  		set_fake_editor &&
>  		FAKE_LINES=3D'r 1 p 2' git rebase --force-rebase --root $* &&
>  		$must_fail git verify-commit HEAD^ &&

These are the first three uses of this test helper.

    test_rebase_gpg_sign ! false
    test_rebase_gpg_sign   true
    test_rebase_gpg_sign ! true  --no-gpg-sign

Examine what this patch does to the second test that is run by the
second invocation of test_rebase_gpg_sign, for example.  Before this
patch, "git config" that was done by the first test is left and
commit.gpgsign was set to 'false' when the second test started.
With this patch, it is removed by the clean-up action set by
test_config, so the second test starts without the configuration.

But this patch does *not* affect correctness of the second invocation.
Why?

Because the way these tests protect themselves is NOT based on the
"I muck with configuration, so I'll clean them up for the next
person" attitude which is made easy to do with test_config ANYWAY.
The correctness of the second test still relies on the fact that it
itself tweaks the variable it cares about to the state it wants it
to be.

So in this particular test script, where all test pieces are about
checking their behaviour on different setting of commit.gpgsign, use
of test_config does not buy us anything other than extra clean-up
after each test that is unnecessary.

Where test_config shines is when only a few (or a single) test cares
about different setting of a variable, and all later tests want to
test the behaviour under the default setting.  Among 47 tests, the
second and 42nd tests may want to test with commit.gpgsign set to
true, while the remainder may want to test without the variable at
all.  In such a case, it is easier to declare that the normal state
in that test script is not to have the configuration, and use
test_config in these selected tests to tentatively set it and remove
it after the tests are done.

But that rationale does not apply to this script.  It seems that
each test piece wants to be in control of and be tested under
specific setting of the variable.

> @@ -63,7 +63,7 @@ test_rebase_gpg_sign   false -i --no-gpg-sign --gpg-s=
ign
> =20
>  test_expect_failure 'rebase -p --no-gpg-sign override commit.gpgsign' =
'
>  	git reset --hard merged &&
> -	git config commit.gpgsign true &&
> +	test_config commit.gpgsign true &&
>  	git rebase -p --no-gpg-sign --onto=3Done fork-point master &&
>  	test_must_fail git verify-commit HEAD
>  '
