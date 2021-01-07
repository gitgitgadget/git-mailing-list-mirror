Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E3BC433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 09:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7CC3217A0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 09:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbhAGJxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 04:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbhAGJxd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 04:53:33 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6163C0612FB
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 01:52:20 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id c5so4988016wrp.6
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 01:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GonbIgr+r1tEu6ealZvgbWAxDh54fAMjlnZ104lc/wI=;
        b=ImH+7Of0i7/w7yhDKTaGgopO3mHKyOT2dAkfVhOa8WAG1d9McFNlWftJgzKzTjOwdA
         3RXKN49AmLBkAzdvBXopWG8eRWlLPacGNUjB+L9EPBjAsiHh21P21wMCCKa8AmcViDc0
         G1wdjJUfopA6c8gQ7r8WU/OB7GRsyysrXOk9rzUWyWvex440RtoaWjicjTN+6EOiwdXG
         fQHtFXZ1Jcj1X+T18tXRy7gbN3EQPU1y3YEcSuVkYXfhFhH8Iv4x15cT09Lyj6lC1B8M
         PUgb0DmEn3iDTEh1ywFV1knWJ/F7FUeYzvyt8EM5E09XDInnfu4SqUA19+THmIdPGpPM
         jhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GonbIgr+r1tEu6ealZvgbWAxDh54fAMjlnZ104lc/wI=;
        b=SygpZBQCb/Vr9O+64mvD1x7WXizuCY6D0PV++nr1gqJ+BHWvrKsW4MeXVK6nDlu6YO
         b06nqq03L5Hku3QPv0Ajgtwf6dhFaDRvtIsFxvP0FuU6hMpTnyq7o6FQUoZRNY1eIwPd
         jqrMEu2/24Z6SBOoRlc7CtNLylYWJKoNRJQSgNRTr03+jzF8jYrhaZV+bBE2ehghs7Sq
         rOPYWytiuaZyvi59evi+ISstpesR7JxntfXrhnsZQnfHKz2JP0kIYD+0lH11sGbUKpBZ
         RCTo9MTlGNtSmKfRBU5JqGMYRfZo9ylOdXj6JBCTIW9rSKla0/zyd5GVISzzkhP/JXjB
         LPcA==
X-Gm-Message-State: AOAM531k7X3+IR9lQsyQyBAfGjMzWuy3Ljk1jirDpaeje7LVMw+KH8R/
        8eCE/lbWOZh19o9LHJhTWIe9NP5gDTeJrQ==
X-Google-Smtp-Source: ABdhPJzLl8MelOBbM/gIOtZFySrfaFCpKBN6M3zOmD8pFEqepUfwOkdms/FMhnYq0VKKJ3SXRxjIJw==
X-Received: by 2002:adf:a551:: with SMTP id j17mr8062123wrb.217.1610013139256;
        Thu, 07 Jan 2021 01:52:19 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k10sm6806535wrq.38.2021.01.07.01.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 01:52:17 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthew DeVore <matvore@google.com>, git@matthieu-moy.fr,
        olyatelezhnaya@gmail.com, samuel.maftoul@gmail.com,
        Johannes.Schindelin@gmx.de, karthik.188@gmail.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        emilyshaffer@google.com, jrnieder@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/7] branch: sort detached HEAD based on a flag
Date:   Thu,  7 Jan 2021 10:51:52 +0100
Message-Id: <20210107095153.4753-7-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210106100139.14651-1-avarab@gmail.com>
References: <20210106100139.14651-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the ref-filter sorting of detached HEAD to check the
FILTER_REFS_DETACHED_HEAD flag, instead of relying on the ref
description filled-in by get_head_description() to start with "(",
which in turn we expect to ASCII-sort before any other reference.

For context, we'd like the detached line to appear first at the start
of "git branch -l", e.g.:

    $ git branch -l
    * (HEAD detached at <hash>)
      master

