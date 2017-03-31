Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBE4820978
	for <e@80x24.org>; Fri, 31 Mar 2017 14:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933291AbdCaOMK (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 10:12:10 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:45182 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933244AbdCaOMF (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 Mar 2017 10:12:05 -0400
X-AuditID: 12074414-807ff70000002bfd-be-58de63abeae6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id BD.1A.11261.BA36ED85; Fri, 31 Mar 2017 10:11:55 -0400 (EDT)
Received: from bagpipes.fritz.box (p4FEDFA60.dip0.t-ipconnect.de [79.237.250.96])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2VEBRBs010139
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 31 Mar 2017 10:11:53 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 13/20] refs: handle "refs/bisect/" in `loose_fill_ref_dir()`
Date:   Fri, 31 Mar 2017 16:11:11 +0200
Message-Id: <1254a76cd06f6fbf0d5820b7d0ccc148413c4b16.1490966385.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490966385.git.mhagger@alum.mit.edu>
References: <cover.1490966385.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsUixO6iqLs6+V6EwYsDihZrn91hsui60s1k
        0dB7hdni9or5zBZLHr5mtuie8pbR4kdLD7PF5s3tLA4cHn/ff2Dy2DnrLrvHgk2lHl3tR9g8
        nvXuYfS4eEnZ4/MmuQD2KC6blNSczLLUIn27BK6Mya+bWAt+ClRMXH6TrYHxBG8XIyeHhICJ
        xL0XTSxdjFwcQgI7mCSaP7xngnBOMkmcnDubGaSKTUBXYlFPMxOILSKgJjGx7RBYB7PAGyaJ
        A1t+sYAkhAX8Jd4vbwQrYhFQlWh+tJcVxOYViJK4393ADLFOXmJX20WwOKeAhcS6mYfYQWwh
        AXOJBWsnsE1g5FnAyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdCLzezRC81pXQTIyTYRHYw
        Hjkpd4hRgINRiYf3hPe9CCHWxLLiytxDjJIcTEqivL7hQCG+pPyUyozE4oz4otKc1OJDjBIc
        zEoivExxQDnelMTKqtSifJiUNAeLkjjvt8XqfkIC6YklqdmpqQWpRTBZGQ4OJQneiiSgRsGi
        1PTUirTMnBKENBMHJ8hwHqDhC0BqeIsLEnOLM9Mh8qcYFaXEeVlBEgIgiYzSPLheWDJ4xSgO
        9Iow75REoCoeYCKB634FNJgJaLDF17sgg0sSEVJSDYzND/sMHF46pBikmizTvJiuyiz9u5Pj
        6fEYlmM6zzraV81n7qhWfn3U9bvGRAM/yY+q+yYymJ/YaX24RXd5SdP3fcX7QiR5DdjM3p6s
        yglRzX3CXRYs177C4FT+hOJb1b7n9C43dex8NuvTfZNI5k4Wi4oq/bSnhsaWylHTeibGZsub
        la4oV2Ipzkg01GIuKk4EANcyXIbhAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That "refs/bisect/" has to be handled specially when filling the
ref_cache for loose references is a peculiarity of the files backend,
and the ref-cache code shouldn't need to know about it. So move this
code to the callback function, `loose_fill_ref_dir()`.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 15 +++++++++++++++
 refs/ref-cache.c     | 16 ----------------
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index e4d78393ac..7b5f5c1240 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -508,6 +508,21 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 	strbuf_release(&refname);
 	strbuf_release(&path);
 	closedir(d);
+
+	/*
+	 * Manually add refs/bisect, which, being per-worktree, might
+	 * not appear in the directory listing for refs/ in the main
+	 * repo.
+	 */
+	if (!strcmp(dirname, "refs/")) {
+		int pos = search_ref_dir(dir, "refs/bisect/", 12);
+
+		if (pos < 0) {
+			struct ref_entry *child_entry = create_dir_entry(
+					dir->cache, "refs/bisect/", 12, 1);
+			add_entry_to_dir(dir, child_entry);
+		}
+	}
 }
 
 static struct ref_dir *get_loose_refs(struct files_ref_store *refs)
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 7f247b9170..44440e0c13 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -26,22 +26,6 @@ struct ref_dir *get_ref_dir(struct ref_entry *entry)
 			die("BUG: incomplete ref_store without fill_ref_dir function");
 
 		dir->cache->fill_ref_dir(dir->cache->ref_store, dir, entry->name);
-
-		/*
-		 * Manually add refs/bisect, which, being
-		 * per-worktree, might not appear in the directory
-		 * listing for refs/ in the main repo.
-		 */
-		if (!strcmp(entry->name, "refs/")) {
-			int pos = search_ref_dir(dir, "refs/bisect/", 12);
-			if (pos < 0) {
-				struct ref_entry *child_entry;
-				child_entry = create_dir_entry(dir->cache,
-							       "refs/bisect/",
-							       12, 1);
-				add_entry_to_dir(dir, child_entry);
-			}
-		}
 		entry->flag &= ~REF_INCOMPLETE;
 	}
 	return dir;
-- 
2.11.0

