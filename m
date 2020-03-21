Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E481C54EEB
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A312070A
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tZwCQPaD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgCUJWX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 05:22:23 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34458 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgCUJWW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 05:22:22 -0400
Received: by mail-qk1-f196.google.com with SMTP id i6so750198qke.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 02:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BVUCGP0h63x/93nH/Byok+kuU1ZmeApiq/kH5F0BVso=;
        b=tZwCQPaD7JrdQDtg+JL6N8kn8YLgK3D1mZ54NnyJFT/zUjhtUa8IgXgERFujlwODga
         A7vhLk3KpH02DthyN1X75YT33EpxoF9HF4krWaFYKFSX++ZFm/mNf9XPXdTa5OKqlshd
         PpIMmyONnIFB0jDJMh+oghYdAHImX9r5weSNmBHmz82czFMRFu2nqlekTl1E3uQpeeFv
         UdekjSn5nkO3wLH1l+5n1OMHnEUadIoLaVpDyFhrpqLDzVXA7PXlEXMKAgnuQlJj5ZqO
         QN3EViIgKjqjsn/YAEAuGJv49V2PiUu/QJzQA+lBZjSxJykQV62mDdrrNJc1mzvlN48T
         pSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BVUCGP0h63x/93nH/Byok+kuU1ZmeApiq/kH5F0BVso=;
        b=Krgm2ITT7Ne1cRiAH97LDf+a0eDOxemP14IZs0Wun5zp3CtiWnbmhWXWAK0xq0jl37
         8CIkRWxEGB+VkbzscD+bLO1J0DIT6KOKCHViTkm8b409LMV/TTBM1U3vq3YZhbSRxiEv
         qMkJUxThrTEGwiixd0/B8sJFZTZrHsDQ50/Db/SE6wl34YYdDon4GFNRfaxwW5O38vzN
         ZqIsArYqxPLmAx4MabQnv7mYR2ts6Zuuc6xT7gy+DMcXU+QqTwlWO8sdq3P2mjWpnk6b
         jCkIBz4t2ttTI0SaljULCPi+vNOyA7nDqqYnlW+h4/XtsMiwha1jhOJWvftma7K1cYia
         C3kA==
X-Gm-Message-State: ANhLgQ2so/CgFU9NOWjgNzz1rAkYGQkpe76SQ0dsfLHhjhsh56RP8SNB
        d41x4aJKMCEW7laaEiBfOjvVdlQ1
X-Google-Smtp-Source: ADFU+vt281c5ZTd9FOcnlpjOORL912lDoTYSCtpHGABcWl+ytidK49/fdq+OKNK9Y9cUgPKwWGH2/g==
X-Received: by 2002:a05:620a:15d1:: with SMTP id o17mr11455702qkm.457.1584782541253;
        Sat, 21 Mar 2020 02:22:21 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id z23sm6579890qkg.21.2020.03.21.02.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 02:22:20 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 07/19] rebase: use read_oneliner()
Date:   Sat, 21 Mar 2020 05:21:26 -0400
Message-Id: <d07a50c5b22128263aaa8eef94546fe8bc8a9ec8.1584782450.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca878e0
In-Reply-To: <cover.1584782450.git.liu.denton@gmail.com>
References: <cover.1577185374.git.liu.denton@gmail.com> <cover.1584782450.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since in sequencer.c, read_one() basically duplicates the functionality
of read_oneliner(), reduce code duplication by replacing read_one() with
read_oneliner().

This was done with the following Coccinelle script

	@@
	expression a, b;
	@@
	- read_one(a, b)
	+ !read_oneliner(b, a, READ_ONELINER_WARN_NON_EXISTENCE)

and long lines were manually broken up.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/rebase.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index bff53d5d16..1146463099 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -586,15 +586,6 @@ static const char *state_dir_path(const char *filename, struct rebase_options *o
 	return path.buf;
 }
 
