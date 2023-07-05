Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E97C001B3
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 06:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjGEGIw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 02:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjGEGIj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 02:08:39 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4589910F2
        for <git@vger.kernel.org>; Tue,  4 Jul 2023 23:08:38 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbc244d39dso84946935e9.3
        for <git@vger.kernel.org>; Tue, 04 Jul 2023 23:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688537316; x=1691129316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAi+xvrjzE7keEMAZobkXBGgLdIFZ0gxTr8MhGGeh+Y=;
        b=QEpWTApvs0OCr5SILydGcOANBRzPNrGYIBkjzznBhrf0xU9qocOX/QxSvNaOxSa0hr
         hC45ut4FDUN4gu1XvndvegrMDTtvvK1RziVsByRc20dL27zU4K8A3jDcdrYXd6ipYQUF
         FbiyJ7y0mFfMg+g5C8zwnfVp5If88MxVcW/di+vvtzhjo2TXs5oRDkc0MWQG62Urle/W
         IPCOoLvXRWi973uo/Q8BQeK7xLgnpukB+QYfsGRihtZFsmQm/+ChVAd7328Dw5xRmWmD
         es4DfmTa8pKOgZZnGNV70zKOFczCEmKSeIm0iCvH2TI1O8yfq74vWNBUHl0asDvcGTa2
         seDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688537316; x=1691129316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAi+xvrjzE7keEMAZobkXBGgLdIFZ0gxTr8MhGGeh+Y=;
        b=XB4n3qN9cgCFq/1K9+QP2GPAZet4VjsJ1/vFHVDkymU3pL4vMTp9uIV8EISDL7OS0b
         SEL4YZkVYU5VlCsh6mrLMTIS8V76n8xy+ODsLICUofXqQFCZUi+zMCYq0ycW4cbttFSK
         aAh2VlYTigQ4rqc9zpJbjAc+VciVci/NKS2LykSPV33TETnvA78h7LFgT/CyPGRNOzjw
         Q6LvqFrjdD85XZVFy5n7f5KRcHIPDbEe74ZRtmzPP0gbmfRrZ3h/RvHZdRkWgxDALMQN
         p8vI+mwQLvCjiOL5NymN9+XK8LxWV1a2vtrcgkUCSxfNB4Rs0HMnlHX2oabS7Ewc/aB7
         SLzQ==
X-Gm-Message-State: AC+VfDwm+iJms4pwqyIk2Oxt4V6qLZ+42DqkfoJGlkB9xY5xNseLelIN
        8JQuhL3SYjZ2SP5uaMHwiAsl7wfjFUo=
X-Google-Smtp-Source: ACHHUZ5iaFsSRAJk3rRUcivmr3CRxwAp+lfje99ZsGHDfuXkMqecdX1i8/0sLG3hNE+xTlipz47W8Q==
X-Received: by 2002:a05:600c:215:b0:3fb:b9b7:fb0c with SMTP id 21-20020a05600c021500b003fbb9b7fb0cmr19856272wmi.31.1688537316231;
        Tue, 04 Jul 2023 23:08:36 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:3f04:7ca0:f6a2:3135:7895:378b])
        by smtp.gmail.com with ESMTPSA id k15-20020a7bc40f000000b003fbaf9abf2fsm1087762wmi.23.2023.07.04.23.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 23:08:35 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 4/8] repack: refactor finding pack prefix
Date:   Wed,  5 Jul 2023 08:08:08 +0200
Message-ID: <20230705060812.2865188-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.244.g8cb3faa74c
In-Reply-To: <20230705060812.2865188-1-christian.couder@gmail.com>
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230705060812.2865188-1-christian.couder@gmail.com>
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
index 916ba7c6d0..4e5afee8d8 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -791,6 +791,17 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 	return finish_pack_objects_cmd(&cmd, names, local);
 }
 
+static const char *find_pack_prefix(void)
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
@@ -1039,12 +1050,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		printf_ln(_("Nothing new to pack."));
 
 	if (pack_everything & PACK_CRUFT) {
-		const char *pack_prefix;
-		if (!skip_prefix(packtmp, packdir, &pack_prefix))
-			die(_("pack prefix %s does not begin with objdir %s"),
-			    packtmp, packdir);
-		if (*pack_prefix == '/')
-			pack_prefix++;
+		const char *pack_prefix = find_pack_prefix();
 
 		if (!cruft_po_args.window)
 			cruft_po_args.window = po_args.window;
-- 
2.41.0.244.g8cb3faa74c

