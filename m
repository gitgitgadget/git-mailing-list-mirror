Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5998BC433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 20:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 362AE2074B
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 20:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lYxzRhoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgFJU5g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgFJU5d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 16:57:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9FEC08C5C1
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 13:57:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s90so3874190ybi.6
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 13:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sxYkUyxSdMjDXshpP8k5DlKQRM0FGR2Ps/Dhb8ayTJ4=;
        b=lYxzRhoU1dN0IGiqPlvshsH3UEY2Y+RLI80GDN9SZTUY5FX0+x+/rDmNFAynunylqP
         0ex7YjSU9kg5J2PelQKCo8PMBYATOI/uGjPkUh/1ZfnH49J2bQ7YfG8LLLWrfmYbpxu2
         Kqfdx86XGGiP0o5Onp6lzV4gntGx0Of8hQMaNnasncZUeD1oe5PyWdV8cNu2ToihKHJ2
         mhDS00nTO3wCIovtFlKnEtPnCR9QhO3W/vrMmWU3AJw7pJeJtr9Tt0LTFNLWh+PaBYdL
         2W1spDyYoI2+p9ti2v/B4HEqjO7c4R8Vw4KjwOYuMziVi7W95L2N1dLFU5FL+5ePJu1Q
         xeIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sxYkUyxSdMjDXshpP8k5DlKQRM0FGR2Ps/Dhb8ayTJ4=;
        b=ohHt78IbYMBRBgTjsipAeQDQ5gampJ2GdJzNRHtYruyLZ9WaYM0BCEqCnG0VbWjeys
         hNtvE5ObePfcZ1ZK2i0UgNZfVXcqCbyGv9GboB+SguOtXRb8kaA6sn0PxEP+5jx5l79Y
         mrvwk3uK02MhgI1fwH44RHzjZpXRgG4+Iq/rmZhY6sCE8BDDRqsvXYkOD6/1zTw3ybiO
         sldGFxNza4/NkjDcOVQYqTCn4SZyQZn6lX3RM++Ev+SYJ/LhWwRh8GmMFe5OjjOOKDcz
         hHy7B6do4XOiE9c2gwDhEFvouQWtWRnKus6f7wk8foAbqqiJe4chi1eYdxhJB2746EWM
         4vzQ==
X-Gm-Message-State: AOAM530cgetefRN73k12EDJJXWIBJMcVyGgEx2Q/R5j9Tixo6tpBAvTi
        LF0xlp0UMLZMIzIaV0f1d72KiTwKiJqfJ14afmLTtV3je0ImoYPaWiWmL0DG7mdQ1wyHVBw1BjG
        rUmmyZxskTO2B+nxNHl8vMKzon3ECJaCvrNkqbLnkQzL/iblS1ncOtG7kwd4AynLT7Z/51IMo6N
        QC
X-Google-Smtp-Source: ABdhPJy4UZBFlBo04g8Fn3TpkTAsAonMd5rKGeOVrRMjdh2O9oeqaMii1BuZpFMZ3VhMH8Ot/pNwUMU/weoHbByZNH0Z
X-Received: by 2002:a25:7b44:: with SMTP id w65mr3817022ybc.199.1591822652768;
 Wed, 10 Jun 2020 13:57:32 -0700 (PDT)
Date:   Wed, 10 Jun 2020 13:57:17 -0700
In-Reply-To: <cover.1591821067.git.jonathantanmy@google.com>
Message-Id: <7a9b454bd609aaa7d9909c70739603add5c038e5.1591821067.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1590789428.git.jonathantanmy@google.com> <cover.1591821067.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH v2 3/9] http-fetch: refactor into function
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cmd_main() in http-fetch.c will grow in a future patch, so refactor the
HTTP walking part into its own function.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 http-fetch.c | 69 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 28 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index a32ac118d9..e538174bde 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -7,16 +7,49 @@
 static const char http_fetch_usage[] = "git http-fetch "
 "[-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin] commit-id url";
 
-int cmd_main(int argc, const char **argv)
+static int fetch_using_walker(const char *raw_url, int get_verbosely,
+			      int get_recover, int commits, char **commit_id,
+			      const char **write_ref, int commits_on_stdin)
 {
+	char *url = NULL;
 	struct walker *walker;
+	int rc;
+
+	str_end_url_with_slash(raw_url, &url);
+
+	http_init(NULL, url, 0);
+
+	walker = get_http_walker(url);
+	walker->get_verbosely = get_verbosely;
+	walker->get_recover = get_recover;
+	walker->get_progress = 0;
+
+	rc = walker_fetch(walker, commits, commit_id, write_ref, url);
+
+	if (commits_on_stdin)
+		walker_targets_free(commits, commit_id, write_ref);
+
+	if (walker->corrupt_object_found) {
+		fprintf(stderr,
+"Some loose object were found to be corrupt, but they might be just\n"
+"a false '404 Not Found' error message sent with incorrect HTTP\n"
+"status code.  Suggest running 'git fsck'.\n");
+	}
+
+	walker_free(walker);
+	http_cleanup();
+	free(url);
+
+	return rc;
+}
+
+int cmd_main(int argc, const char **argv)
+{
 	int commits_on_stdin = 0;
 	int commits;
 	const char **write_ref = NULL;
 	char **commit_id;
-	char *url = NULL;
 	int arg = 1;
-	int rc = 0;
 	int get_verbosely = 0;
 	int get_recover = 0;
 
@@ -47,34 +80,14 @@ int cmd_main(int argc, const char **argv)
 		commits = 1;
 	}
 
-	if (argv[arg])
-		str_end_url_with_slash(argv[arg], &url);
-
 	setup_git_directory();
 
 	git_config(git_default_config, NULL);
 
-	http_init(NULL, url, 0);
-	walker = get_http_walker(url);
-	walker->get_verbosely = get_verbosely;
-	walker->get_recover = get_recover;
-
-	rc = walker_fetch(walker, commits, commit_id, write_ref, url);
-
-	if (commits_on_stdin)
-		walker_targets_free(commits, commit_id, write_ref);
+	if (!argv[arg])
+		BUG("must have one arg remaining");
 
-	if (walker->corrupt_object_found) {
-		fprintf(stderr,
-"Some loose object were found to be corrupt, but they might be just\n"
-"a false '404 Not Found' error message sent with incorrect HTTP\n"
-"status code.  Suggest running 'git fsck'.\n");
-	}
-
-	walker_free(walker);
-	http_cleanup();
-
-	free(url);
-
-	return rc;
+	return fetch_using_walker(argv[arg], get_verbosely, get_recover,
+				  commits, commit_id, write_ref,
+				  commits_on_stdin);
 }
-- 
2.27.0.278.ge193c7cf3a9-goog

