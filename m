From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 06/27] update_refs(): Fix constness
Date: Mon, 24 Mar 2014 18:56:39 +0100
Message-ID: <1395683820-17304-7-git-send-email-mhagger@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 18:57:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS987-00018N-9D
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 18:57:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787AbaCXR50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 13:57:26 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:52486 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753760AbaCXR5W (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2014 13:57:22 -0400
X-AuditID: 12074412-f79d46d000002e58-7c-533072017281
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 04.AE.11864.10270335; Mon, 24 Mar 2014 13:57:21 -0400 (EDT)
Received: from michael.fritz.box (p57A25F6C.dip0.t-ipconnect.de [87.162.95.108])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2OHv4xc028070
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 24 Mar 2014 13:57:20 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqMtYZBBs8POIpsXOdRIWXVe6mSwa
	eq8wW8y7u4vJ4vaK+cwWP1p6mC0+di5gdmD3+Pv+A5PHzll32T0uvfzO5vHx2XJ2j2e9exg9
	Ll5S9vi8SS6APYrbJimxpCw4Mz1P3y6BO+PqLY2CvXwVvzeeZ2lgvMLdxcjBISFgIrHrSGAX
	IyeQKSZx4d56ti5GLg4hgcuMEnvOX2CGcE4wSZxpXMEMUsUmoCuxqKeZCcQWEVCTmNh2iAWk
	iFngCqPElY/bWUCmCguYSaz/5AlSwyKgKrH6/B02EJtXwEXi2frrzBDb5CSm/F7ADmJzCrhK
	bG0/DBYXAqrZ8bGXaQIj7wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFumZ6uZkleqkppZsY
	IWEntINx/Um5Q4wCHIxKPLwbTA2ChVgTy4orcw8xSnIwKYnysuUChfiS8lMqMxKLM+KLSnNS
	iw8xSnAwK4nwWoYD5XhTEiurUovyYVLSHCxK4rw/F6v7CQmkJ5akZqemFqQWwWRlODiUJHhv
	FwA1ChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIPiIr4YGBkgKR6gvRyFIHuLCxJz
	gaIQracYFaXEea+BzBUASWSU5sGNhSWTV4ziQF8K834CqeIBJiK47ldAg5mABoc36YEMLklE
	SEk1MDoWfP2/WVBcwdg+eM2uH623tY1bfVMfzap3eBR0ZGK9g++JRymyS8L9me4s2SRc7PT5
	3oFLugGq82ou1mYVXKpd4uM8P0/68Ym3MxstrqSZaj2dweeuEN2Sz2m8rmKJ2/2J 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244838>

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
index 196984e..1305eb1 100644
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
