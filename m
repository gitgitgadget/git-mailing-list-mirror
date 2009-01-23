From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH] contrib git-resurrect: find traces of a branch name and resurrect it
Date: Fri, 23 Jan 2009 15:00:17 -0600
Message-ID: <200901231500.23182.bss@iguanasuicide.net>
References: <200901201450.53450.bss@iguanasuicide.net> <1232740985-4551-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2547033.Mx3BKTHTD9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jan 23 22:01:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQT99-0008Dt-GD
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 22:00:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755103AbZAWU7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 15:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754721AbZAWU7f
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 15:59:35 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:44905 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273AbZAWU7e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 15:59:34 -0500
Received: from [63.167.78.78]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LQT7l-0002i9-0M; Fri, 23 Jan 2009 20:59:33 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <1232740985-4551-1-git-send-email-trast@student.ethz.ch>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106914>

--nextPart2547033.Mx3BKTHTD9
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 2009 January 23 14:03:05 Thomas Rast wrote:
>Boyd Stephen Smith Jr. wrote:
>> I think it could be quite nice; "undelete"-type commands are generally
>> well-received by users and when run against reflogs alone, that's what t=
he
>> command is.
>>
>> It's useful enough to me that I'd love to see it mainlined.
>
>So here's a version for contrib with more options and some other
>tweaks.

I wanted/needed the ability to ignore reflogs entirely.  Use went something=
=20
like this:
1. resurrect branch from origin/pu
2. add patches, mail to list
3. # wait 24 hours
4. pull, see from logs that branch was modified, but not just my changes (o=
r=20
without all of my changes).
5. delete local branch
6. Try to resurrect branch from origin/pu, get local version I just deleted.
7. delete reflog for that branch
8. Try to resurrect branch from origin/pu, get local version I merged into=
=20
master at some point.
9. Add new option.

So, I added a couple of options locally: --only-merges, so it would only lo=
ok=20
at the first line of commit logs, ignoring my local reflogs entirely;=20
and --revisions, to specify arguments to pass to rev-list so it wouldn't ev=
en=20
see my local merges (I passed 'origin/pu origin/next').

Yeah, my usage might be abusage, but it worked for me. :)

Would you object to a patch adding a --reflog option and allowing each of t=
he=20
scan options to be negated?

>I removed the ability to "batch resurrect" with several <name>
>arguments since that would have conflicted with -b <newname>, but
>otherwise the features are the same.

In my local version, which I was going to try and clean up over the weekend=
, I=20
was going to support both, by borrowing refspec syntax from fetch/push. =20
Specifically.  Resurrecting 'js/notes' as 'pu/js/notes' would look like:
git-resurrect -H js/notes:pu/js/notes

Would you object to a patch that dropped -b in favor of the refspec syntax?

>> In my particular case, it wasn't useful without the -m option, but I
>> understand why it is not the default.
>
>Aside from the obvious speed reasons, I don't really want to teach
>people that commits "know" the branch they were on.  It is a pure
>coincidence if you can resurrect a topic branch from merge messages;
>an equivalent merge could have gone through as a fast-forward, and
>you'd never know.

Yeah, agreed.  I made this more clear in my local version by changing the=20
documentation from "scan for merges" to "scan first line of commit messages=
=20
for possible merges".  It's more wordy, but it make it clear that it is=20
dependent on the message, and it's not tracked outside of that.

I also tend to merge topic branches with --no-ff so that I do get the merge=
=20
message, so it has a better chance of working against my repository.  (I al=
so=20
enjoy octopus merging when possible so the history indicates the patch sets=
=20
are separable, but maybe I'm just a little "touched" and haven't been bitte=
n=20
by by an octopus yet.[1])

Not directly related to any issue you bring up:

There seems to be some needless redundancy between USAGE and OPTIONS_SPEC.

Would you object to a patch that used $USAGE inside OPTIONS_SPEC?
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

[1] I hear they are even more feral than penguins.

--nextPart2547033.Mx3BKTHTD9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkl6L+cACgkQdNbfk+86fC3iwwCfe5DIKP5wR+HiHucOCCJocQnO
F84Anj71HrhCjkDFRubbeTi9u47IwV7i
=p93f
-----END PGP SIGNATURE-----

--nextPart2547033.Mx3BKTHTD9--
