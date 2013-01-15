From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2 06/19] reset.c: remove unnecessary variable 'i'
Date: Mon, 14 Jan 2013 21:47:38 -0800
Message-ID: <1358228871-7142-7-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Matt Kraai <kraai@ftbfs.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 07:17:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuzqJ-0005HN-D8
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 07:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767Ab3AOGRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 01:17:30 -0500
Received: from mail-ea0-f201.google.com ([209.85.215.201]:49387 "EHLO
	mail-ea0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679Ab3AOGR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 01:17:29 -0500
Received: by mail-ea0-f201.google.com with SMTP id e12so312781eaa.2
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 22:17:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=MNmms9FizAmXBJvA3CgGT9zJnmXj59G3jMRbH+5Ld20=;
        b=adesgeEeZ0xythQa/QpUHYHf1Eac8OHuwFPGFojxaXvEoEXrHs0Qg3d0zzCa7lJDzQ
         iANdSB1u+WWqNAzt/veVqxnhpbBQg4JZ9HByOzFRUzUv5ahWS85mCYcNalhJ5xW952np
         famcE8K4PYg5vx169NFoZhqF6vVmhKXv7cq6519x4sEjybyZtoxmtljiZZU/xxp2iCrE
         FxV/gZmjmd/zkPjWpGdno2R9Sp0IiH98yztCEeBX/nX7EseBR9RSJHEoo/qzsG7MMWI4
         zW5y0DJWsojPflG+dMjdwVGX8kKqEt3sWekjxt9IwwKAHlcuGBkKOeEcoZ6xl0oaU3G1
         bhFA==
X-Received: by 10.14.208.198 with SMTP id q46mr109695341eeo.0.1358228907634;
        Mon, 14 Jan 2013 21:48:27 -0800 (PST)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id g9si5656473eeo.1.2013.01.14.21.48.27
        (version=TLSv1 cipher=AES128-SHA bits=128/128);
        Mon, 14 Jan 2013 21:48:27 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id D777E200057;
	Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 2EE1A101478; Mon, 14 Jan 2013 21:48:25 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.454.gce43f05
In-Reply-To: <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQlabpXq+iYHe300rglahfqonZBZfLycD17qKr/SwY1xwTYXGqk15Ge37psDY2fkYK88yW9mSHPXyBRWzOD/dcKwGYhMXbafe94sEvLW6PPI1La+OgzW7ciYGLH7sZ3f3ZEFj9tCpJRtTbWfOkxoOl/r2ivBJZqzs+EOTOkra9EmnyIgZUU+njVm21l9Vk+uIlAZYRiK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213596>

Throughout most of parse_args(), the variable 'i' remains at 0. Many
references are still made to the variable even when it could only have
the value 0. This made at least me, who has relatively little
experience with C programming styles, think that parts of the function
was meant to be part of a loop. To avoid such confusion, remove the
variable and also the 'argc' parameter and check for NULL trailing
argv instead.

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
---
I explained a bit more why I was confused by the current style, but
I'm also perfectly happy if you just drop the patch (there would be
some minor conflicts in a later patch, though).

 builtin/reset.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 58f0f61..d89cf4d 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -198,9 +198,8 @@ static void die_if_unmerged_cache(int reset_type)
 
 }
 
-static const char **parse_args(int argc, const char **argv, const char *prefix, const char **rev_ret)
+static const char **parse_args(const char **argv, const char *prefix, const char **rev_ret)
 {
-	int i = 0;
 	const char *rev = "HEAD";
 	unsigned char unused[20];
 	/*
@@ -211,34 +210,34 @@ static const char **parse_args(int argc, const char **argv, const char *prefix,
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
+	if (argv[0]) {
+		if (!strcmp(argv[0], "--")) {
+			argv++; /* reset to HEAD, possibly with paths */
+		} else if (argv[1] && !strcmp(argv[1], "--")) {
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
+	return argv[0] ? get_pathspec(prefix, argv) : NULL;
 }
 
 int cmd_reset(int argc, const char **argv, const char *prefix)
@@ -270,7 +269,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
 						PARSE_OPT_KEEP_DASHDASH);
-	pathspec = parse_args(argc, argv, prefix, &rev);
+	pathspec = parse_args(argv, prefix, &rev);
 
 	if (get_sha1_committish(rev, sha1))
 		die(_("Failed to resolve '%s' as a valid ref."), rev);
-- 
1.8.1.1.454.gce43f05
