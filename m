Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B507C4320A
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CC4A610C8
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbhHYXUq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 19:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbhHYXUl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 19:20:41 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636DAC061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:19:55 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k20-20020a05600c0b5400b002e87ad6956eso942527wmr.1
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zxaDMSqEmyf2OUXmB0ikcRu33GjzQA6kv0DTZEl2Bno=;
        b=WlVRnbsTjEonifiRt1OF7jG/zBkkbWlXF2orIyR1br0GrdknSVq3JSvqAaBftlT2F1
         gDEoh4/3UuTgdt0eOILQoDo0u3bPvVVcweEYOUW8SaL1uRFlOZPQwxKKXX4exTHs1Bp8
         AhI8Gtkdwp1TZxa6MJiXSvoeZfZ15w53kxk05l9CFhdyu/dclvP+hC1Wtb5CTfsA6gan
         ysjbY+F/JW8ZNTl5wlvL9fhbdiS840ZRcafzotNbR/0KZkMvfU5MB2NciuUu9y0DWvAi
         5di5zgLkvxB+dAgpSw8hZsLpy1nzCYq33G2xpjkIPAchUlIx+CjdZ/po4Rqb/r19yLT5
         UkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zxaDMSqEmyf2OUXmB0ikcRu33GjzQA6kv0DTZEl2Bno=;
        b=iAVIFIe7o57tANbrNnjNF3BwwZzWaLdDxz0NsPdmyJe1UwlVIMYBbgiPrl3Q9fc+L+
         KaKUDkqEU8yu3H/7EUtOONgrPzH9T2W2sWVmotS7k8boktde7abXENHWcKLNrwSi18Ym
         RNPOP8Uh+yl056g4AodT0Tae/2qDPNCfoI239ZC2g8Z/C6atwtRAiZfWqq82GbgKuJqq
         o77kbJwNzFpgNk2efOke90pbYAaoPsDxB3v831vqIBuKkjrHLmJYJQrW3MyGoiAZM1RW
         RHDWUhq0wDLLx6zObEI4lLF2MZzjLvxdnWYZh0dj8nldcH04uW1SkvRRETf2+9E8L9ZY
         TIOQ==
X-Gm-Message-State: AOAM531vx2XLLBIO+G5edHLZNkuv3/viv3jXLm0fdIMCIy0ansc9gW/3
        5jcZMe20SY5JXPsWpSJMLWtfb0FE00tVew==
X-Google-Smtp-Source: ABdhPJyFsG6axz1qY6iEKlGH5+RFkpStqMRJovF9R7l40F0fpW85JshojNM7RPw7u+Wbq6rkhZUiaQ==
X-Received: by 2002:a1c:2086:: with SMTP id g128mr771505wmg.46.1629933593598;
        Wed, 25 Aug 2021 16:19:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u23sm6327166wmc.24.2021.08.25.16.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 16:19:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/6] tr2: log N parent process names on Linux
Date:   Thu, 26 Aug 2021 01:19:24 +0200
Message-Id: <patch-6.6-da003330800-20210825T231400Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.733.ga72a4f1c2e1
In-Reply-To: <cover-0.6-00000000000-20210825T231400Z-avarab@gmail.com>
References: <87o8agp29o.fsf@evledraar.gmail.com> <cover-0.6-00000000000-20210825T231400Z-avarab@gmail.com>
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
Linux. In 2f732bf15e6 it was claimed that "further ancestry info can
be gathered with procfs, but it's unwieldy to do so.".

I don't know what the author meant by that, but I think it probably
referred to needing to slurp this up from the FS, as opposed to having
an API. The underlying semantics on Linux are easier to deal with than
on Windows though, at least as far as finding the parent PIDs
goes. See the get_processes() function used on Windows. As shown in
353d3d77f4f (trace2: collect Windows-specific process information,
2019-02-22) it needs to deal with cycles.

What is more complex on Linux is getting at the process name, a
simpler approach is to use fscanf(), see [1] for an implementation of
that, but as noted in the comment being added here it would fail in
the face of some weird process names, so we need our own
parse_proc_stat() to parse it out.

