Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022A0C43331
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C312020731
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYOLjNVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgDDBMK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:12:10 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36979 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgDDBMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 21:12:09 -0400
Received: by mail-qk1-f195.google.com with SMTP id x3so10213531qki.4
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 18:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0BecW6VR8q+Mh1gBmcoBsRAHGRyq7eUcW1jl4/aKCP0=;
        b=gYOLjNVTiTXYBwGbGGy66MCDqpW3axe5G55WcEg7OS3pGZXryNxKdAZbfB6eayozFQ
         uXBnmuKs/KQICAqCNvHy/dNvEhZ51cIQhniyQYzUpwPRD5vti8IF6671zRzOQvptLDw4
         X54v8SUXrsinwtKkUOFfLcI1eRSxt2JXuFEwjsDFKXlVuCoj6L4e03WrElqRMISioldZ
         SH3jJtNDLHPyVQoI9psCHlf3TepNsocbASCHuQajshbR5g0D6cAGu5yvu+kGbmPhGGoB
         jrQHIq/nudX49HIf04OwRIo8/Sq5MfPzSRysctocdebMYWnx/4fN7am4mMi94lL8FhtC
         TxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0BecW6VR8q+Mh1gBmcoBsRAHGRyq7eUcW1jl4/aKCP0=;
        b=pkNuQKlyRgxCJ6JwMkjRIL3i1LxvdWAZvQv1KfRCXO8HIz+LE3stAEMBwxhW3dSvEL
         TebbzatDZenLE6XhPSV1mdcOd3nbqBI6ekFkTjq/H9zhyqMGAkdS9HJFZq5fmQIeeduH
         8pMgl+qhEjRdFc24axJS+mEl6ICEZSCPzVecK/QS6PEB74HuJrdjjqSfLAL0FF0FrTjT
         C12v35+4tnzbk5BtJKxmujud8cHwgvhviPLE/GwL8kk/ZRopQEatcyAKlvlui0iDCs0i
         La8IiTEZ8Fuvhg1K0Auu1BA1NNnQVgqVJMYnvZPcOSb64wt4CL3kIeWO/ZwKWqX9gTmL
         HDwg==
X-Gm-Message-State: AGi0PuYBEUEBY57G2K2221c/+QeDgL28EGAFWPjL3PDhB2O9dmbpVrqc
        rw/5cvgN2d6ttTOQueDrrUiHyReB
X-Google-Smtp-Source: APiQypKed/TK5kXNjBwpKq7j6J766V8v2FZR9CQLRpp0arng2DL7Dsyt0ime8aVum4AKmI2qW9xaBw==
X-Received: by 2002:ae9:e711:: with SMTP id m17mr12044052qka.129.1585962728237;
        Fri, 03 Apr 2020 18:12:08 -0700 (PDT)
Received: from localhost.localdomain (ktnron0919w-grc-01-76-68-143-128.dsl.bell.ca. [76.68.143.128])
        by smtp.gmail.com with ESMTPSA id a136sm3297503qkc.75.2020.04.03.18.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 18:12:07 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 09/23] rebase: use read_oneliner()
Date:   Fri,  3 Apr 2020 21:11:22 -0400
Message-Id: <689f34a2a56242d20f8692281847a5ff7aed36e3.1585962673.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585962672.git.liu.denton@gmail.com>
References: <cover.1584782450.git.liu.denton@gmail.com> <cover.1585962672.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since in sequencer.c, read_one() basically duplicates the functionality
of read_oneliner(), reduce code duplication by replacing read_one() with
read_oneliner(). Also, delete strbuf_reset() calls prior to
read_oneliner() as read_oneliner() already resets the strbuf.

This was mostly done with the following Coccinelle script

	@@
	expression a, b;
	@@
	- read_one(a, b)
	+ !read_oneliner(b, a, READ_ONELINER_WARN_NON_EXISTENCE)

