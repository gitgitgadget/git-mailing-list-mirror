From: Rudolf Polzer <divVerent@alientrap.org>
Subject: Re: [PATCH] git push --track
Date: Thu, 14 Jan 2010 08:00:02 +0100
Message-ID: <20100114070000.GA1528@rm.endoftheinternet.org>
References: <op.u6g8jnixg402ra@nb-04> <20100113154310.GA7348@Knoppix> <op.u6haiiiog402ra@nb-04> <be6fef0d1001132121w4e25c7f0j760d71c136012401@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Miles Bader <miles@gnu.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 08:22:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVK1q-0004uD-PP
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 08:22:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756365Ab0ANHVw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jan 2010 02:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756316Ab0ANHVv
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 02:21:51 -0500
Received: from rm.endoftheinternet.org ([94.23.21.40]:56180 "EHLO
	r23604.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756344Ab0ANHVu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 02:21:50 -0500
Received: from rpolzer by r23604.ovh.net with local (Exim 4.69)
	(envelope-from <divVerent@alientrap.org>)
	id 1NVJgY-0000V0-Iz; Thu, 14 Jan 2010 08:00:02 +0100
Content-Disposition: inline
In-Reply-To: <be6fef0d1001132121w4e25c7f0j760d71c136012401@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136960>

On Thu, Jan 14, 2010 at 01:21:17PM +0800, Tay Ray Chuan wrote:
> Hi,
>=20
> generally, it would be better if you could add some tests for this.
>=20
> If I'm not wrong, the place to put it would be t5516-fetch-push.sh.

Can add that, but it seems like it won't go in anyway from the discussi=
on here,
so it's probably not worth working on it. Sad.

> On Wed, Jan 13, 2010 at 11:55 PM, Rudolf Polzer <divVerent@alientrap.=
org> wrote:
> > On Wed, 13 Jan 2010 16:43:10 +0100, Ilari Liusvaara
> > <ilari.liusvaara@elisanet.fi> wrote:
>=20
> please don't drop people from the Cc list - especially when you're
> replying to somebody!

I did not drop anyone, but simply replied from my newsreader. I really =
don't
want to subscribe to a mailing list and then get hundreds of emails a d=
ay.

> > From 123598516c7d4e1f83591e8dae64e2c76dc87c90 Mon Sep 17 00:00:00 2=
001
> > From: Rudolf Polzer <divVerent@alientrap.org>
> > Date: Wed, 13 Jan 2010 16:42:04 +0100
> > Subject: [PATCH 1/2] Add a feature "git push --track" to automatica=
lly make
> > the pushed branches tracking
>=20
> Each patch should be sent out in its own mail. (As Matthieu has
> recommended, you should check out Documentation/SubmittingPatches.)

So, using a newsreader is not accepted practice? Why is the mailing lis=
t on a
newsgroup then?

> > =A0static const char * const push_usage[] =3D {
> > @@ -115,6 +116,36 @@ static int push_with_options(struct transport
> > *transport, int flags)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fprintf(stderr, "Pushing to %s\n", t=
ransport->url);
> > =A0 =A0 =A0 =A0err =3D transport_push(transport, refspec_nr, refspe=
c, flags,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &nonfastfor=
ward);
> > + =A0 =A0 =A0 if (err =3D=3D 0 && flags & TRANSPORT_PUSH_TRACK) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct ref *remote_refs =3D
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 transport->get_refs_l=
ist(transport, 1);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct ref *local_refs =3D get_local_=
heads();
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int match_flags =3D 0;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (flags & TRANSPORT_PUSH_ALL)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 match_flags |=3D MATC=
H_REFS_ALL;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (flags & TRANSPORT_PUSH_MIRROR)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 match_flags |=3D MATC=
H_REFS_MIRROR;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if(!(flags & TRANSPORT_PUSH_DRY_RUN))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if(!match_refs(local_refs, &remote_re=
fs, refspec_nr,
> > refspec,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 match_flags)) {
>=20
> It would be better if you can move this to
> transport.c::transport_push(). It repeats what's already there, so yo=
u
> don't have to configure match_flags, nor call match_refs, etc.

Then I have to duplicate it in the rsync specific push code too. Otherw=
ise,
agreed.

> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct ref *next =3D =
remote_refs;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while(next) {
> > [snip]
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 next =
=3D next->next;
>=20
> In most places, this is done like this:
>=20
>   struct ref* ref;
>   for (ref =3D remote_refs; ref; ref =3D ref->next) {
>     ...
>   }

Sure, could do that too, I got this loop from the loop that frees a ref=
 list.

Best regards,

Rudolf
