Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03697C38147
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 16:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjARQOO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 11:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjARQNf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 11:13:35 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30361303CD
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:09:29 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id hw16so72571558ejc.10
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYvVtEoD6GitywXnzu9tpBWlTpwNmt44MW+zTf4CMYU=;
        b=fFq6SO9rBHbxpqUnSsXjvLU0jNoxRvU9GQuyo922uDey/JM7hEjKEHwJk6KTQRNvef
         t/X/+vgrngw90CNYGnajAcctX+CdFthYdW16FfJBM0DeOaYL+HN2Tsal5wupCEbAzEeB
         F6YvnGPx/QBeR6ejY5i7cFR9hTZzTqf0cE/uye3Kv4Z8NoobH1lm5ZYJbF/SyA8Ey3YV
         3/Seyyidcow9CXqpCcl5G+Eq4sdKW344VPeXj7m/r9QhFJmYgZC+QesGWXJcYBpR8sfu
         U3rIgGHzk0mf8WH/qzT1MIO580nWQl6LkCm2F79YaYa5Ko3Nm14Rwme166L9VNZfySqQ
         atuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYvVtEoD6GitywXnzu9tpBWlTpwNmt44MW+zTf4CMYU=;
        b=Keb/DX537PFuI8HhHKlBHseBkwa6SOiE//9BU+hv7u0xgUI22l4aN2h4s2md8sndTV
         AWHHR+zfIVCDdwDftKpq9o77dLJO1/tlzIrzly6aeIpFGDLjIFfoN3siF18gq5nPnraU
         WQ2eMGEL/sMJOvvZgneXxtsex+qrlsF8sD9A5PIXzVmutsofHbCFv2KNK2q/bok1JEKS
         aloopib3ayDtR9d0AaSa8Xm4/s7TzXkOPzM7dlo8Smn7cCH2z9n2jLhPb738Os+BGP/8
         4BYgOhcLaEqZq8Je8k4fdHYSmxnXd2Ajl4xxQqW0pQQfG1OIo97IuppoGXvgEnq/gsor
         XcUA==
X-Gm-Message-State: AFqh2kpuokoNxKHophirGGLUpK0k79nFrU9QAspgQziZ8m43Nmdxg5r7
        O5yUz22n1fst3grEZz70GXqD5oj04ietzA==
X-Google-Smtp-Source: AMrXdXtjK6L3euyD/qK5QWmaBYZ24Z9YhRISOnP8k1aaqMJFEdNJ+R+ehkwBJRd30Emh8uWiifNZAQ==
X-Received: by 2002:a17:906:762a:b0:7c0:be5d:59a9 with SMTP id c10-20020a170906762a00b007c0be5d59a9mr20295410ejn.20.1674058167455;
        Wed, 18 Jan 2023 08:09:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id du1-20020a17090772c100b0084bfd56fb3bsm14778202ejc.162.2023.01.18.08.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:09:26 -0800 (PST)
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
Subject: [PATCH v3 2/8] sequencer.c: split up sequencer_remove_state()
Date:   Wed, 18 Jan 2023 17:09:10 +0100
Message-Id: <patch-v3-2.8-00c7f04363f-20230118T160600Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v3-0.8-00000000000-20230118T160600Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com> <cover-v3-0.8-00000000000-20230118T160600Z-avarab@gmail.com>
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
2.39.0.1225.g30a3d88132d

