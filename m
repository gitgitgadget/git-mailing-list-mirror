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
	by dcvr.yhbt.net (Postfix) with ESMTP id 06E5D1F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 02:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391249AbfJYCwB (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 22:52:01 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:46485 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732696AbfJYCwB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 22:52:01 -0400
Received: by mail-vk1-f202.google.com with SMTP id n124so228337vkg.13
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 19:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YCvff+85QpMKmKT6MzrF+anTyQpZ411O2Zun7SX3Zds=;
        b=Drrpnw2S6/MDa3s+UT+NazLihXtncicUf7E4xpUzI2LLzsO6o7Jlfc9xjDKYfERRGA
         ow7vb+m+3OQPr0+C+5bfSYTe6PxcjPwtO3MLWLUYFDZP6+m1b4QPKkpSjDT3B+XdwuDm
         +BCTP+5GpBJdHoBKTKZHzhAGkyy+l0fgqUsBBqrO4RKOynKBC8uXJMafWeyHKb8GcW/I
         UY/5hamY/xqu0SPTHywUtPGHgwhYBV9uYH8QCFAQzEtosgn9dyfLZYHTn0NoU3gkZSs/
         J3Iqp5VafozoApAdxr1Dssem4c8pQKIoJAGfj8buAIW0Uf5hSjPAzmltZ42i05GxW9lE
         Himg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YCvff+85QpMKmKT6MzrF+anTyQpZ411O2Zun7SX3Zds=;
        b=KJwAJtFKgkT6R77l5mwFliULS6RF6TXATSDwqy4qyDlNA+w9bhOHlPlV5nEznfJXox
         /c+68U3Wo0VDlK9MrDW0fAiRMXuxW8S0/sHO/Q12Npih8EeTHBRjvbD/nxVJcDuA6HRP
         6oXaA4U4ncEXBWjqPwV30TbUnvRQLUWtQYo0ZSvTTUh3sJgGgsYj25fKsyvl7f7g7foG
         Q+qxQ0dehI8/v6CFTqs3XRs2uYPdbSJoenz7Mhca5osL7XHVyHP0WpegXz1+CmTqmevA
         HhThbRJw1xjXLPuWCskrDniTr2FbOvOZ4Ez9juJCCAx/lrVbBcfFkQewwSegGreHJ9Ft
         cwJQ==
X-Gm-Message-State: APjAAAViCVzW2SpPVE9PtXf5qM+ThG4BrXwKrxos4QqFnJawfOG6Zmje
        rB/Om3M8qTx1ZRh43zpCSrqR33D7IJZV4MtzDzuAuvbnkiyTf4zQGWmIitO/m2VbMNOrcyWDyd6
        EAFHCbd8aOCUkwRWrG77tlleL/GubKdKTv90e1HbzWnnakmSTHViMbJrWDnT8CfUM07DM3qlMkA
        ==
X-Google-Smtp-Source: APXvYqzlBxqfBWv/FZJm5AIyEW8PwgJ2rqUU6F6V0StbxC2+GQy+IrB0MXujkZWBeWSmRY8qORrq84K1yVppqfF36rg=
X-Received: by 2002:a67:e316:: with SMTP id j22mr777093vsf.152.1571971919973;
 Thu, 24 Oct 2019 19:51:59 -0700 (PDT)
Date:   Thu, 24 Oct 2019 19:51:26 -0700
In-Reply-To: <20191025025129.250049-1-emilyshaffer@google.com>
Message-Id: <20191025025129.250049-7-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191025025129.250049-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v3 6/9] bugreport: count loose objects
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The number of unpacked objects in a user's repository may help us
understand the root of the problem they're seeing, especially if a
command is running unusually slowly.

Rather than directly invoking 'git-count-objects', which may sometimes
fail unexpectedly on Git for Windows, manually count the contents of
.git/objects. Additionally, since we may wish to inspect other
directories' contents for bugreport in the future, put the directory
listing into a helper function.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 bugreport.c         | 72 +++++++++++++++++++++++++++++++++++++++++++++
 bugreport.h         |  6 ++++
 builtin/bugreport.c |  4 +++
 3 files changed, 82 insertions(+)

