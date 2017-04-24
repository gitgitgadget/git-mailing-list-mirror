Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACD96207BD
	for <e@80x24.org>; Mon, 24 Apr 2017 01:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163925AbdDXBQM (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 21:16:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59154 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1163923AbdDXBQK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2017 21:16:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 50B7E7C942;
        Sun, 23 Apr 2017 21:15:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jPouS/ekBSnq
        cViWU1xcTvKWVmM=; b=OYVyOy3Qe0H2RjLRcShAbZTrW6qek5Q7zqU2CNP857Eo
        bGzpL0ZDGfeFEr+jSn+f3mFTdMyQ/TaVqlN3vI3/HuxgmCGZt7ENzrKnl3cNAQdM
        8zwi+GItVIZVST+LvzvFmSY9/19P/+HQsLlD3S0r/JhU5MrRuDds5Cw/qcMu6pY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=YNyRVl
        1li/EIPCF9bP3N6oTgEWU7tJumejG2EqfbQNC8gHGv6aPtE9j4EoMYzuf9DK3F7d
        0vPxaep8b0T+Z4abQsRC2yONpTvm0QoXRy/SDDBVSra6Qkb+ueSDIaDteoGYyNaq
        cRC5N2zeXz5nCDe0O+IwqgjXSqvX4rUGIQ/x4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B52C7C941;
        Sun, 23 Apr 2017 21:15:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 956947C940;
        Sun, 23 Apr 2017 21:15:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Michael J Gruber <git@grubix.eu>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] tests: fix tests broken under GETTEXT_POISON=YesPlease
References: <FDAE86E2-F607-4E82-8E0C-0E6DCEF7ED67@gmail.com>
        <20170421185757.28978-1-avarab@gmail.com>
Date:   Sun, 23 Apr 2017 18:15:57 -0700
In-Reply-To: <20170421185757.28978-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 21 Apr 2017 18:57:57 +0000")
Message-ID: <xmqq1ssi4nci.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 92C87EB6-288B-11E7-8D43-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The GETTEXT_POISON=3DYesPlease compile-time testing option added in my
> bb946bba76 ("i18n: add GETTEXT_POISON to simulate unfriendly
> translator", 2011-02-22) has been slowly bitrotting as strings have
> been marked for translation, and new tests have been added without
> running it.
>
> I brought this up on the list ("[BUG] test suite broken with
> GETTEXT_POISON=3DYesPlease", [1]) asking whether this mode was useful a=
t
> all anymore. At least one person occasionally uses it, and Lars
> Schneider offered to change one of the the Travis builds to run in
> this mode, so fix up the failing ones.
>
> My test setup runs most of the tests, with the notable exception of
> skipping all the p4 tests, so it's possible that there's still some
> lurking regressions I haven't fixed.
>
> 1. <CACBZZX62+acvi1dpkknadTL827mtCm_QesGSZ=3D6+UnyeMpg8+Q@mail.gmail.co=
m>

To be honest, I feel quite uneasy about this patch.  It is no
brainer to take fixes like the one to 1309 where we used grep on a
localizable string to use test_i18ngrep instead---they are obviously
good changes.

But changes that skip tests with !GETTEXT_POISON look suspicious.

> diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
> index 8937e25e49..2003ec7907 100755
> --- a/t/t1430-bad-ref-name.sh
> +++ b/t/t1430-bad-ref-name.sh
> @@ -122,7 +122,7 @@ test_expect_success 'push cannot create a badly nam=
ed ref' '
>  	! grep -e "broken\.\.\.ref" output
>  '
> =20
> -test_expect_failure 'push --mirror can delete badly named ref' '
> +test_expect_failure !GETTEXT_POISON 'push --mirror can delete badly na=
med ref' '
>  	top=3D$(pwd) &&
>  	git init src &&
>  	git init dest &&

This test affects only src and dest repositories that does not seem
to be looked at by later tests, so skipping it is presumably safe.

I am guessing that the reason why this is skipped is because the
error message is looked at with "! grep ", not "grep", but by
skipping the entire test, we are not checking that "push" succeeds
(which should happen regardless of the locale).

It also is VERY curious that the test before this one (whose tail is
visible in the pre-context) does not need to be skipped.  Is that
because we can expect "broken...ref", which is litrally a part of a
refname, would be emitted intact in any locale (including the
poisoned one)?  If that is the case it is curous why this one needs
to be skipped.

> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> index 5778c0afe1..a428ae6703 100755
> --- a/t/t3203-branch-output.sh
> +++ b/t/t3203-branch-output.sh
> @@ -236,7 +236,7 @@ test_expect_success 'git branch --format option' '
>  	Refname is refs/heads/ref-to-remote
>  	EOF
>  	git branch --format=3D"Refname is %(refname)" >actual &&
> -	test_cmp expect actual
> +	test_i18ncmp expect actual
>  '

This is a strange change.  Filling the placeholder in a format
string "Refname is %(refname)" should be affeced by i18n???

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
.sh
> index 33d392ba11..e07d6d8cd2 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -366,7 +366,7 @@ test_expect_success 'verbose flag is heeded, even a=
fter --
> ...
> -test_expect_success 'multi-squash only fires up editor once' '
> +test_expect_success !GETTEXT_POISON 'multi-squash only fires up editor=
 once' '
>  	base=3D$(git rev-parse HEAD~4) &&
>  	set_fake_editor &&
>  	FAKE_COMMIT_AMEND=3D"ONCE" FAKE_LINES=3D"1 squash 2 squash 3 squash 4=
" \

This is also curious.  Is this because the poison locale does not substit=
ute
anything passed to format template and literal strings like ONCE and
the instructions do not reach the edited file?

 (skipping many changes, not because I find nothing to comment on them)

> diff --git a/t/t5316-pack-delta-depth.sh b/t/t5316-pack-delta-depth.sh
> index 37143ea0ac..2ed479b712 100755
> --- a/t/t5316-pack-delta-depth.sh
> +++ b/t/t5316-pack-delta-depth.sh
> @@ -82,12 +82,16 @@ test_expect_success 'packing produces a long delta'=
 '
>  	# Use --window=3D0 to make sure we are seeing reused deltas,
>  	# not computing a new long chain.
>  	pack=3D$(git pack-objects --all --window=3D0 </dev/null pack) &&
> -	test 9 =3D "$(max_chain pack-$pack.pack)"
> +	echo 9 >expect &&
> +	max_chain pack-$pack.pack >actual &&
> +	test_i18ncmp expect actual
>  '

This is also curious.  Why do we needto protect comparision with a
line whose contents is '9' from poison locale?  If the last one were
test_cmp I think this is a good change, by the way.

>  test_expect_success '--depth limits depth' '
>  	pack=3D$(git pack-objects --all --depth=3D5 </dev/null pack) &&
> -	test 5 =3D "$(max_chain pack-$pack.pack)"
> +	echo 5 >expect &&
> +	max_chain pack-$pack.pack >actual &&
> +	test_i18ncmp expect actual
>  '

Likewise.

