Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E35DC001DB
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 18:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjHHSJP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjHHSIp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 14:08:45 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4BF14D266
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 10:03:44 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so9589846e87.2
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 10:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691514222; x=1692119022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Pb+vWwXMqqqmf86jYz3oGWrw5ityY0GVtItR+o0DqM=;
        b=jpjZxQJN/A54ctI2ONE1U/AAvXuQCoSmue6DdFUNXkzBjl2WDiwT9oyrh6BCheUkxZ
         ONdZiKWMEa4mpxsCwP6sXTFawWdRmJrkEuop7NYy0AhIz3llw9gRKZgCNnoNblxH9MGI
         kHGc60WsErV9SOo/YopY4/MiS5Mn0baTrgHFljBAcAxyEphnnzE6qZ7xNx6rrX/DsL16
         qgrT1gtFXQg9cCOyTvG9+CXCRA7/QUfNqtKDwhglBq8ztdN3KAIGl5Jw8YgJaubtmYFp
         O2i3JM7bk6WSEogUE4KWQTmX8TZ3EBc0mk3AVL+euIcn5mNRsSPtSen1Dhf/HKgTwBnZ
         x6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514222; x=1692119022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Pb+vWwXMqqqmf86jYz3oGWrw5ityY0GVtItR+o0DqM=;
        b=JXdLQcm8Ctsjaf2rEjikuX9Y7OiFhLe3SGNJcXBi/Teskh2uQstBoqHHe0cvBL0nAS
         XLpgx3U/usCl6bC3i2VgGXu6ZxOF2NMaX1pg19qsFpQjmLmcZtnlEbyYXAXKh1BuT1ff
         gLhCEb9ZaJAwtTF/nCW8AdqyMfVbxQvsfS4leZkB7vkSLQQDpsgtGv0XbRTAJ9jbIpS6
         Pv6lSI0z4jduwCTAWu3B/fGca/0/4VlWmEWy+qS6BAgWpZK/a3iWJM//7mT02vRvQ+kX
         2kZH7mO7DHQy3FDExKzQ2KKn7sFnLfczHBYzLMTw5Jj01aQT5hImaly4DlwZlqn4YADk
         /NLA==
X-Gm-Message-State: AOJu0YyFnTf0raVrUmu7IXX39AyCuV7UHdMIlSv8cDu/D6wv0hblPm57
        wvv72VT/rnY9rUbEoiFmtIHUHOy6d7o=
X-Google-Smtp-Source: AGHT+IEXLWxYvcMxlKmK4F2MPTzmztgMjzauE85JFerVQSGuzJRiG31fwJgcyOKx7z5YWGmoX32CpQ==
X-Received: by 2002:adf:df09:0:b0:316:f5b1:98c with SMTP id y9-20020adfdf09000000b00316f5b1098cmr6868099wrl.24.1691483191016;
        Tue, 08 Aug 2023 01:26:31 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:2420:9770:9200:db98:c1c8:97d0])
        by smtp.gmail.com with ESMTPSA id d17-20020a5d6dd1000000b003140fff4f75sm12845707wrz.17.2023.08.08.01.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 01:26:30 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 3/8] repack: refactor finishing pack-objects command
Date:   Tue,  8 Aug 2023 10:26:03 +0200
Message-ID: <20230808082608.582319-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.rc0.8.g76fac86b0e
In-Reply-To: <20230808082608.582319-1-christian.couder@gmail.com>
References: <20230724085909.3831831-1-christian.couder@gmail.com>
 <20230808082608.582319-1-christian.couder@gmail.com>
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
2.42.0.rc0.8.g76fac86b0e

