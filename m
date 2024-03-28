Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C91B4E1C9
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711637165; cv=none; b=Y/3MTnZKncpmRZ+OjEd/6y48rweDmoHgBzD4dXW55W9VqAkzEhnrIpkgYlYdG7ePFBIeMVzzeybvOoKA2Y6lPzu/WUv7Yx8c5HqOrLD32j9VFdJZDQPKE3t1L/nx5JKJur/JbPOzGUUSIplYA+bHJQ+SoDPI6aFlGmTGF5UOChQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711637165; c=relaxed/simple;
	bh=xQmzOMiYfOAWPYS+rCr902lJ2/W1mFco+fdenw8HjEM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BYJz4+aM6hTc/CHNDhzc2B7/kIaRaLs9uN5uZmndVZbdOs9lc9Cx+pukiHkvR6bxVs3VmQ2TauJKxkUNW8D7BUjG4BIjL8Z1e8qvhPR6i0m4rDKl7ZAJ/5uJlHkPhPaaRQpagLSSYh2lHh7bE7rvvWCzccTPGO2XG2sV8K1Tk28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XAXE1Wi5; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XAXE1Wi5"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BDF51EA8D8;
	Thu, 28 Mar 2024 10:46:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xQmzOMiYfOAW
	PYS+rCr902lJ2/W1mFco+fdenw8HjEM=; b=XAXE1Wi5bB6Xt1NEimKwgrt8nwtv
	5r7mWotlgnA93ABkriyDjJd1mJ7eieDooOPm/RqLUo2xKAmrubqL5hafRj/Wcwjk
	yAI2jm5Rw7UEYPdNoGc/HhHcpFbRZvw77LtDgyREYYLyagF3sYuSzvBSj4IMmJx1
	3yPJhFx61u2kQrM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 734BE1EA8D7;
	Thu, 28 Mar 2024 10:46:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B7E231EA8D5;
	Thu, 28 Mar 2024 10:46:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 2/2] add-patch: do not print hunks repeatedly
In-Reply-To: <60c43160-1b60-42f6-9488-4cc332201b7e@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Thu, 28 Mar 2024 02:12:13 +0100")
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
	<6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
	<60d978d0-f69a-4b65-b4ba-d30dac8f112a@gmail.com>
	<60c43160-1b60-42f6-9488-4cc332201b7e@gmail.com>
Date: Thu, 28 Mar 2024 07:46:00 -0700
Message-ID: <xmqqmsqixvmf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 E59FB8E6-ED11-11EE-8CF1-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> @@ -1448,10 +1448,15 @@ static int patch_update_file(struct add_p_state=
 *s,
> =20
>  		strbuf_reset(&s->buf);
>  		if (file_diff->hunk_nr) {
> -			render_hunk(s, hunk, 0, colored, &s->buf);
> -			fputs(s->buf.buf, stdout);
> +			if (rendered_hunk_index !=3D hunk_index) {

So, the one previously rendered is compared with the current one,
which raises an obvious question, what happens to the first new hunk
resulting from splitting a hunk?  The answer is below ...

> +				render_hunk(s, hunk, 0, colored, &s->buf);
> +				fputs(s->buf.buf, stdout);
> +
> +				rendered_hunk_index =3D hunk_index;
> +			}
> =20
>  			strbuf_reset(&s->buf);
> +
>  			if (undecided_previous >=3D 0) {
>  				permitted |=3D ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK;
>  				strbuf_addstr(&s->buf, ",k");
> @@ -1649,10 +1654,12 @@ static int patch_update_file(struct add_p_state=
 *s,
>  			if (!(permitted & ALLOW_SPLIT))
>  				err(s, _("Sorry, cannot split this hunk"));
>  			else if (!split_hunk(s, file_diff,
> -					     hunk - file_diff->hunk))
> +					     hunk - file_diff->hunk)) {
>  				color_fprintf_ln(stdout, s->s.header_color,
>  						 _("Split into %d hunks."),
>  						 (int)splittable_into);
> +				rendered_hunk_index =3D -1;
> +			}

... we explicitly say "we always want to show the current one after
this operation", which makes sense.

>  		} else if (s->answer.buf[0] =3D=3D 'e') {
>  			if (!(permitted & ALLOW_EDIT))
>  				err(s, _("Sorry, cannot edit this hunk"));
> @@ -1661,7 +1668,7 @@ static int patch_update_file(struct add_p_state *=
s,
>  				goto soft_increment;
>  			}
>  		} else if (s->answer.buf[0] =3D=3D 'p') {
> -			/* nothing special is needed */
> +			rendered_hunk_index =3D -1;

And that matches what is done for 'p', which is the base case that
wants to say "no matter what, show the current one".  Doubly makes
sense.

>  		} else {
>  			const char *p =3D _(help_patch_remainder), *eol =3D p;

Looking good.  As we are not doing anything dynamic to the help
text, I think dropping "again" in [1/2] would make sense.

Will queue.  Thanks.
