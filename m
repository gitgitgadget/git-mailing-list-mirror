Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA93AC433E0
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 19:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97D5A64E15
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 19:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhBVTZg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 14:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbhBVTU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 14:20:57 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9943C061797
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 11:20:15 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id s18so7808172pfe.10
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 11:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=vfKfOGTi+pc7bqsX5Z/70a0qR04Cc4O6Wnb9CLDZLOM=;
        b=WsSm+ceU4ksyen5b33ELJ9/x83C7VssAHxfMSTBrdIeXYaYdNRTVSUxD4ezO65A7eW
         Fi0Rc++WlFgU7GcBI387fn7smNqYYU9rCz47T969CLgw6Zhpjvic4+dsYqfrsSRQn+QW
         fAHqSgdk4HYC7JEG0d/nCkWPk/8y/8nDzCnu67niOGwDB0hL1JuzFLByeiIqrEEM3jJc
         j80YxdgS3hJ8wiCdOvHLF+9DIE9TVGzeWBHdK59T2UQnAa86L4ahfSSaOefFvL3orWhQ
         DDVegBzqs/zS7idaeSJdRULWv1rETQByo7FC8WlWcIyY5qMNM7hNcDowEuEu2ZYXfAhE
         Ll1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vfKfOGTi+pc7bqsX5Z/70a0qR04Cc4O6Wnb9CLDZLOM=;
        b=l5RxL93A9R0AbynaQY2L1kz6lzhtFsJbkcFprItH8c6A95PtBOVV4Mu0/RywFfCTyi
         xe3vXzaxe0HzGPJilKyaIMOS8bvGLFlfh4BY1aZQX2OhtC0Pc/odCiSVoU9kKG2BY6JF
         X+bttr0m+RN/mzPydaLH2cGnLsImLvhvtyDVOoXY4ldk7FKGuNBBe04It9hpI7KtCm5b
         3HR6OqIvonfJh1D6+kuqYRy68xIGaXA5YlyoY1eXTVWQ4r65R/a46gp8v1r2ravYOKMC
         s349f880jxuhIJ1oTg7fCXuLH21g7H/+qZIDlVffj/eH0+SMHkz01tn2+On7439/BBkd
         +LFA==
X-Gm-Message-State: AOAM5319f+UCIFEvWIjFk5eVSCgMaN/KLwcaI33XDzhQXeEDsjjwsfLP
        nJRwl9SBsT7uxF6BekndGQKu+DPiMUhOJKt7uqrtRNTo5QuPJ2h1qO9pIKrQ+QPlaDFHVUsHSqq
        vfKHMXU/X4H1mTUzQmzBdHSIZUHCP/pTVQ75X3umgnl9QFsyYFwabrkT3SRm4YyjA8uXqpmECWR
        JB
X-Google-Smtp-Source: ABdhPJxnGm8vPumLDuNcFEVdkNSn8+JCHmY7OY1olv7xtGyV8uRQ5m4Pn1xtvqyBunM3h3aRmtzwbeJ+4o9z7l29EkA/
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:8d8e:0:b029:1d1:f9c9:cff6 with
 SMTP id i14-20020aa78d8e0000b02901d1f9c9cff6mr23713478pfr.31.1614021615062;
 Mon, 22 Feb 2021 11:20:15 -0800 (PST)
Date:   Mon, 22 Feb 2021 11:20:06 -0800
In-Reply-To: <cover.1614021092.git.jonathantanmy@google.com>
Message-Id: <b7e376be160a569e25405153c6d0f21fa28ca03a.1614021093.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20210115234300.350442-1-jonathantanmy@google.com> <cover.1614021092.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH v2 1/4] http: allow custom index-pack args
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, when fetching, packfiles referenced by URIs are run through
index-pack without any arguments other than --stdin and --keep, no
matter what arguments are used for the packfile that is inline in the
fetch response. As a preparation for ensuring that all packs (whether
inline or not) use the same index-pack arguments, teach the http
subsystem to allow custom index-pack arguments.

http-fetch has been updated to use the new API. For now, it passes
--keep alone instead of --keep with a process ID, but this is only
temporary because http-fetch itself will be taught to accept index-pack
parameters (instead of using a hardcoded constant) in a subsequent
commit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http-fetch.c |  6 +++++-
 http.c       | 15 ++++++++-------
 http.h       | 10 +++++-----
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index c4ccc5fea9..2d1d9d054f 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -43,6 +43,9 @@ static int fetch_using_walker(const char *raw_url, int get_verbosely,
 	return rc;
 }
 
+static const char *index_pack_args[] =
+	{"index-pack", "--stdin", "--keep", NULL};
+
 static void fetch_single_packfile(struct object_id *packfile_hash,
 				  const char *url) {
 	struct http_pack_request *preq;
@@ -55,7 +58,8 @@ static void fetch_single_packfile(struct object_id *packfile_hash,
 	if (preq == NULL)
 		die("couldn't create http pack request");
 	preq->slot->results = &results;
-	preq->generate_keep = 1;
+	preq->index_pack_args = index_pack_args;
+	preq->preserve_index_pack_stdout = 1;
 
 	if (start_active_slot(preq->slot)) {
 		run_active_slot(preq->slot);
diff --git a/http.c b/http.c
index 8b23a546af..f8ea28bb2e 100644
--- a/http.c
+++ b/http.c
@@ -2259,6 +2259,9 @@ void release_http_pack_request(struct http_pack_request *preq)
 	free(preq);
 }
 
+static const char *default_index_pack_args[] =
+	{"index-pack", "--stdin", NULL};
+
 int finish_http_pack_request(struct http_pack_request *preq)
 {
 	struct child_process ip = CHILD_PROCESS_INIT;
@@ -2270,17 +2273,15 @@ int finish_http_pack_request(struct http_pack_request *preq)
 
 	tmpfile_fd = xopen(preq->tmpfile.buf, O_RDONLY);
 
-	strvec_push(&ip.args, "index-pack");
-	strvec_push(&ip.args, "--stdin");
 	ip.git_cmd = 1;
 	ip.in = tmpfile_fd;
-	if (preq->generate_keep) {
-		strvec_pushf(&ip.args, "--keep=git %"PRIuMAX,
-			     (uintmax_t)getpid());
+	ip.argv = preq->index_pack_args ? preq->index_pack_args
+					: default_index_pack_args;
+
+	if (preq->preserve_index_pack_stdout)
 		ip.out = 0;
-	} else {
+	else
 		ip.no_stdout = 1;
-	}
 
 	if (run_command(&ip)) {
 		ret = -1;
diff --git a/http.h b/http.h
index 5de792ef3f..bf3d1270ad 100644
--- a/http.h
+++ b/http.h
@@ -218,12 +218,12 @@ struct http_pack_request {
 	char *url;
 
 	/*
-	 * If this is true, finish_http_pack_request() will pass "--keep" to
-	 * index-pack, resulting in the creation of a keep file, and will not
-	 * suppress its stdout (that is, the "keep\t<hash>\n" line will be
-	 * printed to stdout).
+	 * index-pack command to run. Must be terminated by NULL.
+	 *
+	 * If NULL, defaults to	{"index-pack", "--stdin", NULL}.
 	 */
-	unsigned generate_keep : 1;
+	const char **index_pack_args;
+	unsigned preserve_index_pack_stdout : 1;
 
 	FILE *packfile;
 	struct strbuf tmpfile;
-- 
2.30.0.617.g56c4b15f3c-goog

