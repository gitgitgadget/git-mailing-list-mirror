Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BBA61F461
	for <e@80x24.org>; Tue, 14 May 2019 18:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfENSsB (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 14:48:01 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34877 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfENSsA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 14:48:00 -0400
Received: by mail-yb1-f193.google.com with SMTP id k202so47776ybk.2
        for <git@vger.kernel.org>; Tue, 14 May 2019 11:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mAF6FHEC0v1bwPVDs4U8j0qt4ZT7mzmVDQS5eGWgfnI=;
        b=ubh7ZtnTzgEZRXiwwLSigmMZ6kr5b78uX3cu3k9ijx8DvhtTwjLIxecZHf8/yDPBH4
         4tUPnOY6uR5wZkIXItii7n9bB+oiPtFYsH4ILlh+B1f+f0VHCb8cE7CXsRkTXphkaMFD
         odPZOKS6875SUmhF3lhTwjET1VJu8CNoNzS/eZWFpqRJ9ogJqCg/wKblebXxSbSrW4Wg
         yzk1y/kqOKeda7ds+ww4QK/EnQZbcBqfKW0eKGdSt9xtMTyPZJ/4TFajRGSjWFXQl/Ph
         7lsEuH+5Jtu6fcQ7hxjphQlbfle3q7UrS8RCzB2b6zNq9gcX5TKLGjCB44+MJiLJFPFj
         f/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mAF6FHEC0v1bwPVDs4U8j0qt4ZT7mzmVDQS5eGWgfnI=;
        b=LTcxaV0oqHfIVJPqPL0Hr2G/lBPBWN47JmpBtJB42Af3ih0TEtuwS3aE+Qgjxesv8o
         EgWVLgb00NXa208drGzRhGbjbMFT0jNWQjb2HVbt8aq/sSIrtypcmB61o5rbQdOpgPJt
         +QbWl+mHqJQswa1rwPkElXXrFF9EvtfWbIGX+u3D6rIhCY8WrHIlMte7c/Qqe/vBNXBr
         b7LRyrd75exjQVZjRh43dSJBpw3IAoa9OmdeXHTFgpIcr+ODwlNi/zC6RZ7lm8NOWw0I
         p5RWEpavBopnjGiINPuGDlDj+IMc6Xcy0gkOJlEFvcXKCcpbrl4HDNVdbp31QcfX7+hh
         2c7Q==
X-Gm-Message-State: APjAAAWdxrRinG/2tbOgavTvOIO7B9U5/zOJXoxz8JwcHB+/5DglWFqX
        /RGy7PXqWYapVTzamDBPhOWCm9PS58s=
X-Google-Smtp-Source: APXvYqzriCk9B68663mlRzAZ2INF/PnljILVDzGL1FNHts2GJoHN65v9Yg/hlSVkW6Bh2cRA0e9qpg==
X-Received: by 2002:a25:5456:: with SMTP id i83mr17582718ybb.301.1557859679830;
        Tue, 14 May 2019 11:47:59 -0700 (PDT)
Received: from linux.mshome.net ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id u17sm3438627ywu.94.2019.05.14.11.47.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 11:47:58 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
        avarab@gmail.com, dstolee@microsoft.com
Subject: [PATCH v6 01/11] repack: refactor pack deletion for future use
Date:   Tue, 14 May 2019 18:47:44 +0000
Message-Id: <20190514184754.3196-2-dstolee@microsoft.com>
X-Mailer: git-send-email 2.22.0.rc0
In-Reply-To: <20190514184754.3196-1-dstolee@microsoft.com>
References: <20190424151428.170316-1-dstolee@microsoft.com>
 <20190514184754.3196-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The repack builtin deletes redundant pack-files and their
associated .idx, .promisor, .bitmap, and .keep files. We will want
to re-use this logic in the future for other types of repack, so
pull the logic into 'unlink_pack_path()' in packfile.c.

The 'ignore_keep' parameter is enabled for the use in repack, but
will be important for a future caller.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/repack.c | 14 ++------------
 packfile.c       | 28 ++++++++++++++++++++++++++++
 packfile.h       |  7 +++++++
 3 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 67f8978043..1f9e6fad1b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -129,19 +129,9 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list,
 
 static void remove_redundant_pack(const char *dir_name, const char *base_name)
 {
-	const char *exts[] = {".pack", ".idx", ".keep", ".bitmap", ".promisor"};
-	int i;
 	struct strbuf buf = STRBUF_INIT;
-	size_t plen;
-
-	strbuf_addf(&buf, "%s/%s", dir_name, base_name);
-	plen = buf.len;
-
-	for (i = 0; i < ARRAY_SIZE(exts); i++) {
-		strbuf_setlen(&buf, plen);
-		strbuf_addstr(&buf, exts[i]);
-		unlink(buf.buf);
-	}
+	strbuf_addf(&buf, "%s/%s.pack", dir_name, base_name);
+	unlink_pack_path(buf.buf, 1);
 	strbuf_release(&buf);
 }
 
diff --git a/packfile.c b/packfile.c
index 060de420d1..683ce5674c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -352,6 +352,34 @@ void close_all_packs(struct raw_object_store *o)
 	}
 }
 
+void unlink_pack_path(const char *pack_name, int force_delete)
+{
+	static const char *exts[] = {".pack", ".idx", ".keep", ".bitmap", ".promisor"};
+	int i;
+	struct strbuf buf = STRBUF_INIT;
+	size_t plen;
+
+	strbuf_addstr(&buf, pack_name);
+	strip_suffix_mem(buf.buf, &buf.len, ".pack");
+	plen = buf.len;
+
+	if (!force_delete) {
+		strbuf_addstr(&buf, ".keep");
+		if (!access(buf.buf, F_OK)) {
+			strbuf_release(&buf);
+			return;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(exts); i++) {
+		strbuf_setlen(&buf, plen);
+		strbuf_addstr(&buf, exts[i]);
+		unlink(buf.buf);
+	}
+
+	strbuf_release(&buf);
+}
+
 /*
  * The LRU pack is the one with the oldest MRU window, preferring packs
  * with no used windows, or the oldest mtime if it has no windows allocated.
diff --git a/packfile.h b/packfile.h
index 12baa6118a..09f5222113 100644
--- a/packfile.h
+++ b/packfile.h
@@ -94,6 +94,13 @@ void unuse_pack(struct pack_window **);
 void clear_delta_base_cache(void);
 struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
 
+/*
+ * Unlink the .pack and associated extension files.
+ * Does not unlink if 'force_delete' is false and the pack-file is
+ * marked as ".keep".
+ */
+extern void unlink_pack_path(const char *pack_name, int force_delete);
+
 /*
  * Make sure that a pointer access into an mmap'd index file is within bounds,
  * and can provide at least 8 bytes of data.
-- 
2.22.0.rc0

