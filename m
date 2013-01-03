From: Jeff King <peff@peff.net>
Subject: [PATCH] tests: turn on test-lint by default
Date: Thu, 3 Jan 2013 02:17:51 -0500
Message-ID: <20130103071751.GA32377@sigill.intra.peff.net>
References: <201301012240.10722.tboegi@web.de>
 <20130102094635.GD9328@sigill.intra.peff.net>
 <50E4BF58.4090808@web.de>
 <20130102232239.GA27952@sigill.intra.peff.net>
 <50E4C9B5.8070308@web.de>
 <7vlicbyvc2.fsf@alter.siamese.dyndns.org>
 <50E4CF7E.9090302@web.de>
 <7vhamzyqev.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 08:18:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tqf4D-00067z-6P
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 08:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852Ab3ACHR6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jan 2013 02:17:58 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41823 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751422Ab3ACHR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 02:17:57 -0500
Received: (qmail 4397 invoked by uid 107); 3 Jan 2013 07:19:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 03 Jan 2013 02:19:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jan 2013 02:17:51 -0500
Content-Disposition: inline
In-Reply-To: <7vhamzyqev.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212572>

On Wed, Jan 02, 2013 at 06:02:48PM -0800, Junio C Hamano wrote:

> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
> > When the dust has settled, we can either enable the check always,
> > or mention "make test-lint-shell-syntax" in the Documentation.
>=20
> In the longer term, I'm pretty much in favor of enabling all the
> checks that are cheap by default, as that would help people catch
> easy mistakes while preparing their patches.  People do not tend to
> enable any check if it were optional.

That is fine with me, and I always intended that we turn the lint on by
default at some point (I'm not really sure why we didn't -- looking at
the list archives, I think I did not push it because it seemed like
nobody was really that interested).

Certainly the two existing checks are cheap and do not produce false
positives, and should be safe to turn on. Like this:

-- >8 --
Subject: [PATCH] tests: turn on test-lint by default

The test Makefile knows about a few "lint" checks for common
errors. However, they are not enabled as part of "make test"
by default, which means that many people do not bother
running them. Since they are both quick to run and accurate
(i.e., no false positives), there should be no harm in
turning them on and helping submitters catch errors earlier.

We could just set:

  TEST_LINT =3D test-lint

to enable all tests. But that would be unnecessarily
annoying later on if we add slower or less accurate tests
that should not be part of the default. Instead, we name the
tests individually.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/Makefile b/t/Makefile
index 3025418..5c6de81 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -13,6 +13,7 @@ DEFAULT_TEST_TARGET ?=3D test
 RM ?=3D rm -f
 PROVE ?=3D prove
 DEFAULT_TEST_TARGET ?=3D test
+TEST_LINT ?=3D test-lint-duplicates test-lint-executable
=20
 # Shell quote;
 SHELL_PATH_SQ =3D $(subst ','\'',$(SHELL_PATH))
--=20
1.8.1.rc3.4.gf3a2f57





> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
