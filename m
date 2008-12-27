From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2] parse-opt: migrate builtin-apply.
Date: Sat, 27 Dec 2008 22:53:43 +0100
Message-ID: <4956A3E7.7070208@lsrfire.ath.cx>
References: <20081227140533.GX21154@genesis.frugalware.org> <1230387764-11230-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Dec 27 22:55:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGh7p-00015I-2t
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 22:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754241AbYL0Vxw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Dec 2008 16:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754163AbYL0Vxw
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 16:53:52 -0500
Received: from india601.server4you.de ([85.25.151.105]:55570 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728AbYL0Vxv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 16:53:51 -0500
Received: from [10.0.1.101] (p57B7C571.dip.t-dialin.net [87.183.197.113])
	by india601.server4you.de (Postfix) with ESMTPSA id AC42C2F8003;
	Sat, 27 Dec 2008 22:53:48 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <1230387764-11230-1-git-send-email-vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104021>

Miklos Vajna schrieb:
> -static const char apply_usage[] =3D
> -"git apply [--stat] [--numstat] [--summary] [--check] [--index] [--c=
ached] [--apply] [--no-add] [--index-info] [--allow-binary-replacement]=
 [--reverse] [--reject] [--verbose] [-z] [-pNUM] [-CNUM] [--whitespace=3D=
<nowarn|warn|fix|error|error-all>] <patch>...";
> +static const char * const apply_usage[] =3D {
> +	"git apply [--stat] [--numstat] [--summary] [--check] [--index] [--=
cached] [--apply] [--no-add] [--index-info] [--allow-binary-replacement=
] [--reverse] [--reject] [--verbose] [-z] [-pNUM] [-CNUM] [--whitespace=
=3D<nowarn|warn|fix|error|error-all>] <patch>...",
> +	NULL
> +};

A useful convention with parse_options is to display "[options]" as a
place holder instead of listing all options explicitly in the usage
string.  They are listed and explained in the full help message anyway
shown by "git apply -?").

> +static int option_parse_inaccurate(const struct option *opt,
> +				   const char *arg, int unset)
> +{
> +	options |=3D INACCURATE_EOF;
> +	return 0;
> +}
> +
> +static int option_parse_recount(const struct option *opt,
> +				const char *arg, int unset)
> +{
> +	options |=3D RECOUNT;
> +	return 0;
> +}

OPT_BIT?

> +		OPT_INTEGER('C', NULL, &p_context,
> +				"ensure at least <n> lines of context match"),

p_context is an unsigned long variable; OPT_INTEGER expects a pointer
to an int.  You'd either need an OPT_ULONG macro or change p_context
to in int.  Doing the latter fixed the two test cases t4105 and t4252
for me.

Ren=E9
