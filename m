Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8FD41F609
	for <e@80x24.org>; Wed, 28 Nov 2018 20:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeK2H1J (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 02:27:09 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38657 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbeK2H1J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 02:27:09 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so24175785wrw.5
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 12:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z2ivQedDUUZAWzv5zbPkCw0EMgpYm2m6QvYi8Aa5hzY=;
        b=Q8nGYDhZ/IAjTJuuI16FJloVuhA90k/FCty3/jviYel19CycJw4yU/6nt6I6tso34V
         DyMaI5P4hEHZy9Ch4MbOadKb0FIm+l381guj57ckkMuuEtAFvzcDt86PS2IplO9iKr6j
         GZ17lHDRsZXazxT+vzGkR8m18G+QRs22lTx3gpzAtOi459Gy9p+9Y89Yd0s8JAbZFTBK
         8/DtXzE57EgacvqAG1GORbZnjsRdq9WFh40BVrpZrXRxPVSGL8M3/5E3g9WER6XDrDBm
         f1J6Tdn5/Gw6uFQAldm6dmGYO3ZyR4xW+w9J+WcFNqEsRUDe99I11+xP25hUKnN80o9a
         /45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z2ivQedDUUZAWzv5zbPkCw0EMgpYm2m6QvYi8Aa5hzY=;
        b=eakvyz6mmM5UJc2QDfOPTIxyinf1TAFv5gctxbNiB3xtbhvWtHJCue5CcrEIqjkVw+
         lI4UnEwyE3T1NTpa9EP9UE7lojSF0JNzZdlUwQ64XWc2izJS3jigBnvJfbOXdz+SFGHp
         pBmI/t2rDk56RcSvZTb/iLp5sSxx1qsgYYVKAiVxrsLYT2rq5Av0WkKnwGVxI3B5VyIk
         c1Y/91oud5SOvb54xxH3HuUFured2RbWueOZbIERlbLIqd8T9BqREelcYD64ks32+aHO
         3U+k/s7Djyz++n8RZYSRCbdg4UQ7K5yRF64+c3pJmoaIFrK5XajvGY/UZuDGuSNAu53r
         enlg==
X-Gm-Message-State: AA+aEWbd4bMXh7Krw+Bfn4I+5IWP4ic/4X/y7BvHOIJaKS64deWgA5BL
        A6/FNMQhuFKiYvmpr8Rm5FC7Ycp+
X-Google-Smtp-Source: AFSGD/UxprP5KK3u1kTzK66+su1xEeR7ULe6kVJMHaZKn92BMkEQXBpdreA3r2oxkvNMd9QvkWzu5Q==
X-Received: by 2002:adf:b608:: with SMTP id f8mr31244910wre.120.1543436339910;
        Wed, 28 Nov 2018 12:18:59 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 5sm4648896wmw.8.2018.11.28.12.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 12:18:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] format-patch: allow for independent diff & range-diff options
Date:   Wed, 28 Nov 2018 21:18:52 +0100
Message-Id: <20181128201852.9782-3-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3
In-Reply-To: <xmqqk1l32jo2.fsf@gitster-ct.c.googlers.com>
References: <xmqqk1l32jo2.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the semantics of the "--range-diff" option so that the regular
diff options can be provided separately for the range-diff and the
patch. This allows for supplying e.g. --range-diff-U0 and -U1 to
"format-patch" to provide different context for the range-diff and the
patch. This wasn't possible before.

