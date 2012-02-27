From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v6 02/11] Add git-column and column mode parsing
Date: Mon, 27 Feb 2012 20:09:36 +0000
Message-ID: <4F4BE300.2060302@ramsay1.demon.co.uk>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com> <1330170078-29353-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 23:08:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S28k9-0008L9-VW
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 23:08:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755779Ab2B0WIZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 17:08:25 -0500
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:52546 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755404Ab2B0WIY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2012 17:08:24 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1S28k2-00015r-lJ; Mon, 27 Feb 2012 22:08:23 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <1330170078-29353-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191681>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
[...]
> +static int parse_option(const char *arg, int len,
> +			unsigned int *mode, int stdout_is_tty)
> +{
> +	struct colopt opts[] =3D {
> +		{ ENABLE, "always",  1 },
> +		{ ENABLE, "never",   0 },
> +		{ ENABLE, "auto",   -1 },
> +	};

Hmm, I don't recognise this table from last time ...

> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(opts); i++) {
> +		int set =3D 1, arg_len =3D len, name_len;

set is initialised here (mainly to silence the compiler) in each
loop, but then ...

> +		const char *arg_str =3D arg;
> +
> +		if (opts[i].type =3D=3D OPTION) {
> +			if (arg_len > 2 && !strncmp(arg_str, "no", 2)) {
> +				arg_str +=3D 2;
> +				arg_len -=3D 2;
> +				set =3D 0;
> +			} else {
> +				set =3D 1;

=2E.. this else clause is no longer required.

> +			}
> +		}
> +
> +		name_len =3D strlen(opts[i].name);
> +		if (arg_len !=3D name_len ||
> +		    strncmp(arg_str, opts[i].name, name_len))
> +			continue;
> +
> +		switch (opts[i].type) {
> +		case ENABLE:
> +			return set_enable_bit(mode, opts[i].value,
> +					      stdout_is_tty);

given the above table, can the following case limbs ever be reached?
(the "no" prefix is only applied to the OPTION type, so most of the
above code seems to be useless now ...)

> +		case MODE:
> +			return set_mode(mode, opts[i].value);
> +		case OPTION:
> +			return set_option(mode, opts[i].value, set);
> +		default:
> +			die("BUG: Unknown option type %d", opts[i].type);
> +		}
> +	}
> +
> +	return error("unsupported style '%s'", arg);
> +}
> +
[...]

Note, I only skimmed the patch text, I haven't applied it or tested it =
=2E..

ATB,
Ramsay Jones
