From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] hash binary sha1 into patch id
Date: Fri, 13 Aug 2010 23:23:31 +0200
Message-ID: <20100813212331.GA24127@localhost>
References: <20100813094027.GA20906@localhost>
 <20100813200031.GD2003@burratino>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Cc: git@vger.kernel.org, Marat Radchenko <marat@slonopotamus.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 23:24:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok1jL-0003Sf-Sl
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 23:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753434Ab0HMVXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 17:23:42 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57099 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395Ab0HMVXl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 17:23:41 -0400
Received: by ewy23 with SMTP id 23so1573094ewy.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 14:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=GTFvAasBcnqEHlcsBOVNkf2Oq3Q4BBqAYXKTV/D04KI=;
        b=IEBhDZD8W0yXLCBznZJGcNsgoI4oTBctCmjk/ZdOFdsrz3trf14k3pdEk87uOMiADW
         PfYW/CqhoLPYOwuvecjEYYDytagJpqyMF9izASpiNN7UGzT0/sUQ5z0Wilj7TqC3r+uf
         nCSFWh3tpc/wg+0T7r5duXURG+h59RrHK4FaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=BImNvHOVLEEFBfV9D0wm7ruekgFbEM+q6hChg56QXgbGHk4GnQfYPRn8V6RLHuF6J1
         x+ethjnth2nkOVU46NfNMwYvK9uUHe4POfJen+oxROlymdlZxkQnmaaDq7c8JwYTbYls
         0TOz35l6T1RQsIX5lATIUqcdubkQrxN+CdZ90=
Received: by 10.213.33.135 with SMTP id h7mr1989787ebd.34.1281734620018;
        Fri, 13 Aug 2010 14:23:40 -0700 (PDT)
Received: from darc.lan ([80.123.242.182])
        by mx.google.com with ESMTPS id v59sm4962964eeh.4.2010.08.13.14.23.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 14:23:38 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1Ok1it-0006Hs-4r; Fri, 13 Aug 2010 23:23:31 +0200
Content-Disposition: inline
In-Reply-To: <20100813200031.GD2003@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153507>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Fri, Aug 13, 2010 at 03:00:31PM -0500, Jonathan Nieder wrote:
> Clemens Buchacher wrote:
>=20
> > Since commit 2f82f760 (Take binary diffs into account for "git rebase")=
, binary
> > files are included in patch ID computation. Binary files are diffed usi=
ng the
> > text diff algorithm, however
> [...]
> > Instead of hashing the diff of binary files, use the post-image sha1, w=
hich is
> > just as unique. As a result, performance is much improved.
>=20
> Maybe it should use both the pre- and post-image?

That would make the patch ID more correct in that it will identify
a particular change. But ultimately, we want to know whether or not
a change has been applied already. If the contents of a binary file
are the same in both commits, this is almost certainly true,
regardless of whether or not the pre-images match.

So I think we get better behavior if we ignore the pre-image.
Although the difference is probably minuscule.

>=20
> > diff --git a/diff.c b/diff.c
> > index 17873f3..20fc6db 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -3758,6 +3758,12 @@ static int diff_get_patch_id(struct diff_options=
 *options, unsigned char *sha1)
> >  					len2, p->two->path);
> >  		git_SHA1_Update(&ctx, buffer, len1);
> > =20
> > +		if (diff_filespec_is_binary(p->two)) {
> > +			len1 =3D sprintf(buffer, "%s", sha1_to_hex(p->two->sha1));
> > +			git_SHA1_Update(&ctx, buffer, len1);
>=20
>=20
> i.e., maybe also
>=20
> 			git_SHA1_Update(&ctx, sha1_to_hex(p->one->sha1), 40);

Thanks.

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMZbfTAAoJELKdZexG8uqM218H/24Ny32cWAH+yuTxlfvX5E4w
d92xWRWnmZ2dI1CWxE9uysYk9J2v7E/z6XUmktcCOVe1c3d6Erske6tJfTx7yYuW
yoEg9tu3NWypdV6tqhcghVyR6eiF0ecgd/B1qXX5u/MBsilHn8//BIhM/gx7YpDL
qGe4yg0afB/hrtmcmkdxAbQoVLg2hzRVjiM/MfTr3xTFLw/P78sto9GxjxSvqO+k
eYABvXtBxWF9PQyjlfwlDDrxHOyMOyCx4E01rkhWBxnWuaiWEIgBwkz1O3Ubr2AO
UgU4u6suzU54GwOpNixzKQ3Lnn+BLRZZ7/eM4moyhlgK+1kgC3skbeUT2tx0urk=
=Cnn3
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
