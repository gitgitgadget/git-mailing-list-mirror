From: Jeff King <peff@peff.net>
Subject: [PATCH] config.c: mark die_bad_number as NORETURN
Date: Wed, 16 Apr 2014 12:51:47 -0400
Message-ID: <20140416165146.GA16695@sigill.intra.peff.net>
References: <20140416141353.GA9676@camelia.ucw.cz>
 <20140416152920.GA4691@sigill.intra.peff.net>
 <534EB1FB.5040405@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	kasal@ucw.cz
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 16 18:51:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaT3y-0001Eo-19
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 18:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753794AbaDPQvt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Apr 2014 12:51:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:60930 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752554AbaDPQvt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 12:51:49 -0400
Received: (qmail 28568 invoked by uid 102); 16 Apr 2014 16:51:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 16 Apr 2014 11:51:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Apr 2014 12:51:47 -0400
Content-Disposition: inline
In-Reply-To: <534EB1FB.5040405@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246344>

On Wed, Apr 16, 2014 at 06:38:19PM +0200, Torsten B=C3=B6gershausen wro=
te:

> > Does that also silence the warning?
> >=20
> This works under gcc 4.2.1 Mac OS: the warning is away.

Thanks. I couldn't test myself, as I could not get gcc to generate the
warning in the first place, but I do not have anything as old as 4.2 on
hand.

Here it is with a commit message.

-- >8 --
Subject: config.c: mark die_bad_number as NORETURN

This can help avoid -Wuninitialized false positives in
git_config_int and git_config_ulong, as the compiler now
knows that we do not return "ret" if we hit the error
codepath.

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.c b/config.c
index 6821cef..a30cb5c 100644
--- a/config.c
+++ b/config.c
@@ -557,6 +557,7 @@ int git_parse_ulong(const char *value, unsigned lon=
g *ret)
 	return 1;
 }
=20
+NORETURN
 static void die_bad_number(const char *name, const char *value)
 {
 	const char *reason =3D errno =3D=3D ERANGE ?
--=20
1.9.1.656.ge8a0637
