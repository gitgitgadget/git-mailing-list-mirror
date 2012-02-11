From: Tom Grennan <tmgrennan@gmail.com>
Subject: [PATCHv2 4/4] for-each-ref: use refs.c:refname_match_patterns()
Date: Fri, 10 Feb 2012 18:16:58 -0800
Message-ID: <1328926618-17167-5-git-send-email-tmgrennan@gmail.com>
References: <1328926618-17167-1-git-send-email-tmgrennan@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, krh@redhat.com,
	jasampler@gmail.com
To: pclouds@gmail.com
X-From: git-owner@vger.kernel.org Sat Feb 11 03:18:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw2XJ-0002so-Bo
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 03:18:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761236Ab2BKCR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 21:17:59 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:39102 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761195Ab2BKCRx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 21:17:53 -0500
Received: by mail-qw0-f46.google.com with SMTP id c10so674260qad.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 18:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=2NpRcjpoJZsNCZAYNQc9W5IW3Y01414szgZCTVWVVLU=;
        b=UfCwH/TIHrAECyH57Tp0L98Uk1ysvJQUhrqLUwbBzYjKRJFFSFcLzl9Z+bBXPpVTLX
         uo4huCZsGZqKBucjRDHb1gONhYIvbuZbU5oCmlhrGeb2RG7sXOfzE48mI6y2WAMmwl2h
         sRrR3k5XAz5oJjOsvmNf+GyHS8U9Le78NKXs4=
Received: by 10.229.76.139 with SMTP id c11mr5557895qck.1.1328926673524;
        Fri, 10 Feb 2012 18:17:53 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com ([129.192.185.163])
        by mx.google.com with ESMTPS id fd1sm16844239qab.1.2012.02.10.18.17.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 18:17:52 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1328926618-17167-1-git-send-email-tmgrennan@gmail.com>
In-Reply-To: <20120210185516.GA4903@tgrennan-laptop>
References: <20120210185516.GA4903@tgrennan-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190476>

Signed-off-by: Tom Grennan <tmgrennan@gmail.com>
---
 builtin/for-each-ref.c |   23 +++--------------------
 1 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index b01d76a..2c9cc47 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -781,25 +781,8 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 	struct refinfo *ref;
 	int cnt;
 
-	if (*cb->grab_pattern) {
-		const char **pattern;
-		int namelen = strlen(refname);
-		for (pattern = cb->grab_pattern; *pattern; pattern++) {
-			const char *p = *pattern;
-			int plen = strlen(p);
-
-			if ((plen <= namelen) &&
-			    !strncmp(refname, p, plen) &&
-			    (refname[plen] == '\0' ||
-			     refname[plen] == '/' ||
-			     p[plen-1] == '/'))
-				break;
-			if (!fnmatch(p, refname, FNM_PATHNAME))
-				break;
-		}
-		if (!*pattern)
-			return 0;
-	}
+	if (!refname_match_patterns(cb->grab_pattern, refname))
+		return 0;
 
 	/*
 	 * We do not open the object yet; sort may only need refname
@@ -974,7 +957,7 @@ static int opt_parse_sort(const struct option *opt, const char *arg, int unset)
 }
 
 static char const * const for_each_ref_usage[] = {
-	"git for-each-ref [options] [<pattern>]",
+	"git for-each-ref [options] [[!]<pattern>...]",
 	NULL
 };
 
-- 
1.7.8
