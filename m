Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 266071F463
	for <e@80x24.org>; Wed, 11 Sep 2019 18:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbfIKSVR (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 14:21:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32945 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbfIKSVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 14:21:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id r17so2829004wme.0
        for <git@vger.kernel.org>; Wed, 11 Sep 2019 11:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YX9Jc4uTUl7rF9szigiX4FIebuQ+R/+M55GmSb0pZm4=;
        b=mJEhVgHo4pwoJe1J8AW+MicCjxrJW5PoDvDOG7GG2SMfuPmlHZ0ijWxGJApbV4XEoQ
         oH5F6Vbpt+85FteHHsKGs5lp720HFE1mkZKifa7DNbKNbHkUMRtDKdlSUtnaEqQkXD/6
         sd+MZwW6CseASMFSLueoWqRLjmZs1vrhgttxGMccy/qBrsytL5TxYz/IXvXMC9oTud3q
         Kpo7ugyEwslooJmtLT4yAigy1n6FyzYcn+seiweMhAfe7I9u2x7E7aL/HJlyc76YqVxU
         EsDYGGG4gh71par+fSDh/yVJv5IQ79kf1ymmzrbvOJ+KPMT1ZFzQm6BdFkOkmzLFY6iu
         kKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YX9Jc4uTUl7rF9szigiX4FIebuQ+R/+M55GmSb0pZm4=;
        b=qyDFg2e75C1wXw1H1WMbTiJhv9HzS5gChOx2EFwE4vDEXygFh6rF2MMgL9Q7TrvF3t
         aaYq+kuiLU5k9qPtrkmDUgc8LZ5+rCj45XQ/R9qI8tkDfdB2oQaq1GSDDGUjo2lwtPBk
         Gq2hc3pYGiY2qSdzTLwTW+nRSr0ISK+WmFrwN8kq9QhJcCa9h7lU2LmVp/GhsUpSrrVP
         sSu5mD119c8MYHZLDpt0UHhpZ02tmNmYy79ACK+24Wvhc2Vg6G0dPpcxTHHGvvoDdb/r
         ZDoHNxJcQnqNG/O4ishua1/45d9HH5BuYGjQByyD57XKHvDsjgY0yV7aqacneqKQNq3w
         P+rw==
X-Gm-Message-State: APjAAAXUA+mZCej5jYoMTz4C4CmfdfYZ8YonIi48XlnX4DD7phRf88Bc
        XnZX6OTCGqggYTKCfnX92EVrh3Ru
X-Google-Smtp-Source: APXvYqyPwlN5g/1RSc1X5vMOiO5KhLAGUga8jptzP3Yz6va3R0pnQ9JCQ5quq5OnVhMpiG2eOkqh6w==
X-Received: by 2002:a7b:cc8e:: with SMTP id p14mr4972802wma.124.1568226072718;
        Wed, 11 Sep 2019 11:21:12 -0700 (PDT)
Received: from localhost ([95.148.214.9])
        by smtp.gmail.com with ESMTPSA id y6sm2547263wmi.14.2019.09.11.11.21.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Sep 2019 11:21:11 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 1/3] factor out refresh_and_write_cache function
Date:   Wed, 11 Sep 2019 19:20:25 +0100
Message-Id: <20190911182027.41284-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.194.ge5444969c9
In-Reply-To: <20190911182027.41284-1-t.gummerer@gmail.com>
References: <20190903191041.10470-1-t.gummerer@gmail.com>
 <20190911182027.41284-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Getting the lock for the index, refreshing it and then writing it is a
pattern that happens more than once throughout the codebase, and isn't
trivial to get right.  Factor out the refresh_and_write_cache function
from builtin/am.c to read-cache.c, so it can be re-used in other
places in a subsequent commit.

Note that we return different error codes for failing to refresh the
cache, and failing to write the index.  The current caller only cares
about failing to write the index.  However for other callers we're
going to convert in subsequent patches we will need this distinction.

Helped-by: Martin Ågren <martin.agren@gmail.com>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/am.c | 16 ++--------------
 cache.h      | 18 ++++++++++++++++++
 read-cache.c | 21 +++++++++++++++++++++
 3 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 1aea657a7f..92e0e70069 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1071,19 +1071,6 @@ static const char *msgnum(const struct am_state *state)
 	return sb.buf;
 }
 
