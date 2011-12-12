From: mhagger@alum.mit.edu
Subject: [PATCH v2 26/51] check_refname_component(): return 0 for zero-length components
Date: Mon, 12 Dec 2011 06:38:33 +0100
Message-ID: <1323668338-1764-27-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:41:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZydN-0000k3-L8
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:41:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760Ab1LLFkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:40:22 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34762 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737Ab1LLFkT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:40:19 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8ad015577;
	Mon, 12 Dec 2011 06:40:09 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186845>

From: Michael Haggerty <mhagger@alum.mit.edu>

Return 0 (instead of -1) for zero-length components.  Move the
interpretation of zero-length components as illegal to
check_refname_format().

This will make it easier to extend check_refname_format() to also
check whether directory names are valid.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 99667fc..e29f76c 100644
--- a/refs.c
+++ b/refs.c
@@ -51,7 +51,7 @@ static int check_refname_component(const char *refname, int flags)
 		last = ch;
 	}
 	if (cp == refname)
-		return -1; /* Component has zero length. */
+		return 0; /* Component has zero length. */
 	if (refname[0] == '.') {
 		if (!(flags & REFNAME_DOT_COMPONENT))
 			return -1; /* Component starts with '.'. */
@@ -74,7 +74,7 @@ int check_refname_format(const char *refname, int flags)
 	while (1) {
 		/* We are at the start of a path component. */
 		component_len = check_refname_component(refname, flags);
-		if (component_len < 0) {
+		if (component_len <= 0) {
 			if ((flags & REFNAME_REFSPEC_PATTERN) &&
 					refname[0] == '*' &&
 					(refname[1] == '\0' || refname[1] == '/')) {
-- 
1.7.8
