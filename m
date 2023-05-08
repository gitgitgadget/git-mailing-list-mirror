Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3618AC7EE26
	for <git@archiver.kernel.org>; Mon,  8 May 2023 22:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbjEHWAB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 18:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbjEHV7z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 17:59:55 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E8CE70
        for <git@vger.kernel.org>; Mon,  8 May 2023 14:59:54 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-55a5a830238so46493247b3.3
        for <git@vger.kernel.org>; Mon, 08 May 2023 14:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683583193; x=1686175193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VDtx3iqE2RZQuNCLKAySEpkN7cP3UMLjgoQpHks3AJY=;
        b=FaJpuR6pZNfm/ACv2/OO35hYdztb22m0HTC9LW+XQlvx2JLWYlziVJdRnyZ1YCmry+
         SMNVTcmfLPK0KgZYTPGPswDxx8Jbu4+paXkDAUmlp3QahbF+nHiI13vlbq1NQjvan0BG
         oahslJ+TkX5yoy3jGat8MJFkpAkgWDLpqBW+dUee3xt0hQ8xdlUao/a0zk81ra4npBV+
         4kPtHHx9AtvvdAx8fGN3UvdXtAIoR37KOldilg7Aok56lTzpk6GfUeTIGPjTjHL6xnTh
         aVNvMZo19S6aYFaB/xchVCsmS1KmCmBF0PYcJYTy85yqO0QvzfzppPdcEKaD4oBqbVFQ
         zMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683583193; x=1686175193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDtx3iqE2RZQuNCLKAySEpkN7cP3UMLjgoQpHks3AJY=;
        b=G4Nkzt3+Qdje1e0nqA9jKpo44+AOMQ9IhnZPGFhw7h0xj+OiamfcAHL+UHh9I+Eysx
         +Hf7PidRsPnnZOEs2DTV4+7Ol5J3SHiGYZIKcBs2DIRP4x2rT4iaSHhUbHNY32HNjyQ6
         VC6UnS8dH3qllt/14uvUaVlRgpDUE1VeN9sMdnsKY3aTZOUPHQRXrdG3cupkxXlsPakE
         fPPRgjQVSv6J/YOOUClXarda5j7y9K+OIaBLJNJ2g22VjEzF5zBEP9d/TuMu8kykLOM/
         izH/6Yjrxf/xMOD+cehtNytzbxKZ+RvJnKarzozTbjEiRjTg0RcI6Db2oqxqK3ybGAgV
         YFHw==
X-Gm-Message-State: AC+VfDzRN0A9SfVBZEV1aG8Wb12VxNbE7XWuG+7MuagyfuaAAYKudNrg
        yNdGRRyLSj6PovOqv6QL+Yjf3tcOhMj1upH9sniePQ==
X-Google-Smtp-Source: ACHHUZ43C7ZvBQGJYvLJeJ8V2MtRD/fH34TJ4EIQeNd0cz9wweKzhn6GgNFwEPWQPY8KSiH/QHq9CQ==
X-Received: by 2002:a81:5404:0:b0:55d:c333:26c4 with SMTP id i4-20020a815404000000b0055dc33326c4mr8236520ywb.0.1683583193387;
        Mon, 08 May 2023 14:59:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g142-20020a815294000000b0055d6b67f468sm2795753ywb.14.2023.05.08.14.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 14:59:53 -0700 (PDT)
Date:   Mon, 8 May 2023 17:59:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 04/15] ref-filter: add ref_filter_clear()
Message-ID: <c804ba3620476713bd0535a315876378149ad7dd.1683581621.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1683581621.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

We did not bother to clean up at all in branch/tag, and for-each-ref
only hit a few elements. So this is probably cleaning up leaks, but I
didn't check yet.

Note that the reachable_from and unreachable_from lists should be
cleaned as they are used. So this is just covering any case where we
might bail before running the reachability check.
---
 builtin/branch.c       |  1 +
 builtin/for-each-ref.c |  3 +--
 builtin/tag.c          |  1 +
 ref-filter.c           | 16 ++++++++++++++++
 ref-filter.h           |  3 +++
 5 files changed, 22 insertions(+), 2 deletions(-)

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
index b1d5022a51..9ea92b9637 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2864,3 +2864,19 @@ int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
 
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
-- 
2.40.1.477.g956c797dfc

