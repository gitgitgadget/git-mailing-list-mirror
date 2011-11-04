From: Jeff King <peff@peff.net>
Subject: Re: aliases causing =?utf-8?B?4oCcUGVybWlz?=
 =?utf-8?Q?sion_denied=E2=80=9D?= error in git v1.7
Date: Fri, 4 Nov 2011 16:34:15 -0400
Message-ID: <20111104203415.GB26591@sigill.intra.peff.net>
References: <CALUFZ3n9cpHw3r3rcGriDqvJ+UM83L3Q19m=0YeAy51LBJzosA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?0JDQu9C10LrRgdC10Lkg0JTQsNC90YfQtdC90LrQvtCy?= 
	<adanchenkov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 04 21:34:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMQT5-0003Ie-TT
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 21:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601Ab1KDUeS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Nov 2011 16:34:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33650
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752556Ab1KDUeR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 16:34:17 -0400
Received: (qmail 5524 invoked by uid 107); 4 Nov 2011 20:34:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 04 Nov 2011 16:34:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Nov 2011 16:34:15 -0400
Content-Disposition: inline
In-Reply-To: <CALUFZ3n9cpHw3r3rcGriDqvJ+UM83L3Q19m=0YeAy51LBJzosA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184803>

On Fri, Nov 04, 2011 at 12:09:07PM +0400, =D0=90=D0=BB=D0=B5=D0=BA=D1=81=
=D0=B5=D0=B9 =D0=94=D0=B0=D0=BD=D1=87=D0=B5=D0=BD=D0=BA=D0=BE=D0=B2 wro=
te:

> $ git co -b newbranch
> $ git co oldbranch
>=20
> results in "fatal: cannot exec 'git-co': Permission denied" error.

Git will try commands in your PATH before aliases. So you are running
into a permissions problem with a "git-co" in your PATH.

Or more likely, there is an inaccessible directory of your PATH (and we
get the same error code from execve whether it is the directory or the
file itself which lacks permission). Try "git foobar" and I suspect you
will see the same thing (it doesn't matter that you have no foobar
alias; we never get past the "try to exec it" stage).

If you are on Linux, try:

  strace -f -e execve git foobar

to see the the problematic entry that is returning EACCES. Or look
through your $PATH manually.

-Peff
