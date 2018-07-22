Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 180C71F597
	for <e@80x24.org>; Sun, 22 Jul 2018 09:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbeGVKyP (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 06:54:15 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36485 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbeGVKyP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 06:54:15 -0400
Received: by mail-io0-f196.google.com with SMTP id r15-v6so7034969ioa.3
        for <git@vger.kernel.org>; Sun, 22 Jul 2018 02:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2IHXkOYjDZ9J8XGUKc0gB+/7c4fdZve9E49oka+kw0E=;
        b=Fj3n8enmzBLtWzNblbPK519n9l8w718Sjvrx/XuXC1lLqOrlN50Od76+sjVVtprpea
         PBr4NUL+1xii8ZXczZ52s2XzDfEzU68DsJOMplfigtlOUn2Y4KMZ+wQ3aWpbKuD5OeR4
         zZzBrrGF+krKffyCkhyJmlF6rfrf4gF1xoTzOzfnhMeS2BPuYOeDRlZ8nN5sykKzSPRZ
         39jPBGLNy8hdaSfH2M2twpsvH8oxfHs0dck1YXEIOu4RHtPnGh42BFS28nKNYQbrsFHB
         lBdVLFxkGYjs04FMPgSESMVJLSWnMe+Fmq4Y6Nj4VXzMmXenLsB5PNfPAbYbLMkWpOj2
         khKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2IHXkOYjDZ9J8XGUKc0gB+/7c4fdZve9E49oka+kw0E=;
        b=BsJuIaRpWPeffwjoXFv9oV85eCOLU5MVtvFAg8LEl7wMYpGJUbPLY5JiSb7ZTsbAaG
         h7mc5s/AN7sLSiOKY2d7IBM7pPlxkkinl1lJGfZhAkTPX9n/heDaM2FMp4gT9kgTLsAN
         3/aFsILdTUgl6UVaz7kWoWu65XzcbfYe5iuOaQY30dCy30Ar9Uv7Ad+hekDgNFYOCNjM
         1uJ32r/psZR73K5shvtAtWpgLJVTfuoyKNrCMIY6t/5o4f1rIblump6L9bq+USiHVt3z
         mC+EihPJW2C3x28LJQKwTCdFw7f5Q94mdmUc44tdKr+03FHQPw0l3n6vpmKouX4i8Z6c
         G8XA==
X-Gm-Message-State: AOUpUlGroHk+VnlraZgFxD2jaautR9Wnv8uKPkuHxKCewJ1cX6Vn+ZLD
        Ooz3wUb1VpeDubZNpJPoOZXYB9bO
X-Google-Smtp-Source: AAOMgpdoZ8B+kyFsedWwFK2CeyRuyR8cUEWt73fhC5OOGpOTRj6MwUybC8H8+6qgZ0tVWGYPkGDLVw==
X-Received: by 2002:a6b:224d:: with SMTP id i74-v6mr6275135ioi.95.1532253485234;
        Sun, 22 Jul 2018 02:58:05 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id w13-v6sm3681298itb.29.2018.07.22.02.58.04
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 02:58:04 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 10/14] format-patch: add --range-diff option to embed diff in cover letter
Date:   Sun, 22 Jul 2018 05:57:13 -0400
Message-Id: <20180722095717.17912-11-sunshine@sunshineco.com>
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
attempt in the form of a range-diff, however, doing so involves manually
copy/pasting the diff into the cover letter.

Add a --range-diff option to automate this process. The argument to
--range-diff specifies the tip of the previous attempt against which to
generate the range-diff. For example:

    git format-patch --cover-letter --range-diff=v1 -3 v2

(At this stage, the previous attempt and the patch series being
formatted must share a common base, however, a subsequent enhancement
will make it possible to specify an explicit revision range for the
previous attempt.)

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-format-patch.txt | 10 +++++++++
 builtin/log.c                      | 35 ++++++++++++++++++++++++++++++
 revision.h                         |  5 +++++
 t/t3206-range-diff.sh              | 12 ++++++++++
 4 files changed, 62 insertions(+)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index f8a061794d..e7f404be3d 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -24,6 +24,7 @@ SYNOPSIS
 		   [--to=<email>] [--cc=<email>]
 		   [--[no-]cover-letter] [--quiet] [--notes[=<ref>]]
 		   [--interdiff=<previous>]
+		   [--range-diff=<previous>]
 		   [--progress]
 		   [<common diff options>]
 		   [ <since> | <revision range> ]
@@ -238,6 +239,15 @@ feeding the result to `git send-email`.
 	the series being formatted (for example `git format-patch
 	--cover-letter --interdiff=feature/v1 -3 feature/v2`).
 
