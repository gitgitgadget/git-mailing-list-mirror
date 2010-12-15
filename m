From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] get_sha1: handle special case $commit^{/}
Date: Wed, 15 Dec 2010 15:44:12 -0800
Message-ID: <7v8vzqppo3.fsf@alter.siamese.dyndns.org>
References: <AANLkTimy5MVkxDzXqzA8T4DHJmzsSAvwqVVzRvWw5KA0@mail.gmail.com>
 <1292403774-361-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 16 00:44:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PT11T-0000Fv-Cq
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 00:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755836Ab0LOXoe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 18:44:34 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55758 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755781Ab0LOXod convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Dec 2010 18:44:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C9E68377E;
	Wed, 15 Dec 2010 18:44:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XEw6Tn0h7tKr
	kkxatm5+XuCBrSc=; b=vURa0QaShVZ4LOnpJUO1NFoewxi4jmiuCH78onjadp2c
	ZISeb/corVtSZuZ4YTLzhhPLm2FlHd9mSOV8zdjvoqAcfTU+5UfxbsuwBIqmRlGq
	c5N1F0/z2sSBIBujsQhcNWGDjL5639M4hBqHiEOqjOXt/7a0TvQv/paw3scyXUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cseRSx
	8MP3pEG1Yb0V8kv7sA08tokGNN0l631fvUAryH3Q8UIn6FC9HEV/0MUaf1ub9gzY
	p7Oeh27YRTCLSxzX67J8K/LS4kvG5lrur9ttPpQlT+dOKIWHgYvVMDgHtBqAiAW4
	f23KD9n5H4W6IwjmV8xVDtAT35leneoaeIGT0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 48ECA377C;
	Wed, 15 Dec 2010 18:44:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 19455377B; Wed, 15 Dec 2010
 18:44:39 -0500 (EST)
In-Reply-To: <1292403774-361-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Wed\, 15 Dec
 2010 16\:02\:54 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4E9C22D6-08A5-11E0-A276-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163795>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> Empty regex pattern should always match. But the exact behavior of
> regexec() may vary. Because it always matches anyway, we can just
> return 'matched' without calling regex machinery.

Hmm, I just noticed that "git grep -e '' Makefile" fails on FBSD8 for
the same reason.

I'd prefer a solution that is not about "special case $commit^{/}" but =
is
about "work around regcomp that cannot compile an empty regexp".

Wisdoms?

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  On top of nd/oneline-sha1-name-from-specific-ref
>
>  sha1_name.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 1ba4bc3..c5c59ce 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -599,6 +599,13 @@ static int peel_onion(const char *name, int len,=
 unsigned char *sha1)
>  		int ret;
>  		struct commit_list *list =3D NULL;
> =20
> +		/*
> +		 * $commit^{/}. Some regex implementation may reject.
> +		 * We don't need regex anyway. '' pattern always matches.
> +		 */
> +		if (sp[1] =3D=3D '}')
> +			return 0;
> +
>  		prefix =3D xstrndup(sp + 1, name + len - 1 - (sp + 1));
>  		commit_list_insert((struct commit *)o, &list);
>  		ret =3D get_sha1_oneline(prefix, sha1, list);
> --=20
> 1.7.3.3.476.g10a82
