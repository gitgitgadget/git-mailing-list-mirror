From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/RFC/GSoC 03/17] builtin-rebase: implement skeletal builtin rebase
Date: Sat, 12 Mar 2016 18:46:23 +0800
Message-ID: <1457779597-6918-4-git-send-email-pyokagan@gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com,
	Paul Tan <pyokagan@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 12 11:47:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeh4k-0005iB-NR
	for gcvg-git-2@plane.gmane.org; Sat, 12 Mar 2016 11:47:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbcCLKrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2016 05:47:09 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36695 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbcCLKrE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2016 05:47:04 -0500
Received: by mail-pa0-f48.google.com with SMTP id tt10so119738009pab.3
        for <git@vger.kernel.org>; Sat, 12 Mar 2016 02:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u5xKOZNKYkk+F/w0gWzd0vV1KPwWRLQ4ZghzdIj+qRE=;
        b=Kq8Z67kbNt7OWQCvzWsqITQZ/Fey4hu91LjR6TjRhp4Gk5kwbPsYpPojmXnnbDvPIz
         WdpymHyXuAH5dA7mi88z+kXmpJKRVOGUSUjHbPbpFQWAKId5r9ttVUprEuNdp/Shfjrm
         ziNrWMrz7LqQooj7Hs5oQYW7zCoNCTiR7/fYMrRIqULDncZibB5TvMNSczoqtxmOMQ/L
         VSunP2u1HJVQlu9l2II+Eat1F4wCpLHhlGdkuxqOen2/vUMXSSMIrJ4Lbdnflm2Q8kAV
         6Cnl4lcY6KA/wuTqgLbguk/8D2UkhI4WG3U0NoLtks8AqenGeBiaYmxoOuQjrC+6d2Bc
         o0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u5xKOZNKYkk+F/w0gWzd0vV1KPwWRLQ4ZghzdIj+qRE=;
        b=dQgQMkofl+Kz6n4T+fOTYeW2kd5CoIBFFRJrbXmmlWo3O2pruEcYVgAorglL69HZqe
         8klQbz8Yhl/p8G0CGvni1pPWhqxUPA/gD9xs4uoNxzGBap7n7s6HmZ4UxEiSeyJe8REP
         i6XcUWlv9ue58/aLNeAvUgdmvUxC1eGwpL2KlJ2NsXqlp0BPYYxkTciN+Syp5/EzpQoL
         kQPcz5lH8aT7Vvz7V5mDxzadjFsCLGRLG35wCdkx0H8qIMFvt5shVR+Dg7Uv0vP9sucw
         EU19YYAh80PWwgsvTZVDO7IoClPgc08IOqpSoAdMgnuo2t1RowATavpEj4E1d/e7ClOb
         at+g==
X-Gm-Message-State: AD7BkJIU2Zej6QKwQj2EG/kOcAfyzXdamchBkErSVBaMuqO8h+sNwlRWoMj/+C/pR+P1Rw==
X-Received: by 10.66.141.42 with SMTP id rl10mr23049580pab.48.1457779624111;
        Sat, 12 Mar 2016 02:47:04 -0800 (PST)
Received: from yoshi.chippynet.com ([116.86.77.230])
        by smtp.gmail.com with ESMTPSA id tb10sm18983519pab.22.2016.03.12.02.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 12 Mar 2016 02:47:03 -0800 (PST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288735>

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 Makefile         |  5 +----
 builtin.h        |  1 +
 builtin/rebase.c | 31 +++++++++++++++++++++++++++++++
 git.c            |  1 +
 4 files changed, 34 insertions(+), 4 deletions(-)
 create mode 100644 builtin/rebase.c

diff --git a/Makefile b/Makefile
index 24bef8d..ad98714 100644
--- a/Makefile
+++ b/Makefile
@@ -496,7 +496,6 @@ SCRIPT_SH += git-merge-one-file.sh
 SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-quiltimport.sh
-SCRIPT_SH += git-rebase.sh
 SCRIPT_SH += git-remote-testgit.sh
 SCRIPT_SH += git-request-pull.sh
 SCRIPT_SH += git-stash.sh
@@ -505,9 +504,6 @@ SCRIPT_SH += git-web--browse.sh
 
 SCRIPT_LIB += git-mergetool--lib
 SCRIPT_LIB += git-parse-remote
-SCRIPT_LIB += git-rebase--am
-SCRIPT_LIB += git-rebase--interactive
-SCRIPT_LIB += git-rebase--merge
 SCRIPT_LIB += git-sh-setup
 SCRIPT_LIB += git-sh-i18n
 
@@ -909,6 +905,7 @@ BUILTIN_OBJS += builtin/prune.o
 BUILTIN_OBJS += builtin/pull.o
 BUILTIN_OBJS += builtin/push.o
 BUILTIN_OBJS += builtin/read-tree.o
+BUILTIN_OBJS += builtin/rebase.o
 BUILTIN_OBJS += builtin/receive-pack.o
 BUILTIN_OBJS += builtin/reflog.o
 BUILTIN_OBJS += builtin/remote.o
diff --git a/builtin.h b/builtin.h
index 6b95006..a184a58 100644
--- a/builtin.h
+++ b/builtin.h
@@ -102,6 +102,7 @@ extern int cmd_prune_packed(int argc, const char **argv, const char *prefix);
 extern int cmd_pull(int argc, const char **argv, const char *prefix);
 extern int cmd_push(int argc, const char **argv, const char *prefix);
 extern int cmd_read_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_rebase(int argc, const char **argv, const char *prefix);
 extern int cmd_receive_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_reflog(int argc, const char **argv, const char *prefix);
 extern int cmd_remote(int argc, const char **argv, const char *prefix);
diff --git a/builtin/rebase.c b/builtin/rebase.c
new file mode 100644
index 0000000..04cc1bd
--- /dev/null
+++ b/builtin/rebase.c
@@ -0,0 +1,31 @@
+/*
+ * Builtin "git rebase"
+ */
+#include "cache.h"
+#include "builtin.h"
+#include "parse-options.h"
+
+static int git_rebase_config(const char *k, const char *v, void *cb)
+{
+	return git_default_config(k, v, NULL);
+}
+
+int cmd_rebase(int argc, const char **argv, const char *prefix)
+{
+	const char * const usage[] = {
+		N_("git rebase [options]"),
+		NULL
+	};
+	struct option options[] = {
+		OPT_END()
+	};
+
+	git_config(git_rebase_config, NULL);
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+
+	if (read_cache_preload(NULL) < 0)
+		die(_("failed to read the index"));
+
+	return 0;
+}
diff --git a/git.c b/git.c
index 6cc0c07..f9b7033 100644
--- a/git.c
+++ b/git.c
@@ -452,6 +452,7 @@ static struct cmd_struct commands[] = {
 	{ "pull", cmd_pull, RUN_SETUP | NEED_WORK_TREE },
 	{ "push", cmd_push, RUN_SETUP },
 	{ "read-tree", cmd_read_tree, RUN_SETUP },
+	{ "rebase", cmd_rebase, RUN_SETUP | NEED_WORK_TREE },
 	{ "receive-pack", cmd_receive_pack },
 	{ "reflog", cmd_reflog, RUN_SETUP },
 	{ "remote", cmd_remote, RUN_SETUP },
-- 
2.7.0
