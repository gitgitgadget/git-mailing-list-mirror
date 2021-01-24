Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEDFC433E0
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 02:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B9D822C7C
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 02:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbhAXCfW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 21:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbhAXCfS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 21:35:18 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46EBC061786
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 18:34:37 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 127so10242060ybn.5
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 18:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=qGrcsnbMq9etB26uWF+H0pfkFEtafEwsttDBXCGjtuo=;
        b=HGpAi26j3oHbwJbdgcq+pPgYQq86m4xDzqLpwIAtfthLthfWY6pHaWM0oSP4Fwqwcb
         cJsovzootVosAzl2lo3SmS1GuXdggPXwLiKIDDF4+OwCN2GDUuwkpZRkR4LtaO0lghwY
         sMJeOwpBADBUMuYGO4r6SU6XzqDe/U+PaeCXvMP10zaCFszD0r/vBEQmsUBm815ks7Tq
         DkuIsAWfXytoF7bc104m+sYVqiRMEkx2OmTLZEyc8Mp2bOYrl2I7lIa/sELdaZclYiID
         Krk7yo8U/C4SlQtZXR30dgoqNZsJx/Te+ECHkaNrGHx2lmK2Eut8JjxpvcNyDOrygTy+
         zx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qGrcsnbMq9etB26uWF+H0pfkFEtafEwsttDBXCGjtuo=;
        b=Cz/KO0YfU5eOrVDlU/bqEcUpEyUCUzjyjwEn/u43pa9A0SM2530c0nVSTQP+LlHZLO
         zBDP9cFaX+ZhVGhg4e8FhL0XHlhhQpBJEMmaOnNx8npUufYpJQJuDIiB+vXvW/bAU+3r
         6BNpGYRFt6btYg5dSiz5ioMTZKoYN44qHlpp+dXsv3JMjuvPCK1LhFmfyCgpzbf1RdCZ
         yp1VlUwtX1816+SJQ/UbYK0GtaCM5Ll9Ed0hICtnTdz/brEcy12MXNbkKZ5aY/tQVBf1
         aYx71DOw0dQeQcXGNbklWEKacl8xB0ka7icdqpvd0BFJgtIqqT1IUbbkTifeFWLDob8M
         Sufg==
X-Gm-Message-State: AOAM530k8Q4x7SRNUEm/0MJtXmpXS88UikrofZq5JMsDYmWzAd1+livy
        PBi+H/XOxQMr6T3XQlbukiHISDSgHcb23RCfSp3Q+e6SB8Dub8l4TWNUuVXrC0er8t3h7jYGnXM
        FhOyFh1KRdmrDvU4SIxt8vRlC2fijJxvx8c/AZIraDDQ1xettWB0I0LeCOu9v1JYav25Z8NeHF+
        i/
X-Google-Smtp-Source: ABdhPJy99+X0s7+g+gNgW3LbmWnnArVR7pSdVSTdU03B0u8WbeMp3TrAiucIjY2pQCXAQGKlTOxlT7bZ3iyLLtef0CVt
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:7b82:: with SMTP id
 w124mr15350851ybc.492.1611455676832; Sat, 23 Jan 2021 18:34:36 -0800 (PST)
Date:   Sat, 23 Jan 2021 18:34:27 -0800
In-Reply-To: <cover.1611455251.git.jonathantanmy@google.com>
Message-Id: <e5d84a2d946f2770cc2034a100e741607faf62ee.1611455251.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20210115234300.350442-1-jonathantanmy@google.com> <cover.1611455251.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH 1/4] http: allow custom index-pack args
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
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
2.30.0.280.ga3ce27912f-goog

