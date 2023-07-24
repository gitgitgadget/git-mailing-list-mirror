Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33588C001DE
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 08:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjGXI7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 04:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbjGXI7m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 04:59:42 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1E512A
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 01:59:41 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-992acf67388so611222266b.1
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 01:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690189179; x=1690793979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPxnAwAPrGQ414YKVIBt/qldlBjQHw2tp5sXBwwzoNs=;
        b=quER0J0Vqe9CaJY1Z1mMcdbtV9JQdLECb1aaaYzxybqkeVOgmxK6BM/XeLdIZ7/uLs
         o2brhvT4JzAuq7juSNp2Pa2fRZYLttp3P3JayBzm5wQbmvtiBd87Q/QU//jg+IDm4RIX
         SA5aNbshysg+zROhf4jdrYZxXpWl8KjDWKseqnP7wO0l4cMmI2NTV7qszV+J0C1IlCd3
         FuB9foi+5DM4igczV2u6GuixXP+VERUVBVFYR2oIvGSm94Pj0WwJrNTXrwWjHvRoOwA0
         746or1iXkcH2022kWBpS83NMoFsr6dzV5xxVaUA4xAbgQACSRkBDORmejBp0VGkONG0a
         Igdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690189179; x=1690793979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPxnAwAPrGQ414YKVIBt/qldlBjQHw2tp5sXBwwzoNs=;
        b=dPBxAVboUwWxODi1cr/6vMVpfzYtADIeCtbwNlLwEyciRwuVEmiSBV5XTUmCTsWWx5
         E1W7uXzY5Xn/g0Ba2U3hk1PLTjtQdOB1MZkkG8h4BUl3ju+FNeLwbRF01Y9Zye8FE0gk
         1Pdu9EJL0PWJZ5+9JQpuLvzxP++gkoD4Amwoxt5H9n78PjMFu0jp13lvXlY/HLUSxb67
         u8A41l270mRLpV/DZ+RmZ1ac2YNlyxY/kNKpBTeWbNHL7M4XVUgN+XpDbbJaVmZsqWkU
         2wnZIXpW/1B49rvX8GkHcOqHlXy5Mzk32OaglmdawEQ1BcNlBQvBYw2bpNVtw345Aply
         83Xw==
X-Gm-Message-State: ABy/qLZibzcmKjwTBQMHGXqS8eqgkRIzAHfFnYo7DhQ4SJOcxM1lD59H
        BqGUhth5PaH6eyM75E3j3Vyu6MF9N6c=
X-Google-Smtp-Source: APBJJlHnDA4oFuqX7oL2LZmvkX2QJuyByj4s8I3HOSFaxK5Ktzg/w1boAnFN622aVEg3tPBsplMBXQ==
X-Received: by 2002:a17:906:cc16:b0:992:d013:1132 with SMTP id ml22-20020a170906cc1600b00992d0131132mr8480191ejb.1.1690189179321;
        Mon, 24 Jul 2023 01:59:39 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:11c4:4096:3d09:3950:f280:5ec1])
        by smtp.gmail.com with ESMTPSA id rv7-20020a17090710c700b00993a9a951fasm6506665ejb.11.2023.07.24.01.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 01:59:38 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 3/8] repack: refactor finishing pack-objects command
Date:   Mon, 24 Jul 2023 10:59:04 +0200
Message-ID: <20230724085909.3831831-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.384.ged66511823
In-Reply-To: <20230724085909.3831831-1-christian.couder@gmail.com>
References: <20230705060812.2865188-1-christian.couder@gmail.com>
 <20230724085909.3831831-1-christian.couder@gmail.com>
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
index aea5ca9d44..96af2d1caf 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -696,6 +696,36 @@ static void remove_redundant_bitmaps(struct string_list *include,
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
@@ -705,9 +735,8 @@ static int write_cruft_pack(const struct pack_objects_args *args,
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
@@ -751,27 +780,7 @@ static int write_cruft_pack(const struct pack_objects_args *args,
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
@@ -782,10 +791,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct string_list existing_nonkept_packs = STRING_LIST_INIT_DUP;
 	struct string_list existing_kept_packs = STRING_LIST_INIT_DUP;
 	struct pack_geometry *geometry = NULL;
-	struct strbuf line = STRBUF_INIT;
 	struct tempfile *refs_snapshot = NULL;
 	int i, ext, ret;
-	FILE *out;
 	int show_progress;
 
 	/* variables to be filled by option parsing */
@@ -1016,18 +1023,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
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
2.41.0.384.ged66511823

