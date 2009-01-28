From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: (beginner) git rm
Date: Wed, 28 Jan 2009 23:13:55 +0100
Message-ID: <20090128221355.GE7503@atjola.homenet>
References: <1233137498146-2231416.post@n2.nabble.com> <Pine.LNX.4.64.0901281133380.645@ds9.cixit.se> <1233140751523-2231622.post@n2.nabble.com> <49804385.908@dbservice.com> <1233144045221-2231849.post@n2.nabble.com> <49804D41.3010801@dbservice.com> <1233166992184-2233892.post@n2.nabble.com> <20090128201727.GD7503@atjola.homenet> <1233175322729-2234796.post@n2.nabble.com> <7vab9bm85b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Zabre <427@free.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 23:17:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSIi9-0002nx-NN
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 23:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330AbZA1WPB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jan 2009 17:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbZA1WPA
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 17:15:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:51575 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751121AbZA1WO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 17:14:59 -0500
Received: (qmail invoked by alias); 28 Jan 2009 22:14:57 -0000
Received: from i577BB3F1.versanet.de (EHLO atjola.local) [87.123.179.241]
  by mail.gmx.net (mp010) with SMTP; 28 Jan 2009 23:14:57 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18/OHJP9Lo/pHprxxjSYX6X5b9JYoFBXr4VYQKye1
	7fhrLO16vVoXPf
Content-Disposition: inline
In-Reply-To: <7vab9bm85b.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107587>

[Zabre, please keep the Cc: list when replying]

On 2009.01.28 13:29:36 -0800, Junio C Hamano wrote:
> Zabre <427@free.fr> writes:
> > Bj=F6rn Steinbrink wrote:
> >>=20
> >> The "git checkout -- d.txt" is also a valid command, but that rest=
ores
> >> the file from the index.
> >>=20
> >> git checkout -- paths
> >> 	=3D=3D> Copy "paths" from the index to the working tree
> >>=20
> >> git checkout <tree-ish> -- paths
> >> 	=3D=3D> Copy "paths" from the tree-ish to the index and working t=
ree
> >>=20
> >> So, for "rm d.txt", a plain "git checkout -- d.txt" would also do =
the
> >> trick, as d.txt is still in the index. But your "git rm d.txt" als=
o
> >> removed the file from the index, and thus that checkout does nothi=
ng.
> >> But "git checkout HEAD -- d.txt" works, as it gets the file from H=
EAD
> >> and puts it into the index and working tree.
> >
> > This is enlightening, thank you very much!
> > (I knew I would love git more and more)
> >
> > Oh just one (probably stupid) thing : <tree-ish> does represent a d=
irectory
> > being the root of a tree of folders (which has been added to the in=
dex),
> > does it?
>=20
> Yeah, it typically is a commit object.
>=20
> Bj=F6rn said "Copy", but the operation really is like checking out a =
book
> from a library and "checkout" is a good word for it.  "I do not like =
what
> I have in my work tree, and I'd like to replace it with a fresh one t=
aken
> out of the index (or, out of that commit)".

With "checkout", I'm still a bit unsure about which term to use, becaus=
e
of the behaviour you get with, for example, "git checkout HEAD --
directory". It always just adds or replaces files, but never removes
them. So it's not really like taking the old directory out of the repo
and using that instead. For example:

git rm dir/old_file
echo 123 > dir/new_file
git add dir/new_file
git checkout HEAD -- dir

That won't remove dir/new_file from the index (and of course it won't
drop it from the working tree). That's the one thing where "git checkou=
t
HEAD -- dir" differs from "git reset HEAD -- dir && git checkout --
dir". IIRC we've talked about that on #git a few months ago, but I don'=
t
recall what conclusions we came up with.

It would probably be better to say that checkout only works with the
blobs (because the index doesn't have entries for trees, right?) that
exist in the given tree-ish. And thus it doesn't remove entries from th=
e
index. But that feels a bit convoluted. :-/

Bj=F6rn
