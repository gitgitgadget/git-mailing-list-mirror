From: mhagger@alum.mit.edu
Subject: [PATCH 6/6] do_for_each_extra_ref(): simplify signature
Date: Tue, 13 Dec 2011 21:06:51 +0100
Message-ID: <1323806811-5798-7-git-send-email-mhagger@alum.mit.edu>
References: <1323806811-5798-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 21:07:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaYdG-0001PP-5P
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 21:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755724Ab1LMUHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 15:07:11 -0500
Received: from mail.berlin.jpk.com ([212.222.128.130]:37227 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755714Ab1LMUHI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 15:07:08 -0500
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RaYUZ-0006aj-6V; Tue, 13 Dec 2011 20:58:23 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323806811-5798-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187055>

From: Michael Haggerty <mhagger@alum.mit.edu>

Now that do_for_each_extra_ref() is only called from one place, it can
be less general.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index f52d8b5..4b2ba3f 100644
--- a/refs.c
+++ b/refs.c
@@ -706,19 +706,15 @@ fallback:
 	return -1;
 }
 
-static int do_for_each_extra_ref(const char *base, each_ref_fn fn,
-				 int trim, void *cb_data)
+static int do_for_each_extra_ref(each_ref_fn fn, void *cb_data)
 {
 	struct extra_ref *extra;
 
 	current_ref = NULL;
 	for (extra = extra_refs; extra; extra = extra->next) {
-		if (!prefixcmp(extra->name, base)) {
-			int retval = fn(extra->name + trim, extra->sha1,
-					0, cb_data);
-			if (retval)
-				return retval;
-		}
+		int retval = fn(extra->name, extra->sha1, 0, cb_data);
+		if (retval)
+			return retval;
 	}
 	return 0;
 }
@@ -794,7 +790,7 @@ int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 
 int for_each_ref(each_ref_fn fn, void *cb_data)
 {
-	int retval = do_for_each_extra_ref("", fn, 0, cb_data);
+	int retval = do_for_each_extra_ref(fn, cb_data);
 	if (retval)
 		return retval;
 	return do_for_each_ref(NULL, "", fn, 0, 0, cb_data);
-- 
1.7.8
