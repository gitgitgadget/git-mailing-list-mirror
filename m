Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F17C352BE
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 21:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55468221F9
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 21:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MgZC985g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgDPVSY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728720AbgDPVSW (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 17:18:22 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01354C061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 14:18:22 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id h16so4324770pgb.16
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 14:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e8HNoWowZxAZsZnwQqY9TdtqFsIyvnERIuhflByXzR4=;
        b=MgZC985gtEnbJkjk55sKG+xqkxWm1YRHu4KtOsYB0xX/AozKZQLccY7lJSZQ4khSH/
         vAWDefzBpcc3IDCjdWyjqCIycPcgBOojJjTbCzgrK5xYWwxFvAvgXZaXxrSbeN+Knaac
         +zSmeHCMgXcvu7oYFN9910rX1iN5OFRtXlQgTdae/pS9pAHIVLXwyFniwyb25q5q09cG
         mklfcwAANsS7CnwwMOrxXjMqy7vrS1hYlJ8KUeTDNJ0iQnnREgky1KCyIJyOSK5fVBu/
         hVl6XNB4pxS/5mnqju7Dvp543VTWhJjO2zV8N7ZeLGWEK4KxGOHsYwDr/FEEZOMM+yof
         6NbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e8HNoWowZxAZsZnwQqY9TdtqFsIyvnERIuhflByXzR4=;
        b=VQVuXd3JIPW6sppDreVi2bhvMDikUITJzmxB7PKOFDPyW+TVzqZjlEKwDoh3C0DQla
         Tqfzg47j3qxeWQO+rS8Tz5SSC4qu4CgJla1jTF/VHuw88kMqYC5PKJ8zqTJXgmIMchfh
         27CtyC1Hp4aFlS1ySFdZr2yiWqqfiUs4UIX5zDva1jb5o7GESKUsfZf5sW/bUAPfcE+a
         AIAhEv+bhF15Qp4I5eAcRUk6x4ZRO/PCmCzRDt04/NP+pXkaoi1/IbLWEqsumjZtR6YZ
         K7mxNod9gBrAEW+GCdV9NluvvXIGFcS7GiNefx7VPNh3JsFe7lV5JxjxfBXxPJvYOsR4
         wO+A==
X-Gm-Message-State: AGi0PuYnlNz7cEPiDo4/bJrJUCUEVfeguZJBJNjzbUz5yXfQVsUqTRqz
        gsryV37iPJDhVvXpE42EEsNpcm6SalB2amISjtBNQvWWJxQ55f8pZhTPNh+ffIRsD8dqb49Hute
        6tTno+1xrT0fBrAB8dfQzNWXAo2wuR7MxQDFcVW6W8I1skQFGxaNJQpSrhSQ8wAvtPRxMEY7+7w
        ==
X-Google-Smtp-Source: APiQypI+xjBSi34OftkdyVvNFbU6xe2sS8C4ywm9NYTrjiIBOjWRMV9M6wrvd+3kMNAcKRsiY0kyb3y1I59lTEMK1Bs=
X-Received: by 2002:a17:90a:c78b:: with SMTP id gn11mr298954pjb.147.1587071901391;
 Thu, 16 Apr 2020 14:18:21 -0700 (PDT)
Date:   Thu, 16 Apr 2020 14:18:04 -0700
In-Reply-To: <20200416211807.60811-1-emilyshaffer@google.com>
Message-Id: <20200416211807.60811-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200416211807.60811-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v13 2/5] bugreport: add tool to generate debugging info
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
 .gitignore                      |   1 +
 Documentation/git-bugreport.txt |  46 ++++++++++++++
 Makefile                        |   5 ++
 bugreport.c                     | 105 ++++++++++++++++++++++++++++++++
 command-list.txt                |   1 +
 strbuf.c                        |   4 ++
 strbuf.h                        |   1 +
 t/t0091-bugreport.sh            |  61 +++++++++++++++++++
 8 files changed, 224 insertions(+)
 create mode 100644 Documentation/git-bugreport.txt
 create mode 100644 bugreport.c
 create mode 100755 t/t0091-bugreport.sh

diff --git a/.gitignore b/.gitignore
index 61bf5142a9..ee509a2ad2 100644
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
index 0000000000..1f9fde5cde
--- /dev/null
+++ b/Documentation/git-bugreport.txt
@@ -0,0 +1,46 @@
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
+This tool is invoked via the typical Git setup process, which means that in some
+cases, it might not be able to launch - for example, if a relevant config file
+is unreadable. In this kind of scenario, it may be helpful to manually gather
+the kind of information listed above when manually asking for help.
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
index d4aff7f9b5..b0a9073788 100644
--- a/Makefile
+++ b/Makefile
@@ -680,6 +680,7 @@ EXTRA_PROGRAMS =
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS += $(EXTRA_PROGRAMS)
 
+PROGRAM_OBJS += bugreport.o
 PROGRAM_OBJS += credential-store.o
 PROGRAM_OBJS += daemon.o
 PROGRAM_OBJS += fast-import.o