Long lines were broken up and strbuf_reset()s were deleted manually.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/rebase.c | 42 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index bff53d5d16..91873fa0b5 100644
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
+			   READ_ONELINER_WARN_MISSING) ||
+	    !read_oneliner(&buf, state_dir_path("onto", opts),
+			   READ_ONELINER_WARN_MISSING))
 		return -1;
 	opts->head_name = starts_with(head_name.buf, "refs/") ?
 		xstrdup(head_name.buf) : NULL;
@@ -617,11 +610,12 @@ static int read_basic_state(struct rebase_options *opts)
 	 * head. Fall back to reading from head to cover for the case that the
 	 * user upgraded git with an ongoing interactive rebase.
 	 */
-	strbuf_reset(&buf);
 	if (file_exists(state_dir_path("orig-head", opts))) {
-		if (read_one(state_dir_path("orig-head", opts), &buf))
+		if (!read_oneliner(&buf, state_dir_path("orig-head", opts),
+				   READ_ONELINER_WARN_MISSING))
 			return -1;
-	} else if (read_one(state_dir_path("head", opts), &buf))
+	} else if (!read_oneliner(&buf, state_dir_path("head", opts),
+				  READ_ONELINER_WARN_MISSING))
 		return -1;
 	if (get_oid(buf.buf, &opts->orig_head))
 		return error(_("invalid orig-head: '%s'"), buf.buf);
@@ -640,9 +634,8 @@ static int read_basic_state(struct rebase_options *opts)
 	}
 
 	if (file_exists(state_dir_path("allow_rerere_autoupdate", opts))) {
-		strbuf_reset(&buf);
-		if (read_one(state_dir_path("allow_rerere_autoupdate", opts),
-			    &buf))
+		if (!read_oneliner(&buf, state_dir_path("allow_rerere_autoupdate", opts),
+				   READ_ONELINER_WARN_MISSING))
 			return -1;
 		if (!strcmp(buf.buf, "--rerere-autoupdate"))
 			opts->allow_rerere_autoupdate = RERERE_AUTOUPDATE;
@@ -654,25 +647,24 @@ static int read_basic_state(struct rebase_options *opts)
 	}
 
 	if (file_exists(state_dir_path("gpg_sign_opt", opts))) {
-		strbuf_reset(&buf);
-		if (read_one(state_dir_path("gpg_sign_opt", opts),
-			    &buf))
+		if (!read_oneliner(&buf, state_dir_path("gpg_sign_opt", opts),
+				   READ_ONELINER_WARN_MISSING))
 			return -1;
 		free(opts->gpg_sign_opt);
 		opts->gpg_sign_opt = xstrdup(buf.buf);
 	}
 
 	if (file_exists(state_dir_path("strategy", opts))) {
-		strbuf_reset(&buf);
-		if (read_one(state_dir_path("strategy", opts), &buf))
+		if (!read_oneliner(&buf, state_dir_path("strategy", opts),
+				   READ_ONELINER_WARN_MISSING))
 			return -1;
 		free(opts->strategy);
 		opts->strategy = xstrdup(buf.buf);
 	}
 
 	if (file_exists(state_dir_path("strategy_opts", opts))) {
-		strbuf_reset(&buf);
-		if (read_one(state_dir_path("strategy_opts", opts), &buf))
+		if (!read_oneliner(&buf, state_dir_path("strategy_opts", opts),
+				   READ_ONELINER_WARN_MISSING))
 			return -1;
 		free(opts->strategy_opts);
 		opts->strategy_opts = xstrdup(buf.buf);
@@ -724,7 +716,7 @@ static int apply_autostash(struct rebase_options *opts)
 	if (!file_exists(path))
 		return 0;
 
-	if (read_one(path, &autostash))
+	if (!read_oneliner(&autostash, path, READ_ONELINER_WARN_MISSING))
 		return error(_("Could not read '%s'"), path);
 	/* Ensure that the hash is not mistaken for a number */
 	strbuf_addstr(&autostash, "^0");
-- 
2.26.0.159.g23e2136ad0