diff --git a/bugreport.c b/bugreport.c
index 9d7f44ff28..54e1d47103 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -5,8 +5,11 @@
 #include "exec-cmd.h"
 #include "help.h"
 #include "run-command.h"
+#include "strbuf.h"
 #include "version.h"
 
+#include "dirent.h"
+
 /**
  * A sorted list of config options which we will add to the bugreport. Managed
  * by 'gather_whitelist(...)'.
@@ -147,3 +150,72 @@ void get_populated_hooks(struct strbuf *hook_info)
 		}
 	}
 }
+
+/**
+ * Fill 'contents' with the contents of the dir at 'dirpath'.
+ * If 'filter' is nonzero, the contents are filtered on d_type as 'type' - see
+ * 'man readdir'. opendir() doesn't take string length as an arg, so don't
+ * bother passing it in.
+ */
+void list_contents_of_dir(struct string_list *contents, struct strbuf *dirpath,
+			  int filter, unsigned char type)
+{
+	struct dirent *dir = NULL;
+	DIR *dh = NULL;
+
+	dh = opendir(dirpath->buf);
+	while (dh && (dir = readdir(dh))) {
+		if (!filter || type == dir->d_type) {
+			string_list_append(contents, dir->d_name);
+		}
+	}
+}
+
+
+void get_object_counts(struct strbuf *obj_info)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf std_out = STRBUF_INIT;
+
+	argv_array_push(&cp.args, "count-objects");
+	argv_array_push(&cp.args, "-vH");
+	cp.git_cmd = 1;
+	capture_command(&cp, &std_out, 0);
+
+	strbuf_reset(obj_info);
+	strbuf_addstr(obj_info, "git-count-objects -vH:\n");
+	strbuf_addbuf(obj_info, &std_out);
+}
+
+void get_loose_object_summary(struct strbuf *obj_info)
+{
+	struct strbuf dirpath = STRBUF_INIT;
+	struct string_list subdirs = STRING_LIST_INIT_DUP;
+	struct string_list_item *subdir;
+
+	strbuf_reset(obj_info);
+
+	strbuf_addstr(&dirpath, get_object_directory());
+	strbuf_complete(&dirpath, '/');
+
+	list_contents_of_dir(&subdirs, &dirpath, 1, DT_DIR);
+
+	for_each_string_list_item(subdir, &subdirs)
+	{
+		struct strbuf subdir_buf = STRBUF_INIT;
+		struct string_list objects = STRING_LIST_INIT_DUP;
+
+		/*
+		 * Only interested in loose objects - so dirs named with the
+		 * first byte of the object ID
+		 */
+		if (strlen(subdir->string) != 2 || !strcmp(subdir->string, ".."))
+			continue;
+
+		strbuf_addbuf(&subdir_buf, &dirpath);
+		strbuf_addstr(&subdir_buf, subdir->string);
+		list_contents_of_dir(&objects, &subdir_buf, 0, 0);
+		strbuf_addf(obj_info, "%s: %d objects\n", subdir->string,
+			    objects.nr);
+	}
+}
diff --git a/bugreport.h b/bugreport.h
index 942a5436e3..09ad0c2599 100644
--- a/bugreport.h
+++ b/bugreport.h
@@ -18,3 +18,9 @@ void get_whitelisted_config(struct strbuf *sys_info);
  * contents of hook_info will be discarded.
  */
 void get_populated_hooks(struct strbuf *hook_info);
+
+/**
+ * Adds the output of `git count-object -vH`. The previous contents of hook_info
+ * will be discarded.
+ */
+void get_loose_object_summary(struct strbuf *obj_info);
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index a0eefba498..b2ab194207 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -64,6 +64,10 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	get_populated_hooks(&buffer);
 	strbuf_write(&buffer, report);
 
+	add_header(report, "Object Counts");
+	get_loose_object_summary(&buffer);
+	strbuf_write(&buffer, report);
+
 	fclose(report);
 
 	launch_editor(report_path.buf, NULL, NULL);
-- 
2.24.0.rc0.303.g954a862665-goog

