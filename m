Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AE1EB64DD
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 06:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjGEGIu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 02:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjGEGIj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 02:08:39 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7CA10E3
        for <git@vger.kernel.org>; Tue,  4 Jul 2023 23:08:38 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fb96e2b573so10213667e87.3
        for <git@vger.kernel.org>; Tue, 04 Jul 2023 23:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688537316; x=1691129316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icwadf3OpgZ5ELW9RPnIlITNXr/NDVJfKlSvypx5lV4=;
        b=Ee0QJ4NhnRiCmevJM49plP1yXAXRjr5LIV2Y4NjX0ew54F9osHaLM3GGunQoVlPByB
         KFON1f/uxeeTX0VcELm0VH6fGasaBI2Aj64WTYNziPQjX2SRtSvE2X09Azvvmus8O0G2
         xhLqLM3pJtMR3vFbycS4MRwzTtItjcqzRkszKQp+d7xq411WwoL2lb0oWmvQ3DmlD+r5
         iMHXHgH3gISPZtERnUAYa8WYp0RpvT8yErTdTTLT97cCVZIBFBNP4dl7aOpZBydDGix3
         e1iYjjrSEK2aPi2xC9BFMFH/pMbiFhyUmOM0yP8Ft/mXofUE82mpI+sOf9Kl61onf1tU
         CI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688537316; x=1691129316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icwadf3OpgZ5ELW9RPnIlITNXr/NDVJfKlSvypx5lV4=;
        b=gxnBfxrEgpyYNL0/J7xI1v1U8cs3NwBGrLF46YjZdO4Xo+RMFH107CYkuQDvNfcvHK
         vRwbAWrxoACbw1nfkddBehso2psviqQRDkCn0VVk16fnxbWBENHG1Otw+48ej1WSMsFv
         Niiz5MiDWZB5/wWvd22lEWmpqnz7nBOiZv2EUVZRNzgX48mqiHI6+KdERS+74R85Iq7Q
         B9GhCtZzym+aZuKFFeaJ40BrWq/E0GDMk+zEYRo2KIEj8KEnyYcZQ6KvXVg/5zBGqaEP
         Eh+5kwyJRkthd+abughcpxI3+WzxQrLRcXIx5qE5acjuSqwZU+ax2UW6K1DNSC9o1UZL
         +vQg==
X-Gm-Message-State: ABy/qLZAP4SagWDz7ZbXFx8ElR8lO6kgQ9I0Kx91LjMCQnewoSq3lXwe
        iM/kYIQ3EWRPGGwckSlu/u2yYvcTWC0=
X-Google-Smtp-Source: APBJJlEqDcs6CPR0whdt+t+xhNwMlM6KDD+MDZP5yYDU3GD0sUIekeJ0nhguw3WiKZ2486im3kSuUg==
X-Received: by 2002:a05:6512:2510:b0:4f9:a542:91c with SMTP id be16-20020a056512251000b004f9a542091cmr12851154lfb.3.1688537315498;
        Tue, 04 Jul 2023 23:08:35 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:3f04:7ca0:f6a2:3135:7895:378b])
        by smtp.gmail.com with ESMTPSA id k15-20020a7bc40f000000b003fbaf9abf2fsm1087762wmi.23.2023.07.04.23.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 23:08:34 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 3/8] repack: refactor finishing pack-objects command
Date:   Wed,  5 Jul 2023 08:08:07 +0200
Message-ID: <20230705060812.2865188-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.244.g8cb3faa74c
In-Reply-To: <20230705060812.2865188-1-christian.couder@gmail.com>
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230705060812.2865188-1-christian.couder@gmail.com>
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
index a96e1c2638..916ba7c6d0 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -704,6 +704,36 @@ static void remove_redundant_bitmaps(struct string_list *include,
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
@@ -713,9 +743,8 @@ static int write_cruft_pack(const struct pack_objects_args *args,
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
@@ -759,27 +788,7 @@ static int write_cruft_pack(const struct pack_objects_args *args,
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
@@ -790,10 +799,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct string_list existing_nonkept_packs = STRING_LIST_INIT_DUP;
 	struct string_list existing_kept_packs = STRING_LIST_INIT_DUP;
 	struct pack_geometry *geometry = NULL;
-	struct strbuf line = STRBUF_INIT;
 	struct tempfile *refs_snapshot = NULL;
 	int i, ext, ret;
-	FILE *out;
 	int show_progress;
 
 	/* variables to be filled by option parsing */
@@ -1024,18 +1031,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
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
2.41.0.244.g8cb3faa74c

