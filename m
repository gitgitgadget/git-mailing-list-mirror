From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Serious bug with pretty format strings & empty bodies?
Date: Wed, 19 Dec 2007 19:28:37 +0100
Message-ID: <476962D5.3050409@lsrfire.ath.cx>
References: <57518fd10712190632o490af924n61326fddf1819014@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 19:29:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J53fe-0006ue-Co
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 19:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126AbXLSS3G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 13:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752252AbXLSS3F
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 13:29:05 -0500
Received: from india601.server4you.de ([85.25.151.105]:49642 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbXLSS3E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 13:29:04 -0500
Received: from [10.0.1.201] (p57B7FDB3.dip.t-dialin.net [87.183.253.179])
	by india601.server4you.de (Postfix) with ESMTP id B74A82F8072;
	Wed, 19 Dec 2007 19:28:55 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <57518fd10712190632o490af924n61326fddf1819014@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68928>

Jonathan del Strother schrieb:
> I'm struggling to come up with a minimal test case that confirms this=
,
> but I seem to be hitting a bug in the pretty string formatter when
> trying to print bodies of commits that don't have bodies.
>=20
> For example, on a private repository, I'm trying to print the subject
> & body of a commit.  This particular commit doesn't actually have a
> body, so I'm expecting to see this output :
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> commit 18d2480ab689b483ef1ebbdb3f7420904049ba0b
> Try to flush log files before terminating the app
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> However, when I actually run the command, I get gibberish in place of=
 %b :
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> $ git rev-list -1- --pretty=3Dformat:"%s%n%b"
> 18d2480ab689b483ef1ebbdb3f7420904049ba0b
> commit 18d2480ab689b483ef1ebbdb3f7420904049ba0b
> Try to flush log files before terminating the app
> tree 57bc7cf30a10aee96251852125cf30fd2c81d7aa
> parent 04c833865828538315fcdf6e187da077869ce444
> author Jonathan del Strother <jon.delStrother@bestbefore.tv> 11979017=
55 +0000
> committer Jonathan del Strother <jon.delStrother@bestbefore.tv> 11979=
01755 +0000
>=20
> Check that ThreadWorker's work method actually returns a value with
> method signatures
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> So here you can see that the full details of a different commit is
> appearing in place of the requested commit's (empty) body.  Rerunning
> the rev-list produces the same output - the same string appears in
> place of %b every time, but it's different for each commit.  Often yo=
u
> only get a small fragment of another commit's message, rather than th=
e
> full commit as seen above.
>=20
> When I use --pretty=3Dfull, it works fine.
>=20
> This appears in quite a few places in my repository's history.
> Repacking the repo semi-fixes it - I still get junk bodies, but not
> quite so many.
>=20
> It doesn't always happen when a commit message body is empty, but I'v=
e
> never seen it happen where the message body has something in.
>=20
> This happens with both git 1.5.3.7 and 1.5.4.rc0.1162.g3bfea, though
> the output is slightly different - the former has a number of
> <unknown> markers in it.  This is on OS X 10.5.1

That's strange.  Could you check if this happens with e52a5de, too?
That's the commit that introduced --pretty=3Dformat.  If it doesn't, co=
uld
you then please try to bisect the bug?

How many '<unknown>' markers are there in the output of version 1.5.3.7
(and e52a5de)?  One per %b?  Are they the only output or are they
combined with parts of unrelated commits, too?

Thanks,
Ren=E9
