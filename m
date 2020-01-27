Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9A7C35242
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 07:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73E420842
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 07:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iP1ArmdN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgA0HEk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 02:04:40 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39175 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbgA0HEj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 02:04:39 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so9731662wrt.6
        for <git@vger.kernel.org>; Sun, 26 Jan 2020 23:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RoY/pvI4yAWUXsyXH8Nid9Dt9ncDunTF8PBKcVdpJIE=;
        b=iP1ArmdNWaxIjKxDoNmh1i4ohNBGqPAkW7SshR8qd9mxUXDg7KpGWDkyv71KqVMOBg
         Rjx9vJKujFy187AnHRkPYAl4StHlaKUj79249ET+FWCZ3cezqMP7BCT74mu6WY+uWPhH
         ggCNqMu529mn6tSIMS6A9EnGJk5Xi0clK5rxWiz4WRoZtURDlrxDGCfXsZHRSbOrAjQ3
         s/ITLHl/ENVVziZllHi9eXUvscmePovHSQM31YkbJ9nTPAZkBgF8kB1/4KjQDBDrOz6u
         k1y+S5O2uDeDh5rtPqt4ugSr5dYwDv3GYP4kbijKrPylhs6kKkzcXRM+KceGXkZ5x5Gv
         5UTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RoY/pvI4yAWUXsyXH8Nid9Dt9ncDunTF8PBKcVdpJIE=;
        b=nbwl+0+2+W1rXkfuuCrZBW5y1bMkzrSW/o1Zaw7N4qujoTIbQXyPCrXckgfz0lOLCQ
         61k9IDNp1JxYvrUd8/zsP2tDStRRXpCsJFssINcGtvH6QiZ7ecdv11mCTXR6uoH6HZ30
         huSsu0p0MRkuNn1FiWu7JBfpGaIKiiN6YAxIiNbFgMKb2coTiHkKHCUCsOLxLLQJ2+E3
         czhGaoMrNSb2v8za5pUGhRfZo+Z2ipYhcrz6sJ5IDVpMCz3SwTOuLoN1n0TEni8KxSCN
         dddfSz0BWXkZ8d6SjFBQZEU93/UjMa03jcViY8B4Q+r3FKfCKnRAOp04fXJiv4U9F5sy
         S2Lw==
X-Gm-Message-State: APjAAAWcuyVX/ZzL57O1Sw6MOM5BnS5zCDnAh4PJm3SJOVFCNpuZzZNo
        l9L20Pzv0bKVIa+50Dw=
X-Google-Smtp-Source: APXvYqz/1Kv+TTccOnB+U+XXZwol9406yAGJ1S3bOZ/y4olSJgvGzNv11+EvZFD0pbvl2SxinBP86w==
X-Received: by 2002:adf:df8e:: with SMTP id z14mr18603885wrl.190.1580108677120;
        Sun, 26 Jan 2020 23:04:37 -0800 (PST)
Received: from localhost ([2a02:810a:8c80:d2c:1d4:baf0:179f:5856])
        by smtp.gmail.com with ESMTPSA id s10sm19510202wrw.12.2020.01.26.23.04.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Jan 2020 23:04:36 -0800 (PST)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 3/6] remote: clean-up config callback
Date:   Mon, 27 Jan 2020 08:04:29 +0100
Message-Id: <e2c36ae2cd5770031160e0736072ee3d8d1577c9.1580108477.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.24.1.497.g9abd7b20b4.dirty
In-Reply-To: <cover.1580108477.git.bert.wesarg@googlemail.com>
References: <cover.1580108477.git.bert.wesarg@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some minor clean-ups in function `config_read_branches`:

 * remove hardcoded length in `key += 7`
 * call `xmemdupz` only once
 * use a switch to handle the configuration type and add a `BUG()`

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/remote.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 4cf929bfc6..9ee44c9f6c 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -273,29 +273,29 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 	if (!starts_with(key, "branch."))
 		return 0;
 
-	key += 7;
-	if (strip_suffix(key, ".remote", &key_len)) {
-		name = xmemdupz(key, key_len);
+	key += strlen("branch.");
+	if (strip_suffix(key, ".remote", &key_len))
 		type = REMOTE;
-	} else if (strip_suffix(key, ".merge", &key_len)) {
-		name = xmemdupz(key, key_len);
+	else if (strip_suffix(key, ".merge", &key_len))
 		type = MERGE;
-	} else if (strip_suffix(key, ".rebase", &key_len)) {
-		name = xmemdupz(key, key_len);
+	else if (strip_suffix(key, ".rebase", &key_len))
 		type = REBASE;
-	} else
+	else
 		return 0;
+	name = xmemdupz(key, key_len);
 
 	item = string_list_insert(&branch_list, name);
 
 	if (!item->util)
 		item->util = xcalloc(1, sizeof(struct branch_info));
 	info = item->util;
-	if (type == REMOTE) {
+	switch (type) {
+	case REMOTE:
 		if (info->remote_name)
 			warning(_("more than one %s"), orig_key);
 		info->remote_name = xstrdup(value);
-	} else if (type == MERGE) {
+		break;
+	case MERGE: {
 		char *space = strchr(value, ' ');
 		value = abbrev_branch(value);
 		while (space) {
@@ -306,12 +306,18 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 			space = strchr(value, ' ');
 		}
 		string_list_append(&info->merge, xstrdup(value));
-	} else
+		break;
+	}
+	case REBASE:
 		/*
 		 * Consider invalid values as false and check the
 		 * truth value with >= REBASE_TRUE.
 		 */
 		info->rebase = rebase_parse_value(value);
+		break;
+	default:
+		BUG("unexpected type=%d", type);
+	}
 
 	return 0;
 }
-- 
2.24.1.497.g9abd7b20b4.dirty

