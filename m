Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426BDC2BA1B
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 13:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197B9206C3
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 13:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwMWEQgk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgDDNnz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Apr 2020 09:43:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40601 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgDDNnz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Apr 2020 09:43:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id t24so5062211pgj.7
        for <git@vger.kernel.org>; Sat, 04 Apr 2020 06:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k0TTErNib/oVDKYqMrFH1TE4YX/C72t6kSBmdz23lsc=;
        b=QwMWEQgku+5FnqFnMP0IMZeHoLG0Iu2KR4DVe5bjLEgFVDSuvp4sO1YfGb/CltC4UX
         pBk3nal9uAPj7kq6yhjnU4gCAm1pb3LULpPTnR4PadkFLeSuD/UqLKcDIHxvNRo/pwd/
         CJLDDfwbxSG61wiy4KlPlNzhX+tVZtSzOAckn9WrLOl5Hl0VyMLZ8zx2/zR0XRqjSKtK
         l0z3lYF9pLJUgejNY4GyV1YV8Dcz+C0khwgRNKP9MGTQYgj3yPB+GQ8LRwNZIHEgzuIQ
         3FBovoy9vF6yDzjiAQPMjGZZA6GiY0nDGbjeYujYIzyVzQa0BueCR3pkEiaTk4ZLyJ6a
         MYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k0TTErNib/oVDKYqMrFH1TE4YX/C72t6kSBmdz23lsc=;
        b=ApxAPCkPphQJKn4knYCPm2qqNRZdUh1+R0syhW0yqHVmjqO28GF5CDAba79KiVDQgI
         i9upZ6t6mC1cnaT4yUyGvRaCw2N+UMxmlt4FMy2H+PhiU/Df3i/ytdTOhsTnS1OyIZi9
         gb51sKJ0d0muHkmSD5/0G/v+fAXZ/VstjUa4Lu5IUsLWmbv+ug3ygv1mVDJAKzCxr3gs
         MQmYd7xjHKC2o8DDfuZ+SHqpxqEw/I61DY82O+bRg85lBl4qoaIo6N6cfPQmSftLutvX
         WoGfVL0aMOX+y/0xYjORhQd3skVtsoE3E0KYmg6GPLes+sMwGMTE/eI7qW3X2LbF9KXX
         a00w==
X-Gm-Message-State: AGi0PubK7rSupLp+nvgRN5OceX93s3Y9AYb8D/344A3qo0Klddwd7LaI
        9LZOenBuE9dYYdj9PI9tO9IojmUU
X-Google-Smtp-Source: APiQypKwH9hY2c6jUTyk80OAJ8JDxUiRhO2MX4R0j6xetkuZ9xZ52+flNszpmn4jtuEx6sWEBRDPyw==
X-Received: by 2002:a65:5881:: with SMTP id d1mr12803329pgu.378.1586007833683;
        Sat, 04 Apr 2020 06:43:53 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y15sm7755531pfc.206.2020.04.04.06.43.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Apr 2020 06:43:53 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v8 3/7] refs.c: refactor to reuse ref_is_hidden()
Date:   Sat,  4 Apr 2020 09:43:41 -0400
Message-Id: <20200404134345.10655-4-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200403160838.6252-1-worldhello.net@gmail.com>
References: <20200403160838.6252-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Add new function `ref_is_matched()` to reuse `ref_is_hidden()`. Will use
this function for `receive-pack` to check commands with specific
prefixes.

Test case t5512 covered this change.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 refs.c | 11 ++++++++---
 refs.h |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 1ab0bb54d3..229159ea1a 100644
--- a/refs.c
+++ b/refs.c
@@ -1389,13 +1389,18 @@ int parse_hide_refs_config(const char *var, const char *value, const char *secti
 }
 
 int ref_is_hidden(const char *refname, const char *refname_full)
+{
+	return ref_is_matched(hide_refs, refname, refname_full);
+}
+
+int ref_is_matched(struct string_list *match_refs, const char *refname, const char *refname_full)
 {
 	int i;
 
-	if (!hide_refs)
+	if (!match_refs)
 		return 0;
-	for (i = hide_refs->nr - 1; i >= 0; i--) {
-		const char *match = hide_refs->items[i].string;
+	for (i = match_refs->nr - 1; i >= 0; i--) {
+		const char *match = match_refs->items[i].string;
 		const char *subject;
 		int neg = 0;
 		const char *p;
diff --git a/refs.h b/refs.h
index 545029c6d8..a2ea043f7f 100644
--- a/refs.h
+++ b/refs.h
@@ -739,6 +739,7 @@ int parse_hide_refs_config(const char *var, const char *value, const char *);
  * parameter always points to the full ref name.
  */
 int ref_is_hidden(const char *, const char *);
+int ref_is_matched(struct string_list *, const char *, const char *);
 
 enum ref_type {
 	REF_TYPE_PER_WORKTREE,	  /* refs inside refs/ but not shared       */
-- 
2.24.1.15.g448c31058d.agit.4.5

