From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] test_must_fail: report number of unexpected signal
Date: Wed, 24 Feb 2016 02:45:49 -0500
Message-ID: <20160224074548.GC9481@sigill.intra.peff.net>
References: <20160224073603.GA9163@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 08:45:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYU8x-000197-LV
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 08:45:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757211AbcBXHpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 02:45:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:48080 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756699AbcBXHpv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 02:45:51 -0500
Received: (qmail 20684 invoked by uid 102); 24 Feb 2016 07:45:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 02:45:51 -0500
Received: (qmail 5257 invoked by uid 107); 24 Feb 2016 07:45:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 02:45:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Feb 2016 02:45:49 -0500
Content-Disposition: inline
In-Reply-To: <20160224073603.GA9163@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287179>

If a command is marked as test_must_fail but dies with a
signal, we consider that a problem and report the error to
stderr. However, we don't say _which_ signal; knowing that
can make debugging easier. Let's share as much as we know.

Signed-off-by: Jeff King <peff@peff.net>
---
Not necessary for the fix, obviously, but I implemented this while
trying to figure out what in the world was going on with the
write_or_die() thing. :)

 t/test-lib-functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index c64e5a5..8d99eb3 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -617,7 +617,7 @@ test_must_fail () {
 		return 0
 	elif test $exit_code -gt 129 && test $exit_code -le 192
 	then
-		echo >&2 "test_must_fail: died by signal: $*"
+		echo >&2 "test_must_fail: died by signal $(($exit_code - 128)): $*"
 		return 1
 	elif test $exit_code -eq 127
 	then
-- 
2.7.2.645.g4e1306c
