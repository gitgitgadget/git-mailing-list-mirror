Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3660BC19F2B
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 08:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbiG2IbU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 04:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbiG2IbR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 04:31:17 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F2B3AE48
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:31:16 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r83-20020a1c4456000000b003a3a22178beso269900wma.3
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=PKYTQzib+FsJ+Zz8HknNYTvCp/jsCeeVTLtEh90ByfU=;
        b=aRVo2NcS94m9ghetH885Oqc5KJt2tM2/wIm2wIwZbRRRYZKMRkOHYUroLv3OQOUCRW
         E2vnr8KSF1libj54fVaS1OqPq3DdPCiJ1IAc/BU8W5KdkR3J4gyMNtop6jWhECTaW7uu
         cA29FdSbscRxePIRhVKr4KDsyJwxhHd4ZVL5V4ryGv365OGlqKDIS/6lqQnEsGMsRY70
         Pdk0RvBWmhNr+Fs8xnU1gV5vMM9SbbZ4ySVuxBKjjow35HpUkwDtmnBg+bTbri9BgSQv
         6wg4jorVWcb6mby7GmxUlrYzONPDqmfsJrT3TZUxKsnFLTvzQziGmKYuMuZaAePDNe2U
         SxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=PKYTQzib+FsJ+Zz8HknNYTvCp/jsCeeVTLtEh90ByfU=;
        b=CcDC1zs8DD+89GdY6VmwoPuMUPjsKAqfdbx4AVgIZyC4zsWbpVkdj8gJ6LcmrcSedf
         +huvZ3a7otAi/QNXAIOVy/rT8Ip9nuANZY2dPrp9l/++TOqI2HVewhcbdJIZUVAwrSgu
         FZ6JHj4YPXJOFLuAmUZD5BBH4LxY1UVGx3KKluDQKu7G9/QOMAv15Gl1V+XWr3amKJJn
         8/AKMwsS+2hkD/7npHDovXFL9HBroVjpCLJHYbBLxsIDXB+wb+CuPwEPoIMjl+j1V713
         X0ak9ETYCTjBJj28H+b0l0nX2FVPuMgWdr1/cr4Pm2Fk3ocxmZAErYNSqPKlKPdnadG1
         okew==
X-Gm-Message-State: AJIora+IejPAoFcwGpaWHXewN+GPcIxVLR8tqiDOVCP7RtCCbUvgJYaQ
        8hc0ZL9xOKvj9S2EXFwHu5zhpnMpCVcgfw==
X-Google-Smtp-Source: AGRyM1s5XiQa8+hc6prIuS7NoT3ytwBohuqmSJiQzMnH/G3ZMClaoGfUNJ+5+vrttT94jrNGljMqaA==
X-Received: by 2002:a05:600c:4e54:b0:3a3:3197:9491 with SMTP id e20-20020a05600c4e5400b003a331979491mr1585539wmq.58.1659083474998;
        Fri, 29 Jul 2022 01:31:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f13-20020adfe90d000000b0021f0c0c62d1sm2325467wrm.13.2022.07.29.01.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 01:31:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/6] log: make the intent of cmd_show()'s "rev.pending" juggling clearer
Date:   Fri, 29 Jul 2022 10:31:05 +0200
Message-Id: <patch-v2-3.6-1629299f883-20220729T082919Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1196.g8af3636bc64
In-Reply-To: <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust code added in 5d7eeee2ac6 (git-show: grok blobs, trees and
tags, too, 2006-12-14) to use the "memcpy a &blank" idiom introduced
in 5726a6b4012 (*.c *_init(): define in terms of corresponding *_INIT
macro, 2021-07-01).

Now the types in play are guaranteed to correspond, i.e. we used "int"
here for the "count" before, but the corresponding "nr" is an
"unsigned int". By using a "blank" object we almost entirely bypass
that, we'll only need to declare our own "unsigned int i".

There are no functional changes here aside from potential overflow
guard rails, the structure only has these three members ("nr", "alloc"
and "objects"), but now we're obviously future-proof against assuming
that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/log.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 88a5e98875a..6135f8191a9 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -668,10 +668,12 @@ static void show_setup_revisions_tweak(struct rev_info *rev,
 int cmd_show(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
-	struct object_array_entry *objects;
+	struct object_array blank = OBJECT_ARRAY_INIT;
+	struct object_array pending = OBJECT_ARRAY_INIT;
+	unsigned int i;
 	struct setup_revision_opt opt;
 	struct pathspec match_all;
-	int i, count, ret = 0;
+	int ret = 0;
 
 	init_log_defaults();
 	git_config(git_log_config, NULL);
@@ -698,12 +700,11 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	if (!rev.no_walk)
 		return cmd_log_deinit(cmd_log_walk(&rev), &rev);
 
-	count = rev.pending.nr;
-	objects = rev.pending.objects;
+	memcpy(&pending, &rev.pending, sizeof(rev.pending));
 	rev.diffopt.no_free = 1;
-	for (i = 0; i < count && !ret; i++) {
-		struct object *o = objects[i].item;
-		const char *name = objects[i].name;
+	for (i = 0; i < pending.nr && !ret; i++) {
+		struct object *o = pending.objects[i].item;
+		const char *name = pending.objects[i].name;
 		switch (o->type) {
 		case OBJ_BLOB:
 			ret = show_blob_object(&o->oid, &rev, name);
@@ -726,7 +727,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 			if (!o)
 				ret = error(_("could not read object %s"),
 					    oid_to_hex(oid));
-			objects[i].item = o;
+			pending.objects[i].item = o;
 			i--;
 			break;
 		}
@@ -743,8 +744,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 			rev.shown_one = 1;
 			break;
 		case OBJ_COMMIT:
-			rev.pending.nr = rev.pending.alloc = 0;
-			rev.pending.objects = NULL;
+			memcpy(&rev.pending, &blank, sizeof(rev.pending));
 			add_object_array(o, name, &rev.pending);
 			ret = cmd_log_walk_no_free(&rev);
 			break;
-- 
2.37.1.1196.g8af3636bc64

