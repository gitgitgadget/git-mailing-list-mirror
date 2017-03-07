Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5156420133
	for <e@80x24.org>; Tue,  7 Mar 2017 03:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754691AbdCGDqB (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 22:46:01 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34251 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbdCGDp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 22:45:59 -0500
Received: by mail-pf0-f178.google.com with SMTP id v190so32083047pfb.1
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 19:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gDUruydO8V7SfD+ibxKoNYPOkVl9srUKTciGlOfbB0s=;
        b=ItEXt68SUEm9UHlL6SFalb5ARWwuX+FF7AyTb0e++Ad/SgzLN9o7eFLdAmG9IKCGxJ
         1IliNv5XsQeJ5qmN6usq+4j5cNipks+q/CD9yGlq5oY64X2sdMIbhbbcsIWOvcnv9BvW
         muNegKr8nuV8gZB3cwP3qO+bamVRTN3Tk2e+hP/kH56WA1c000d213gYA6hjuwdETV+o
         FoztC7xqhT+Ol+dzqV/TNN9igw2A1vLpk8QV/Pkr4HblDOji7X3X0DV9SlhuOvXdbR9Z
         0Lr1ZM/Enb1Rl8oj1JOX4pCoxaeK0uK7/K+4vK9zHCaF22DAnkOS1D/fhxmmKxtT0iWy
         dqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gDUruydO8V7SfD+ibxKoNYPOkVl9srUKTciGlOfbB0s=;
        b=tLyYyKn9vpAPRRUL7SCc9Stn0BIc4oHT6wDR+yw1s3Xbwmd0H8EPPRJqzfQwOr+SiX
         8vpck7nt+7I6Se2IlLTXKX0TW/tC8701ebxV5fxzvdaV8lQqXeAek4LIzXfiZ75qEs4j
         n15dkqijUd7sPGvByx0k7+hlHk7FNmpyhJtBqSHA1clKvuEuqUAMajCvG4LjXOALZRSl
         ZFxtB3f/L+UpBNgXH8CwynuBxNv08M9T0ohhMAT+VbdcekWQfgJAUAnerrx/V+HnMTDe
         PL9cBGLj1dfY9gsLWahy7iGL+arwpoQhkmM6OQAEwT86eHIM0PGwpn86Kka/Y8+0iwMq
         bzsA==
X-Gm-Message-State: AMke39kwzRMA/S7fZG/ldpk+z1bK6Q3+19kIH+Bj5VoSLEAq/tw9m6K7LV5aMtMtyi/yqDE4
X-Received: by 10.98.223.76 with SMTP id u73mr25628873pfg.147.1488858357589;
        Mon, 06 Mar 2017 19:45:57 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:44ae:633a:9d1d:6402])
        by smtp.gmail.com with ESMTPSA id j62sm42349072pgc.54.2017.03.06.19.45.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 19:45:56 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     szeder.dev@gmail.com, email@benjaminfuchs.de, git@vger.kernel.org,
        sandals@crustytoothpaste.net, ville.skytta@iki.fi
Cc:     Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH] rev-parse: add --show-superproject-working-tree
Date:   Mon,  6 Mar 2017 19:45:53 -0800
Message-Id: <20170307034553.10770-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.189.g3bc53220cb.dirty
In-Reply-To: <CAGZ79kZv=LoP+nG0GVtU_Zi+_SX8_98AXFqzXNh=xM6ASy+=Gw@mail.gmail.com>
References: <CAGZ79kZv=LoP+nG0GVtU_Zi+_SX8_98AXFqzXNh=xM6ASy+=Gw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Marking this as RFC as documentation and tests are missing.

 builtin/rev-parse.c |  7 +++++
 submodule.c         | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 submodule.h         |  8 +++++
 3 files changed, 102 insertions(+)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index e08677e559..2549643267 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -12,6 +12,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "split-index.h"
+#include "submodule.h"
 
 #define DO_REVS		1
 #define DO_NOREV	2
@@ -779,6 +780,12 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 					puts(work_tree);
 				continue;
 			}
+			if (!strcmp(arg, "--show-superproject-working-tree")) {
+				const char *superproject = get_superproject_working_tree();
+				if (superproject)
+					puts(superproject);
+				continue;
+			}
 			if (!strcmp(arg, "--show-prefix")) {
 				if (prefix)
 					puts(prefix);
diff --git a/submodule.c b/submodule.c
index 3b98766a6b..a63aef2c6b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1514,3 +1514,90 @@ void absorb_git_dir_into_superproject(const char *prefix,
 		strbuf_release(&sb);
 	}
 }
+
+static int superproject_exists(void)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf sb = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	const char *one_up = real_path_if_valid("../");
+	const char *dirname;
+	int code, has_superproject = 0;
+
+	if (!one_up)
+		/* At the root of the file system. */
+		return 0;
+
+	dirname = relative_path(xgetcwd(), one_up, &sb);
+	prepare_submodule_repo_env(&cp.env_array);
+	argv_array_pop(&cp.env_array);
+	argv_array_pushl(&cp.args, "--literal-pathspecs", "-C", "..",
+			"ls-tree", "HEAD", "--", dirname, NULL);
+
+	cp.no_stdin = 1;
+	cp.no_stderr = 1;
+	cp.out = -1;
+	cp.git_cmd = 1;
+
+	if (start_command(&cp))
+		die(_("could not start ls-tree in .."));
+
+	strbuf_read(&buf, cp.out, 7);
+	close(cp.out);
+	if (starts_with(buf.buf, "160000"))
+		/* there is a superproject having this as a submodule */
+		has_superproject = 1;
+
+	code = finish_command(&cp);
+
+	if (code == 128)
+		/* not a git repository */
+		goto out;
+	if (code == 0 && !has_superproject)
+		/* there is an unrelated git repository */
+		goto out;
+
+	if (code)
+		die(_("ls-tree returned unexpected return code"));
+
+	return 1;
+
+out:
+	strbuf_release(&sb);
+
+	return 0;
+}
+
+const char *get_superproject_working_tree()
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf sb = STRBUF_INIT;
+
+	if (!superproject_exists())
+		return NULL;
+
+	prepare_submodule_repo_env(&cp.env_array);
+	argv_array_pop(&cp.env_array);
+
+	argv_array_pushl(&cp.args, "-C", "..",
+			"rev-parse", "--show-toplevel", NULL);
+
+	cp.no_stdin = 1;
+	cp.no_stderr = 1;
+	cp.out = -1;
+	cp.git_cmd = 1;
+
+	if (start_command(&cp))
+		die(_("could not start rev-parse in .."));
+
+	strbuf_reset(&sb);
+	strbuf_read(&sb, cp.out, PATH_MAX);
+
+	/* remove trailing new line */
+	strbuf_rtrim(&sb);
+
+	if (finish_command(&cp))
+		die(_("rev-parse died unexpectedly"));
+
+	return strbuf_detach(&sb, NULL);
+}
diff --git a/submodule.h b/submodule.h
index 05ab674f06..f207bb8d5f 100644
--- a/submodule.h
+++ b/submodule.h
@@ -93,4 +93,12 @@ extern void prepare_submodule_repo_env(struct argv_array *out);
 extern void absorb_git_dir_into_superproject(const char *prefix,
 					     const char *path,
 					     unsigned flags);
+
+/*
+ * Return the absolute path of the working tree of the superproject, which this
+ * project is a submodule of. If this repository is not a submodule of
+ * another repository, return NULL.
+ */
+extern const char *get_superproject_working_tree();
+
 #endif
-- 
2.12.0.189.g3bc53220cb.dirty

