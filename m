Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129A9C35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18C32166E
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OL9IuFPV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbgBFAlc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 19:41:32 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:42257 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbgBFAl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 19:41:29 -0500
Received: by mail-pj1-f73.google.com with SMTP id hi12so2285397pjb.7
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 16:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0SxoWHucftRH/KPOoSORrHecC74+RUfZbQilCzLwPQU=;
        b=OL9IuFPVYZB2S+C6YlgMU9556kwIMDASAl5trqAfFUwQ7gEFXG3Y81E82Llr4GGkBL
         DUYkh3U7pP/B3+V8j33XrdSrLWafY3HWKe4qYExlqC3MkxgwLAQvhKbbkGYP8YwvMjfL
         VFX3X54c0g7YFhtdOw7gF+HBKa4i9Im2Duv0xQCBlgWITFx7TZWGxw6jWc4ZM1+39iLf
         g6FKPA35LXTRdc8C09qucYLiehx8eiv49n8W7iZpbA8n+wYfrVgdcqV8U9lcDvdBIK+O
         ZcevEK91M5FPuAk/ZGuhH9hf+dQZMOH5Q+DVTsMTdcZFU1vEcD+PDUPMHtcn8FiF4XJy
         ds0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0SxoWHucftRH/KPOoSORrHecC74+RUfZbQilCzLwPQU=;
        b=Wgdkx+sbunVhtm33mIzrn4N3kE4BErtyoWWEYDIEkPJruUGKbBFOKoaJFF/OgojOp0
         d3vWmfRMyTJa8G3P5QxegYwty6Hul1CpSubJZxwpJTI5aLyuCuY1lqy0bUiaSgxxUdbo
         qDO8jIJxefG6KM1zGKsPxS0INa2agtv245qb7Q/2u6CHPnwGB68ZtD3UqnPWXeFvUNXY
         fd34o/oNKDAZiPelkNfJ3Q+f++uuWwAhYVxYjFFE0hWUUXUfnYZCw+obthNyEBEPpHPv
         3Y0opiEE00LXauwRsxL0XglDYeeTYMOuZQ9bcmd/ltC1oG0MKC549k+Pm9o9BycMVQS9
         WR3Q==
X-Gm-Message-State: APjAAAVGGwTh0D1GjbQ+aNQfj7nOA6yUjalqgIuX9ofhHpUqw4S35KNS
        RO0Q23rS/QTLhd08gY65tAG0/6JF+iaRnlQt6wgFjbqvuqCrcuEsQMxuuyX/aRmyY9Zvso47oci
        pFJ3bNcTYo2Sml+e5xLDFPIpFvwTNunhcC6TrthO5xnzlzc4b4A5SZUNyLd6QahA/woiDfd40pg
        ==
X-Google-Smtp-Source: APXvYqxG+5hi8G0uY37f70PC0+xupZVNZ1GiGF0zqkFg//q1oAtFYEVxvU/d0+fHHStAWNmBJfFWxuWa6ZMCbWBRcS0=
X-Received: by 2002:a63:447:: with SMTP id 68mr618575pge.97.1580949688964;
 Wed, 05 Feb 2020 16:41:28 -0800 (PST)
Date:   Wed,  5 Feb 2020 16:40:56 -0800
In-Reply-To: <20200206004108.261317-1-emilyshaffer@google.com>
Message-Id: <20200206004108.261317-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200206004108.261317-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v6 03/15] bugreport: add tool to generate debugging info
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
 .gitignore                      |  1 +
 Documentation/git-bugreport.txt | 41 ++++++++++++++++
 Makefile                        |  5 ++
 bugreport.c                     | 85 +++++++++++++++++++++++++++++++++
 t/t0091-bugreport.sh            | 49 +++++++++++++++++++
 5 files changed, 181 insertions(+)
 create mode 100644 Documentation/git-bugreport.txt
 create mode 100644 bugreport.c
 create mode 100755 t/t0091-bugreport.sh

diff --git a/.gitignore b/.gitignore
index ea97de83f3..d89bf9e11e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -25,6 +25,7 @@
 /git-bisect--helper
 /git-blame
 /git-branch
+/git-bugreport
 /git-bundle
 /git-cat-file
 /git-check-attr
diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
new file mode 100644
index 0000000000..52d49ed7aa
--- /dev/null
+++ b/Documentation/git-bugreport.txt
@@ -0,0 +1,41 @@
+git-bugreport(1)
+================
+
+NAME
+----
+git-bugreport - Collect information for user to file a bug report
+
+SYNOPSIS
+--------
+[verse]
+'git bugreport' [(-o | --output-directory) <path>] [(-s | --suffix) <format>]
+
+DESCRIPTION
+-----------
+Captures information about the user's machine, Git client, and repository state,
+as well as a form requesting information about the behavior the user observed,
+into a single text file which the user can then share, for example to the Git
+mailing list, in order to report an observed bug.
+
+The following information is requested from the user:
+
+ - Reproduction steps
+ - Expected behavior
+ - Actual behavior
+
+OPTIONS
+-------
+-o <path>::
+--output-directory <path>::
+	Place the resulting bug report file in `<path>` instead of the root of
+	the Git repository.
+
+-s <format>::
+--suffix <format>::
+	Specify an alternate suffix for the bugreport name, to create a file
+	named 'git-bugreport-<formatted suffix>'. This should take the form of a
+	link:strftime[3] format string; the current local time will be used.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 5a022367d4..a01a050aa3 100644
--- a/Makefile
+++ b/Makefile
@@ -681,6 +681,7 @@ EXTRA_PROGRAMS =
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS += $(EXTRA_PROGRAMS)
 