With this patch the "ancestry" chain for a trace2 event might look
like this:

    $ GIT_TRACE2_EVENT=/dev/stdout ~/g/git/git version | grep ancestry | jq -r .ancestry
    [
      "bash",
      "screen",
      "systemd"
    ]

And in the case of naughty process names. This uses perl's ability to
use prctl(PR_SET_NAME, ...). See Perl/perl5@7636ea95c5 (Set the legacy
process name with prctl() on assignment to $0 on Linux, 2010-04-15)[2]:

    $ perl -e '$0 = "(naughty\nname)"; system "GIT_TRACE2_EVENT=/dev/stdout ~/g/git/git version"' | grep ancestry | jq -r .ancestry
    [
      "sh",
      "(naughty\nname)",
      "bash",
      "screen",
      "systemd"
    ]

1. https://lore.kernel.org/git/87o8agp29o.fsf@evledraar.gmail.com/
2. https://github.com/Perl/perl5/commit/7636ea95c57762930accf4358f7c0c2dec086b5e

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 compat/linux/procinfo.c | 134 ++++++++++++++++++++++++++++++++++------
 1 file changed, 116 insertions(+), 18 deletions(-)

diff --git a/compat/linux/procinfo.c b/compat/linux/procinfo.c
index 46a751c9a1d..937084126a6 100644
--- a/compat/linux/procinfo.c
+++ b/compat/linux/procinfo.c
@@ -4,27 +4,129 @@
 #include "strvec.h"
 #include "trace2.h"
 
-static void get_ancestry_names(struct strvec *names)
+/*
+ * We need more complex parsing instat_parent_pid() and
+ * parse_proc_stat() below than a dumb fscanf(). That's because while
+ * the statcomm field is surrounded by parentheses, the process itself
+ * is free to insert any arbitrary byte sequence its its name. That
+ * can include newlines, spaces, closing parentheses etc. See
+ * do_task_stat() in fs/proc/array.c in linux.git, this is in contrast
+ * with the escaped version of the name found in /proc/%d/status.
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
+ * We then have 4 spaces between those four values, which brings us up
+ * to 18. Add the two parentheses and it's 20. The "state" is then one
+ * character (now at 21).
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
+	const char *lhs = strchr(sb->buf, '(');
+	const char *rhs = strrchr(sb->buf, ')');
+	const char *ppid_lhs, *ppid_rhs;
+	char *p;
+	pid_t ppid;
+
+	if (!lhs || !rhs)
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
+	ppid_lhs = rhs + 4;
+
+	ppid_rhs = strchr(ppid_lhs, ' ');
+	if (!ppid_rhs)
+		goto bad_kernel;
+
+	ppid = strtol(ppid_lhs, &p, 10);
+	if (ppid_rhs == p) {
+		const char *comm = lhs + 1;
+		int commlen = rhs - lhs - 1;
+
+		strbuf_addf(name, "%.*s", commlen, comm);
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
+	size_t n;
+	FILE *fp = NULL;
+	int ret = -1;
 
 	/* try to use procfs if it's present. */
-	strbuf_addf(&procfs_path, "/proc/%d/comm", getppid());
-	if (strbuf_read_file(&name, procfs_path.buf, 0) > 0) {
-		strbuf_trim_trailing_newline(&name);
-		strvec_push(names, name.buf);
-		strbuf_release(&name);
-	}
+	strbuf_addf(&procfs_path, "/proc/%d/stat", pid);
+	fp = fopen(procfs_path.buf, "r");
+	if (!fp)
+		goto cleanup;
+
+	n = strbuf_fread(&sb, STAT_PARENT_PID_READ_N, fp);
+	if (n != STAT_PARENT_PID_READ_N)
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
+	strbuf_release(&name);
 	return;
 }
 
@@ -44,11 +146,7 @@ void trace2_collect_process_info(enum trace2_process_info_reason reason)
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

