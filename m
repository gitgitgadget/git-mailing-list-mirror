Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90645C433C1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 08:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 558D461930
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 08:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhCUI7N (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 04:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhCUI67 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 04:58:59 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CD3C061762
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 01:58:58 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id 61so13444811wrm.12
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 01:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XV+6WLkOn05a8uhswC+WThR2PIVf47WbU96Bo3Y6SIw=;
        b=ALDstTI2ObCUurzLJ/miGYDn+JaReroWHSQ2D/XjJubqHw52lbospZ8XkLSXVieRbN
         fY6cEgUCZ7OuMvlVRN0st0o8gLx26R4idRBmmB1V/KjDtns+PVmH+jk37SjH/sP+0GCU
         hZrfY9j9JJ+YFkDs9ERIhj0ftM7omgrbxFGZuYuFKBRHPVua6DUNbLvAFPUNH6bCaRV4
         T+7Lb7Tlr2OMlD0GmKYUfmleyhHm9ckQtGkJCdeLq9cn8pXUQa9c3OwjFPTe/A10lFxe
         /4dg8HCE/rUHG2DoPX2uewXv2T3n+VvOAbDWTYea5Fzu/iFeXV5/PSEWoAaCghSIDKcd
         ohVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XV+6WLkOn05a8uhswC+WThR2PIVf47WbU96Bo3Y6SIw=;
        b=iBIaocEWqo7wLZJj1SEaBwdMlEnui6T4PaYHpfeS7f960o4XZTpoZImPHrGOoJECDB
         YB2BWsU/IwJ95RQT73WT9el+HHYEMrs2RHiIxnjmPPKkeXD5QhdIukQiQcclExhED51T
         pPV1xRE2iNb/aK/dzhSyofB0Ea8qt0cjWsLOdVwZc+Sm6LMyh4EQagmGQy69B1btAdFe
         OnSEq/qXR30qMZV0CVuQeMpzwoowwQ/jfMHnd4C1e+VKM6JnWl6J2RzRpo2A2a9DzEV3
         oD+f+W4wBi7XmM6o/S1Iczw515e8LeEyRmQVpptjYWhlgrp5awHNVt4rtZtG/s+1ZNr9
         Flkw==
X-Gm-Message-State: AOAM531vXn3xqQ1T0N0W764I+k3ZID0PPHrhptHlCsMV/4kv6fEE2Tji
        5UVsfYhpPnpqVJZO8SK7N09GqnbosD8=
X-Google-Smtp-Source: ABdhPJxBcRDXgj0Oe0w5Vwox/r8gfqCb9NhXGQbcmcqCpNu7ry7gR2yP1QV/n4J7/Ae3QXw4Osq0GA==
X-Received: by 2002:a05:6000:1b0f:: with SMTP id f15mr12898592wrz.171.1616317137494;
        Sun, 21 Mar 2021 01:58:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j20sm12485270wmp.30.2021.03.21.01.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 01:58:57 -0700 (PDT)
Message-Id: <8b8b236a4ffb81a8c6be3f320b878cea1d0f9d7a.1616317135.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.911.v2.git.1616317134.gitgitgadget@gmail.com>
References: <pull.911.git.1616251299.gitgitgadget@gmail.com>
        <pull.911.v2.git.1616317134.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Mar 2021 08:58:54 +0000
Subject: [PATCH v2 2/2] [GSOC] interpret-trailer: easy parse trailer value
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

The original `-trailer` adding some trailers like
"Signed-off-by:C O <Mister@email.com>" is often too
verbose and error-prone.

Now add the syntax parse for the value of `--trailer`:
e.g. "Signed-off-by:@Junio", git will fuzzy search in the
commit history to find the latest one commit which matches
`--author=Junio`, and get the "author <email>" pair
`Junio C Hamano <gitster@pobox.com>` as the value of
`--trailer`, it will be a easy way to add trailers.
git commit --trailer` can also benefit from this.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jeff King <peff@peff.net>
---
 Documentation/git-interpret-trailers.txt | 23 ++++++++++++++++
 builtin/commit.c                         | 33 -----------------------
 commit.c                                 | 34 ++++++++++++++++++++++++
 commit.h                                 | 10 +++++++
 t/t7502-commit-porcelain.sh              | 28 +++++++++++++++++++
 t/t7513-interpret-trailers.sh            | 23 ++++++++++++++++
 trailer.c                                | 13 ++++++++-
 7 files changed, 130 insertions(+), 34 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 96ec6499f001..33e76f2a58fb 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -69,6 +69,29 @@ Note that 'trailers' do not follow and are not intended to follow many
 rules for RFC 822 headers. For example they do not follow
 the encoding rules and probably many other rules.
 
+Support to replace the value in the form of `@nickname`, provided that the
+commit with nickname as the author can be found in the your repository's git
+log. For example, in git's source code repository you can use commands:
+
+`git log --author="Junio"  --pretty="%an <%ae>" | sort |uniq `
+
+to find Junio's "name <email>" pair:
+
+Junio C Hamano <gitster@pobox.com>
+Junio C Hamano <junio@hera.kernel.org>
+Junio C Hamano <junio@kernel.org>
+Junio C Hamano <junio@pobox.com>
+...
+
+If you want to add a `Helped-by` trailer with Junio "name <email>" pair,
+you can use:
+
+`git commit --trailers "Helped-by:@Junio"`
+
+to insert the trailer to your commit messages:
+
+Helped-by: Junio C Hamano <gitster@pobox.com>
+
 OPTIONS
 -------
 --in-place::
diff --git a/builtin/commit.c b/builtin/commit.c
index 4b06672bd07d..58c020e3cfbf 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1043,39 +1043,6 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	return 1;
 }
 
-static const char *find_author_by_nickname(const char *name)
-{
-	struct rev_info revs;
-	struct commit *commit;
-	struct strbuf buf = STRBUF_INIT;
-	struct string_list mailmap = STRING_LIST_INIT_NODUP;
-	const char *av[20];
-	int ac = 0;
-
-	repo_init_revisions(the_repository, &revs, NULL);
-	strbuf_addf(&buf, "--author=%s", name);
-	av[++ac] = "--all";
-	av[++ac] = "-i";
-	av[++ac] = buf.buf;
-	av[++ac] = NULL;
-	setup_revisions(ac, av, &revs, NULL);
-	revs.mailmap = &mailmap;
-	read_mailmap(revs.mailmap);
-
-	if (prepare_revision_walk(&revs))
-		die(_("revision walk setup failed"));
-	commit = get_revision(&revs);
-	if (commit) {
-		struct pretty_print_context ctx = {0};
-		ctx.date_mode.type = DATE_NORMAL;
-		strbuf_release(&buf);
-		format_commit_message(commit, "%aN <%aE>", &buf, &ctx);
-		clear_mailmap(&mailmap);
-		return strbuf_detach(&buf, NULL);
-	}
-	die(_("--author '%s' is not 'Name <email>' and matches no existing author"), name);
-}
-
 static void handle_ignored_arg(struct wt_status *s)
 {
 	if (!ignored_arg)
diff --git a/commit.c b/commit.c
index 6ccd774841c6..e1aad52d2c4f 100644
--- a/commit.c
+++ b/commit.c
@@ -21,6 +21,7 @@
 #include "commit-reach.h"
 #include "run-command.h"
 #include "shallow.h"
+#include "mailmap.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -1703,3 +1704,36 @@ int run_commit_hook(int editor_is_used, const char *index_file,
 
 	return ret;
 }
+
+const char *find_author_by_nickname(const char *name)
+{
+	struct rev_info revs;
+	struct commit *commit;
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list mailmap = STRING_LIST_INIT_NODUP;
+	const char *av[20];
+	int ac = 0;
+
+	repo_init_revisions(the_repository, &revs, NULL);
+	strbuf_addf(&buf, "--author=%s", name);
+	av[++ac] = "--all";
+	av[++ac] = "-i";
+	av[++ac] = buf.buf;
+	av[++ac] = NULL;
+	setup_revisions(ac, av, &revs, NULL);
+	revs.mailmap = &mailmap;
+	read_mailmap(revs.mailmap);
+
+	if (prepare_revision_walk(&revs))
+		die(_("revision walk setup failed"));
+	commit = get_revision(&revs);
+	if (commit) {
+		struct pretty_print_context ctx = {0};
+		ctx.date_mode.type = DATE_NORMAL;
+		strbuf_release(&buf);
+		format_commit_message(commit, "%aN <%aE>", &buf, &ctx);
+		clear_mailmap(&mailmap);
+		return strbuf_detach(&buf, NULL);
+	}
+	die(_("--author '%s' is not 'Name <email>' and matches no existing author"), name);
+}
diff --git a/commit.h b/commit.h
index 49c0f503964e..cb9f7cd13f09 100644
--- a/commit.h
+++ b/commit.h
@@ -370,5 +370,15 @@ int parse_buffer_signed_by_header(const char *buffer,
 				  struct strbuf *payload,
 				  struct strbuf *signature,
 				  const struct git_hash_algo *algop);
+/*
+ * Calling `find_author_by_nickname` to find the "author <email>" pair
+ * in the most recent commit which matches "--author=name".
+ *
+ * Note that `find_author_by_nickname` is not reusable, because it haven't
+ * reset flags for parsed objects. The only safe way to use `find_author_by_nickname`
+ * (without rewriting the revision traversal machinery) is to spawn a
+ * subprocess and do find_author_by_nickname() in it.
+ */
+const char *find_author_by_nickname(const char *name);
 
 #endif /* COMMIT_H */
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index 74b1602c0ce6..143690e2833c 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -445,6 +445,34 @@ test_expect_success 'commit --trailer with -c and ":=#" as separators' '
 	test_cmp expected actual
 '
 
+
+test_expect_success 'commit --trailer parse @nickname' '
+	echo "I love git" >file1 &&
+	git add file1 &&
+	git commit -m "yly" --author="batman <email1>" &&
+	echo "I love git" >file2 &&
+	git add file2 &&
+	git commit -m "yly" --author="jocker <email2>" &&
+	echo "I love git" >file3 &&
+	git add file3 &&
+	git commit -m "yly" \
+	--trailer "Reviewed-by:@bat" \
+	--trailer "Signed-off-by:@jock" \
+	--trailer "Helped-by:@email1" \
+	--trailer "Mentored-by:@email2" &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d" commit.msg >actual &&
+	cat >expected <<-\EOF &&
+	yly
+
+	Reviewed-by: batman <email1>
+	Signed-off-by: jocker <email2>
+	Helped-by: batman <email1>
+	Mentored-by: jocker <email2>
+	EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'multiple -m' '
 
 	>negative &&
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 6602790b5f4c..f2f1ae3b2faf 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -63,6 +63,29 @@ test_expect_success 'without config' '
 	test_cmp expected actual
 '
 
+test_expect_success 'trailer parse @nickname' '
+	echo "I love git" >file1 &&
+	git add file1 &&
+	git commit -m "yly" --author="batman <email1>" &&
+	echo "I love git" >file2 &&
+	git add file2 &&
+	git commit -m "yly" --author="jocker <email2>" &&
+	git interpret-trailers \
+	--trailer "Reviewed-by:@bat" \
+	--trailer "Signed-off-by:@jock" \
+	--trailer "Helped-by:@email1" \
+	--trailer "Mentored-by:@email2" \
+	empty >actual &&
+	cat >expected <<-\EOF &&
+
+	Reviewed-by: batman <email1>
+	Signed-off-by: jocker <email2>
+	Helped-by: batman <email1>
+	Mentored-by: jocker <email2>
+	EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'without config in another order' '
 	sed -e "s/ Z\$/ /" >expected <<-\EOF &&
 
diff --git a/trailer.c b/trailer.c
index 249ed618ed8e..21f367e7b761 100644
--- a/trailer.c
+++ b/trailer.c
@@ -6,6 +6,7 @@
 #include "tempfile.h"
 #include "trailer.h"
 #include "list.h"
+#include "revision.h"
 /*
  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
  */
@@ -633,11 +634,21 @@ static void parse_trailer(struct strbuf *tok, struct strbuf *val,
 	struct arg_item *item;
 	size_t tok_len;
 	struct list_head *pos;
+	const char *ae = NULL;
 
 	if (separator_pos != -1) {
 		strbuf_add(tok, trailer, separator_pos);
 		strbuf_trim(tok);
-		strbuf_addstr(val, trailer + separator_pos + 1);
+		if (trailer[separator_pos + 1] == '@') {
+			ae = find_author_by_nickname(trailer + separator_pos + 2);
+			reset_revision_walk();
+			if (ae) {
+				strbuf_addstr(val, ae);
+				free((char*)ae);
+			} else
+				strbuf_addstr(val, trailer + separator_pos + 1);
+		} else
+			strbuf_addstr(val, trailer + separator_pos + 1);
 		strbuf_trim(val);
 	} else {
 		strbuf_addstr(tok, trailer);
-- 
gitgitgadget
