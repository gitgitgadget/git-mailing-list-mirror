From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <carlos@cmartin.tk>
Subject: [GSoC 11] libgit2: midterm report
Date: Tue, 19 Jul 2011 02:07:03 +0200
Message-ID: <1311034023.4147.949.camel@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-fBr3wzkABftBY6yt/z13"
To: libgit2@librelist.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 19 02:07:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QixqL-0003bx-AM
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 02:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583Ab1GSAHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 20:07:06 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:47815 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881Ab1GSAHF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 20:07:05 -0400
Received: from [192.168.1.23] (brln-4d0c3c8c.pool.mediaWays.net [77.12.60.140])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id B5BDD461FF;
	Tue, 19 Jul 2011 02:07:02 +0200 (CEST)
X-Mailer: Evolution 2.32.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177431>


--=-fBr3wzkABftBY6yt/z13
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

As it's the GSoC midterm and I'm taking a rest from coding (my exams are
in the next few days) I'm taking this opportunity to write up a more
detailed report on what has been happening on the libgit2 network front.
All the code is available from my 'fork' on github.

The more useful working code has been merged into mainline, and you can
get a list of references on the remote. If you want to filter which
references you want to see, you can do that as well (with some manual
work). I had hoped that fetching and/or pack indexing would be working
by now, but sadly the university got in the way. At any rate, here's a
list of what's working/implemented:

   _Refspec_

I believe all the important stuff has been implemented. You can get one
from a remote and you can see if a string matches what it describes. You
can also transform  a string/path from the source to the destination
form (this probably has a different name in git.git). The transformation
code assumes that a '*' in the destination implies that there is a '*'
at the end of the source name as well. This might need to be 'hardened'.

   _Remotes_

You can parse its information from the configuration file (the push and
fetch refspecs will be parsed as well) and an appropriate transport (see
below) will be chosen based on the URL prefix. Right now there is a
static list, but plug-ins could be supported without much effort if
somebody can come up with an use-case. It is through these transports
that everything is done through the network (or simulating the network,
as in the local filesystem "network" transport).


   _Transports_

This is where most of the work actually happens. Each transport
registers its callbacks in a structure and does its work transparently.
The data structures are still in flux, as I haven't yet found the best
way to avoid duplicating the information in several places, and the
want/have/need code is really still in it infancy. The idea is that the
object list you get when you connect can be used to mark which commits
you want to receive or send. Right now only the local filesystem and
git/tcp are implemented; and the only working operation is
'git-ls-remote'.

   _Sliding memory maps, packfile reading and the indexer_

Or whatever you want to call them; I believe it's mmfile in git. This
code and the packfile reading code live in the "pack ODB backend" so I'm
making it somewhat more generic so I can use it without an ODB backend.
Once that code is decoupled (which is a good change on its own), writing
and indexer shouldn't be too hard.

-----

So this is where I am now. I'm a bit behind according to the original
schedule but still on track to finish on time. It's been interesting and
fun, sometimes a bit frustrating. Thanks to all the people who have
helped me thus far.

Cheers,
   cmn



--=-fBr3wzkABftBY6yt/z13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOJMqdAAoJEHKRP1jG7ZzTFvgH+gN6YQMk/79hCBaV5L2RyC7r
zIY1lCWiXRd5n531CRoZe/dh5+kOOpREBccYDNAUElORseUiSs+SAREmvM8xVDM1
O7rHBXwznC2Bubsu7BpuFay+JMSLZJ21heLyFwiRiSK17IG7KTJ9SG9pdf/CDAbG
SOGt6NLdlE50jNh7NsXGhlWCHoTC77QE7fBHqZb/fasu75C2TZ8gvkT7F5eGiaiy
s5FzdDwaMBk0qj0q9OTJYWKMh+qlmyUQ7dElOo4cOJCbCDiRa3KKE1MhQeCkXQ+I
bawHkdlG71d04WPMSwoZ9HPK+7wdcNG1U+5C0OId423AGF0idRZoJm86XFWGh9Q=
=azO1
-----END PGP SIGNATURE-----

--=-fBr3wzkABftBY6yt/z13--
