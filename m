Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC51C2D0CE
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 09:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DEDB214AF
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 09:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cQ+TSAiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbgAXJZd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:25:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32794 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbgAXJZc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 04:25:32 -0500
Received: by mail-wm1-f66.google.com with SMTP id m10so3118430wmc.0
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 01:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DyHHivxss+vJsvXP+/tp2pYiIergF+KDNzC01hr3fTU=;
        b=cQ+TSAiUs6lbnGYSI34+PiRrmX650aCZtgA5n5SluPVyU5NOHXNUfodhdpf2ffEm5p
         8do7ZelIDkX5D/T5BkvqB7NmEOZosy1AsAs3ERY0ydgSkiZhzEEBsH36FSykLE2QXEj7
         IJgyyPdypT7R7C6v/K9IfMyGlM2dTvyyDYcSL09ngN10XxcyV8eCGr0gLMD4P9vla0js
         6L9r60v0yAHqzHm2tREzAnna1zhymMbkRnx32UFYLg9CJLa3MyDzni8m+C/S+7B11RrN
         Fkvw7OKPKGxgT9DZ3WA/hl51rFA+/wF/wUZkaBiZrdLZZdUNs7ZnR5fBX6oNgnllSAKW
         sPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DyHHivxss+vJsvXP+/tp2pYiIergF+KDNzC01hr3fTU=;
        b=REmdpcseQCWw7BS2oh9Y58qt23hUNmAzpx18Gi5CH4nEVeLeXoIykA93cpDAog/tAf
         AqCddWwIrgBX4bBI3ls8QarPQ1IQxKiFOBpB1Qb3YPKrUwQTmgiSXu1DwZS+GkvNbwIB
         /Db1LfI2sQg8kD9qtgK0pv9bcHnvqmqnYEUzxaDnkLDhwYkfp4YlupKFun7pgr6UfujZ
         6Ho5l2lFxnKOIGTXPFcmpfZAcYS7mQtwDBihqLRwT/dxZV2JYcllrSE5WzUi0fbDjxhE
         3sA3VOMcCLGtE1snT6by5eba5r8fh2/GbI6cxPOy+pTrCY2wnFThJHP1FHgDruOreMLR
         p4ew==
X-Gm-Message-State: APjAAAWmI8RupFuuZmjh5Hu1/ZHiVoVotocMrx6s6EmLU2dWczErNiL9
        +eTL7T5HYhO+2YAmtZ0=
X-Google-Smtp-Source: APXvYqz4ymWx1Y58Pt7lNO3r6zlZTRh7J/sHOccJ1JfemQAMMi19gaWFlLphngPOxI1Sq6CyTb8TEQ==
X-Received: by 2002:a1c:5448:: with SMTP id p8mr2543805wmi.159.1579857931256;
        Fri, 24 Jan 2020 01:25:31 -0800 (PST)
Received: from localhost (m221.zih.tu-dresden.de. [141.30.68.221])
        by smtp.gmail.com with ESMTPSA id q6sm7132821wrx.72.2020.01.24.01.25.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Jan 2020 01:25:30 -0800 (PST)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/7] remote: clean-up by returning early to avoid one indentation
Date:   Fri, 24 Jan 2020 10:25:22 +0100
Message-Id: <f8f3fd1f2151866891c4ba9cd4e3080fec3c9e9c.1579857394.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.24.1.497.g9abd7b20b4.dirty
In-Reply-To: <cover.1579857394.git.bert.wesarg@googlemail.com>
References: <cover.1579857394.git.bert.wesarg@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
Changes since v1:
 * avoid mixed declarations and statements

Cc: Junio C Hamano <gitster@pobox.com>
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

