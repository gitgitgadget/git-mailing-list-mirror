From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/4] get_remote_group(): handle remotes with single-character names
Date: Tue, 28 Jul 2015 23:08:18 +0200
Message-ID: <9607497fedac5b69b76f6f47886b533553857ddb.1438117334.git.mhagger@alum.mit.edu>
References: <cover.1438117334.git.mhagger@alum.mit.edu>
Cc: =?UTF-8?q?Bj=C3=B6rn=20Gustavsson?= <bgustavsson@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 23:08:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKC71-0002ui-9X
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 23:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753119AbbG1VIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 17:08:30 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:55691 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752603AbbG1VI3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jul 2015 17:08:29 -0400
X-AuditID: 12074411-f797e6d000007df3-65-55b7ef4d84da
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id EB.9C.32243.D4FE7B55; Tue, 28 Jul 2015 17:08:29 -0400 (EDT)
Received: from michael.fritz.box (p4FC97CAD.dip0.t-ipconnect.de [79.201.124.173])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t6SL8PUB021490
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 28 Jul 2015 17:08:28 -0400
X-Mailer: git-send-email 2.4.6
In-Reply-To: <cover.1438117334.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsUixO6iqOv7fnuowfdGAYv5xxYzW3Rd6Way
	aOi9wmxxe8V8ZgcWj7/vPzB57Jx1l93j4iVlj8+b5AJYorhtkhJLyoIz0/P07RK4M7Y/4Cvo
	Zq+YcFaqgfEIaxcjB4eEgInEkRN2XYycQKaYxIV769lAbCGBy4wSR+9UdTFyAdknmSTeztoI
	lmAT0JVY1NPMBGKLCKhJTGw7xAJSxCzQxihxYc0uZpCEsECwxNUr55hBFrAIqEqs324NEuYV
	iJK4fL6ZBWKZnMS1s1tZQWxOAQuJy99bWEDKhQTMJb7t9ZrAyLuAkWEVo1xiTmmubm5iZk5x
	arJucXJiXl5qka6pXm5miV5qSukmRkjYCO5gnHFS7hCjAAejEg/vhHXbQoVYE8uKK3MPMUpy
	MCmJ8s64tz1UiC8pP6UyI7E4I76oNCe1+BCjBAezkghvw0OgHG9KYmVValE+TEqag0VJnJdv
	ibqfkEB6YklqdmpqQWoRTFaGg0NJgrf2HVCjYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFi
	aUlGPCgi4ouBMQGS4gHauwqknbe4IDEXKArReopRl2PBj9trmYRY8vLzUqXEeVNBigRAijJK
	8+BWwJLEK0ZxoI+FeXVBqniACQZu0iugJUxASzx7toAsKUlESAHjXsQsmqtCcseeP1ypO6Xz
	D38+mv2xyyrfepKTYlbMZTG5I/Irzpjs+OW4lfOW+UH9VWH39V5lOP/7lCfqZ6bEo7Fk1owf
	hpUTF5Xt63m+N/XsatXja9RuvPx+UWvrolDfqU2K+/tWBbfGxU5pEJP68p5jXpuK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274846>

The code for splitting a whitespace-separated list of values in
"remotes.<name>" had an off-by-one error that caused it to skip over
remotes whose names consist of a single character.

Also remove unnecessary braces.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f951265..98f9048 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -980,10 +980,9 @@ static int get_remote_group(const char *key, const char *value, void *priv)
 		/* split list by white space */
 		int space = strcspn(value, " \t\n");
 		while (*value) {
-			if (space > 1) {
+			if (space >= 1)
 				string_list_append(g->list,
 						   xstrndup(value, space));
-			}
 			value += space + (value[space] != '\0');
 			space = strcspn(value, " \t\n");
 		}
-- 
2.4.6
