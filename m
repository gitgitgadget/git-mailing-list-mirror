From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: cg-export incompatible with older versions of GNU tar
Date: Thu, 22 Sep 2005 21:13:26 +0200
Message-ID: <43330256.7000505@lsrfire.ath.cx>
References: <20050922124338.246D535267B@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 21:15:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIWVj-0002u9-Dt
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 21:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbVIVTNd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 22 Sep 2005 15:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbVIVTNd
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 15:13:33 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:36762 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751124AbVIVTNc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2005 15:13:32 -0400
Received: from [10.0.1.3] (p508E4B22.dip.t-dialin.net [80.142.75.34])
	by neapel230.server4you.de (Postfix) with ESMTP id 0E0B9239;
	Thu, 22 Sep 2005 21:13:30 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20050922124338.246D535267B@atlas.denx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9139>

Wolfgang Denk wrote:
> In message <20050922120841.GH21019@pasky.or.cz> you wrote:
>=20
>>>-> tar jxf foo.tar.bz2=20
>>>tar: pax_global_header: Unknown file type 'g', extracted as normal f=
ile
>>>...
>=20
>=20
>>It is unclear if the tar actually extracts the archive or not, though=
=2E
>>Does it just complain with those warnings, or are they fatal errors?
>=20
>=20
> In this case extraction went fine, except for the warning message.

And you get an extra file, pax_global_header, containing the commit ID
of the archive's contents.

> I had other error reports from customers befroe, where unpacking  the
> tarballs failed - instead of the origianl source tree just a bunch of
> *.data  and  *.paxheader  were created; error messages in these cases
> looked like this:
>=20
> tar: pax_global_header: Unknown file type 'g', extracted as normal fi=
le
> tar: ea1efd7f213469bcde030e00ac9f89ed16256869.paxheader: Unknown file=
 type 'x', extracted as normal file

[snip]

This happens when you have pathes inside the tar file that are longer
than 100 characters.  Is this taken from a real-world project or is it
just some test?

All your files with pathes longer than 100 chars will be extracted as
<SHA1>.data, with an accompanying <SHA1>.paxheader file.  The latter
contains the real filename.  You could then repair the mess by renaming
them manually or write a script that does it for you.  Or you could
simply update tar. :-)

Lately I noticed that the tar version used by the BSDs also doesn't
understand Pax extended headers.  I guess they're not that popular a
feature.

> [But this was with older versions of git / cogito, so I'm not sure if
> this still applies.]

Nothing has changed in this respect, basicly since git-tar-tree went in=
=2E

Ren=E9
