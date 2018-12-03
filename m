Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 478DC211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 01:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbeLCB31 (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Dec 2018 20:29:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56045 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbeLCB31 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 20:29:27 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 946B912B92A;
        Sun,  2 Dec 2018 20:29:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=j8IFMbLkb1N2
        C/N+Ifq/8Ot9YO4=; b=t2U5JZ6/p0RkOMpMj75c+LyLGlD0VRNBbCnD6DHyLADF
        pY2a8QfZkX1HoV2t5k/3WSd4raath3iMKrpsA1miLzl263opmS3LvakuW0CqLCcv
        LiFUxgSYHDeUAfP5FEnrtWYxdy1p4acxAiSnwqJUqgpRk2KYkn4hGHu0CpsxVWo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=hysrmj
        nzr8u0Z6b3RqmdZzcrGkPMU8dla7uE4vFdIJcM2O7dkgdb7fO7YIIfU/K8iHxb3x
        JLMrgWJn3GkGMEND8eiuJzeBkXrZ075KCikWgYtAF6T4vWPF45JPbHOeq25QPksK
        GJyBYPYWW+OIPH03aAgDoOoFh7T1jlOMIEZqE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8E62A12B929;
        Sun,  2 Dec 2018 20:29:23 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0F1B812B928;
        Sun,  2 Dec 2018 20:29:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t5004: avoid using tar for empty packages
References: <20181202024003.65103-1-carenas@gmail.com>
Date:   Mon, 03 Dec 2018 10:29:21 +0900
In-Reply-To: <20181202024003.65103-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sat, 1 Dec 2018 18:40:03 -0800")
Message-ID: <xmqqh8fvgzym.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DD2A1C24-F69A-11E8-B6B4-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> ea2d20d4c2 ("t5004: avoid using tar for checking emptiness of archive",
> 2013-05-09), introduced a fake empty tar archive to allow for portable
> tests of emptiness without having to invoke tar
>
> 4318094047 ("archive: don't add empty directories to archives", 2017-09=
-13)
> changed the expected result for its tests from one containing an empty
> directory to a plain empty archive but the portable test wasn't updated
> resulting on them failing again in (at least) NetBSD and OpenBSD
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  t/t5004-archive-corner-cases.sh | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-c=
ases.sh
> index ced44355ca..271eb5a1fd 100755
> --- a/t/t5004-archive-corner-cases.sh
> +++ b/t/t5004-archive-corner-cases.sh
> @@ -3,8 +3,12 @@
>  test_description=3D'test corner cases of git-archive'
>  . ./test-lib.sh
> =20
> -test_expect_success 'create commit with empty tree' '
> -	git commit --allow-empty -m foo
> +# the 10knuls.tar file is used to test for an empty git generated tar
> +# without having to invoke tar because an otherwise valid empty GNU ta=
r
> +# will be considered broken by {Open,Net}BSD tar
> +test_expect_success 'create commit with empty tree and fake empty tar'=
 '
> +	git commit --allow-empty -m foo &&
> +	perl -e "print \"\\0\" x 10240" >10knuls.tar
>  '

OK, so you moved the creation of the file with block of NULs to the
set-up phase of the entire script.

>  # Make a dir and clean it up afterwards
> @@ -47,7 +51,6 @@ test_expect_success HEADER_ONLY_TAR_OK 'tar archive o=
f commit with empty tree' '
> =20
>  test_expect_success 'tar archive of empty tree is empty' '
>  	git archive --format=3Dtar HEAD: >empty.tar &&
> -	perl -e "print \"\\0\" x 10240" >10knuls.tar &&
>  	test_cmp_bin 10knuls.tar empty.tar
>  '

And because of that, this one that was added for ea2d20d4 ("t5004:
avoid using tar for checking emptiness of archive", 2013-05-09) is
now simplified.  It can use the one that was created in the set-up
phase.

> @@ -106,16 +109,12 @@ test_expect_success 'create a commit with an empt=
y subtree' '
> =20
>  test_expect_success 'archive empty subtree with no pathspec' '
>  	git archive --format=3Dtar $root_tree >subtree-all.tar &&
> -	make_dir extract &&
> -	"$TAR" xf subtree-all.tar -C extract &&
> -	check_dir extract
> +	test_cmp_bin 10knuls.tar subtree-all.tar
>  '

And then we avoid the test that assumes that an empty tar archive
can safely and portably extracted, and instead check the emptiness
the same way as the earlier test here ...

>  test_expect_success 'archive empty subtree by direct pathspec' '
>  	git archive --format=3Dtar $root_tree -- sub >subtree-path.tar &&
> -	make_dir extract &&
> -	"$TAR" xf subtree-path.tar -C extract &&
> -	check_dir extract
> +	test_cmp_bin 10knuls.tar subtree-path.tar
>  '

... and here, too.

OK, and the result is consistent with the "We can help GNU and BSD
tar, but NetBSD tar cannot be salvageable" approach, laid out in the
earlier ea2d20d4 ("t5004: avoid using tar for checking emptiness of
archive", 2013-05-09).  Makes sense.

Thanks.