-/* Read one file, then strip line endings */
-static int read_one(const char *path, struct strbuf *buf)
-{
-	if (strbuf_read_file(buf, path, 0) < 0)
-		return error_errno(_("could not read '%s'"), path);
-	strbuf_trim_trailing_newline(buf);
-	return 0;
-}
-
 /* Initialize the rebase options from the state directory. */
 static int read_basic_state(struct rebase_options *opts)
 {
@@ -602,8 +593,10 @@ static int read_basic_state(struct rebase_options *opts)
 	struct strbuf buf = STRBUF_INIT;
 	struct object_id oid;
 
-	if (read_one(state_dir_path("head-name", opts), &head_name) ||
-	    read_one(state_dir_path("onto", opts), &buf))
+	if (!read_oneliner(&head_name, state_dir_path("head-name", opts),
+			   READ_ONELINER_WARN_NON_EXISTENCE) ||
+	    !read_oneliner(&buf, state_dir_path("onto", opts),
+			   READ_ONELINER_WARN_NON_EXISTENCE))
 		return -1;
 	opts->head_name = starts_with(head_name.buf, "refs/") ?
 		xstrdup(head_name.buf) : NULL;
@@ -619,9 +612,11 @@ static int read_basic_state(struct rebase_options *opts)
 	 */
 	strbuf_reset(&buf);
 	if (file_exists(state_dir_path("orig-head", opts))) {
-		if (read_one(state_dir_path("orig-head", opts), &buf))
+		if (!read_oneliner(&buf, state_dir_path("orig-head", opts),
+				   READ_ONELINER_WARN_NON_EXISTENCE))
 			return -1;
-	} else if (read_one(state_dir_path("head", opts), &buf))
+	} else if (!read_oneliner(&buf, state_dir_path("head", opts),
+				  READ_ONELINER_WARN_NON_EXISTENCE))
 		return -1;
 	if (get_oid(buf.buf, &opts->orig_head))
 		return error(_("invalid orig-head: '%s'"), buf.buf);
@@ -641,8 +636,8 @@ static int read_basic_state(struct rebase_options *opts)
 
 	if (file_exists(state_dir_path("allow_rerere_autoupdate", opts))) {
 		strbuf_reset(&buf);
-		if (read_one(state_dir_path("allow_rerere_autoupdate", opts),
-			    &buf))
+		if (!read_oneliner(&buf, state_dir_path("allow_rerere_autoupdate", opts),
+				   READ_ONELINER_WARN_NON_EXISTENCE))
 			return -1;
 		if (!strcmp(buf.buf, "--rerere-autoupdate"))
 			opts->allow_rerere_autoupdate = RERERE_AUTOUPDATE;
@@ -655,8 +650,8 @@ static int read_basic_state(struct rebase_options *opts)
 
 	if (file_exists(state_dir_path("gpg_sign_opt", opts))) {
 		strbuf_reset(&buf);
-		if (read_one(state_dir_path("gpg_sign_opt", opts),
-			    &buf))
+		if (!read_oneliner(&buf, state_dir_path("gpg_sign_opt", opts),
+				   READ_ONELINER_WARN_NON_EXISTENCE))
 			return -1;
 		free(opts->gpg_sign_opt);
 		opts->gpg_sign_opt = xstrdup(buf.buf);
@@ -664,7 +659,8 @@ static int read_basic_state(struct rebase_options *opts)
 
 	if (file_exists(state_dir_path("strategy", opts))) {
 		strbuf_reset(&buf);
-		if (read_one(state_dir_path("strategy", opts), &buf))
+		if (!read_oneliner(&buf, state_dir_path("strategy", opts),
+				   READ_ONELINER_WARN_NON_EXISTENCE))
 			return -1;
 		free(opts->strategy);
 		opts->strategy = xstrdup(buf.buf);
@@ -672,7 +668,8 @@ static int read_basic_state(struct rebase_options *opts)
 
 	if (file_exists(state_dir_path("strategy_opts", opts))) {
 		strbuf_reset(&buf);
-		if (read_one(state_dir_path("strategy_opts", opts), &buf))
+		if (!read_oneliner(&buf, state_dir_path("strategy_opts", opts),
+				   READ_ONELINER_WARN_NON_EXISTENCE))
 			return -1;
 		free(opts->strategy_opts);
 		opts->strategy_opts = xstrdup(buf.buf);
@@ -724,7 +721,7 @@ static int apply_autostash(struct rebase_options *opts)
 	if (!file_exists(path))
 		return 0;
 
-	if (read_one(path, &autostash))
+	if (!read_oneliner(&autostash, path, READ_ONELINER_WARN_NON_EXISTENCE))
 		return error(_("Could not read '%s'"), path);
 	/* Ensure that the hash is not mistaken for a number */
 	strbuf_addstr(&autostash, "^0");
-- 
2.25.0.114.g5b0ca878e0

