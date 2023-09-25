Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC75ACE7A81
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 15:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbjIYP0B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 11:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbjIYPZu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 11:25:50 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1CC109
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 08:25:43 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a648f9d8e3so886577066b.1
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 08:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695655541; x=1696260341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kpEPGUcOVm0Cr8yXEhQpwXIWray4hrXDhMKhT+w5tA=;
        b=UVN1Ua5Bs4sXFwScpS3xyztJypEUL0Hui1vg3G2wxbwrZ1FXSff5kMB9HhJ1B/OhrP
         NYcVic5eMM+iCN4Bz2r5J/eVsYtaH/cmnGrGGh41B4b2jcgnfXCIk7gj4FY3UFoSkhOK
         eqNGjF1m4zI+7HEFigkSERnv3NmWzFVqvBDnBY6iJzaj8bAOlI3IZfOPQ+Nh3Fe8Z/bF
         vs7k69RBL7jCuqFxGD+RxVjJ9+/L0CmERayxEv5Bbf2lNURDcgzn0ec3P8MCkTLjtpfn
         eEkmTQ7U76oX3dGWFjubQWoDxtdhfsAubvyrQFYQMVegprGUjqPRBr9pUUgh1We3k6HS
         dKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695655541; x=1696260341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kpEPGUcOVm0Cr8yXEhQpwXIWray4hrXDhMKhT+w5tA=;
        b=MqRwbIGXBwfMSF24a3+AtznwKQFBdQ664VddYsmbsRkslrcynXP8OqIb6Dc6hyxgpW
         UNqsyxI6/BaofbXJ1X0oosJCHcNGEhs5ab2Zq5RANKOgOBAgXGlFej7d/1MEYWFECE77
         0n/KVOjsl+ErVeElswDLAr51lU46EFVhGOOwUvRTZlFaF5ToRbBQXt83OE9jcMC/6SYt
         dQTo6tYe6X/wZ7vqfNWc1ARVBgk4rrbeTE2orCFl4pRpqXOzhPS75uN2aNhCE9DxYdw9
         3sKvlV4r3/iF+bNKn3T3Zns0Bn66KTdCCit7gy8mWnLn4bYrO3dNv/gKq3LJD1xPKhjd
         NtrQ==
X-Gm-Message-State: AOJu0Yxm5+7TE0m2VRhHeXAR1qhscPiX2kLttNh5oxtHwfSxmfLwWW/9
        R5D8frt7sv5NGDIhiuEbxF4A7dgZTUPpog==
X-Google-Smtp-Source: AGHT+IEI2Zhw2FSJEMI8Ssm9E4Jw0snukMCxeHVgeJmR68DOH7fPqK0agm6z23db1yfmP2ukgwIncw==
X-Received: by 2002:a17:906:18a9:b0:9ad:ef08:1f32 with SMTP id c9-20020a17090618a900b009adef081f32mr6706422ejf.37.1695655541670;
        Mon, 25 Sep 2023 08:25:41 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:105a:e25e:7421:a01e:ee4a:ba03])
        by smtp.gmail.com with ESMTPSA id f1-20020a17090624c100b009ae3e6c342asm6432045ejb.111.2023.09.25.08.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:25:40 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 3/9] repack: refactor finishing pack-objects command
Date:   Mon, 25 Sep 2023 17:25:11 +0200
Message-ID: <20230925152517.803579-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.279.g57b2ba444c
In-Reply-To: <20230925152517.803579-1-christian.couder@gmail.com>
References: <20230911150618.129737-1-christian.couder@gmail.com>
 <20230925152517.803579-1-christian.couder@gmail.com>
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
index 529e13120d..d0ab55c0d9 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -806,6 +806,36 @@ static void remove_redundant_bitmaps(struct string_list *include,
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
@@ -814,9 +844,8 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 			    struct existing_packs *existing)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
-	struct strbuf line = STRBUF_INIT;
 	struct string_list_item *item;
-	FILE *in, *out;
+	FILE *in;
 	int ret;
 	const char *scratch;
 	int local = skip_prefix(destination, packdir, &scratch);
@@ -861,27 +890,7 @@ static int write_cruft_pack(const struct pack_objects_args *args,
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
@@ -891,10 +900,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct string_list names = STRING_LIST_INIT_DUP;
 	struct existing_packs existing = EXISTING_PACKS_INIT;
 	struct pack_geometry geometry = { 0 };
-	struct strbuf line = STRBUF_INIT;
 	struct tempfile *refs_snapshot = NULL;
 	int i, ext, ret;
-	FILE *out;
 	int show_progress;
 
 	/* variables to be filled by option parsing */
@@ -1124,18 +1131,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
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
2.42.0.279.g57b2ba444c

