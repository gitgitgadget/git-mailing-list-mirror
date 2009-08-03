From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: git for pushing local subdir to website
Date: Mon, 3 Aug 2009 12:58:09 -0600
Organization: icecavern.net
Message-ID: <200908031258.13787.wjl@icecavern.net>
References: <13f0168a0908031011odd98c03ye08a1b0774fca523@mail.gmail.com> <200908031201.41039.wjl@icecavern.net> <13f0168a0908031109h10c02424l91938918639c6a57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart20164101.Sysvvkhopq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matt Di Pasquale <pasquale@fas.harvard.edu>
X-From: git-owner@vger.kernel.org Mon Aug 03 20:58:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY2jy-0003s8-Kn
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 20:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069AbZHCS6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 14:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753550AbZHCS6W
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 14:58:22 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:53067 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753531AbZHCS6V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 14:58:21 -0400
Received: from tonberry.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id 978AC35A3B;
	Mon,  3 Aug 2009 20:58:19 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.29-2-amd64; KDE/4.2.2; x86_64; ; )
In-Reply-To: <13f0168a0908031109h10c02424l91938918639c6a57@mail.gmail.com>
X-Face: #;qMWg=Msk*d]z]X1P2-t9]~6+RoGF$nJo89f%|Y`^whfl3Wj$X2Q_1u)ZAW@Hx|g)J]!)
 =?utf-8?q?=0A=09Br0=3FK3Imj?=)np=]r*QN,Q8].V99^Og'xl-d9FM~$yaSGB"mfXb>x[QNi[()
 =?utf-8?q?oob=60/4M42=26We=0A=09cC1jq=3DQ=5CS?=@ck\>H@
 =?utf-8?q?t=26Y7Y=3Apub=3DHOWqY=7D-d=5CwrCxvsTo7k1Ek=7DqQO=5D5=7EngK=5E=25?=
 =?utf-8?q?cT5IzmmG=5BQ=0A=09Nha=7D=5DAmI=60R-6m84VcWT4=236c?=)1`>t{$~l6:gZMtv18ge'!d[Yk-/?T3>C5O-|6On4(
 =?utf-8?q?N=7BAV=23=0A=094Eyw52=5B=3A=25Z?=>#"c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124716>

--nextPart20164101.Sysvvkhopq
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 03 August 2009 12:09:26 Matt Di Pasquale wrote:
> yes... i've thought of that. that's a good idea. i just love git and
> i've never really used rsync. how do i do that?
> i'll go google it..

Rsync can do a lot of things, but the usual easy way to do it is to do=20
something like this to send files via rsync over an ssh connection:

rsync -av /some_dir/ user@host:/some_dir/

This is essentially the same as using scp, but rsync saves a lot of network=
=20
bandwidth by only sending the changes between the source and destination.

> i guess it would also be nice to use git though incase i decide i want
> a collaborator, right?

Setting things up to have a collaboration is kind of orthogonal to=20
installing a production version of your app, but you could use the same=20
server (and possibly the same git repository) for both things if you wanted=
=20
to.

Here an example of one way to do it:

On the server you could have a normal git repository in, say,=20
/home/me/myapp, and it always has the "production" branch checked out. So=20
now the following directories are interesting:

/home/me/myapp              -- repository branch w/ "production" checked out
/home/me/myapp/.git         -- the actual bare git repository
/home/me/myapp/example.com/ -- the files that the web server should see

Now, you can use symlinks (or web-server configuration) to point the=20
webserver to the right locations, for example:

http://example.com/myapp/     -- link to /home/me/myapp/example.com/
http://example.com/myapp.git/ -- link to /home/me/myapp/.git/

Now, collaborators can pull from the http://example.com/myapp.git and get=20
the whole project, but access to http://example.com/myapp/ sees the=20
example.com subdir as it's root, and everything works normally (assuming=20
webserver configuration & permissions are correct).

Now you work on whatever branches you want, and push to the server whenever=
=20
you want for collaboration using whatever branches you want. As far as the=
=20
webserver is concerned, nothing changes when you do a push.

Then, when you are ready to change the website, you put your production=20
changes on the "production" branch, push them, and make sure they are=20
checked out on the server (git push doesn't automatically check out the=20
files), e.g.:

client$ # just made changes in production branch and want them "live"
client$ git push

server$ cd /home/me/myapp
server$ git reset --hard

> how would u set it up?

Personally, I might set something like this if I had a good reason, but=20
otherwise, I'd host my git repository for collaboration separately, and jus=
t=20
use rsync to install production files on the server. For one thing, that=20
needs less prerequisites and setup on the server, so it's good if you don't=
=20
fully control the server.

Either way, a "production" branch is a good idea so you know logically=20
exactly what and when you released things live.

--nextPart20164101.Sysvvkhopq
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkp3M0EACgkQ8KmKTEzW49IidgCff7VMVpz36LJpvXzX1dB8hHZN
XJ0An3K7Uo4/7iV72UUJz2xYxQ6kPnH4
=gHyG
-----END PGP SIGNATURE-----

--nextPart20164101.Sysvvkhopq--
