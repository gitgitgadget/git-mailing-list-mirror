From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jul 2009, #01; Mon, 06)
Date: Tue, 7 Jul 2009 17:11:09 -0400
Message-ID: <20090707211109.GA1922@coredump.intra.peff.net>
References: <7vk52l4q7k.fsf@alter.siamese.dyndns.org>
 <ca433830907061918s6c674bf6w2f8d166f645d4e33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Marcus Camen <mcamen@mcamen.de>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 23:11:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOHwi-0000EW-JA
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 23:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756060AbZGGVLN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jul 2009 17:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755296AbZGGVLM
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 17:11:12 -0400
Received: from peff.net ([208.65.91.99]:45131 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753508AbZGGVLL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 17:11:11 -0400
Received: (qmail 6368 invoked by uid 107); 7 Jul 2009 21:13:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 07 Jul 2009 17:13:05 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jul 2009 17:11:09 -0400
Content-Disposition: inline
In-Reply-To: <ca433830907061918s6c674bf6w2f8d166f645d4e33@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122877>

On Mon, Jul 06, 2009 at 10:18:03PM -0400, Mark Lodato wrote:

> > * ml/http (Wed May 27 23:16:03 2009 -0400) 2 commits
> > =C2=A0- http.c: add http.sslCertPasswordProtected option
> > =C2=A0- http.c: prompt for SSL client certificate password
> [...]
>=20
> Sorry for the lack of updates.  After hearing feedback, the consensus
> seemed to be that detection of the certificate's encryption (above)
> and file type (other patch, not in git.git) should be done
> automatically, that is, without user configuration.  I agree, but
> neither can be done without great difficulty outside of libcurl.
> Therefore, I have started implement the autodetection of both, as wel=
l
> as the password caching, directly in libcurl.  If my work, once
> completed, is accepted by the libcurl folks, then there would be no
> need for the above, and we should recommend upgrading libcurl for
> those who want to use client-side certificates.
>=20
> However, in the interim, and for users with earlier libcurl versions
> (and especially if my libcurl patch is never accepted), it might be
> nice to still have the above commits.  They are unobtrusive - the
> patches are small, and they do not affect users who do not enable the
> option - yet they drastically improve the experience for those using
> password-protected client-side certificates.

Yes, even if you get patches into libcurl, we will be supporting libcur=
l
without this feature for some time. So I think the right upgrade path
is:

  1. add sslCertPasswordProtected as a bool config option now, defaulti=
ng
     to false (i.e., your patches)

  2. libcurl grows new auto-detect feature

  3. When the new feature is available at build-time, turn
     sslCertPasswordProtected into a tri-state yes/no/auto, defaulting =
to
     "auto". For older libcurl, setting it to "auto" should probably
     generate an error (or perhaps simply default to "no").

IOW, whether the libcurl auto-detection feature happens or not, your
patches are the right first step (and if "not", then they are the final
step :) ).

-Peff
