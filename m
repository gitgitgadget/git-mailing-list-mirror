From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix segmentation fault when user doesn't have access
	permission to the repository.
Date: Thu, 22 Nov 2007 17:09:59 +0100
Message-ID: <20071122160959.GA3411@steel.home>
References: <b8bf37780711211659i4d621533o6a3b97349bb75f8c@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-15?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 17:10:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvEdY-00075H-HT
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 17:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbXKVQKF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Nov 2007 11:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbXKVQKF
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 11:10:05 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:45758 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbXKVQKD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 11:10:03 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTj9XLA=
Received: from tigra.home (Fcac9.f.strato-dslnet.de [195.4.202.201])
	by post.webmailer.de (fruni mo58) (RZmta 14.3)
	with ESMTP id p0039bjAMF6oLY ; Thu, 22 Nov 2007 17:10:00 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id DD3C0277AE;
	Thu, 22 Nov 2007 17:09:59 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 5984756D22; Thu, 22 Nov 2007 17:09:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <b8bf37780711211659i4d621533o6a3b97349bb75f8c@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65828>

Andr=E9 Goddard Rosa, Thu, Nov 22, 2007 01:59:00 +0100:
> @@ -487,8 +490,13 @@ static int do_fetch(struct transport *transport,
>  		die("Don't know how to fetch from %s", transport->url);
> =20
>  	/* if not appending, truncate FETCH_HEAD */
> -	if (!append)
> -		fclose(fopen(git_path("FETCH_HEAD"), "w"));
> +	if (!append) {
> +		char *filename =3D git_path("FETCH_HEAD");
> +		int fd =3D fopen(filename, "w");

This should have been "FILE *fp", not "int fd".

> +		if (!fd)
> +			return error("cannot open %s: %s\n", filename, strerror(errno));
> +		fclose(fd);
> +	}
> =20
>  	ref_map =3D get_ref_map(transport, refs, ref_count, tags, &autotags=
);
> =20
> --=20
> 1.5.3.6.861.gd794-dirty
>=20
