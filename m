Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2A681F597
	for <e@80x24.org>; Sun, 22 Jul 2018 09:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbeGVKyM (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 06:54:12 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:40017 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbeGVKyL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 06:54:11 -0400
Received: by mail-io0-f194.google.com with SMTP id l14-v6so13263744iob.7
        for <git@vger.kernel.org>; Sun, 22 Jul 2018 02:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eFTXQMsq8qDjaDOdxPfSnfOKPBIvMZdyDRx0LOS/YZc=;
        b=Nt5891+FDynH5x450hOlsUwW1kWPxqpX7c9myEyOb8TQOwPJsGS7GMcVrQfHAxe4Wq
         yuuD0PwuyVorNCg/R/1g1L3xzYEUJ184E0xuimcilSnR+7h4JK//CZbULUTUNF9Gdni1
         dljQgtIWqpzfMgk9edtdXpqmKWsgFd39vNXyjfqsCWorJobsCwY732368go5XHvnJo25
         i3v76kcWwt0EgJPAyYNGD7LDD0tsmEcDvC71E4fUNIMnpVPdXc3Te581QvkBfFybDLnT
         QPuSFE+V64TOo4PSBrCKuLA9feDyU+05OogTY5OERIRLK/T/BkW3fMFAeGpFj5KJrMos
         rTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=eFTXQMsq8qDjaDOdxPfSnfOKPBIvMZdyDRx0LOS/YZc=;
        b=rLL/jNurCO1RpxfE1rFkvDJ1P8H+v3CI2Dlvqrto13m/lfPGk3lpDcDfr1qWG9CU2U
         tIyxT+lBWutZ6gRaO1PQbJ2GPb56kU8onTUUbTUKYIoL3FvlO7yBauSanfHnVzP5l2ge
         wxhs/81u5bQo/EldwuaE+JApFGOsBOkDLsjZNjRT0jtrXQfVO2RFpmmErLHXeBFokts+
         vfBJUHNCmBktuCyBvjofCb62K2FxJKnTldfuvL5EHjqZN9fX6KOZaQaUE7M0fsmRLM+m
         n+XgPJR/mQg+KU8wa4RuSSwYMgbsB/6oLtZBtCj5YWUMQtHFShIXzm+VDvZQvr4nTQlI
         nkTw==
X-Gm-Message-State: AOUpUlHzfxH9s03ftxJXNQGLB9u2lmqZ0yUGJd3Tkq5zeeLSYPGfXUjL
        qzOYSIURVaKYqOKpmtU+MMznfJUE
X-Google-Smtp-Source: AAOMgpd8vjJDLp5o28/I5ufBoE2kym7w4zevTQ+hYMwdf/Gkcog7SU3hFiICBdRLlq0wygn4bJBeNA==
X-Received: by 2002:a6b:2c4b:: with SMTP id s72-v6mr7072007ios.195.1532253481553;
        Sun, 22 Jul 2018 02:58:01 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id w13-v6sm3681298itb.29.2018.07.22.02.58.00
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 02:58:01 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 06/14] format-patch: allow --interdiff to apply to a lone-patch
Date:   Sun, 22 Jul 2018 05:57:09 -0400
Message-Id: <20180722095717.17912-7-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180722095717.17912-1-sunshine@sunshineco.com>
References: <20180722095717.17912-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When submitting a revised version of a patch or series, it can be
helpful (to reviewers) to include a summary of changes since the
previous attempt in the form of an interdiff, typically in the cover
letter. However, it is occasionally useful, despite making for a noisy
read, to insert an interdiff into the commentary section of the lone
patch of a 1-patch series.

Therefore, extend "git format-patch --interdiff=<prev>" to insert an
interdiff into the commentary section of a lone patch rather than
requiring a cover letter. The interdiff is indented to avoid confusing
git-am and human readers into considering it part of the patch proper.

Implementation note: Generating an interdiff for insertion into the
commentary section of a patch which itself is currently being generated
requires invoking the diffing machinery recursively. However, the
machinery does not (presently) support this since it uses global state.
Consequently, we need to take care to stash away the state of the
in-progress operation while generating the interdiff, and restore it
after.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-format-patch.txt |  3 ++-
 builtin/log.c                      |  8 +++++---
 log-tree.c                         | 14 ++++++++++++++
 t/t4014-format-patch.sh            | 12 ++++++++++++
 4 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index a1b1bafee7..f8a061794d 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -230,7 +230,8 @@ feeding the result to `git send-email`.
 	fill in a description in the file before sending it out.
 
 --interdiff=<previous>::
