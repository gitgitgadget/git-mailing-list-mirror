Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DBBC2D0D5
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B0320706
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/5ZURlp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfLXLFz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:05:55 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37243 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfLXLFx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 06:05:53 -0500
Received: by mail-qt1-f196.google.com with SMTP id w47so17881897qtk.4
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 03:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YFgXMROkeed/QDYtZ0Ndb0D56tSzSKygOpSe5QnYWm0=;
        b=I/5ZURlp7ko4Qy4FbAK30EGstIVC5hhg98ECD5A1xVrw6m9jKTsOA4PxO9/n9ai6ff
         k6SRrmzyY44aE+6Tvx3viEABZE5LoaHkwuoESwL7Y0XldKPT8aQ84v8OhGPt3+SiOR0j
         E2jV4nxKAYNVpZwOPZUaKBdHpVFJQqoqxaEKGmBHPjtriguhm0qRrMdcCmC7JmhdASWc
         mUIhPDh6xtRKlmg/BYD3D44WKtBDiEwP41CifMZHLEtNLBHiX/N/xdz98eEwriL0ifwg
         lLILjlkvNWXRG+8oWNrREuDVoGNTMb1IIz7FyJdW9ArAcnNx8JZ7IgYheTnoSdJHA1kK
         A7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YFgXMROkeed/QDYtZ0Ndb0D56tSzSKygOpSe5QnYWm0=;
        b=qBXmN9uYlsK/9BykcqYG1dlxORJ7Y9PuRhN/HZderI8lR2cuECO7EY8NYIg3lDxGQi
         XKghir7zgC6mXOp5yfgBP4vg0LA6eTvRQnmRJyzlOKRyinNBfzYTYab5yKXgcy8h3LQ5
         R8UQPbAKXqVyLcKQ/39wvN5d4mrGRJtZqaOisFR0wcQjqyBe7PrLMHZAM0QVx/5zT82l
         chulYfxMr+saVIVHyoDmwG/YtmaYTAeQrvR0ijpMtZIs7T0SmX1iYiyhu+AtWOEYnLkY
         TwSCON9HdFHZbcCFnnuLkP7dA6mxW9BQ9kjf0OV02h3GbE6ukyXQq+P+2LhntGXgz86p
         7A+Q==
X-Gm-Message-State: APjAAAUGkOppH2U7k/hR9gTTf76sRNCTtTPKYzDsChAutw+OugekbLMm
        Q8lk3OdyeFpexLMBAPTgwRZ6T+KD
X-Google-Smtp-Source: APXvYqyun0yvbYimOfw3DBjzoVnviTZ4EccyljhiEcivxevQaAAtVuWLQUGjky5vEvgjd4Vt+RFoVg==
X-Received: by 2002:ac8:6153:: with SMTP id d19mr26358923qtm.18.1577185552470;
        Tue, 24 Dec 2019 03:05:52 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id o19sm7446944qtb.43.2019.12.24.03.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 03:05:52 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 06/17] rebase: use read_oneliner()
Date:   Tue, 24 Dec 2019 06:05:03 -0500
Message-Id: <06c5bd48d767ff5dce45bebb58505888745af861.1577185374.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1577185374.git.liu.denton@gmail.com>
References: <cover.1571246693.git.liu.denton@gmail.com> <cover.1577185374.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since in sequencer.c, read_one() basically duplicates the functionality
of read_oneliner(), reduce code duplication by replacing read_one() with
read_oneliner().