This doesn't change that, but improves on a fix made in
28438e84e04 (ref-filter: sort detached HEAD lines firstly, 2019-06-18)
and gives the Chinese translation the ability to use its preferred
punctuation marks again.

In Chinese the fullwidth versions of punctuation like "()" are
typically written as (U+FF08 fullwidth left parenthesis), (U+FF09
fullwidth right parenthesis) instead[1]. This form is used in both
po/zh_{CN,TW}.po in most cases where "()" is translated in a string.

Aside from that improvement to the Chinese translation, it also just
makes for cleaner code that we mark any special cases in the ref_array
we're sorting with flags and make the sort function aware of them,
instead of piggy-backing on the general-case of strcmp() doing the
right thing.

As seen in the amended tests this made reverse sorting a bit more
consistent. Before this we'd sometimes sort this message in the
middle, now it's consistently at the beginning or end, depending on
whether we're doing a normal or reverse sort. Having it at the end
doesn't make much sense either, but at least it behaves consistently
now. A follow-up commit will make this behavior under reverse sorting
even better.

I'm removing the "TRANSLATORS" comments that were in the old code
while I'm at it. Those were added in d4919bb288e (ref-filter: move
get_head_description() from branch.c, 2017-01-10). I think it's
obvious from context, string and translation memory in typical
translation tools that these are the same or similar string.

1. https://en.wikipedia.org/wiki/Chinese_punctuation#Marks_similar_to_European_punctuation

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/branch.c         |  2 ++
 ref-filter.c             | 44 +++++++++++++++++++++++-----------------
 ref-filter.h             |  1 +
 t/t3203-branch-output.sh |  4 ++--
 wt-status.c              |  4 ++--
 wt-status.h              |  2 --
 6 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 2dd51a8653b..8c0b428104d 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -740,6 +740,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!sorting)
 			sorting = ref_default_sorting();
 		ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
+		ref_sorting_set_sort_flags_all(
+			sorting, REF_SORTING_DETACHED_HEAD_FIRST, 1);
 		print_ref_list(&filter, sorting, &format);
 		print_columns(&output, colopts, NULL);
 		string_list_clear(&output, 0);
diff --git a/ref-filter.c b/ref-filter.c
index fe587afb80b..8d0739b9972 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1536,36 +1536,27 @@ char *get_head_description(void)
 	struct wt_status_state state;
 	memset(&state, 0, sizeof(state));
 	wt_status_get_state(the_repository, &state, 1);
-
-	/*
-	 * The ( character must be hard-coded and not part of a localizable
-	 * string, since the description is used as a sort key and compared
-	 * with ref names.
-	 */
-	strbuf_addch(&desc, '(');
 	if (state.rebase_in_progress ||
 	    state.rebase_interactive_in_progress) {
 		if (state.branch)
-			strbuf_addf(&desc, _("no branch, rebasing %s"),
+			strbuf_addf(&desc, _("(no branch, rebasing %s)"),
 				    state.branch);
 		else
-			strbuf_addf(&desc, _("no branch, rebasing detached HEAD %s"),
+			strbuf_addf(&desc, _("(no branch, rebasing detached HEAD %s)"),
 				    state.detached_from);
 	} else if (state.bisect_in_progress)
-		strbuf_addf(&desc, _("no branch, bisect started on %s"),
+		strbuf_addf(&desc, _("(no branch, bisect started on %s)"),
 			    state.branch);
 	else if (state.detached_from) {
 		if (state.detached_at)
-			strbuf_addstr(&desc, HEAD_DETACHED_AT);
+			strbuf_addf(&desc, _("(HEAD detached at %s)"),
+				state.detached_from);
 		else
-			strbuf_addstr(&desc, HEAD_DETACHED_FROM);
-		strbuf_addstr(&desc, state.detached_from);
-	}
-	else
-		strbuf_addstr(&desc, _("no branch"));
-	strbuf_addch(&desc, ')');
+			strbuf_addf(&desc, _("(HEAD detached from %s)"),
+				state.detached_from);
+	} else
+		strbuf_addstr(&desc, _("(no branch)"));
 
-	wt_status_state_free_buffers(&state);
 	return strbuf_detach(&desc, NULL);
 }
 
@@ -2350,6 +2341,18 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 	return ret;
 }
 