@@ -2462,6 +2463,10 @@ endif
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
index 0000000000..f6f53a5e8e
--- /dev/null
+++ b/bugreport.c
@@ -0,0 +1,105 @@
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
+	strbuf_addstr(template, _(template_text));
+	return 0;
+}
+
+int cmd_main(int argc, const char **argv)
+{
+	struct strbuf buffer = STRBUF_INIT;
+	struct strbuf report_path = STRBUF_INIT;
+	int report = -1;
+	time_t now = time(NULL);
+	char *option_output = NULL;
+	char *option_suffix = "%Y-%m-%d-%H%M";
+	int nongit_ok = 0;
+	const char *prefix = NULL;
+	const char *user_relative_path = NULL;
+
+	const struct option bugreport_options[] = {
+		OPT_STRING('o', "output-directory", &option_output, N_("path"),
+			   N_("specify a destination for the bugreport file")),
+		OPT_STRING('s', "suffix", &option_suffix, N_("format"),
+			   N_("specify a strftime format suffix for the filename")),
+		OPT_END()
+	};
+
+	prefix = setup_git_directory_gently(&nongit_ok);
+
+	argc = parse_options(argc, argv, prefix, bugreport_options,
+			     bugreport_usage, 0);
+
+	/* Prepare the path to put the result */
+	strbuf_addstr(&report_path,
+		      prefix_filename(prefix,
+				      option_output ? option_output : ""));
+	strbuf_complete(&report_path, '/');
+
+	strbuf_addstr(&report_path, "git-bugreport-");
+	strbuf_addftime(&report_path, option_suffix, localtime(&now), 0, 0);
+	strbuf_addstr(&report_path, ".txt");
+
+	switch (safe_create_leading_directories(report_path.buf)) {
+	case SCLD_OK:
+	case SCLD_EXISTS:
+		break;
+	default:
+		die(_("could not create leading directories for '%s'"),
+		    report_path.buf);
+	}
+
+	/* Prepare the report contents */
+	get_bug_template(&buffer);
+
+	/* fopen doesn't offer us an O_EXCL alternative, except with glibc. */
+	report = open(report_path.buf, O_CREAT | O_EXCL | O_WRONLY, 0666);
+
+	if (report < 0) {
+		UNLEAK(report_path);
+		die(_("couldn't create a new file at '%s'"), report_path.buf);
+	}
+
+	strbuf_write_fd(&buffer, report);
+	close(report);
+
+	/*
+	 * We want to print the path relative to the user, but we still need the
+	 * path relative to us to give to the editor.
+	 */
+	if (!(prefix && skip_prefix(report_path.buf, prefix, &user_relative_path)))
+		user_relative_path = report_path.buf;
+	fprintf(stderr, _("Created new report at '%s'.\n"),
+		user_relative_path);
+
+	UNLEAK(buffer);
+	UNLEAK(report_path);
+	return !!launch_editor(report_path.buf, NULL, NULL);
+}
diff --git a/command-list.txt b/command-list.txt
index 2087894655..185e5e3f05 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -54,6 +54,7 @@ git-archive                             mainporcelain
 git-bisect                              mainporcelain           info
 git-blame                               ancillaryinterrogators          complete
 git-branch                              mainporcelain           history
+git-bugreport                           ancillaryinterrogators
 git-bundle                              mainporcelain
 git-cat-file                            plumbinginterrogators
 git-check-attr                          purehelpers
diff --git a/strbuf.c b/strbuf.c
index bb0065ccaf..3bfcaababb 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -554,6 +554,10 @@ ssize_t strbuf_write(struct strbuf *sb, FILE *f)
 	return sb->len ? fwrite(sb->buf, 1, sb->len, f) : 0;
 }
 
+ssize_t strbuf_write_fd(struct strbuf *sb, int fd)
+{
+	return sb->len ? write(fd, sb->buf, sb->len) : 0;
+}
 
 #define STRBUF_MAXLINK (2*PATH_MAX)
 
diff --git a/strbuf.h b/strbuf.h
index ce8e49c0b2..801a3694ec 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -468,6 +468,7 @@ int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
  * NUL bytes.
  */
 ssize_t strbuf_write(struct strbuf *sb, FILE *stream);
+ssize_t strbuf_write_fd(struct strbuf *sb, int fd);
 
 /**
  * Read a line from a FILE *, overwriting the existing contents of
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
new file mode 100755
index 0000000000..2e73658a5c
--- /dev/null
+++ b/t/t0091-bugreport.sh
@@ -0,0 +1,61 @@
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
+
+check_all_headers_populated () {
+	while read -r line
+	do
+		if test "$(grep "$HEADER_PATTERN" "$line")"
+		then
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
+	test_when_finished rm git-bugreport-check-headers.txt &&
+	git bugreport -s check-headers &&
+	check_all_headers_populated <git-bugreport-check-headers.txt
+'
+
+test_expect_success 'dies if file with same name as report already exists' '
+	test_when_finished rm git-bugreport-duplicate.txt &&
+	>>git-bugreport-duplicate.txt &&
+	test_must_fail git bugreport --suffix duplicate
+'
+
+test_expect_success '--output-directory puts the report in the provided dir' '
+	test_when_finished rm -fr foo/ &&
+	git bugreport -o foo/ &&
+	test_path_is_file foo/git-bugreport-*
+'
+
+test_expect_success 'incorrect arguments abort with usage' '
+	test_must_fail git bugreport --false 2>output &&
+	test_i18ngrep usage output &&
+	test_path_is_missing git-bugreport-*
+'
+
+test_expect_success 'runs outside of a git dir' '
+	test_when_finished rm non-repo/git-bugreport-* &&
+	nongit git bugreport
+'
+
+test_expect_success 'can create leading directories outside of a git dir' '
+	test_when_finished rm -fr foo/bar/baz &&
+	nongit git bugreport -o foo/bar/baz
+'
+
+
+test_done
-- 
2.26.1.301.g55bc3eb7cb9-goog

