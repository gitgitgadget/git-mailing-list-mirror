Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8045C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 12:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 926FE61052
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 12:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241082AbhHZMYS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 08:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240725AbhHZMXV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 08:23:21 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F57C061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 05:22:33 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m2so1753840wmm.0
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 05:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=otPC016tsQYbkCsyuHX7/AxStQdIngyghh9r6YMqxjM=;
        b=MfW986LQIedLJGtJZTpM1MLZdrfQMNo2IJ7DNxoBS2t7lA4xJ7+64GjVkRoHgR9YoX
         +dNqIViPxUCGlZ6UclYPyext11eXrLrgb//rxPUyaufvoh1BXiXWVgOXBW3fbX+9+vca
         JEjIGVe0kDI7vzwpeMtG9eBsUnkJhdmsPskQ4Xz+EEzw7Ag6ZKYJo/8nZXYfOyq1m5d9
         aTnvqXYW/EVv/C02uinAUVg4u6amr7xyDMlvR/5vOEHrmHqAhHTvcZIGCLsvtsZXPYGj
         jsOGLgMkl7O6qdJVi+/gj7tKgScQ+nmIY6a2xUNCasr09plB4tw/VpyopdTER1CcQXnn
         uzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=otPC016tsQYbkCsyuHX7/AxStQdIngyghh9r6YMqxjM=;
        b=OZ5PMplcOAOXUwOhI6qCwRl7CFJIuSMvM46sJu5IRpFUIoWn3dWdb232AYfIlVUgoN
         CkvXAASbIJUEaRA5yb8nBQ2KJMGx2E2xgHgoFY/5lFEvXQE5J5ZvzKCJngC8hPO412hg
         42Bk4AnABOPTa6VY/ZyW1NqZqqH/H03RZyU+UGlYqRPCm2zNqXrCgpjwoG/HBfdv+hhY
         6pZNvV6+TUhWBqbUTjZFZviPbJfvkbNdUMPfQee1xPJgKtzOUxwJCv9OQeBqbw/SwK4A
         j/QwROoFDyMsMvEP2npc5Kc+Q8B61G2YIrQMENKyQIHDACEoQJkz5UPV+5enwnZ/L+VH
         bQZA==
X-Gm-Message-State: AOAM530fiRx/OUibPS3roT5ehEWlyxyqcyOuDkVmm4Iq40iRWMQ6oiDU
        iAwjp33EQaFr3VW78tR5QsJ4IdMj4Wpp8g==
X-Google-Smtp-Source: ABdhPJwq5K7hOc43kyY5Ank7/d+CyoJOaphIsd2PzOUb+fZlTLTS3dNdj03PKMORM35r/r+jStVeYw==
X-Received: by 2002:a05:600c:35c1:: with SMTP id r1mr3370141wmq.101.1629980551779;
        Thu, 26 Aug 2021 05:22:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z17sm2969885wrr.66.2021.08.26.05.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 05:22:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/6] tr2: log N parent process names on Linux
Date:   Thu, 26 Aug 2021 14:22:24 +0200
Message-Id: <patch-v2-6.6-f6aac902484-20210826T121820Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.733.ga72a4f1c2e1
In-Reply-To: <cover-v2-0.6-00000000000-20210826T121820Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210825T231400Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20210826T121820Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 2f732bf15e6 (tr2: log parent process name, 2021-07-21) we started
logging parent process names, but only logged all parents on Windows.
on Linux only the name of the immediate parent process was logged.

Extend the functionality added there to also log full parent chain on
Linux.

This requires us to lookup "/proc/<getppid()>/stat" instead of
"/proc/<getppid()>/comm". The "comm" file just contains the name of the
process, but the "stat" file has both that information, and the parent
PID of that process, see procfs(5). We parse out the parent PID of our
own parent, and recursively walk the chain of "/proc/*/stat" files all
the way up the chain. A parent PID of 0 indicates the end of the
chain.

It's possible given the semantics of Linux's PID files that we end up
getting an entirely nonsensical chain of processes. It could happen if
e.g. we have a chain of processes like:

    1 (init) => 321 (bash) => 123 (git)

Let's assume that "bash" was started a while ago, and that as shown
the OS has already cycled back to using a lower PID for us than our
parent process. In the time it takes us to start up and get to
trace2_collect_process_info(TRACE2_PROCESS_INFO_STARTUP) our parent
process might exit, and be replaced by an entirely different process!

We'd racily look up our own getppid(), but in the meantime our parent
would exit, and Linux would have cycled all the way back to starting
an entirely unrelated process as PID 321.

