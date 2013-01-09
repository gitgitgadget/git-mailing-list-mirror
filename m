From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH 06/19] reset.c: remove unnecessary variable 'i'
Date: Wed,  9 Jan 2013 00:16:03 -0800
Message-ID: <1357719376-16406-7-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 09:25:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsqyQ-0003Bu-Pj
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 09:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757403Ab3AIIYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 03:24:54 -0500
Received: from mail-lb0-f202.google.com ([209.85.217.202]:43219 "EHLO
	mail-lb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757216Ab3AIIYw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 03:24:52 -0500
Received: by mail-lb0-f202.google.com with SMTP id s4so85674lbc.5
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 00:24:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=CgFnZp0bAjO0uI30JLaHFdXxl9hvbg/tXv7gFCZJviU=;
        b=eNfvSlabXeP2Dn16y4N/MVBvkWBk3k9ZvIEg0xbK8wiKPw8vPzl0yUyGJJrCYKtqJv
         lXHSDSkUp4VKPkRD2vvDk6G80+Xnn44T/x0A06uL2DUSfe94LII5OtV2QHYOi+b+W+Uc
         98IEu+LNK9a/uB/JaFU3dI0kGeMbU9VaIgKxBt+/lqZZZHg2aoLok0/NWjHOkqfi24IR
         rQ9jEZCPv2SZ6X2R8MlqTYdldJXNfGz+lJxKwGJp5ECkPVoifQXR1nF050B+T+Qqk46G
         0qWx3TwhiFgy0yX7Uj8wsJXZCd8y6gCgN+fiaLm8aA4ESnmQ5W89BUkKSVI2VvrRT2Jq
         1Zcw==
X-Received: by 10.14.201.1 with SMTP id a1mr83872140eeo.3.1357719425368;
        Wed, 09 Jan 2013 00:17:05 -0800 (PST)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id z44si25287617een.0.2013.01.09.00.17.05
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 09 Jan 2013 00:17:05 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id E3D2820005C;
	Wed,  9 Jan 2013 00:17:04 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 0B886102FB8; Wed,  9 Jan 2013 00:17:03 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.331.g1ef2165
In-Reply-To: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQlut/0dmoB1nN37LULAsQk0reCm9KxIndzQvJQZimNGccy84u4dbs9D0563VtAZMSE4YJKcxooJYqoPTY9ZwhDV8oYn6tNWNs1w2B5y4Gh6OPPa5n4LsnSfOQveMDoDn2iPUnq4XGjk8JaZpvtZBRLu5ON4gZHkRUfkGxcZ/nL3YVpJblEox8H7C0AkuYnDR4r6xfVJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213046>

Throughout most of parse_args(), the variable 'i' remains at 0. In the
remaining few cases, we can do pointer arithmentic on argv itself
instead.
---
This is clearly mostly a matter of taste. The remainder of the series
does not depend on it in any way.

 builtin/reset.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 9473725..68be05c 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -199,7 +199,6 @@ static void die_if_unmerged_cache(int reset_type)
 }
 
 const char **parse_args(int argc, const char **argv, const char *prefix, const char **rev_ret) {
-	int i = 0;
 	const char *rev = "HEAD";
 	unsigned char unused[20];
 	/*
@@ -210,34 +209,34 @@ const char **parse_args(int argc, const char **argv, const char *prefix, const c
 	 * git reset [-opts] -- <paths>...
 	 * git reset [-opts] <paths>...
 	 *
-	 * At this point, argv[i] points immediately after [-opts].
+	 * At this point, argv points immediately after [-opts].
 	 */
 
-	if (i < argc) {
-		if (!strcmp(argv[i], "--")) {
-			i++; /* reset to HEAD, possibly with paths */
-		} else if (i + 1 < argc && !strcmp(argv[i+1], "--")) {
-			rev = argv[i];
-			i += 2;
+	if (argc) {
+		if (!strcmp(argv[0], "--")) {
+			argv++; /* reset to HEAD, possibly with paths */
+		} else if (argc > 1 && !strcmp(argv[1], "--")) {
+			rev = argv[0];
+			argv += 2;
 		}
 		/*
-		 * Otherwise, argv[i] could be either <rev> or <paths> and
+		 * Otherwise, argv[0] could be either <rev> or <paths> and
 		 * has to be unambiguous.
 		 */
-		else if (!get_sha1_committish(argv[i], unused)) {
+		else if (!get_sha1_committish(argv[0], unused)) {
 			/*
-			 * Ok, argv[i] looks like a rev; it should not
+			 * Ok, argv[0] looks like a rev; it should not
 			 * be a filename.
 			 */
-			verify_non_filename(prefix, argv[i]);
-			rev = argv[i++];
+			verify_non_filename(prefix, argv[0]);
+			rev = *argv++;
 		} else {
 			/* Otherwise we treat this as a filename */
-			verify_filename(prefix, argv[i], 1);
+			verify_filename(prefix, argv[0], 1);
 		}
 	}
 	*rev_ret = rev;
-	return i < argc ? get_pathspec(prefix, argv + i) : NULL;
+	return *argv ? get_pathspec(prefix, argv) : NULL;
 }
 
 int cmd_reset(int argc, const char **argv, const char *prefix)
-- 
1.8.1.rc3.331.g1ef2165
