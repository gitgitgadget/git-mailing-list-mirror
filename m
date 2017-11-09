Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4406F201C8
	for <e@80x24.org>; Thu,  9 Nov 2017 19:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752787AbdKIT63 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 14:58:29 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:52815 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752231AbdKIT60 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 14:58:26 -0500
Received: by mail-pf0-f194.google.com with SMTP id e64so5018254pfk.9
        for <git@vger.kernel.org>; Thu, 09 Nov 2017 11:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=sCM+9hcwv4BsceK5OWHosbb5pLF5B6tlNC/li6L0Ay8=;
        b=Q4+8UUVkB28zrcPthmh/UMb8IcncAecCWtX42wH+L/a7fAUW37WuDqM2UgNEaO+XQi
         m+ruINKkVAnFj1AD6ffSOXOdTeogt51uIJazUqScD5uZO1l520/BY2NraUGseYFHKkuy
         3uCB7X/hpCWqb5bVD3GzXIY5/XHNlW94CE8lE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=sCM+9hcwv4BsceK5OWHosbb5pLF5B6tlNC/li6L0Ay8=;
        b=eeCOWSkhz/e/vKe3Y9532ob1IWScKnMDMcxfXDo8TN3SZmreg+HIdlUvtXnocBDy6X
         Hg2OsT6v3/2VFz5MlLNqrG/qRrr5Eyy6NfxNmQBl6R9yAKNDIgXdWW/+qvAX3gNXewaD
         LJsdHZgRfOUUHkniFuVOlQ1fJBZN8lI44kAjuLjtiGhSNW0dhLTcaaH1uz6bDPQe1GKe
         YCwURqkaVa1aihiwH1W2YZFecI52sBh4qtTq12IvRQ2UQs8xkJSyNpwfeE+hyRaiRgtT
         ck/osa4zJVu0rS1AjBtwelElfL2OR97oyt5uwqv6vfqch/pwuZXZ71OzWvq8c+lf1BiJ
         CaSA==
X-Gm-Message-State: AJaThX6eADVIWZMpbgASQtD9loxcUFZGKI3jIAYcZEtXxgvubbPm+HPK
        vs0JpaQYonclZy7dFjeYsWlpNmvOJm4=
X-Google-Smtp-Source: ABhQp+RF5o9cSSD1KkMC/pbDl7y2NbE3XufEwSXEjIXRG4KcwnSYbnMHsF+v1vonnUiJ0m4EPP7JEA==
X-Received: by 10.84.143.195 with SMTP id 61mr1469804plz.357.1510257505142;
        Thu, 09 Nov 2017 11:58:25 -0800 (PST)
Received: from alexmv-linux.corp.dropbox.com (v160-sfo11-br01.corp.dropbox.com. [205.189.0.163])
        by smtp.gmail.com with ESMTPSA id p83sm15150760pfd.61.2017.11.09.11.58.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Nov 2017 11:58:24 -0800 (PST)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH 2/2] fsmonitor: Store fsmonitor bitmap before splitting index
Date:   Thu,  9 Nov 2017 11:58:10 -0800
Message-Id: <4ff73be656d5bbf9e2cada6bdec61843da9d1516.1510257457.git.alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.0.rc1.413.g76aedb451
In-Reply-To: <20171109195810.30446-1-alexmv@dropbox.com>
References: <20171109195810.30446-1-alexmv@dropbox.com>
In-Reply-To: <1a8090dfa6f273bae68cfcdd62446944bedbc8a7.1510257457.git.alexmv@dropbox.com>
References: <1a8090dfa6f273bae68cfcdd62446944bedbc8a7.1510257457.git.alexmv@dropbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ba1b9caca6 resolved the problem of the fsmonitor data being applied to
the non-base index when reading; however, a similar problem exists
when writing the index.  Specifically, writing of the fsmonitor
extension happens only after the work to split the index has been
applied -- as such, the information in the index is only for the
non-"base" index, and thus the extension information contains only
partial data.

