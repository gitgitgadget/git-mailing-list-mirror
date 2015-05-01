From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 15/18] rename_ref(): integrate lock_ref_sha1_basic() errors into ours
Date: Fri,  1 May 2015 14:25:55 +0200
Message-ID: <1430483158-14349-16-git-send-email-mhagger@alum.mit.edu>
References: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 14:34:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoA8v-0006se-I0
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 14:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812AbbEAMeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 08:34:05 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:47609 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753760AbbEAMeD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2015 08:34:03 -0400
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 May 2015 08:34:03 EDT
X-AuditID: 12074411-f79fa6d000006b8a-8f-554370f42b37
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id AF.28.27530.4F073455; Fri,  1 May 2015 08:26:28 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D7E.dip0.t-ipconnect.de [79.201.125.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t41CQ3Zs004310
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 1 May 2015 08:26:27 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqPulwDnUYNMCS4uuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZxz70s5U0MVV8bXjE1sD4zSOLkZODgkBE4l3ExYxQthiEhfurWfrYuTiEBK4zCjRe2oC
	M4Rzgkmi/+lKdpAqNgFdiUU9zUwgtoiAmsTEtkMsIEXMAh2MEheWbwMrEhYIlej7+4UNxGYR
	UJVovLgHzOYVcJVY8fIZG8Q6OYnzx38CbeDg4ASKf5maCBIWEnCRuP/9K9sERt4FjAyrGOUS
	c0pzdXMTM3OKU5N1i5MT8/JSi3RN9XIzS/RSU0o3MUJCSnAH44yTcocYBTgYlXh4NxxzChVi
	TSwrrsw9xCjJwaQkymub4BwqxJeUn1KZkVicEV9UmpNafIhRgoNZSYT3njpQjjclsbIqtSgf
	JiXNwaIkzsu3RN1PSCA9sSQ1OzW1ILUIJivDwaEkwZuYD9QoWJSanlqRlplTgpBm4uAEGc4l
	JVKcmpeSWpRYWpIRD4qN+GJgdICkeID2LgNp5y0uSMwFikK0nmJUlBLn7QFJCIAkMkrz4MbC
	EsUrRnGgL4V5j4NU8QCTDFz3K6DBTECDz99yABlckoiQkmpg1H38WLQ4/Kj40rWCqrK869NP
	b1upnqenfdSwzvLLpuBmPrkV89dLM8kEPp282I7xeXj3K9n5c1vznogvtTt9NTcikG3fFck1
	tYWdtdYrHjR07L1idymiaH/0+QJLKVP1p2UXvjiVLhZYNWvX5UXJZkcKPpcmmCsc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268133>

Now that lock_ref_sha1_basic() gives us back its error messages via a
strbuf, incorporate its error message into our error message rather
than emitting two separate error messages.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index cdbd31a..6077e83 100644
--- a/refs.c
+++ b/refs.c
@@ -2889,9 +2889,8 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 
 	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, NULL, 0, NULL, &err);
 	if (!lock) {
-		error("%s", err.buf);
+		error("unable to rename '%s' to '%s': %s", oldrefname, newrefname, err.buf);
 		strbuf_release(&err);
-		error("unable to lock %s for update", newrefname);
 		goto rollback;
 	}
 	hashcpy(lock->old_sha1, orig_sha1);
@@ -2906,9 +2905,8 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
  rollback:
 	lock = lock_ref_sha1_basic(oldrefname, NULL, NULL, NULL, 0, NULL, &err);
 	if (!lock) {
-		error("%s", err.buf);
+		error("unable to lock %s for rollback: %s", oldrefname, err.buf);
 		strbuf_release(&err);
-		error("unable to lock %s for rollback", oldrefname);
 		goto rollbacklog;
 	}
 
-- 
2.1.4
