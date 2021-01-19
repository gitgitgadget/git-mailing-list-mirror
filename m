Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47612C433E6
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 19:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF5D62310B
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 19:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392173AbhAST4N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 14:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392094AbhASTzU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 14:55:20 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37147C061795
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:54:06 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a9so17468744wrt.5
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ygk2dHvdie6xocUMSQuhzWjXnVGU//ctbHvZdY9sPug=;
        b=YkXf3GN8BR6j1WD6DoEhQ/i6+bBrYkDDYOZktpHvz5O29cwrAEgCvm3e/cw59SOekh
         nhwnPqJ4rt1C/7ExAVNPgZZfKFQr2V3kro64A4BOV0f5s+/4tztTu+yUGMYsodd/AoVs
         V1GzqbofG9AQxxNSkqA7NFYZtEp9M15WiGSJlBIbH3s+QLaUS7JlPr67W+l4tU0yaRka
         Ewm6aPzGD1IlhbLQiAU30tZEAbsX6a0x+qVxO+PoF/50CVSZCErijvrUSc6Fnir8Z2B0
         6rt2RPemUhu1wEvK7247cbmebQMxDMFFc6rEvzFPyS6uRNcTEjWiSOWpdEjNqP3qW8Me
         2v3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ygk2dHvdie6xocUMSQuhzWjXnVGU//ctbHvZdY9sPug=;
        b=M91AbqbHYppsHy4J0CLIub4H0aMsjf2Hn4uds2WDVe0gG/RsdDS3CEkK3g/zkEbuGg
         zT3HmVjPkQ3LsHaQi/gpDPUvl+p1KH/04xwhWf7qYltruevh12WfSM+18EOtA2dDB5ba
         J4/phdcRA3JNtuErTLxC8ioqgL8wlwUCdMB3z6Mcr5yg6GwOBah/b6zxGfc8QvRitwqr
         qBNedun693R3xtaoJEOzAz/KXUvxhwtN+a719PYsUlyGYmib8ljLY7tVVxh7MFCXPZq8
         oS12RzYglqLe59IfoneBu25dRMXCN7OHW5LVZoVEPFm7FmvrglMBZQ4fEZPp/zjukEmy
         dv/A==
X-Gm-Message-State: AOAM532FCsVVDB7E9Bg0Er9CXjWV+4+4C/bNLa0VCJk/SQMn0bML4FJ1
        yMbJTEBPwPobUjGRgmV2BmoX92+2rIE=
X-Google-Smtp-Source: ABdhPJxT2phcROoy6LeaJIOnbr1jPz3zTuP2j6L5uYgSE7UyU4FOJUsygj1DtC6OoiGUEWDfzrfcIQ==
X-Received: by 2002:a5d:4f0e:: with SMTP id c14mr5919544wru.84.1611086044826;
        Tue, 19 Jan 2021 11:54:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s25sm41176997wrs.49.2021.01.19.11.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 11:54:04 -0800 (PST)
Message-Id: <95f6e11907240b1cd7772d358fb4ad580de3b506.1611086033.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v3.git.1611086033.gitgitgadget@gmail.com>
References: <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
        <pull.835.v3.git.1611086033.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jan 2021 19:53:47 +0000
Subject: [PATCH v3 11/17] merge-ort: implement apply_dir_rename() and
 check_dir_renamed()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Both of these are copied from merge-recursive.c, with just minor tweaks
due to using strmap API and not having a non_unique_new_dir field.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 22028d57f3d..db922272edf 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -736,7 +736,29 @@ struct collision_info {
 static char *apply_dir_rename(struct strmap_entry *rename_info,
 			      const char *old_path)
 {
-	die("Not yet implemented!");
+	struct strbuf new_path = STRBUF_INIT;
+	const char *old_dir = rename_info->key;
+	const char *new_dir = rename_info->value;
+	int oldlen, newlen, new_dir_len;
+
+	oldlen = strlen(old_dir);
+	if (*new_dir == '\0')
+		/*
+		 * If someone renamed/merged a subdirectory into the root
+		 * directory (e.g. 'some/subdir' -> ''), then we want to
+		 * avoid returning
+		 *     '' + '/filename'
+		 * as the rename; we need to make old_path + oldlen advance
+		 * past the '/' character.
+		 */
+		oldlen++;
+	new_dir_len = strlen(new_dir);
+	newlen = new_dir_len + (strlen(old_path) - oldlen) + 1;
+	strbuf_grow(&new_path, newlen);
+	strbuf_add(&new_path, new_dir, new_dir_len);
+	strbuf_addstr(&new_path, &old_path[oldlen]);
+
+	return strbuf_detach(&new_path, NULL);
 }
 
 static void get_renamed_dir_portion(const char *old_path, const char *new_path,
@@ -980,7 +1002,18 @@ static void handle_directory_level_conflicts(struct merge_options *opt)
 static struct strmap_entry *check_dir_renamed(const char *path,
 					      struct strmap *dir_renames)
 {
-	die("Not yet implemented!");
+	char *temp = xstrdup(path);
+	char *end;
+	struct strmap_entry *e = NULL;
+
+	while ((end = strrchr(temp, '/'))) {
+		*end = '\0';
+		e = strmap_get_entry(dir_renames, temp);
+		if (e)
+			break;
+	}
+	free(temp);
+	return e;
 }
 
 static void compute_collisions(struct strmap *collisions,
-- 
gitgitgadget

