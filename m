Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D6E61F597
	for <e@80x24.org>; Sun, 22 Jul 2018 09:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbeGVKyI (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 06:54:08 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:38844 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbeGVKyI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 06:54:08 -0400
Received: by mail-io0-f196.google.com with SMTP id v26-v6so13251491iog.5
        for <git@vger.kernel.org>; Sun, 22 Jul 2018 02:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mLdL+SDEIP/Q03yZJl3G3Oyd7tkS4p3iirgxmBIZgwE=;
        b=ivfNGRZcqcb2TFbR1Cnvum+TQ74jRReMoKmzeIXLINZShNYfWOcKkZCGSkAon1syQp
         Z1mdh6CM2OnZ9SOVsySr7KtTvnSefpnGq+NHrctdwJONJ3ylJZirxyircGaraSb0nUfx
         VGUAbCnCZXXTZ6lKRFajx0YNAWjyHyK6q+u4EPLXXgXlsK+UKp+cphsMCJPCbAI6hBXr
         57uSE3R1NIknN0BtGT6oDO3yuMuIfTfNHgNpRs/YblWR/vDS7rhmVFHihuJl0h3toXUn
         g9vougpKHaCgC4/qWzCCqcRcBYXlGyvf5T0F2ei3CCLglJJerxYNJ5T2sMvnFJdcirq1
         xFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mLdL+SDEIP/Q03yZJl3G3Oyd7tkS4p3iirgxmBIZgwE=;
        b=kkLhGZx1G7/yLPvm0TlYhpfzMFCbhwFtJEgcY9n2CFxrzLV2q36aaUty7g3El9YbaP
         WiiVdfdZhkfAbzzyxspr/dxAo4rkvZrwcja61YD008ITUtoWUoO7lhOZcteTFTdx1J9I
         TBOMISCmktseDO6rcFq6hPPkKKZ8wpYlU1haQPZpPvcYu5ksNqZPG80Kjf1okL879MHw
         NaOUZKzTXqY11ngDRAvujYHTgqK4IzBRPwGJE2RfLLdZWAIVEAGIk1JjLBSneWWBmr0g
         DI/QoXlCJ2jNOqJ3A0hkAGOwAIjYKqlAbSkUyy1+DRioO6YViDlYce+5iXu3+BB5TCdm
         pF7Q==
X-Gm-Message-State: AOUpUlEgFuMDm++ITR1XPhfbr8vqR98Enq7AmevfKGIFoL60r++JqPgv
        sNNZbqsyM7S9l9noQ1BC9poAeNpx
X-Google-Smtp-Source: AAOMgpco1Bt6w4MZmskatSou6k7oXBJ33ulcFCzWpPDdK09GZP/KQfZ4jZMX+rtdefgkaCWW1+VCTg==
X-Received: by 2002:a6b:2c9:: with SMTP id 192-v6mr7084224ioc.123.1532253478224;
        Sun, 22 Jul 2018 02:57:58 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id w13-v6sm3681298itb.29.2018.07.22.02.57.57
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 02:57:57 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 02/14] format-patch: add --interdiff option to embed diff in cover letter
Date:   Sun, 22 Jul 2018 05:57:05 -0400
Message-Id: <20180722095717.17912-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180722095717.17912-1-sunshine@sunshineco.com>
References: <20180722095717.17912-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When submitting a revised version of a patch series, it can be helpful
(to reviewers) to include a summary of changes since the previous
attempt in the form of an interdiff, however, doing so involves manually
copy/pasting the diff into the cover letter.

Add an --interdiff option to automate this process. The argument to
--interdiff specifies the tip of the previous attempt against which to
generate the interdiff. For example:

    git format-patch --cover-letter --interdiff=v1 -3 v2

The previous attempt and the patch series being formatted must share a
common base.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-format-patch.txt |  9 +++++++++
 Makefile                           |  1 +
 builtin/log.c                      | 24 ++++++++++++++++++++++--
 interdiff.c                        | 17 +++++++++++++++++
 interdiff.h                        |  8 ++++++++
 revision.h                         |  4 ++++
 t/t4014-format-patch.sh            | 17 +++++++++++++++++
 7 files changed, 78 insertions(+), 2 deletions(-)
 create mode 100644 interdiff.c
 create mode 100644 interdiff.h

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index b41e1329a7..a1b1bafee7 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -23,6 +23,7 @@ SYNOPSIS
 		   [(--reroll-count|-v) <n>]
 		   [--to=<email>] [--cc=<email>]
 		   [--[no-]cover-letter] [--quiet] [--notes[=<ref>]]
+		   [--interdiff=<previous>]
 		   [--progress]
 		   [<common diff options>]
 		   [ <since> | <revision range> ]
@@ -228,6 +229,14 @@ feeding the result to `git send-email`.
 	containing the branch description, shortlog and the overall diffstat.  You can
 	fill in a description in the file before sending it out.
 
+--interdiff=<previous>::
+	As a reviewer aid, insert an interdiff into the cover letter showing
+	the differences between the previous version of the patch series and
+	the series currently being formatted. `previous` is a single revision
+	naming the tip of the previous series which shares a common base with
+	the series being formatted (for example `git format-patch
+	--cover-letter --interdiff=feature/v1 -3 feature/v2`).
+
 --notes[=<ref>]::
 	Append the notes (see linkgit:git-notes[1]) for the commit
 	after the three-dash line.
diff --git a/Makefile b/Makefile
index 41b93689ad..2af389c0d9 100644
--- a/Makefile
+++ b/Makefile
@@ -872,6 +872,7 @@ LIB_OBJS += linear-assignment.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
 LIB_OBJS += ident.o
