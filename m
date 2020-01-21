Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B70C2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 09:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7692B22522
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 09:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="pJhUn8y/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgAUJZD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:25:03 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39217 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729091AbgAUJZB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 04:25:01 -0500
Received: by mail-wm1-f65.google.com with SMTP id 20so2146730wmj.4
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 01:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6JsNtZkYmg/Qif54pf3N5IxmtY7XFoYh5vm3yM+EwbY=;
        b=pJhUn8y/ioSDCF4SDixCx+rbNGlahU4lHSlbdhqS3bHFo9rTHK8hjzkp5VMP+iUUkl
         qz6hJFrw4RWAvOpyDYovjZrfAoFrbx2Cy6mFmmN/wO0EY8QAJFjXYXG+wcAbejRYUpvX
         rPZLsKeA3P1M0T2NRSFEW6M7PwGAjSmoA8bEOkUjt7ixGE5KAFAqoAC7F8wSjc5rmTyO
         hYbm8DgfoUGSMEMIoRODK4gSfInw1HCP8kR4PVdg61PJ3o20h3zLJc225jg8hCvsMXJ2
         2BffV6DlovuyQKAJ4M657TYbaMDACN2nxcQEZ1Ml2wKUDkfFDpwbjG+FykZhvWlHUMGh
         B6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6JsNtZkYmg/Qif54pf3N5IxmtY7XFoYh5vm3yM+EwbY=;
        b=DxGnvRjQ1wIO8Q+SWBKbzkdoRgRW0328hnCnddGu5zEMhW3k+8mDGGcYR/YH104Lxm
         QFaDIbhjr0eW7Ei8UyzJHjg0HOiS9dszODErPtrCetvvNUEnS+wT6pSmxsvps3fGjPrF
         P2JNCiazRmsZRGJI+9r0deZtBBIc5PR6lVKBnjKHVNCeaEtprUvVWLozpqDNEOC5szi+
         MpeP9+p89Tq1+OndHvkYY75Fuq4v7lQDqwfxPgIcJuxtu0GPQfboYukVydU/ZIzSi8VS
         a2AHUkML6CV4Gdx9nLpq4AbRjQ7G+YDcPrfuuXfoTiZpWhLhDPlTJMPYpLC6aq6AIKBF
         IZLg==
X-Gm-Message-State: APjAAAU4N7gRt5nRvHA8DGqldLOCdiI+1Gl5VH+oQuIzylKpSy4Tshg7
        SgE9H7A1ZW1Xt4q4uCo=
X-Google-Smtp-Source: APXvYqzCp9S5gtPvv5AxJdpeKx0YVKMEm8pwhVMd2YVE8oeUkmdq8ASZF8TSbxJQ+NHqMhQjXilV6g==
X-Received: by 2002:a05:600c:295a:: with SMTP id n26mr3381206wmd.187.1579598699557;
        Tue, 21 Jan 2020 01:24:59 -0800 (PST)
Received: from localhost (m221.zih.tu-dresden.de. [141.30.68.221])
        by smtp.gmail.com with ESMTPSA id g9sm51789971wro.67.2020.01.21.01.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Jan 2020 01:24:59 -0800 (PST)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 3/7] remote: clean-up config callback
Date:   Tue, 21 Jan 2020 10:24:51 +0100
Message-Id: <63df149b8cffb3f4290dee47136e721a5043bd57.1579598053.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.24.1.497.g9abd7b20b4.dirty
In-Reply-To: <cover.1579598053.git.bert.wesarg@googlemail.com>
References: <cover.1579598053.git.bert.wesarg@googlemail.com>
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
index a8bdaca4f4..9466e32b3d 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -273,29 +273,29 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 	enum { REMOTE, MERGE, REBASE } type;
 	size_t key_len;
 
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
@@ -306,8 +306,14 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 			space = strchr(value, ' ');
 		}
 		string_list_append(&info->merge, xstrdup(value));
-	} else
+		break;
+	}
+	case REBASE:
 		info->rebase = rebase_parse_value(value);
+		break;
+	default:
+		BUG("unexpected type=%d", type);
+	}
 
 	return 0;
 }
-- 
2.24.1.497.g9abd7b20b4.dirty

