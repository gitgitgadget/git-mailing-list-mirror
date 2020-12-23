Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD88AC433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 03:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BAA120789
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 03:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbgLWDHD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 22:07:03 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59582 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbgLWCSz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 21:18:55 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E194A43C9;
        Tue, 22 Dec 2020 21:18:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yffaGOKDRuVD
        AE1hx6iF0ZxLo5s=; b=SeWVQc74TMEXoDu4ma/Lv//40ZxMM2kRr88U0PJXNZoZ
        t4k3ba2ZrdgdrdklwpfLZDhsxLW+WncygsODJiyy16YGOmwcg7gHc+mbfhUZ+CbS
        QdCD/q7EmUwbyqFcK+dy5HUBM9+RBeUV3kXOP8zHpgHfvhrfDf8n7T6vw1aoieI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=wjM0lu
        KlAitbp5fwMUiAVhR2mFr9t04o/kma5Nnw2AUZUYAqMWwUtmW3XQbgbJdsXi4034
        +ZRlap7N3YEsQRwyzNyeKSCf7KCvuQk7hSsooXCylFyIyU5Hv9RwdfIAeJmW60Md
        9hg9F6wjmN28upIYqGuK4xSeIezugPZ9hF6I0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 93E01A43C8;
        Tue, 22 Dec 2020 21:18:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1A8EAA43C7;
        Tue, 22 Dec 2020 21:18:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 08/20] mktag tests: don't create "mytag" twice
References: <20201209200140.29425-1-avarab@gmail.com>
        <20201223013606.7972-9-avarab@gmail.com>
Date:   Tue, 22 Dec 2020 18:18:12 -0800
In-Reply-To: <20201223013606.7972-9-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 23 Dec 2020 02:35:53 +0100")
Message-ID: <xmqqlfdpe04b.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1BD78676-44C5-11EB-A9CB-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change a test added in e0aaf781f6 (mktag.c: improve verification of
> tagger field and tests, 2008-03-27) to not create "mytag", which
> should only be created and verified at the end in an earlier test
> added in 446c6faec6 (New tests and en-passant modifications to mktag.,
> 2006-07-29).

If mktag fails to create a tag, presumably .git/refs/tags/mytag file
would be left empty.  Wouldn't "git tag -l" notice that it is not a
valid ref and omit it from its output?  I suspect if you corrupt the
contents of tag.sig temporarily while the first of the original
tests were running in such a way that mktag notices a bogosity, the
second half of the original would notice.

Having said that, I like the new way much better.

But do we even need to create the tag with update-ref in the first
place?  What does it check?  The fact that "mktag" only creates an
object and never creates a new ref to point at the newly created
object (hence we expect refs/tags/mytag does not yet exist)?

I am not complaining that it runs update-ref there or creates the
mytag tag.  I am just saying I do not understand what the test wants
to check by doing so.

> While we're at it let's prevent a similar logic error from creeping
> into the test by asserting that "mytag" doesn't exist before we create
> it. Let's do this by moving the test to use "update-ref", instead of
> our own homebrew ad-hoc refstore update.

Great.  I really like this part of the change that future-proofs us.

Thanks.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t3800-mktag.sh | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
> index bbd148618e..b6dcdbebe6 100755
> --- a/t/t3800-mktag.sh
> +++ b/t/t3800-mktag.sh
> @@ -257,7 +257,7 @@ EOF
> =20
>  test_expect_success \
>      'allow empty tag email' \
> -    'git mktag <tag.sig >.git/refs/tags/mytag'
> +    'git mktag <tag.sig'
> =20
>  ############################################################
>  # 16. disallow spaces in tag email
> @@ -383,16 +383,9 @@ tagger T A Gger <tagger@example.com> 1206478233 -0=
500
> =20
>  EOF
> =20
> -test_expect_success \
> -    'create valid tag' \
> -    'git mktag <tag.sig >.git/refs/tags/mytag'
> -
> -############################################################
> -# 25. check mytag
> -
> -test_expect_success \
> -    'check mytag' \
> -    'git tag -l | grep mytag'
> -
> +test_expect_success 'create valid tag' '
> +	git mktag <tag.sig >hash &&
> +	git update-ref refs/tags/mytag $(cat hash) $(test_oid zero)
> +'
> =20
>  test_done
