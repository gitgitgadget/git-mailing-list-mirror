Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D339C4332B
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 21:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54C266023B
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 21:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241324AbhCAVqx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 16:46:53 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59763 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237989AbhCAVoS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 16:44:18 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9941CACB68;
        Mon,  1 Mar 2021 16:43:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=b6eW7j/ciaKYPIRIY8Isl3EkY
        ig=; b=aUJbBZVoOvrw2KCVN3owlpjBuuyupmW/hgGspgx+Zc0kxdosWAxAiX5NB
        WUrEDdGhrGTVlHQoaBMju1/+TfPgl4Pt7kRMo7/RPWlAsBUDoKskcAWgR2ngf7Ml
        zRnNsa6T4cpGfSKL6lEAGobfS94Xv/wIf3Tju79yZr3J713OuM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=tuqDTvnyvSqw9n2gBsn
        6VGkzku+qDWley4rcA+BhOG86g0W7CCeMaiGtdKg0ry4xskWae7IEZZ1HkgVG5UU
        cM09epJOCRaRSGGe3PRa0gPddO0URKjZ4n9nqCd6zbWTLtQtneMZxsK5336w1tVd
        C1Dj3jnsnpkyYXcRt80BKWuM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E45BACB67;
        Mon,  1 Mar 2021 16:43:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F83AACB66;
        Mon,  1 Mar 2021 16:43:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Benno Evers <benno@bmevers.de>, Jean Privat <jean@pryen.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 10/10] test-lib: return 1 from
 test_expect_{success,failure}
References: <20200223125102.6697-1-benno@bmevers.de>
        <20210228195414.21372-11-avarab@gmail.com>
Date:   Mon, 01 Mar 2021 13:43:27 -0800
Message-ID: <xmqqft1eo8hs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 28875D22-7AD7-11EB-80DB-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index c6cdabf53e..3dd68091bb 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -636,6 +636,7 @@ test_expect_failure () {
>  		fi
>  	fi
>  	test_finish_
> +	return 1
>  }
> =20
>  test_expect_success () {
> @@ -656,6 +657,7 @@ test_expect_success () {
>  		fi
>  	fi
>  	test_finish_
> +	return 1
>  }
> =20
>  # test_external runs external test scripts that provide continuous

Hmph.

This does not catch if the outer expect_success does not catch a
failure in the inner expect_success and signal a failure.

When I asked if this kind of breakage is an easy mistake to catch by
the test lint, I had something along this in mind:

	test_expect_success () {
		if test -n "$GIT_IN_TEST_EXPECT"
		then
			BUG caling "$GIT_IN_TEST_EXPECT" inside test_expect_success
		fi
		GIT_IN_TEST_EXPECT=3Dtest_expect_success

		... do the 'eval the given test body' thing ..

		GIT_IN_TEST_EXPECT=3D
	}

After all, the error is in the outer expect_success in that it
called another one, so it feels more natural that the called inner
expect_success to notice the situation and barf.

Thanks.
