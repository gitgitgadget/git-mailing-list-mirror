Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40200C10DCE
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 21:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A27F20719
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 21:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q4md4hS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgCWVnz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:43:55 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:41267 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgCWVny (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 17:43:54 -0400
Received: by mail-pl1-f202.google.com with SMTP id m9so10505392plt.8
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 14:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=a1gHsKgesXvZ6on9jZutni1fYrs6iLWNRYX08oB8HKA=;
        b=Q4md4hS1BaCvtzF6pCjkPcvF0vb/R48PTzvAX3AC30yB9ghif2Cs6pI7waGmeQ/f1D
         XcuQI3zSndjlzOJRqXnnidHpCFPVy43ofOkQVOG0r4KbstwJfioYCaUTtVcW3mjQWZyz
         Q4sYT8Vuf73W/wdoY1PtVLf8Ovdsz3pp6ADm2nq/8/nWzZnWu29DxJHN7Z33Ext1kMFd
         bToF3YeiIwHMti093KXpzqAIHfLdBP3tBtRO/s2UxZy0LGuPQd22tBy4Y/gRwLxBPnLH
         +DMqG/Y+xGnWe1R2qBBcp8+maELXmftem0o/y4HU44YVUzxjnFBoyVm/WY01KXzre1oU
         PjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=a1gHsKgesXvZ6on9jZutni1fYrs6iLWNRYX08oB8HKA=;
        b=NtQf/ycN7PYlIHomP6Xkvdc/c9O+FaHfHrVblpXqhopqeCKTjgUtEuJ3X9wSeHusBt
         11uEsT0DqynDr0HNjpSSErJXvd4IDK2jgtaGPXVOfYSHRRYx89OrBeNlJeT6MV4LAk3A
         mdeNkZpayCcUljgQXFpXX7i7qpxXxvKuSyPuDNzCVAWTHZv3LIDV82Le9PNZlQQVDeEc
         RzRwBUXoAUX3inloPh7R1UuwXuug3PCcKr20fqahyWNqn4/Ji1xMpFFJPuu44TxJoZ6X
         t1qFGV0LHpMZELdXs9ZXR7qNu+loPtMROY+YDAEEUipTD5m7CyVIxMzeSZl70Lt0fKQk
         biJA==
X-Gm-Message-State: ANhLgQ3gX2bY/UfZpn5+TqvAFeUYcEwdVRXjTGaWQkhzn8jHvbkW0fiH
        kBVzocn861xuQrcgQLISWb6rPNxHE1amUoK1n2AxHiDFsAUJgdpxxDYNurw/XDV/sf483Xm+OuV
        ugxT04aHWEXE+uMFz1T6rASg+pvq0xscvQDK4l04AEMsVBHAjsDbrDaQz8zbsVTcFmGHnkhJmOw
        ==
X-Google-Smtp-Source: ADFU+vuaskbQExRg8v+jTTZQA6wUsmcIdTioPk34swXJ5ccDWRG1IQVaXxXNdSjzGoJjdn/cEFlbkyrb7WZAabJR+Hs=
X-Received: by 2002:a65:60d7:: with SMTP id r23mr19753271pgv.321.1584999831878;
 Mon, 23 Mar 2020 14:43:51 -0700 (PDT)
Date:   Mon, 23 Mar 2020 14:43:37 -0700
In-Reply-To: <20200323214340.182724-1-emilyshaffer@google.com>
Message-Id: <20200323214340.182724-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200323214340.182724-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v10 2/5] bugreport: add tool to generate debugging info
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
index c552312d3f..9e6705061d 100644
--- a/Makefile
+++ b/Makefile
@@ -681,6 +681,7 @@ EXTRA_PROGRAMS =
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS += $(EXTRA_PROGRAMS)
 
+PROGRAM_OBJS += bugreport.o
 PROGRAM_OBJS += credential-store.o
 PROGRAM_OBJS += daemon.o
 PROGRAM_OBJS += fast-import.o
@@ -2461,6 +2462,10 @@ endif
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
index f19da55b07..f1d66c7848 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -539,6 +539,10 @@ ssize_t strbuf_write(struct strbuf *sb, FILE *f)
 	return sb->len ? fwrite(sb->buf, 1, sb->len, f) : 0;
 }
 
+ssize_t strbuf_write_fd(struct strbuf *sb, int fd)
+{
+	return sb->len ? write(fd, sb->buf, sb->len) : 0;
+}
 
 #define STRBUF_MAXLINK (2*PATH_MAX)
 
diff --git a/strbuf.h b/strbuf.h
index aae7ac3a82..bbf6204de7 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -462,6 +462,7 @@ int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
  * NUL bytes.
  */
 ssize_t strbuf_write(struct strbuf *sb, FILE *stream);
+ssize_t strbuf_write_fd(struct strbuf *sb, int fd);
 
 /**
  * Read a line from a FILE *, overwriting the existing contents of
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
new file mode 100755
index 0000000000..65f664fdac
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
+	git bugreport -s check-headers &&
+	check_all_headers_populated <git-bugreport-check-headers.txt &&
+	test_when_finished rm git-bugreport-check-headers.txt
+'
+
+test_expect_success 'dies if file with same name as report already exists' '
+	>>git-bugreport-duplicate.txt &&
+	test_must_fail git bugreport --suffix duplicate &&
+	test_when_finished rm git-bugreport-duplicate.txt
+'
+
+test_expect_success '--output-directory puts the report in the provided dir' '
+	git bugreport -o foo/ &&
+	test_path_is_file foo/git-bugreport-* &&
+	test_when_finished rm -fr foo/
+'
+
+test_expect_success 'incorrect arguments abort with usage' '
+	test_must_fail git bugreport --false 2>output &&
+	test_i18ngrep usage output &&
+	test_path_is_missing git-bugreport-*
+'
+
+test_expect_success 'runs outside of a git dir' '
+	nongit git bugreport &&
+	test_when_finished rm non-repo/git-bugreport-*
+'
+
+test_expect_success 'can create leading directories outside of a git dir' '
+	nongit git bugreport -o foo/bar/baz &&
+	test_when_finished rm -fr foo/bar/baz
+'
+
+
+test_done
-- 
2.25.1.696.g5e7596f4ac-goog

