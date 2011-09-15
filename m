From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 15/22] resolve_ref(): do not follow incorrectly-formatted symbolic refs
Date: Thu, 15 Sep 2011 23:10:36 +0200
Message-ID: <1316121043-29367-16-git-send-email-mhagger@alum.mit.edu>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 23:19:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4JLC-0001GW-3Z
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 23:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935029Ab1IOVTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 17:19:15 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:40226 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935026Ab1IOVTO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 17:19:14 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1R4J8x-00019o-UG; Thu, 15 Sep 2011 23:06:47 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181515>

Emit a warning and fail if a symbolic reference refers to an
incorrectly-formatted refname.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index 473f7f6..b055501 100644
--- a/refs.c
+++ b/refs.c
@@ -581,6 +581,11 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 		buf = buffer + 4;
 		while (isspace(*buf))
 			buf++;
+		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
+			warning("symbolic reference in %s is formatted incorrectly",
+				path);
+			return NULL;
+		}
 		ref = strcpy(ref_buffer, buf);
 		if (flag)
 			*flag |= REF_ISSYMREF;
-- 
1.7.6.8.gd2879
