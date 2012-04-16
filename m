From: marcnarc@xiplink.com
Subject: [PATCH 2/3] fetch: Pass both the full remote ref and its short name to update_local_ref().
Date: Mon, 16 Apr 2012 18:08:49 -0400
Message-ID: <1334614130-31826-3-git-send-email-marcnarc@xiplink.com>
References: <1334591542-25136-1-git-send-email-marcnarc@xiplink.com>
 <1334614130-31826-1-git-send-email-marcnarc@xiplink.com>
Cc: Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 00:08:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJu6K-0006Tr-VP
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 00:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269Ab2DPWIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 18:08:30 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:50929 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752828Ab2DPWI3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 18:08:29 -0400
Received: from xiplink.com (rincewind.xiplink.com [192.168.1.166])
	by farnsworth.xiplink.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id q3GM8QLQ000947;
	Mon, 16 Apr 2012 18:08:27 -0400
X-Mailer: git-send-email 1.7.10.2.ge89da.dirty
In-Reply-To: <1334614130-31826-1-git-send-email-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195708>

From: Marc Branchaud <marcnarc@xiplink.com>

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---
 builtin/fetch.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index cfb43df..6c19975 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -239,7 +239,8 @@ static int s_update_ref(const char *action,
 #define REFCOL_WIDTH  10
 
 static int update_local_ref(struct ref *ref,
-			    const char *remote,
+			    const char *remote_ref_shortname,
+			    const struct ref *remote_ref,
 			    struct strbuf *display)
 {
 	struct commit *current = NULL, *updated;
@@ -256,7 +257,7 @@ static int update_local_ref(struct ref *ref,
 			strbuf_addf(display, "= %-*s %-*s -> %s",
 				    TRANSPORT_SUMMARY_WIDTH,
 				    _("[up to date]"), REFCOL_WIDTH,
-				    remote, pretty_ref);
+				    remote_ref_shortname, pretty_ref);
 		return 0;
 	}
 
@@ -271,7 +272,7 @@ static int update_local_ref(struct ref *ref,
 		strbuf_addf(display,
 			    _("! %-*s %-*s -> %s  (can't fetch in current branch)"),
 			    TRANSPORT_SUMMARY_WIDTH, _("[rejected]"),
-			    REFCOL_WIDTH, remote, pretty_ref);
+			    REFCOL_WIDTH, remote_ref_shortname, pretty_ref);
 		return 1;
 	}
 
@@ -282,7 +283,7 @@ static int update_local_ref(struct ref *ref,
 		strbuf_addf(display, "%c %-*s %-*s -> %s%s",
 			    r ? '!' : '-',
 			    TRANSPORT_SUMMARY_WIDTH, _("[tag update]"),
-			    REFCOL_WIDTH, remote, pretty_ref,
+			    REFCOL_WIDTH, remote_ref_shortname, pretty_ref,
 			    r ? _("  (unable to update local ref)") : "");
 		return r;
 	}
@@ -309,7 +310,7 @@ static int update_local_ref(struct ref *ref,
 		strbuf_addf(display, "%c %-*s %-*s -> %s%s",
 			    r ? '!' : '*',
 			    TRANSPORT_SUMMARY_WIDTH, what,
-			    REFCOL_WIDTH, remote, pretty_ref,
+			    REFCOL_WIDTH, remote_ref_shortname, pretty_ref,
 			    r ? _("  (unable to update local ref)") : "");
 		return r;
 	}
@@ -327,7 +328,7 @@ static int update_local_ref(struct ref *ref,
 		strbuf_addf(display, "%c %-*s %-*s -> %s%s",
 			    r ? '!' : ' ',
 			    TRANSPORT_SUMMARY_WIDTH, quickref,
-			    REFCOL_WIDTH, remote, pretty_ref,
+			    REFCOL_WIDTH, remote_ref_shortname, pretty_ref,
 			    r ? _("  (unable to update local ref)") : "");
 		return r;
 	} else if (force || ref->force) {
@@ -343,13 +344,13 @@ static int update_local_ref(struct ref *ref,
 		strbuf_addf(display, "%c %-*s %-*s -> %s  (%s)",
 			    r ? '!' : '+',
 			    TRANSPORT_SUMMARY_WIDTH, quickref,
-			    REFCOL_WIDTH, remote, pretty_ref,
+			    REFCOL_WIDTH, remote_ref_shortname, pretty_ref,
 			    r ? _("unable to update local ref") : _("forced update"));
 		return r;
 	} else {
 		strbuf_addf(display, "! %-*s %-*s -> %s  %s",
 			    TRANSPORT_SUMMARY_WIDTH, _("[rejected]"),
-			    REFCOL_WIDTH, remote, pretty_ref,
+			    REFCOL_WIDTH, remote_ref_shortname, pretty_ref,
 			    _("(non-fast-forward)"));
 		return 1;
 	}
@@ -466,7 +467,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 
 			strbuf_reset(&note);
 			if (ref) {
-				rc |= update_local_ref(ref, what, &note);
+			  rc |= update_local_ref(ref, what, rm, &note);
 				free(ref);
 			} else
 				strbuf_addf(&note, "* %-*s %-*s -> FETCH_HEAD",
-- 
1.7.10.2.ge89da.dirty
