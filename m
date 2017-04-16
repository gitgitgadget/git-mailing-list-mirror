Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6438220A04
	for <e@80x24.org>; Sun, 16 Apr 2017 06:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755357AbdDPGmx (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 02:42:53 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:56017 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755274AbdDPGmw (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Apr 2017 02:42:52 -0400
X-AuditID: 12074413-f67ff700000077e1-c5-58f3126a0330
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id F6.87.30689.A6213F85; Sun, 16 Apr 2017 02:42:50 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B1058DF.dip0.t-ipconnect.de [91.16.88.223])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3G6gGNE025813
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 16 Apr 2017 02:42:48 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 13/20] refs: handle "refs/bisect/" in `loose_fill_ref_dir()`
Date:   Sun, 16 Apr 2017 08:41:35 +0200
Message-Id: <a9e8ff585fe4ebd5f0b3e135f254034725d29478.1492323985.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1492323985.git.mhagger@alum.mit.edu>
References: <cover.1492323985.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsUixO6iqJst9DnCYP9VNou1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfGmrWbmAp+ClSsutnG3sB4greLkZNDQsBE
        4tzE+8xdjFwcQgI7mCReL7rCCOGcYJJ4vOU3M0gVm4CuxKKeZiYQW0RATWJi2yEWkCJmgcdM
        En+XdbOAJIQF/CWmTrsEZrMIqEocPHaTFcTmFYiSOPx+HzPEOnmJXW0XweKcAhYSU+5uAKsX
        EjCX2H78KvMERp4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3TN9XIzS/RSU0o3MUKCTXgH
        466TcocYBTgYlXh4Lfw/RQixJpYVV+YeYpTkYFIS5ZX5DxTiS8pPqcxILM6ILyrNSS0+xCjB
        wawkwpvM8jlCiDclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwRstCNQo
        WJSanlqRlplTgpBm4uAEGc4DNDwdpIa3uCAxtzgzHSJ/ilFRSpz3hwBQQgAkkVGaB9cLSwav
        GMWBXhHmrQVp5wEmErjuV0CDmYAGM0z+ADK4JBEhJdXAaBlsfVZyr/bjuDVlq+PXLM7YZbKy
        45vZ/ruTAiJbXJ1PTr8r5Vuj/VPX+pNA+Wa2tYqFjYf05x1pbbpx4Ucj414fDrP9TokMH7Zd
        jXF/w3tiwQaf6sMH0wWP+k5aUPOmQbSCWStxqcIZka2nnMsV5j1q1Qw+sOqjxEeLyiX52zf2
        vD5U8XvdVCWW4oxEQy3mouJEAJxdtu7hAgAA
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
index ff9251b9cd..079ba941ef 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -507,6 +507,21 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
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

