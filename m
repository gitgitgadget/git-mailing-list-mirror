Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D78A21F403
	for <e@80x24.org>; Tue,  5 Jun 2018 20:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752581AbeFEUsK (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 16:48:10 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39580 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751941AbeFEUsI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 16:48:08 -0400
Received: by mail-wr0-f195.google.com with SMTP id w7-v6so3846976wrn.6
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 13:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wFywTKRMq/FsFi2f9H+uhfh7NqW9efD0oc12Tquhn+s=;
        b=um2lIzNUrqfcvgVU3uZa4G0e8Givffo8hClwdTyALQOfHpfigy577IY/QDT7Sgv8qz
         TiaRMoMVFfoXu2ri5gZKS23GXBSDSNWvrIKFHaE1ceTHIwJ04T0vlZvcZScu6qljL/mf
         GyyDxbwLIgHxB+ub1nai5pv+Kckr9ybpa1rPQrfLs05HdkNLIX209hileKiE6UM6vVic
         1kCEQYjLV9Mb8M+NrUIMCTe8OeYUHTQMmrIKtYdaZiejxRSlUbK9U3LE4DzdQbG4tKhS
         aqLiVai3ZDZXiDAyK6o5bxA/TRI4t1qQY0PkMo2R5+whLjPyouWQKyy9axLIt6czdDFS
         5Qvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wFywTKRMq/FsFi2f9H+uhfh7NqW9efD0oc12Tquhn+s=;
        b=CCAny3xKgSyOKyeATW2PkCGGysK+xxJ5fyBO3zhTvmUJOcjOu34u/ozec3E8H4loPL
         dKY7CgdzdxslftUcWG8tCRtR+jOE1wCPRvzop0pvNwCGluekQj2ZfVRNIt6tcPQX7d6b
         cQ2w9mQrh4xDvKXioWJwkR2KziYqiwOLULSM4vzGDNTDQbIcZHP4J843WusvKlkISer/
         goBq4xEMYtTdL8SX6zoUD0dubiuEpg8/SbROT5/P2RQYXv9tku6rJeVPxdnqBEnytzz5
         iJYsyPN0QEIgRn6t54BSGDKJiWJnFIGUAwuSd2Rs9WFqelr0DCmCvULN/QUSeyGzY5ck
         75uw==
X-Gm-Message-State: APt69E1WxkHjW0J/TN1CGx3ETuitozT4uyj6beG86B+FuIby3eiYu1ZF
        fgdiYeBKmX1bb39QztkS6TzO/dik
X-Google-Smtp-Source: ADUXVKKJfqShgVxkrka3O7KrptCSooZhbdgYb9eJW7ly0bQwEqGCGbCXBEFIQe9yti4LFD+TsKaRNA==
X-Received: by 2002:adf:8af5:: with SMTP id z50-v6mr132878wrz.22.1528231686320;
        Tue, 05 Jun 2018 13:48:06 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id u11-v6sm3347083wmd.7.2018.06.05.13.48.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 13:48:05 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 07/10] rerere: only return whether a path has conflicts or not
Date:   Tue,  5 Jun 2018 22:52:16 +0100
Message-Id: <20180605215219.28783-8-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.410.g65aef3a6c4
In-Reply-To: <20180605215219.28783-1-t.gummerer@gmail.com>
References: <20180520211210.1248-1-t.gummerer@gmail.com>
 <20180605215219.28783-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We currently return the exact number of conflict hunks a certain path
has from the 'handle_paths' function.  However all of its callers only
care whether there are conflicts or not or if there is an error.
Return only that information, and document that only that information
is returned.  This will simplify the code in the subsequent steps.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 rerere.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/rerere.c b/rerere.c
index 220020187b..da3744b86b 100644
--- a/rerere.c
+++ b/rerere.c
@@ -393,12 +393,13 @@ static int is_cmarker(char *buf, int marker_char, int marker_size)
  * one side of the conflict, NUL, the other side of the conflict,
  * and NUL concatenated together.
  *
- * Return the number of conflict hunks found.
+ * Return 1 if conflict hunks are found, 0 if there are no conflict
+ * hunks and -1 if an error occured.
  */
 static int handle_path(unsigned char *sha1, struct rerere_io *io, int marker_size)
 {
 	git_SHA_CTX ctx;
-	int hunk_no = 0;
+	int has_conflicts = 0;
 	enum {
 		RR_CONTEXT = 0, RR_SIDE_1, RR_SIDE_2, RR_ORIGINAL
 	} hunk = RR_CONTEXT;
@@ -426,7 +427,7 @@ static int handle_path(unsigned char *sha1, struct rerere_io *io, int marker_siz
 				goto bad;
 			if (strbuf_cmp(&one, &two) > 0)
 				strbuf_swap(&one, &two);
-			hunk_no++;
+			has_conflicts = 1;
 			hunk = RR_CONTEXT;
 			rerere_io_putconflict('<', marker_size, io);
 			rerere_io_putmem(one.buf, one.len, io);
@@ -462,7 +463,7 @@ static int handle_path(unsigned char *sha1, struct rerere_io *io, int marker_siz
 		git_SHA1_Final(sha1, &ctx);
 	if (hunk != RR_CONTEXT)
 		return -1;
-	return hunk_no;
+	return has_conflicts;
 }
 
 /*
@@ -471,7 +472,7 @@ static int handle_path(unsigned char *sha1, struct rerere_io *io, int marker_siz
  */
 static int handle_file(const char *path, unsigned char *sha1, const char *output)
 {
-	int hunk_no = 0;
+	int has_conflicts = 0;
 	struct rerere_io_file io;
 	int marker_size = ll_merge_marker_size(path);
 
@@ -491,7 +492,7 @@ static int handle_file(const char *path, unsigned char *sha1, const char *output
 		}
 	}
 
-	hunk_no = handle_path(sha1, (struct rerere_io *)&io, marker_size);
+	has_conflicts = handle_path(sha1, (struct rerere_io *)&io, marker_size);
 
 	fclose(io.input);
 	if (io.io.wrerror)
@@ -500,14 +501,14 @@ static int handle_file(const char *path, unsigned char *sha1, const char *output
 	if (io.io.output && fclose(io.io.output))
 		io.io.wrerror = error_errno(_("failed to flush '%s'"), path);
 
-	if (hunk_no < 0) {
+	if (has_conflicts < 0) {
 		if (output)
 			unlink_or_warn(output);
 		return error(_("could not parse conflict hunks in '%s'"), path);
 	}
 	if (io.io.wrerror)
 		return -1;
-	return hunk_no;
+	return has_conflicts;
 }
 
 /*
@@ -955,7 +956,7 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 	mmfile_t mmfile[3] = {{NULL}};
 	mmbuffer_t result = {NULL, 0};
 	const struct cache_entry *ce;
-	int pos, len, i, hunk_no;
+	int pos, len, i, has_conflicts;
 	struct rerere_io_mem io;
 	int marker_size = ll_merge_marker_size(path);
 
@@ -1009,11 +1010,11 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 	 * Grab the conflict ID and optionally write the original
 	 * contents with conflict markers out.
 	 */
-	hunk_no = handle_path(sha1, (struct rerere_io *)&io, marker_size);
+	has_conflicts = handle_path(sha1, (struct rerere_io *)&io, marker_size);
 	strbuf_release(&io.input);
 	if (io.io.output)
 		fclose(io.io.output);
-	return hunk_no;
+	return has_conflicts;
 }
 
 static int rerere_forget_one_path(const char *path, struct string_list *rr)
-- 
2.17.0.410.g65aef3a6c4

