From: Jeff King <peff@peff.net>
Subject: Re: Using filter-branch to move repo contents in subdirectory
Date: Wed, 11 Aug 2010 15:32:14 -0400
Message-ID: <20100811193214.GB8106@coredump.intra.peff.net>
References: <AANLkTik2dL5jrEjZe0LB6Y4_PEwRt-7t_5CG7gup3pnV@mail.gmail.com>
 <AANLkTi=TeJvF+swpMWddDtA7jh4XWedQ+FjigEdRYkx_@mail.gmail.com>
 <AANLkTimu+V8zJeBV65nhqw0zaQHVHzZZahw2q-20SaWO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Adam Mercer <ramercer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 21:32:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjH2H-0004XB-OY
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 21:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758517Ab0HKTcT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 15:32:19 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:39384 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756390Ab0HKTcS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 15:32:18 -0400
Received: (qmail 6516 invoked by uid 111); 11 Aug 2010 19:32:17 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Wed, 11 Aug 2010 19:32:17 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Aug 2010 15:32:14 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimu+V8zJeBV65nhqw0zaQHVHzZZahw2q-20SaWO@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153291>

On Wed, Aug 11, 2010 at 10:01:15AM -0500, Adam Mercer wrote:

> On Mon, Aug 9, 2010 at 14:36, Adam Mercer <ramercer@gmail.com> wrote:
>=20
> > I'm trying to do this with another repo now and am getting a differ=
ent
> > error message:
> >
> > $ git filter-branch --index-filter \
> > =C2=A0 =C2=A0'git ls-files -s | gsed "s-\t\"*-&sftlib/-" |
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0GIT_INDEX_FILE=3D$GIT_INDEX_FILE.new \
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git update-index --index-i=
nfo &&
> > =C2=A0 =C2=A0mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD
> > Rewrite b3100fb24a7eb2f349801f3b87cf995dc3d14bba (1/44)mv:
> > /Users/ram/git/eah2/.git-rewrite/t/../index.new: No such file or
> > directory
> > index filter failed: git ls-files -s | gsed "s-\t\"*-&sftlib/-" |
> > GIT_INDEX_FILE=3D$GIT_INDEX_FILE.new git update-index --index-info =
&& mv
> > $GIT_INDEX_FILE.new $GIT_INDEX_FILE
> > $
> >
> > Any ideas?
> >
> > This is on Mac OS X 10.6.4, with git-1.7.2.1, and GNU sed 4.2.1
>=20
> Anyone?

It looks like git-update-index will not create $GIT_INDEX_FILE at all i=
f
you have no actual input lines to --index-info. So perhaps you have som=
e
commit in your repo that has no actual content in it. Either that or
for some reason your "ls-files -s | gsed" invocation is producing no
output.

Try adding a "touch $GIT_INDEX_FILE.new" at the beginning of your index
filter and see if that helps. Then the file will always exist to be
moved, even if we write nothing to it. If it works, then problem solved=
=2E
If you get a repo full of empty commits, then something is wrong with
your gsed pipeline.

-Peff
