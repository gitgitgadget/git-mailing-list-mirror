Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698F6CA0ED4
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348845AbjIKVbT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241341AbjIKPG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 11:06:58 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B98CCCC
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 08:06:54 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9aa0495f9cfso594531366b.1
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 08:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694444812; x=1695049612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1Ud+/L+/v+I0dNo0shBn5ym0jwhmelDowjUlrSsyJk=;
        b=dgMedkn0FdjqMeLAcvHdDwMbYfUJmnnQOK+9Wc9F2OLQawar1qr0qAZra/isakSLat
         UAeufX1v+2DGgjZCtEK6QUoyPcHgP4ZAvXpOHgipnByUoG7mfu48F1AA43MmjCP/dAli
         Lfn3DTB+Jr0NmufEa70D/UUkZ/flEm0SPzwwvKAJvZ/oIxu3TWKT/xKEDpTejfl9/kLS
         pYGtXSL2JgpEUG3kDxIvm+xuUCL9851tAryw7QYKt5t67nNgZslxtgUgduOj+sUTkPnV
         5f9UhptZDr8w1RSlNJAKrKY2FmDuz/yzoVUmVa9RmdH0mrOAWPgOinq47Ikz+xJsfAck
         yi1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694444812; x=1695049612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1Ud+/L+/v+I0dNo0shBn5ym0jwhmelDowjUlrSsyJk=;
        b=eAsXSv4fVqO7KgrUnghFJ7nt1kK+paB8Eva3JDrr6CqFoWf9Rf++FXRhJWlO8776he
         loS0X6pM4j7mnUZxBNBBZzbBph8oI1DtkeQud6WgQpGouRW3qBHyVsmiM1gz1Hc4bCLF
         hJsoItMi13LaB1zAnOWjwe/wn5c5w7fgz5CIN6L75NTLPgg3tFa//zsZELBqvZBTNOGJ
         4Mv9mowzvZY1g2r/WA65FpQ9AjnlwM6cZsRMf2WkEfz4HB5hWMmEqo390R3/6Rk9gu8O
         dbXBIZpHyGAityaeNChN6ITQDXDMuf5K7/Fq/ZB6ug2WLV12NMn3MaAeecsQ7AFoosz7
         aw/g==
X-Gm-Message-State: AOJu0Yy/GVc/S+oV4nD4+IWZ16hxhbt21LCOkZ/gNHSxg9GcGT1CmKvR
        EEpKTZS7UkxB/d4PdQeN1GFsx9r9TXI=
X-Google-Smtp-Source: AGHT+IE7QQCf+8hRR83mRZpN0TyDJNLpBYhl0Upu5bfSTKmAVjvPhR9DLsvowlGVJFUdYwLwsqdyAA==
X-Received: by 2002:a17:907:8311:b0:9aa:1dc9:1474 with SMTP id mq17-20020a170907831100b009aa1dc91474mr5787761ejc.33.1694444812161;
        Mon, 11 Sep 2023 08:06:52 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:1085:31e2:f2be:e47a:b382:4542])
        by smtp.gmail.com with ESMTPSA id f5-20020a170906138500b0099cb1a2cab0sm5485617ejc.28.2023.09.11.08.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:06:51 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 4/9] repack: refactor finding pack prefix
Date:   Mon, 11 Sep 2023 17:06:13 +0200
Message-ID: <20230911150618.129737-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.167.gd6ff314189
In-Reply-To: <20230911150618.129737-1-christian.couder@gmail.com>
References: <20230812000011.1227371-1-christian.couder@gmail.com>
 <20230911150618.129737-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new find_pack_prefix() to refactor code that handles finding
the pack prefix from the packtmp and packdir global variables, as we are
going to need this feature again in following commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org
---
 builtin/repack.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 4f53b24958..8de3009b9f 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -781,6 +781,17 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 	return finish_pack_objects_cmd(&cmd, names, local);
 }
 
+static const char *find_pack_prefix(const char *packdir, const char *packtmp)
+{
+	const char *pack_prefix;
+	if (!skip_prefix(packtmp, packdir, &pack_prefix))
+		die(_("pack prefix %s does not begin with objdir %s"),
+		    packtmp, packdir);
+	if (*pack_prefix == '/')
+		pack_prefix++;
+	return pack_prefix;
+}
+
 int cmd_repack(int argc, const char **argv, const char *prefix)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -1028,12 +1039,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		printf_ln(_("Nothing new to pack."));
 
 	if (pack_everything & PACK_CRUFT) {
-		const char *pack_prefix;
-		if (!skip_prefix(packtmp, packdir, &pack_prefix))
-			die(_("pack prefix %s does not begin with objdir %s"),
-			    packtmp, packdir);
-		if (*pack_prefix == '/')
-			pack_prefix++;
+		const char *pack_prefix = find_pack_prefix(packdir, packtmp);
 
 		if (!cruft_po_args.window)
 			cruft_po_args.window = po_args.window;
-- 
2.42.0.167.gd6ff314189

