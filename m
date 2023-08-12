Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B00C04A6A
	for <git@archiver.kernel.org>; Sat, 12 Aug 2023 00:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237297AbjHLAAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 20:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237298AbjHLAAo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 20:00:44 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E4F171F
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 17:00:43 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bdba48eccdso8478495ad.3
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 17:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691798442; x=1692403242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9R9PvWuufPe7OZHaIhFg39XGiMj0LtppO0oX7nawezY=;
        b=AF3Yz/Ew5oHmkA/xBuGOqcpzjDJlnFoic7T552Ese+7nu0QT94xnwdSuGvOJxoPz++
         GEG+xEWHXhHpwJtO5NgJE8dQlz6ka3OLFEBNn3oVqZZSTe3wKVOGfKkwOcfLs1lXCaQg
         tJb6LLFJpPphwR0tya9C3dyULSIQElqWaS6iM0Oh10C96XcN8HMibX6RZINxmv/A7hnQ
         V5R1W2YXafpwV7RC7YPu+LlMELtRNEJVPdBRASQT6vfw28MrShUjvbG+Nw8gNPPkgFUq
         qV1hL4dE9y/JqRYsf/q8PgnXR+V8J7N6fJfDwMWYXwvacES0yHrqXbbgZ3WOUSHM82aY
         KKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691798442; x=1692403242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9R9PvWuufPe7OZHaIhFg39XGiMj0LtppO0oX7nawezY=;
        b=EsMForz9QFNDPVWzwpreCX1ZrAArYjis8A3eoYNRuhaQabjOB4cN7IM6xCU+ezey8x
         Xm9x0ahXKrQqEeWa2nd9dR3r+qS792LuZtD9t1Xcj+fN8f430En8/2AEvafe4uzfTn5g
         sc2tf/JClmmY7Y/qKdVTkEh5U9gWj+SDBa083mEICpG6u7oACsvRQsJr8ZGXe0QfTk0t
         xVrKFBw7w0qqdX6lRilG3Zi+1BR9/LWKi8crN4f7V25keVFll7H81vvqKfOre6+z/R4S
         eC6yexu7bRofHkwD5j8CnfB6XK5NhSSHfDR2eW/wjWzt/+w//lv36aP7OFpQ8anfFGTY
         9ceQ==
X-Gm-Message-State: AOJu0Yzux640Aybd/EI5/7RZFYdiFzZ3KYBl1NcLWoreDuE6mc5rUD2N
        /38YJ6HslluBo5UhCgNAxQnaoXTNzog2rg==
X-Google-Smtp-Source: AGHT+IH1NWCvC59+Mu0oFqbDHw5z1SaRzq/RLqw8c6dvd/8Lf3rir5lymzNKgpPFYozzoLWh9Ro3yg==
X-Received: by 2002:a17:902:e741:b0:1bb:8e13:deba with SMTP id p1-20020a170902e74100b001bb8e13debamr3724667plf.11.1691798442518;
        Fri, 11 Aug 2023 17:00:42 -0700 (PDT)
Received: from christian-Precision-5550.. ([129.126.215.52])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709028f8500b001b8a7e1b116sm4478308plo.191.2023.08.11.17.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 17:00:42 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 3/8] repack: refactor finishing pack-objects command
Date:   Sat, 12 Aug 2023 02:00:06 +0200
Message-ID: <20230812000011.1227371-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.rc1.8.ga52e3a71db
In-Reply-To: <20230812000011.1227371-1-christian.couder@gmail.com>
References: <20230808082608.582319-1-christian.couder@gmail.com>
 <20230812000011.1227371-1-christian.couder@gmail.com>
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
2.42.0.rc1.8.ga52e3a71db