If that happens we'll just silently log incorrect data in our ancestry
chain. Luckily we don't need to worry about this except in this
specific cycling scenario, as Linux does not have PID
randomization. It appears it once did through a third-party feature,
but that it was removed around 2006[1]. For anyone worried about this
edge case raising PID_MAX via "/proc/sys/kernel/pid_max" will mitigate
it, but not eliminate it.

One thing we don't need to worry about is getting into an infinite
loop when walking "/proc/*/stat". See 353d3d77f4f (trace2: collect
Windows-specific process information, 2019-02-22) for the related
Windows code that needs to deal with that, and [2] for an explanation
of that edge case.

Aside from potential race conditions it's also a bit painful to
correctly parse the process name out of "/proc/*/stat". A simpler
approach is to use fscanf(), see [3] for an implementation of that,
but as noted in the comment being added here it would fail in the face
of some weird process names, so we need our own parse_proc_stat() to
parse it out.

With this patch the "ancestry" chain for a trace2 event might look
like this:

    $ GIT_TRACE2_EVENT=/dev/stdout ~/g/git/git version | grep ancestry | jq -r .ancestry
    [
      "bash",
      "screen",
      "systemd"
    ]

And in the case of naughty process names like the following. This uses
perl's ability to use prctl(PR_SET_NAME, ...). See
Perl/perl5@7636ea95c5 (Set the legacy process name with prctl() on
assignment to $0 on Linux, 2010-04-15)[4]:

    $ perl -e '$0 = "(naughty\nname)"; system "GIT_TRACE2_EVENT=/dev/stdout ~/g/git/git version"' | grep ancestry | jq -r .ancestry
    [
      "sh",
      "(naughty\nname)",
      "bash",
      "screen",
      "systemd"
    ]

1. https://grsecurity.net/news#grsec2110
2. https://lore.kernel.org/git/48a62d5e-28e2-7103-a5bb-5db7e197a4b9@jeffhostetler.com/
3. https://lore.kernel.org/git/87o8agp29o.fsf@evledraar.gmail.com/
4. https://github.com/Perl/perl5/commit/7636ea95c57762930accf4358f7c0c2dec086b5e

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 compat/linux/procinfo.c | 149 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 132 insertions(+), 17 deletions(-)

diff --git a/compat/linux/procinfo.c b/compat/linux/procinfo.c
index 0b47d44990c..bc2f9382a17 100644
--- a/compat/linux/procinfo.c
+++ b/compat/linux/procinfo.c
@@ -4,26 +4,145 @@
 #include "strvec.h"
 #include "trace2.h"
 
