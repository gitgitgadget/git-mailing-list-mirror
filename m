From: mhagger@alum.mit.edu
Subject: [PATCH 10/15] check_refname_component(): return 0 for zero-length components
Date: Tue, 10 Apr 2012 07:30:22 +0200
Message-ID: <1334035827-20331-11-git-send-email-mhagger@alum.mit.edu>
References: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 07:31:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHTg0-0002SQ-Fq
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 07:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611Ab2DJFbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 01:31:23 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:59269 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422Ab2DJFbU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 01:31:20 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p4FC0B8CA.dip.t-dialin.net [79.192.184.202])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3A5UXe3000870;
	Tue, 10 Apr 2012 07:30:57 +0200
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195067>

From: Michael Haggerty <mhagger@alum.mit.edu>

Return 0 (instead of -1) for zero-length components.  Move the
interpretation of zero-length components as illegal to
check_refname_format().

This will make it easier to extend check_refname_format() to also
check whether directory names are valid.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 8659c3e..1f6890b 100644
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
1.7.10
