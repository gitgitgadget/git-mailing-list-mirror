Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACE75674C
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711125707; cv=none; b=UVdojsRfvz3Aquu6IqrwxlzZMYNBqfCK/O8+COnc7QeufYouLRLY3nKrFqD+cc4y933nLB+E7DpCU4EPVuL6HyKRecoQ0OxtUXF3B7Ff0BAQQ+wm0RH1FRlr1GXuhBjvcNG72hgE5vdLMW0jQ8cLtEqrsJDy5mQGTFtz/CV81NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711125707; c=relaxed/simple;
	bh=QqCtIRHlr8BX/s07PzZ1I2FfoR7oohaF/3QFVu8H5xk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mL1ClmH9P7GZYXpmmpJL4f/E+j31Oh/kMVdPVX1lCRfdMDcIOT7n4OARk0CMNR6ykylqS3tFX7yLA2eK/WO/si2ddwiVuohAqhagCXtE8SnHMeqxJzMXoFPTpliDFnoBQsRc83Fz7CcBkrb+n9Qq39OdGHKtfnFrj0tHHWXEl6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=In5jgyWz; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="In5jgyWz"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4F250199A5;
	Fri, 22 Mar 2024 12:41:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QqCtIRHlr8BX
	/s07PzZ1I2FfoR7oohaF/3QFVu8H5xk=; b=In5jgyWznCkooIGtyPV6RpomG+Gt
	6sfWtFNa8R2KrxfMGkdV4vuZJNvgGWIQk58Jw+zl3CQ0J5+8TP81s1StRjLb9alf
	nsSThNfig1P6J+q0XK/Vtl3goWArGG3JgQGwWa9ybFjl3L/8WXSpECf+CzrblehD
	LW0RwIlvE8/2/LM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 47849199A4;
	Fri, 22 Mar 2024 12:41:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C58BB199A3;
	Fri, 22 Mar 2024 12:41:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: git@vger.kernel.org,  Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH] grep: improve errors for unmatched ( and )
In-Reply-To: <petpdy3bs6wpfd3ilrg6xrjsbj5y7ql4geps6y22ozdqw7vi4k@tarta.nabijaczleweli.xyz>
	("Ahelenia =?utf-8?Q?Ziemia=C5=84ska=22's?= message of "Fri, 22 Mar 2024
 09:34:38 +0100")
References: <petpdy3bs6wpfd3ilrg6xrjsbj5y7ql4geps6y22ozdqw7vi4k@tarta.nabijaczleweli.xyz>
Date: Fri, 22 Mar 2024 09:41:40 -0700
Message-ID: <xmqq34si2p8b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 0FBCF0B8-E86B-11EE-A22B-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz> writes:

> Imagine you want to grep for (. Easy:

Please have a blank line before and=20

>   $ git grep '('
>   fatal: unmatched parenthesis

after a displayed text like this one (this applies to a few more
paragraphs in the proposed log message).

> uhoh. This is plainly wrong. Unless you know specifically that
> (a) git grep has expression groups and that
> (b) the only way to work around them is by doing -- '(' or -e '('

I do not think "--" (end of options and beginning of pathspec)
marker would work for that purpose, UNLESS you are talking about a
file whose name is an open parenthesis.  Just keep "-e '('" in the
description and drop the double-dash there.

> Similarly,
>   $ git grep ')'
>   fatal: incomplete pattern expression: )
> is somehow worse. ")" is a complete regular expression pattern.
> Of course, the error wants to say "group" here.

Nice problem description so far.

> These now return

Phrase it more like "Make them return" ...

>   $ ./git grep '('
>   fatal: unmatched ( for expression group
>   $ ./git grep ')'
>   fatal: incomplete pattern expression group: )

> which hopefully are clearer in indicating that it's not the expression
> that's wrong (since no pattern had been parsed at all), but rather that
> it's been misconstrued as a grouping operator.

Nicely done.

> Link: https://bugs.debian.org/1051205
> Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.=
xyz>
> ---
>  grep.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
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

Thanks.  The changes to these two messages look good.
