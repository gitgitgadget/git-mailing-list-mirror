Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39471C7DBCF
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1B02480B
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vdTVf1L+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbfLMS0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 13:26:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58971 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfLMS0O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 13:26:14 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F47122E80;
        Fri, 13 Dec 2019 13:26:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UKSF68mUveeREgbCbb4WdyC4j2w=; b=vdTVf1
        L+pvkgeS8yyNTFJKOaV+zZdHMZ5W3XomdV/0Y2hFgl3T1JX3dJp599qheNeHeiaC
        tBn0AMaklEp88qc7ICTaXLGYMbFZ7TgIYU0gPbFqjCicqDIZfaREJecDhLLS131P
        GQyZOIuYrLPOAzDKjLv8yT2MA4jyu/Fy4Dfbg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lXlvYoyP/dHCNiaRp1sWhrL/5qy3EIIg
        72SKe4AX/ASSXXdqESJGVm/DpxbtqMhnC/kV3pJGqzjm4Yo72buA5wegnlLKEuSL
        Hlsq9OdBQzsL3tSwsOsSOpH7FOL2jvdD4dS8z1IkRoO6KpF2xaoKykseHOTY0j8L
        v+6FbY+XAJ4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 44BD822E7F;
        Fri, 13 Dec 2019 13:26:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 99C1722E7A;
        Fri, 13 Dec 2019 13:26:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Denton Liu <liu.denton@gmail.com>,
        =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] grep: support the --pathspec-from-file option
References: <20191213041254.13202-1-emilyshaffer@google.com>
Date:   Fri, 13 Dec 2019 10:26:06 -0800
In-Reply-To: <20191213041254.13202-1-emilyshaffer@google.com> (Emily Shaffer's
        message of "Thu, 12 Dec 2019 20:12:54 -0800")
Message-ID: <xmqqpngskrpd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 07A1FB62-1DD6-11EA-A889-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Teach 'git grep' to use OPT_PATHSPEC_FROM_FILE and update the
> documentation accordingly.
>
> This changes enables 'git grep' to receive the pathspec from a file by
> specifying the path, or from stdin by specifying '-' as the path. This
> matches the previous functionality of '-f', so the documentation of '-f'
> has been expanded to describe this functionality. To let '-f' match the
> new '--pathspec-from-file' option, also teach a '--patterns-from-file'
> long name to '-f'.
>
> Since there are now two arguments which can attempt to read from stdin,
> add a safeguard to check whether the user specified '-' for both of
> them. It is still possible for a user to pass '/dev/stdin' to one or
> both arguments at present; we do not explicitly check.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> I built this on 'next' locally, but it does require 'am/pathspec-from-file'
> (which was merged to 'next').

Thanks.  I'd probably just queue on top of 'master' as the other
topic has graduated as part of the fifth batch.

> -static int file_callback(const struct option *opt, const char *arg, int unset)
> +static int read_pattern_file(struct grep_opt *grep_opt, const char *path)
>  {
> -	struct grep_opt *grep_opt = opt->value;
>  	int from_stdin;
>  	FILE *patterns;
>  	int lno = 0;
>  	struct strbuf sb = STRBUF_INIT;
>  
> -	BUG_ON_OPT_NEG(unset);
> -
> -	from_stdin = !strcmp(arg, "-");
> -	patterns = from_stdin ? stdin : fopen(arg, "r");
> +	from_stdin = !strcmp(path, "-");
> +	patterns = from_stdin ? stdin : fopen(path, "r");
>  	if (!patterns)
> -		die_errno(_("cannot open '%s'"), arg);
> +		die_errno(_("cannot open '%s'"), path);
>  	while (strbuf_getline(&sb, patterns) == 0) {
>  		/* ignore empty line like grep does */
>  		if (sb.len == 0)
>  			continue;
>  
> -		append_grep_pat(grep_opt, sb.buf, sb.len, arg, ++lno,
> +		append_grep_pat(grep_opt, sb.buf, sb.len, path, ++lno,
>  				GREP_PATTERN);
>  	}
>  	if (!from_stdin)

Hmph.  This has nothing to do with "--pathspec-from-file" that was
advertised on the title of the patch.  It used to be that

	git grep -f one -f two

can be used to read patterns from two sources, but that is no
longer possible, is it?  Am I missing a larger benefit to accept
this regression?

> +test_expect_success 'setup pathspecs-file tests' '
> +cat >excluded-file <<EOF &&
> +bar
> +EOF
> +cat >pathspec-file <<EOF &&
> +foo
> +bar
> +baz
> +EOF
> +cat >unrelated-file <<EOF &&
> +xyz
> +EOF
> +git add excluded-file pathspec-file unrelated-file
> +'

As Alexandr mentioned, the above is harder to read than necessary.


	test_expect_success 'setup pathspec-file tests' '
		test_write_lines >excluded-file bar &&
		test_write_lines >pathspec-file foo bar baz &&
		test_write_lines >unrelated-file xyz &&
		git add ...
	'

perhaps?

> +
> +cat >pathspecs <<EOF
> +pathspec-file
> +unrelated-file
> +EOF
> +
> +cat >expected <<EOF
> +pathspec-file:bar
> +EOF

Also, shouldn't the above also be part of the (sub)setup for these
tests?  IOW, after that addition of three files with "git add", 

		test_write_lines >pathspec pathspec-file unrelated-file &&
		test_write_lines >expect pathspec-file:bar

in the "setup pathspec-file tests".

> +test_expect_success 'grep --pathspec-from-file with file' '
> +	git grep --pathspec-from-file pathspecs "bar" >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'grep --pathspec-file with stdin' '
> +	git grep --pathspec-from-file - "bar" <pathspecs >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'grep with two stdin inputs fails' '
> +	test_must_fail git grep --pathspec-from-file - --patterns-from-file - <pathspecs 2>err &&
> +	test_i18ngrep "cannot specify both patterns and pathspec via stdin" err
> +'
> +
>  test_expect_success 'setup double-dash tests' '
>  cat >double-dash <<EOF &&
>  --
