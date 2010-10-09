From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TopGit PATCH 10/10] [RFC] tg-patch: simulate mnemonic prefixes
Date: Sat, 9 Oct 2010 22:46:40 +0200
Message-ID: <20101009204640.GP29673@pengutronix.de>
References: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com> <101fe6e1e47292faa21770ab3a5a0b204897ac63.1286524446.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Oct 09 22:46:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4gJb-0004c5-LY
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 22:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757282Ab0JIUqm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Oct 2010 16:46:42 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37333 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757171Ab0JIUql (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 16:46:41 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1P4gJU-0004am-VZ; Sat, 09 Oct 2010 22:46:40 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1P4gJU-0000cv-Tq; Sat, 09 Oct 2010 22:46:40 +0200
Content-Disposition: inline
In-Reply-To: <101fe6e1e47292faa21770ab3a5a0b204897ac63.1286524446.git.bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158609>

On Fri, Oct 08, 2010 at 09:58:08AM +0200, Bert Wesarg wrote:
> b/ is for base, i/ and w/ correspond to -i/-w and t/ is the committed
> topic.
>=20
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> ---
>  tg-patch.sh |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/tg-patch.sh b/tg-patch.sh
> index dcce672..c8ad723 100644 tg-patch.sh
> --- a/tg-patch.sh
> +++ b/tg-patch.sh
> @@ -6,7 +6,7 @@
>  name=3D
> =20
>  head_from=3D
> -
> +dst_prefix=3D"t/"
> =20
>  ## Parse options
> =20
> @@ -15,7 +15,8 @@ while [ -n "$1" ]; do
>  	case "$arg" in
>  	-i|-w)
>  		[ -z "$head_from" ] || die "-i and -w are mutually exclusive"
> -		head_from=3D"$arg";;
> +		head_from=3D"$arg"
> +		dst_prefix=3D"${arg#-}/";;
>  	-*)
>  		echo "Usage: tg [...] patch [-i | -w] [NAME]" >&2
>  		exit 1;;
> @@ -72,6 +73,9 @@ if [ $b_tree =3D $t_tree ]; then
>  else
>  	# use the ui diff command when the pager is active
>  	diff_command=3Ddiff
> +	if $(git config --bool diff.mnemonicprefix); then
> +		diff_command=3D"$diff_command --src-prefix=3Db/ --dst-prefix=3D$ds=
t_prefix"
> +	fi
Do I assume right, that diff.mnemonicprefix is topgitish only?   Maybe
it should go then into a topgit namespace?

Hmm, nice idea, the only thing about it I don't like ad hoc is that b/
is already used by default and so it might be confusing.  OTOH you need
to enabled it in the config, ...  Hmm, will think about it.

Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
