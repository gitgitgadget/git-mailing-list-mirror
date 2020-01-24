Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69D3C2D0CE
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 09:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7710220838
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 09:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="P8FpdOQl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbgAXJZf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:25:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34094 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730364AbgAXJZe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 04:25:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so1120335wrr.1
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 01:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RoY/pvI4yAWUXsyXH8Nid9Dt9ncDunTF8PBKcVdpJIE=;
        b=P8FpdOQl9LuUGUQ5xZtsSB9fy52mXqqalh62eo8gQeaPoT9Sv0YakKezsYYFpd04s6
         rgbLP+0sxLsZLiGRyIcJbYJC5Gm3T1hI3Sg7B4iGN7Uy6b9o6akoISdxxrURU4hQeWeT
         zCjXXSQxpZn7CwrBmDrSEDITy63dEZ3Phlj+PzzWOM8pBdqiFnPgNe2ntw2l9XtblrQT
         +NbeQtJEL/tv+MTeU20K4K3tlSyTIg6ak/6x8gm+RtxhG/1TGnla4B47As+Af8PgPexG
         daqLw3iSHDZwvPnx/ofTvM++tZtxuMXJ3Q86vRePUoQk7imdKnVhFdL0TBNjnUBDBUqe
         jzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RoY/pvI4yAWUXsyXH8Nid9Dt9ncDunTF8PBKcVdpJIE=;
        b=TN+EjACeMe1pPYvKSrq74hm1HlSkLIulHN3b6CwWu7awE1kHxei6yb32q9JQuwYva5
         ozmX9SC4iNm+GA1XwiDPrMOsLvzeKvz32XPXRs0h1sg7jI/vSprzdT/dE/Iq4dP4aVGR
         dUCUsesjJHyxWd89wiRZGSIcSS5iAS6gFkC1EWsSv/SrwPAfpl2VVUGkEOl7Qa9vTQda
         iZVOXdeL1vpBr3beUkhQ3fGvyE4MYLonCTzTU7BBdN18p/ENiiFzHywhTEx1OD2pJblI
         UglAS3T25HtL97NmbY1y4o7O4/xHMEPHL5x7JqaMOGI3lIv/eDvpbDsFsToNM3WPYpjf
         +Drw==
X-Gm-Message-State: APjAAAXX2LzdyUeKoqPJPFVxzS5wCXiiNjeS8xo69WlO3+P+souXRJRs
        Js2Hd0CQS/AHVjfE264=
X-Google-Smtp-Source: APXvYqz9/J6cix7cT0UmMDdp4Z4R3dUZ8VlxmjfzG4e7sGhOznmdJrhwFuV7lTXBz4H1lHY3NFYIpg==
X-Received: by 2002:a05:6000:11c3:: with SMTP id i3mr3129422wrx.244.1579857932311;
        Fri, 24 Jan 2020 01:25:32 -0800 (PST)
Received: from localhost (m221.zih.tu-dresden.de. [141.30.68.221])
        by smtp.gmail.com with ESMTPSA id b128sm6055600wmb.25.2020.01.24.01.25.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Jan 2020 01:25:31 -0800 (PST)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 3/7] remote: clean-up config callback
Date:   Fri, 24 Jan 2020 10:25:23 +0100
Message-Id: <f4bd2461996cfa5c3a949bf5957ebb08ae716b4d.1579857394.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.24.1.497.g9abd7b20b4.dirty
In-Reply-To: <cover.1579857394.git.bert.wesarg@googlemail.com>
References: <cover.1579857394.git.bert.wesarg@googlemail.com>
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

