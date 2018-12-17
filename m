Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F854211B3
	for <e@80x24.org>; Mon, 17 Dec 2018 06:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbeLQGZ2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 01:25:28 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37518 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbeLQGZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 01:25:28 -0500
Received: by mail-ot1-f68.google.com with SMTP id 40so11150873oth.4
        for <git@vger.kernel.org>; Sun, 16 Dec 2018 22:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9k4EYdj6PONCkkaAJEUmYa8eK+tGP2g41iPLF76bXYw=;
        b=XwSOp/lsTw8HqDSLgGraAVY6VzOmOtgfVAj/j2UhzLdTB2XWQHpJmG0dHyJAsqfob+
         H1rGGVgnaAwu7QU4mDmJn5/B52VGQTrwxaM/If3tsYst26/6mTUi8A1e78AZBDamaCRF
         VFI1r/qeTUFe8ja5pqAiMjM1B2dMvy5B/LV/eW1ej7sDQEQBn8Z808Nq7zikYx1TIPD6
         KuPPPq4y+TxXuSYR0K0lDUvr5/XyRA5QNAUpKwMke8eB7Ynmm8+gRz2tkiU4SI0hZEZN
         ELjMydXg4O+139PPEMvCI7ZTyOWI+IAu2Bn52nQBx3B7bihyzMDCFRbYGG2a+pDyeAzG
         UWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9k4EYdj6PONCkkaAJEUmYa8eK+tGP2g41iPLF76bXYw=;
        b=cIa8+HjKzjvotEbq/ThXed8zuxgKuXb+S0cDnwo0OwSOBgzSDupzREO47j42ua1htP
         6ybTLD9mKc1PV76NZERVJY1b7h1Ovylio4p0gTX5nhHD0y3nNdCtlVaPGQWfn1uKkHXY
         KNIEDkYnhN8KTN4Orpgb6RbGJevq0fDclyvZFVZLEeCyKl1iUmxpeEfZGgYCgBEwdEpx
         /z0aV/D/ieMZbtndGjbcwY+7pwvNNqLjRLEQnQAL5zbePklOwIzdGuP+8GNzL7CkaE71
         WQv2x4Be7Dr799ScEwciDrrWv6u4cjJG7QOJ5/4IVZon95WSZetocJB3egQMujtnSCTY
         MOWg==
X-Gm-Message-State: AA+aEWbr5QBm6IbzNFiPjQL5ibIl/KWvTMupeflW7QCpikTzF1XUL5pa
        Bmk8dWwXlnCYSxwGIrhjCA1uJn22k2bSWumpzgE9SsbJ
X-Google-Smtp-Source: AFSGD/VrSO0n+mX7+hqHPOCBILSmhxTu3U/xrAWUXihH67n417/3dy6Vj6bFitud+kSjHeIsaq5tZmGTMFvSjGE/Hmg=
X-Received: by 2002:a9d:781:: with SMTP id 1mr8158119oto.250.1545027925898;
 Sun, 16 Dec 2018 22:25:25 -0800 (PST)
MIME-Version: 1.0
From:   Issac Trotts <issac.trotts@gmail.com>
Date:   Sun, 16 Dec 2018 22:25:14 -0800
Message-ID: <CANdyxMwxPqTMfLsoK-2JT3Wf3hXZnQNCPRS04aSHzsMbYJZo-Q@mail.gmail.com>
Subject: [PATCH] log: add %S option (like --source) to log --format
To:     git@vger.kernel.org
Cc:     Noemi Mercado <noemi@sourcegraph.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make it possible to write for example

        git log --format="%H,%S"

where the %S at the end is a new placeholder that prints out the ref
(tag/branch) for each commit.

Using %d might seem like an alternative but it only shows the ref for
the last commit in the branch.

This change is based on a question from Stack Overflow:
https://stackoverflow.com/questions/12712775/git-get-source-information-in-format
---
 Documentation/pretty-formats.txt |  2 ++
 builtin/log.c                    |  2 +-
 log-tree.c                       |  1 +
 pretty.c                         | 10 +++++++
 t/t4205-log-pretty-formats.sh    | 50 ++++++++++++++++++++++++++++++++
 5 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 417b638cd..acfe7e0a4 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -104,6 +104,8 @@ The placeholders are:

 - '%H': commit hash
 - '%h': abbreviated commit hash
