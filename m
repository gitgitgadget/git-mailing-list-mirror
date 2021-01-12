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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6C6C433E6
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75E0822D2C
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404835AbhALIXC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 03:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbhALIW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 03:22:57 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA7BC061794
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 00:22:17 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id e25so1211080wme.0
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 00:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l5kKR0W4pjUI7ggKuTjT52VNx/DhQw0P/DpRqSnJEzk=;
        b=Ab5XGJJ5ZlJGA+ZOY03m6s8zZ3dgYUwKqF/ACWdyPgPZzsUnYTwPzBjpHFvfb6LcFv
         nNp3PcQ7IGXuXRKaW7S+s/8jyLnk9vsw36LkQ8u88BD5+Pkb+T6ZpEVCB223X+pKq1Yq
         Ic0/s3n2VMmO84oekbyvt8GWzvB1G114k0a0iO8++w3V+BUXwMbCuhzxbIoYOS8I5cby
         xvQfRHgtR0dvrkjTNQGAyIjr9zOlKuGdB55PMi/mzOPFGYpZ5UyISbdo4oPiqJJXfeGp
         I4+lGvpSpkTTRsHvG0+TCFuzJSH50ELf8bUWCPmt/1dYyPi8o4uEds2AHJO8ilKdsFkc
         OVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l5kKR0W4pjUI7ggKuTjT52VNx/DhQw0P/DpRqSnJEzk=;
        b=uCpXYCrvWuHmKlDycPjuhoA8iBqX0Rr7rPzLZ1qNr5fs3VWJAtoF7cDePu0psLsawZ
         bJSj40wNMRRyl/TCrvtqgY+fZWOToowAsXS7dbsDr4KNd+jVVQavkIZeEhslB8VS6raq
         RVULmW6rVS5uYK0l0hrIrxEtHsLeVG0lpUihlKh4rensA+sb86254f9uctM5HcXj4GDT
         zJul0VPxkpAuaMbOw8cpDKt1BlrM24jB/o8BhO6ozjWA6+vu+uhCgZh2JwGc2uAeSEhc
         lrJ82YiK+w2gOAx1VI6JGjinNHo3/R6BjdQs95pan5lLIUTivLwaaJJmZ21WRiyAXEI1
         MyMg==
X-Gm-Message-State: AOAM531O2nlBP95qGBYiq0yn6VvGHmRKbRXSKEUgULqn+H9fcodCi+5x
        Xa1V1k0dKQJgCMPXZMOMjS2pA4wr5Ctzzg==
X-Google-Smtp-Source: ABdhPJyxsGUU1ZCTWzza668qUcyTccvaIZbJvPt7ne5FWCIUhTrt8ZM2O+iwkTRhxmO7P1JiJp2rJA==
X-Received: by 2002:a7b:c198:: with SMTP id y24mr2378227wmi.151.1610439735631;
        Tue, 12 Jan 2021 00:22:15 -0800 (PST)
Received: from localhost.localdomain ([193.57.125.79])
        by smtp.gmail.com with ESMTPSA id f9sm3919247wrw.81.2021.01.12.00.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 00:22:15 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 2/2] fetch-pack: refactor writing promisor file
Date:   Tue, 12 Jan 2021 09:21:59 +0100
Message-Id: <20210112082159.2277214-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.30.0.83.g36fd80b35a
In-Reply-To: <20210112082159.2277214-1-chriscool@tuxfamily.org>
References: <20210112082159.2277214-1-chriscool@tuxfamily.org>
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
2.30.0.83.g36fd80b35a