-static void get_ancestry_names(struct strvec *names)
+/*
+ * We need more complex parsing in stat_parent_pid() and
+ * parse_proc_stat() below than a dumb fscanf(). That's because while
+ * the statcomm field is surrounded by parentheses, the process itself
+ * is free to insert any arbitrary byte sequence its its name. That
+ * can include newlines, spaces, closing parentheses etc.
+ *
+ * See do_task_stat() in fs/proc/array.c in linux.git, this is in
+ * contrast with the escaped version of the name found in
+ * /proc/%d/status.
+ *
+ * So instead of using fscanf() we'll read N bytes from it, look for
+ * the first "(", and then the last ")", anything in-between is our
+ * process name.
+ *
+ * How much N do we need? On Linux /proc/sys/kernel/pid_max is 2^15 by
+ * default, but it can be raised set to values of up to 2^22. So
+ * that's 7 digits for a PID. We have 2 PIDs in the first four fields
+ * we're interested in, so 2 * 7 = 14.
+ *
+ * We then have 3 spaces between those four values, and we'd like to
+ * get to the space between the 4th and the 5th (the "pgrp" field) to
+ * make sure we read the entire "ppid" field. So that brings us up to
+ * 14 + 3 + 1 = 18. Add the two parentheses around the "comm" value
+ * and it's 20. The "state" value itself is then one character (now at
+ * 21).
+ *
+ * Finally the maximum length of the "comm" name itself is 15
+ * characters, e.g. a setting of "123456789abcdefg" will be truncated
+ * to "123456789abcdef". See PR_SET_NAME in prctl(2). So all in all
+ * we'd need to read 21 + 15 = 36 bytes.
+ *
+ * Let's just read 2^6 (64) instead for good measure. If PID_MAX ever
+ * grows past 2^22 we'll be future-proof. We'll then anchor at the
+ * last ")" we find to locate the parent PID.
+ */
+#define STAT_PARENT_PID_READ_N 64
+
+static int parse_proc_stat(struct strbuf *sb, struct strbuf *name,
+			    int *statppid)
 {
+	const char *comm_lhs = strchr(sb->buf, '(');
+	const char *comm_rhs = strrchr(sb->buf, ')');
+	const char *ppid_lhs, *ppid_rhs;
+	char *p;
+	pid_t ppid;
+
+	if (!comm_lhs || !comm_rhs)
+		goto bad_kernel;
+
 	/*
-	 * NEEDSWORK: We could gather the entire pstree into an array to match
-	 * functionality with compat/win32/trace2_win32_process_info.c.
-	 * To do so, we may want to examine /proc/<pid>/stat. For now, just
-	 * gather the immediate parent name which is readily accessible from
-	 * /proc/$(getppid())/comm.
+	 * We're at the ")", that's followed by " X ", where X is a
+	 * single "state" character. So advance by 4 bytes.
 	 */
+	ppid_lhs = comm_rhs + 4;
+
+	/*
+	 * Read until the space between the "ppid" and "pgrp" fields
+	 * to make sure we're anchored after the untruncated "ppid"
+	 * field..
+	 */
+	ppid_rhs = strchr(ppid_lhs, ' ');
+	if (!ppid_rhs)
+		goto bad_kernel;
+
+	ppid = strtol(ppid_lhs, &p, 10);
+	if (ppid_rhs == p) {
+		const char *comm = comm_lhs + 1;
+		size_t commlen = comm_rhs - comm;
+
+		strbuf_add(name, comm, commlen);
+		*statppid = ppid;
+
+		return 0;
+	}
+
+bad_kernel:
+	/*
+	 * We were able to read our STAT_PARENT_PID_READ_N bytes from
+	 * /proc/%d/stat, but the content is bad. Broken kernel?
+	 * Should not happen, but handle it gracefully.
+	 */
+	return -1;
+}
+
+static int stat_parent_pid(pid_t pid, struct strbuf *name, int *statppid)
+{
 	struct strbuf procfs_path = STRBUF_INIT;
-	struct strbuf name = STRBUF_INIT;
+	struct strbuf sb = STRBUF_INIT;
+	FILE *fp;
+	int ret = -1;
 
 	/* try to use procfs if it's present. */
-	strbuf_addf(&procfs_path, "/proc/%d/comm", getppid());
-	if (strbuf_read_file(&name, procfs_path.buf, 0) > 0) {
-		strbuf_trim_trailing_newline(&name);
-		strvec_push(names, name.buf);
-	}
+	strbuf_addf(&procfs_path, "/proc/%d/stat", pid);
+	fp = fopen(procfs_path.buf, "r");
+	if (!fp)
+		goto cleanup;
+
+	/*
+	 * We could be more strict here and assert that we read at
+	 * least STAT_PARENT_PID_READ_N. My reading of procfs(5) is
+	 * that on any modern kernel (at least since 2.6.0 released in
+	 * 2003) even if all the mandatory numeric fields were zero'd
+	 * out we'd get at least 100 bytes, but let's just check that
+	 * we got anything at all and trust the parse_proc_stat()
+	 * function to handle its "Bad Kernel?" error checking.
+	 */
+	if (!strbuf_fread(&sb, STAT_PARENT_PID_READ_N, fp))
+		goto cleanup;
+	if (parse_proc_stat(&sb, name, statppid) < 0)
+		goto cleanup;
 
+	ret = 0;
+cleanup:
+	if (fp)
+		fclose(fp);
 	strbuf_release(&procfs_path);
+	strbuf_release(&sb);
+
+	return ret;
+}
+
+static void push_ancestry_name(struct strvec *names, pid_t pid)
+{
+	struct strbuf name = STRBUF_INIT;
+	int ppid;
+
+	if (stat_parent_pid(pid, &name, &ppid) < 0)
+		goto cleanup;
+
+	strvec_push(names, name.buf);
+
+	/*
+	 * Both errors and reaching the end of the process chain are
+	 * reported as fields of 0 by proc(5)
+	 */
+	if (ppid)
+		push_ancestry_name(names, ppid);
+cleanup:
 	strbuf_release(&name);
 
 	return;
@@ -45,11 +164,7 @@ void trace2_collect_process_info(enum trace2_process_info_reason reason)
 		 */
 		break;
 	case TRACE2_PROCESS_INFO_STARTUP:
-		/*
-		 * NEEDSWORK: we could do the entire ptree in an array instead,
-		 * see compat/win32/trace2_win32_process_info.c.
-		 */
-		get_ancestry_names(&names);
+		push_ancestry_name(&names, getppid());
 
 		if (names.nr)
 			trace2_cmd_ancestry(names.v);
-- 
2.33.0.733.ga72a4f1c2e1