+static int compare_detached_head(struct ref_array_item *a, struct ref_array_item *b)
+{
+	if (!(a->kind ^ b->kind))
+		BUG("ref_kind_from_refname() should only mark one ref as HEAD");
+	if (a->kind & FILTER_REFS_DETACHED_HEAD)
+		return -1;
+	else if (b->kind & FILTER_REFS_DETACHED_HEAD)
+		return 1;
+	BUG("should have died in the xor check above");
+	return 0;
+}
+
 static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, struct ref_array_item *b)
 {
 	struct atom_value *va, *vb;
@@ -2362,7 +2365,10 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 	if (get_ref_atom_value(b, s->atom, &vb, &err))
 		die("%s", err.buf);
 	strbuf_release(&err);
-	if (s->sort_flags & REF_SORTING_VERSION) {
+	if (s->sort_flags & REF_SORTING_DETACHED_HEAD_FIRST &&
+	    ((a->kind | b->kind) & FILTER_REFS_DETACHED_HEAD)) {
+		cmp = compare_detached_head(a, b);
+	} else if (s->sort_flags & REF_SORTING_VERSION) {
 		cmp = versioncmp(va->s, vb->s);
 	} else if (cmp_type == FIELD_STR) {
 		int (*cmp_fn)(const char *, const char *);
diff --git a/ref-filter.h b/ref-filter.h
index 6296ae8bb27..19ea4c41340 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -32,6 +32,7 @@ struct ref_sorting {
 		REF_SORTING_REVERSE = 1<<0,
 		REF_SORTING_ICASE = 1<<1,
 		REF_SORTING_VERSION = 1<<2,
+		REF_SORTING_DETACHED_HEAD_FIRST = 1<<3,
 	} sort_flags;
 };
 
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index f92fb3aab9d..8f53b081365 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -223,8 +223,8 @@ test_expect_success 'git branch `--sort=[-]objectsize` option' '
 	cat >expect <<-\EOF &&
 	  branch-one
 	  main
-	* (HEAD detached from fromtag)
 	  branch-two
+	* (HEAD detached from fromtag)
 	EOF
 	git branch --sort=-objectsize >actual &&
 	test_i18ncmp expect actual
@@ -241,10 +241,10 @@ test_expect_success 'git branch `--sort=[-]type` option' '
 	test_i18ncmp expect actual &&
 
 	cat >expect <<-\EOF &&
-	* (HEAD detached from fromtag)
 	  branch-one
 	  branch-two
 	  main
+	* (HEAD detached from fromtag)
 	EOF
 	git branch --sort=-type >actual &&
 	test_i18ncmp expect actual
diff --git a/wt-status.c b/wt-status.c
index 7074bbdd53c..40b59be478c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1742,9 +1742,9 @@ static void wt_longstatus_print(struct wt_status *s)
 			} else if (s->state.detached_from) {
 				branch_name = s->state.detached_from;
 				if (s->state.detached_at)
-					on_what = HEAD_DETACHED_AT;
+					on_what = _("HEAD detached at ");
 				else
-					on_what = HEAD_DETACHED_FROM;
+					on_what = _("HEAD detached from ");
 			} else {
 				branch_name = "";
 				on_what = _("Not currently on any branch.");
diff --git a/wt-status.h b/wt-status.h
index 35b44c388ed..0d32799b28e 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -77,8 +77,6 @@ enum wt_status_format {
 	STATUS_FORMAT_UNSPECIFIED
 };
 
-#define HEAD_DETACHED_AT _("HEAD detached at ")
-#define HEAD_DETACHED_FROM _("HEAD detached from ")
 #define SPARSE_CHECKOUT_DISABLED -1
 
 struct wt_status_state {
-- 
2.29.2.222.g5d2a92d10f8

