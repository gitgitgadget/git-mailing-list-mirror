From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: RAM consumption when working with the gcc repo
Date: Sat, 8 Dec 2007 18:24:37 +0100
Message-ID: <20071208172437.GA24442@auto.tuwien.ac.at>
References: <9e4733910712071207p750c14f4h7abc5d637da3a478@mail.gmail.com> <Pine.LNX.4.64.0712071323260.12607@asgard.lang.hm> <alpine.LFD.0.99999.0712071529580.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: david@lang.hm, Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Dec 08 18:25:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J13QI-00015w-Cd
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 18:25:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbXLHRYp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Dec 2007 12:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbXLHRYp
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 12:24:45 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:60532 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbXLHRYo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 12:24:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 2A5CB680BF71;
	Sat,  8 Dec 2007 18:24:38 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xRcxEztDiywM; Sat,  8 Dec 2007 18:24:38 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 03DE1680BF6D; Sat,  8 Dec 2007 18:24:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.99999.0712071529580.555@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67562>

On Fri, Dec 07, 2007 at 03:46:30PM -0500, Nicolas Pitre wrote:
> On Fri, 7 Dec 2007, david@lang.hm wrote:
> > On Fri, 7 Dec 2007, Jon Smirl wrote:
> >=20
> > > I noticed two things when doing a repack of the gcc repo. First i=
s
> > > that the git process is getting to be way too big. Turning off th=
e
> > > delta caches had minimal impact. Why does the process still grow =
to
> > > 4.8GB?
> > >=20
> > > Putting this in perspective, this is a 4.8GB process constructing=
 a
> > > 330MB file. Something isn't right. Memory leak or inefficient dat=
a
> > > structure?
> >=20
> > keep in mind that that 330MB file is _very_ heavily compressed. the=
 simple
> > zlib compression is probably getting you 10:1 or 20:1 compression a=
nd the
> > delta compression is a significant multiplier on top of that.
>=20
> Doesn't matter.  Something is indeed fishy.
>=20
> The bulk of pack-objects memory consumption can be estimated as follo=
ws:
>=20
> 1M objects * sizeof(struct object_entry) ~=3D 100MB
> 256 window entries with data (assuming a big 1MB per entry) =3D 256MB

=46or each (uncompressed) object in the delta window, a delta index is
created. It can have the same size as the uncompressed object.

Each thread has its own window, so using 4 threads means having 1024 ob=
jects=20
in memory =3D> 1 GB

> Delta result caching was disabled therefore 0MB
> read-side delta cache limited to 16MB
>=20
> So the purely ram allocation might get to roughly 400MB.
>=20
> Then add the pack and index map, which, depending on the original pac=
k=20
> size,
> might be 2GB.
>=20
> So we're pessimistically talking of about 2.5GB of virtual space.
>=20
> The other 2.3GB is hard to explain.

mfg Martin K=F6gler
