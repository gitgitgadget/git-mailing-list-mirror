From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC 0/2] git-svn: Allow certain refs to be ignored
Date: Wed, 21 Apr 2010 09:54:52 -0700
Message-ID: <20100421165451.GA14004@dcvr.yhbt.net>
References: <o2xc8b3bef91004201430m10bbe060q7d8ebd3a1ac4c3bd@mail.gmail.com> <7vbpddekwk.fsf@alter.siamese.dyndns.org> <m2wc8b3bef91004210931xc0a7ec58ycbf18dd37d5e98f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Tim Stoakes <tim@stoakes.net>, Sam Vilain <sam@vilain.net>
To: Michael Olson <mwolson@gnu.org>
X-From: git-owner@vger.kernel.org Wed Apr 21 18:55:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4dCV-000618-Ku
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 18:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590Ab0DUQyy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Apr 2010 12:54:54 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33205 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035Ab0DUQyx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 12:54:53 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 491B81F500;
	Wed, 21 Apr 2010 16:54:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <m2wc8b3bef91004210931xc0a7ec58ycbf18dd37d5e98f0@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145441>

Michael Olson <mwolson@gnu.org> wrote:
> On Tue, Apr 20, 2010 at 4:58 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
> > Michael Olson <mwolson@gnu.org> writes:
> >
> >> [svn-remote "svn"]
> >> =A0 =A0 =A0 =A0url =3D https://svn.my.org/svn/root
> >> ...
> >> =A0 =A0 =A0 =A0ignore-refs =3D ^refs/remotes/(tags/)?old/myorg
> >
> > Traditionally configuration variable names are spelled camelCase wi=
thout
> > dashes. =A0You probably would want to be consistent.
>=20
> I was looking at the existing syntax for "ignore-paths", which uses
> dashes.  Should that be changed as well?

Yes, I missed that the first time around :x

I suppose that should be changed to work both ways.

> > Also "refs" and any pathname-like things are traditionally matched =
using
> > globs and not regexes. =A0It is Ok to deviate if you have a strong =
reason to
> > (and I suspect it would make it easier to write "exclude" patterns =
like
> > the above example to allow a regex here), but that needs to be prom=
inently
> > documented (e.g. "Unlike any other ref-matching configuration varia=
ble,
> > this alone uses regex, not glob") to avoid end user confusion.
>=20
> ignore-paths also uses a regex.  I'm concerned that using globs will
> not be expressive enough to represent a regex like (a combination of
> the 2 use cases I posted initially):

I also missed that (I never used that feature :x)

> ^refs/remotes/((tags/)?old/myorg|old/bad_branch|old/unlabeled[^/]*|ta=
gs/(old/bad_tag|releases/another_tag))$

I wonder if both would be better as a series of globs would be
easier to read (maybe more verbose to write):

	ignoreRefs =3D refs/remotes/tags/old/myorg
	ignoreRefs =3D refs/remotes/old/myorg
	ignoreRefs =3D refs/remotes/old/unlabeled/*

But I suppose the regexp route is fine.  I'll ack and push them
out with Sam's Ack on 2/2

--=20
Eric Wong
