Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FD6C433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BA5864DC3
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbhBHT1o (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 14:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236185AbhBHT11 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 14:27:27 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C106C06178B
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 11:26:42 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id g15so10880950pgu.9
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 11:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hkVWdNQiQTnGfiwViD6nDYqlHF5k8u66zHfNdY58TMY=;
        b=A2+u8IUaitM70uY9W+u8eYczGw788tJsJE8n5n3rRTFL06OdRmMs2Vn/EoA3Hy5khi
         XGTrgKhgYKyndlUnOgXsq2lzdvulNYxrsfG2JQNzeTnLWknvWqlE+Uv4JIW+0IojIKlP
         OmbuWTOBhgG5QLsezg6bIcUxguvjKrUfAE2YkBLF4Ipkaw8ADynFoLR/MlVtMhCDyYtS
         W7zWG3Q3Cfv4V85RzsPatvkPWz3Q3GVGT8TOgQeSkGFrUHgtHR8NcEJFbGe8iAZb5yPk
         uLloxLOiHGN1UA4y9DbopVvv6U25BO28oMApcR/YSeuMuIlNf6RYLqbvXQgcCQLyoL4B
         g+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hkVWdNQiQTnGfiwViD6nDYqlHF5k8u66zHfNdY58TMY=;
        b=M+vfNbcKOj3m4oALfHZ285IJHsKJiS6b7GjIJQKJTAlQ6DMjgo6NgHcEdlvfVa0jmO
         9OSltRRdmMFQ0T15ulNFw0OEe3Os5jAclnCoEJhDoYdizjmlgxVZeRHVTvCckx11nGX7
         r5u8Al527f6/8su9KIpFftK4l/DS9+pD+OAoba3fZvb/DIpUY8RX4yydLd9BYbWdCbu9
         krjao4AxZGRtIncqG+kJoi6v4XKIlIrsBr1XfPIXQRnaGtkYCNFlc7NbO0ywlwpICIp1
         +2xdNjFv+Sa+2OldEO9za9ZGnfcRVYSl20+k1ajy059vbGA+6KV1XPWdi9GZad5DLpGc
         ZaKQ==
X-Gm-Message-State: AOAM531xfb+4xoJe1wYKBBl6OfjQtcH5y/BHhNDVnD59bxHzQ9AqCg2Y
        QeBec5Pko0NYQ151mYbaUMDMSDLVF3G6eg==
X-Google-Smtp-Source: ABdhPJwahooJoUw+cgyYsVA8LOKbBpCIFlzEi+yPyWcKO2EdTafMcQ7PnX5WlLgTwR1zKnFdr0Awbg==
X-Received: by 2002:a65:57cd:: with SMTP id q13mr10162508pgr.367.1612812401748;
        Mon, 08 Feb 2021 11:26:41 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2e07:af0b:91c3:5a1c:9f2d:b1e6])
        by smtp.googlemail.com with ESMTPSA id a141sm19765444pfa.189.2021.02.08.11.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 11:26:41 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 01/11] sequencer: fixup the datatype of the 'flag' argument
Date:   Tue,  9 Feb 2021 00:55:19 +0530
Message-Id: <20210208192528.21399-2-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210207181439.1178-1-charvi077@gmail.com>
References: <20210207181439.1178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As 'flag' is a combination of bits, so change its datatype from
'enum todo_item_flags' to 'unsigned'.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 sequencer.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index d09ce446b6..f3928cf45c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1744,8 +1744,7 @@ static const char skip_first_commit_msg_str[] = N_("The 1st commit message will
 static const char skip_nth_commit_msg_fmt[] = N_("The commit message #%d will be skipped:");
 static const char combined_commit_msg_fmt[] = N_("This is a combination of %d commits.");
 
-static int check_fixup_flag(enum todo_command command,
-			    enum todo_item_flags flag)
+static int check_fixup_flag(enum todo_command command, unsigned flag)
 {
 	return command == TODO_FIXUP && ((flag & TODO_REPLACE_FIXUP_MSG) ||
 					 (flag & TODO_EDIT_FIXUP_MSG));
@@ -1850,7 +1849,7 @@ static void update_squash_message_for_fixup(struct strbuf *msg)
 
 static int append_squash_message(struct strbuf *buf, const char *body,
 			 enum todo_command command, struct replay_opts *opts,
-			 enum todo_item_flags flag)
+			 unsigned flag)
 {
 	const char *fixup_msg;
 	size_t commented_len = 0, fixup_off;
@@ -1906,7 +1905,7 @@ static int update_squash_messages(struct repository *r,
 				  enum todo_command command,
 				  struct commit *commit,
 				  struct replay_opts *opts,
-				  enum todo_item_flags flag)
+				  unsigned flag)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int res = 0;
-- 
2.29.0.rc1

