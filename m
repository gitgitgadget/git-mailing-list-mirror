Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C979C33CAA
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 09:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040D324125
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 09:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZnwGBOGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgAUJZB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:25:01 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36940 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728913AbgAUJZA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 04:25:00 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so2163740wmf.2
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 01:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jVyebLi8KS3ba+BiSTaEdXBwSuoKqxyH+Ch+W/Jcfno=;
        b=ZnwGBOGNuIIl8+HVeZENyYi0RGosnmTYBK0kGzlL/1kcWe8+8IWx2QcNoMSjQcJR83
         poVeCc1BIUaxuJKr72OiSW83fLlRuUoCo0L//jBNdLrF++SuyBPexOsAlCku2ZpHlIQC
         SuD69SkZ0mlrwusFd0lY6izlYOg9HXHrB8aOoLK62bygbqD/56d26P0h/e3agMa9Ld1v
         iodlPUTcSiUP38Pwq8vJPYk+ceVuQLmq7vj66kK7Wzxse98Sa/MuLPPCUdSBXnqizHGG
         J/xo05i2Il2CFcBzvprqmkJzP0L+UAPy6wYH42UOD1cqNGmS1Qew7Pmck5PymmfKCRCy
         jR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jVyebLi8KS3ba+BiSTaEdXBwSuoKqxyH+Ch+W/Jcfno=;
        b=USxulrJjbIEpozsEobMnaY8awyzsdkjF+ClxmMcUVQFecNGsVUSRkA9D7aYz0Usuu0
         JyLmJF/OEXBxZ5S+m/BGT7fHSpP7AD1bSS2brGO1N/3JcBQ0p3aa7LQhCNBN8kZQz0ea
         BZnb0x711C4Cd06t3ylWgAKIaeO5is8O1OZrzTY4SZe7jz7lrXIOx/cmCz1C1HdBgViR
         pg+wbxwDsKXmMPgynVT9jdEbQ7WCCpavAwrPKQHkuY7lfbgOB7L+eu9KgtcS8Q69Q2z9
         qDs19Z8KiQYKG9Av5xbt6Zp46g2j/Prly5+xis91Srui8OnkvL74EHr0DrD4AnIWKZwQ
         0Iuw==
X-Gm-Message-State: APjAAAV9eoTn/Q8i25OMc+YUC7hJpVL8E2RywaOEibHMm3xoldvFUUm9
        zIgeEyom3pEZPtuYSm4=
X-Google-Smtp-Source: APXvYqx/7+0qk7rPAUcHIGvJQ9IRWAyZdxuvk7oozBUnQNNXNzTcx4eHU4HrYuRWQWNIdDstTeUsVQ==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr3474289wmk.50.1579598698555;
        Tue, 21 Jan 2020 01:24:58 -0800 (PST)
Received: from localhost (m221.zih.tu-dresden.de. [141.30.68.221])
        by smtp.gmail.com with ESMTPSA id v14sm51165084wrm.28.2020.01.21.01.24.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Jan 2020 01:24:58 -0800 (PST)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/7] remote: clean-up by returning early to avoid one indentation
Date:   Tue, 21 Jan 2020 10:24:50 +0100
Message-Id: <59b97032fa158ccc9aee9d52b9cb969cd8df6a5f.1579598053.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.24.1.497.g9abd7b20b4.dirty
In-Reply-To: <cover.1579598053.git.bert.wesarg@googlemail.com>
References: <cover.1579598053.git.bert.wesarg@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
Cc: Junio C Hamano <gitster@pobox.com>
---
 builtin/remote.c | 86 +++++++++++++++++++++++++-----------------------
 1 file changed, 44 insertions(+), 42 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 2830c4ab33..a8bdaca4f4 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -263,50 +263,52 @@ static const char *abbrev_ref(const char *name, const char *prefix)
 
 static int config_read_branches(const char *key, const char *value, void *cb)
 {
-	if (starts_with(key, "branch.")) {
-		const char *orig_key = key;
-		char *name;
-		struct string_list_item *item;
-		struct branch_info *info;
-		enum { REMOTE, MERGE, REBASE } type;
-		size_t key_len;
-
-		key += 7;
-		if (strip_suffix(key, ".remote", &key_len)) {
-			name = xmemdupz(key, key_len);
-			type = REMOTE;
-		} else if (strip_suffix(key, ".merge", &key_len)) {
-			name = xmemdupz(key, key_len);
-			type = MERGE;
-		} else if (strip_suffix(key, ".rebase", &key_len)) {
-			name = xmemdupz(key, key_len);
-			type = REBASE;
-		} else
-			return 0;
+	if (!starts_with(key, "branch."))
+		return 0;
 
-		item = string_list_insert(&branch_list, name);
+	const char *orig_key = key;
+	char *name;
+	struct string_list_item *item;
+	struct branch_info *info;
+	enum { REMOTE, MERGE, REBASE } type;
+	size_t key_len;
+
+	key += 7;
+	if (strip_suffix(key, ".remote", &key_len)) {
+		name = xmemdupz(key, key_len);
+		type = REMOTE;
+	} else if (strip_suffix(key, ".merge", &key_len)) {
+		name = xmemdupz(key, key_len);
+		type = MERGE;
+	} else if (strip_suffix(key, ".rebase", &key_len)) {
+		name = xmemdupz(key, key_len);
+		type = REBASE;
+	} else
+		return 0;
+
+	item = string_list_insert(&branch_list, name);
+
+	if (!item->util)
+		item->util = xcalloc(1, sizeof(struct branch_info));
+	info = item->util;
+	if (type == REMOTE) {
+		if (info->remote_name)
+			warning(_("more than one %s"), orig_key);
+		info->remote_name = xstrdup(value);
+	} else if (type == MERGE) {
+		char *space = strchr(value, ' ');
+		value = abbrev_branch(value);
+		while (space) {
+			char *merge;
+			merge = xstrndup(value, space - value);
+			string_list_append(&info->merge, merge);
+			value = abbrev_branch(space + 1);
+			space = strchr(value, ' ');
+		}
+		string_list_append(&info->merge, xstrdup(value));
+	} else
+		info->rebase = rebase_parse_value(value);
 
-		if (!item->util)
-			item->util = xcalloc(1, sizeof(struct branch_info));
-		info = item->util;
-		if (type == REMOTE) {
-			if (info->remote_name)
-				warning(_("more than one %s"), orig_key);
-			info->remote_name = xstrdup(value);
-		} else if (type == MERGE) {
-			char *space = strchr(value, ' ');
-			value = abbrev_branch(value);
-			while (space) {
-				char *merge;
-				merge = xstrndup(value, space - value);
-				string_list_append(&info->merge, merge);
-				value = abbrev_branch(space + 1);
-				space = strchr(value, ' ');
-			}
-			string_list_append(&info->merge, xstrdup(value));
-		} else
-			info->rebase = rebase_parse_value(value);
-	}
 	return 0;
 }
 
-- 
2.24.1.497.g9abd7b20b4.dirty

