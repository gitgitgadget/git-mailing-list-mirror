Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A438BC56202
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 23:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56B7620809
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 23:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tiDWf3zh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732471AbgKJXm1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 18:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732451AbgKJXm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 18:42:26 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB98C0613D6
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 15:42:24 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id s13so125509wmh.4
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 15:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=li8clFkTL0WoFiio26Z5SCHvNIyzRnyAytG439CeyhM=;
        b=tiDWf3zhKNw1s9hkgk2oB04VSQZi7gAG116OKH5/Si1aYmV09BthYSNen6Wz0OxiVy
         zxfF4/B/yK/sPUiN2vuyEOhgNFVUx54T3F/Qi4BIwh1kKmvcQAHv8pzFjVIMJM+ZuN3S
         OKfxrXL0fAVU7DXRFohvvZFoiyrMC9rn7VhQ/gSfIxBqI/XeR3RqrIc6f1BJvmVaKZ1F
         sBMrXuOdLIeNf27+EhNIsZyYJR9nX0lLyqbCrQEXqCJ5XoapfuOrfkwXY2aXMqFeGn9x
         tMmaV/Z5h+/uew2+HyOnsCO4axcWpp5mwEnbLCgZJI+pu6PlaQgcG5JCbM/hKhglL6JH
         DjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=li8clFkTL0WoFiio26Z5SCHvNIyzRnyAytG439CeyhM=;
        b=GHmW5n9HPWs+oZFvlYmSJcF0Qxrj/65Q+gsUBT5J1hhs+2kgryH5ZGxCfwOpVwTv4z
         cvawlWNVdByuUfaYOiUTUSy9EYAarYpP5ocXu9YgpZ4gjmlw///CFc/0xjVIJjhKB28u
         AbR5vFx64UQOyiAfOJfrKv8t4IMFVL8jo/ikGRQ2u04xKfX7ZyzPMD7MkyHEvT2QNQd+
         jMeYyfDkHoSMcDZc9NOiGl66IVdCHYId7y/FbovVHJVcofu2dzQXivLoS29D3Vo1xbkL
         zqKVX8OEnf1Cf+CE8ArPIPnul4VkacPKY81jS72nlyzYbzl7M9kcTy8+RxMQyzuj+VNg
         b/yA==
X-Gm-Message-State: AOAM5305CzTK1TPtUB/Z6wXBQGKQ+19+P/y2M8cSf7kAXC2jMHQRrMVF
        0l7LVmjweVQrChYbtuFCCWUPFTM5e74=
X-Google-Smtp-Source: ABdhPJwv9diUEjsLb/gSS4Y89IzpYjl/2fXkd7CqE+ojrSaeR/N0EEcM7GvFruc5Os1zTUYi1CBvUw==
X-Received: by 2002:a1c:5605:: with SMTP id k5mr519118wmb.99.1605051742934;
        Tue, 10 Nov 2020 15:42:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q7sm274287wrg.95.2020.11.10.15.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 15:42:22 -0800 (PST)
Message-Id: <9a1ba71977e9dda4c2656dc2847106dd8b79a433.1605051739.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.git.1605051739.gitgitgadget@gmail.com>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Nov 2020 23:42:13 +0000
Subject: [PATCH 3/9] add -i: use `reset_color` consistently
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We already maintain a list of colors in the `add_i_state`, therefore we
should use them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index be4cf6e9e5..33a24f58fe 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -667,7 +667,7 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 		if (len)
 			strbuf_add(out, p, len);
 		else if (colored)
-			strbuf_addf(out, "%s\n", GIT_COLOR_RESET);
+			strbuf_addf(out, "%s\n", s->s.reset_color);
 		else
 			strbuf_addch(out, '\n');
 	}
@@ -1060,7 +1060,7 @@ static void recolor_hunk(struct add_p_state *s, struct hunk *hunk)
 			      s->s.file_new_color :
 			      s->s.context_color);
 		strbuf_add(&s->colored, plain + current, eol - current);
-		strbuf_addstr(&s->colored, GIT_COLOR_RESET);
+		strbuf_addstr(&s->colored, s->s.reset_color);
 		if (next > eol)
 			strbuf_add(&s->colored, plain + eol, next - eol);
 		current = next;
-- 
gitgitgadget

