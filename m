Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832E8C433E1
	for <git@archiver.kernel.org>; Fri, 29 May 2020 22:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58E5F207BC
	for <git@archiver.kernel.org>; Fri, 29 May 2020 22:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UQAy7RAd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgE2Waj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 18:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgE2Wah (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 18:30:37 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32A0C03E969
        for <git@vger.kernel.org>; Fri, 29 May 2020 15:30:35 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id k35so3509695qva.18
        for <git@vger.kernel.org>; Fri, 29 May 2020 15:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QCYckzNzK5i+fZTw25Hd9a5OrW3Hwbmx//2aNeQEKXY=;
        b=UQAy7RAdy+j/+Yv25OGDtzIAHkyplfRCUvGwqpZPyrDbieVaytcLOhSsc726n3QIZp
         8at8oaD15oxIPAX88IUE/mfbdB20mX0ocPyOgbTck7t20PcJymJMZimrPhzcaopif9Ke
         n7otYfCIw1iz1ssgszS2EuQgxCjCgyTVNiPUFQhtu7YrtBfQe3sUMHp/8CBjdu/ULKoT
         MREEbdcgsSGnMhl2lNo3LcmmxkgEi50Yv11c1xP2OOU7qD5ng+elqm4cCfxkj/v38Cyw
         4dLGqovKH/Sm+zT0fVvvHWtxa2rBeiSlTcr74jpoGlUnuy3J6PStU9MZ0+c5rfUUycSl
         cHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QCYckzNzK5i+fZTw25Hd9a5OrW3Hwbmx//2aNeQEKXY=;
        b=Y6l0eNvpDBiy97iW9kDx8O4302H856lJRTQkV4Q9+zpS+L8dc7rcScaR/wtmmydryn
         69Dn+MasTNRZ7Sp8oGv5GnF8ZzDwuYsnd//5gsc0YSnPstQGjGWZ4ANPAFEX03kLtq6z
         5Cu8sprlpOPheYDIfDJ31raO2WCOWuJqLZojdBLjQ1qV+kyDZtsZ8oDvJQmLvuDGlT06
         tQLbiyE0TAuCkzttk9B8WarXCXk2Em1+xsPWJmmN4UvX1GV9Nk2yQBDev6vHx3H/rXQF
         cqSpuytJk3pqBX/VleKJHuGKRXf6qrQhEWonPd39zDUOOQHJxBIJLTiq8/EF/YfyTwvg
         Gi5Q==
X-Gm-Message-State: AOAM531UPZmaSkIY35/xFhE3HH43aw7DrmTidvsTp4p1lYpXpboLoBpL
        zD5d26FG5uGXOxwf3jQEoeAfYMNgpw1MY32uuRPiR4+rnlGp9ZwvTwOKynK6PrXNg2dL5WvzzB+
        LpVJKBhaAqtkrdXIo93xenYecyLMutBeZ1M5aMO3uhd+s6jYmV1PD3ZXXCNYBH0mUis1QZ8/rhj
        nc
X-Google-Smtp-Source: ABdhPJzQio6F8lAED0QcA+fu8+OnCk0H0lCicYjfm2cMnCy1bt6KvlniVXOfLZvFdfCOXfDQcOdQ0s6Z/OLOowejomQS
X-Received: by 2002:a0c:f486:: with SMTP id i6mr10153526qvm.190.1590791434825;
 Fri, 29 May 2020 15:30:34 -0700 (PDT)
Date:   Fri, 29 May 2020 15:30:15 -0700
In-Reply-To: <cover.1590789428.git.jonathantanmy@google.com>
Message-Id: <6b3a628719e0593893e537de0220a5e0d5460232.1590789428.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1590789428.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH 3/8] http-fetch: support fetching packfiles by URL
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach http-fetch the ability to download packfiles directly, given a
URL, and to verify them.

