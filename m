Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4956B1F453
	for <e@80x24.org>; Wed, 24 Apr 2019 15:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbfDXPOq (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 11:14:46 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34941 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730492AbfDXPOp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 11:14:45 -0400
Received: by mail-qt1-f194.google.com with SMTP id l17so1510874qtp.2
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 08:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uJmisl9eTZ2db8prImrjM+CSFfGcBImygH6QMGsr3Tc=;
        b=Eb4nX2eL9cs498Trws8kiJvNVD3d4gdV406ARQht0UqFOb6g2wJ1xlt4ouYUY5R7ck
         OjVHi15nXc4zWlLCgEe6NMj202rKtSxHEZqeQzTuD3hfrjKATLBJHtcI/vQxuc5S2XWg
         Vqz2l5ZdRVNjdKd3y+diSM7Vr0kouNrIjUNiMkVZ5GbjZACyowY38qiHNHQg6EtEoRim
         uwXttUCvJIEwH0BPVoAfp1xpFs+MlNXETqjNCkFTAtq4xIJi8+1cC913lRnW3Z6AoAln
         tGzCfPWfrQ5K4vhMoZu1sCE6ZR7bNB2eliDQywQGAD5/oYoK8HhKST1t2JJ6ZE4A2vsP
         gQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uJmisl9eTZ2db8prImrjM+CSFfGcBImygH6QMGsr3Tc=;
        b=Ow0VDpkQ57hAsr1cbs4CKCOY/Q3YSmtZThayeEnUb1lz0M8UXLPTBxBUJDASRq/o3e
         g21PP9u1+YCadL7dcZ11Q7/qaNHiS+hXKgaS30D7jCdcU/4GzB5xl08s3Hu/EnO5f41e
         +DJWrrf3vxgDnFPd8MqQ+uQg/tCxvojL4YjEvE1P+Unf1NWSJjv2aQR41g56+3gjpKtf
         fWkoWb/Z8Pz7j2Ktkv79wfXJb9c+7NNoavfe+/CNCVSBHaf33xeC7fbjgUDRyS3H6xHo
         iPjvFxXDMOWnSZaPbBLIodyhgkZCGzQ+mXau7oZzLUStqHCiz6Kb/zi9B9XKc6K2u7to
         rB9A==
X-Gm-Message-State: APjAAAUVAWSLPN8uSZeGZXDrr2RBgQVpQCLTcFyl4bmYGM5e+fT63GGB
        ddIvngvYLDkQTgGFS6/Idrsr8uwJ
X-Google-Smtp-Source: APXvYqyFZUrCPCo59qaoBXTGOjmH9vzzADHhHZeHe0deVR8Mv+HMAs45dxmnQTMJYNEXP3/m3wTKLQ==
X-Received: by 2002:a0c:b6c8:: with SMTP id h8mr25594828qve.67.1556118884548;
        Wed, 24 Apr 2019 08:14:44 -0700 (PDT)
Received: from stolee-gitdev.corp.microsoft.com ([2001:4898:8010:2:9efc:3578:ef3e:58d5])
        by smtp.gmail.com with ESMTPSA id j129sm9671005qkd.51.2019.04.24.08.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 08:14:43 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, avarab@gmail.com,
        gitster@pobox.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 01/11] repack: refactor pack deletion for future use
Date:   Wed, 24 Apr 2019 11:14:18 -0400
Message-Id: <20190424151428.170316-2-dstolee@microsoft.com>
X-Mailer: git-send-email 2.21.0.1096.g1c91fdc207
In-Reply-To: <20190424151428.170316-1-dstolee@microsoft.com>
References: <pull.92.v4.git.gitgitgadget@gmail.com>
 <20190424151428.170316-1-dstolee@microsoft.com>
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
index 45583683ee..3d445b34b4 100644
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
index d1e6683ffe..bacecb4d0d 100644
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
index 6c4037605d..5b7bcdb1dd 100644
--- a/packfile.h
+++ b/packfile.h
@@ -86,6 +86,13 @@ extern void unuse_pack(struct pack_window **);
 extern void clear_delta_base_cache(void);
 extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
 
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
2.21.0.1096.g1c91fdc207