When saving, compute the ewah bitmap before the index is split, and
store it in the fsmonitor_dirty field, mirroring the behavior that
occurred during reading.  fsmonitor_dirty is kept from being leaked by
being freed when the extension data is written -- which always happens
precisely once, no matter the split index configuration.

Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
---
 fsmonitor.c                 | 20 ++++++++++++--------
 fsmonitor.h                 |  9 ++++++++-
 read-cache.c                |  3 +++
 t/t7519-status-fsmonitor.sh | 13 +++++++++++++
 4 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index f494a866d..0af7c4edb 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -54,12 +54,19 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
 	return 0;
 }
 
+void fill_fsmonitor_bitmap(struct index_state *istate)
+{
+	int i;
+	istate->fsmonitor_dirty = ewah_new();
+	for (i = 0; i < istate->cache_nr; i++)
+		if (!(istate->cache[i]->ce_flags & CE_FSMONITOR_VALID))
+			ewah_set(istate->fsmonitor_dirty, i);
+}
+
 void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
 {
 	uint32_t hdr_version;
 	uint64_t tm;
-	struct ewah_bitmap *bitmap;
-	int i;
 	uint32_t ewah_start;
 	uint32_t ewah_size = 0;
 	int fixup = 0;
@@ -73,12 +80,9 @@ void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
 	strbuf_add(sb, &ewah_size, sizeof(uint32_t)); /* we'll fix this up later */
 
 	ewah_start = sb->len;
-	bitmap = ewah_new();
-	for (i = 0; i < istate->cache_nr; i++)
-		if (!(istate->cache[i]->ce_flags & CE_FSMONITOR_VALID))
-			ewah_set(bitmap, i);
-	ewah_serialize_strbuf(bitmap, sb);
-	ewah_free(bitmap);
+	ewah_serialize_strbuf(istate->fsmonitor_dirty, sb);
+	ewah_free(istate->fsmonitor_dirty);
+	istate->fsmonitor_dirty = NULL;
 
 	/* fix up size field */
 	put_be32(&ewah_size, sb->len - ewah_start);
diff --git a/fsmonitor.h b/fsmonitor.h
index 0de644e01..cd3cc0ccf 100644
--- a/fsmonitor.h
+++ b/fsmonitor.h
@@ -10,7 +10,14 @@ extern struct trace_key trace_fsmonitor;
 extern int read_fsmonitor_extension(struct index_state *istate, const void *data, unsigned long sz);
 
 /*
- * Write the CE_FSMONITOR_VALID state into the fsmonitor index extension.
+ * Fill the fsmonitor_dirty ewah bits with their state from the index,
+ * before it is split during writing.
+ */
+extern void fill_fsmonitor_bitmap(struct index_state *istate);
+
+/*
+ * Write the CE_FSMONITOR_VALID state into the fsmonitor index
+ * extension.  Reads from the fsmonitor_dirty ewah in the index.
  */
 extern void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate);
 
diff --git a/read-cache.c b/read-cache.c
index c18e5e623..7976d39d6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2529,6 +2529,9 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 	int new_shared_index, ret;
 	struct split_index *si = istate->split_index;
 
+	if (istate->fsmonitor_last_update)
+		fill_fsmonitor_bitmap(istate);
+
 	if (!si || alternate_index_output ||
 	    (istate->cache_changed & ~EXTMASK)) {
 		if (si)
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index c6df85af5..eb2d13bbc 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -301,4 +301,17 @@ do
 	done
 done
 
+# test that splitting the index dosn't interfere
+test_expect_success 'splitting the index results in the same state' '
+	write_integration_script &&
+	dirty_repo &&
+	git update-index --fsmonitor  &&
+	git ls-files -f >expect &&
+	test-dump-fsmonitor >&2 && echo &&
+	git update-index --fsmonitor --split-index &&
+	test-dump-fsmonitor >&2 && echo &&
+	git ls-files -f >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.15.0.rc1.413.g76aedb451

