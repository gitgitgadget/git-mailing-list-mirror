Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C1FC433FE
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 10:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbhLIKeP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 05:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbhLIKeB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 05:34:01 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A2FC061D60
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 02:30:25 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so3689954wms.3
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 02:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=B2qNreqxPbVLHXZVbNIw1FNvHSOsXYeU20/GeFvd7zY=;
        b=bCK7/r1XwQKR72lDYzGsc22lfie21i6xbZt0aKfxLBianeNYQdQsoZp9SWm+jJwAcK
         kpb7JI3StoqU19A6VXI9AH/OzvRjF1YhS2t/obpilY2YPOWuU9oO5dtJSPbMBqwJaYrV
         ieTaOUiZ/0CkkrxeM5lHl0+1C3QbTQ2RDDXgrd1uT7ZgTKKiNb3Lu92+yGv6DmwGo6Dh
         FzBDNErBAbYG0Vr8YmPFxKfyhddQAsXHQOReEnDBe0Eb67iJG7tipLeTeQC0xXVWy9Pg
         Lt+b/C4NGDp4S5MT8f/Df0VjaQY5E7l3B9FFIjR/xIKidMXrO+qGm1WEyzlThYa0cBxX
         wi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=B2qNreqxPbVLHXZVbNIw1FNvHSOsXYeU20/GeFvd7zY=;
        b=EWfFqxDYOtdw9Q9SlzxtvIIuGE9JEXeK4NlVj/w0NOV4egUkUPKKHpeD6GtbU24D7b
         Bm5ttdHlKLMgyzHtsKzY4rndwPyZZl8iJOF638HDbcFAyl9nx2JLr2q9gK8EevXuHyKO
         lgoy6/4ZjgqWBI+fee08rphFUWRLyz+U4PdeWeBU4T3N6El7aig25a9YrY2Nfebj8AgB
         GFUvImhCh6lZsQ4gyuUTMKqvaupzFMmX2r8FkmkSM/rARO5upLASKbZFKY6rz6Lrc5P+
         v5Zyy5UUufVkhFLuXsKcDz7TYcjKMiTz7kIPN9rPin00+9Z5af5cY95W5lre/IIZAf+M
         UKXA==
X-Gm-Message-State: AOAM532AMGEfEXjSBWbkAKzzFsGINo35tgPj41s+nr/y06N0JxoFxUDm
        4lzQWTEvIMCDeW2X1qxtu3qSl2BgWBo=
X-Google-Smtp-Source: ABdhPJz7MexfkYiIMJMDX+gySDoyBBfenS62X6NEIzKYUGYztufpuojC2Q/z9kIx1AN4VoUrZ5VuUw==
X-Received: by 2002:a1c:4d13:: with SMTP id o19mr5911779wmh.164.1639045823520;
        Thu, 09 Dec 2021 02:30:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j11sm5439064wrt.3.2021.12.09.02.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 02:30:23 -0800 (PST)
Message-Id: <b88696596641eba8f2bd5c09869972874e642023.1639045810.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v5.git.1639045809.gitgitgadget@gmail.com>
References: <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
        <pull.981.v5.git.1639045809.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 10:30:08 +0000
Subject: [PATCH v5 14/15] diff: use designated initializers for
 emitted_diff_symbol
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This makes it clearer which fields are being explicitly initialized
and will simplify the next commit where we add a new field to the
struct.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 2085c063675..9ef88d7665a 100644
--- a/diff.c
+++ b/diff.c
@@ -1497,7 +1497,9 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 			     const char *line, int len, unsigned flags)
 {
-	struct emitted_diff_symbol e = {line, len, flags, 0, 0, s};
+	struct emitted_diff_symbol e = {
+		.line = line, .len = len, .flags = flags, .s = s
+	};
 
 	if (o->emitted_symbols)
 		append_emitted_diff_symbol(o, &e);
-- 
gitgitgadget

