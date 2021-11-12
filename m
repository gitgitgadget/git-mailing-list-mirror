Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355C7C433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 17:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B93460F42
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 17:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbhKLRMM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 12:12:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53740 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbhKLRML (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 12:12:11 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EE8AEA95E;
        Fri, 12 Nov 2021 12:09:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=I5t6Yc8bUSht
        HLiBQDI0/d5gVXLaMpLV1VFxcngIjpY=; b=u5FOPKRG4KkiFeXkDzPSzwPMBQpR
        4Wl+h5koPiIr36RfvN6m9hnXDomuhhRClQDnfXovgajEZfZUeg1f105f8vJtQuw9
        vb0KFPOe8FXOwu1TsZn069SmGXUK+9pWMMz7c7EBlUDtrvmXRk4YEZAamSiVE90Y
        KR4v+wMm057h4yw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 05149EA95D;
        Fri, 12 Nov 2021 12:09:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 626BEEA95C;
        Fri, 12 Nov 2021 12:09:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 3/8] log tests: check if grep_config() is called by
 "log"-like cmds
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
        <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
        <patch-v2-3.8-41e38ebb32c-20211110T013632Z-avarab@gmail.com>
Date:   Fri, 12 Nov 2021 09:09:18 -0800
In-Reply-To: <patch-v2-3.8-41e38ebb32c-20211110T013632Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 10 Nov
 2021 02:43:45
        +0100")
Message-ID: <xmqqsfw1s3lt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4613C786-43DB-11EC-9E2C-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Extend the tests added in my 9df46763ef1 (log: add exhaustive tests
> for pattern style options & config, 2017-05-20) to check not only
> whether "git log" handles "grep.patternType", but also "git show"
> etc.
>
> It's sufficient to check whether a PCRE regex matches for the purposes
> of this test, we otherwise assume that it's running the same code as
> "git log", whose behavior is tested more exhaustively by test added in
> 9df46763ef1e.

I do agree with the reasoning that it is sufficient to check with
only one kind, but it is unclear if PCRE is so special and if so
why.  Wouldn't testing with, say grep.patternType=3Dextended, alone
also be sufficient?  The reason I am asking it is mostly because the
above description is insufficient to answer these questions, but
also because we can lose the prerequisite and gain a bit wider test
coverage, if we use a pattern that is not PCRE.

Knowing that "show", "whatchanged", "reflog", and "format-patch" all
share the same backend in builtin/log.c, I am not sure how much
value the new tests add.  Testing the "--grep-reflog" option and the
"git rev-list" command may exercise a bit different code path,
though.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t4202-log.sh | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 7884e3d46b3..a114c49ef27 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -449,6 +449,22 @@ test_expect_success !FAIL_PREREQS 'log with variou=
s grep.patternType configurati
>  	)
>  '
> =20
> +for cmd in show whatchanged reflog format-patch
> +do
> +	myarg=3D
> +	if test "$cmd" =3D "format-patch"
> +	then
> +		myarg=3D"HEAD~.."
> +	fi

I prefer to send the output that ought to contain the grep hits
consistently to "actual", i.e.

	case "$cmd" in
	format-patch) myarg=3D"--stdout -1" ;;
	*) myarg=3D ;;
	esac=09

instead of sending only the filenames.

I also prefer "case/esac" as it would be more concise when we need
to tweak myarg per command later.

> +	test_expect_success PCRE "$cmd: understands grep.patternType=3Dperl, =
like 'log'" '
> +		git -c grep.patternType=3Dfixed -C pattern-type $cmd --grep=3D"1(?=3D=
\|2)" $myarg >actual &&
> +		test_must_be_empty actual &&
> +		git -c grep.patternType=3Dperl -C pattern-type $cmd --grep=3D"1(?=3D=
\|2)" $myarg >actual &&
> +		test_file_not_empty actual
> +	'
> +done
> +
>  test_expect_success 'log --author' '
>  	cat >expect <<-\EOF &&
>  	Author: <BOLD;RED>A U<RESET> Thor <author@example.com>

Thanks.
