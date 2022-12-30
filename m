Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AE7C46467
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 07:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbiL3H2a (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 02:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbiL3H2X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 02:28:23 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0196E18B3B
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 23:28:22 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id fm16-20020a05600c0c1000b003d96fb976efso12625127wmb.3
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 23:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmusm75l7evrt7DWCX0ymYdvUs8/pyoIVbNR9v/f9P0=;
        b=Ruv3IriwGMicMatWnqR6YD0sSWXmJN8bOgjLl60mJxJToIsoHT0Rv/2sTfSqvsqDx1
         uOVCeJS159zb1hWBgIWJBwp86Gh+pFD+j59SwlZvosKPAec480SW/sAa3fNV8Hy1K0of
         ZPyim62QBhS1dQWkOFHqN6nIiMgXGaIeZzQG8uSCp19yHHFS6Xgs4z0TKlVSMiH38Kin
         259f0Id7p1BAI8/f4kYZHdVKZZE1TYT3utdwssWkG0WqfQPDw26W9lLGxjAsyrLKZN5U
         miy2zLIrpKtQBJR4PjPXwKRveMt52HmWGLipZxtTP7VV2G8B5z3iOS86u+mDY36qETsg
         63CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmusm75l7evrt7DWCX0ymYdvUs8/pyoIVbNR9v/f9P0=;
        b=VYGIlIK1sJ8f8EvCAI/NnizmD3OxJoC527UJTcPnIae4hVUwffL2k7E9oq8l2S07CG
         VYxGQsuArFgv307rgL91MfbdR6ksdbZPvzxf/l+WdxHwCFFsmZpLJlSGDvbvq4WrETwi
         lsOb092nnkMRE1gnllWbvd4nt+8lTY4V+5j5QqjQ6RvgdmfpnJChh9n1zVzNNSKwmvlS
         kBOaPiD/JrhARza8fEznZI8b8ww5nQWcdf6j7Zx1nYNkrjXZp5k9WC22ShkDc5N3omS6
         7bgEz8K71BCby9zupgz3vJyaakkqn6j1piydevLHN/cLeUXEghxD9APbz/zh99CMdU08
         MxPQ==
X-Gm-Message-State: AFqh2ko5AmKFOG2Tu8lB/tMY8Viz1PPVc0mzDXcIQpcx72gmjmmPzH+h
        ow8NZitzCi+ZGCYYyXCt1H2I4NHcfZP61w==
X-Google-Smtp-Source: AMrXdXsOoNmlnAtke/xi1T0oFGqte3ACrOwbTZAMbMQYzEOTiti/sUb4yr0zICZ/tnDJbRGs6r3UsA==
X-Received: by 2002:a05:600c:4920:b0:3cf:7514:a82e with SMTP id f32-20020a05600c492000b003cf7514a82emr22301854wmp.23.1672385300099;
        Thu, 29 Dec 2022 23:28:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b003d998412db6sm6526449wmn.28.2022.12.29.23.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 23:28:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/10] sequencer.c: split up sequencer_remove_state()
Date:   Fri, 30 Dec 2022 08:28:07 +0100
Message-Id: <patch-02.10-4994940a0a9-20221230T071741Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split off the free()-ing in sequencer_remove_state() into a utility
function, which will be adjusted and called independent of the other
code in sequencer_remove_state() in a subsequent commit.

The only functional changes here are:

 * Changing the "int" to a "size_t", which is the correct type, as
   "xopts_nr" is a "size_t".

 * Calling the free() before the "if (is_rebase_i(opts) && ...)",
   which is OK, and makes a subsequent change smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sequencer.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index bcb662e23be..655ae9f1a72 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -351,10 +351,24 @@ static const char *gpg_sign_opt_quoted(struct replay_opts *opts)
 	return buf.buf;
 }
 
+static void replay_opts_release(struct replay_opts *opts)
+{
+	free(opts->gpg_sign);
+	free(opts->reflog_action);
+	free(opts->default_strategy);
+	free(opts->strategy);
+	for (size_t i = 0; i < opts->xopts_nr; i++)
+		free(opts->xopts[i]);
+	free(opts->xopts);
+	strbuf_release(&opts->current_fixups);
+}
+
 int sequencer_remove_state(struct replay_opts *opts)
 {
 	struct strbuf buf = STRBUF_INIT;
-	int i, ret = 0;
+	int ret = 0;
+
+	replay_opts_release(opts);
 
 	if (is_rebase_i(opts) &&
 	    strbuf_read_file(&buf, rebase_path_refs_to_delete(), 0) > 0) {
@@ -373,15 +387,6 @@ int sequencer_remove_state(struct replay_opts *opts)
 		}
 	}
 
-	free(opts->gpg_sign);
-	free(opts->reflog_action);
-	free(opts->default_strategy);
-	free(opts->strategy);
-	for (i = 0; i < opts->xopts_nr; i++)
-		free(opts->xopts[i]);
-	free(opts->xopts);
-	strbuf_release(&opts->current_fixups);
-
 	strbuf_reset(&buf);
 	strbuf_addstr(&buf, get_dir(opts));
 	if (remove_dir_recursively(&buf, 0))
-- 
2.39.0.1153.g589e4efe9dc

