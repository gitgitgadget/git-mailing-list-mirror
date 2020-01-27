Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD69CC32771
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 07:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B5E20842
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 07:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="N6ZAgwOZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgA0HEi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 02:04:38 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54235 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgA0HEh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 02:04:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id s10so2062720wmh.3
        for <git@vger.kernel.org>; Sun, 26 Jan 2020 23:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZEsudpfXVpuJMD3Z3BSclWands5qePBGaY0KhdJm14A=;
        b=N6ZAgwOZigQo4TIW1We3vkf8WwdOkgYu5NxtOMfHr/z0g8DrfQrydwCrFKu20DzTAu
         BsuExVkc/gx7ikrRGOT2tEivyznFxo6MlotjoCsc/iCkU1JBuKzuS8lBIM4Ejb23vAJz
         EUc/JDPfgU8/RI+xhNCckP1jdnJDxIhyTHJAKrdZqU0kbsQ15HFzpO030jJXEBxWaVMy
         EG2s6fgKrE9vLAm5Q8n58mVvCdSphO25urlKCRlRnRctYZx6JRKvsSVbCzjYS9QBHGAm
         rO/k6NS6nMNkjuhLcSBWqS2X+XXYVqT61Z31X4WBdOKxmYyVmw+Es85SnqQ9QfkH4XzF
         NLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZEsudpfXVpuJMD3Z3BSclWands5qePBGaY0KhdJm14A=;
        b=QweTJxH1bKx6SbLoZxRgkGKswg9MLnXFtXfHQCv0vR6GAWxwvOMHuOcg3uj0ZeOjZX
         sv5J+3nKXYmIOLkt08NKpnJV99AKv+z4qMf2hj8Nxgxpd1FhIcMJUa5aHsKeipvvwCo/
         +sactWwz1lGj4NNvKkcotxkf5mvu2kq11NXY7OgTUtV+0WIjxf2FIj/ZZKk3tCI3R4Zr
         Bf8erX+ScSS+mCvVwB4zjNYChyAdYsJjNZ7brfcpNTBQFpxy1lz9ZG9Wpl++TFqfaGAp
         WtfJUxZ8xUoLGkjTJqJ6UD1ArupCRqtVGIqj4RsjN/L0QWc9xfsgeKku/598jMYH6yGy
         cuCA==
X-Gm-Message-State: APjAAAVkqLtjAP5yAzeNBEgAK3oCJGbunCFfsO7qFxZ8PC8htr1S/z/M
        tXGbg24nmCC9tq4R+TU=
X-Google-Smtp-Source: APXvYqz/tDdGfWIPaqPI6CYdmk0zBp/Dd6ObnIx4Siz+aQjaG/4vRZmzDoOmHollOYDxQRle52EjCg==
X-Received: by 2002:a1c:ddc3:: with SMTP id u186mr12169835wmg.103.1580108675966;
        Sun, 26 Jan 2020 23:04:35 -0800 (PST)
Received: from localhost ([2a02:810a:8c80:d2c:1d4:baf0:179f:5856])
        by smtp.gmail.com with ESMTPSA id 5sm20219120wrh.5.2020.01.26.23.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Jan 2020 23:04:35 -0800 (PST)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/6] remote: clean-up by returning early to avoid one indentation
Date:   Mon, 27 Jan 2020 08:04:28 +0100
Message-Id: <aab595b55abedb9cc519a587dfd75477a8afd363.1580108477.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.24.1.497.g9abd7b20b4.dirty
In-Reply-To: <cover.1580108477.git.bert.wesarg@googlemail.com>
References: <cover.1580108477.git.bert.wesarg@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
Cc: Junio C Hamano <gitster@pobox.com>

Changes since v1:
 * avoid mixed declarations and code statements
---
 builtin/remote.c | 94 ++++++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 46 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 6802765e73..4cf929bfc6 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -263,54 +263,56 @@ static const char *abbrev_ref(const char *name, const char *prefix)
 
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
+	const char *orig_key = key;
+	char *name;
+	struct string_list_item *item;
+	struct branch_info *info;
+	enum { REMOTE, MERGE, REBASE } type;
+	size_t key_len;
 
-		item = string_list_insert(&branch_list, name);
+	if (!starts_with(key, "branch."))
+		return 0;
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
+		/*
+		 * Consider invalid values as false and check the
+		 * truth value with >= REBASE_TRUE.
+		 */
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
-			/*
-			 * Consider invalid values as false and check the
-			 * truth value with >= REBASE_TRUE.
-			 */
-			info->rebase = rebase_parse_value(value);
-	}
 	return 0;
 }
 
-- 
2.24.1.497.g9abd7b20b4.dirty

