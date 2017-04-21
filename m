Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AAB2207BD
	for <e@80x24.org>; Fri, 21 Apr 2017 02:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034759AbdDUCpC (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 22:45:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53530 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1034756AbdDUCpA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 22:45:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 419697FD77;
        Thu, 20 Apr 2017 22:44:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DKJuW0LeReGj
        72KbDVM/+XGU2BY=; b=rXyPa9lwhfbYrWOSZVFjnOg504PEfqQYjQa754MeDCdX
        UNZULTiLqw27c7CabQaY5Olkg2/NfxjSausrOWiyq+lJbwkayq3/QxNb+3JtTJqx
        cCQ+bO0ne4QSvOG6nu/ffpabTHQxKngMBHxuBIocwb+Naw8UNmJH0FjFaMlMWm8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=oueUC+
        HSp7v5mLMf0g9wqjf109usXORq+1csSVqfpRinAy2cK9ZoHLUsx6xQu+mqrXjdcd
        0qmiIv0u+wexmbPQuXkmJL+aLBKgeQRNW9Xya07OD3nzpOZB6fIKBtYasEcxqrsk
        jWrB1TpJZc6QghjjQFD2gJcHHU1+d9oJA3SJs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A7337FD76;
        Thu, 20 Apr 2017 22:44:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 764AC7FD74;
        Thu, 20 Apr 2017 22:44:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/6] worktree move: accept destination as directory
References: <20170420101024.7593-1-pclouds@gmail.com>
        <20170420101024.7593-5-pclouds@gmail.com>
Date:   Thu, 20 Apr 2017 19:44:57 -0700
In-Reply-To: <20170420101024.7593-5-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Thu, 20 Apr 2017 17:10:22 +0700")
Message-ID: <xmqqzifa5viu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 825AD20A-263C-11E7-B1AC-C260AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Similar to "mv a b/", which is actually "mv a b/a", we extract basename
> of source worktree and create a directory of the same name at
> destination if dst path is a directory.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> ---
>  builtin/worktree.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index e3fbfe2a71..116507e47e 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -540,7 +540,13 @@ static int move_worktree(int ac, const char **av, =
const char *prefix)
>  		usage_with_options(worktree_usage, options);
> =20
>  	strbuf_addstr(&dst, prefix_filename(prefix, av[1]));
> -	if (file_exists(dst.buf))
> +	if (is_directory(dst.buf))
> +		/*
> +		 * keep going, dst will be appended after we get the
> +		 * source's absolute path
> +		 */
> +		;

Ugly.  Why not do that "infer the real destination b/a when existing
directory b/ was given" here, without "else if" so that we can catch
"hey, b/a exists already" with the existing code?  That way you do
not have to do is_directory() twice.

For that matter, perhaps we should go back to 3/6 and move the "if
dst.buf exists error out" to after wt is validated.  That would make
it stand out why having these is_directory() on the same thing twice
is ugly, I would think.

> +	else if (file_exists(dst.buf))
>  		die(_("target '%s' already exists"), av[1]);
> =20
>  	worktrees =3D get_worktrees(0);
> @@ -558,6 +564,17 @@ static int move_worktree(int ac, const char **av, =
const char *prefix)
>  	if (validate_worktree(wt, 0))
>  		return -1;
> =20
> +	if (is_directory(dst.buf)) {
> +		const char *sep =3D find_last_dir_sep(wt->path);
> +
> +		if (!sep)
> +			die(_("could not figure out destination name from '%s'"),
> +			    wt->path);
> +		strbuf_addstr(&dst, sep);
> +		if (file_exists(dst.buf))
> +			die(_("target '%s' already exists"), dst.buf);
> +	}
> +
>  	if (rename(wt->path, dst.buf) =3D=3D -1)
>  		die_errno(_("failed to move '%s' to '%s'"), wt->path, dst.buf);
