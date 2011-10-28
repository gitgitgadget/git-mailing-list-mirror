From: mhagger@alum.mit.edu
Subject: [PATCH 03/28] check_refname_component(): return 0 for zero-length components
Date: Fri, 28 Oct 2011 14:28:16 +0200
Message-ID: <1319804921-17545-4-git-send-email-mhagger@alum.mit.edu>
References: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 14:28:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJlYO-0003RI-Mu
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 14:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549Ab1J1M2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 08:28:51 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:55685 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755597Ab1J1M2u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 08:28:50 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJlRw-0007Ud-Ey; Fri, 28 Oct 2011 14:22:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184375>

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
index eff1abe..61dfb32 100644
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
1.7.7
