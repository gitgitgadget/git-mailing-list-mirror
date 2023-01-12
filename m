Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428BDC54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 02:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbjALCs0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 21:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbjALCsX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 21:48:23 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934401263C
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 18:48:22 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id jn22so18796999plb.13
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 18:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tHRgc9OO4Y10hlN6Yxcn4gGkzb3nGWz5WzS/R7Quuk=;
        b=e/j86R7cPIBF3UKRZkBMN5+ZJzlBUPfFefOA2WgLf+8RSQLxcJYmW1sJci+6kzyxeY
         3IQJsisUxwt3yF/SX6xlMMs53oEKFU/RRILQg50Jy92hNdrfbqf+vBcqlDf7F1u0Vryc
         BVvn3WlmOngHU3Pz8iGMGz2tQQagS/AGJTSCL4kb/F8x92BxRQ6RhE9J2g+F9y4p91S4
         dAn97WCTri/uZdnZV2WxLhmC/SMdy77bU7D/OQqQsCG/IdzMCBUnu2wOINts2nbIY0pX
         GF4O55Zlo2rdsl8b7Kz2gmuH9A3zasajzlw8mLTLEtM1O9sIUHhNcV8ExnjZbwu892p7
         R6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3tHRgc9OO4Y10hlN6Yxcn4gGkzb3nGWz5WzS/R7Quuk=;
        b=TVwgXdk2t63IcVS8DSd9IpMjrsqXdH6AdyxCkMx7EvBFNsib+Fw8WkVveOygWfwzE7
         7NXZvfohKWJW8oC984sPAPvcMYMO66LCyDpK+2/IatwGF/iD63VTbuKwxDaG4qFi6hU6
         VSimPvufv4cbVZSAGFtx5GYQTRra6LANSzgBd3PBRYSs4mw04gz8g9w/brrfz5dvVGbV
         REeCo3HIj21c0/zyB6K64okQ5V+3Sq1Qh+v2PH+BlwG+jVUMsUb9IPiRstCyEPrPj10e
         s0wJ6GKpyG9JmVdPXVRwqygw1Lb/WrnQ+9nnerE6H71CAjdOAcMNlkLU0L53TDxmJ3ne
         Dl0g==
X-Gm-Message-State: AFqh2krZbqA0iCwahut0nm4vO7jlEhErAop4BTKkB5r17HjzADUP2Qqc
        p5P7w2MD5OJZcZyDyeaWtkQ=
X-Google-Smtp-Source: AMrXdXsGCKEVNsJsflmes5ZnAFDcna46ASzjL3eqa92ZYNVOPcy34oUdbQvICkXkXPxoHQ4Z4nMSUQ==
X-Received: by 2002:a17:902:e84d:b0:192:8824:e516 with SMTP id t13-20020a170902e84d00b001928824e516mr72176788plg.51.1673491702069;
        Wed, 11 Jan 2023 18:48:22 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.48])
        by smtp.gmail.com with ESMTPSA id u9-20020a170903124900b001926392adf9sm10855227plh.271.2023.01.11.18.48.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jan 2023 18:48:21 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, tenglong.tl@alibaba-inc.com,
        sunshine@sunshineco.com
Subject: [PATCH v4 2/5] notes.c: cleanup for "designated init" and "char ptr init"
Date:   Thu, 12 Jan 2023 10:48:06 +0800
Message-Id: <29f7703b06dfecd1daedb72a7027aa953addfa3a.1673490953.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.386.g6952793f2d9.dirty
In-Reply-To: <cover.1673490953.git.dyroneteng@gmail.com>
References: <cover.1673490953.git.dyroneteng@gmail.com>
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
index e57f024824..8ca55ec83e 100644
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
2.38.1.386.g6952793f2d9.dirty

