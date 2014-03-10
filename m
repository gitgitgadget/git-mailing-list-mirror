From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 07/26] update_refs(): Fix constness
Date: Mon, 10 Mar 2014 13:46:24 +0100
Message-ID: <1394455603-2968-8-git-send-email-mhagger@alum.mit.edu>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 13:48:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMzdI-0000P1-1i
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 13:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753542AbaCJMrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 08:47:07 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:59251 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753524AbaCJMrD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 08:47:03 -0400
X-AuditID: 12074413-f79076d000002d17-03-531db4462a96
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id D5.96.11543.644BD135; Mon, 10 Mar 2014 08:47:02 -0400 (EDT)
Received: from michael.fritz.box (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2ACkjwV025479
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 08:47:01 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqOu2RTbY4P1sc4ud6yQsuq50M1k0
	9F5htph3dxeTxe0V85ktfrT0MFt87FzA7MDu8ff9ByaPnbPusntcevmdzePjs+XsHs969zB6
	XLyk7PF5k1wAexS3TVJiSVlwZnqevl0Cd8a21vqCvXwVT1a0MTcwXuHuYuTkkBAwkXhz6DYj
	hC0mceHeerYuRi4OIYHLjBKvtz+Fck4wSXRvPMQGUsUmoCuxqKeZCcQWEVCTmNh2iAWkiFng
	CqPE56+/2LsYOTiEBYwlTk0xAKlhEVCVeHrsMjOIzSvgLHFjUxM7xDY5iSm/F4DZnAIuEtOv
	PACzhYBqXu5pZp3AyLuAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka65Xm5miV5qSukmRkjg
	Ce9g3HVS7hCjAAejEg/vgbcywUKsiWXFlbmHGCU5mJREeSeulQ0W4kvKT6nMSCzOiC8qzUkt
	PsQowcGsJMKbuRgox5uSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4K3f
	DNQoWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4qM+GJgbICkeID2OoC08xYXJOYC
	RSFaTzEqSonzzgFJCIAkMkrz4MbC0skrRnGgL4V5W0GqeICpCK77FdBgJqDBzcelQAaXJCKk
	pBoYIyR6nhfn6adJqf5Klbf3VeN8YsV194dH7crm3Gn2Fz6+XeypybjWP+/MhPmvD85WurZx
	g8K6hYlng7dMKgp7OpvJPumwiLJW/KoTC27KaXy/HOz3dpm/QJzy8cRiE/ed3hal 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243753>

Since full const correctness is beyond the ability of C's type system,
just put the const where it doesn't do any harm.  A (struct ref_update
**) can be passed to a (struct ref_update * const *) argument, but not
to a (const struct ref_update **) argument.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/update-ref.c | 2 +-
 refs.c               | 2 +-
 refs.h               | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index f6345e5..a8a68e8 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -14,7 +14,7 @@ static const char * const git_update_ref_usage[] = {
 
 static int updates_alloc;
 static int updates_count;
-static const struct ref_update **updates;
+static struct ref_update **updates;
 
 static char line_termination = '\n';
 static int update_flags;
diff --git a/refs.c b/refs.c
index 58faf95..0963077 100644
--- a/refs.c
+++ b/refs.c
@@ -3306,7 +3306,7 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 	return 0;
 }
 
-int update_refs(const char *action, const struct ref_update **updates_orig,
+int update_refs(const char *action, struct ref_update * const *updates_orig,
 		int n, enum action_on_err onerr)
 {
 	int ret = 0, delnum = 0, i;
diff --git a/refs.h b/refs.h
index a713b34..08e60ac 100644
--- a/refs.h
+++ b/refs.h
@@ -228,7 +228,7 @@ int update_ref(const char *action, const char *refname,
 /**
  * Lock all refs and then perform all modifications.
  */
-int update_refs(const char *action, const struct ref_update **updates,
+int update_refs(const char *action, struct ref_update * const *updates,
 		int n, enum action_on_err onerr);
 
 extern int parse_hide_refs_config(const char *var, const char *value, const char *);
-- 
1.9.0
