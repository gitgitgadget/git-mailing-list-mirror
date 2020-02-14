Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E43C3B18F
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAAD20848
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ouLE294c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgBNByA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 20:54:00 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:51442 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbgBNBx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 20:53:59 -0500
Received: by mail-pj1-f73.google.com with SMTP id z5so4774366pjt.1
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 17:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yx7G+XXlQ+ditWfSOivUnzKInA16uK7KS/3Amg6vdTM=;
        b=ouLE294cVJnMARew+0VgmrMXoCeEknH2H9y6d+LRGLmCu3iUAOAz8+8HjoRJ5ib/4T
         z0973FjU55N+MH/a2VfcL3E7BXDULtxJQOk6ygoLzquX9ADH0tq16RemSfPdhosq3kw8
         XUlg+WVFfkDcAlOjGQPnvLxawaXMyL0n7GvmZHqLDmGuRUw2Mgx1I6Q5bwMJcln6uVhT
         G1mif2T3CszXqokplB0Jy4oIDhw5qUC+A+XUizMHXBvKDsLy4hVFY3S9TaZTQjmIL26u
         R94HZwYX4q58llLRk1mKu/CnEqw4duTlFGne6MpW0KC3TG5Soc2zqNoexsRwLROL8p6t
         peDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yx7G+XXlQ+ditWfSOivUnzKInA16uK7KS/3Amg6vdTM=;
        b=TQi+PDoNJDTa/UmlEzBhranr4Db7OAMTiCaq1qN/ECobDZ8NnuaXUg9aS54jDuex8Y
         fYrmAXxc9I5uxqPDRa0RKBMmHe0W3S1Oy79ZFZZ8xUiVplzXw5xqzw9yRRVEUcsAED7Z
         tdwjk5crg/9s2zs8PdQ6nzsN0rAAx22k5+7AUsSUCULjaNuAf8+5OqoZuedQ/6QOlSL3
         lm0Pi/AF5vr//xcAtPaBanL+wida/q7cgEsRGcSf49WiO6+Rk7AsKKoaUdAb8GQbKFmE
         6qvBNUDSwouRW3MBF/5+cO1uWuJFxhH8hPaZ/OsIvGM8/uGHV9ZHQ2BbacT1tsTlCqFY
         fTsA==
X-Gm-Message-State: APjAAAWiEpw3nWWZfNkUYiQcx4nc5ZBT6mAXeG5ckHeIE5FWHatsx/2k
        rn6eyUf/bh9VbLoEGivmOGx7rxJTgGhhM0R47mLs1qCi/SYO9rGXZq7P316mO4bSN0tkzHHs9cL
        6iYFxbeXaMn811Iyz2SugIJNxWSmI0mp5NtvhAEImk9RNr5hffpqeUYLORLmJcObDH4K4wmNj0g
        ==
X-Google-Smtp-Source: APXvYqxSsx7AuPhBNj/+GapxPjJcJScoAxhwfNezbJ69k1kS7pCr+3qmvtpZ/A2MK2YRPbfyQR1z2fwacmAliPj5hc4=
X-Received: by 2002:a63:f648:: with SMTP id u8mr918413pgj.148.1581645238731;
 Thu, 13 Feb 2020 17:53:58 -0800 (PST)
Date:   Thu, 13 Feb 2020 17:53:31 -0800
In-Reply-To: <20200214015343.201946-1-emilyshaffer@google.com>
Message-Id: <20200214015343.201946-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200214015343.201946-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v7 03/15] bugreport: add tool to generate debugging info
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
 Documentation/git-bugreport.txt | 41 ++++++++++++++
 Makefile                        |  5 ++
 bugreport.c                     | 94 +++++++++++++++++++++++++++++++++
 command-list.txt                |  1 +
 t/t0091-bugreport.sh            | 55 +++++++++++++++++++
 6 files changed, 197 insertions(+)
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
index 0000000000..a9398e6a2a
--- /dev/null
+++ b/bugreport.c
@@ -0,0 +1,94 @@
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
+	switch (safe_create_leading_directories(report_path.buf)) {
+	case SCLD_OK:
+	case SCLD_EXISTS:
+		break;
+	default:
+		die(_("could not create leading directories for '%s'"),
+		    report_path.buf);
+	}
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
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
new file mode 100755
index 0000000000..6585a2d144
--- /dev/null
+++ b/t/t0091-bugreport.sh
@@ -0,0 +1,55 @@
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
+test_done
-- 
2.25.0.265.gbab2e86ba0-goog

