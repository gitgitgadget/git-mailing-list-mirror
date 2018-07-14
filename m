Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 146B01F915
	for <e@80x24.org>; Sat, 14 Jul 2018 21:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731609AbeGNWF1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jul 2018 18:05:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32953 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731432AbeGNWF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jul 2018 18:05:27 -0400
Received: by mail-wm0-f66.google.com with SMTP id z6-v6so7042596wma.0
        for <git@vger.kernel.org>; Sat, 14 Jul 2018 14:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=evuS5y4GpmPO35cgQ06Y1M+psehLpZZpMXEARRO6QEI=;
        b=ott3i07cmEi71lb5dzKde84OnHv7wUpFChy3II+bsN7S9qk2S+12q5Uu0M5Hz1ahb2
         p7TD8SX6rrDnaqWRqwq/kNj/Y1XGyq0kGhHku2R5+tuak4G5hCKEWK6RAR5As+2HGs1H
         y//5qHuvcXj8Rhc1eT5ab63oaVygQJ/kdEXjQG760qOM1Lt5J13CYsDqI95imIx43VRQ
         FTtPNIY7IeDeXKyJid9LIzfMdsjzK+rAOOSIAm0TpP/FzKpOo0C1+mLQ/AdJ/+ZQZLET
         YR9AzZh2D7wWzbJxUtsbcX1K4k9coZcjlq6hq9Tuw/8vqgsffBI8YsUipTfG8h3H56xw
         UYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=evuS5y4GpmPO35cgQ06Y1M+psehLpZZpMXEARRO6QEI=;
        b=cbn3DWrMs95euGu6ND0kWY4DSX4DmUKb1QShS3VlY4pxyp03KezzIDMcRifryFjeVf
         F9LZxQoW5Ws+cJ2FhN85lKid7cP5rxjzue+iHq3Xbv/I7pm0VCeoVbYkeTzGcg0Qkcch
         Dxgrpa9a6/nLHRyUT16FQ7N0zc3nm/pcexsEqBYgLLEU1N4sXYpfug0dlGfPPGRKalNI
         uY5DnU/wuioMeRT36SMAWGa5ZNx1yOZ3grEqqp1t7CNUQzerHTtyTcmiUPn+UfVvT7ss
         tjx/IiNlRghepITr7eq4z1UcVLMARxJnjRIzcBTmnxGTwOXDGzHnicc7ANlQPrzT666R
         YrVQ==
X-Gm-Message-State: AOUpUlEJIbBX6BnEVTfNJiOY1jigx8OoT1lQLF98gdkgXik4V4g3ic+o
        EsTnk4evHcN3oFZ7KZ9GDcktdwLB
X-Google-Smtp-Source: AAOMgpeqEsrEp1ZER8upw6rYVLxasNZfxDll1+Lnu2GX2mZKPpnAeGS/MQn2QKO1IAycirWAxXphBw==
X-Received: by 2002:a1c:ec1b:: with SMTP id k27-v6mr6414323wmh.157.1531604699953;
        Sat, 14 Jul 2018 14:44:59 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id y203-v6sm16767149wme.42.2018.07.14.14.44.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Jul 2018 14:44:59 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 07/11] rerere: only return whether a path has conflicts or not
Date:   Sat, 14 Jul 2018 22:44:39 +0100
Message-Id: <20180714214443.7184-8-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.410.g65aef3a6c4
In-Reply-To: <20180714214443.7184-1-t.gummerer@gmail.com>
References: <20180605215219.28783-1-t.gummerer@gmail.com>
 <20180714214443.7184-1-t.gummerer@gmail.com>
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
index 895ad80c0c..bf803043e2 100644
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
@@ -954,7 +955,7 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 	mmfile_t mmfile[3] = {{NULL}};
 	mmbuffer_t result = {NULL, 0};
 	const struct cache_entry *ce;
-	int pos, len, i, hunk_no;
+	int pos, len, i, has_conflicts;
 	struct rerere_io_mem io;
 	int marker_size = ll_merge_marker_size(path);
 
@@ -1008,11 +1009,11 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
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

