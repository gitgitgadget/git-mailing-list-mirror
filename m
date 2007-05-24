From: "Fernando J. Pereda" <ferdy@gentoo.org>
Subject: Re: [PATCH] Teach mailsplit about Maildir's
Date: Thu, 24 May 2007 21:56:08 +0200
Message-ID: <20070524195608.GA4714@ferdyx.org>
References: <20070520181447.GA10638@ferdyx.org> <7vd50uj29r.fsf@assigned-by-dhcp.cox.net> <20070521182052.GB4696@ferdyx.org> <7vd50qvwaz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 21:56:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrJQ2-00022D-VR
	for gcvg-git@gmane.org; Thu, 24 May 2007 21:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbXEXT4Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 24 May 2007 15:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbXEXT4Q
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 15:56:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:4372 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbXEXT4O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 15:56:14 -0400
Received: by ug-out-1314.google.com with SMTP id j3so950304ugf
        for <git@vger.kernel.org>; Thu, 24 May 2007 12:56:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:sender;
        b=I12uqBTzgFscyeUO6rGtPvkHoE/6cL85UpFeW4bWaUrHwrf5H5e7z6W9OJVOuh7AyGsL5KMcTMWYPFj39XbdSQfdRizpZo6U/LLjO8dxFsvPFINOM8uyN5krS0fNPWy1t7MKge/DENsY8u+h+O44UVMo+UyumcMhGgEyXMrUxTI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:sender;
        b=d1J1oAqtQbGbtlfhPbFvX6mRtTVH5CyyTqogRQNvchE2x2YPJYtCjGWwzcervwZB3tK0Kn+qvj47aj1Pzt8Pk2uh/GXo+v/R2Paf3r3BoRqydWgB7GJ7zs5ZZ/+eNWM++8JII6ft7ufrncl9A5a8DOXz/DvgV0ErYdfjB9ZMugg=
Received: by 10.67.29.7 with SMTP id g7mr2386830ugj.1180036573190;
        Thu, 24 May 2007 12:56:13 -0700 (PDT)
Received: from posidon.ferdyx.org ( [213.96.222.170])
        by mx.google.com with ESMTP id s7sm6447796uge.2007.05.24.12.56.09;
        Thu, 24 May 2007 12:56:11 -0700 (PDT)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	ferdy@gentoo.org; Thu, 24 May 2007 21:56:10 +0200 (CEST)
Mail-Followup-To: "Fernando J. Pereda" <ferdy@gentoo.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vd50qvwaz.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48301>

On Thu, May 24, 2007 at 12:47:00PM -0700, Junio C Hamano wrote:
> "Fernando J. Pereda" <ferdy@gentoo.org> writes:
> >           [--whitespace=3D<option>] [-C<n>] [-p<n>]
> > -         <mbox>...
> > +         <mbox>|<Maildir>...
> > +
> >  'git-am' [--skip | --resolved]
>=20
> Does the document still format Ok if you add a blank line there
> (not a rhetorical question -- I haven't checked)?

I think I tried when I first sent it, will try.

> > +
> > +	if ((dir =3D opendir(path)) =3D=3D NULL) {
> > +		error("cannot diropen %s (%s)", path, strerror(errno));
> > +		return -1;
> > +	}
>=20
> Didn't you just fail opendir, not diropen?

Ouch, will fix

> > +	return 1;
> > +}
>=20
> Usually we signal success by returning 0.

Ok. Fair enough.

>=20
> > +static int split_maildir(const char *maildir, const char *dir,
> > +	int nr_prec, int skip)
> > +{
> > +	char file[PATH_MAX];
> > +	char curdir[PATH_MAX];
> > +	char name[PATH_MAX];
> >  	int ret =3D -1;
> > +	struct path_list list =3D {NULL, 0, 0, 1};
> > =20
> > +	snprintf(curdir, sizeof(curdir), "%s/cur", maildir);
> > +	if (populate_maildir_list(&list, curdir) < 0)
> > +		goto out;
> > =20
> > +	int i;
>=20
> Decl-after-statement.

I did it because other parts of the file do it too. Do you want me to
fix the rest of them?

>=20
> > +	for (i =3D 0; i < list.nr; i++) {
> > +		snprintf(file, sizeof(file), "%s/%s", curdir, list.items[i].path=
);
> > +		FILE *f =3D fopen(file, "r");
>=20
> Likewise.

Again, because we were already doing it in other parts of the file. Wil=
l
fix.

>=20
> > @@ -186,9 +249,39 @@ int cmd_mailsplit(int argc, const char **argv,=
 const char *prefix)
> > ...
> > +		if (ret < 0) {
> > +			error("cannot split patches from %s", arg);
> > +			return 1;
> > +		}
> > +		num +=3D ret;
> > +	}
> > +
> > +	printf("%d\n", num);
> > =20
> > -	return ret =3D=3D -1;
> > +	return 0;
> >  }
>=20
> We do not signal error anymore from the command?

If we reached that part of the code, there is no error to signal about.
We signal error when either split_mbox or split_maildir fail by
returning 1.

Will fix those issues and send a new patch. Thanks for reviewing it.

- ferdy

--=20
=46ernando J. Pereda Garcimart=EDn
20BB BDC3 761A 4781 E6ED  ED0B 0A48 5B0C 60BD 28D4
