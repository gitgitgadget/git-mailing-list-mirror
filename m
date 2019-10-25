Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0437E1F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 02:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391145AbfJYCvm (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 22:51:42 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:34423 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732696AbfJYCvm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 22:51:42 -0400
Received: by mail-pf1-f202.google.com with SMTP id a1so785723pfn.1
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 19:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WDh11je03PVm+Rfs/Oo/s+eIqA68pYQ1aARLmtbselo=;
        b=nYLD6X/TaBqpsCsWFlG678JHUhNkpKZByw4ZTxCeD6ydd5261yQZ/Vues/ELB9jDVT
         TlLrRKZb9F28HJ7gc+XaoCLdcWnFyrr2gkSh70ZRD+8zeW3nt/cBoKr+K/MtO+ptT3jp
         eEsffb4YOUpJfUjYBsybte4joYyObmxZCsLSp75fGWWBADtF6rMRVFmu3uXI0THgAlAi
         P+TLKnXU6ddE6PX+pY7u5u7RAI+PlEsz50zJDazUYA2uUpP8LUsObgOJyYVDRfEJzo+Y
         82LCVq34sIgesGMKKzAT+U3ACWbLJ8CGwwEC5TP27EBp7F2qYqUgMgINWWWuGLZ43rMK
         wp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WDh11je03PVm+Rfs/Oo/s+eIqA68pYQ1aARLmtbselo=;
        b=THwKKQMxTE+p5XbggFOxXVxFCDYiv68n4nS9MUk7ZpbAPEuWsc/ZOD3z4qpRUtgfm/
         szNFCrdL40JlW+LiWbDPYfY/A4P1/wIcSNC7abbtQAaGSViSxTYPW5XxeRCqGYzYhjFH
         BrmMzg52Wap24YM4P/SD85Y0mBNPuN/mnkVhArzSKUgMWE5bzFZqKLvs9om55do+9BD6
         +rJPDq4UrDbhGFDTyC20DHHkPdEC+g2DGUnFMJMPapmlMsiNEhBmp0pPdI0cSwjeW4rm
         Uuw3B/r2IeLKUx7PA2QoQIWW2qrGMkkuiy9lUSMUT8Kymd3bEtfBzSBKa9uAcdCcMjP5
         IoSw==
X-Gm-Message-State: APjAAAW59OLe45OYx5InYiwzIXm4FSIiEm4DU5bcHWtDqOqlMN2pjyzq
        +5E/4n3LLwEs4zlB2EVtObyZ9tQrJ5iLukR0wlHjo3evtdmQinPvZnF+1qM/KvZMSpawcnqWIjS
        stfLx9nm1bMv2f4HXr71bXNgJZ9QeRN2Nt4PIecRnlN03mlObm4wJx2qAb+9y4dWmBTNChjpJgg
        ==
X-Google-Smtp-Source: APXvYqwHPdgbicYt9NfQTm7joOYK294H2w0//aLNf8NyNzBLLS1n2LBZ9+8yUPupNJSHg6apihUCjwRNd1TwmN9TRXw=
X-Received: by 2002:a65:464b:: with SMTP id k11mr1470817pgr.263.1571971900942;
 Thu, 24 Oct 2019 19:51:40 -0700 (PDT)
Date:   Thu, 24 Oct 2019 19:51:21 -0700
In-Reply-To: <20191025025129.250049-1-emilyshaffer@google.com>
Message-Id: <20191025025129.250049-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191025025129.250049-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v3 1/9] bugreport: add tool to generate debugging info
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach Git how to prompt the user for a good bug report: reproduction
steps, expected behavior, and actual behavior. Later, Git can learn how
to collect some diagnostic information from the repository.

If users can send us a well-written bug report which contains diagnostic
information we would otherwise need to ask the user for, we can reduce
the number of question-and-answer round trips between the reporter and
the Git contributor.

