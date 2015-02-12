From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 1/3] transport-helper: emit progress and verbosity options after asking for capabilities
Date: Thu, 12 Feb 2015 19:09:59 +0900
Message-ID: <1423735801-11108-1-git-send-email-mh@glandium.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 11:10:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLqiy-0007YA-70
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 11:10:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766AbbBLKKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 05:10:12 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:47765 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752642AbbBLKKL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 05:10:11 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YLqif-0002tr-Tc; Thu, 12 Feb 2015 19:10:01 +0900
X-Mailer: git-send-email 2.3.0.1.g55ac403.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263712>

Currently, the progress and verbosity options are only emitted for the fetch
and push commands, but they should also be emitted for other commands, such as
import or export, and, why not, even list.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 transport-helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 0224687..23a741c 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -98,6 +98,8 @@ static void do_take_over(struct transport *transport)
 	free(data);
 }
 
+static void standard_options(struct transport *t);
+
 static struct child_process *get_helper(struct transport *transport)
 {
 	struct helper_data *data = transport->data;
@@ -212,6 +214,7 @@ static struct child_process *get_helper(struct transport *transport)
 	strbuf_release(&buf);
 	if (debug)
 		fprintf(stderr, "Debug: Capabilities complete.\n");
+	standard_options(transport);
 	return data->helper;
 }
 
@@ -339,7 +342,6 @@ static int fetch_with_fetch(struct transport *transport,
 	int i;
 	struct strbuf buf = STRBUF_INIT;
 
-	standard_options(transport);
 	if (data->check_connectivity &&
 	    data->transport_options.check_self_contained_and_connected)
 		set_helper_option(transport, "check-connectivity", "true");
@@ -824,7 +826,6 @@ static int push_refs_with_push(struct transport *transport,
 		return 0;
 	}
 
-	standard_options(transport);
 	for_each_string_list_item(cas_option, &cas_options)
 		set_helper_option(transport, "cas", cas_option->string);
 
-- 
2.3.0.1.g55ac403.dirty
