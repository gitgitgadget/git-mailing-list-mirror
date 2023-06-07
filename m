Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAD8C77B7A
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 10:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbjFGKlT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 06:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239522AbjFGKlO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 06:41:14 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9FB1BDA
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 03:41:12 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-bacfb7acdb7so8670489276.0
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 03:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1686134472; x=1688726472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YHfcvs8EUcosgL3leePNnuehqaeKMvNIAHrpFnBigo4=;
        b=YiudMEcOaK10ZZUCI7qK+x65kcAG7ev8RsYWxUdkKt8icVfn6PbwjNAQOwrazpzG9I
         uQxLk2ETclON2sZGSNgjfi6VIUmgOQHey/nbLMqIfrHd9XSucjSzBEekcKOXk3Xo9tz8
         7Obwd3p4VAxm4/2XOBksIVlsIiE3fZ3LWNCRgL+nOiCRzYDIJPvijNPsKYQkRMsYcWmm
         hPSvwcP9bcZcVclweq4tPpywbHLgCBSo7JCD+RTZk6CshD+i8VmzOlTh0J8dPmqTf1v1
         37v+LMYrSMGJbp6smGY8DcAfhenzdQM0jtidiPHvHQUmHg9C/lOtEwvRaVEAeWssVhjT
         JKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686134472; x=1688726472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHfcvs8EUcosgL3leePNnuehqaeKMvNIAHrpFnBigo4=;
        b=RRtu9rpY+c9t7w429yzDuzbriNeHminS69PrNBweBW1+Ivo3x/MNtS/Mf3lCPalftz
         +m51x56hYmS12gnQqUVSOLSwEuRSTXISzbVGBsuDyTjozQeQG7pWWPgQ/848by4qI7WR
         u4Q0qqqYB7wlak8sdqBnK5CGTfdVEZsST2jsccq+JSMLLr7V7dY2f6xCZcn5i0VwBY/x
         iDg+bh6PnWbDZUeP/ia/Ga3tp6RiyV2Ye0bQrk94sXXbI8VGqAn28Hb2F8yzegEgI2Ne
         hWPYeEbeeqrrsD4ATveLFfgZyccHjnE1RSVeTau2XNoX6lz9m7LiXe6CZQMgruuakL3t
         0V7A==
X-Gm-Message-State: AC+VfDxWt/ag/FZEsiX/bBpYF7Cvnl/oAbqLX8rgJSn6hLbnIgTJTULt
        gd0KSFC6ornDOKu5HLLhx+l23BbYI81y36AA8ETIykA0
X-Google-Smtp-Source: ACHHUZ74hQ3EbmUv+6oXgET+N/3O4Udf/gW6+PbB1WVdWiCrHBdW1khcQKqFlo4p3H7L5f0LjRjw8Q==
X-Received: by 2002:a25:d7c5:0:b0:b9e:d97:e34b with SMTP id o188-20020a25d7c5000000b00b9e0d97e34bmr5693325ybg.50.1686134471431;
        Wed, 07 Jun 2023 03:41:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k84-20020a252457000000b00bb131cd635bsm3798851ybk.8.2023.06.07.03.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:41:11 -0700 (PDT)
Date:   Wed, 7 Jun 2023 06:41:08 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 04/16] ref-filter: add `ref_filter_clear()`
Message-ID: <bc5356fe4b368ddd6e100341707ddcc75979af75.1686134440.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1686134440.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1686134440.git.me@ttaylorr.com>
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
index 6b41bb7374..aab5e693fe 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -645,6 +645,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
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
2.41.0.16.g26cd413590