+- '%S': ref name given on the command line by which the commit was reached
+  (like `git log --source`)
 - '%T': tree hash
 - '%t': abbreviated tree hash
 - '%P': parent hashes
diff --git a/builtin/log.c b/builtin/log.c
index e8e51068b..a314ea2b6 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -203,7 +203,7 @@ static void cmd_log_init_finish(int argc, const
char **argv, const char *prefix,
         rev->diffopt.filter || rev->diffopt.flags.follow_renames)
         rev->always_show_header = 0;

-    if (source) {
+    if (source || (rev->pretty_given && rev->commit_format ==
CMIT_FMT_USERFORMAT)) {
         init_revision_sources(&revision_sources);
         rev->sources = &revision_sources;
     }
diff --git a/log-tree.c b/log-tree.c
index 10680c139..3cb14256e 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -700,6 +700,7 @@ void show_log(struct rev_info *opt)
     ctx.color = opt->diffopt.use_color;
     ctx.expand_tabs_in_log = opt->expand_tabs_in_log;
     ctx.output_encoding = get_log_output_encoding();
+    ctx.rev = opt;
     if (opt->from_ident.mail_begin && opt->from_ident.name_begin)
         ctx.from_ident = &opt->from_ident;
     if (opt->graph)
diff --git a/pretty.c b/pretty.c
index b83a3ecd2..b1774acad 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1084,6 +1084,7 @@ static size_t format_commit_one(struct strbuf
*sb, /* in UTF-8 */
     struct commit_list *p;
     const char *arg;
     int ch;
+    char **slot;

     /* these are independent of the commit */
     switch (placeholder[0]) {
@@ -1149,6 +1150,15 @@ static size_t format_commit_one(struct strbuf
*sb, /* in UTF-8 */
         parse_object(the_repository, &commit->object.oid);

     switch (placeholder[0]) {
+    case 'S':        /* tag/branch like --source */
+        slot = revision_sources_at(c->pretty_ctx->rev->sources, commit);
+        if (slot && *slot) {
+            strbuf_addstr(sb, *slot);
+            return 1;
+        } else {
+            die(_("failed to get info for %%S"));
+            return 0;
+        }
     case 'H':        /* commit hash */
         strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_COMMIT));
         strbuf_addstr(sb, oid_to_hex(&commit->object.oid));
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 978a8a66f..7df8c3d4e 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -621,4 +621,54 @@ test_expect_success 'trailer parsing not fooled
by --- line' '
     test_cmp expect actual
 '

+test_expect_success 'set up %S tests' '
+    git checkout --orphan source-a &&
+    test_commit one &&
+    test_commit two &&
+    git checkout -b source-b HEAD^ &&
+    test_commit three
+'
+
+test_expect_success 'log --format=%S paints branch names' '
+    cat >expect <<-\EOF &&
+    source-b
+    source-a
+    source-b
+    EOF
+    git log --format=%S source-a source-b >actual &&
+    test_cmp expect actual
+'
+
+test_expect_success 'log --format=%S paints tag names' '
+    git tag -m tagged source-tag &&
+    cat >expect <<-\EOF &&
+    source-tag
+    source-a
+    source-tag
+    EOF
+    git log --format=%S source-tag source-a >actual &&
+    test_cmp expect actual
+'
+
+test_expect_success 'log --format=%S paints symmetric ranges' '
+    cat >expect <<-\EOF &&
+    source-b
+    source-a
+    EOF
+    git log --format=%S source-a...source-b >actual &&
+    test_cmp expect actual
+'
+
+test_expect_success '%S in git log --format works with other
placeholders (part 1)' '
+    git log --format="source-b %h" source-b >expect &&
+    git log --format="%S %h" source-b >actual &&
+    test_cmp expect actual
+'
+
+test_expect_success '%S in git log --format works with other
placeholders (part 2)' '
+    git log --format="%h source-b" source-b >expect &&
+    git log --format="%h %S" source-b >actual &&
+    test_cmp expect actual
+'
+
 test_done
-- 
2.19.1
