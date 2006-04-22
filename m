From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: RFC: New diff-delta.c implementation
Date: Sat, 22 Apr 2006 14:36:04 +0200
Message-ID: <444A2334.3030501@lsrfire.ath.cx>
References: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 22 22:12:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXOSZ-0008Iy-SK
	for gcvg-git@gmane.org; Sat, 22 Apr 2006 22:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWDVULy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 22 Apr 2006 16:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWDVULx
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Apr 2006 16:11:53 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:18633 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751132AbWDVULv (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Apr 2006 16:11:51 -0400
Received: from neapel230.server4you.de (static-ip-217-172-187-230.inaddr.intergenia.de [217.172.187.230])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id k3MCadFF031567
	for <git@vger.kernel.org>; Sat, 22 Apr 2006 12:36:40 GMT
Received: from [10.0.1.3] (p508E6DDF.dip.t-dialin.net [80.142.109.223])
	by neapel230.server4you.de (Postfix) with ESMTP id 9B3DE100A8;
	Sat, 22 Apr 2006 14:36:07 +0200 (CEST)
User-Agent: Thunderbird 1.5 (Windows/20051201)
To: Geert Bosch <bosch@adacore.com>
In-Reply-To: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com>
X-Virus-Scanned: ClamAV 0.88/1414/Fri Apr 21 22:58:39 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19051>

Hello Geert,

Geert Bosch schrieb:
> I wrote a new binary differencing algorithm that is both faster and
> generates smaller deltas than the current implementation. The format
> is compatible with that used by patch-delta, so it should be easy to
> integrate.
[...]
> Initial testing seems quite positive, take for example git-1.2.5.tar
> vs git-1.2.6.tar on my PowerBook (both with -O2 -DNDEBUG):
>=20
> current: 2.281s, patch size 36563
> new    : 0.109s, patch size 16199
>=20
> Please feel free to play around with this code, and give feedback.=20
> Keep in mind this wasn't originally written for GIT, and C is not my
> native language, so don't mind my formatting etc.

nice speedup!  Though I cannot comment on what it actually does, I have
some comments on style. B-)

Could you please send your code inline, not as an attachment?  And
possibly as a patch with a Signed-off-by: tag (see
Documentation/SubmittingPatches)?

Regarding your FIXME comment about endianess: I think you are looking
for htonl().  Use it to convert the values from host byte order to
network byte order (=3D big endian) and you can get rid of those ugly
branches.

You can use "indent -npro -kr -i8 -ts8 -l80 -ss -ncs" to reformat your
code into a similar style as used in the rest of git (settings taken
from Lindent which is shipped with the Linux source).

After converting to htonl() "make test" ran fine on my x86 box.  Here i=
s
what I get when I try to repack the git repo, though:

   $ git repack -a -d
   Generating pack...
   Done counting 18985 objects.
   Deltifying 18985 objects.
   git-pack-objects: diff-delta.c:766: create_delta: Assertion `ptr -
delta =3D=3D (int)delta_size' failed.

Please let me know if you need more details.

Thanks,
Ren=E9
