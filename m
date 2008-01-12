From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: Re-casing directories on case-insensitive systems
Date: Sat, 12 Jan 2008 01:15:40 +0100
Message-ID: <200801120115.41274.robin.rosenberg@dewire.com>
References: <579DF776-4F4E-464C-88DB-B22C2EC291BD@sb.org> <200801120026.01930.robin.rosenberg@dewire.com> <1973E1D5-C8CC-4979-A085-85A2C5A13E57@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sat Jan 12 01:16:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDU32-0000l9-C6
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 01:16:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223AbYALAPw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jan 2008 19:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752275AbYALAPw
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 19:15:52 -0500
Received: from [83.140.172.130] ([83.140.172.130]:8048 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752096AbYALAPv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 19:15:51 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9BDC880267F;
	Sat, 12 Jan 2008 01:15:50 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hk+OrjqA4e-Q; Sat, 12 Jan 2008 01:15:50 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id D3F26802643;
	Sat, 12 Jan 2008 01:15:49 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <1973E1D5-C8CC-4979-A085-85A2C5A13E57@sb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70230>

l=C3=B6rdagen den 12 januari 2008 skrev Kevin Ballard:
> Speaking of normalizing composed sequences, could that be the cause =20
> for the following?
[...]
> kevin@KBALLARD:~/Dev/git/gitweb/test> ls M=C3=A4rchen | xxd
> 0000000: 4d61 cc88 7263 6865 6e0a                 Ma..rchen.
>=20
> As you can see, git has the file tracked using M\303\244rchen, where =
=20
> \303\244 (or 0xC3A4, or U+00E4) is Latin Small Letter A With =20
> Diaeresis, but the filesystem reports it as "Ma\xCC\x88rchen" where =20
> 0xCC88 (or U+0308) is Combining Diaeresis.

Yes that is due to normalization. When adding a file by name git uses t=
he user=20
supplied name, but when adding files indirectly it gets the names from =
the=20
file system without denormalizing them. Likewize status gets the names =
from
the file system without denormalizing and thus you get a mismatch.

-- robin
