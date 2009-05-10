From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/6] mktree: use parse-options
Date: Sun, 10 May 2009 11:49:47 -0700
Message-ID: <1241981391-19639-3-git-send-email-gitster@pobox.com>
References: <1241981391-19639-1-git-send-email-gitster@pobox.com>
 <1241981391-19639-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 10 20:50:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3E6P-0004rg-Es
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 20:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755968AbZEJSuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 14:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754978AbZEJSt7
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 14:49:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52385 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754741AbZEJSt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 14:49:57 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 66A36B1B66
	for <git@vger.kernel.org>; Sun, 10 May 2009 14:49:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D1203B1B65 for
 <git@vger.kernel.org>; Sun, 10 May 2009 14:49:57 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.9.g6345d
In-Reply-To: <1241981391-19639-2-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5C325214-3D93-11DE-BEF3-CABC03BA4B0C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118734>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-mktree.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin-mktree.c b/builtin-mktree.c
index 3d05427..2b3145b 100644
--- a/builtin-mktree.c
+++ b/builtin-mktree.c
@@ -6,6 +6,7 @@
 #include "builtin.h"
 #include "quote.h"
 #include "tree.h"
+#include "parse-options.h"
 
 static struct treeent {
 	unsigned mode;
@@ -61,7 +62,10 @@ static void write_tree(unsigned char *sha1)
 	write_sha1_file(buf.buf, buf.len, tree_type, sha1);
 }
 
-static const char mktree_usage[] = "git mktree [-z]";
+static const char *mktree_usage[] = {
+	"git mktree [-z]",
+	NULL
+};
 
 int cmd_mktree(int ac, const char **av, const char *prefix)
 {
@@ -69,16 +73,12 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 	struct strbuf p_uq = STRBUF_INIT;
 	unsigned char sha1[20];
 	int line_termination = '\n';
+	const struct option option[] = {
+		OPT_SET_INT('z', NULL, &line_termination, "input is NUL terminated", '\0'),
+		OPT_END()
+	};
 
-	while ((1 < ac) && av[1][0] == '-') {
-		const char *arg = av[1];
-		if (!strcmp("-z", arg))
-			line_termination = 0;
-		else
-			usage(mktree_usage);
-		ac--;
-		av++;
-	}
+	ac = parse_options(ac, av, option, mktree_usage, 0);
 
 	while (strbuf_getline(&sb, stdin, line_termination) != EOF) {
 		char *ptr, *ntr;
-- 
1.6.3.9.g6345d
