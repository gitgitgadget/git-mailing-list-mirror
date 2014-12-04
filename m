From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 10/23] expire_reflog(): add a "flags" argument
Date: Fri,  5 Dec 2014 00:08:22 +0100
Message-ID: <1417734515-11812-11-git-send-email-mhagger@alum.mit.edu>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:09:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwfWE-0002vY-VE
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:09:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933321AbaLDXI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:08:58 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:42800 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754847AbaLDXI4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 18:08:56 -0500
X-AuditID: 12074413-f79f26d0000030e7-99-5480e987838a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id DC.A0.12519.789E0845; Thu,  4 Dec 2014 18:08:56 -0500 (EST)
Received: from michael.fritz.box (p5DDB0B3C.dip0.t-ipconnect.de [93.219.11.60])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sB4N8de7027614
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 4 Dec 2014 18:08:54 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsUixO6iqNvxsiHEYLOYRdeVbiaLht4rzBZv
	by5htLi9Yj6zRW/fJ1aLzZvbWRzYPP6+/8DksXPWXXaPBZtKPS5eUvb4vEkugDWK2yYpsaQs
	ODM9T98ugTvjf/99loKlwhWrJu9hb2Dcx9/FyMkhIWAi8b5pGTuELSZx4d56NhBbSOAyo8T8
	2/JdjFxA9jEmiUOrPjGCJNgEdCUW9TQzgdgiAmoSM1fNZgMpYhY4wSjxa3I3WJGwgJ3Ep+vb
	wGwWAVWJDd/nMIPYvAKuEpOfb2XpYuQA2iYnsXWdN0iYEyg8dWYrI8RiF4lnmxayT2DkXcDI
	sIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11wvN7NELzWldBMjJLCEdzDuOil3iFGAg1GJh7dg
	d32IEGtiWXFl7iFGSQ4mJVHes08bQoT4kvJTKjMSizPii0pzUosPMUpwMCuJ8BofAcrxpiRW
	VqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4lCR4S18ANQoWpaanVqRl5pQgpJk4
	OEGGc0mJFKfmpaQWJZaWZMSDIiO+GBgbICkeoL1lIO28xQWJuUBRiNZTjIpS4rz1IAkBkERG
	aR7cWFi6eMUoDvSlMMR2HmCqget+BTSYCWjw2YZakMEliQgpqQbGGDep06JC51YlqF7hXLjq
	U5XGrcUa557esujed+i+oumjv1d0E4/n28gf3eHHvlT/yObnu2rDPZu+PJC+vnyi1as9gbq3
	r3V1/St0VvgtsfDzsa+xy1emKvxgvflF3M21y2eb4dGqMM6TinqS3Qtv+c9+NjeO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260815>

We want to separate the options relevant to the expiry machinery from
the options affecting the expiration policy. So add a "flags" argument
to expire_reflog() to hold the former.

The argument doesn't yet do anything.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/reflog.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index ebfa635..319f0d2 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -415,7 +415,8 @@ static void reflog_expiry_cleanup(struct expire_reflog_cb *cb)
 
 static struct lock_file reflog_lock;
 
-static int expire_reflog(const char *refname, const unsigned char *sha1, void *cb_data)
+static int expire_reflog(const char *refname, const unsigned char *sha1,
+			 unsigned int flags, void *cb_data)
 {
 	struct cmd_reflog_expire_cb *cmd = cb_data;
 	struct expire_reflog_cb cb;
@@ -627,6 +628,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	unsigned long now = time(NULL);
 	int i, status, do_all;
 	int explicit_expiry = 0;
+	unsigned int flags = 0;
 
 	default_reflog_expire_unreachable = now - 30 * 24 * 3600;
 	default_reflog_expire = now - 90 * 24 * 3600;
@@ -696,7 +698,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		for (i = 0; i < collected.nr; i++) {
 			struct collected_reflog *e = collected.e[i];
 			set_reflog_expiry_param(&cb, explicit_expiry, e->reflog);
-			status |= expire_reflog(e->reflog, e->sha1, &cb);
+			status |= expire_reflog(e->reflog, e->sha1, flags, &cb);
 			free(e);
 		}
 		free(collected.e);
@@ -710,7 +712,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		set_reflog_expiry_param(&cb, explicit_expiry, ref);
-		status |= expire_reflog(ref, sha1, &cb);
+		status |= expire_reflog(ref, sha1, flags, &cb);
 	}
 	return status;
 }
@@ -729,6 +731,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 {
 	struct cmd_reflog_expire_cb cb;
 	int i, status = 0;
+	unsigned int flags = 0;
 
 	memset(&cb, 0, sizeof(cb));
 
@@ -781,7 +784,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 			cb.expire_total = 0;
 		}
 
-		status |= expire_reflog(ref, sha1, &cb);
+		status |= expire_reflog(ref, sha1, flags, &cb);
 		free(ref);
 	}
 	return status;
-- 
2.1.3
