From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [BUG] "git pull" will regress between 'master' and 'pu'
Date: Sun, 19 Apr 2015 17:38:26 +0000
Message-ID: <20150419173825.GD652025@vauxhall.crustytoothpaste.net>
References: <xmqqbnikoq0n.fsf@gitster.dls.corp.google.com>
 <20150419130745.GA20476@peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fXStkuK2IQBfcDe+"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 19 19:39:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjtBj-0007DE-D8
	for gcvg-git-2@plane.gmane.org; Sun, 19 Apr 2015 19:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbbDSRib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2015 13:38:31 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:41289 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751309AbbDSRia (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Apr 2015 13:38:30 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:acb5:49fa:9dfc:e224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 896842808D;
	Sun, 19 Apr 2015 17:38:29 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20150419130745.GA20476@peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16.0-4-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267443>


--fXStkuK2IQBfcDe+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 19, 2015 at 09:07:46AM -0400, Jeff King wrote:
> Which I guess is just:
>=20
> diff --git a/git-pull.sh b/git-pull.sh
> index 252969e..15d9431 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -323,7 +323,6 @@ then
>  	fi
>  fi
> =20
> -merge_name=3D$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
>  case "$rebase" in
>  true)
>  	eval=3D"git-rebase $diffstat $strategy_args $merge_args $rebase_args $v=
erbosity"
> @@ -334,7 +333,7 @@ true)
>  	eval=3D"git-merge $diffstat $no_commit $verify_signatures $edit $squash=
 $no_ff $ff_only"
>  	eval=3D"$eval $log_arg $strategy_args $merge_args $verbosity $progress"
>  	eval=3D"$eval $gpg_sign_args"
> -	eval=3D"$eval -m \"\$merge_name\" $merge_head"
> +	eval=3D"$eval FETCH_HEAD"
>  	;;
>  esac
>  eval "exec $eval"
>=20
> as we seem to special-case the name FETCH_HEAD. It assumes that
> git-merge's parsing of FETCH_HEAD is the same as what we do in git-pull,
> but that seems safe. Unfortunately we still have to compute $merge_head
> ourselves here for the "git pull --rebase" case.

I agree that this is a better choice.  My concern with your other
suggestion is that it looks like it wouldn't honor the --no-edit flag or
GIT_MERGE_AUTOEDIT=3Dno.  That might break some use cases, such as
non-interactive applications.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--fXStkuK2IQBfcDe+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVM+gRAAoJEL9TXYEfUvaLgqsP/3xOJSsuqvWa/VNsMvewGQyz
5iEsmWSlJTVfaGSG4bvvteLgP0x5ayOebMkTYmUUr2oES7q6fEt3kUf/LJ46g+8D
uhzpvELqL/DcTXW4I29F/QqDoD/E5iu1oF/MnQJQDpDJLUBXwGGx59rK8p6oZGxX
+qjrOj7cG5FKoLq5bp1B+iFHcWc7/eUP0K0avTvx9RtP9xW+KiWuln9ZD4BLwlav
ZFJS/dYFiTY8L6HKFZB8r8LRs3mVBbamxQjljcGNeSi4OpxKIYBD6PKgNlxVio3T
q7uxTGGLH7YP7Y6TNWv+qEI69vxzZgotlo15i+W7ubxxt1qhJtVHx1GPgq3ai2Lo
dvgmF8j+2QfJ2yUwpWmCHRpuS8KVWDFGkegCuXK2fzwiwqeaxvfwJG9V0ipmuE49
MEU+5ziqe6pgRwkXDCvzKUv/Yf9J9QJlax+8pK4AJYVoSzss2+v50Nxot8a4U+cI
UH1/6IVM1TL4u0d+dfWqwf9UMZQfX9cL/5thxTlrEA/kUetffOl/JmWsQppYsQe6
9ejQk+ntHX6tqv6LZcu/E8M1pfrELf8pqtc6Uxo89gXES3+Myxn+jigrRf+5kNms
AiwHHAgV5RNHjuGc529LDZ4mk4ZJl2681sbMpNwaaZx8evfIBPYGTy6s82WyhyMy
7VVHzAbq7bpiRR8oPea1
=toYr
-----END PGP SIGNATURE-----

--fXStkuK2IQBfcDe+--
