From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 17/25] do_fetch(): clean up existing_refs before exiting
Date: Sat, 25 May 2013 11:08:16 +0200
Message-ID: <1369472904-12875-18-git-send-email-mhagger@alum.mit.edu>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johan Herland <johan@herland.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 25 11:09:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgATm-0005GF-M0
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 11:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687Ab3EYJJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 05:09:24 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:50789 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754347Ab3EYJJW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 May 2013 05:09:22 -0400
X-AuditID: 12074414-b7fb86d000000905-ed-51a07fc19176
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 9C.D4.02309.1CF70A15; Sat, 25 May 2013 05:09:21 -0400 (EDT)
Received: from michael.fritz.box (p4FDD49F3.dip0.t-ipconnect.de [79.221.73.243])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4P98gur000489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 May 2013 05:09:19 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqHuwfkGgwdybEhZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLe5eXsXuwObx9/0HJo9LL7+zedx+PZ/Z41nvHkaPi5eUPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgzrg06zBTwXfuiuVty5kaGI9zdjFyckgImEgsetTHBGGLSVy4t56t
	i5GLQ0jgMqPEpY13GSGcC0wSH2c2MoJUsQnoSizqaQbrEBFwlDjx4DorSBGzQC+jxMNH38ES
	wgLeEuvfXGIFsVkEVCUmLdsJFucVcJXoefyIHWKdgsTlWWuYuxg5ODiB4m9PgF0kJOAi8fzT
	OdYJjLwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFula6OVmluilppRuYoQEmsgOxiMn5Q4x
	CnAwKvHwCpTPDxRiTSwrrsw9xCjJwaQkystfuyBQiC8pP6UyI7E4I76oNCe1+BCjBAezkggv
	QwpQjjclsbIqtSgfJiXNwaIkzvttsbqfkEB6YklqdmpqQWoRTFaGg0NJgndvHVCjYFFqempF
	WmZOCUKaiYMTRHCBbOAB2nAWpJC3uCAxtzgzHaLoFKOilDjvTZCEAEgiozQPbgAsJbxiFAf6
	R5j3LkgVDzCdwHW/AhrMBDT4Zu58kMEliQgpqQZG3Q/5y6+xbOtoEyi4//TG+2bVF7uCGF0+
	/78eO71Ms9nNV27ziTf3/m/ca/dpd0GSxISFSif4LjKzCs5hZJb3tbvcGMsuO+HEn8hzfYm5
	ctv/3QszFTVcaMa8arGttbPgT4/J3knLnthLbq/83S2149ITtc2rrv76YVFcW7yv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225502>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 80c6e37..48df5fa 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -697,6 +697,7 @@ static int do_fetch(struct transport *transport,
 	struct ref *ref_map;
 	struct ref *rm;
 	int autotags = (transport->remote->fetch_tags == 1);
+	int retcode = 0;
 
 	for_each_ref(add_existing, &existing_refs);
 
@@ -712,9 +713,9 @@ static int do_fetch(struct transport *transport,
 
 	/* if not appending, truncate FETCH_HEAD */
 	if (!append && !dry_run) {
-		int errcode = truncate_fetch_head();
-		if (errcode)
-			return errcode;
+		retcode = truncate_fetch_head();
+		if (retcode)
+			goto cleanup;
 	}
 
 	ref_map = get_ref_map(transport, refs, ref_count, tags, &autotags);
@@ -736,7 +737,8 @@ static int do_fetch(struct transport *transport,
 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
 	if (fetch_refs(transport, ref_map)) {
 		free_refs(ref_map);
-		return 1;
+		retcode = 1;
+		goto cleanup;
 	}
 	if (prune) {
 		/* If --tags was specified, pretend the user gave us the canonical tags refspec */
@@ -779,7 +781,9 @@ static int do_fetch(struct transport *transport,
 		free_refs(ref_map);
 	}
 
-	return 0;
+ cleanup:
+	string_list_clear(&existing_refs, 0);
+	return retcode;
 }
 
 static void set_option(const char *name, const char *value)
-- 
1.8.2.3
