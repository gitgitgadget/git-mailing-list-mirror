Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E5251FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 21:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754001AbdFMVDf (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 17:03:35 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35903 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752326AbdFMVDe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 17:03:34 -0400
Received: by mail-pf0-f179.google.com with SMTP id x63so73423686pff.3
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 14:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oLx8gEjo2S696x2/GfKgzRs4SKzQjf4SZ9CvHKTLFT8=;
        b=sUchvB72SKWjHe6jOtZHZ5IfVbaQEaGERd5cE69756MC5XlpoPBqhTMGWkwkWfhSKj
         70QDpojLO8Nsg/+6paX2nwUxtEACFtTxNkXu31vCoezhyX9ZzdjgYUJ18+PTAl/MpnFN
         LimG8KkxqykHEuk0lS0TzwwyvqoOdB2qo/qN5+nAfEq01qacolQVTjjjM8qvMjcFXg7z
         KeGf4uV4fu4J5plTukDpn66ZU8kHVlOzN0nJ4t7Xj+c9E7qhz0ieQUu6/iddQl4E6+Op
         wWWsWJnbFZD2flN14onAEFd+QMWDhgNxWmMZ0KCKunCbYRu5q0V0F9i1ZHnsfwVYTQGo
         IjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oLx8gEjo2S696x2/GfKgzRs4SKzQjf4SZ9CvHKTLFT8=;
        b=J7EMklvtFyWlu5znBAaCIu5D+EqBMOAZhl/TEU8jr5nBzPKvWfCXXhjgYD/qjyNzwo
         zFbZKd3WVvMc6+83g2VrrGL6tLNDrUwEIETeLPCn9cas3MLV8V9viJqzI6OFoR5hkAr3
         Of71ik53bEheFfdCEfGEnpNqPoKV0LoszhW1tSpp1c+XHz4AY8ualGnPi4PuuoJpmlSJ
         X/n0SvMe2vkMHb1yjlyR/i+60sJJY7CXe3VgBajlbsvC3fsIjtWd8Bddm/CRjetYqxwX
         IHHyaSK3dxpkuEz7HtSB9temJ1FvkyZBR6i083MQZKDbq4MMiwhb8glT0ONgP/bFIKE/
         08GQ==
X-Gm-Message-State: AKS2vOxtxXjOCD6OA4N8yc0JL6zzDvTM3eONhNJ3AUrQ8McHC8oNhz1v
        zc7Ia16kEwlctfqTEJI51g==
X-Received: by 10.99.175.19 with SMTP id w19mr1366358pge.67.1497387813312;
        Tue, 13 Jun 2017 14:03:33 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id b65sm29154065pfm.29.2017.06.13.14.03.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 14:03:32 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de, peff@peff.net,
        jrnieder@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 5/6] setup: teach discover_git_directory to respect the commondir
Date:   Tue, 13 Jun 2017 14:03:20 -0700
Message-Id: <20170613210321.152978-6-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <20170613210321.152978-1-bmwill@google.com>
References: <20170612213406.83247-1-bmwill@google.com>
 <20170613210321.152978-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently 'discover_git_directory' only looks at the gitdir to determine
if a git directory was discovered.  This causes a problem in the event
that the gitdir which was discovered was in fact a per-worktree git
directory and not the common git directory.  This is because the
repository config, which is checked to verify the repository's format,
is stored in the commondir and not in the per-worktree gitdir.  Correct
this behavior by checking the config stored in the commondir.

It will also be of use for callers to have access to the commondir, so
lets also return that upon successfully discovering a git directory.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 cache.h  |  3 ++-
 config.c | 10 ++++++----
 setup.c  |  9 +++++++--
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index fd45b8c55..a4176436d 100644
--- a/cache.h
+++ b/cache.h
@@ -530,7 +530,8 @@ extern void setup_work_tree(void);
  * appended to gitdir. The return value is either NULL if no repository was
  * found, or pointing to the path inside gitdir's buffer.
  */
-extern const char *discover_git_directory(struct strbuf *gitdir);
+extern const char *discover_git_directory(struct strbuf *commondir,
+					  struct strbuf *gitdir);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
 extern char *prefix_path(const char *prefix, int len, const char *path);
diff --git a/config.c b/config.c
index 4e2842689..9aa9b9715 100644
--- a/config.c
+++ b/config.c
@@ -1652,7 +1652,8 @@ static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
 void read_early_config(config_fn_t cb, void *data)
 {
 	struct config_options opts = {0};
-	struct strbuf buf = STRBUF_INIT;
+	struct strbuf commondir = STRBUF_INIT;
+	struct strbuf gitdir = STRBUF_INIT;
 
 	opts.respect_includes = 1;
 
@@ -1666,12 +1667,13 @@ void read_early_config(config_fn_t cb, void *data)
 	 * notably, the current working directory is still the same after the
 	 * call).
 	 */
-	else if (discover_git_directory(&buf))
-		opts.git_dir = buf.buf;
+	else if (discover_git_directory(&commondir, &gitdir))
+		opts.git_dir = gitdir.buf;
 
 	git_config_with_options(cb, data, NULL, &opts);
 
-	strbuf_release(&buf);
+	strbuf_release(&commondir);
+	strbuf_release(&gitdir);
 }
 
 static void git_config_check_init(void);
diff --git a/setup.c b/setup.c
index e99a82cbe..7bbb8736f 100644
--- a/setup.c
+++ b/setup.c
@@ -946,10 +946,12 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 	}
 }
 
-const char *discover_git_directory(struct strbuf *gitdir)
+const char *discover_git_directory(struct strbuf *commondir,
+				   struct strbuf *gitdir)
 {
 	struct strbuf dir = STRBUF_INIT, err = STRBUF_INIT;
 	size_t gitdir_offset = gitdir->len, cwd_len;
+	size_t commondir_offset = commondir->len;
 	struct repository_format candidate;
 
 	if (strbuf_getcwd(&dir))
@@ -974,8 +976,10 @@ const char *discover_git_directory(struct strbuf *gitdir)
 		strbuf_insert(gitdir, gitdir_offset, dir.buf, dir.len);
 	}
 
+	get_common_dir(commondir, gitdir->buf + gitdir_offset);
+
 	strbuf_reset(&dir);
-	strbuf_addf(&dir, "%s/config", gitdir->buf + gitdir_offset);
+	strbuf_addf(&dir, "%s/config", commondir->buf + commondir_offset);
 	read_repository_format(&candidate, dir.buf);
 	strbuf_release(&dir);
 
@@ -983,6 +987,7 @@ const char *discover_git_directory(struct strbuf *gitdir)
 		warning("ignoring git dir '%s': %s",
 			gitdir->buf + gitdir_offset, err.buf);
 		strbuf_release(&err);
+		strbuf_setlen(commondir, commondir_offset);
 		return NULL;
 	}
 
-- 
2.13.1.518.g3df882009-goog

