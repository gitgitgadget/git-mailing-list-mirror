From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 12/22] resolve_ref(): only follow a symlink that contains a valid, normalized refname
Date: Thu, 15 Sep 2011 23:10:33 +0200
Message-ID: <1316121043-29367-13-git-send-email-mhagger@alum.mit.edu>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 23:19:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4JKx-00016R-60
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 23:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935021Ab1IOVTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 17:19:00 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:40196 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935018Ab1IOVS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 17:18:59 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1R4J8t-00019o-P6; Thu, 15 Sep 2011 23:06:43 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181514>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index da9737f..8f0b871 100644
--- a/refs.c
+++ b/refs.c
@@ -521,7 +521,8 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 			if (len < 0)
 				return NULL;
 			buffer[len] = 0;
-			if (!prefixcmp(buffer, "refs/")) {
+			if (!prefixcmp(buffer, "refs/") &&
+					!check_refname_format(buffer, 0)) {
 				strcpy(ref_buffer, buffer);
 				ref = ref_buffer;
 				if (flag)
-- 
1.7.6.8.gd2879
