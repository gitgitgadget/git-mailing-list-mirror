Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8D0C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 16:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EA0F64DF0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 16:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhBPQd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 11:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhBPQdz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 11:33:55 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65355C0613D6
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 08:33:15 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id lu16so2694812ejb.9
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 08:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rM8LR8zg+78MivVLCW8ZcYM9H+sKwcLX6b5+20LMdR8=;
        b=EeukXIm19Eqe0wEX5K3mW6OnTn86kkrGQOCdpj3pmXsSlp30HlfuIhd/3xjVwsh/3J
         rIgZu1I4Fy+BF3JhXJm/9FD1XOSKNrzkRShuceqvhfYRJrxoEY0S+W3isZoz9prQSF4t
         HrdDPdW1RYSolAi2tL461xIX9glnzU8I6zoyph07hJaRhzGJEOSQKdssthlPexf9fGsY
         GWCVEzT4qSzAj9K8oZhxexSZSLKiq9J2MyBUYcuqfAy3graXcW3B2auHIPBMaSNjgVaa
         m1WVqSrrEnHZaWk0xPTi+86wPx6ZoGC17e/ocg6dPDcn+kunquO6CwXSvgcJrGIXQvzk
         7OiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rM8LR8zg+78MivVLCW8ZcYM9H+sKwcLX6b5+20LMdR8=;
        b=r6ED26l6B+khm9WpmVEt4PWlASnxAbogopd6GLMYh0pf9T+H+BRC60h6vsCSOQmEhZ
         eTsIIrDscNXMwwV5KnAMu1zS4QChxzxHEpVisLsGBWfR83goOsE0Sqzmx7csCI2TPuIv
         yq7fc3ja8EEReOaGp9oJIPtYgX3jfGQxl7bVaX6LN4GgkhBsFD2NgQpXxm/pbJsayGeH
         dH8n14VLpTfDZTvDKaUO+IAv2LN3bWJaqG3KT9ftlb7LT4m8oRb14v8ABw3Md7tq3PDC
         Nyb2aIT3oSoGOG9mlEw6YXRROV7WMqbKobiAM9KbLSLpQFZ5Ng4/tDv5CiXz9f6lAVMc
         uFpA==
X-Gm-Message-State: AOAM5311EekVlnJG4g3tcqfF6MnKmynJTF/MbIabkhqnbm9ExGQq0ppL
        1IS0pTZlSa8dUNoIpakgHGGSmFHlojzgGd0Q
X-Google-Smtp-Source: ABdhPJxS1ba8Ud6/Vu5cd2cBCmQUV024JhsnHCXmLoyWSkbbjNhiPOohr9ZXVmYEy9pc1wMfdD3omw==
X-Received: by 2002:a17:906:a448:: with SMTP id cb8mr20892617ejb.174.1613493193890;
        Tue, 16 Feb 2021 08:33:13 -0800 (PST)
Received: from localhost.localdomain ([79.140.115.26])
        by smtp.gmail.com with ESMTPSA id u3sm13708850eje.63.2021.02.16.08.33.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2021 08:33:13 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH 1/1] blame: remove unnecessary use of get_commit_info()
Date:   Tue, 16 Feb 2021 17:31:51 +0100
Message-Id: <20210216163151.76307-2-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.1.850.g2d41e9e789
In-Reply-To: <20210216163151.76307-1-rafaeloliveira.cs@gmail.com>
References: <20210216163151.76307-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When `git blame --color-by-age`, the determine_line_heat() is called to
select how to color the output based on the commit author's date.  It
uses the get_commit_info() to parse the information into a `commit_info`
structure, however, this is actually unnecessary because the
determine_line_heat() caller also does the same.

Instead, let's change determine_line_heat() to take a `commit_info`
structure and remove the internal call to get_commit_info() thus
cleaning up and micro-optimizing the code path.

Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
---
 builtin/blame.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index b66e938022..641523ff9a 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -425,13 +425,11 @@ static void setup_default_color_by_age(void)
 	parse_color_fields("blue,12 month ago,white,1 month ago,red");
 }
 
-static void determine_line_heat(struct blame_entry *ent, const char **dest_color)
+static void determine_line_heat(struct commit_info *ci, const char **dest_color)
 {
 	int i = 0;
-	struct commit_info ci;
-	get_commit_info(ent->suspect->commit, &ci, 1);
 
-	while (i < colorfield_nr && ci.author_time > colorfield[i].hop)
+	while (i < colorfield_nr && ci->author_time > colorfield[i].hop)
 		i++;
 
 	*dest_color = colorfield[i].col;
@@ -453,7 +451,7 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 	cp = blame_nth_line(sb, ent->lno);
 
 	if (opt & OUTPUT_SHOW_AGE_WITH_COLOR) {
-		determine_line_heat(ent, &default_color);
+		determine_line_heat(&ci, &default_color);
 		color = default_color;
 		reset = GIT_COLOR_RESET;
 	}
-- 
2.30.1.842.gf6373b1729