Ever since the "--range-diff" option was added in
31e2617a5f ("format-patch: add --range-diff option to embed diff in
cover letter", 2018-07-22) the "rev->diffopt" we pass down to the diff
machinery has been the one we get from "format-patch"'s own
setup_revisions().

This sort of thing is unique among the log-like commands in
builtin/log.c, no command than format-patch will embed the output of
another log-like command. Since the "rev->diffopt" is reused we need
to munge it before we pass it to show_range_diff(). See
43dafc4172 ("format-patch: don't include --stat with --range-diff
output", 2018-11-22) for a related regression fix which is being
mostly reverted here.

Implementation notes: 1) We're not bothering with the full teardown
around die() and will leak memory, but it's too much boilerplate to do
all the frees with/without the die() and not worth it. 2) We call
repo_init_revisions() for "rd_rev" even though we could get away with
a shallow copy like the code we're replacing (and which
show_range_diff() itself does). This is to make this code more easily
understood.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-format-patch.txt | 10 ++++++-
 builtin/log.c                      | 42 +++++++++++++++++++++++-------
 t/t3206-range-diff.sh              | 41 +++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index aba4c5febe..6c048f415f 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -24,7 +24,8 @@ SYNOPSIS
 		   [--to=<email>] [--cc=<email>]
 		   [--[no-]cover-letter] [--quiet] [--notes[=<ref>]]
 		   [--interdiff=<previous>]
-		   [--range-diff=<previous> [--creation-factor=<percent>]]
+		   [--range-diff=<previous> [--creation-factor=<percent>]
+		      [--range-diff<common diff option>]]
 		   [--progress]
 		   [<common diff options>]
 		   [ <since> | <revision range> ]
@@ -257,6 +258,13 @@ feeding the result to `git send-email`.
 	creation/deletion cost fudge factor. See linkgit:git-range-diff[1])
 	for details.
 
+--range-diff<common diff option>::
+	Other options prefixed with `--range-diff` are stripped of
+	that prefix and passed as-is to the diff machinery used to
+	generate the range-diff, e.g. `--range-diff-U0` and
+	`--range-diff--no-color`. This allows for adjusting the format
+	of the range-diff independently from the patch itself.
+
 --notes[=<ref>]::
 	Append the notes (see linkgit:git-notes[1]) for the commit
 	after the three-dash line.
diff --git a/builtin/log.c b/builtin/log.c
index 02d88fa233..7658e56ecc 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1023,7 +1023,8 @@ static void show_diffstat(struct rev_info *rev,
 	fprintf(rev->diffopt.file, "\n");
 }
 
-static void make_cover_letter(struct rev_info *rev, int use_stdout,
+static void make_cover_letter(struct rev_info *rev, struct rev_info *rd_rev,
+			      int use_stdout,
 			      struct commit *origin,
 			      int nr, struct commit **list,
 			      const char *branch_name,
@@ -1095,13 +1096,9 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	}
 
 	if (rev->rdiff1) {
-		struct diff_options opts;
-		memcpy(&opts, &rev->diffopt, sizeof(opts));
-		opts.output_format &= ~(DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_SUMMARY);
-
 		fprintf_ln(rev->diffopt.file, "%s", rev->rdiff_title);
 		show_range_diff(rev->rdiff1, rev->rdiff2,
-				rev->creation_factor, 1, &opts);
+				rev->creation_factor, 1, &rd_rev->diffopt);
 	}
 }
 
@@ -1485,6 +1482,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct commit *commit;
 	struct commit **list = NULL;
 	struct rev_info rev;
+	struct rev_info rd_rev;
 	struct setup_revision_opt s_r_opt;
 	int nr = 0, total, i;
 	int use_stdout = 0;
@@ -1603,6 +1601,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	init_log_defaults();
 	git_config(git_format_config, NULL);
 	repo_init_revisions(the_repository, &rev, prefix);
+	repo_init_revisions(the_repository, &rd_rev, prefix);
 	rev.commit_format = CMIT_FMT_EMAIL;
 	rev.expand_tabs_in_log_default = 0;
 	rev.verbose_header = 1;
@@ -1689,8 +1688,32 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.preserve_subject = keep_subject;
 
 	argc = setup_revisions(argc, argv, &rev, &s_r_opt);
