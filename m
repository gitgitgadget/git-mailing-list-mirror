From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add column layout skeleton and git-column
Date: Mon, 16 Apr 2012 09:05:04 -0700
Message-ID: <7v4nsjy85r.fsf@alter.siamese.dyndns.org>
References: <7v3984z16m.fsf@alter.siamese.dyndns.org>
 <1334582784-25723-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 18:05:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJoQV-0007wR-Tn
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 18:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171Ab2DPQFJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 12:05:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45514 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750734Ab2DPQFI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 12:05:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3BD3783E;
	Mon, 16 Apr 2012 12:05:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=iQhi0+CYRxq1
	xOP5YFznjWPbQTM=; b=MM71H4Ebg+HGRCaM0a0W12aBW2m17rl5b3ihETSzmTNQ
	Uk3t98MlBv+Eg5QgGCgOTAQOfcQCR2r7L+C8QrQWoK/bmAT/WUj4TZFMQKYiF9P+
	L4uUPNAseVPJGqvLsjVDknuHMwSnR5cqjBwsbr+4hnYnOWszwPPwKeqEwlIQzNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jHHXRR
	rsOo/yJgNb9j1NCx6Mg8BP1zGUPKarz+vGySl3UgnszhpDGsUOsWUETOyoEesgcD
	E8xhbrATdeVTjWgyCOFRomnkLE0FNCFRFoqJuXDNbwRr5xjT8zWrzk8xdx178+pt
	cWbERqS9WX+qXCxZ4VLOQ0GcH+Mhw92K+WHOc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B613783D;
	Mon, 16 Apr 2012 12:05:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1873F783B; Mon, 16 Apr 2012
 12:05:05 -0400 (EDT)
In-Reply-To: <1334582784-25723-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 16 Apr
 2012 20:26:24 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EEC30A0A-87DD-11E1-A7E8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195656>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> +static int parse_config(unsigned int *colopts, const char *value)
> +{
> +	const char *sep =3D " ,";
> +	int group_set =3D 0;
> +
> +	while (*value) {
> +		int len =3D strcspn(value, sep);
> +		if (len) {
> +			if (parse_option(value, len, colopts, &group_set))
> +				return -1;
> +
> +			value +=3D len;
> +		}
> +		value +=3D strspn(value, sep);
> +	}
> +	/*
> +	 * Setting layout implies "always" if neither always, never
> +	 * nor auto is specified.
> +	 *
> +	 * Current COL_ENABLE() value is disregarded. This means if
> +	 * you set column.ui =3D auto and pass --column=3Drow, then "auto"
> +	 * will become "always".
> +	 */
> +	if ((group_set & LAYOUT_SET) && !(group_set & ENABLE_SET))
> +		*colopts =3D (*colopts & ~COL_ENABLE_MASK) | COL_ENABLED;
> +	return 0;
> +}
> +
> +static int column_config(const char *var, const char *value,
> +			 const char *key, unsigned int *colopts)
> +{
> +	if (value && parse_config(colopts, value))
> +		return error("invalid column.%s mode %s", key, value);

If column.* can never be a boolean, this code shouldn't silently ignore

	[column]
        	ui

but explicitly error out.  See git_config_string() for an example if yo=
u
want to go this route.

On the other hand, it might make sense to equate a "true" with "a sane
default" (i.e. the user declares that s/he trusts whatever default the =
Git
implementation deems sane), in which case

	if (!value)
		value =3D "auto,whatever,column,default,mode";
	if (parse_config(colopts, value))
        	return error("invalid column.%s mode...", ...);

might be a better way to go.  If you take this route, a single-token
column.* becomes a variable that takes boolean and more, so the existin=
g
`never` has to gain `no`, `false`, etc. as synonyms, and `true`, `1`,
etc. needs to be interpreted the same as `auto` for consistency.