+PROGRAM_OBJS += bugreport.o
 PROGRAM_OBJS += credential-store.o
 PROGRAM_OBJS += daemon.o
 PROGRAM_OBJS += fast-import.o
@@ -2457,6 +2458,10 @@ endif
 git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
+git-bugreport$X: bugreport.o GIT-LDFLAGS $(GITLIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+		$(LIBS)
+
 git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(IMAP_SEND_LDFLAGS) $(LIBS)
diff --git a/bugreport.c b/bugreport.c
new file mode 100644
index 0000000000..db46fb88be
--- /dev/null
+++ b/bugreport.c
@@ -0,0 +1,85 @@
+#include "builtin.h"
+#include "parse-options.h"
+#include "stdio.h"
+#include "strbuf.h"
+#include "time.h"
+
+static const char * const bugreport_usage[] = {
+	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]"),
+	NULL
+};
+
+static int get_bug_template(struct strbuf *template)
+{
+	const char template_text[] = N_(
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
+"You can delete any lines you don't wish to share.\n");
+
+	strbuf_addstr(template, template_text);
+	return 0;
+}
+
+int cmd_main(int argc, const char **argv)
+{
+	struct strbuf buffer = STRBUF_INIT;
+	struct strbuf report_path = STRBUF_INIT;
+	FILE *report;
+	time_t now = time(NULL);
+	char *option_output = NULL;
+	char *option_suffix = "%F-%H%M";
+	struct stat statbuf;
+
+	const struct option bugreport_options[] = {
+		OPT_STRING('o', "output-directory", &option_output, N_("path"),
+			   N_("specify a destination for the bugreport file")),
+		OPT_STRING('s', "suffix", &option_suffix, N_("format"),
+			   N_("specify a strftime format suffix for the filename")),
+		OPT_END()
+	};
+	argc = parse_options(argc, argv, "", bugreport_options,
+			     bugreport_usage, 0);
+
+	if (option_output) {
+		strbuf_addstr(&report_path, option_output);
+		strbuf_complete(&report_path, '/');
+	}
+
+
+	strbuf_addstr(&report_path, "git-bugreport-");
+	strbuf_addftime(&report_path, option_suffix, localtime(&now), 0, 0);
+	strbuf_addstr(&report_path, ".txt");
+
+	if (!stat(report_path.buf, &statbuf))
+		die("'%s' already exists", report_path.buf);
+
+	get_bug_template(&buffer);
+
+	report = fopen_for_writing(report_path.buf);
+
+	if (report == NULL) {
+		strbuf_release(&report_path);
+		die("couldn't open '%s' for writing", report_path.buf);
+	}
+
+	strbuf_write(&buffer, report);
+	fclose(report);
+
+	fprintf(stderr, _("Created new report at '%s'.\n"), report_path.buf);
+
+	UNLEAK(buffer);
+	UNLEAK(report_path);
+	return -launch_editor(report_path.buf, NULL, NULL);
+}
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
new file mode 100755
index 0000000000..451badff0c
--- /dev/null
+++ b/t/t0091-bugreport.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+
+test_description='git bugreport'
+
+. ./test-lib.sh
+
+# Headers "[System Info]" will be followed by a non-empty line if we put some
+# information there; we can make sure all our headers were followed by some
+# information to check if the command was successful.
+HEADER_PATTERN="^\[.*\]$"
+check_all_headers_populated() {
+	while read -r line; do
+		if test "$(grep "$HEADER_PATTERN" "$line")"; then
+			echo "$line"
+			read -r nextline
+			if test -z "$nextline"; then
+				return 1;
+			fi
+		fi
+	done
+}
+
+test_expect_success 'creates a report with content in the right places' '
+	git bugreport &&
+	REPORT="$(ls git-bugreport-*)" &&
+	check_all_headers_populated <$REPORT &&
+	rm $REPORT
+'
+
+test_expect_success 'dies if file with same name as report already exists' '
+	touch git-bugreport-duplicate.txt &&
+	test_must_fail git bugreport --suffix duplicate &&
+	rm git-bugreport-duplicate.txt
+'
+
+test_expect_success '--output-directory puts the report in the provided dir' '
+	mkdir foo/ &&
+	git bugreport -o foo/ &&
+	test_path_is_file foo/git-bugreport-* &&
+	rm -fr foo/
+'
+
+test_expect_success 'incorrect arguments abort with usage' '
+	test_must_fail git bugreport --false 2>output &&
+	grep usage output &&
+	test_path_is_missing git-bugreport-*
+'
+
+test_done
-- 
2.25.0.341.g760bfbb309-goog