-	if (argc > 1)
-		die(_("unrecognized argument: %s"), argv[1]);
+	if (argc > 1) {
+		struct argv_array args = ARGV_ARRAY_INIT;
+		const char *prefix = "--range-diff";
+		int have_prefix = 0;
+
+		for (i = 0; i < argc; i++) {
+			struct strbuf sb = STRBUF_INIT;
+			char *str;
+
+			strbuf_addstr(&sb, argv[i]);
+			if (starts_with(argv[i], prefix)) {
+				have_prefix = 1;
+				strbuf_remove(&sb, 0, strlen(prefix));
+			}
+			str = strbuf_detach(&sb, NULL);
+			strbuf_release(&sb);
+
+			argv_array_push(&args, str);
+		}
+
+		if (!have_prefix)
+			die(_("unrecognized argument: %s"), argv[1]);
+		argc = setup_revisions(args.argc, args.argv, &rd_rev, NULL);
+		if (argc > 1)
+			die(_("unrecognized argument: %s"), argv[1]);
+	}
 
 	if (rev.diffopt.output_format & DIFF_FORMAT_NAME)
 		die(_("--name-only does not make sense"));
@@ -1702,7 +1725,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (!use_patch_format &&
 		(!rev.diffopt.output_format ||
 		 rev.diffopt.output_format == DIFF_FORMAT_PATCH))
-		/* Needs to be mirrored in show_range_diff() invocation */
 		rev.diffopt.output_format = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_SUMMARY;
 	if (!rev.diffopt.stat_width)
 		rev.diffopt.stat_width = MAIL_DEFAULT_WRAP;
@@ -1877,7 +1899,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (cover_letter) {
 		if (thread)
 			gen_message_id(&rev, "cover");
-		make_cover_letter(&rev, use_stdout,
+		make_cover_letter(&rev, &rd_rev, use_stdout,
 				  origin, nr, list, branch_name, quiet);
 		print_bases(&bases, rev.diffopt.file);
 		print_signature(rev.diffopt.file);
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index bc5facc1cd..6916103888 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -308,6 +308,35 @@ test_expect_success 'format-patch with <common diff option>' '
 		--range-diff=topic~..topic changed~..changed >actual.raw &&
 	sed -ne "/^1:/,/^--/p" <actual.raw >actual.range-diff &&
 	sed -e "s|:$||" >expect <<-\EOF &&
+	1:  a63e992 ! 1:  d966c5c s/12/B/
+	    @@ -8,7 +8,7 @@
+	     @@
+	      9
+	      10
+	    - B
+	    + BB
+	     -12
+	     +B
+	      13
+	-- :
+	EOF
+	test_cmp expect actual.range-diff &&
+	sed -ne "/^--- /,/^--/p" <actual.raw >actual.diff &&
+	sed -e "s|:$||" >expect <<-\EOF &&
+	--- a/file
+	+++ b/file
+	@@ -12 +12 @@ BB
+	-12
+	+B
+	-- :
+	EOF
+	test_cmp expect actual.diff &&
+
+	# -U0 & --range-diff-U0
+	git format-patch --cover-letter --stdout -U0 --range-diff-U0 \
+		--range-diff=topic~..topic changed~..changed >actual.raw &&
+	sed -ne "/^1:/,/^--/p" <actual.raw >actual.range-diff &&
+	sed -e "s|:$||" >expect <<-\EOF &&
 	1:  a63e992 ! 1:  d966c5c s/12/B/
 	    @@ -11 +11 @@
 	    - B
@@ -327,4 +356,16 @@ test_expect_success 'format-patch with <common diff option>' '
 	test_cmp expect actual.diff
 '
 
+test_expect_success 'format-patch option parsing with --range-diff-*' '
+	test_must_fail git format-patch --stdout --unknown \
+		master..unmodified 2>stderr &&
+	test_i18ngrep "unrecognized argument: --unknown" stderr &&
+	test_must_fail git format-patch --stdout --range-diff-unknown \
+		master..unmodified 2>stderr &&
+	test_i18ngrep "unrecognized argument: --range-diff-unknown" stderr &&
+	test_must_fail git format-patch --stdout --unknown --range-diff-unknown \
+		master..unmodified 2>stderr &&
+	test_i18ngrep "unrecognized argument: --unknown" stderr
+'
+
 test_done
-- 
2.20.0.rc1.387.gf8505762e3

