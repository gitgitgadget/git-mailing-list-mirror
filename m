From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH v2 1/3] blame: add --abbrev command line option
Date: Wed,  6 Apr 2011 11:20:50 +0900
Message-ID: <1302056452-5387-1-git-send-email-namhyung@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 04:21:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7IN2-0004UH-8G
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 04:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754248Ab1DFCVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 22:21:00 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42493 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754214Ab1DFCU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 22:20:59 -0400
Received: by ywj3 with SMTP id 3so416848ywj.19
        for <git@vger.kernel.org>; Tue, 05 Apr 2011 19:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=ZSLiNFlBXAFA/2FFX2kxzqQfyD2FodsAzIYvrKb7tX8=;
        b=m+v+Jk1K8KtQLVWb8TN1+z2J6JPCuW+eWzQePn/qEjSN9K1jZXSNS5+2G9GifMtyRy
         I8tbphUJFLI7pzAOwF+gnGqcJnzYKzepedRTLbxAntaLVUEN8yC+NV1jWng8qhvd5ktQ
         qMro42fIdPGvkxISelYBlWFPCAg6EWG23rYIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Ecy1xgwyTJN7DaVm2/+/hsdhEy+TcLHAL3sWYzmuRsFNF0uF4cjFZX8L9Nn3hwfxw6
         l+PUiiJBcsEvYOl3ywdJ0fO/9v7/fRJg6LJo+v42h7r8wk5ITGZ4zSOdbva3o/oRHQnk
         WEtzUdxkUrAp1l25jU9u5jvS2m0kY9JjHzzUE=
Received: by 10.150.172.18 with SMTP id u18mr1309694ybe.51.1302056458739;
        Tue, 05 Apr 2011 19:20:58 -0700 (PDT)
Received: from localhost.localdomain ([118.176.76.173])
        by mx.google.com with ESMTPS id p23sm443416ybk.24.2011.04.05.19.20.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Apr 2011 19:20:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170947>

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 builtin/blame.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index f6b03f7..253b480 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -41,6 +41,7 @@ static int reverse;
 static int blank_boundary;
 static int incremental;
 static int xdl_opts;
+static int abbrev = 8;
 
 static enum date_mode blame_date_mode = DATE_ISO8601;
 static size_t blame_date_width;
@@ -1670,7 +1671,7 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 	cp = nth_line(sb, ent->lno);
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
 		char ch;
-		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? 40 : 8;
+		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? 40 : abbrev;
 
 		if (suspect->commit->object.flags & UNINTERESTING) {
 			if (blank_boundary)
@@ -2310,6 +2311,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 'C', NULL, &opt, "score", "Find line copies within and across files", PARSE_OPT_OPTARG, blame_copy_callback },
 		{ OPTION_CALLBACK, 'M', NULL, &opt, "score", "Find line movements within and across files", PARSE_OPT_OPTARG, blame_move_callback },
 		OPT_CALLBACK('L', NULL, &bottomtop, "n,m", "Process only line range n,m, counting from 1", blame_bottomtop_callback),
+		OPT__ABBREV(&abbrev),
 		OPT_END()
 	};
 
-- 
1.7.4
