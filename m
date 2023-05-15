Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AC7C77B7D
	for <git@archiver.kernel.org>; Mon, 15 May 2023 19:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245083AbjEOTXd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 15:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245015AbjEOTX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 15:23:28 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE77914E70
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:23:21 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-ba7ed900ac4so922551276.0
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684178601; x=1686770601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yDzw/Zl0GNt1WZwh5Kd8MvJSroAqJ6M4H+sxaNmDvxg=;
        b=A4PwbgbYSdhJi+gLZalKkInJHkfpWZJrRT1iYbcHbCmm0Abh1VXQx8RoiMGdbl1ZRi
         lCX34PD70T80aOqYnvYOP3dVpDzKi0vZTKHldLpZ61cPAElgX7g99JDI778+Hgj3+EQu
         9xD2bGZ7/lWGm6Dy1n2mZRZf6Do0FMUnKoV0dGT8HCQS6zN/2ynHl0n839+kmKeOh2NM
         WqjhH5s3nY+WIDi+jJmq3djPJSj8EXPQO4e4BOGhE6LMpsb/3kllabfNWp/dojkYBfVX
         1W05RfJ1ErYCang3l2zkwiSaKGqie+gbjXrrz9qYtkitapStJpqztT4ZQGYee5G43snD
         qAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684178601; x=1686770601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDzw/Zl0GNt1WZwh5Kd8MvJSroAqJ6M4H+sxaNmDvxg=;
        b=fJjmRRDKxkVmUeiBPbxCJkBWPTGcjSZ1GWTC4BKy7TDlo77L1VaAiQhZRuqGMVsjPB
         ETA4pN4ibW+hvb2eplRtBK4pPjDC3xur7e3mUzvhtQs6uyx5Ksa2ZM/nFPSW6nwwHmEx
         hUhwmWWcb00eHD6OfuE/ZpTNJ12Ud95V30DLHNGOL4xMjSmpIQRPapuXLNbzt3ubNvhR
         6CDfDaMEyKGiZz1nDnNBRjYwgy72s1iO1sFXm9P/sjjqHow4BLuI9Tjo7at9SeMQrJcs
         VB8s73GIglVBZgSmQiuMa+W7tojISRnYHGs1+BA9kEMOsGo1FMxhe03yArqDjnI1kKBM
         Zl7g==
X-Gm-Message-State: AC+VfDwZnBDnjZhZLL7KT1L+nBTCE9PAC3BKj8TzuqGO3z+hs5gtM/3U
        ZuBUs+Gxaic8b0lOjZQ3AEUPcZ91/HC4AQPQwltiEg==
X-Google-Smtp-Source: ACHHUZ58DDN9HZMjEDtqCrrGgeU14VP0HeRM75xVzOly/224BQ6F1G6klG379sDM+QDcnEaxBr6swg==
X-Received: by 2002:a25:b28f:0:b0:ba6:bc78:a3fd with SMTP id k15-20020a25b28f000000b00ba6bc78a3fdmr11155503ybj.20.1684178600991;
        Mon, 15 May 2023 12:23:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j10-20020a5b030a000000b00b9d8612a8bbsm27428ybp.16.2023.05.15.12.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 12:23:20 -0700 (PDT)
Date:   Mon, 15 May 2023 15:23:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 04/16] ref-filter: add `ref_filter_clear()`
Message-ID: <85ecb70957d27911adc6d7a36dd08ba435684528.1684178576.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1684178576.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1684178576.git.me@ttaylorr.com>
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
index 03bb8e414c..c201f0cb0b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -813,6 +813,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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
2.40.1.572.g5c4ab523ef