Users may also wish to send a report like this to their local "Git
expert" if they have put their repository into a state they are confused
by.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Makefile            |  1 +
 builtin.h           |  1 +
 builtin/bugreport.c | 50 +++++++++++++++++++++++++++++++++++++++++++++
 git.c               |  1 +
 4 files changed, 53 insertions(+)
 create mode 100644 builtin/bugreport.c

diff --git a/Makefile b/Makefile
index 58b92af54b..132e2a52da 100644
--- a/Makefile
+++ b/Makefile
@@ -1039,6 +1039,7 @@ BUILTIN_OBJS += builtin/archive.o
 BUILTIN_OBJS += builtin/bisect--helper.o
 BUILTIN_OBJS += builtin/blame.o
 BUILTIN_OBJS += builtin/branch.o
+BUILTIN_OBJS += builtin/bugreport.o
 BUILTIN_OBJS += builtin/bundle.o
 BUILTIN_OBJS += builtin/cat-file.o
 BUILTIN_OBJS += builtin/check-attr.o
diff --git a/builtin.h b/builtin.h
index 5cf5df69f7..c6373d3289 100644
--- a/builtin.h
+++ b/builtin.h
@@ -135,6 +135,7 @@ int cmd_archive(int argc, const char **argv, const char *prefix);
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix);
 int cmd_blame(int argc, const char **argv, const char *prefix);
 int cmd_branch(int argc, const char **argv, const char *prefix);
+int cmd_bugreport(int argc, const char **argv, const char *prefix);
 int cmd_bundle(int argc, const char **argv, const char *prefix);
 int cmd_cat_file(int argc, const char **argv, const char *prefix);
 int cmd_checkout(int argc, const char **argv, const char *prefix);
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
new file mode 100644
index 0000000000..2ef16440a0
--- /dev/null
+++ b/builtin/bugreport.c
@@ -0,0 +1,50 @@
+#include "builtin.h"
+#include "stdio.h"
+#include "strbuf.h"
+#include "time.h"
+
+int get_bug_template(struct strbuf *template)
+{
+	const char template_text[] =
+"Thank you for filling out a Git bug report!\n"
+"Please answer the following questions to help us understand your issue.\n"
+"\n"
+"What did you do before the bug happened? (Steps to reproduce your issue)\n"
+"\n"
+"What did you expect to happen? (Expected behavior)\n"
+"\n"
+"What happened instead? (Actual behavior)\n"
+"\n"
+"What's different between what you expected and what actually happened?\n"
+"\n"
+"Anything else you want to add:\n"
+"\n"
+"Please review the rest of the bug report below.\n"
+"You can delete any lines you don't wish to send.\n";
+
+	strbuf_reset(template);
+	strbuf_add(template, template_text, strlen(template_text));
+	return 0;
+}
+
+int cmd_bugreport(int argc, const char **argv, const char *prefix)
+{
+	struct strbuf buffer = STRBUF_INIT;
+	struct strbuf report_path = STRBUF_INIT;
+	FILE *report;
+	time_t now = time(NULL);
+
+	strbuf_addstr(&report_path, "git-bugreport-");
+	strbuf_addftime(&report_path, "%F", gmtime(&now), 0, 0);
+	strbuf_addstr(&report_path, ".txt");
+
+	report = fopen_for_writing(report_path.buf);
+
+	get_bug_template(&buffer);
+	strbuf_write(&buffer, report);
+
+	fclose(report);
+
+	launch_editor(report_path.buf, NULL, NULL);
+	return 0;
+}
diff --git a/git.c b/git.c
index ce6ab0ece2..2d6a64f019 100644
--- a/git.c
+++ b/git.c
@@ -473,6 +473,7 @@ static struct cmd_struct commands[] = {
 	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
 	{ "blame", cmd_blame, RUN_SETUP },
 	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
+	{ "bugreport", cmd_bugreport, RUN_SETUP },
 	{ "bundle", cmd_bundle, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "cat-file", cmd_cat_file, RUN_SETUP },
 	{ "check-attr", cmd_check_attr, RUN_SETUP },
-- 
2.24.0.rc0.303.g954a862665-goog

