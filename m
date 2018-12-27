Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14753211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 23:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733220AbeL0Xgw (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 18:36:52 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41533 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbeL0Xgv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 18:36:51 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so9696791pfi.8
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 15:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eiVIZ2+Dx8KgfkAi4gkVeGyHRailncI3+VFPtMBMZJs=;
        b=rLJMHqENYXjl5yHRzs5YSyRDRHAuo5STvOweR/TchJH+AvK0OrTOJkqHOq78IASYC+
         q39jXsGwEYMyH0fp7UzUXYTQF78bP0Xmbap/O5j4ZyVO0pXnD/5VUHjvFaqJIUXJLewU
         OL6k2BI+olrPaof1JSYCHcjjyb6v8nlUQjm/N/0CfuYYPpBzfJKiuiBKCqS6CPt+Otpa
         XTmuc+wpcuRwdETQHPws8phdWTQmuL3gCFr6KKDkyM92xB1kqTP51JhMEkCzaJYw8YB7
         /YdFlTKd2yw6Y0EvJunPMxvgQ5MNhmyl0pP1Aa224hBtFcm45/gSD11MKYKEeE5mrviN
         4YUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eiVIZ2+Dx8KgfkAi4gkVeGyHRailncI3+VFPtMBMZJs=;
        b=LXxo1DQ56w63XYG13oDNDLlQgsCz+UYocWnF/58dqPA0PU/ubJiBcIrNTbiBX9SAp/
         vGrND+7vX4hD2GtVn1oMDYImlXBykBB8Nl/Q7Au5vIDDEtrJdroEBgjoZb+i8o8IhNSY
         vedP2FfJNtOv1VRe+omVcDA+A6h3aTxbEkl7nGz1xk0OYfTaRZvK98VLKRF+pOB6tL6p
         3brn0goVVYQC80JA8/gbfc19v+4iwKz11xP1XLIiSAM/YGhmCYNRXgHP2f+uUlyuQZVe
         mzISTfhQvyoDrrveigxAAQFKWiebjmm25gZ6Q9ivaWi/DNaIFc5CXi+uQNXYVJqDMy8Q
         a/8Q==
X-Gm-Message-State: AJcUukfhJ33r9GpTwvz11wdI6Mc6gbnTc4WQmak0LdEcUB1v1zIq2fFL
        h0UNXY1Jum8UscQiIIfTM7qg3MDR
X-Google-Smtp-Source: ALg8bN5v3afwKqWlG+IUk3lP7mW6/LY3UFFkIS38ueTHnFBU/0moLxwNvdP0lmyrnc5TEX7NYITksQ==
X-Received: by 2002:a65:448a:: with SMTP id l10mr24406964pgq.387.1545953810105;
        Thu, 27 Dec 2018 15:36:50 -0800 (PST)
Received: from localhost.localdomain ([162.250.210.102])
        by smtp.googlemail.com with ESMTPSA id f13sm55790677pfa.132.2018.12.27.15.36.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Dec 2018 15:36:48 -0800 (PST)
From:   Erin Dahlgren <eedahlgren@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Erin Dahlgren <eedahlgren@gmail.com>
Subject: [PATCH v3] Simplify handling of setup_git_directory_gently() failure cases.
Date:   Thu, 27 Dec 2018 15:36:29 -0800
Message-Id: <1545953789-15040-1-git-send-email-eedahlgren@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544922308-740-1-git-send-email-eedahlgren@gmail.com>
References: <1544922308-740-1-git-send-email-eedahlgren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

setup_git_directory_gently() expects two types of failures to
discover a git directory (e.g. .git/):

  - GIT_DIR_HIT_CEILING: could not find a git directory in any
	parent directories of the cwd.
  - GIT_DIR_HIT_MOUNT_POINT: could not find a git directory in
	any parent directories up to the mount point of the cwd.

Both cases are handled in a similar way, but there are misleading
and unimportant differences. In both cases, setup_git_directory_gently()
should:

  - Die if we are not in a git repository. Otherwise:
  - Set nongit_ok = 1, indicating that we are not in a git repository
	but this is ok.
  - Call strbuf_release() on any non-static struct strbufs that we
	allocated.

Before this change are two misleading additional behaviors:

  - GIT_DIR_HIT_CEILING: setup_nongit() changes to the cwd for no
	apparent reason. We never had the chance to change directories
	up to this point so chdir(current cwd) is pointless.
  - GIT_DIR_HIT_MOUNT_POINT: strbuf_release() frees the buffer
	of a static struct strbuf (cwd). This is unnecessary because the
	struct is static so its buffer is always reachable. This is also
	misleading because nowhere else in the function is this buffer
	released.

This change eliminates these two misleading additional behaviors and
deletes setup_nogit() because the code is clearer without it. The
result is that we can see clearly that GIT_DIR_HIT_CEILING and
GIT_DIR_HIT_MOUNT_POINT lead to the same behavior (ignoring the
different help messages).

During review, this change was amended to additionally include:

  - Neither GIT_DIR_HIT_CEILING nor GIT_DIR_HIT_MOUNT_POINT may
	return early from setup_git_directory_gently() before the
	GIT_PREFIX environment variable is reset. Change both cases to
	break instead of return. See GIT_PREFIX below for more details.

  - GIT_DIR_NONE: setup_git_directory_gently_1() never returns this
	value, but if it ever did, setup_git_directory_gently() would
	incorrectly record that it had found a repository. Explicitly
	BUG on this case because it is underspecified.

  - GIT_PREFIX: this environment variable must always match the
	value of startup_info->prefix and the prefix returned from
	setup_git_directory_gently(). Make how we handle this slightly
	more repetitive but also more clear.

  - setup_git_env() and repo_set_hash_algo(): Add comments showing
	that only GIT_DIR_EXPLICIT, GIT_DIR_DISCOVERED, and GIT_DIR_BARE
	will cause setup_git_directory_gently() to call these setup
	functions. This was obvious (but partly incorrect) before this
	change when GIT_DIR_HIT_MOUNT_POINT returned early from
	setup_git_directory_gently().
---
Changes in v3:

  - Re-aligned arguments to die() calls to match formatting convention.

  - Neither GIT_DIR_HIT_CEILING nor GIT_DIR_HIT_MOUNT_POINT may
  return early from setup_git_directory_gently() before the
  GIT_PREFIX environment variable is reset. Change both cases to
  break instead of return. See GIT_PREFIX below for more details.

  - GIT_DIR_NONE: setup_git_directory_gently_1() never returns this
  value, but if it ever did, setup_git_directory_gently() would
  incorrectly record that it had found a repository. Explicitly
  BUG on this case because it is underspecified.

  - GIT_PREFIX: this environment variable must always match the
  value of startup_info->prefix and the prefix returned from
  setup_git_directory_gently(). Make how we handle this slightly
  more repetitive but also more clear.

  - setup_git_env() and repo_set_hash_algo(): Add comments showing
  that only GIT_DIR_EXPLICIT, GIT_DIR_DISCOVERED, and GIT_DIR_BARE
  will cause setup_git_directory_gently() to call these setup
  functions. This was obvious (but partly incorrect) before this
  change when GIT_DIR_HIT_MOUNT_POINT returned early from
  setup_git_directory_gently().

 setup.c | 75 ++++++++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 44 insertions(+), 31 deletions(-)

diff --git a/setup.c b/setup.c
index 1be5037..eb8332b 100644
--- a/setup.c
+++ b/setup.c
@@ -831,16 +831,6 @@ static const char *setup_bare_git_dir(struct strbuf *cwd, int offset,
 	return NULL;
 }
 
-static const char *setup_nongit(const char *cwd, int *nongit_ok)
-{
-	if (!nongit_ok)
-		die(_("not a git repository (or any of the parent directories): %s"), DEFAULT_GIT_DIR_ENVIRONMENT);
-	if (chdir(cwd))
-		die_errno(_("cannot come back to cwd"));
-	*nongit_ok = 1;
-	return NULL;
-}
-
 static dev_t get_device_or_die(const char *path, const char *prefix, int prefix_len)
 {
 	struct stat buf;
@@ -1054,7 +1044,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 {
 	static struct strbuf cwd = STRBUF_INIT;
 	struct strbuf dir = STRBUF_INIT, gitdir = STRBUF_INIT;
-	const char *prefix;
+	const char *prefix = NULL;
 	struct repository_format repo_fmt;
 
 	/*
@@ -1079,9 +1069,6 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	strbuf_addbuf(&dir, &cwd);
 
 	switch (setup_git_directory_gently_1(&dir, &gitdir, 1)) {
-	case GIT_DIR_NONE:
-		prefix = NULL;
-		break;
 	case GIT_DIR_EXPLICIT:
 		prefix = setup_explicit_git_dir(gitdir.buf, &cwd, &repo_fmt, nongit_ok);
 		break;
@@ -1097,29 +1084,52 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		prefix = setup_bare_git_dir(&cwd, dir.len, &repo_fmt, nongit_ok);
 		break;
 	case GIT_DIR_HIT_CEILING:
-		prefix = setup_nongit(cwd.buf, nongit_ok);
+		if (!nongit_ok)
+			die(_("not a git repository (or any of the parent directories): %s"),
+			    DEFAULT_GIT_DIR_ENVIRONMENT);
+		*nongit_ok = 1;
 		break;
 	case GIT_DIR_HIT_MOUNT_POINT:
-		if (nongit_ok) {
-			*nongit_ok = 1;
-			strbuf_release(&cwd);
-			strbuf_release(&dir);
-			return NULL;
-		}
-		die(_("not a git repository (or any parent up to mount point %s)\n"
-		      "Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set)."),
-		    dir.buf);
+		if (!nongit_ok)
+			die(_("not a git repository (or any parent up to mount point %s)\n"
+			      "Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set)."),
+			    dir.buf);
+		*nongit_ok = 1;
+		break;
+	case GIT_DIR_NONE:
+		/*
+		 * As a safeguard against setup_git_directory_gently_1 returning
+		 * this value, fallthrough to BUG. Otherwise it is possible to
+		 * set startup_info->have_repository to 1 when we did nothing to
+		 * find a repository.
+		 */
 	default:
 		BUG("unhandled setup_git_directory_1() result");
 	}
 
-	if (prefix)
-		setenv(GIT_PREFIX_ENVIRONMENT, prefix, 1);
-	else
+	/*
+	 * At this point, nongit_ok is stable. If it is non-NULL and points
+	 * to a non-zero value, then this means that we haven't found a
+	 * repository and that the caller expects startup_info to reflect
+	 * this.
+	 *
+	 * Regardless of the state of nongit_ok, startup_info->prefix and
+	 * the GIT_PREFIX environment variable must always match. For details
+	 * see Documentation/config/alias.txt.
+	 */
+	if (nongit_ok && *nongit_ok) {
+		startup_info->have_repository = 0;
+		startup_info->prefix = NULL;
 		setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
-
-	startup_info->have_repository = !nongit_ok || !*nongit_ok;
-	startup_info->prefix = prefix;
+	} else {
+		// !nongit_ok || !*nongit_ok
+		startup_info->have_repository = 1;
+		startup_info->prefix = prefix;
+		if (prefix)
+			setenv(GIT_PREFIX_ENVIRONMENT, prefix, 1);
+		else
+			setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
+	}
 
 	/*
 	 * Not all paths through the setup code will call 'set_git_dir()' (which
@@ -1132,7 +1142,10 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	 * the user has set GIT_DIR.  It may be beneficial to disallow bogus
 	 * GIT_DIR values at some point in the future.
 	 */
-	if (startup_info->have_repository || getenv(GIT_DIR_ENVIRONMENT)) {
+	if (// GIT_DIR_EXPLICIT, GIT_DIR_DISCOVERED, GIT_DIR_BARE
+	    startup_info->have_repository ||
+	    // GIT_DIR_EXPLICIT
+	    getenv(GIT_DIR_ENVIRONMENT)) {
 		if (!the_repository->gitdir) {
 			const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
 			if (!gitdir)
-- 
2.7.4

