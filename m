From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] mailmap.c: Fix a sparse warning
Date: Sat, 15 Dec 2012 19:25:21 +0000
Message-ID: <50CCCEA1.1020000@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: apelisse@gmail.com
X-From: git-owner@vger.kernel.org Sat Dec 15 20:28:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjxPN-0004LJ-2A
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 20:28:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451Ab2LOT2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 14:28:08 -0500
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:41611 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab2LOT2G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 14:28:06 -0500
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 3F3F7384081;
	Sat, 15 Dec 2012 19:28:05 +0000 (GMT)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 8CED6384080;	Sat, 15 Dec 2012 19:28:04 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;	Sat, 15 Dec 2012 19:28:02 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211564>


In particular, sparse issues an "Using plain integer as NULL pointer"
warning (line 214), since an integer zero is passed as the second
actual argument in a strbuf_detach() call. The expected type for
this parameter is 'size_t *'. In order to suppress the warning, we
simply pass a NULL pointer constant instead.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Antoine,

When you re-roll your mailmap patches (branch 'ap/log-mailmap') could
you please squash this into commit a09b6cd9 ("mailmap: Remove buffer
length limit in map_user", 11-12-2012).

Thanks!

ATB,
Ramsay Jones

 mailmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mailmap.c b/mailmap.c
index e636278..0608eb3 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -211,7 +211,7 @@ int map_user(struct string_list *map,
 	for (i = 0; i < end_of_email - email; i++)
 		strbuf_addch(&buf, tolower(email[i]));
 	strbuf_addch(&buf, 0);
-	mailbuf = strbuf_detach(&buf, 0);
+	mailbuf = strbuf_detach(&buf, NULL);
 
 	debug_mm("map_user: map '%s' <%s>\n", name, mailbuf);
 	item = string_list_lookup(map, mailbuf);
-- 
1.8.0
