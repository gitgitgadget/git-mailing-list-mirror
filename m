From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 26/39] try_merge_strategy(): remove redundant lock_file allocation
Date: Fri, 26 Sep 2014 12:08:26 +0200
Message-ID: <1411726119-31598-27-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:17:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSaO-00032m-Cn
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755961AbaIZKRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:17:04 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:47270 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755955AbaIZKRC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:17:02 -0400
X-AuditID: 1207440d-f797f6d000000a4a-e5-54253b5ceb35
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 70.6E.02634.C5B35245; Fri, 26 Sep 2014 06:09:32 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lMB013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:09:31 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42IRYndR1I2xVg0xWDLV2KLrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7ozjBy6yFJxjrzh96y5rA+MMti5G
	Tg4JAROJq5OWsUDYYhIX7q0HinNxCAlcZpRYtuYyK4SziUni+N2rzCBVbAK6Eot6mplAbBEB
	NYmJbYdYQIqYBRYzSUw4tAlsrLBAqMTcnzPZQWwWAVWJ7c/3gcV5BVwllpy8CrVaTmLD7v+M
	IDYnULxx+zUwW0jARaJl/WSWCYy8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGunlZpbo
	paaUbmKEhCPvDsb/62QOMQpwMCrx8N5YpxIixJpYVlyZe4hRkoNJSZT3i4VqiBBfUn5KZUZi
	cUZ8UWlOavEhRgkOZiUR3jtGQDnelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpis
	DAeHkgTvRUugRsGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQdMQXA+MDJMUDtJfL
	CmRvcUFiLlAUovUUozFHS9PbXiaOdZ3f+pmEWPLy81KlxHmPgGwSACnNKM2DWwRLRK8YxYH+
	Fua9AVLFA0xicPNeAa1iAlqldEQZZFVJIkJKqoHRU5V1Y+6EIs2yqjqh/382ziie3Sq796Sr
	P6uoor/jijnZk/KSGs0LLj73iOb84Tdpcx7raa4lM1Yy3fEQ27DtHLfm01Sj7Kry 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257538>

By the time the "if" block is entered, the lock_file instance from the
main function block is no longer in use, so re-use that one instead of
allocating a second one.

Note that the "lock" variable in the "if" block shadowed the "lock"
variable at function scope, so the only change needed is to remove the
inner definition.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/merge.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index ec6fa93..cb8f709 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -668,7 +668,6 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree")) {
 		int clean, x;
 		struct commit *result;
-		struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
 		struct commit_list *reversed = NULL;
 		struct merge_options o;
 		struct commit_list *j;
-- 
2.1.0
