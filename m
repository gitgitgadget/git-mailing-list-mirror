From: Simon Richter <Simon.Richter@hogyros.de>
Subject: Re: [RFC] shallow clone
Date: Mon, 30 Jan 2006 14:25:08 +0100
Message-ID: <43DE13B4.8090403@hogyros.de>
References: <7voe1uchet.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0601301220420.6424@wbgn013.biozentrum.uni-wuerzburg.de> <43DDFF5C.30803@hogyros.de> <Pine.LNX.4.63.0601301305100.20228@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4BE69007F7D93FF1639EC478"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 14:25:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3Z23-0006YW-Qn
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 14:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWA3NZU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 08:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWA3NZU
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 08:25:20 -0500
Received: from kleinhenz.com ([213.239.205.196]:15574 "EHLO kleinhenz.com")
	by vger.kernel.org with ESMTP id S932253AbWA3NZS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jan 2006 08:25:18 -0500
Received: from [192.168.115.35] (p54995381.dip.t-dialin.net [84.153.83.129])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Simon Richter", Issuer "Kleinhenz Elektronik CA" (verified OK))
	by kleinhenz.com (Postfix) with ESMTP id AB32B4A8045;
	Mon, 30 Jan 2006 14:25:16 +0100 (CET)
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0601301305100.20228@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.93.0.0
OpenPGP: url=http://www.hogyros.de/simon.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15272>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4BE69007F7D93FF1639EC478
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Johannes Schindelin wrote:

[config as a registry]

> It is becoming sort of a registry: it contains metadata about the current 
> repository, easily available to scripts and programs.

Provided you have a parser that can handle it.

> I beg to differ on your personal opinion on the grounds that the 
> robustness comes from testing, not from diversity. I much prefer to have a 
> well tested config mechanism to having dozens of differently formatted 
> files with less-than-well tested parsers.

Indeed. But we already have a method for associating data values with 
keys in a hierarchical namespace, and that one is pretty well tested. :-)

>>Why? It's perfectly acceptable to pull from an incomplete repo, as long as you
>>don't care about the old history.

> Right. But should that be the default? I don't think so. Therefore: 
> disable it, and if the user is absolutely sure to do dumb things, she'll 
> have to enable it explicitely.

What harm is done if I have an incomplete repository? It would probably 
make more sense to emit a warning on clone and explain things if the 
user tries to go to a version she doesn't have.

>>Hrm, I think there should also be a way to shrink a repo and "forget" old
>>history occasionally (obviously, use of that feature would be highly
>>discouraged).

> Yes. And you need information about how shallow it used to be. My 
> suggestion was to store that information at a place specific to that 
> repository (see above).

Indeed, but you are keeping this information in two places, namely the 
grafts file and the config file. This is asking for trouble if they ever 
get out of sync.

>>>How about refs/tags/start_shallow?

>>No, as that would imply that cloning from such a repo is disallowed.

> See above.

Well, I can however see the use case of a developer hosting an 
incomplete repo on a free web service and another developer wanting to 
merge her changes into her (complete) repo. You would have to 
specialcase this tag in the fetch operation to avoid copying it over.

What's probably worse: You can only have a single cutoff point that way. 
You probably want multiple in case you want to cut off at a place where 
development happened in multiple branches that got subsequently merged 
inside the window of objects you keep.

> The functionality of cutoff objects is included in grafts functionality, 
> so why should we spend time on reimplementing a subset of features?

I would ask for the grafts parser to add "fake" grafts when it 
encounters the "shallow" file. Otherwise, it would be hard to 
distinguish between grafts the user made when doing interesting merges, 
and grafts that were created to build a shallow repo, because you would 
need some heuristics to figure out the latter from the former if you 
want to have a function in your porcelain to "pull more/all objects".

> I beg your pardon, you want to edit this information *by hand*? Wow.

Yes. That is actually the reason I like git so much: I can repair it by 
hand if something breaks, and this can be done with simple commands. I 
can remove an object id from a file with "grep -v" or perl. I would need 
to fire up an editor or hack a longer script if I wanted to fix 
something inside a complex file that does multiple things.

    Simon

--------------enig4BE69007F7D93FF1639EC478
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ94Tt1Yr4CN7gCINAQLC+AP9EXHoq2L3iiZ9bmApWruBOLYSc7rvnL/o
wWZtCyH3wWAKwAkX5pRq3GiXwiAUnXoCip2wMl55MA3vo8zeugmaHrYL6JQRQr0v
JKJQSLm00fN/9YtZcbuqqhXzemtJ0In3M7k4cKhaIx/GaIV5TohYKAkvFBWqRUXT
vjvUKkVmiCk=
=BcV/
-----END PGP SIGNATURE-----

--------------enig4BE69007F7D93FF1639EC478--
