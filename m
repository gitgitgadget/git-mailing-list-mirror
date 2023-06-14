Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D223EB64D8
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 19:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbjFNT01 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 15:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236608AbjFNT0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 15:26:25 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5182684
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 12:26:09 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f8d0d684f3so10037565e9.2
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 12:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686770767; x=1689362767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Khcw39MVa4wY4BiNdWHhcIIpn3dBkfmavaetTaqVbUI=;
        b=ObHhO1hGlBnOLsk85s0TUweJ929mURHs4EhF07xOCovmPNoSWhQyfBJO6eQHFY8bn2
         j7KJEgsSnUcQoKHjADtSE/DLv/rq0bjl1LTkP9WEW5YISgyvj6qWBjecN+VCfZ1xpvwo
         bkTDhGmolJ5OBIG/Q5Diphl7kcumH3NsE2mdV3YgVNGZGX2ssv2zWIS7XSC/pb2wBtYT
         lktJcjhwMwDk2JQvdCtPG3KKrZOj6/x3oYodqsqokVxGu5PQ2gq4nrVsM/o2xUsc8Szq
         uHqA685+HuhCK3wASj8u21pl0PHaj/PV87CWths4AWhYoLWcKIXreNr98u6BwE9t0r7Z
         3oVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686770767; x=1689362767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Khcw39MVa4wY4BiNdWHhcIIpn3dBkfmavaetTaqVbUI=;
        b=RbRiV8TTTtL0shdCRTZF900w2viJV89PLg1wf/00ShkjVpEiGIgT3+Nnh8/VTAjcOb
         HsyM4aIQuknKc4/VA1oE8pUVgSM+/w8qK0a8FSsjEtVfp9q/wNDeQvJ+jyAz0IMlLw/J
         7Uk2H6hsDErfW/j12HR0jRJBT29w61IcLcHHHu2woMiBE7ObantqDXJv25gZExaf1/aq
         obJk5p6UKYRk2ylm4pCbDKwK49qS0DmW6ZThCS+rxhdM3wV0jXdCE+MmqUIgL+oU4Obh
         g6+9pqg7rdSrQ1VT1VKFe71bUJu7F5dcJsvu2A42qr81xcOQ2nl9/mfKjL7btmMsWz6P
         XWLg==
X-Gm-Message-State: AC+VfDwnyC2TTlMgwvDjWOCcku/1jI3qIUMzy4RAVaMiqN5QN5mdyocr
        1vYvHltyPOGt2llNNYkx5YKprK5tqBg=
X-Google-Smtp-Source: ACHHUZ5lRWq+sCO3avN1gYDV8cCYp2eE7yUg4lqMI1OUSoU1KIj8UZ83V0iMN6NxXXM7rpjx19kmow==
X-Received: by 2002:a1c:4c0c:0:b0:3f7:ee69:869f with SMTP id z12-20020a1c4c0c000000b003f7ee69869fmr10828141wmf.5.1686770767357;
        Wed, 14 Jun 2023 12:26:07 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:e164:efe0:8fdb:6ba])
        by smtp.gmail.com with ESMTPSA id u26-20020a05600c00da00b003eddc6aa5fasm18370365wmm.39.2023.06.14.12.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:26:06 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 5/9] repack: refactor finishing pack-objects command
Date:   Wed, 14 Jun 2023 21:25:37 +0200
Message-ID: <20230614192541.1599256-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.37.gae45d9845e
In-Reply-To: <20230614192541.1599256-1-christian.couder@gmail.com>
References: <20230614192541.1599256-1-christian.couder@gmail.com>
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
 builtin/repack.c | 78 ++++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index e591c295cf..f1adacf1d0 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -703,6 +703,42 @@ static void remove_redundant_bitmaps(struct string_list *include,
 	strbuf_release(&path);
 }
 
+static int finish_pack_objects_cmd(struct child_process *cmd,
+				   struct string_list *names,
+				   const char *destination)
+{
+	int local = 1;
+	FILE *out;
+	struct strbuf line = STRBUF_INIT;
+
+	if (destination) {
+		const char *scratch;
+		local = skip_prefix(destination, packdir, &scratch);
+	}
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
@@ -712,12 +748,9 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 			    struct string_list *existing_kept_packs)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
-	struct strbuf line = STRBUF_INIT;
 	struct string_list_item *item;
-	FILE *in, *out;
+	FILE *in;
 	int ret;
-	const char *scratch;
-	int local = skip_prefix(destination, packdir, &scratch);
 
 	prepare_pack_objects(&cmd, args, destination);
 
@@ -758,27 +791,7 @@ static int write_cruft_pack(const struct pack_objects_args *args,
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
+	return finish_pack_objects_cmd(&cmd, names, destination);
 }
 
 int cmd_repack(int argc, const char **argv, const char *prefix)
@@ -789,10 +802,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct string_list existing_nonkept_packs = STRING_LIST_INIT_DUP;
 	struct string_list existing_kept_packs = STRING_LIST_INIT_DUP;
 	struct pack_geometry *geometry = NULL;
-	struct strbuf line = STRBUF_INIT;
 	struct tempfile *refs_snapshot = NULL;
 	int i, ext, ret;
-	FILE *out;
 	int show_progress;
 
 	/* variables to be filled by option parsing */
@@ -1023,18 +1034,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
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
+	ret = finish_pack_objects_cmd(&cmd, &names, NULL);
 	if (ret)
 		goto cleanup;
 
-- 
2.41.0.37.gae45d9845e

