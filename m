From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH v3] merge-base: teach "git merge-base" to accept more than 2 arguments
Date: Wed, 30 Jul 2008 06:52:41 +0200
Message-ID: <200807300652.41404.chriscool@tuxfamily.org>
References: <20080728065023.743930d6.chriscool@tuxfamily.org> <alpine.DEB.1.00.0807281328520.2725@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 30 06:50:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO3dS-0002LU-MN
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 06:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbYG3Es4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jul 2008 00:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbYG3Es4
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 00:48:56 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:41523 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101AbYG3Esz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jul 2008 00:48:55 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 1646A12B6D7;
	Wed, 30 Jul 2008 06:48:54 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g19.free.fr (Postfix) with ESMTP id BC11712B6C7;
	Wed, 30 Jul 2008 06:48:53 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0807281328520.2725@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90736>

Hi,

Le lundi 28 juillet 2008, Johannes Schindelin a =E9crit :
> Hi,
>
> On Mon, 28 Jul 2008, Christian Couder wrote:
> > +	rev =3D xmalloc((argc - 1) * sizeof(*rev));
> > +
> > +	do {
> > +		struct commit *r =3D get_commit_reference(argv[1]);
> > +		if (!r)
> > +			return 1;
> > +		rev[rev_nr++] =3D r;
> > +		argc--; argv++;
> > +	} while (argc > 1);
> > +
> > +	return show_merge_base(rev, rev_nr, show_all);
>
> 	rev =3D xmalloc((argc - 1) * sizeof(*rev));
>
> 	for (rev_nr =3D 0; rev_nr + 1 < argc; rev_nr++) {
> 		rev[rev_nr] =3D get_commit_reference(argv[rev_nr + 1]);
> 		if (!rev[rev_nr])
> 			return !!error("Does not refer to a commit: '%s'",
> 				argv[rev_nr + 1]);
> 	}
>
> 	return show_merge_base(rev, rev_nr, show_all);
>
> I do not know about you, but I think this is not only shorter (in spi=
te
> of adding a helpful error message), but also simpler to understand (n=
ot
> using convoluted do { } while logic), and therefore superior.

In my last version the loop is reduced to:

+	do {
+		rev[rev_nr++] =3D get_commit_reference(argv[1]);
+		argc--; argv++;
+	} while (argc > 1);

so it's very simple.

And the stop condition is simpler in my version.

> Your performance argument is weak IMHO, as this is not a big performa=
nce
> hit, and command line parameter parsing is definitely not performance
> critical.

It feels a bit sloppy though.

Regards,
Christian.
