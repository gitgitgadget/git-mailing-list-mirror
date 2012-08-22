From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Support generate poison .mo files for testing
Date: Wed, 22 Aug 2012 09:43:38 -0700
Message-ID: <7vtxvuand1.fsf@alter.siamese.dyndns.org>
References: <7va9xofbgo.fsf@alter.siamese.dyndns.org>
 <1345613246-4053-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 18:43:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4E20-0005WE-1Q
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 18:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757819Ab2HVQnm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Aug 2012 12:43:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63500 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753138Ab2HVQnk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2012 12:43:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F5628768;
	Wed, 22 Aug 2012 12:43:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FMixq6bKVMF1
	w6N1NuXBDSPvZQY=; b=vveGAyXJu595NArbyDPieGB349Or3xrEG+qIHA1gM+pU
	fe0Tx/yLFS/oyrmp1YhvV06DLpYUE0AQtYAbmOodvaOjFhxbVdVBWHUYf49S+jzh
	AcD5lc8bz4YaRsDscW6czUo42RBa2cO/5Ie6oH3Rb774OPP/mur00kVu9eB0Jz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wZV6el
	edryGLIyUCtmYBIxt2y1OpwQGluqGQsExmMg8QAT1wU+4NRGZ5pCuImxrdX69Fg2
	Etg04G+FFbY4SGTp+i8Pg+vuGm+TKDvA3fCupNVXuYWl3QtQAj7HPDhyINBl6F/6
	2cqq38SHjIWkH3rbjOBbPD20rXUbzilDjpXPM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CD7C8767;
	Wed, 22 Aug 2012 12:43:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A11638766; Wed, 22 Aug 2012
 12:43:39 -0400 (EDT)
In-Reply-To: <1345613246-4053-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 22 Aug
 2012 12:27:26 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 869FCD78-EC78-11E1-91B7-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204028>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +static void translate(const char *msg, struct strbuf *buf)
> +{
> +	const char *end =3D msg + strlen(msg);
> +	const char *text =3D "* GETTEXT POISON *";
> +	int text_len =3D strlen(text);
> +	int t =3D 0;
> +
> +	strbuf_reset(buf);
> +	/* preserve \n and printf format specifiers because msgfmt
> +	   barfs otherwise. */
> +	while (msg < end) {
> +		/* printf specifiers and shell variables, it's a quite
> +		   relax check */
> +		if ((*msg =3D=3D '%' || *msg =3D=3D '$') && msg+1 < end) {
> +			strbuf_addch(buf, *msg++);
> +			do
> +			       strbuf_addch(buf, *msg);
> +			while (msg < end && !isspace(*msg++));

Aside from the Style:

        do {
                ...
        } while ();

why are you special casing a run of non-blank letters that begin
with a dollar sign (swapping two ints is done with "%2$d %1$d", a
percent still at the beginning, so there must be something else I am
missing)?

Also why do you stop at isspace()?  Isn't a " " (space) a flag that
means "If the first character of a signed conversion is not a sign
or if a signed conversion results in no characters, a <space> shall
be prefixed to the result."

As the flags, min-width, precision, and length do not share the same
character as the conversion that has to come at the end, I think you
only want to do something like

	/*
         * conversion specifier characters, taken from:
         * http://pubs.opengroup.org/onlinepubs/9699919799/functions/pr=
intf.html
         */
        static const char printf_conversion[] =3D "diouxXfFeEgGaAcspnCS=
%";

        ...

        while (msg < end) {
                if (*msg =3D=3D '%') {
                        strbuf_addch(buf, *msg++);
                        while (msg < end) {
                                int ch =3D *msg++;
                                strbuf_addch(buf, ch);
                                if (strchr(printf_conversion, ch))
                                        break;
                        }
                        /* copied the printf part literally */
                        continue;
		}
		... keep \n ...
                ... muck with string ...
	}

perhaps?
