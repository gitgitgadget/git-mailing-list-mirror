Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA782CA0EC8
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 23:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349267AbjIKVc7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241339AbjIKPG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 11:06:57 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34060FA
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 08:06:52 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9a9f139cd94so487320466b.2
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 08:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694444810; x=1695049610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qznP7D2Ft+JVn9XSu9aGM0yjSU36kMed+BP2yJ8qNY=;
        b=NLzwaTkDOxJE6qcYOaJCnp+QBknfuiM9jDAC4PPVbjyEZnFmGU5BEcT7Hju8HxScnv
         9eQZ75BSVI+0JmqGxAQG/bH5jRzhQRvkrUaoL/CX6+WmHJrmpjkST2ch4vBNLzOYzi+G
         FRHtoj+Es8HIUCuAae/CLCoZScId+utCCeWcB9T9hYreldbAX4vqbJZE1dK8SuftIxbG
         uFqSVBGL8jhA6oUbCM7z+XhAIaJCtynxoPGsk/Tkd9uLgqJOpztqJo60y0PwZU1f1O+3
         CZDkQpYGO+3UQAPtXT/XiB3a25VUSIEO60KBLCTCplxUIKs3bsGOu0S2iYgsSmyvvfoO
         vGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694444810; x=1695049610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qznP7D2Ft+JVn9XSu9aGM0yjSU36kMed+BP2yJ8qNY=;
        b=RnzyS25R6AZIbxAEh/X6i28aMwUCL8S49rHg2HYgKl1Zc7Zdw68pDZmFFrqNtSnO2x
         1B65M7jWaey2TmTDtBd2ojGqMnoxH5EfwfTh7lS8p7Vn5XPDax5v101MMmtlsQ7iftoG
         /t00/Y4+Po1VCpV2T5tqQYL8uewZ8oEJtiZbAYpf4wv/DQCC7FwZQWzvVzmUS1cShF20
         ta0Bm1RPCoZyjn1ciAti67o4Xlv7RaJGMcqvQ17z9bVI3VnblRJ9DieBumwzoResLL1Z
         DXKta0Dqlqd99w5V/hNU9NUI1XSvE9ehEGx/ZLlt5H4qYsES8lVSOP0gfUxxuyubr6IW
         5zhQ==
X-Gm-Message-State: AOJu0Yxh1XKww0zBVtOSq18f3sv6diQzFtoxa5Tj+RRoaZNkLdWXxtoc
        upsOrWsN5VMtFzqzS+n4zjeyZPCBebs=
X-Google-Smtp-Source: AGHT+IGbHaohxYtOPDdfLGNOXkfVERI2wdcCNde7sjGSHzivIDEBn90QWe9XnFSFT95pxSvA+omQ3g==
X-Received: by 2002:a17:907:784e:b0:99c:3b4:940f with SMTP id lb14-20020a170907784e00b0099c03b4940fmr8583011ejc.27.1694444810188;
        Mon, 11 Sep 2023 08:06:50 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:1085:31e2:f2be:e47a:b382:4542])
        by smtp.gmail.com with ESMTPSA id f5-20020a170906138500b0099cb1a2cab0sm5485617ejc.28.2023.09.11.08.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:06:49 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 3/9] repack: refactor finishing pack-objects command
Date:   Mon, 11 Sep 2023 17:06:12 +0200
Message-ID: <20230911150618.129737-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.167.gd6ff314189
In-Reply-To: <20230911150618.129737-1-christian.couder@gmail.com>
References: <20230812000011.1227371-1-christian.couder@gmail.com>
 <20230911150618.129737-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new finish_pack_objects_cmd() to refactor duplicated code
that handles reading the packfile names from the output of a
`git pack-objects` command and putting it into a string_list, as well as
calling finish_command().

While at it, beautify a code comment a bit in the new function.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org
---
 builtin/repack.c | 70 +++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 37 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 6943c5ba11..4f53b24958 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -695,6 +695,36 @@ static void remove_redundant_bitmaps(struct string_list *include,
 	strbuf_release(&path);
 }
 
+static int finish_pack_objects_cmd(struct child_process *cmd,
+				   struct string_list *names,
+				   int local)
+{
+	FILE *out;
+	struct strbuf line = STRBUF_INIT;
+
+	out = xfdopen(cmd->out, "r");
+	while (strbuf_getline_lf(&line, out) != EOF) {
+		struct string_list_item *item;
+
+		if (line.len != the_hash_algo->hexsz)
+			die(_("repack: Expecting full hex object ID lines only "
+			      "from pack-objects."));
+		/*
+		 * Avoid putting packs written outside of the repository in the
+		 * list of names.
+		 */
+		if (local) {
+			item = string_list_append(names, line.buf);
+			item->util = populate_pack_exts(line.buf);
+		}
+	}
+	fclose(out);
+
+	strbuf_release(&line);
+
+	return finish_command(cmd);
+}
+
 static int write_cruft_pack(const struct pack_objects_args *args,
 			    const char *destination,
 			    const char *pack_prefix,
@@ -704,9 +734,8 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 			    struct string_list *existing_kept_packs)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
-	struct strbuf line = STRBUF_INIT;
 	struct string_list_item *item;
-	FILE *in, *out;
+	FILE *in;
 	int ret;
 	const char *scratch;
 	int local = skip_prefix(destination, packdir, &scratch);
@@ -749,27 +778,7 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 		fprintf(in, "%s.pack\n", item->string);
 	fclose(in);
 
-	out = xfdopen(cmd.out, "r");
-	while (strbuf_getline_lf(&line, out) != EOF) {
-		struct string_list_item *item;
-
-		if (line.len != the_hash_algo->hexsz)
-			die(_("repack: Expecting full hex object ID lines only "
-			      "from pack-objects."));
-		/*
-		 * avoid putting packs written outside of the repository in the
-		 * list of names
-		 */
-		if (local) {
-			item = string_list_append(names, line.buf);
-			item->util = populate_pack_exts(line.buf);
-		}
-	}
-	fclose(out);
-
-	strbuf_release(&line);
-
-	return finish_command(&cmd);
+	return finish_pack_objects_cmd(&cmd, names, local);
 }
 
 int cmd_repack(int argc, const char **argv, const char *prefix)
@@ -780,10 +789,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct string_list existing_nonkept_packs = STRING_LIST_INIT_DUP;
 	struct string_list existing_kept_packs = STRING_LIST_INIT_DUP;
 	struct pack_geometry geometry = { 0 };
-	struct strbuf line = STRBUF_INIT;
 	struct tempfile *refs_snapshot = NULL;
 	int i, ext, ret;
-	FILE *out;
 	int show_progress;
 
 	/* variables to be filled by option parsing */
@@ -1013,18 +1020,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		fclose(in);
 	}
 
-	out = xfdopen(cmd.out, "r");
-	while (strbuf_getline_lf(&line, out) != EOF) {
-		struct string_list_item *item;
-
-		if (line.len != the_hash_algo->hexsz)
-			die(_("repack: Expecting full hex object ID lines only from pack-objects."));
-		item = string_list_append(&names, line.buf);
-		item->util = populate_pack_exts(item->string);
-	}
-	strbuf_release(&line);
-	fclose(out);
-	ret = finish_command(&cmd);
+	ret = finish_pack_objects_cmd(&cmd, &names, 1);
 	if (ret)
 		goto cleanup;
 
-- 
2.42.0.167.gd6ff314189

