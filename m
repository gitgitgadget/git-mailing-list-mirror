Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E1BC4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 09:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiKIJHq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 04:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiKIJHI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 04:07:08 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667232125A
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 01:07:07 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id v3so15690722pgh.4
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 01:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPoB6+TLc6uTYpftf3P6hJM595YQRvfz+smprDfxBJs=;
        b=X6csY0pGHcW7iWpR03F5bc9MQjptw0fYbPuz6l5YrQrh6UeaictjycW2SZXmVltAet
         YNtFLqvBVBOUDb9skHiGfO7kqUgoBVg2yviE/C2szF+JvZoqJFoZhFcEdVlWq561LPFT
         kO3sNPA3lCdq31d9H9TSUtO55GkXXbrtYaHMWgc3PWR4VALyg/TBKR4sFN/gDkBsMzto
         OfUTO2O5t/CZavbkfKhTYucOKmIXd4ZJ/1cjeS2/81/WKxl2cJvvPzNdCYdarObqm2vs
         FbFGfKl2uYnxq34CVqT1U+k9xaFxQi5XzZojY4RjaioqvHtCLQ75sgF/vdsNxhFfE+Sd
         dgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPoB6+TLc6uTYpftf3P6hJM595YQRvfz+smprDfxBJs=;
        b=KujWswEpOZ3E/2qCuHTq5H+My31Gtjb/4AcuCc0Ou9t448bKbtlaCVPu/tL5sxsy3O
         ATuH9+12n0MAQ5w49z+b9QnmUebevMEQDaDAK877XDDNKJKFdtHY6TuHva/Z1A0Jclo2
         IPd5TemCLOfY7wAFEuidhwJCqEjvOQlax5IR3QvsAZx/IIHiq38zVluTbbknm7mHZ6Qn
         rdpxxkfiItQJb9v2GKK3SOJmM4GyvJTDXbvh/UvRNIkCUr0QieQtW7733cYifX/4q10h
         v5Dj+qxziTfJJW5lKbF6dXZFyehKJ9sv21msaKkdNX4IJZyaVoeqZfExvUXEyI/zCsT2
         GtAw==
X-Gm-Message-State: ACrzQf15ICluDT4vqCGikx6FriJwsR4dQ4AX5jCjipP7CURnnWOrlkiE
        zqjPZF6p+CcFg+VFjrRlNjQ=
X-Google-Smtp-Source: AMsMyM7Vcr0tuJWfOhZfN7a/ad1F7xPeLvbJof0EGrN8+0j3gw8x0EvYH0Ps+piXhgyxK+Gq99IVwQ==
X-Received: by 2002:a05:6a00:234d:b0:561:f0c3:cde1 with SMTP id j13-20020a056a00234d00b00561f0c3cde1mr60030312pfj.34.1667984826888;
        Wed, 09 Nov 2022 01:07:06 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.63])
        by smtp.gmail.com with ESMTPSA id mg7-20020a17090b370700b00212d4cbcbfdsm727509pjb.22.2022.11.09.01.07.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Nov 2022 01:07:06 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: [PATCH v3 2/5] notes.c: cleanup for "designated init" and "char ptr init"
Date:   Wed,  9 Nov 2022 17:06:53 +0800
Message-Id: <a53576ea880b00c9225f0d0855c7e357edda789c.1667980450.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.386.g196e80358e8
In-Reply-To: <cover.1667980450.git.dyroneteng@gmail.com>
References: <cover.1667980450.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Let's do some cleanup for the following two places in "append_edit()".

The first place is "char *logmsg;" need to be initialized with NULL.
The second place is "struct note_data d = { 0, 0, NULL, STRBUF_INIT };"
could be replaced with designated init format.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/notes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index f4bab3b2f2..485439c901 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -566,9 +566,9 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	struct notes_tree *t;
 	struct object_id object, new_note;
 	const struct object_id *note;
-	char *logmsg;
+	char *logmsg = NULL;
 	const char * const *usage;
-	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
+	struct note_data d = { .buf = STRBUF_INIT };
 	struct option options[] = {
 		OPT_CALLBACK_F('m', "message", &d, N_("message"),
 			N_("note contents as a string"), PARSE_OPT_NONEG,
-- 
2.38.1.386.g196e80358e8