+--range-diff=<previous>::
+	As a reviewer aid, insert a range-diff (see linkgit:git-range-diff[1])
+	into the cover letter showing the differences between the previous
+	version of the patch series and the series currently being formatted.
+	`previous` is a single revision naming the tip of the previous
+	series which shares a common base with the series being formatted (for
+	example `git format-patch --cover-letter --range-diff=feature/v1 -3
+	feature/v2`).
+
 --notes[=<ref>]::
 	Append the notes (see linkgit:git-notes[1]) for the commit
 	after the three-dash line.
diff --git a/builtin/log.c b/builtin/log.c
index e990027c28..d6e57e8b04 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -31,6 +31,7 @@
 #include "progress.h"
 #include "commit-slab.h"
 #include "interdiff.h"
+#include "range-diff.h"
 
 #define MAIL_DEFAULT_WRAP 72
 
@@ -1088,6 +1089,12 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 		fprintf_ln(rev->diffopt.file, "%s", rev->idiff_title);
 		show_interdiff(rev, 0);
 	}
+
+	if (rev->rdiff1) {
+		fprintf_ln(rev->diffopt.file, "%s", _("Range-diff:"));
+		show_range_diff(rev->rdiff1, rev->rdiff2,
+				rev->creation_factor, 1, &rev->diffopt);
+	}
 }
 
 static const char *clean_message_id(const char *msg_id)
@@ -1437,6 +1444,17 @@ static const char *diff_title(struct strbuf *sb, int reroll_count,
 	return sb->buf;
 }
 
+static void infer_range_diff_ranges(struct strbuf *r1,
+				    struct strbuf *r2,
+				    const char *prev,
+				    struct commit *head)
+{
+	const char *head_oid = oid_to_hex(&head->object.oid);
+
+	strbuf_addf(r1, "%s..%s", head_oid, prev);
+	strbuf_addf(r2, "%s..%s", prev, head_oid);
+}
+
 int cmd_format_patch(int argc, const char **argv, const char *prefix)
 {
 	struct commit *commit;
@@ -1466,6 +1484,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct progress *progress = NULL;
 	struct oid_array idiff_prev = OID_ARRAY_INIT;
 	struct strbuf idiff_title = STRBUF_INIT;
+	const char *rdiff_prev = NULL;
+	struct strbuf rdiff1 = STRBUF_INIT;
+	struct strbuf rdiff2 = STRBUF_INIT;
 
 	const struct option builtin_format_patch_options[] = {
 		{ OPTION_CALLBACK, 'n', "numbered", &numbered, NULL,
@@ -1542,6 +1563,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK(0, "interdiff", &idiff_prev, N_("rev"),
 			     N_("show changes against <rev> in cover letter or single patch"),
 			     parse_opt_object_name),
+		OPT_STRING(0, "range-diff", &rdiff_prev, N_("refspec"),
+			   N_("show changes against <refspec> in cover letter")),
 		OPT_END()
 	};
 
@@ -1774,6 +1797,16 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 					     _("Interdiff against v%d:"));
 	}
 
+	if (rdiff_prev) {
+		if (!cover_letter)
+			die(_("--range-diff requires --cover-letter"));
+
+		infer_range_diff_ranges(&rdiff1, &rdiff2, rdiff_prev, list[0]);
+		rev.rdiff1 = rdiff1.buf;
+		rev.rdiff2 = rdiff2.buf;
+		rev.creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
+	}
+
 	if (!signature) {
 		; /* --no-signature inhibits all signatures */
 	} else if (signature && signature != git_version_string) {
@@ -1897,6 +1930,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 done:
 	oid_array_clear(&idiff_prev);
 	strbuf_release(&idiff_title);
+	strbuf_release(&rdiff1);
+	strbuf_release(&rdiff2);
 	return 0;
 }
 
diff --git a/revision.h b/revision.h
index ffeadc261a..11159416dc 100644
--- a/revision.h
+++ b/revision.h
@@ -217,6 +217,11 @@ struct rev_info {
 	const struct object_id *idiff_oid2;
 	const char *idiff_title;
 
+	/* range-diff */
+	const char *rdiff1;
+	const char *rdiff2;
+	int creation_factor;
+
 	/* commit counts */
 	int count_left;
 	int count_right;
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 2237c7f4af..dd854b6ebc 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -142,4 +142,16 @@ test_expect_success 'changed message' '
 	test_cmp expected actual
 '
 
+for prev in topic
+do
+	test_expect_success "format-patch --range-diff=$prev" '
+		git format-patch --stdout --cover-letter --range-diff=$prev \
+			master..unmodified >actual &&
+		grep "= 1: .* s/5/A" actual &&
+		grep "= 2: .* s/4/A" actual &&
+		grep "= 3: .* s/11/B" actual &&
+		grep "= 4: .* s/12/B" actual
+	'
+done
+
 test_done
-- 
2.18.0.345.g5c9ce644c3

