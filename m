Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69603207B3
	for <e@80x24.org>; Wed,  3 May 2017 03:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbdECDaD (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 23:30:03 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34425 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752097AbdECD35 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 23:29:57 -0400
Received: by mail-yw0-f196.google.com with SMTP id u70so13433351ywe.1
        for <git@vger.kernel.org>; Tue, 02 May 2017 20:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VzO8nxEgM7mMHURmdh1mffLzvh0+3XZWjzkfKmPy+ug=;
        b=HqgPkXO3/8qrX1hS9Ykao6dblp4ScKbhxPwKMTt3py0nPuI2+V292dAnNPcrslltmg
         UDJh6bPdWxgkxUaNw3P4czbpSekfYhB75NXAr3PvxXc/w/cRIn5ucnKrDYOS/iNXzx5Y
         EV40hkjbP6j8yY69cZOn/+EQeE2xhVUeZhCRjG99l6Ty/Hrm7gz6qC6AyTGDqHAy15n1
         a9PbnHgMgldX5cNHRcQoBCFzGYWwjJduyEiIbxfVMFZVUgc7AvztRY0U45OyZvWYb5Yr
         Nrqgpp8N4zJiSbKJOKVdvvy0mKL4VB7YX5DBqBWdtAayDHXvbn6LyDm8uKXWTdbUt5cx
         b8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VzO8nxEgM7mMHURmdh1mffLzvh0+3XZWjzkfKmPy+ug=;
        b=rxoCnG/C6JU3Lwv6m3hNAkb/QD9gcylswSteIMsjPA+wKejQe1O9sH8Q33gLbZodi1
         6r1+zIpyFfbJ7OZUIl9tuCv2Uhwz1hmkiFwEQvlRtaNOlP1tNIePZNYR/WGjkFVTGSYK
         IQZBW+xhyhRWfLA+kL41l55dCS1b+eyPqqyLWuU2BJqhcFWCCfiycUKqNmqIyeMvLQ/X
         GlyRWL38bTzNpJHZSNwv2bKqCPMCxnvhLKxcjw+CsS4JOA6rSossy83fEYxp8GeswnSx
         O179aGSn4kSd3+jwRaH1c0nyLoW9RrvOsKaa4Hj9ELSw/u41lhBbwqtPxDy+R6c4mcZ6
         eSvA==
X-Gm-Message-State: AN3rC/68XrtiP2siEy+0aarTw8eronTDo4cYt23zrN9t8KdVn21RNpEn
        cXkBUyuPr6PYwA==
X-Received: by 10.129.197.9 with SMTP id k9mr29730145ywi.69.1493782186204;
        Tue, 02 May 2017 20:29:46 -0700 (PDT)
Received: from localhost.localdomain ([129.59.122.23])
        by smtp.gmail.com with ESMTPSA id v3sm11329586ywi.79.2017.05.02.20.29.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 May 2017 20:29:45 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH 4/7] dir: hide untracked contents of untracked dirs
Date:   Tue,  2 May 2017 22:29:29 -0500
Message-Id: <20170503032932.16043-5-sxlijin@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170503032932.16043-1-sxlijin@gmail.com>
References: <xmqqshkof6jd.fsf@gitster.mtv.corp.google.com>
 <20170503032932.16043-1-sxlijin@gmail.com>
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
---
 dir.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/dir.c b/dir.c
index 25cb9eadf..f0ddb4608 100644
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

