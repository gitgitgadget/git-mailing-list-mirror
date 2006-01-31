From: Simon Richter <Simon.Richter@hogyros.de>
Subject: Re: [RFC] shallow clone
Date: Tue, 31 Jan 2006 14:05:16 +0100
Message-ID: <43DF608C.1060201@hogyros.de>
References: <7voe1uchet.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0601301220420.6424@wbgn013.biozentrum.uni-wuerzburg.de> <43DDFF5C.30803@hogyros.de> <Pine.LNX.4.63.0601301305100.20228@wbgn013.biozentrum.uni-wuerzburg.de> <7vzmld7c2g.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0601311127490.25248@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4107A3CC2EEAB17C2D6FEEB4"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 14:06:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3vCi-0003SQ-Cy
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 14:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWAaNFo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 08:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWAaNFo
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 08:05:44 -0500
Received: from kleinhenz.com ([213.239.205.196]:49110 "EHLO kleinhenz.com")
	by vger.kernel.org with ESMTP id S1750784AbWAaNFn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 08:05:43 -0500
Received: from [192.168.115.35] (p54995B2F.dip.t-dialin.net [84.153.91.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Simon Richter", Issuer "Kleinhenz Elektronik CA" (verified OK))
	by kleinhenz.com (Postfix) with ESMTP id 9DB1F4A8045;
	Tue, 31 Jan 2006 14:05:27 +0100 (CET)
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0601311127490.25248@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.93.0.0
OpenPGP: url=http://www.hogyros.de/simon.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15312>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4107A3CC2EEAB17C2D6FEEB4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Johannes Schindelin wrote:

>>If the downstream person wants to have a shallow history of post
>>X.org X server core to further hack on it, I do not think of a
>>reason why we would want to refuse her from cloning a repository
>>of a fellow developer who has already done such a shallow copy.

> Okay. But in their case, they'll probably do what was done with Linux: 
> start afresh. If you want to have the old history, you can import it and 
> merge it via a graft.

Well, in the Linux case the problem was not knowing what the SHA1 sum of 
the entire Linux history was. In the shallow repo case we know it, so 
there is no point in throwing away that information.

>>If such a clone is done without telling the downstream that the
>>result is a shallow one, it is "dumb".  I would agree it should
>>not be done.

> That was my point. As long as you don't make sure the client handles the 
> shallow upstream gracefully, it is dangerous. At the moment, there are too 
> many code parts relying on the completeness of the repository (local and 
> remote).

Well, the important thing would be that commands that can work (a merge 
only needs to find the most recent common ancestor, etc) do work, and 
commands that cannot ("log") emit sensible diagnostics.

> Just imagine this: Alice starts a project, Bob makes a shallow copy from 
> it when Alice just reverted an experimental feature. Then, Alice decides 
> the experimental feature was not bad at all and reverts the revert. Bob 
> pulls from Alice: Alice's upload-pack assumes Bob already has the original 
> files (now re-reverted), and Bob ends up with a broken repository.

I know far too little about the internal workings for that, but I'd 
assume that in this case Bob's copy starts at the commit that was never 
in question (and he never saw the reverted commit), and Alice's contains 
a commit on top of that. That one should work. But the other way 'round 
is problematic, when Bob starts with a commit that has been reverted in 
Alice's repository. The solution is for Bob to ask Alice's repo for the 
common ancestor of his shallow base and Alice's HEAD. Alice's repo can, 
however, fail to deliver these if there has been a purge since, in that 
case, stuff needs to be merged by hand (but you already have a problem 
if someone clones your repo before you revert changes, so no regression 
here).

> If you now rely on the grafts file to determine what was a cutoff, you may 
> well end up with bogus cutoffs.

Exactly that was my concern earlier; my database design gut feeling 
tells me that information duplication is not good either, hence my 
suggestion to split off these grafts into a separate file in order to 
mark them as cutoff points.

    Simon

--------------enig4107A3CC2EEAB17C2D6FEEB4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ99gj1Yr4CN7gCINAQJxYwP8CosNi2aRDV0eaIkY5VpxnPyV4AjTzr1i
wEBFSwZEpwokzjZZeK8u54W5NCTomD/lHgbF6/Ac+z6ax/Dm6QbACnhsr/zS9MxO
6rNekr+vvHpgFGepEjWknWXDHWE0uMf0DKqFuvUoKZ+bUaY1QK+SppRQo/485Gs0
cxwE5U1zt48=
=kCG7
-----END PGP SIGNATURE-----

--------------enig4107A3CC2EEAB17C2D6FEEB4--
