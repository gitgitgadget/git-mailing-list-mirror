From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/16] foreach_alt_odb: propagate return value from
 callback
Date: Fri, 3 Oct 2014 20:31:48 -0400
Message-ID: <20141004003148.GF17063@peff.net>
References: <20141003202045.GA15205@peff.net>
 <20141003202104.GA16293@peff.net>
 <542F2951.5050203@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sat Oct 04 02:32:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XaDGU-0001bd-8H
	for gcvg-git-2@plane.gmane.org; Sat, 04 Oct 2014 02:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932965AbaJDAb6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Oct 2014 20:31:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:54990 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932066AbaJDAb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 20:31:56 -0400
Received: (qmail 13199 invoked by uid 102); 4 Oct 2014 00:31:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 19:31:56 -0500
Received: (qmail 16619 invoked by uid 107); 4 Oct 2014 00:31:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 20:31:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Oct 2014 20:31:48 -0400
Content-Disposition: inline
In-Reply-To: <542F2951.5050203@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257886>

On Sat, Oct 04, 2014 at 12:55:13AM +0200, Ren=C3=A9 Scharfe wrote:

> >-void foreach_alt_odb(alt_odb_fn fn, void *cb)
> >+int foreach_alt_odb(alt_odb_fn fn, void *cb)
> >  {
> >  	struct alternate_object_database *ent;
> >+	int r =3D 0;
> >
> >  	prepare_alt_odb();
> >-	for (ent =3D alt_odb_list; ent; ent =3D ent->next)
> >-		if (fn(ent, cb))
> >-			return;
> >+	for (ent =3D alt_odb_list; ent; ent =3D ent->next) {
> >+		int r =3D fn(ent, cb);
> >+		if (r)
> >+			break;
> >+	}
> >+	return r;
>=20
> This will always return zero.  You probably shadowed r unintentionall=
y
> inside the loop, right?

Eek, yes. Thanks for catching. I'll fix it in the re-roll.

-Peff
