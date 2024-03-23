Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD54717583
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711217223; cv=none; b=mILLErhpWcBv9PCTpbg3PBupk3M9vopuGzX2DcJQeBWY91ZFxNDiElb8V+5shGV/v48vkZOiB8q72caTMPGNLD9ElQmS46bfUKSuURG0N3mInOC6Ixv6XK00r+bTFqQxXvtlfWIIXfPBmaXAO4QwAQTK+hMvdpjNVGMOAXmkFRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711217223; c=relaxed/simple;
	bh=AfzwBdUonYzLnkC6xYnGFGkjEUx4LC/guXVtuHotSFY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fS3g1hUEdTQO0nMtnBEgUagEjGVKV+w2M1EiYsguJ4asnCkpMtQaYKku4kX6zGbeM6HxVRbpu4/IAM6fR5BECN6wMkVopIzkWSEtiMeTqQyTxAtgwqwzfCKnX62+aAe/u16W/m2x5lfDLqtSF3Jd3eqR6jmQ/O0Fz8HirODZC5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bc0GnuVn; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bc0GnuVn"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E3DC1D4E62;
	Sat, 23 Mar 2024 14:06:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AfzwBdUonYzL
	nkC6xYnGFGkjEUx4LC/guXVtuHotSFY=; b=bc0GnuVngDXbVSoDAmlRN29wjIDx
	xNmaHxj+iYZ/oYf7tnCZ+awyD9rmOoY2PL5LVFi1iRhaSR+J8B8EjlnM8CuIbPkB
	eXBHO7zekaxJNq7bjh4Hul3nC3wsr6UVgihcDPiXuulPSpIMUI5GhexzV6Amn5hX
	JYornkXbSzhHCNU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 86F341D4E61;
	Sat, 23 Mar 2024 14:06:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EF99F1D4E60;
	Sat, 23 Mar 2024 14:06:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: git@vger.kernel.org,  Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v2] grep: improve errors for unmatched ( and )
In-Reply-To: <tkz3a5jkalcz5ajemx4b4x42pe6kv45sfmgpin4zeai3moq42o@tarta.nabijaczleweli.xyz>
	("Ahelenia =?utf-8?Q?Ziemia=C5=84ska=22's?= message of "Sat, 23 Mar 2024
 14:18:08 +0100")
References: <xmqq34si2p8b.fsf@gitster.g>
	<tkz3a5jkalcz5ajemx4b4x42pe6kv45sfmgpin4zeai3moq42o@tarta.nabijaczleweli.xyz>
Date: Sat, 23 Mar 2024 11:06:53 -0700
Message-ID: <xmqqzfuox1oi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 21D6FBBA-E940-11EE-A491-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz> writes:

> Imagine you want to grep for (. Easy:
>
>   $ git grep '('
>   fatal: unmatched parenthesis
>
> uhoh. This is plainly wrong. Unless you know specifically that
> (a) git grep has expression groups and that
> (b) the only way to work around them is by doing -- '(' or -e '('
>
> Similarly,
>
>   $ git grep ')'
>   fatal: incomplete pattern expression: )
>
> is somehow worse. ")" is a complete regular expression pattern.
> Of course, the error wants to say "group" here.
> In this case it's also not "incomplete", it's unmatched.
> But whatever.
>
> Make them return
>
>   $ ./git grep '('
>   fatal: unmatched ( for expression group
>   $ ./git grep ')'
>   fatal: incomplete pattern expression group: )
>
> which hopefully are clearer in indicating that it's not the expression
> that's wrong (since no pattern had been parsed at all), but rather that
> it's been misconstrued as a grouping operator.
>
> Link: https://bugs.debian.org/1051205
> Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.=
xyz>
> ---
> On Fri, Mar 22, 2024 at 09:41:40AM -0700, Junio C Hamano wrote:
>> Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz> writes:
>> > uhoh. This is plainly wrong. Unless you know specifically that
>> > (a) git grep has expression groups and that
>> > (b) the only way to work around them is by doing -- '(' or -e '('
>> I do not think "--" (end of options and beginning of pathspec)
>> marker would work for that purpose, UNLESS you are talking about a
>> file whose name is an open parenthesis.
> False. -- turns all subsequent parameters into arguments, and if
> there is no -e, the first argument is the pattern, and all the
> subsequent ones are paths. This is normal [git] grep behaviour.

Ah, thanks. =20

I forgot that "git grep" was a oddball that allows revs come after
"--" in some cases.  As long as the user understands this may not
work for other commands, it is OK.  "-e" is the only officially
supported way (which is why I mentioned it in the review comments I
gave you here), so guiding users in that direction would be a better
idea anyway, though.

Thanks.

> diff --git a/grep.c b/grep.c
> index 5f23d1a..ac34bfe 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -621,7 +621,7 @@ static struct grep_expr *compile_pattern_atom(struc=
t grep_pat **list)
>  		*list =3D p->next;
>  		x =3D compile_pattern_or(list);
>  		if (!*list || (*list)->token !=3D GREP_CLOSE_PAREN)
> -			die("unmatched parenthesis");
> +			die("unmatched ( for expression group");
>  		*list =3D (*list)->next;
>  		return x;
>  	default:
> @@ -792,7 +792,7 @@ void compile_grep_patterns(struct grep_opt *opt)
>  	if (p)
>  		opt->pattern_expression =3D compile_pattern_expr(&p);
>  	if (p)
> -		die("incomplete pattern expression: %s", p->pattern);
> +		die("incomplete pattern expression group: %s", p->pattern);
> =20
>  	if (opt->no_body_match && opt->pattern_expression)
>  		opt->pattern_expression =3D grep_not_expr(opt->pattern_expression);
