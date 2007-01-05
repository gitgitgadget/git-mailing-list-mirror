From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH 2/4] Improve cached content header of status output
Date: Fri, 05 Jan 2007 10:54:15 +0000
Message-ID: <459E2E57.6020503@shadowen.org>
References: <1167765983316-git-send-email-j.ruehle@bmiag.de> <11677659921833-git-send-email-j.ruehle@bmiag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	=?ISO-8859-1?Q?J=FCrgen_R=FChle?= <j-r@online.de>
X-From: git-owner@vger.kernel.org Fri Jan 05 11:54:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2miP-0004bf-5J
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 11:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161051AbXAEKyT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 5 Jan 2007 05:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161053AbXAEKyT
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 05:54:19 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:2571 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161051AbXAEKyS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 05:54:18 -0500
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1H2mhO-0007x9-Ob; Fri, 05 Jan 2007 10:53:22 +0000
User-Agent: Icedove 1.5.0.9 (X11/20061220)
To: Juergen Ruehle <j.ruehle@bmiag.de>
In-Reply-To: <11677659921833-git-send-email-j.ruehle@bmiag.de>
X-Enigmail-Version: 0.94.1.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35991>

Juergen Ruehle wrote:
> From: =3D?iso-8859-1?q?J=3DFCrgen_R=3DFChle?=3D <j-r@online.de>
>=20
> This tries to be more to the point while also including a pointer on =
how to
> unstage changes from the index.
>=20
> Since this header is printed in two different code paths and the name=
 of the
> reference commit is needed for the unstage part, provide a new printi=
ng
> function.
>=20
> Signed-off-by: J=FCrgen R=FChle <j-r@online.de>
> ---
>  wt-status.c |   18 ++++++++++++++----
>  1 files changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/wt-status.c b/wt-status.c
> index 34be91b..98ca135 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -53,6 +53,18 @@ void wt_status_prepare(struct wt_status *s)
>  	s->untracked =3D 0;
>  }
> =20
> +static void wt_status_print_cached_header(const char *reference)
> +{
> +	const char *c =3D color(WT_STATUS_HEADER);
> +	color_printf_ln(c, "# Cached changes to be committed:");
> +	if (reference) {
> +		color_printf_ln(c, "#   (use \"git reset %s <file>...\" and \"git =
rm --cached <file>...\" to unstage)", reference);
> +	} else {
> +		color_printf_ln(c, "#   (use \"git rm --cached <file>...\" to unst=
age)");
> +	}
> +	color_printf_ln(c, "#");

We seem to be using 'Cached' and 'staged' here.  I thought we had
updated all the docs to call files in the index "Staged for commit".  I=
t
feels like the header should be more like:

     # Currently staged changes, will be commited:

The rm --cached is somewhat unfortunate either way.

-apw
