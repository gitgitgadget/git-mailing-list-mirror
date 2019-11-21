Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F229CC432C3
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68982068E
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiQEHq8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfKUWFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:05:22 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42933 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfKUWFR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:05:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id a15so6286151wrf.9
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=n1aeEF8voJJ5tk7dX1MuJjkfozlm4w+6/6kB4OTgu2M=;
        b=HiQEHq8OjGUl+5B0mrR89d6HnEjfhcJirEY1N+JyPAZxOWDTol2hQyLZEo1jRE6YKV
         Iy++Ioi5Yra1UrS/fhKq/fvQi8MqvxEcWPigcALF+ZOmMOTSnezVhdZd42613cpOY42m
         agXV0dwHo5EKwYmkuGcBmeA/MCKDvSaW5fTATD0uWxiC26JlJ8L2oSpCrX8Tbsz+kBDi
         wq+8hYBBq7hw/dSdMby/CIeyZG8R316pJjgmNgG+qCRrZ7/MtJSlccgz8APsyz2bRwp9
         ycEB2MVDc1Xqk5hgdFAMjvVkqVRdtcMPTM3Xj9TSS3+l2kz2p8OTJU3Lw8HtONDTpSCX
         xF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=n1aeEF8voJJ5tk7dX1MuJjkfozlm4w+6/6kB4OTgu2M=;
        b=qXyQXyLq6hHfwQfKDDEQpviMPzzm87C2DrQLlmIA4RFhQr5qjV+sIVLe63Gwc7d9Qw
         JSUya60mQW5nwYarSrJzi0sKt+LK/sjAKaKIXkRuup8KfgXiXTNYiaHyPJo4LNPbuVhR
         Fc/Z4bSrFmHuJVs7UePsf2ZRndUm851Pj69cQ6WkOA/jioAm2MOTDBIOP2Kd4hrdGqPm
         1nlLtmdU8ehdtkHWVKY4kFFj0gg4HPPJ5GWzwlcv8sW9U7dX1p9HOZMLhh9fmPb4SB3m
         8ucVH2NdxRjtj+n7kyfsMraNQsbFBHl/DM775tSUWDkl9QO3H6ctyiqFM83ANYund0Bj
         IGig==
X-Gm-Message-State: APjAAAXWS6wKu2TyA6Bzt7uq8mB2L9LKR1OPJt7rHJKA9TshQwd1WVKk
        08/CA1TJlrtkDpUDPryljTUDgkLf
X-Google-Smtp-Source: APXvYqzq+b0wKzuzFVmWeMe649gPHKGceu05UMoTXwe1xsgQngXKQYoMRc9a56sxtMOZkkf8l241aQ==
X-Received: by 2002:a5d:526f:: with SMTP id l15mr13616272wrc.169.1574373915901;
        Thu, 21 Nov 2019 14:05:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d67sm1079640wmd.13.2019.11.21.14.05.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:05:15 -0800 (PST)
Message-Id: <c62d9750efe992f13cb2fa8c71120ffa0f850ae3.1574373892.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
References: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
        <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:04:50 +0000
Subject: [PATCH v6 18/19] sparse-checkout: update working directory in-process
 for 'init'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, jon@jonsimons.org, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git sparse-checkout init' subcommand previously wrote directly
to the sparse-checkout file and then updated the working directory.
This may fail if there are modified files not included in the initial
pattern set. However, that left a populated sparse-checkout file.

Use the in-process working directory update to guarantee that the
init subcommand only changes the sparse-checkout file if the working
directory update succeeds.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 9a620ff014..5dbfb2a7e0 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -13,6 +13,8 @@
 #include "resolve-undo.h"
 #include "unpack-trees.h"
 
+static const char *empty_base = "";
+
 static char const * const builtin_sparse_checkout_usage[] = {
 	N_("git sparse-checkout (init|list|set|disable) <options>"),
 	NULL
@@ -243,10 +245,10 @@ static int sparse_checkout_init(int argc, const char **argv)
 {
 	struct pattern_list pl;
 	char *sparse_filename;
-	FILE *fp;
 	int res;
 	struct object_id oid;
 	int mode;
+	struct strbuf pattern = STRBUF_INIT;
 
 	static struct option builtin_sparse_checkout_init_options[] = {
 		OPT_BOOL(0, "cone", &init_opts.cone_mode,
@@ -275,26 +277,30 @@ static int sparse_checkout_init(int argc, const char **argv)
 	/* If we already have a sparse-checkout file, use it. */
 	if (res >= 0) {
 		free(sparse_filename);
-		goto reset_dir;
+		core_apply_sparse_checkout = 1;
+		return update_working_directory(NULL);
 	}
 
-	/* initial mode: all blobs at root */
-	fp = xfopen(sparse_filename, "w");
-	if (!fp)
-		die(_("failed to open '%s'"), sparse_filename);
+	if (get_oid("HEAD", &oid)) {
+		FILE *fp;
 
-	free(sparse_filename);
-	fprintf(fp, "/*\n!/*/\n");
-	fclose(fp);
+		/* assume we are in a fresh repo, but update the sparse-checkout file */
+		fp = xfopen(sparse_filename, "w");
+		if (!fp)
+			die(_("failed to open '%s'"), sparse_filename);
 
-	if (get_oid("HEAD", &oid)) {
-		/* assume we are in a fresh repo */
+		free(sparse_filename);
+		fprintf(fp, "/*\n!/*/\n");
+		fclose(fp);
 		return 0;
 	}
 
-reset_dir:
-	core_apply_sparse_checkout = 1;
-	return update_working_directory(NULL);
+	strbuf_addstr(&pattern, "/*");
+	add_pattern(strbuf_detach(&pattern, NULL), empty_base, 0, &pl, 0);
+	strbuf_addstr(&pattern, "!/*/");
+	add_pattern(strbuf_detach(&pattern, NULL), empty_base, 0, &pl, 0);
+
+	return write_patterns_and_update(&pl);
 }
 
 static void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *path)
@@ -351,7 +357,6 @@ static struct sparse_checkout_set_opts {
 
 static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 {
-	static const char *empty_base = "";
 	int i;
 	struct pattern_list pl;
 	int result;
@@ -419,7 +424,6 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 
 static int sparse_checkout_disable(int argc, const char **argv)
 {
-	static const char *empty_base = "";
 	struct pattern_list pl;
 	struct strbuf match_all = STRBUF_INIT;
 
-- 
gitgitgadget