-/**
- * Refresh and write index.
- */
-static void refresh_and_write_cache(void)
-{
-	struct lock_file lock_file = LOCK_INIT;
-
-	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
-	refresh_cache(REFRESH_QUIET);
-	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
-		die(_("unable to write index file"));
-}
-
 /**
  * Dies with a user-friendly message on how to proceed after resolving the
  * problem. This message can be overridden with state->resolvemsg.
@@ -1703,7 +1690,8 @@ static void am_run(struct am_state *state, int resume)
 
 	unlink(am_path(state, "dirtyindex"));
 
-	refresh_and_write_cache();
+	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0) < 0)
+		die(_("unable to write index file"));
 
 	if (repo_index_has_changes(the_repository, NULL, &sb)) {
 		write_state_bool(state, "dirtyindex", 1);
diff --git a/cache.h b/cache.h
index b1da1ab08f..68a54f50ac 100644
--- a/cache.h
+++ b/cache.h
@@ -414,6 +414,7 @@ extern struct index_state the_index;
 #define add_file_to_cache(path, flags) add_file_to_index(&the_index, (path), (flags))
 #define chmod_cache_entry(ce, flip) chmod_index_entry(&the_index, (ce), (flip))
 #define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL, NULL)
+#define refresh_and_write_cache(refresh_flags, write_flags, gentle) repo_refresh_and_write_index(the_repository, (refresh_flags), (write_flags), (gentle), NULL, NULL, NULL)
 #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
 #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
 #define cache_dir_exists(name, namelen) index_dir_exists(&the_index, (name), (namelen))
@@ -812,6 +813,23 @@ void fill_stat_cache_info(struct index_state *istate, struct cache_entry *ce, st
 #define REFRESH_IN_PORCELAIN	0x0020	/* user friendly output, not "needs update" */
 #define REFRESH_PROGRESS	0x0040  /* show progress bar if stderr is tty */
 int refresh_index(struct index_state *, unsigned int flags, const struct pathspec *pathspec, char *seen, const char *header_msg);
+/*
+ * Refresh the index and write it to disk.
+ *
+ * 'refresh_flags' is passed directly to 'refresh_index()', while
+ * 'COMMIT_LOCK | write_flags' is passed to 'write_locked_index()', so
+ * the lockfile is always either committed or rolled back.
+ *
+ * If 'gentle' is passed, errors locking the index are ignored.
+ *
+ * Return 1 if refreshing the index returns an error, -1 if writing
+ * the index to disk fails, 0 on success.
+ *
+ * Note that if refreshing the index returns an error, we still write
+ * out the index (unless locking fails).
+ */
+int repo_refresh_and_write_index(struct repository*, unsigned int refresh_flags, unsigned int write_flags, int gentle, const struct pathspec *, char *seen, const char *header_msg);
+
 struct cache_entry *refresh_cache_entry(struct index_state *, struct cache_entry *, unsigned int);
 
 void set_alternate_index_output(const char *);
diff --git a/read-cache.c b/read-cache.c
index 52ffa8a313..7e646e06c2 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1472,6 +1472,27 @@ static void show_file(const char * fmt, const char * name, int in_porcelain,
 	printf(fmt, name);
 }
 
+int repo_refresh_and_write_index(struct repository *repo,
+				 unsigned int refresh_flags,
+				 unsigned int write_flags,
+				 int gentle,
+				 const struct pathspec *pathspec,
+				 char *seen, const char *header_msg)
+{
+	struct lock_file lock_file = LOCK_INIT;
+	int fd, ret = 0;
+
+	fd = repo_hold_locked_index(repo, &lock_file, 0);
+	if (!gentle && fd < 0)
+		return -1;
+	if (refresh_index(repo->index, refresh_flags, pathspec, seen, header_msg))
+		ret = 1;
+	if (0 <= fd && write_locked_index(repo->index, &lock_file, COMMIT_LOCK | write_flags))
+		ret = -1;
+	return ret;
+}
+
+
 int refresh_index(struct index_state *istate, unsigned int flags,
 		  const struct pathspec *pathspec,
 		  char *seen, const char *header_msg)
-- 
2.23.0.rc2.194.ge5444969c9

