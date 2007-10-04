From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: git-cvsserver test failures (still)
Date: Thu, 4 Oct 2007 03:19:54 +0200
Message-ID: <20071004011954.GK18024@planck.djpig.de>
References: <A78B5F62-4FCC-4650-9B0D-0F64FEDB8423@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 03:20:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdFOG-0000Wf-Hf
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 03:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755337AbXJDBUL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Oct 2007 21:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752658AbXJDBUL
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 21:20:11 -0400
Received: from planck.djpig.de ([85.10.192.180]:4538 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754970AbXJDBUG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 21:20:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id C4B1A88231;
	Thu,  4 Oct 2007 03:20:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PDXHbQBkCe8Q; Thu,  4 Oct 2007 03:19:54 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 8C0F888232; Thu,  4 Oct 2007 03:19:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <A78B5F62-4FCC-4650-9B0D-0F64FEDB8423@silverinsanity.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59915>

Hi.

Some investigations on this:

On Wed, Oct 03, 2007 at 03:50:18PM -0400, Brian Gernhardt wrote:
> This appears to be from git-cvsserver.perl:148-9:
>=20
>     req_Root('root', $line) # reuse Root
>        or die "E Invalid root $line \n";
>=20
> This fails the test suite because die() exits with code 255 (checked =
=20
> with "perl -e 'die'; echo $?"), which is outside what =20
> test_expect_failure accepts (see t/test-lib.sh:179).
>=20
> My questions become:
> 1) Why hasn't this hit anyone else?

die doesn't always quit with 255:

"exits with the current value of $! (errno).  If $! is 0, exits with th=
e
value of "($? >> 8)" (backtick =E2=80=98command=E2=80=98 status).  If "=
($? >> 8)" is 0,
exits with 255"

On my system $! is 9 for these cases and so it exits with exit code 9.

> 2) Is this where these tests are supposed to fail?

yes, IIRC

> 3) If it is, should the code be using print and exit 1 instead of die=
?

I think that would be the best solution, yes.

> 4) If not, should the test be altered to end with "|| false" or =20
> similar so the test passes?

Gruesse,
--=20
=46rank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
