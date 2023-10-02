Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECED5E748FB
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 16:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238398AbjJBQzo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 12:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238536AbjJBQzg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 12:55:36 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708DEB4
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 09:55:32 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so21998345a12.2
        for <git@vger.kernel.org>; Mon, 02 Oct 2023 09:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696265730; x=1696870530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1B2Pw8ZjowFSiZyo7tIrTx5e8fItBlrmtuqIKFxK4k=;
        b=XGc38AgQBTRcFfG8YqsCU89cZu3/lJKdiBaUgOdu1fEn9FBswqFNz7DphzjftRSbZf
         ob3y/IALU7IoNxa1Fmhr42nOW8C1CC1f/LrUsSU42zZsDfsnUatDih4ThGbXq94EhVj4
         d/I1UDB1z0Qj0RA6pOS0hrBawpoCXmKUj+W21DJCaOsSgG3ssgsqGqOOcTZ34aJqeZHD
         oxW00rVK4hCkuQ9qN9ua9Nm/qQDEJu4DsPd/4Pzfv4SuP2SpiPc54iQGb7tgF0hfgsQO
         gBgWhxE81g8UQths1zRqyaJAvhoNkfFdOCiRws7LxmQ3+YKLU0RIT9MBMXwEpssG+e1g
         bXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696265730; x=1696870530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1B2Pw8ZjowFSiZyo7tIrTx5e8fItBlrmtuqIKFxK4k=;
        b=xI6Y5jhjVtQkLHpGwA6RYbNrzfQUnxbnrveaQ/U6bNIR957i54ypTKn23HKpB7eftH
         oT4JiiLotMbYS5jG3y8AThbQib3yYqNXdL20/75h4r/BdDkEGk3WAQFG6YTQ3FX3m9IM
         aJH97CQXf5jUTmP23MFb39ahc7cRIXP+8p70vY0HEoBCzVVawbZuHDvGzMtWQOH4Zysy
         c9XIKARRrqAMhA8lQL7Y1HFuSH0yiI118QJ2suJ6ih/MAi1xFMqoAMvC9zalQkhccRQE
         EsnPGX8D2P3L/62gTYj5SrTAQMjENwb5wdF9LADPW38P3RtQxOdt2vwr6OmUfbUO23Ib
         getQ==
X-Gm-Message-State: AOJu0YznNAD8AwPq9uk9kEUX0tFr/Hb5pUtzY9fqE8vLg9VR9aOOBqaf
        SZCJ+f00IUeiiEInztf4Qr0MDm9dpZz5VQ==
X-Google-Smtp-Source: AGHT+IGhAHNWaSB57idyAJFedPU5KUkVJa+iojnkUZ1NBFwti0uPeOBftd+AOiRWw/L5TXziJKlVdA==
X-Received: by 2002:aa7:c301:0:b0:51e:2e39:9003 with SMTP id l1-20020aa7c301000000b0051e2e399003mr9678450edq.40.1696265730331;
        Mon, 02 Oct 2023 09:55:30 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:c027:f1d4:d825:fbf4:9197:5c9f])
        by smtp.gmail.com with ESMTPSA id er15-20020a056402448f00b00533c844e337sm12762364edb.85.2023.10.02.09.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 09:55:29 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v8 3/9] repack: refactor finishing pack-objects command
Date:   Mon,  2 Oct 2023 18:54:58 +0200
Message-ID: <20231002165504.1325153-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.305.g5bfd918c90
In-Reply-To: <20231002165504.1325153-1-christian.couder@gmail.com>
References: <20230925152517.803579-1-christian.couder@gmail.com>
 <20231002165504.1325153-1-christian.couder@gmail.com>
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
2.42.0.305.g5bfd918c90

