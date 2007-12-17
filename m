From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 7/7] git-tag: fix -l switch handling regression.
Date: Mon, 17 Dec 2007 19:23:17 +0100
Message-ID: <1197915797-30679-8-git-send-email-madcoder@debian.org>
References: <1197915797-30679-1-git-send-email-madcoder@debian.org>
 <1197915797-30679-2-git-send-email-madcoder@debian.org>
 <1197915797-30679-3-git-send-email-madcoder@debian.org>
 <1197915797-30679-4-git-send-email-madcoder@debian.org>
 <1197915797-30679-5-git-send-email-madcoder@debian.org>
 <1197915797-30679-6-git-send-email-madcoder@debian.org>
 <1197915797-30679-7-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 17 19:26:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4KdS-0003yo-Vj
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 19:24:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756767AbXLQSX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 13:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756230AbXLQSX2
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 13:23:28 -0500
Received: from pan.madism.org ([88.191.52.104]:54947 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756633AbXLQSXU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 13:23:20 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 3026E3095C;
	Mon, 17 Dec 2007 19:23:19 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 3B6DC4C0D93; Mon, 17 Dec 2007 19:23:17 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc0.1148.ga3ab1-dirty
In-Reply-To: <1197915797-30679-7-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68595>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-tag.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index fd44b2e..c7a1563 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -16,7 +16,7 @@
 static const char * const git_tag_usage[] = {
 	"git-tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<head>]",
 	"git-tag -d <tagname>...",
-	"git-tag [-n [<num>]] -l [<pattern>]",
+	"git-tag -l [-n [<num>]] [<pattern>]",
 	"git-tag -v <tagname>...",
 	NULL
 };
@@ -370,13 +370,11 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct ref_lock *lock;
 
 	int annotate = 0, sign = 0, force = 0, lines = 0,
-					delete = 0, verify = 0;
-	char *list = NULL, *msgfile = NULL, *keyid = NULL;
-	const char *no_pattern = "NO_PATTERN";
+		list = 0, delete = 0, verify = 0;
+	char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct option options[] = {
-		{ OPTION_STRING, 'l', NULL, &list, "pattern", "list tag names",
-			PARSE_OPT_OPTARG, NULL, (intptr_t) no_pattern },
+		OPT_INTEGER('l', NULL, &list, "list tag names"),
 		{ OPTION_INTEGER, 'n', NULL, &lines, NULL,
 				"print n lines of each tag message",
 				PARSE_OPT_OPTARG, NULL, 1 },
@@ -408,7 +406,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		annotate = 1;
 
 	if (list)
-		return list_tags(list == no_pattern ? NULL : list, lines);
+		return list_tags(argv[0], lines);
 	if (delete)
 		return for_each_tag_name(argv, delete_tag);
 	if (verify)
-- 
1.5.4.rc0.1148.ga3ab1-dirty
