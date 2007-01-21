From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] Lose perl dependency. (fwd)
Date: Sun, 21 Jan 2007 03:56:17 +0100
Message-ID: <45B2D651.7010606@fs.ei.tum.de>
References: <Pine.LNX.4.63.0701181149260.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45AF5F83.6090207@fs.ei.tum.de> <Pine.LNX.4.63.0701181441010.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vps9ag58g.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701200052210.12889@wbgn013.biozentrum.uni-wuerzburg.de> <7vvej2bkn2.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701200213020.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vfya69xym.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701201025070.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vwt3h7dp6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701202240210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2A83F664A678BE6CFC93F0BA"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 21 03:56:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8Ssi-0006KN-8t
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 03:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbXAUC4Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 21:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbXAUC4Z
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 21:56:25 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:42081 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbXAUC4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 21:56:24 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id B7D44280A5;
	Sun, 21 Jan 2007 03:56:22 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id OPR3mDQBYd5O; Sun, 21 Jan 2007 03:56:21 +0100 (CET)
Received: from [192.168.10.124] (ppp-62-216-209-241.dynamic.mnet-online.de [62.216.209.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 09293280A1;
	Sun, 21 Jan 2007 03:56:20 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; DragonFly pc32; en-US; rv:1.8.0.8) Gecko/20061212 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701202240210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37305>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2A83F664A678BE6CFC93F0BA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin wrote:
> @@ -1285,6 +1289,27 @@ struct commit *get_revision(struct rev_info *rev=
s)
>  {
>  	struct commit *c =3D NULL;
> =20
> +	if (revs->reverse) {
> +		struct commit_list *list;
> +
> +		if (revs->reverse =3D=3D 1) {
> +			revs->reverse =3D 0;
> +			list =3D NULL;
> +			while ((c =3D get_revision(revs)))
> +				commit_list_insert(c, &list);
> +			revs->commits =3D list;
> +			revs->reverse =3D 2;
> +		}
> +
> +		if (!revs->commits)
> +			return NULL;
> +		c =3D revs->commits->item;
> +		list =3D revs->commits->next;
> +		free(revs->commits);
> +		revs->commits =3D list;
> +		return c;
> +	}
> +
>  	if (0 < revs->skip_count) {
>  		while ((c =3D get_revision_1(revs)) !=3D NULL) {
>  			if (revs->skip_count-- <=3D 0)
> diff --git a/revision.h b/revision.h
> index d93481f..5fec184 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -42,7 +42,8 @@ struct rev_info {
>  			unpacked:1, /* see also ignore_packed below */
>  			boundary:1,
>  			left_right:1,
> -			parents:1;
> +			parents:1,
> +			reverse:2;
> =20
>  	/* Diff flags */
>  	unsigned int	diff:1,

I like this.  However, rev_info.reverse needs some documentation.  Or the=
 block in get_revision does:

/*
 * rev_info.reverse is used to note the fact that we want to output the l=
ist
 * of revisions in reverse order.  To accomplish this goal, reverse can h=
ave
 * different values:
 *  0  do nothing
 *  1  reverse the list
 *  2  internal use:  we have already obtained and reversed the list,
 *     now we only need to yield its items.
 */

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig2A83F664A678BE6CFC93F0BA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFstZUr5S+dk6z85oRAvKhAKCxUeSVt3N5iMgPCp0aIrT55NvBJgCdEQ4t
CvXANayvBphrd2zc3d0iSUc=
=0faj
-----END PGP SIGNATURE-----

--------------enig2A83F664A678BE6CFC93F0BA--
