From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 2/3] transport-helper: emit check-connectivity, cloning, and update-shallow options for import
Date: Thu, 12 Feb 2015 19:10:00 +0900
Message-ID: <1423735801-11108-2-git-send-email-mh@glandium.org>
References: <1423735801-11108-1-git-send-email-mh@glandium.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 11:10:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLqjD-0007f6-1e
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 11:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755205AbbBLKKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 05:10:21 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:47769 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751429AbbBLKKL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 05:10:11 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YLqif-0002tu-VA; Thu, 12 Feb 2015 19:10:01 +0900
X-Mailer: git-send-email 2.3.0.1.g55ac403.dirty
In-Reply-To: <1423735801-11108-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263714>

The check-connectivity, cloning, and update-shallow options are currently only
emitted for the fetch command but should also be emitted for the import
command.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 transport-helper.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 23a741c..c3868e4 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -342,16 +342,6 @@ static int fetch_with_fetch(struct transport *transport,
 	int i;
 	struct strbuf buf = STRBUF_INIT;
 
-	if (data->check_connectivity &&
-	    data->transport_options.check_self_contained_and_connected)
-		set_helper_option(transport, "check-connectivity", "true");
-
-	if (transport->cloning)
-		set_helper_option(transport, "cloning", "true");
-
-	if (data->transport_options.update_shallow)
-		set_helper_option(transport, "update-shallow", "true");
-
 	for (i = 0; i < nr_heads; i++) {
 		const struct ref *posn = to_fetch[i];
 		if (posn->status & REF_STATUS_UPTODATE)
@@ -622,6 +612,16 @@ static int fetch(struct transport *transport,
 	if (!count)
 		return 0;
 
+	if (data->check_connectivity &&
+	    data->transport_options.check_self_contained_and_connected)
+		set_helper_option(transport, "check-connectivity", "true");
+
+	if (transport->cloning)
+		set_helper_option(transport, "cloning", "true");
+
+	if (data->transport_options.update_shallow)
+		set_helper_option(transport, "update-shallow", "true");
+
 	if (data->fetch)
 		return fetch_with_fetch(transport, nr_heads, to_fetch);
 
-- 
2.3.0.1.g55ac403.dirty
