Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C845C202AA
	for <e@80x24.org>; Mon, 25 Feb 2019 23:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbfBYXQt (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 18:16:49 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:43251 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbfBYXQs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 18:16:48 -0500
Received: by mail-wr1-f51.google.com with SMTP id d17so11792969wre.10
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 15:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OCwM8yFl4Q9lZTVWcME4iolZfYe4Yf+Vee4scHj5ORA=;
        b=eqHewjHQ7u85Z0f7L++mTgdUTp90xF932n+9Vuqvz3O/44T3tjo7obqkj9IYtb0PHM
         k01ljqx4JKK2HVF7SuQiLM7Tb32OtT8RSgkeTgqK2DjhKI/dq9NXd/RzIxheom9nEHY5
         h5Pcc/IWWBlKGjO7e8JEO5dOHYKJ+UzVL5yQlHUXf7JgISt/s+g4x1rUfSZPF1qhaS0x
         lDnV9ODjdDTLuL0wZPPtzOSFnRHxTbEcMBnJ2QnbzQCoY/F1+pnxzv6vfid7uiy8u6j4
         XP0rW13chbRTuQTgWV8ZWmEhZApm2qoI7vsc5rvTwd+kohVic3gx4njPI9lQpKDOoKas
         GmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OCwM8yFl4Q9lZTVWcME4iolZfYe4Yf+Vee4scHj5ORA=;
        b=c8ZrLwUWEvlbeRVibuJCpPzRiWI3IjF/oqQUyj0bv/cE2D8OR+8f78kGKevdknqLD0
         vJ7UDpflkwpNcHuuxI0DZ0W4NbOa28o1cP6wG9+/2iGtIjfMxaXCQmJ1Oi0zh+IAfvKj
         /hKtretWS3CZi7l2NB/XgGcEQ3ippdEIZ7XXVAHjn+giKYnRyG1WnIaiG7tTK6Fpe9+d
         Qr3ni8V7iNr5wFrTEHfJQCbT4hRmuNooCnELMgTdfUDZtOzBOZsA2Q+3LUwOhEZsdqvK
         4irKFW2wQM0Ew7A9p3I004h94wzsVaUzEYA+7hgYYOs70kgnjd7dd2NVOBdve9GzLl9P
         waBg==
X-Gm-Message-State: AHQUAuYU5VCp2Pgbp+2YuugN429eXipnwBCAIoY1a+WiCUUdf610FaAb
        qZscZ3x3xtyH5DGxPj5RnQuHcRyU
X-Google-Smtp-Source: AHgI3IbjmNpIY1OS5F9JOvU0QcfBKBZDBv2AUp+ShhZJKzu79FlDQajc+y8JSpIFo11tk3+z2spYbQ==
X-Received: by 2002:adf:de83:: with SMTP id w3mr13677114wrl.56.1551136606598;
        Mon, 25 Feb 2019 15:16:46 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id d21sm32757076wrc.44.2019.02.25.15.16.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 15:16:45 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v13 01/27] sha1-name.c: add `get_oidf()` which acts like `get_oid()`
Date:   Mon, 25 Feb 2019 23:16:05 +0000
Message-Id: <20190225231631.30507-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.291.g17236886c5
In-Reply-To: <20190225231631.30507-1-t.gummerer@gmail.com>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
 <20190225231631.30507-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>

Compared to `get_oid()`, `get_oidf()` has as parameters
a pointer to `object_id`, a printf format string and
additional arguments. This will help simplify the code
in subsequent commits.

Original-idea-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h     |  1 +
 sha1-name.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/cache.h b/cache.h
index ca36b44ee0..7b6b89fc4c 100644
--- a/cache.h
+++ b/cache.h
@@ -1333,6 +1333,7 @@ struct object_context {
 	GET_OID_BLOB)
 
 extern int get_oid(const char *str, struct object_id *oid);
+extern int get_oidf(struct object_id *oid, const char *fmt, ...);
 extern int get_oid_commit(const char *str, struct object_id *oid);
 extern int get_oid_committish(const char *str, struct object_id *oid);
 extern int get_oid_tree(const char *str, struct object_id *oid);
diff --git a/sha1-name.c b/sha1-name.c
index faa60f69e3..cf0e8a3f85 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1542,6 +1542,25 @@ int get_oid(const char *name, struct object_id *oid)
 	return get_oid_with_context(name, 0, oid, &unused);
 }
 
+/*
+ * This returns a non-zero value if the string (built using printf
+ * format and the given arguments) is not a valid object.
+ */
+int get_oidf(struct object_id *oid, const char *fmt, ...)
+{
+	va_list ap;
+	int ret;
+	struct strbuf sb = STRBUF_INIT;
+
+	va_start(ap, fmt);
+	strbuf_vaddf(&sb, fmt, ap);
+	va_end(ap);
+
+	ret = get_oid(sb.buf, oid);
+	strbuf_release(&sb);
+
+	return ret;
+}
 
 /*
  * Many callers know that the user meant to name a commit-ish by
-- 
2.21.0.rc2.291.g17236886c5

