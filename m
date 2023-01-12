Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429E7C54EBD
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 12:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjALMqX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 07:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjALMqL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 07:46:11 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4C549151
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:46:08 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id v6so1455741ejg.6
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqX3YFUgib2wTNx758+8vQUk4m3JkZZ9lN2zw6tyDNE=;
        b=OLIg0FaxLo6NJ+7OnubnCI4kTDWlZcufZW9b+bMitgy/Msyr2hgHHq5BBqhIubQeEf
         Sqn02xSfD8PxytTfpT86kkkNMZ/girG9sKEhRPNXrBO9FcgsESXg2ox5V5EZGBjJLWNh
         kPHIK43a0w2sVTjwZCId2CddQ/tKDtoJxFl/m5MxYZBpbnS/kCnGkh4erLHOXfB3V2YL
         uAt57u7ix4L9ikjdYmcD4QrSQu+8VMJfZYMEP9OCaFK+2Mg2jryCgYtwajAJf92zMlS4
         +ZSsrLKn0zovVWyv18t9D6OynGKtx1vkN9lNkax6V53ePTqAT2xK137EQZU3+d9dLuY9
         QdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqX3YFUgib2wTNx758+8vQUk4m3JkZZ9lN2zw6tyDNE=;
        b=EgMBLAFrF59IjJODcRXaRhExfSQ5QM4kcEbYBkT75eNRFxODumOmnN+OUHRiK1psKv
         7FoZ08wrM0eomH9FbJBiIGrai1KCP2QZ2CoUpk+RBfv/ZT28tDzMq8ormUucG/ebOr5Z
         pT8maKHa47GNOlGHqYAXJNCqWkLwMPApDw+S+OIwepwC2FIrSv4sD+M+t+Z77741Xabh
         2Yg3+tHBcyu296r+spnDDcztoGkJSaiLzW/v3fV1paVd/7GogWqJFeTfEzuaDmX3MA3i
         2p6HrtqnSI+wMuAVuzexKJp9zayalF4MiUtffjICAEbIADF35IcM3Aj4xJ17JFT7ve9q
         52Gg==
X-Gm-Message-State: AFqh2kpjIYST49GtOliw6rQJynhHxzgCE2vSAotn3qd7yikBSWT9KB82
        XLWxaqGxE0ey3bKAKTTo9fRnBrTRO1FP/A==
X-Google-Smtp-Source: AMrXdXsmTNx124MxwAtXCyjc1IsGr08Ihxp8x/XFCGRdY2dnn0vjK6KeE/Xo/ISzsJFLJt6ny/w+gw==
X-Received: by 2002:a17:907:b601:b0:838:9c66:cd30 with SMTP id vl1-20020a170907b60100b008389c66cd30mr68096604ejc.13.1673527566918;
        Thu, 12 Jan 2023 04:46:06 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v17-20020a170906293100b007be301a1d51sm7373523ejd.211.2023.01.12.04.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 04:46:06 -0800 (PST)
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
Subject: [PATCH v2 2/9] sequencer.c: split up sequencer_remove_state()
Date:   Thu, 12 Jan 2023 13:45:54 +0100
Message-Id: <patch-v2-2.9-c4eaa8dfef4-20230112T124201Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1205.g2ca064edc27
In-Reply-To: <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split off the free()-ing in sequencer_remove_state() into a utility
function, which will be adjusted and called independent of the other
code in sequencer_remove_state() in a subsequent commit.

The only functional change here is changing the "int" to a "size_t",
which is the correct type, as "xopts_nr" is a "size_t".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sequencer.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index bcb662e23be..d385bea2bed 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -351,10 +351,22 @@ static const char *gpg_sign_opt_quoted(struct replay_opts *opts)
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
 
 	if (is_rebase_i(opts) &&
 	    strbuf_read_file(&buf, rebase_path_refs_to_delete(), 0) > 0) {
@@ -373,14 +385,7 @@ int sequencer_remove_state(struct replay_opts *opts)
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
+	replay_opts_release(opts);
 
 	strbuf_reset(&buf);
 	strbuf_addstr(&buf, get_dir(opts));
-- 
2.39.0.1205.g2ca064edc27

