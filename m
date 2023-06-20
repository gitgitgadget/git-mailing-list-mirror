Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB3AEB64D8
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 14:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjFTOVb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 10:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbjFTOV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 10:21:26 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CB010F1
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 07:21:20 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b57d9043e4so1716024a34.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 07:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687270880; x=1689862880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kxM0aZJdagtjyfruXnXrIVbRCIB416vf0fjFupbmNEw=;
        b=083tgU9/6Yu0Yv5O98iKTzXbSEMyfTGPcblSDpc3LY/qJZzbdlJJsCWJh/c58cuIXc
         BOrKW/lLVn98a9p+VTU0kQcf2SiFMOX1+YEP35uv7X5+fXFzyo2ojapZyLis6G9oTkV8
         aRePgipMu6hTGrEWguMAHeceRONm5p3GXDJljUxE4BeITTDANFTHZ9LI03MfWvmBeGuA
         30wVYvqmo4MFyEsXlid29lkeeplFtbLML3QVat4agtWh1ZhgDJFJ0FpUuDHfEjX585E8
         eaEcxSNeeJjuUeGHVu+91Vh4KZQBUz2OYwXhxJsMWUrh4FoeYAFQ9LYHNrvms56YlTWF
         3xUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687270880; x=1689862880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxM0aZJdagtjyfruXnXrIVbRCIB416vf0fjFupbmNEw=;
        b=E1JxZZSgm22WXAZOfWBqc/Csa6whTB0aOlQpZxrj2zmcBDzPbebDhP3I4F+xygejb7
         SLk2V4gRQz6CxtTi4XjXfUGw6buyJM43baV6rua4YtoSEt6q/u0WZnSLa94C2grbdfSx
         YCvmDYhpLN7BeLCiqchpVxeczOZgvkUGC/z1ziW6r5Vy7fYiEpPvychNH+PNKn7lOoy6
         pk/3sNhGQN52vYLLXqsdgkZjflgGFJYqmmpbstAr81Sm8lzCxJi0Q+3r24uFEk/BYuN+
         V1b5i3RbfuG1Vbb5rlX+ez5LvrtxcDPGr1hvHEN0Kmk6JuuaApzuCCh4ATaxjBz/wwBo
         pRsA==
X-Gm-Message-State: AC+VfDw9VyZG8scLs/J8DHbQQ+nCW+rzvcqYSWc/MMZIzet6AbDjkECu
        ke2RDHLZpnEFA+vbi0z9YMdyMIAFz7lUhmuNJJxaSL/D
X-Google-Smtp-Source: ACHHUZ6a18vwUNBmHRd5P8u0eX7NqQI1+mM8vX3KeQq3REzUlY6a80n0s2wGw4vY0Kg1+lFq/k/UVg==
X-Received: by 2002:a05:6358:e9e:b0:12f:1f27:7ac3 with SMTP id 30-20020a0563580e9e00b0012f1f277ac3mr6012948rwg.0.1687270879648;
        Tue, 20 Jun 2023 07:21:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t132-20020a81468a000000b00565cf40238csm508560ywa.110.2023.06.20.07.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 07:21:19 -0700 (PDT)
Date:   Tue, 20 Jun 2023 10:21:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 04/16] ref-filter: add `ref_filter_clear()`
Message-ID: <777e71004d68dc9bb9c4cad2b896acff2c615cbf.1687270849.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1687270849.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

We did not bother to clean up at all in `git branch` or `git tag`, and
`git for-each-ref` only cleans up a couple of members.

Add and call `ref_filter_clear()` when cleaning up a `struct
ref_filter`. Running this patch (without any test changes) indicates a
couple of now leak-free tests. This was found by running:

    $ make SANITIZE=leak
    $ make -C t GIT_TEST_PASSING_SANITIZE_LEAK=check GIT_TEST_OPTS=--immediate

(Note that the `reachable_from` and `unreachable_from` lists should be
cleaned as they are used. So this is just covering any case where we
might bail before running the reachability check.)

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/branch.c        |  1 +
 builtin/for-each-ref.c  |  3 +--
 builtin/tag.c           |  1 +
 ref-filter.c            | 16 ++++++++++++++++
 ref-filter.h            |  3 +++
 t/t0041-usage.sh        |  1 +
 t/t3402-rebase-merge.sh |  1 +
 7 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 7891dec361..07ee874617 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -858,6 +858,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		print_columns(&output, colopts, NULL);
 		string_list_clear(&output, 0);
 		ref_sorting_release(sorting);
+		ref_filter_clear(&filter);
 		return 0;
 	} else if (edit_description) {
 		const char *branch_name;
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 99ccb73518..c01fa6fefe 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -120,8 +120,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	strbuf_release(&err);
 	strbuf_release(&output);
 	ref_array_clear(&array);
-	free_commit_list(filter.with_commit);
-	free_commit_list(filter.no_commit);
+	ref_filter_clear(&filter);
 	ref_sorting_release(sorting);
 	strvec_clear(&vec);
 	return 0;
diff --git a/builtin/tag.c b/builtin/tag.c
index ec778ba860..2895ff0e45 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -651,6 +651,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 cleanup:
 	ref_sorting_release(sorting);
+	ref_filter_clear(&filter);
 	strbuf_release(&buf);
 	strbuf_release(&ref);
 	strbuf_release(&reflog_msg);
diff --git a/ref-filter.c b/ref-filter.c
index 048d277cbf..d32f426898 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2866,3 +2866,19 @@ int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
 
 	return 0;
 }
+
+void ref_filter_init(struct ref_filter *filter)
+{
+	struct ref_filter blank = REF_FILTER_INIT;
+	memcpy(filter, &blank, sizeof(blank));
+}
+
+void ref_filter_clear(struct ref_filter *filter)
+{
+	oid_array_clear(&filter->points_at);
+	free_commit_list(filter->with_commit);
+	free_commit_list(filter->no_commit);
+	free_commit_list(filter->reachable_from);
+	free_commit_list(filter->unreachable_from);
+	ref_filter_init(filter);
+}
diff --git a/ref-filter.h b/ref-filter.h
index a920f73b29..160b807224 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -170,4 +170,7 @@ void filter_ahead_behind(struct repository *r,
 			 struct ref_format *format,
 			 struct ref_array *array);
 
+void ref_filter_init(struct ref_filter *filter);
+void ref_filter_clear(struct ref_filter *filter);
+
 #endif /*  REF_FILTER_H  */
diff --git a/t/t0041-usage.sh b/t/t0041-usage.sh
index c4fc34eb18..9ea974b0c6 100755
--- a/t/t0041-usage.sh
+++ b/t/t0041-usage.sh
@@ -5,6 +5,7 @@ test_description='Test commands behavior when given invalid argument value'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup ' '
diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index 79b0640c00..e9e03ca4b5 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -8,6 +8,7 @@ test_description='git rebase --merge test'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 T="A quick brown fox
-- 
2.41.0.44.gf2359540d2

