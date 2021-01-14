Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823B2C433E6
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 15:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D3B323B3E
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 15:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbhANPvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 10:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbhANPvH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 10:51:07 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599FCC0613D3
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 07:50:26 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id y17so6257419wrr.10
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 07:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ybZ2qPh4rHF2vvJYutmlVerbxwrEJb1b4NC1X7hgtU0=;
        b=n13EogmEpQBqLqjLAoj8JkS8YHviIE7XWwW32MlJ5NoOvLj7uO0d0wRjFctK9qAhFt
         MoOfwlnreiqavUbxWKOtYefFkoe0L5BHQbdbDuurAMcb0qdOaYMlRIUFNPrqHyx7SXTP
         e8IUMVhXbmsHhh+RhCijxfBKtlI9D+MGqDBK1DJZd9BITbjA/KzeNXvq1Wz0taZvwC43
         fjTDKLudun2COU47/gbblCuvO3qXFpj3x5+9+7URpViCMCOBgeEAcc2Tz0EY50Ih8tPI
         qJZG56xb7/Dypl8H8IrNurkpBibVM/WhRc9/4iaQmt8Zgf6o3H2D0yI5IedVlCf3kfci
         DO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ybZ2qPh4rHF2vvJYutmlVerbxwrEJb1b4NC1X7hgtU0=;
        b=qGhgCWXjORnrh0xZQacbmM9DWtaU2FK7TutQmZzAYsZB8sFpA9O5ynFJ9YzZDiK8gL
         /iJg5ofr6iZEKI5RRfOpsfd3rucDPxIXg7pF4MqleN1w87w6oVf1lNDz50aUAOGhNMQN
         lKSSSu9PKWU7Eu6hEiOB8la1ZQlIRQZvPQzAXQHjrxZ0AI5XmlexgQM/WCI3NGgtV6Xl
         TA0ln/6PO1J9KDRDu502XbFU+N4oPxMPLYFru2DhUN27UnMTrhF/WQBXiJsehTe9Rpg1
         v4OvwMBegaCFuw1LxBdL8RvkppV/9vlI9S6IcaIpd3gVELHwgrJoVrD5545jOmer5gPl
         sMqA==
X-Gm-Message-State: AOAM531yJYxfHYeH9N8Xt6PPQPWWUQmQXhfTVQwYzC1E07ZRkIkK1TuM
        +5bM+y1ci/M4LY5T6siGh6cdh4haGKmcQQ==
X-Google-Smtp-Source: ABdhPJxlXPxCejqMRYFlv5GWVH4xWTo2qW+UFUl840ii3KTRUyJJgu21CuivSdx54aL6siGBc+5Rhg==
X-Received: by 2002:adf:fd0c:: with SMTP id e12mr8562547wrr.61.1610639424859;
        Thu, 14 Jan 2021 07:50:24 -0800 (PST)
Received: from localhost.localdomain ([185.228.231.221])
        by smtp.gmail.com with ESMTPSA id q7sm10170489wrx.62.2021.01.14.07.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 07:50:24 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 2/3] fetch-pack: refactor writing promisor file
Date:   Thu, 14 Jan 2021 16:50:15 +0100
Message-Id: <20210114155016.3005932-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.30.0.83.g36fd80b35a.dirty
In-Reply-To: <20210114155016.3005932-1-chriscool@tuxfamily.org>
References: <20210114155016.3005932-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's replace the 2 different pieces of code that write a
promisor file in 'builtin/repack.c' and 'fetch-pack.c'
with a new function called 'write_promisor_file()' in
'pack-write.c' and 'pack.h'.

This might also help us in the future, if we want to put
back the ref names and associated hashes that were in
the promisor files we are repacking in 'builtin/repack.c'
as suggested by a NEEDSWORK comment just above the code
we are refactoring.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/repack.c |  8 +++-----
 fetch-pack.c     |  8 +-------
 pack-write.c     | 12 ++++++++++++
 pack.h           |  4 ++++
 4 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 279be11a16..2158b48f4c 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -14,6 +14,7 @@
 #include "object-store.h"
 #include "promisor-remote.h"
 #include "shallow.h"
+#include "pack.h"
 
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
@@ -263,7 +264,7 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 	while (strbuf_getline_lf(&line, out) != EOF) {
 		struct string_list_item *item;
 		char *promisor_name;
-		int fd;
+
 		if (line.len != the_hash_algo->hexsz)
 			die(_("repack: Expecting full hex object ID lines only from pack-objects."));
 		item = string_list_append(names, line.buf);
@@ -281,10 +282,7 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 		 */
 		promisor_name = mkpathdup("%s-%s.promisor", packtmp,
 					  line.buf);
-		fd = open(promisor_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
-		if (fd < 0)
-			die_errno(_("unable to create '%s'"), promisor_name);
-		close(fd);
+		write_promisor_file(promisor_name, NULL, 0);
 
 		item->util = (void *)(uintptr_t)populate_pack_exts(item->string);
 
diff --git a/fetch-pack.c b/fetch-pack.c
index c5fa4992a6..1eaedcb5dc 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -777,8 +777,6 @@ static void create_promisor_file(const char *keep_name,
 {
 	struct strbuf promisor_name = STRBUF_INIT;
 	int suffix_stripped;
-	FILE *output;
-	int i;
 
 	strbuf_addstr(&promisor_name, keep_name);
 	suffix_stripped = strbuf_strip_suffix(&promisor_name, ".keep");
@@ -787,11 +785,7 @@ static void create_promisor_file(const char *keep_name,
 		    keep_name);
 	strbuf_addstr(&promisor_name, ".promisor");
 
-	output = xfopen(promisor_name.buf, "w");
-	for (i = 0; i < nr_sought; i++)
-		fprintf(output, "%s %s\n", oid_to_hex(&sought[i]->old_oid),
-			sought[i]->name);
-	fclose(output);
+	write_promisor_file(promisor_name.buf, sought, nr_sought);
 
 	strbuf_release(&promisor_name);
 }
diff --git a/pack-write.c b/pack-write.c
index 3513665e1e..db3ff9980f 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "pack.h"
 #include "csum-file.h"
+#include "remote.h"
 
 void reset_pack_idx_option(struct pack_idx_option *opts)
 {
@@ -367,3 +368,14 @@ void finish_tmp_packfile(struct strbuf *name_buffer,
 
 	free((void *)idx_tmp_name);
 }
+
+void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought)
+{
+	int i;
+	FILE *output = xfopen(promisor_name, "w");
+
+	for (i = 0; i < nr_sought; i++)
+		fprintf(output, "%s %s\n", oid_to_hex(&sought[i]->old_oid),
+			sought[i]->name);
+	fclose(output);
+}
diff --git a/pack.h b/pack.h
index 9fc0945ac9..9ae640f417 100644
--- a/pack.h
+++ b/pack.h
@@ -87,6 +87,10 @@ off_t write_pack_header(struct hashfile *f, uint32_t);
 void fixup_pack_header_footer(int, unsigned char *, const char *, uint32_t, unsigned char *, off_t);
 char *index_pack_lockfile(int fd);
 
+struct ref;
+
+void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought);
+
 /*
  * The "hdr" output buffer should be at least this big, which will handle sizes
  * up to 2^67.
-- 
2.30.0.83.g36fd80b35a.dirty

