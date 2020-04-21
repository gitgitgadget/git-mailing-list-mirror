Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBC2C54FCB
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 00:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FFD720782
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 00:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="blrkkiG2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgDUANS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 20:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726006AbgDUANS (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 20:13:18 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3BFC061A0E
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 17:13:18 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id z6so4573049plk.10
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 17:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pB2RyomEmPJoEuiEonsk78mNtKwmAiBdh4vfO5My6gM=;
        b=blrkkiG2WwtvX5qEyzepAzc1oWoiEmBDebjVkVb2ZY4bLXLSwUuipgO/qE6NG58F1Q
         9KaPzHkZ3pDWiZkDgx3eLgFJrZMGXkY6azs3ZgEwkZzAEf0Kt3CCqlPKiPl12PEVfBLg
         GYWjF9vaJuTz8rd3bnFZpBcpAMpZJP2q7y15RlSdHDDwvwoCJwY3nu59xzq1gz399VE8
         JKCHpctSynm2ikqbeAlh1eE4cEESzgwUaNU0ID5Z0503A3Fy9S8AcLcRsl/vQjX46/s+
         1oBn8bOy3rF2MPSg0kA2e9prJ37aN48/pmsiiUMm1V3ksuk0Bug0wlFd0Cz3snkjT7EC
         zCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pB2RyomEmPJoEuiEonsk78mNtKwmAiBdh4vfO5My6gM=;
        b=elvDhicJdDctQGqYa/Bka6u259KG5DT3O2QqpUBaxvEEhldkf+3kyzulHzDNmqOJ4J
         jebS8K4SFRrPBMCHYHPJxknTmIqH5A3c0yUhJtYR6I/RUIVu5pSvD0hN0/Q+sVm61arQ
         WAmubMlxZtr/ntpBv3jba5lIZuH09TCCh1RupYhiovdPAF804ct/ciI5NEPJWihgHmB9
         VkDbL7TCgXQf8m8VQX3Mt1GJCD0F+YV1h6Y86aBlioU1iqiRhgo6hL2ns1UtAiwxUra9
         B5v9L9UgbujuLvZOHOEEAGHOE876p/t/ZdksyWSugtc274szwyoEOK44WPuBksKBuSDm
         QIQg==
X-Gm-Message-State: AGi0PubVvQBT9NJe3ph6Sdtvz4T+U/8FoWqguxW3yV3cHyJpWAu8+GjV
        NAcbKcF7zMtlDDqU6U5pARRraA==
X-Google-Smtp-Source: APiQypIF/nPle9kmuSce8/lHHm7Fqc+m/XsKUHSosgw3n1Fsx7Jehzg/svWk5FvfaTQxJZv/EmnA6w==
X-Received: by 2002:a17:90b:3851:: with SMTP id nl17mr2387247pjb.45.1587427997673;
        Mon, 20 Apr 2020 17:13:17 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id t188sm525721pgc.3.2020.04.20.17.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 17:13:16 -0700 (PDT)
Date:   Mon, 20 Apr 2020 18:13:15 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, vd@FreeBSD.org
Subject: Re: [PATCH] diff-tree.c: load notes machinery when required
Message-ID: <20200421001315.GA32669@syl.local>
References: <ce1ba0641e37ac84a104cd44af63e759324feb14.1586997354.git.me@ttaylorr.com>
 <20200416045630.GA21547@coredump.intra.peff.net>
 <20200421000531.GA31800@syl.local>
 <20200421000619.GB2879931@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200421000619.GB2879931@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 20, 2020 at 08:06:19PM -0400, Jeff King wrote:
> On Mon, Apr 20, 2020 at 06:05:31PM -0600, Taylor Blau wrote:
>
> > Here is an updated version of the patch that should be ready for
> > queuing.
> >
> > -- 8< --
> >
> > Subject: [PATCH] tempfile.c: introduce 'create_tempfile_mode'
>
> Er, right patch?

Ugh, how embarrassing. See below:

