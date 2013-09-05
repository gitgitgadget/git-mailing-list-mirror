From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] pathspec: catch prepending :(prefix) on pathspec with short magic
Date: Thu, 05 Sep 2013 11:39:56 -0700
Message-ID: <xmqqppsni03n.fsf@gitster.dls.corp.google.com>
References: <1378352440-25410-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 05 20:40:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHeTY-0005Dv-33
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 20:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756579Ab3IESkK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Sep 2013 14:40:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44633 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756490Ab3IESkB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Sep 2013 14:40:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2A003F1DF;
	Thu,  5 Sep 2013 18:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5XcZkuYwc40+
	gq+twOHLcLVNghk=; b=Da5tj4d3vlrtU8UkO7eAm7/lIsFvGshQnnD7WZNhm+v7
	dekiO273qEk2CKBMicuB5Xy1kmPKT32zODkA6te4Pz8VTVtL2DEmaCrFzpPUPdn8
	2hNWA76Pno+nhttHkhbEf9w5nNi+QynOG4LHaReJCbaZqJH1jhz/+/szmFGdXJM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=S5naox
	8xjMpICgE/rLw0XL+Kn04QKloxgAUvvtELpmt1yux7e00EqZWNSLS6XPZkd0wxYH
	AhpS0JWRhCzerudl1jo65udLikAL0Sgl1IQsfnBNvNCXKp39Mx+mW1u4nxll/iO6
	8GFPPKpnFX4c8pVQJQlg7B6CqpD4LkndpBFh0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D24B43F1DD;
	Thu,  5 Sep 2013 18:40:00 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12E4A3F1D6;
	Thu,  5 Sep 2013 18:39:58 +0000 (UTC)
In-Reply-To: <1378352440-25410-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 5 Sep
 2013 10:40:38 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9150A730-165A-11E3-941F-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233978>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> :(prefix) is in the long form. Suppose people pass :!foo with '!'
> being the short form of magic 'bar', the code will happily turn it to
> :(prefix..)!foo, which makes '!' part of the path and no longer a mag=
ic.
>
> The correct form must be ':(prefix..,bar)foo', but as so far we
> haven't had any magic in short form yet (*), the code to convert from
> short form to long one will be inactive anyway. Let's postpone it
> until a real short form magic appears.
>
> (*) The short form magic '/' is a special case and won't be caught by
> this die(), which is correct. When '/' magic is detected, prefixlen i=
s
> set back to 0 and the whole "if (prefixlen..)" block is skipped.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  fixes on top of nd/magic-pathspec.
>
>  pathspec.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/pathspec.c b/pathspec.c
> index d9f4143..62fde50 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -231,7 +231,9 @@ static unsigned prefix_pathspec(struct pathspec_i=
tem *item,
>  		const char *start =3D elt;
>  		if (prefixlen && !literal_global) {
>  			/* Preserve the actual prefix length of each pattern */
> -			if (long_magic_end) {
> +			if (short_magic)
> +				die("BUG: prefixing on short magic is not supported");
> +			else if (long_magic_end) {
>  				strbuf_add(&sb, start, long_magic_end - start);
>  				strbuf_addf(&sb, ",prefix:%d", prefixlen);
>  				start =3D long_magic_end;

Good.

I wonder if we should start thinking about removing the big
"NEEDSWORK" comment in front of this function.

Also the pathspec_magic[] array was the table-driven way that was
meant to be enhanced to fit future needs to parse all supported
types of pathspec magic, but it seems that "prefix:12" magic is
implemented using a custom/special case code.  We may want to see if
we want to enrich the parser to fold this to match the table-driven
approach better someday---this is not urgent as we are not adding
any new pathspec magic now.

Will queue.  Thanks.