This was done with the following Coccinelle script:

	@@
	expression a, b;
	@@
	- read_one(a, b)
	+ !read_oneliner(b, a, 0, 1)

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/rebase.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index ddf33bc9d4..68bedccb95 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -582,15 +582,6 @@ static const char *state_dir_path(const char *filename, struct rebase_options *o
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
@@ -598,8 +589,8 @@ static int read_basic_state(struct rebase_options *opts)
 	struct strbuf buf = STRBUF_INIT;
 	struct object_id oid;
 
-	if (read_one(state_dir_path("head-name", opts), &head_name) ||
-	    read_one(state_dir_path("onto", opts), &buf))
+	if (!read_oneliner(&head_name, state_dir_path("head-name", opts), 0, 1) ||
+	    !read_oneliner(&buf, state_dir_path("onto", opts), 0, 1))
 		return -1;
 	opts->head_name = starts_with(head_name.buf, "refs/") ?
 		xstrdup(head_name.buf) : NULL;
@@ -615,9 +606,9 @@ static int read_basic_state(struct rebase_options *opts)
 	 */
 	strbuf_reset(&buf);
 	if (file_exists(state_dir_path("orig-head", opts))) {
-		if (read_one(state_dir_path("orig-head", opts), &buf))
+		if (!read_oneliner(&buf, state_dir_path("orig-head", opts), 0, 1))
 			return -1;
-	} else if (read_one(state_dir_path("head", opts), &buf))
+	} else if (!read_oneliner(&buf, state_dir_path("head", opts), 0, 1))
 		return -1;
 	if (get_oid(buf.buf, &opts->orig_head))
 		return error(_("invalid orig-head: '%s'"), buf.buf);
@@ -637,8 +628,7 @@ static int read_basic_state(struct rebase_options *opts)
 
 	if (file_exists(state_dir_path("allow_rerere_autoupdate", opts))) {
 		strbuf_reset(&buf);
-		if (read_one(state_dir_path("allow_rerere_autoupdate", opts),
-			    &buf))
+		if (!read_oneliner(&buf, state_dir_path("allow_rerere_autoupdate", opts), 0, 1))
 			return -1;
 		if (!strcmp(buf.buf, "--rerere-autoupdate"))
 			opts->allow_rerere_autoupdate = RERERE_AUTOUPDATE;
@@ -651,8 +641,7 @@ static int read_basic_state(struct rebase_options *opts)
 
 	if (file_exists(state_dir_path("gpg_sign_opt", opts))) {
 		strbuf_reset(&buf);
-		if (read_one(state_dir_path("gpg_sign_opt", opts),
-			    &buf))
+		if (!read_oneliner(&buf, state_dir_path("gpg_sign_opt", opts), 0, 1))
 			return -1;
 		free(opts->gpg_sign_opt);
 		opts->gpg_sign_opt = xstrdup(buf.buf);
@@ -660,7 +649,7 @@ static int read_basic_state(struct rebase_options *opts)
 
 	if (file_exists(state_dir_path("strategy", opts))) {
 		strbuf_reset(&buf);
-		if (read_one(state_dir_path("strategy", opts), &buf))
+		if (!read_oneliner(&buf, state_dir_path("strategy", opts), 0, 1))
 			return -1;
 		free(opts->strategy);
 		opts->strategy = xstrdup(buf.buf);
@@ -668,7 +657,7 @@ static int read_basic_state(struct rebase_options *opts)
 
 	if (file_exists(state_dir_path("strategy_opts", opts))) {
 		strbuf_reset(&buf);
-		if (read_one(state_dir_path("strategy_opts", opts), &buf))
+		if (!read_oneliner(&buf, state_dir_path("strategy_opts", opts), 0, 1))
 			return -1;
 		free(opts->strategy_opts);
 		opts->strategy_opts = xstrdup(buf.buf);
@@ -720,7 +709,7 @@ static int apply_autostash(struct rebase_options *opts)
 	if (!file_exists(path))
 		return 0;
 
-	if (read_one(path, &autostash))
+	if (!read_oneliner(&autostash, path, 0, 1))
 		return error(_("Could not read '%s'"), path);
 	/* Ensure that the hash is not mistaken for a number */
 	strbuf_addstr(&autostash, "^0");
-- 
2.24.1.810.g65a2f617f4

