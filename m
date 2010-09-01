From: Thiago Farina <tfransosi@gmail.com>
Subject: [Patch v2] builtin.h: Move two functions definitions to help.h.
Date: Tue, 31 Aug 2010 23:29:08 -0300
Message-ID: <1283308148-29880-1-git-send-email-tfransosi@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 01 04:29:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqd4o-0006Xc-2q
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 04:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902Ab0IAC3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 22:29:20 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49969 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618Ab0IAC3T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 22:29:19 -0400
Received: by gyd8 with SMTP id 8so2813983gyd.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 19:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=WRf2OeWfoSQ+LINzwU+SJ2v4N1oQjm+5IyFdHWJ2A2k=;
        b=gULwcCQnhEpNMQXY9wZ4+iFP6Kaj/mYI8YUnoSZHcOjgJBtkVXJ36ugW5al/bjfCZH
         5VXlTWsELhmXL0bBAidBsl2NtZO8BnSh2olmuVlj/oo+O98aKRbXkNBhF5QPRtNamcMP
         kabq72uMwdqci+gyAkBs33aUo0kJ4QbG4DXyg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=DZkKGHzZqgv9RYClCrrBUlYAvj7qryd0/JVEXWwtIOB3H1iWSDhxnbPavGneOFy3LA
         2jSsFbXfgFIMH/XM5Fz7dyPqoi7SXIhvWOeJ7iQy4EoL31F6Wc683Ta9sWExgUWmkBha
         ZiNcoKV9/9Q580CYGF8XT6+vGTBcLEeacNEIU=
Received: by 10.150.175.4 with SMTP id x4mr3333821ybe.325.1283308159084;
        Tue, 31 Aug 2010 19:29:19 -0700 (PDT)
Received: from localhost ([186.205.0.204])
        by mx.google.com with ESMTPS id t16sm4912375ybm.22.2010.08.31.19.29.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 19:29:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.95.g3d045
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155004>

The two functions defined here are implemented in help.c, so makes more sense
to put the definition of those in help.h instead of in builtin.h.

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 builtin.h |    2 --
 git.c     |    3 ++-
 help.h    |   19 +++++++++++--------
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/builtin.h b/builtin.h
index ed6ee26..0398d24 100644
--- a/builtin.h
+++ b/builtin.h
@@ -11,8 +11,6 @@ extern const char git_version_string[];
 extern const char git_usage_string[];
 extern const char git_more_info_string[];
 
-extern void list_common_cmds_help(void);
-extern const char *help_unknown_cmd(const char *cmd);
 extern void prune_packed_objects(int);
 extern int fmt_merge_msg(int merge_summary, struct strbuf *in,
 	struct strbuf *out);
diff --git a/git.c b/git.c
index 12d2952..05d4156 100644
--- a/git.c
+++ b/git.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
-#include "exec_cmd.h"
 #include "cache.h"
+#include "exec_cmd.h"
+#include "help.h"
 #include "quote.h"
 #include "run-command.h"
 
diff --git a/help.h b/help.h
index 56bc154..208af70 100644
--- a/help.h
+++ b/help.h
@@ -16,14 +16,17 @@ static inline void mput_char(char c, unsigned int num)
 		putchar(c);
 }
 
-void load_command_list(const char *prefix,
-		struct cmdnames *main_cmds,
-		struct cmdnames *other_cmds);
-void add_cmdname(struct cmdnames *cmds, const char *name, int len);
+extern void list_common_cmds_help(void);
+extern const char *help_unknown_cmd(const char *cmd);
+extern void load_command_list(const char *prefix,
+                              struct cmdnames *main_cmds,
+		              struct cmdnames *other_cmds);
+extern void add_cmdname(struct cmdnames *cmds, const char *name, int len);
 /* Here we require that excludes is a sorted list. */
-void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes);
-int is_in_cmdlist(struct cmdnames *c, const char *s);
-void list_commands(const char *title, struct cmdnames *main_cmds,
-		   struct cmdnames *other_cmds);
+extern void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes);
+extern int is_in_cmdlist(struct cmdnames *cmds, const char *name);
+extern void list_commands(const char *title,
+                          struct cmdnames *main_cmds,
+		          struct cmdnames *other_cmds);
 
 #endif /* HELP_H */
-- 
1.7.2.1.95.g3d045
