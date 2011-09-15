From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 20/22] resolve_ref(): also treat a too-long SHA1 as invalid
Date: Thu, 15 Sep 2011 23:10:41 +0200
Message-ID: <1316121043-29367-21-git-send-email-mhagger@alum.mit.edu>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 23:19:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4JLD-0001GW-Pk
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 23:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935037Ab1IOVTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 17:19:23 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:40248 "EHLO
	homer.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934943Ab1IOVTW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 17:19:22 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1R4J94-00019o-P4; Thu, 15 Sep 2011 23:06:54 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181518>

If the SHA1 in a reference file is not terminated by a space or
end-of-file, consider it malformed and emit a warning.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index 2387f4e..0baa500 100644
--- a/refs.c
+++ b/refs.c
@@ -593,7 +593,8 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 		if (flag)
 			*flag |= REF_ISSYMREF;
 	}
-	if (get_sha1_hex(buffer, sha1)) {
+	/* Please note that FETCH_HEAD has a second line containing other data. */
+	if (get_sha1_hex(buffer, sha1) || (buffer[40] != '\0' && !isspace(buffer[40]))) {
 		warning("reference in %s is formatted incorrectly", path);
 		return NULL;
 	}
-- 
1.7.6.8.gd2879
