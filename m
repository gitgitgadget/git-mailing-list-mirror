From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 05/10] column: add column.ui for default column output
 settings
Date: Tue, 28 Feb 2012 10:44:47 -0800
Message-ID: <7vpqcyztk0.fsf@alter.siamese.dyndns.org>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
 <1330430331-19945-1-git-send-email-pclouds@gmail.com>
 <1330430331-19945-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 28 19:44:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2S2h-0003v9-TX
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 19:44:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965970Ab2B1Sov convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 13:44:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40173 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965966Ab2B1Sou convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2012 13:44:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCEA077D5;
	Tue, 28 Feb 2012 13:44:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LL0fQJC4lGpq
	Ts0mdOAk+4cgCc8=; b=GRVYD1QNu2MO821rq/Xh6eCfhqA/ntGs1DpUqDRNqJq7
	NF/4vc3ciYFuJB7S/GkxIV82DqbSp0RXOqB9jp9lhoHt4biUXw5jUpl7tPJWuCcG
	pstkIL593p9AgpOCgZSlQj1iy1l6tEaJvYxpbq6UhxooWBCLG4Jj9nDGy/KYy1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NNwp20
	riK7G5emUslrz9GfLnqFurFxuNdl8wdUYI8ogk98dDZG38LZmKtpe26S35EM22HU
	ZEicg3ahdTruk8ufZxzmTQwA4C76d26T4SdWtTKmTzUQwvdKjMXkZWjyts7msPmf
	hQLhVEkPlhehuSIRR/boXQhH8qTw4RtLxmGWE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C483177D4;
	Tue, 28 Feb 2012 13:44:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B2BD77D1; Tue, 28 Feb 2012
 13:44:49 -0500 (EST)
In-Reply-To: <1330430331-19945-6-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 28 Feb
 2012 18:58:46 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4ADAAF68-623C-11E1-A902-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191759>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> +static int column_config(const char *var, const char *value,
> +			 const char *key, unsigned int *colopts)
> +{
> +	if (git_config_column(colopts, value, -1))

Are we sure nobody has put us on pager at this point, so that you can t=
ell
git_config_column() that it is OK to use isatty(1) to figure it out, or=
 we
could already be on pager (i.e. pager_in_use() is true) in which case w=
e
know we are interactive and should behave the same way as writing to a
terminal?

> +		return error("invalid %s mode %s", key, value);
> +	return 0;
> +}
> +
> +int git_column_config(const char *var, const char *value,
> +		      const char *command, unsigned int *colopts)
> +{
> +	if (!strcmp(var, "column.ui"))
> +		return column_config(var, value, "column.ui", colopts);
> +
> +	if (command) {
> +		struct strbuf sb =3D STRBUF_INIT;
> +		int ret =3D 0;
> +		strbuf_addf(&sb, "column.%s", command);
> +		if (!strcmp(var, sb.buf))
> +			ret =3D column_config(var, value, sb.buf, colopts);
> +		strbuf_release(&sb);
> +		return ret;
> +	}

This feels wrong. Depending on the order column.ui and column.frotz app=
ear
in the configuration file, asking for "git column --command=3Dfrotz" wo=
uld
yield random results, no?

Shouldn't the flow of logic be more like:

	git_config(git_column_config);
        -> git_column_config() is called for column.ui and column.frotz
           in no specified order; keep two *char variables to store the
           string value given from configuration
	if (kept value from column.frotz is missing)
		git_config_column(..., kept value from column.ui, ...);
	else
		git_config_column(..., kept value from column.frotz, ...);=20

> diff --git a/column.h b/column.h
> index eb03c6c..43528da 100644
> --- a/column.h
> +++ b/column.h
> @@ -27,6 +27,8 @@ extern void print_columns(const struct string_list =
*list,
>  			  struct column_options *opts);
>  extern int git_config_column(unsigned int *mode, const char *value,
>  			     int stdout_is_tty);
> +extern int git_column_config(const char *var, const char *value,
> +			     const char *command, unsigned int *colopts);

Also please rename git_config_column() in the earlier patch, perhaps li=
ke
"parse_column_config_string()" or something more sensible, to avoid
confusion.