The http_pack_request suite of functions have been modified to support a
NULL target. When target is NULL, the given URL is downloaded directly
instead of being treated as the root of a repository.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/git-http-fetch.txt |  8 +++-
 http-fetch.c                     | 64 +++++++++++++++++++++++++-------
 http.c                           | 55 ++++++++++++++++++++-------
 http.h                           | 19 ++++++++--
 t/t5550-http-fetch-dumb.sh       | 25 +++++++++++++
 5 files changed, 141 insertions(+), 30 deletions(-)

diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
index 666b042679..8357359a9b 100644
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -9,7 +9,7 @@ git-http-fetch - Download from a remote Git repository via HTTP
 SYNOPSIS
 --------
 [verse]
-'git http-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [--stdin] <commit> <url>
+'git http-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [--stdin | --packfile | <commit>] <url>
 
 DESCRIPTION
 -----------
@@ -40,6 +40,12 @@ commit-id::
 
 		<commit-id>['\t'<filename-as-in--w>]
 
+--packfile::
+	Instead of a commit id on the command line (which is not expected in
+	this case), 'git http-fetch' fetches the packfile directly at the given
+	URL and uses index-pack to generate corresponding .idx and .keep files.
+	The output of index-pack is printed to stdout.
+
 --recover::
 	Verify that everything reachable from target is fetched.  Used after
 	an earlier fetch is interrupted.
diff --git a/http-fetch.c b/http-fetch.c
index a32ac118d9..a9764d6f96 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -5,7 +5,7 @@
 #include "walker.h"
 
 static const char http_fetch_usage[] = "git http-fetch "
