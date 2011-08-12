From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/6] Extract a function clear_cached_refs()
Date: Sat, 13 Aug 2011 00:36:24 +0200
Message-ID: <1313188589-2330-2-git-send-email-mhagger@alum.mit.edu>
References: <1313188589-2330-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 00:37:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qs0Lz-0005Kf-Mz
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 00:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589Ab1HLWhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 18:37:21 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:41143 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab1HLWhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 18:37:16 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.homenet.telecomitalia.it (p54BEAA34.dip.t-dialin.net [84.190.170.52])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p7CMaXJO010513;
	Sat, 13 Aug 2011 00:36:56 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1313188589-2330-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179259>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 6f313a9..b0c8308 100644
--- a/refs.c
+++ b/refs.c
@@ -171,10 +171,8 @@ static void free_ref_list(struct ref_list *list)
 	}
 }
 
-static void invalidate_cached_refs(void)
+static void clear_cached_refs(struct cached_refs *ca)
 {
-	struct cached_refs *ca = &cached_refs;
-
 	if (ca->did_loose && ca->loose)
 		free_ref_list(ca->loose);
 	if (ca->did_packed && ca->packed)
@@ -183,6 +181,11 @@ static void invalidate_cached_refs(void)
 	ca->did_loose = ca->did_packed = 0;
 }
 
+static void invalidate_cached_refs(void)
+{
+	clear_cached_refs(&cached_refs);
+}
+
 static void read_packed_refs(FILE *f, struct cached_refs *cached_refs)
 {
 	struct ref_list *list = NULL;
-- 
1.7.6.8.gd2879
