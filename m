From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] wt-status: take the alignment burden off translators
Date: Mon, 04 Nov 2013 10:42:46 -0800
Message-ID: <xmqqppqgypnd.fsf@gitster.dls.corp.google.com>
References: <31465687.35grSWXxkx@i5>
	<1383534531-5153-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, wolfgang@rohdewald.de, vnwildman@gmail.com,
	ralf.thielow@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 04 19:42:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdP71-00022G-Ds
	for gcvg-git-2@plane.gmane.org; Mon, 04 Nov 2013 19:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367Ab3KDSmv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Nov 2013 13:42:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49359 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753323Ab3KDSmu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Nov 2013 13:42:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D60B34DCF8;
	Mon,  4 Nov 2013 13:42:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Hc+OPuT0bQlm
	crDtid5DN8qEkUI=; b=Lo5FAik/VqtmqY3w9BwQ4Ohye7vRJUnSKvLr15lb494l
	RRkcBQlqHdHgOfEm9UXRyvn2t9hH3C5TeRkfS/gYu+Gbl1lRz1I6Jc2pKX18Nxbu
	HjphR93hA08+VJUM9DLrN217I5P/Guu4DmxdPLPOglWq6MjLANQG5NZmeTnlDpY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=l9mTo1
	ZVXGkA7CAUCD8rXFbDBtJySxWysuInkpJh9l1gNavAD/ClCjeKxG+Cf/5yS1YF86
	zOZBlYOECn2+L/rVaOqW/ltBLBiLYXBLelKI4eGgQDVKwLttAsDVSESBh9UTFdEh
	SakpzOjTBG9xA5lNQyJ7QrhQPe5oYezBy+w58=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4F674DCF7;
	Mon,  4 Nov 2013 13:42:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 186E74DCF6;
	Mon,  4 Nov 2013 13:42:49 -0500 (EST)
In-Reply-To: <1383534531-5153-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 4 Nov
 2013 10:08:51 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E75F5662-4580-11E3-ACFA-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237295>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +	static const char *spaces =3D "                                ";

I do not see anything that limits "len" used to show only show the
prefix bytes in this array not to ask for more than you have spaces
here.  It won't overrun the end of this array, but I suspect your
result will not align when that happens.

> +	static int width =3D -1;
> +	int len;
> =20
>  	one_name =3D two_name =3D it->string;
>  	switch (change_type) {
> @@ -309,32 +314,62 @@ static void wt_status_print_change_data(struct =
wt_status *s,
>  	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
>  	switch (status) {
>  	case DIFF_STATUS_ADDED:
> -		status_printf_more(s, c, _("new file:   %s"), one);
> +		what =3D _("new file");
>  		break;
>  	case DIFF_STATUS_COPIED:
> -		status_printf_more(s, c, _("copied:     %s -> %s"), one, two);
> +		what =3D _("copied");
>  		break;
>  	case DIFF_STATUS_DELETED:
> -		status_printf_more(s, c, _("deleted:    %s"), one);
> +		what =3D _("deleted");
>  		break;
>  	case DIFF_STATUS_MODIFIED:
> -		status_printf_more(s, c, _("modified:   %s"), one);
> +		what =3D _("modified");
>  		break;
>  	case DIFF_STATUS_RENAMED:
> -		status_printf_more(s, c, _("renamed:    %s -> %s"), one, two);
> +		what =3D _("renamed");
>  		break;
>  	case DIFF_STATUS_TYPE_CHANGED:
> -		status_printf_more(s, c, _("typechange: %s"), one);
> +		what =3D _("typechange");
>  		break;
>  	case DIFF_STATUS_UNKNOWN:
> -		status_printf_more(s, c, _("unknown:    %s"), one);
> +		what =3D _("unknown");
>  		break;
>  	case DIFF_STATUS_UNMERGED:
> -		status_printf_more(s, c, _("unmerged:   %s"), one);
> +		what =3D _("unmerged");
>  		break;
>  	default:
>  		die(_("bug: unhandled diff status %c"), status);
>  	}
> +	if (width =3D=3D -1) {
> +		/*
> +		 * Translators: if you do translate this, replace it
> +		 * with a decimal number of how many columns needed
> +		 * to align file names in "git status":
> +		 *
> +		 * |<-columns->|
> +		 *
> +		 *   unmerged: foo.c
> +		 *   copied:   foo.c -> bar.c
> +		 *
> +		 * The default value is 12. Normally you would not
> +		 * need to translate this at all unless the translated
> +		 * strings are longer than 12 columns and therefore
> +		 * break alignment.
> +		 */
> +		width =3D atoi(_("<wt-status.c:width>"));

Somewhat ugly.  Wouldn't it work better to keep the "what" strings
in a static array and compute "width" just once?  Is the sparseness
of DIFF_STATUS_* enums what makes such an implementation cumbersome?

I dunno.

> +		if (width <=3D 0 || width > 32)
> +			width =3D 12;
> +	}
> +	if (width > utf8_strwidth(what) + 1)
> +		len =3D width - utf8_strwidth(what) - 1;

Just a style, but this is far easier to read if you said:

	if (width > utf8_strwidth(what) + 1)
		len =3D width - (utf8_strwidth(what) + 1);

because you are essentially doing:

	if (A > B)
        	x =3D A - B;

Or even

	len =3D width - (utf8_strwidth(what) + 1);
        if (len < 0)
        	len =3D 0;

> +	else
> +		len =3D 0;
> +	if (status =3D=3D DIFF_STATUS_COPIED || status =3D=3D DIFF_STATUS_R=
ENAMED)
> +		status_printf_more(s, c, "%s:%.*s%s -> %s",
> +				   what, len, spaces, one, two);
> +	else
> +		status_printf_more(s, c, "%s:%.*s%s",
> +				   what, len, spaces, one);
>  	if (extra.len) {
>  		status_printf_more(s, color(WT_STATUS_HEADER, s), "%s", extra.buf)=
;
>  		strbuf_release(&extra);
