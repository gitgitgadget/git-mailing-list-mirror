Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1F9C2D0CB
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D7921655
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NU0VoiKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731692AbfLMAna (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:43:30 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:41603 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731591AbfLMAn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 19:43:28 -0500
Received: by mail-pj1-f74.google.com with SMTP id ie20so416460pjb.8
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 16:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=K6Ks5A+bdUKeqOTIznyPV9G4BxhJ0Il65kR6FoJbgq8=;
        b=NU0VoiKy+VtveadbBtWj/1AFF9ebpWCO6bpz9yGxiA/PWLTeXXDL7b7/sBiYCsP4Ei
         U1wv3BGa8Kn2f+wYgkwseI+z5/y/C37VgBI0Wjh3i12kPtL35+7ng3joNOo8UYfEg/GS
         ASwO7y7X6tY1P11H5IZ/9JlUWE806YLhGHz9sGADxs+qsXzAMEtNwskMws96TscykP7X
         XOJy7JNpmcGtdSzqG7NQvwvxIPix+OJzIoxjTAruuTgSLIQK2+dLrVjETKGJtSrsiyfO
         vPsKnk70iJr9tdXNJrJks2/ZX+Tv1EvkSBEHUtcWJD0aFZvDwQw4Ud0EgYtDZWS4GSoB
         8PTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K6Ks5A+bdUKeqOTIznyPV9G4BxhJ0Il65kR6FoJbgq8=;
        b=YENMX5lr8+biii1v+UjcmLCotr3LQ2PfdpACVSLo2Z8RiSES0NOsXsGa+nWHQKB8CH
         VIfPKOo7LD11IqGR6lYSS+gmO2Dm757y3uOAevD8qH9Ofn+TLmViOQfVPQeJfNiMRHt2
         H/C8ZSclAhKBuuewk8V/kYATe9Pdc0chtxJsIf9P5JvZaZJS4he857B7CklzWBqW1I8R
         btHB/gZeU47GMpN8xCBFPJn4NAMxC3OlmDuUhS12AViP78MSCuAYFwj6JzW4nq9t/oMR
         t/PK/z1beuObRSwIbCfp4dd6nPpAkgzhgfDZTEpQYcYEgS7ubMSkt1B/DqUVzxXnyuBt
         zuvQ==
X-Gm-Message-State: APjAAAVDZzzmWnQUPK7KW6zJ+Vszob/Rt67wXs4PKiPL0Uvc8oHzwv/H
        0zHo2KlqppOb4uGhXYcQiHdS2wU0RlDNxB7CbhADqsGaCdpRHTDS68YlsEMwLhqfoIhkb88ZCr9
        A2j3xDhXaA7CW4LL+R93lQ6XKxbRf70AK6MOnHE6Ew0qv+zCsWU6fj9QesRFI7QZiCuJn3Fj4Dw
        ==
X-Google-Smtp-Source: APXvYqx8hrPzjZFM9gpY454ZypzB30NT9NkU2eQbHP7DNgd6WftTBcijgUL/RfMUU/1u5EByVWvLswf1yzS1tpbQEaQ=
X-Received: by 2002:a63:5818:: with SMTP id m24mr13884993pgb.358.1576197807384;
 Thu, 12 Dec 2019 16:43:27 -0800 (PST)
Date:   Thu, 12 Dec 2019 16:42:58 -0800
In-Reply-To: <20191213004312.169753-1-emilyshaffer@google.com>
Message-Id: <20191213004312.169753-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191213004312.169753-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v4 01/15] bugreport: add tool to generate debugging info
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
 Documentation/git-bugreport.txt | 43 ++++++++++++++++++++
 Makefile                        |  5 +++
 bugreport.c                     | 69 +++++++++++++++++++++++++++++++++
 t/t0091-bugreport.sh            | 41 ++++++++++++++++++++
 5 files changed, 159 insertions(+)
 create mode 100644 Documentation/git-bugreport.txt
 create mode 100644 bugreport.c
 create mode 100755 t/t0091-bugreport.sh

diff --git a/.gitignore b/.gitignore
index 89b3b79c1a..055a84c4a8 100644
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
index 0000000000..75f0c80acf
--- /dev/null
+++ b/Documentation/git-bugreport.txt
@@ -0,0 +1,43 @@
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
+'git bugreport' [-o | --output <path>]
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
+The following information is captured automatically:
+
+ - Git version (`git version --build-options`)
+ - Machine information (`uname -a`)
+ - Versions of various dependencies
+ - Git config contents (`git config --show-origin --list`)
+ - The names of all configured git-hooks in `.git/hooks/`
+
+OPTIONS
+-------
+-o [<path>]::
+--output [<path>]::
+	Place the resulting bug report file in <path> instead of the root of the
+	Git repository.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index b7d7374dac..9dff91436e 100644
--- a/Makefile
+++ b/Makefile
@@ -681,6 +681,7 @@ EXTRA_PROGRAMS =
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS += $(EXTRA_PROGRAMS)
 
+PROGRAM_OBJS += bugreport.o
 PROGRAM_OBJS += credential-store.o
 PROGRAM_OBJS += daemon.o
 PROGRAM_OBJS += fast-import.o
@@ -2448,6 +2449,10 @@ endif
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
index 0000000000..5495b31674
--- /dev/null
+++ b/bugreport.c
@@ -0,0 +1,69 @@
+#include "builtin.h"
+#include "parse-options.h"
+#include "stdio.h"
+#include "strbuf.h"
+#include "time.h"
+
+static const char * const bugreport_usage[] = {
+	N_("git bugreport [-o|--output <file>]"),
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
+"You can delete any lines you don't wish to send.\n");
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
+
+	const struct option bugreport_options[] = {
+		OPT_STRING('o', "output", &option_output, N_("path"),
+			   N_("specify a destination for the bugreport file")),
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
+	strbuf_addstr(&report_path, "git-bugreport-");
+	strbuf_addftime(&report_path, "%F", gmtime(&now), 0, 0);
+	strbuf_addstr(&report_path, ".txt");
+
+
+	get_bug_template(&buffer);
+
+	report = fopen_for_writing(report_path.buf);
+	strbuf_write(&buffer, report);
+	fclose(report);
+
+	launch_editor(report_path.buf, NULL, NULL);
+	return 0;
+}
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
new file mode 100755
index 0000000000..6eb2ee4f66
--- /dev/null
+++ b/t/t0091-bugreport.sh
@@ -0,0 +1,41 @@
+#!/bin/bash
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
+		if [$(grep $HEADER_PATTERN $line)]; then
+			read -r nextline
+			if [-z $nextline]; then
+				return 1;
+			fi
+		fi
+	done
+}
+
+test_expect_success 'creates a report with content in the right places' '
+	git bugreport &&
+	check_all_headers_populated <git-bugreport-* &&
+	rm git-bugreport-*
+'
+
+test_expect_success '--output puts the report in the provided dir' '
+	mkdir foo/ &&
+	git bugreport -o foo/ &&
+	test -f foo/git-bugreport-* &&
+	rm -fr foo/
+'
+
+test_expect_success 'incorrect arguments abort with usage' '
+	test_must_fail git bugreport --false 2>output &&
+	grep usage output &&
+	test ! -f git-bugreport-*
+'
+
+test_done
-- 
2.24.1.735.g03f4e72817-goog