+LIB_OBJS += interdiff.o
 LIB_OBJS += kwset.o
 LIB_OBJS += levenshtein.o
 LIB_OBJS += line-log.o
diff --git a/builtin/log.c b/builtin/log.c
index 873aabcf40..1020b78477 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -30,6 +30,7 @@
 #include "gpg-interface.h"
 #include "progress.h"
 #include "commit-slab.h"
+#include "interdiff.h"
 
 #define MAIL_DEFAULT_WRAP 72
 
@@ -1082,6 +1083,11 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	/* We can only do diffstat with a unique reference point */
 	if (origin)
 		show_diffstat(rev, origin, head);
+
+	if (rev->idiff_oid1) {
+		fprintf_ln(rev->diffopt.file, "%s", _("Interdiff:"));
+		show_interdiff(rev);
+	}
 }
 
 static const char *clean_message_id(const char *msg_id)
@@ -1448,6 +1454,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct base_tree_info bases;
 	int show_progress = 0;
 	struct progress *progress = NULL;
+	struct oid_array idiff_prev = OID_ARRAY_INIT;
 
 	const struct option builtin_format_patch_options[] = {
 		{ OPTION_CALLBACK, 'n', "numbered", &numbered, NULL,
@@ -1521,6 +1528,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
 		OPT_BOOL(0, "progress", &show_progress,
 			 N_("show progress while generating patches")),
+		OPT_CALLBACK(0, "interdiff", &idiff_prev, N_("rev"),
+			     N_("show changes against <rev> in cover letter"),
+			     parse_opt_object_name),
 		OPT_END()
 	};
 
@@ -1706,7 +1716,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		if (rev.pending.nr == 2) {
 			struct object_array_entry *o = rev.pending.objects;
 			if (oidcmp(&o[0].item->oid, &o[1].item->oid) == 0)
-				return 0;
+				goto done;
 		}
 		get_patch_ids(&rev, &ids);
 	}
@@ -1730,7 +1740,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	}
 	if (nr == 0)
 		/* nothing to do */
-		return 0;
+		goto done;
 	total = nr;
 	if (cover_letter == -1) {
 		if (config_cover_letter == COVER_AUTO)
@@ -1743,6 +1753,13 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (numbered)
 		rev.total = total + start_number - 1;
 
+	if (idiff_prev.nr) {
+		if (!cover_letter)
+			die(_("--interdiff requires --cover-letter"));
+		rev.idiff_oid1 = &idiff_prev.oid[idiff_prev.nr - 1];
+		rev.idiff_oid2 = get_commit_tree_oid(list[0]);
+	}
+
 	if (!signature) {
 		; /* --no-signature inhibits all signatures */
 	} else if (signature && signature != git_version_string) {
@@ -1860,6 +1877,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	string_list_clear(&extra_hdr, 0);
 	if (ignore_if_in_upstream)
 		free_patch_ids(&ids);
+
+done:
+	oid_array_clear(&idiff_prev);
 	return 0;
 }
 
diff --git a/interdiff.c b/interdiff.c
new file mode 100644
index 0000000000..d0fac10c7c
--- /dev/null
+++ b/interdiff.c
@@ -0,0 +1,17 @@
+#include "cache.h"
+#include "commit.h"
+#include "revision.h"
+#include "interdiff.h"
+
+void show_interdiff(struct rev_info *rev)
+{
+	struct diff_options opts;
+
+	memcpy(&opts, &rev->diffopt, sizeof(opts));
+	opts.output_format = DIFF_FORMAT_PATCH;
+	diff_setup_done(&opts);
+
+	diff_tree_oid(rev->idiff_oid1, rev->idiff_oid2, "", &opts);
+	diffcore_std(&opts);
+	diff_flush(&opts);
+}
diff --git a/interdiff.h b/interdiff.h
new file mode 100644
index 0000000000..793c0144fe
--- /dev/null
+++ b/interdiff.h
@@ -0,0 +1,8 @@
+#ifndef INTERDIFF_H
+#define INTERDIFF_H
+
+struct rev_info;
+
+void show_interdiff(struct rev_info *);
+
+#endif
diff --git a/revision.h b/revision.h
index bf2239f876..61931fbac5 100644
--- a/revision.h
+++ b/revision.h
@@ -212,6 +212,10 @@ struct rev_info {
 	/* notes-specific options: which refs to show */
 	struct display_notes_opt notes_opt;
 
+	/* interdiff */
+	const struct object_id *idiff_oid1;
+	const struct object_id *idiff_oid2;
+
 	/* commit counts */
 	int count_left;
 	int count_right;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 53880da7bb..57b46322aa 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1717,4 +1717,21 @@ test_expect_success 'format-patch --pretty=mboxrd' '
 	test_cmp expect actual
 '
 
+test_expect_success 'interdiff: setup' '
+	git checkout -b boop master &&
+	test_commit fnorp blorp &&
+	test_commit fleep blorp
+'
+
+test_expect_success 'interdiff: cover-letter' '
+	sed "y/q/ /" >expect <<-\EOF &&
+	+fleep
+	--q
+	EOF
+	git format-patch --cover-letter --interdiff=boop~2 -1 boop &&
+	test_i18ngrep "^Interdiff:$" 0000-cover-letter.patch &&
+	sed "1,/^@@ /d; /^-- $/q" <0000-cover-letter.patch >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.18.0.345.g5c9ce644c3