-"[-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin] commit-id url";
+"[-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin | --packfile | commit-id] url";
 
 int cmd_main(int argc, const char **argv)
 {
@@ -19,6 +19,7 @@ int cmd_main(int argc, const char **argv)
 	int rc = 0;
 	int get_verbosely = 0;
 	int get_recover = 0;
+	int packfile = 0;
 
 	while (arg < argc && argv[arg][0] == '-') {
 		if (argv[arg][1] == 't') {
@@ -35,43 +36,80 @@ int cmd_main(int argc, const char **argv)
 			get_recover = 1;
 		} else if (!strcmp(argv[arg], "--stdin")) {
 			commits_on_stdin = 1;
+		} else if (!strcmp(argv[arg], "--packfile")) {
+			packfile = 1;
 		}
 		arg++;
 	}
-	if (argc != arg + 2 - commits_on_stdin)
+	if (argc != arg + 2 - (commits_on_stdin || packfile))
 		usage(http_fetch_usage);
 	if (commits_on_stdin) {
 		commits = walker_targets_stdin(&commit_id, &write_ref);
+	} else if (packfile) {
+		/* URL will be set later */
 	} else {
 		commit_id = (char **) &argv[arg++];
 		commits = 1;
 	}
 
-	if (argv[arg])
-		str_end_url_with_slash(argv[arg], &url);
+	if (packfile) {
+		url = xstrdup(argv[arg]);
+	} else {
+		if (argv[arg])
+			str_end_url_with_slash(argv[arg], &url);
+	}
 
 	setup_git_directory();
 
 	git_config(git_default_config, NULL);
 
 	http_init(NULL, url, 0);
-	walker = get_http_walker(url);
-	walker->get_verbosely = get_verbosely;
-	walker->get_recover = get_recover;
 
-	rc = walker_fetch(walker, commits, commit_id, write_ref, url);
+	if (packfile) {
+		struct http_pack_request *preq;
+		struct slot_results results;
+		int ret;
+
+		preq = new_http_pack_request(NULL, url);
+		if (preq == NULL)
+			die("couldn't create http pack request");
+		preq->slot->results = &results;
+		preq->generate_keep = 1;
+
+		if (start_active_slot(preq->slot)) {
+			run_active_slot(preq->slot);
+			if (results.curl_result != CURLE_OK) {
+				die("Unable to get pack file %s\n%s", preq->url,
+				    curl_errorstr);
+			}
+		} else {
+			die("Unable to start request");
+		}
+
+		if ((ret = finish_http_pack_request(preq)))
+			die("finish_http_pack_request gave result %d", ret);
+		release_http_pack_request(preq);
+		rc = 0;
+	} else {
+		walker = get_http_walker(url);
+		walker->get_verbosely = get_verbosely;
+		walker->get_recover = get_recover;
+
+		rc = walker_fetch(walker, commits, commit_id, write_ref, url);
 
-	if (commits_on_stdin)
-		walker_targets_free(commits, commit_id, write_ref);
+		if (commits_on_stdin)
+			walker_targets_free(commits, commit_id, write_ref);
 
-	if (walker->corrupt_object_found) {
-		fprintf(stderr,
+		if (walker->corrupt_object_found) {
+			fprintf(stderr,
 "Some loose object were found to be corrupt, but they might be just\n"
 "a false '404 Not Found' error message sent with incorrect HTTP\n"
 "status code.  Suggest running 'git fsck'.\n");
+		}
+
+		walker_free(walker);
 	}
 
-	walker_free(walker);
 	http_cleanup();
 
 	free(url);
diff --git a/http.c b/http.c
index 130e9d6259..ac66215ee6 100644
--- a/http.c
+++ b/http.c
@@ -2280,15 +2280,18 @@ int finish_http_pack_request(struct http_pack_request *preq)
 	int tmpfile_fd;
 	int ret = 0;
 
-	close_pack_index(p);
+	if (p)
+		close_pack_index(p);
 
 	fclose(preq->packfile);
 	preq->packfile = NULL;
 
-	lst = preq->lst;
-	while (*lst != p)
-		lst = &((*lst)->next);
-	*lst = (*lst)->next;
+	if (p) {
+		lst = preq->lst;
+		while (*lst != p)
+			lst = &((*lst)->next);
+		*lst = (*lst)->next;
+	}
 
 	tmpfile_fd = xopen(preq->tmpfile.buf, O_RDONLY);
 
@@ -2296,14 +2299,21 @@ int finish_http_pack_request(struct http_pack_request *preq)
 	argv_array_push(&ip.args, "--stdin");
 	ip.git_cmd = 1;
 	ip.in = tmpfile_fd;
-	ip.no_stdout = 1;
+	if (preq->generate_keep) {
+		argv_array_pushf(&ip.args, "--keep=git %"PRIuMAX,
+				 (uintmax_t)getpid());
+		ip.out = 0;
+	} else {
+		ip.no_stdout = 1;
+	}
 
 	if (run_command(&ip)) {
 		ret = -1;
 		goto cleanup;
 	}
 
-	install_packed_git(the_repository, p);
+	if (p)
+		install_packed_git(the_repository, p);
 cleanup:
 	close(tmpfile_fd);
 	unlink(preq->tmpfile.buf);
@@ -2321,12 +2331,31 @@ struct http_pack_request *new_http_pack_request(
 	strbuf_init(&preq->tmpfile, 0);
 	preq->target = target;
 
-	end_url_with_slash(&buf, base_url);
-	strbuf_addf(&buf, "objects/pack/pack-%s.pack",
-		hash_to_hex(target->hash));
-	preq->url = strbuf_detach(&buf, NULL);
+	if (target) {
+		end_url_with_slash(&buf, base_url);
+		strbuf_addf(&buf, "objects/pack/pack-%s.pack",
+			hash_to_hex(target->hash));
+		preq->url = strbuf_detach(&buf, NULL);
+	} else {
+		preq->url = xstrdup(base_url);
+	}
+
+	if (target) {
+		strbuf_addf(&preq->tmpfile, "%s.temp",
+			    sha1_pack_name(target->hash));
+	} else {
+		const char *shortened_url;
+		size_t url_len = strlen(base_url);
+
+		shortened_url = url_len <= 50
+			? base_url : base_url + (url_len - 50);
+		strbuf_addf(&preq->tmpfile, "%s/pack/pack-",
+			    get_object_directory());
+		strbuf_addstr_urlencode(&preq->tmpfile,
+					shortened_url, is_rfc3986_unreserved);
+		strbuf_addstr(&preq->tmpfile, ".temp");
+	}
 
-	strbuf_addf(&preq->tmpfile, "%s.temp", sha1_pack_name(target->hash));
 	preq->packfile = fopen(preq->tmpfile.buf, "a");
 	if (!preq->packfile) {
 		error("Unable to open local file %s for pack",
@@ -2350,7 +2379,7 @@ struct http_pack_request *new_http_pack_request(
 		if (http_is_verbose)
 			fprintf(stderr,
 				"Resuming fetch of pack %s at byte %"PRIuMAX"\n",
-				hash_to_hex(target->hash),
+				target ? hash_to_hex(target->hash) : base_url,
 				(uintmax_t)prev_posn);
 		http_opt_request_remainder(preq->slot->curl, prev_posn);
 	}
diff --git a/http.h b/http.h
index a5b082f3ae..709dfa4c19 100644
--- a/http.h
+++ b/http.h
@@ -223,12 +223,21 @@ struct http_pack_request {
 	struct active_request_slot *slot;
 
 	/*
-	 * After calling new_http_pack_request(), point lst to the head of the
+	 * After calling new_http_pack_request(), if fetching a pack that
+	 * http_get_info_packs() told us about, point lst to the head of the
 	 * pack list that target is in. finish_http_pack_request() will remove
 	 * target from lst and call install_packed_git() on target.
 	 */
 	struct packed_git **lst;
 
+	/*
+	 * If this is true, finish_http_pack_request() will pass "--keep" to
+	 * index-pack, resulting in the creation of a keep file, and will not
+	 * suppress its stdout (that is, the "keep\t<hash>\n" line will be
+	 * printed to stdout).
+	 */
+	unsigned generate_keep : 1;
+
 	/*
 	 * State managed by functions in http.c.
 	 */
@@ -237,8 +246,12 @@ struct http_pack_request {
 };
 
 /*
- * target must be an element in a pack list obtained from
- * http_get_info_packs().
+ * If fetching a pack that http_get_info_packs() told us about, set target to
+ * an element in a pack list obtained from http_get_info_packs(). The actual
+ * URL fetched will be base_url followed by a suffix with the hash of the pack.
+ *
+ * Otherwise, set target to NULL. The actual URL fetched will be base_url
+ * itself.
  */
 struct http_pack_request *new_http_pack_request(
 	struct packed_git *target, const char *base_url);
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 50485300eb..53010efc49 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -199,6 +199,23 @@ test_expect_success 'fetch packed objects' '
 	git clone $HTTPD_URL/dumb/repo_pack.git
 '
 
+test_expect_success 'http-fetch --packfile' '
+	git init packfileclient &&
+	p=$(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git && ls objects/pack/pack-*.pack) &&
+	git -C packfileclient http-fetch --packfile "$HTTPD_URL"/dumb/repo_pack.git/$p >out &&
+
+	# Ensure that the expected files are generated
+	grep "^keep.[0-9a-f]\{16,\}$" out &&
+	cut -c6- out >packhash &&
+	test -e "packfileclient/.git/objects/pack/pack-$(cat packhash).pack" &&
+	test -e "packfileclient/.git/objects/pack/pack-$(cat packhash).idx" &&
+	test -e "packfileclient/.git/objects/pack/pack-$(cat packhash).keep" &&
+
+	# Ensure that it has the HEAD of repo_pack, at least
+	HASH=$(git -C "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git rev-parse HEAD) &&
+	git -C packfileclient cat-file -e "$HASH"
+'
+
 test_expect_success 'fetch notices corrupt pack' '
 	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad1.git &&
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad1.git &&
@@ -214,6 +231,14 @@ test_expect_success 'fetch notices corrupt pack' '
 	)
 '
 
+test_expect_success 'http-fetch --packfile with corrupt pack' '
+	rm -rf packfileclient &&
+	git init packfileclient &&
+	p=$(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad1.git && ls objects/pack/pack-*.pack) &&
+	test_must_fail git -C packfileclient http-fetch --packfile \
+		"$HTTPD_URL"/dumb/repo_bad1.git/$p
+'
+
 test_expect_success 'fetch notices corrupt idx' '
 	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad2.git &&
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad2.git &&
-- 
2.27.0.rc0.183.gde8f92d652-goog

