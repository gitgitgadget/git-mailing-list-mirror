Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7C2C4167B
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 18:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbiL1SBF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 13:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbiL1SAu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 13:00:50 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FB117E0B
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:36 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h16so15507047wrz.12
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3QeGqHa71pgnG1kSKNIxgX5r/JJaCU+EVs4SGQYKTs=;
        b=g3XSJPqOQHxk4kw1kV1qfNJ/G/NHuWwCwKhBciSsSCI/onwWgYWzRC98xf4x/naWUB
         vebSdcK4Iz6nYifMwH3Jrf9dr4VBzremcvHcQLVES3gk+8yMWiJUwwo83q45cVOsNmaA
         J3rUp1F/a6Y1XwpRrvZ8r2jQG/pAjGZN03O/hd6tr1vGql5iJwW0n0Wyu274ZxXbFU9Q
         v8aqPqBPkzYep4tN8n0SUlGNiqe56qSGzwgOXtgnlY6theceYXx/pJv1yS3D/o9O1q63
         fA5rqtgG4KuVKvscsqcjQvFfsD2pDAYFIy8d6rKbfUvdPLoDX4svkhFGMmWoeXLmA4HQ
         UNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3QeGqHa71pgnG1kSKNIxgX5r/JJaCU+EVs4SGQYKTs=;
        b=tttYrrcDjMe5CaoGN2z3XkLOqgFVNS/sU+VvEqnjfq3/fupBpetmfFhKZM7fS6X7cX
         GhUWD4LrCNKI7HI1Z/rec3xWgreADI3rhMBWPXCqUmzNEDEN/TUqLz8eDPEPom07owRg
         yHNkSPCVHhDGRHSezgDnbhdC2wOu1J5exkm9U2+sv+XnIucEZ2zRJIoAfayVjjncHGSA
         HvOe1S8/qnFlmMZ0bMWdorMaj7snjWimD2eAkqYYmeuKgKEVjBhothCknJ536zcu0JrI
         RRU6z/yCCEpLJISVCpBVCT1bI15Usis/iRRYoZKh1DTH00WAwhcpY2Z4KCtDiuoa/iJv
         fWMg==
X-Gm-Message-State: AFqh2koE8L6AMbRWXtf+JSDuXb/LOaG4Vb6ZFNtTVwGbrYqoFRl9Nw73
        gv2YD83+NyjDpYCz5MUmAjZsQbDuD6XOdw==
X-Google-Smtp-Source: AMrXdXttj8WAWzVf9ougs65TUuuaIoNVDm3AdxwJO0KjfBtaHCu7kyilyq05iv8+2febduGRjNNJLQ==
X-Received: by 2002:a5d:6888:0:b0:27e:315e:d282 with SMTP id h8-20020a5d6888000000b0027e315ed282mr5891393wru.49.1672250434962;
        Wed, 28 Dec 2022 10:00:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4148000000b002428c4fb16asm16022480wrq.10.2022.12.28.10.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 10:00:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/20] name-rev: don't xstrdup() an already dup'd string
Date:   Wed, 28 Dec 2022 19:00:09 +0100
Message-Id: <patch-09.20-77fcdeb9284-20221228T175512Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.gb0033028ca9
In-Reply-To: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "add_to_tip_table()" is called with a non-zero
"shorten_unambiguous" we always return an xstrdup()'d string, which
we'd then xstrdup() again, leaking memory. See [1] and [2] for how
this leak came about.

1. 98c5c4ad015 (name-rev: allow to specify a subpath for --refs
   option, 2013-06-18)
2. b23e0b9353e (name-rev: allow converting the exact object name at
   the tip of a ref, 2013-07-07)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/name-rev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 15535e914a6..24f4438eb01 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -313,7 +313,8 @@ static void add_to_tip_table(const struct object_id *oid, const char *refname,
 
 	ALLOC_GROW(tip_table.table, tip_table.nr + 1, tip_table.alloc);
 	oidcpy(&tip_table.table[tip_table.nr].oid, oid);
-	tip_table.table[tip_table.nr].refname = xstrdup(refname);
+	tip_table.table[tip_table.nr].refname = shorten_unambiguous ? refname :
+		xstrdup(refname);
 	tip_table.table[tip_table.nr].commit = commit;
 	tip_table.table[tip_table.nr].taggerdate = taggerdate;
 	tip_table.table[tip_table.nr].from_tag = from_tag;
-- 
2.39.0.1153.gb0033028ca9

