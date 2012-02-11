From: Tom Grennan <tmgrennan@gmail.com>
Subject: [PATCHv2 3/4] branch: use refs.c:refname_match_patterns()
Date: Fri, 10 Feb 2012 18:16:57 -0800
Message-ID: <1328926618-17167-4-git-send-email-tmgrennan@gmail.com>
References: <1328926618-17167-1-git-send-email-tmgrennan@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, krh@redhat.com,
	jasampler@gmail.com
To: pclouds@gmail.com
X-From: git-owner@vger.kernel.org Sat Feb 11 03:18:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw2XI-0002so-2E
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 03:18:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761219Ab2BKCRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 21:17:54 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:39102 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758914Ab2BKCRv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 21:17:51 -0500
Received: by mail-qw0-f46.google.com with SMTP id c10so674260qad.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 18:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=ZKvagGWVCA4VbDZ/V6kkM54Ng5rG31xUsfp/62s6KKw=;
        b=Tbel/TAPXK6nYIdR9gyquyOgF9NGjePIlN579ILPj9qUSJotpW7UA92VU5taoBLO/B
         96Rp4LVHYDW4itDt76P14hSZEhxtwDL0PkSUOylfAvHgQqT2PhcMSCTr7+ALEpMWB5qD
         Zbgl5eakpK8FogO9Kt8VpVtDgQFvsvXgURoHc=
Received: by 10.224.181.210 with SMTP id bz18mr1636504qab.13.1328926671081;
        Fri, 10 Feb 2012 18:17:51 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com ([129.192.185.163])
        by mx.google.com with ESMTPS id fd1sm16844239qab.1.2012.02.10.18.17.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 18:17:50 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1328926618-17167-1-git-send-email-tmgrennan@gmail.com>
In-Reply-To: <20120210185516.GA4903@tgrennan-laptop>
References: <20120210185516.GA4903@tgrennan-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190477>

Signed-off-by: Tom Grennan <tmgrennan@gmail.com>
---
 builtin/branch.c |   16 ++--------------
 1 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 7095718..7dfc693 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -266,18 +266,6 @@ struct append_ref_cb {
 	int ret;
 };
 
-static int match_patterns(const char **pattern, const char *refname)
-{
-	if (!*pattern)
-		return 1; /* no pattern always matches */
-	while (*pattern) {
-		if (!fnmatch(*pattern, refname, 0))
-			return 1;
-		pattern++;
-	}
-	return 0;
-}
-
 static int append_ref(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
 {
 	struct append_ref_cb *cb = (struct append_ref_cb *)(cb_data);
@@ -312,7 +300,7 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	if ((kind & ref_list->kinds) == 0)
 		return 0;
 
-	if (!match_patterns(cb->pattern, refname))
+	if (!refname_match_patterns(cb->pattern, refname))
 		return 0;
 
 	commit = NULL;
@@ -542,7 +530,7 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
 
 	detached = (detached && (kinds & REF_LOCAL_BRANCH));
-	if (detached && match_patterns(pattern, "HEAD"))
+	if (detached && refname_match_patterns(pattern, "HEAD"))
 		show_detached(&ref_list);
 
 	for (i = 0; i < ref_list.index; i++) {
-- 
1.7.8
