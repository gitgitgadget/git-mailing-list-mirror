Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_24_48,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A64F2207F8
	for <e@80x24.org>; Sat,  6 May 2017 18:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbdEFStw (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 14:49:52 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33833 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbdEFSti (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2017 14:49:38 -0400
Received: by mail-qt0-f195.google.com with SMTP id l39so4886562qtb.1
        for <git@vger.kernel.org>; Sat, 06 May 2017 11:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Zt2rOwvGOnKASbTmvqloDIZBeOAx/WbosKBJEowkAog=;
        b=ljn2mTjt5RmSlWzhMdmgPANk3IZqa0jQyvq5hw8JiuFxNUoLnMBKHTzzU5T+ciQfIs
         q1XDDI5n28p5e33xoaiXUZyqfmG9lAUXW10S3JcYXpHEgzK0OwTg7PaE/y4L3pAnxh8o
         wOPmQHFxPbU1NH4jL1sj4XZoJFE7Cmrq1RMT/upFR6QdJyRqcVMel26NrOys4CLnCpMn
         vcCe2M7+nyUQYIfAUEDn11DIsXwwDiFpqBYnR1V4csot/fUaHG4nv5BvoWYfhc5imivQ
         kJop0sd+pT8tfh8RumyFqqLxSmHU1+q+49fkgFEe5aVB2OBAABqtpVu/ZHmQ4txP0bjg
         Zz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Zt2rOwvGOnKASbTmvqloDIZBeOAx/WbosKBJEowkAog=;
        b=ZXHDdDdZih7enGB6LvUksMJd3P0R7Y94PBZtkhtxbRnQIIn4+FeKi3v4ENAJpZoTfQ
         gYs0+eEWAyR2hWOWPOOggKi24Qs0sZ1q1ceaaWu8biEYRM4jNKM9cE7wFW9zIHGttF+h
         +E9B6KtGQadomxUAzL5QSv9d0uIHP9m78LA/2+Dl/wgV0NFoKYKzkSEg4kvWYp6IkaAp
         yRbF1gs0ewX+5pQ86qH6kt+iogTNwvKoLC2oqNnu+EbGZvVDdUfjRqLVtUnuZUhNH5dF
         PA2PEDbx1GyDYnP5U4yydr30cxoJ5ZTfKvXNeFjJlh21nHgC68UUxGMWMrFc2sErtKLQ
         o1nw==
X-Gm-Message-State: AN3rC/4rMdiR+nCTY0iPtZ4Tow5vUsJcglBF3XDsjsz9HO2sILHNyJQ1
        xusksUpAEYPdrsZVdsE=
X-Received: by 10.200.40.151 with SMTP id i23mr45917966qti.146.1494096572781;
        Sat, 06 May 2017 11:49:32 -0700 (PDT)
Received: from localhost.localdomain ([129.59.122.17])
        by smtp.gmail.com with ESMTPSA id 83sm6866347qkq.26.2017.05.06.11.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 May 2017 11:49:32 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v2 5/9] dir: hide untracked contents of untracked dirs
Date:   Fri,  5 May 2017 05:46:07 -0500
Message-Id: <20170505104611.17845-6-sxlijin@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170505104611.17845-1-sxlijin@gmail.com>
References: <20170505104611.17845-1-sxlijin@gmail.com>
In-Reply-To: <20170503032932.16043-1-sxlijin@gmail.com>
References: <20170503032932.16043-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we taught read_directory_recursive() to recurse into untracked
directories in search of ignored files given DIR_SHOW_IGNORED_TOO, that
had the side effect of teaching it to collect the untracked contents of
untracked directories. It does not make sense to return these, so we
teach read_directory() to strip dir->entries of any such untracked
contents.

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 dir.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/dir.c b/dir.c
index 4739087f4..fd445ee9e 100644
--- a/dir.c
+++ b/dir.c
@@ -2075,6 +2075,50 @@ int read_directory(struct dir_struct *dir, const char *path,
 		read_directory_recursive(dir, path, len, untracked, 0, pathspec);
 	QSORT(dir->entries, dir->nr, cmp_name);
 	QSORT(dir->ignored, dir->ignored_nr, cmp_name);
+
+	// if collecting ignored files, never consider a directory containing
+	// ignored files to be untracked
+	if (dir->flags & DIR_SHOW_IGNORED_TOO) {
+		int i, j, nr_removed = 0;
+
+		// remove from dir->entries untracked contents of untracked dirs
+		for (i = 0; i < dir->nr; i++) {
+			if (!dir->entries[i])
+				continue;
+
+			for (j = i + 1; j < dir->nr; j++) {
+				if (!dir->entries[j])
+					continue;
+				if (check_contains(dir->entries[i], dir->entries[j])) {
+					nr_removed++;
+					free(dir->entries[j]);
+					dir->entries[j] = NULL;
+				}
+				else {
+					break;
+				}
+			}
+		}
+
+		// strip dir->entries of NULLs
+		if (nr_removed) {
+			for (i = 0;;) {
+				while (i < dir->nr && dir->entries[i])
+					i++;
+				if (i == dir->nr)
+					break;
+				j = i;
+				while (j < dir->nr && !dir->entries[j])
+					j++;
+				if (j == dir->nr)
+					break;
+				dir->entries[i] = dir->entries[j];
+				dir->entries[j] = NULL;
+			}
+			dir->nr -= nr_removed;
+		}
+	}
+
 	if (dir->untracked) {
 		static struct trace_key trace_untracked_stats = TRACE_KEY_INIT(UNTRACKED_STATS);
 		trace_printf_key(&trace_untracked_stats,
-- 
2.12.2