-- >8 --

Subject: [PATCH] diff-tree.c: load notes machinery when required

Since its introduction in 7249e91 (revision.c: support --notes
command-line option, 2011-03-29), combining '--notes' with any option
that causes us to format notes (e.g., '--pretty', '--format="%N"', etc)
results in a failed assertion at runtime.

  $ git rev-list HEAD | git diff-tree --stdin --pretty=medium --notes
  commit 8f3d9f354286745c751374f5f1fcafee6b3f3136
  git: notes.c:1308: format_display_notes: Assertion `display_notes_trees' failed.
  Aborted

This failure is due to diff-tree not calling 'load_display_notes' to
initialize the notes machinery.

Ordinarily, this failure isn't triggered, because it requires passing
both '--notes' and another of the above mentioned options. In the case
of '--pretty', for example, we set 'opt->verbose_header', causing
'show_log()' to eventually call 'format_display_notes()', which expects
a non-NULL 'display_note_trees'.

Without initializing the notes machinery, 'display_note_trees' remains
NULL, and thus triggers an assertion failure.

Fix this by initializing the notes machinery after parsing our options,
and harden this behavior against regression with a test in t4013. (Note
that the added ref in this test requires updating two unrelated tests
which use 'log --all', and thus need to learn about the new refs).

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/diff-tree.c                          |  9 +++++++++
 t/t4013-diff-various.sh                      | 12 ++++++++++++
 t/t4013/diff.diff-tree_--format=%N_note      |  6 ++++++
 t/t4013/diff.diff-tree_--pretty_--notes_note | 12 ++++++++++++
 t/t4013/diff.diff-tree_--pretty_note         |  9 +++++++++
 t/t4013/diff.log_--decorate=full_--all       | 15 +++++++++++++++
 t/t4013/diff.log_--decorate_--all            | 15 +++++++++++++++
 7 files changed, 78 insertions(+)
 create mode 100644 t/t4013/diff.diff-tree_--format=%N_note
 create mode 100644 t/t4013/diff.diff-tree_--pretty_--notes_note
 create mode 100644 t/t4013/diff.diff-tree_--pretty_note

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index cb9ea79367..802363d0a2 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -109,6 +109,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	struct object *tree1, *tree2;
 	static struct rev_info *opt = &log_tree_opt;
 	struct setup_revision_opt s_r_opt;
+	struct userformat_want w;
 	int read_stdin = 0;

 	if (argc == 2 && !strcmp(argv[1], "-h"))
@@ -127,6 +128,14 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	precompose_argv(argc, argv);
 	argc = setup_revisions(argc, argv, opt, &s_r_opt);

+	memset(&w, 0, sizeof(w));
+	userformat_find_requirements(NULL, &w);
+
+	if (!opt->show_notes_given && w.notes)
+		opt->show_notes = 1;
+	if (opt->show_notes)
+		load_display_notes(&opt->notes_opt);
+
 	while (--argc > 0) {
 		const char *arg = *++argv;

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index dde3f11fec..3f60f7d96c 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -95,6 +95,15 @@ test_expect_success setup '
 	git commit -m "update mode" &&
 	git checkout -f master &&

+	GIT_AUTHOR_DATE="2006-06-26 00:06:00 +0000" &&
+	GIT_COMMITTER_DATE="2006-06-26 00:06:00 +0000" &&
+	export GIT_AUTHOR_DATE GIT_COMMITTER_DATE &&
+	git checkout -b note initial &&
+	git update-index --chmod=+x file2 &&
+	git commit -m "update mode (file2)" &&
+	git notes add -m "note" &&
+	git checkout -f master &&
+
 	# Same merge as master, but with parents reversed. Hide it in a
 	# pseudo-ref to avoid impacting tests with --all.
 	commit=$(echo reverse |
@@ -398,6 +407,9 @@ diff --no-index --raw --no-abbrev dir2 dir

 diff-tree --pretty --root --stat --compact-summary initial
 diff-tree --pretty -R --root --stat --compact-summary initial
+diff-tree --pretty note
+diff-tree --pretty --notes note
+diff-tree --format=%N note
 diff-tree --stat --compact-summary initial mode
 diff-tree -R --stat --compact-summary initial mode
 EOF
diff --git a/t/t4013/diff.diff-tree_--format=%N_note b/t/t4013/diff.diff-tree_--format=%N_note
new file mode 100644
index 0000000000..93042ed539
--- /dev/null
+++ b/t/t4013/diff.diff-tree_--format=%N_note
@@ -0,0 +1,6 @@
+$ git diff-tree --format=%N note
+note
+
+
+:100644 100755 01e79c32a8c99c557f0757da7cb6d65b3414466d 01e79c32a8c99c557f0757da7cb6d65b3414466d M	file2
+$
diff --git a/t/t4013/diff.diff-tree_--pretty_--notes_note b/t/t4013/diff.diff-tree_--pretty_--notes_note
new file mode 100644
index 0000000000..4d0bde601c
--- /dev/null
+++ b/t/t4013/diff.diff-tree_--pretty_--notes_note
@@ -0,0 +1,12 @@
+$ git diff-tree --pretty --notes note
+commit a6f364368ca320bc5a92e18912e16fa6b3dff598
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    update mode (file2)
+
+Notes:
+    note
+
+:100644 100755 01e79c32a8c99c557f0757da7cb6d65b3414466d 01e79c32a8c99c557f0757da7cb6d65b3414466d M	file2
+$
diff --git a/t/t4013/diff.diff-tree_--pretty_note b/t/t4013/diff.diff-tree_--pretty_note
new file mode 100644
index 0000000000..1fa5967083
--- /dev/null
+++ b/t/t4013/diff.diff-tree_--pretty_note
@@ -0,0 +1,9 @@
+$ git diff-tree --pretty note
+commit a6f364368ca320bc5a92e18912e16fa6b3dff598
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    update mode (file2)
+
+:100644 100755 01e79c32a8c99c557f0757da7cb6d65b3414466d 01e79c32a8c99c557f0757da7cb6d65b3414466d M	file2
+$
diff --git a/t/t4013/diff.log_--decorate=full_--all b/t/t4013/diff.log_--decorate=full_--all
index 2afe91f116..3f9b872ece 100644
--- a/t/t4013/diff.log_--decorate=full_--all
+++ b/t/t4013/diff.log_--decorate=full_--all
@@ -5,12 +5,27 @@ Date:   Mon Jun 26 00:06:00 2006 +0000

     update mode

+commit a6f364368ca320bc5a92e18912e16fa6b3dff598 (refs/heads/note)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    update mode (file2)
+
+Notes:
+    note
+
 commit cd4e72fd96faed3f0ba949dc42967430374e2290 (refs/heads/rearrange)
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:06:00 2006 +0000

     Rearranged lines in dir/sub

+commit cbacedd14cb8b89255a2c02b59e77a2e9a8021a0 (refs/notes/commits)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    Notes added by 'git notes add'
+
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> refs/heads/master)
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--decorate_--all b/t/t4013/diff.log_--decorate_--all
index d0f308ab2b..f5e20e1e14 100644
--- a/t/t4013/diff.log_--decorate_--all
+++ b/t/t4013/diff.log_--decorate_--all
@@ -5,12 +5,27 @@ Date:   Mon Jun 26 00:06:00 2006 +0000

     update mode

+commit a6f364368ca320bc5a92e18912e16fa6b3dff598 (note)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    update mode (file2)
+
+Notes:
+    note
+
 commit cd4e72fd96faed3f0ba949dc42967430374e2290 (rearrange)
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:06:00 2006 +0000

     Rearranged lines in dir/sub

+commit cbacedd14cb8b89255a2c02b59e77a2e9a8021a0 (refs/notes/commits)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    Notes added by 'git notes add'
+
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> master)
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
--
2.26.2.108.g048abe1751