-	As a reviewer aid, insert an interdiff into the cover letter showing
+	As a reviewer aid, insert an interdiff into the cover letter,
+	or as commentary of the lone patch of a 1-patch series, showing
 	the differences between the previous version of the patch series and
 	the series currently being formatted. `previous` is a single revision
 	naming the tip of the previous series which shares a common base with
diff --git a/builtin/log.c b/builtin/log.c
index 8078a43d14..e990027c28 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1540,7 +1540,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "progress", &show_progress,
 			 N_("show progress while generating patches")),
 		OPT_CALLBACK(0, "interdiff", &idiff_prev, N_("rev"),
-			     N_("show changes against <rev> in cover letter"),
+			     N_("show changes against <rev> in cover letter or single patch"),
 			     parse_opt_object_name),
 		OPT_END()
 	};
@@ -1765,8 +1765,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		rev.total = total + start_number - 1;
 
 	if (idiff_prev.nr) {
-		if (!cover_letter)
-			die(_("--interdiff requires --cover-letter"));
+		if (!cover_letter && total != 1)
+			die(_("--interdiff requires --cover-letter or single patch"));
 		rev.idiff_oid1 = &idiff_prev.oid[idiff_prev.nr - 1];
 		rev.idiff_oid2 = get_commit_tree_oid(list[0]);
 		rev.idiff_title = diff_title(&idiff_title, reroll_count,
@@ -1811,6 +1811,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		print_signature(rev.diffopt.file);
 		total++;
 		start_number--;
+		/* interdiff in cover-letter; omit from patches */
+		rev.idiff_oid1 = NULL;
 	}
 	rev.add_signoff = do_signoff;
 
diff --git a/log-tree.c b/log-tree.c
index 9d38f1cf79..56513fa83d 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -14,6 +14,7 @@
 #include "sequencer.h"
 #include "line-log.h"
 #include "help.h"
+#include "interdiff.h"
 
 static struct decoration name_decoration = { "object names" };
 static int decoration_loaded;
@@ -736,6 +737,19 @@ void show_log(struct rev_info *opt)
 
 	strbuf_release(&msgbuf);
 	free(ctx.notes_message);
+
+	if (cmit_fmt_is_mail(ctx.fmt) && opt->idiff_oid1) {
+		struct diff_queue_struct dq;
+
+		memcpy(&dq, &diff_queued_diff, sizeof(diff_queued_diff));
+		DIFF_QUEUE_CLEAR(&diff_queued_diff);
+
+		next_commentary_block(opt, NULL);
+		fprintf_ln(opt->diffopt.file, "%s", opt->idiff_title);
+		show_interdiff(opt, 2);
+
+		memcpy(&diff_queued_diff, &dq, sizeof(diff_queued_diff));
+	}
 }
 
 int log_tree_diff_flush(struct rev_info *opt)
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 5950890d30..909c743c13 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1730,6 +1730,7 @@ test_expect_success 'interdiff: cover-letter' '
 	EOF
 	git format-patch --cover-letter --interdiff=boop~2 -1 boop &&
 	test_i18ngrep "^Interdiff:$" 0000-cover-letter.patch &&
+	test_i18ngrep ! "^Interdiff:$" 0001-fleep.patch &&
 	sed "1,/^@@ /d; /^-- $/q" <0000-cover-letter.patch >actual &&
 	test_cmp expect actual
 '
@@ -1739,4 +1740,15 @@ test_expect_success 'interdiff: reroll-count' '
 	test_i18ngrep "^Interdiff ..* v1:$" v2-0000-cover-letter.patch
 '
 
+test_expect_success 'interdiff: solo-patch' '
+	cat >expect <<-\EOF &&
+	  +fleep
+
+	EOF
+	git format-patch --interdiff=boop~2 -1 boop &&
+	test_i18ngrep "^Interdiff:$" 0001-fleep.patch &&
+	sed "1,/^  @@ /d; /^$/q" <0001-fleep.patch >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.18.0.345.g5c9ce644c3

