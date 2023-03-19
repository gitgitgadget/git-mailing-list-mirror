Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D7BC7618A
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 16:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjCSQ46 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 12:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjCSQ44 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 12:56:56 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9008F13DF9
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 09:56:55 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l27so31490wrb.2
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 09:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679245014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=No6TLoVg452zeHFVlMrxvhXKPmc3MA7PglWzwOYuohI=;
        b=aY+TbWIYAV2DoIFZAj1sgQYaeUvfZJ2oPXMZGAK166TwYKV9Es5mg2ZxqfOEQMCiP6
         8QeQt1BDoY90X2hcvHuMEKyuSdMwWLznVkMWSPn5K2Se8HaDtYJ+7AERQFeGQTDr/Etu
         HQ6OMbyaeGwz580ULVH9FNZ5dzbu5+uIslBwNsHdb0zBzlIe3lwmrJLYJ2PDeG+lDXkf
         CHdvrdpz/vMd/55Nnjc69vTJW1IK5dOGBXVY/ZXdta7zs+09JREV9tiP8ner/7k6S17Y
         Xap/xwOacHrtwsPKMJp86jTzpAb3fr2MrKwHuqX14UIpR4yKeuCITJiYxGhbpLJznzl/
         Mtdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679245014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=No6TLoVg452zeHFVlMrxvhXKPmc3MA7PglWzwOYuohI=;
        b=U6yOxyn2OSr3T597QfMeKXtxA0Ubgnpwn3LFLqPr6QeEbiqesBrA4j2nZ/Ee/mUy0H
         CXktqpWeHgHuvxr22tDDAxOE+t70AVdRDxAg7qmcA/VmPZNIW2nOfthOSekUdwP+5NJE
         FK7Thl1k+eGA544X3vg2gtTB1dlleSpiRzTvG2myWf915jmFksstMZXqexkUBRhUGP8m
         BOIchm84Q8JI3EwEk8NEsR/fxchmS+kEZQfDuYe8ROJ7NJAxPGYx5swYlZcmJ+Vuy7Ql
         Yf8CR90ATJXxO1G3/GkiCXDFxwMU2bdb2oSZS7YU0E/uRymdfIjS1m5a2abSnpQdz3Tf
         nOsg==
X-Gm-Message-State: AO0yUKUYVq0vzPmySb8jUrekNM03fqlFcn+s+OCeOrb+E03FEyPp9N8g
        9n0txb0ilv8g0WOH4CsVQIgB1pgKKy8=
X-Google-Smtp-Source: AK7set8AJq3Wfv7amPiE8CRrdzPWdSP6aL07i3sPH5TvzqAwpbCdpbZdVmzQNwl/miUIFwpEa7Xg1Q==
X-Received: by 2002:adf:e806:0:b0:2ce:ae54:1592 with SMTP id o6-20020adfe806000000b002ceae541592mr12032692wrm.38.1679245014099;
        Sun, 19 Mar 2023 09:56:54 -0700 (PDT)
Received: from localhost (62-165-236-170.pool.digikabel.hu. [62.165.236.170])
        by smtp.gmail.com with ESMTPSA id v7-20020a5d4b07000000b002c56af32e8csm6878395wrq.35.2023.03.19.09.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 09:56:53 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/3] parse-options.h: use consistent name for the callback parameters
Date:   Sun, 19 Mar 2023 17:56:46 +0100
Message-Id: <20230319165648.656738-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.40.0.499.g88fa0b00d2
In-Reply-To: <20230319165648.656738-1-szeder.dev@gmail.com>
References: <20230319165648.656738-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the various OPT_* macros the 'f' parameter is usually used to
specify flags, while the 'cb' parameter is used to specify a callback
function.  OPT_CALLBACK and OPT_NUMBER_CALLBACKS, however, are
inconsistent with the rest, as they use 'f' to specify their callback
function.

Rename their callback macro parameters to 'cb' to avoid the
inconsistency.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 parse-options.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/parse-options.h b/parse-options.h
index 50d852f299..34f8caf369 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -199,10 +199,10 @@ struct option {
 #define OPT_EXPIRY_DATE(s, l, v, h) \
 	{ OPTION_CALLBACK, (s), (l), (v), N_("expiry-date"),(h), 0,	\
 	  parse_opt_expiry_date_cb }
-#define OPT_CALLBACK(s, l, v, a, h, f) OPT_CALLBACK_F(s, l, v, a, h, 0, f)
-#define OPT_NUMBER_CALLBACK(v, h, f) \
+#define OPT_CALLBACK(s, l, v, a, h, cb) OPT_CALLBACK_F(s, l, v, a, h, 0, cb)
+#define OPT_NUMBER_CALLBACK(v, h, cb) \
 	{ OPTION_NUMBER, 0, NULL, (v), NULL, (h), \
-	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, (f) }
+	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, (cb) }
 #define OPT_FILENAME(s, l, v, h)    { OPTION_FILENAME, (s), (l), (v), \
 				       N_("file"), (h) }
 #define OPT_COLOR_FLAG(s, l, v, h) \
-- 
2.40.0.499.g88fa0b00d2

