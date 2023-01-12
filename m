Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667F3C61DB3
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 12:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjALMq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 07:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjALMqO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 07:46:14 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC92C25F
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:46:10 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id v30so26655846edb.9
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tr+OH0VWd18MYHbL1P+tb7xUYMoJNRdzSn+T+0AHhQ0=;
        b=PLhzrppKtQrjkh2H6qjdPy0pWiUJjCs+oiWgKco4MDLLEAehTtzeUrMhAwfnGjSs9h
         RDWh2Bhx14gpZ37bAJRlbyoRj4DKUByKiuJMYBDITFiN3dCBjyvcuiDWmZxeRcLlUrXD
         xSzJmURzNP/7e8jNjFbbE9011aCfxvm9xVf67AoPxmcjZJj75O4fjslqM4l9XgDHHyT8
         mRs69sMepzXnsW5WAz1xduWw0hRYC7msdJqwDVQC+XaQum7ZHcgNP1thL/olrhhDFKyr
         /cXoOkhlpQNr4uLcwZplI6CWAFbA66iKCF/d9K000OgW1R/t5jiZBYYL4bofRxlshhWJ
         VDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tr+OH0VWd18MYHbL1P+tb7xUYMoJNRdzSn+T+0AHhQ0=;
        b=7IHSxkKRrhvvTtwnODbwvLH/gkWqCI6OCcfW/qMIf46xYV8ZQVucl4Ey5nHy6ggBzB
         4zbsOS/ONdJOCt/KlLdOFffaBRjZqe7mJLPag9XmAdB6WXzC7j6jXUFAdm7vnBt+AWkQ
         ziyG4vpEeUTexcfVbzQLrymB+kKjYjN4hxm0/4F2mImEdLAk84IOTkxAYvj2MlL2+PAA
         Po7TvfplqWKeogMQRCq+nPggLDMaBtouyStrhujn18ernN/arSdsAWZP+ZgfUhiLCxao
         opQqjMw/EKmPRSneX5C5DzI/Wi74yT0rD+SULhCE1jvsfgIDJs54UmAVOUiyEGRT31GD
         KAwg==
X-Gm-Message-State: AFqh2kqSlsoVNOs2RzFi+7Op8yhUxVyFgA2Fpd/yd7OkfCITyQmk4V36
        MkbBO5gytPtoy67p57qrfjYdACLOVAitkg==
X-Google-Smtp-Source: AMrXdXujkb5evOhKrjYNV2T5sIch9Fku1/F3jweVw5CLRyApOXrAnF2gATF8XLEF1Yno+Hifw5BAqQ==
X-Received: by 2002:a50:eb06:0:b0:46c:b221:8605 with SMTP id y6-20020a50eb06000000b0046cb2218605mr67630296edp.0.1673527568983;
        Thu, 12 Jan 2023 04:46:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v17-20020a170906293100b007be301a1d51sm7373523ejd.211.2023.01.12.04.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 04:46:08 -0800 (PST)
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
Subject: [PATCH v2 4/9] builtin/revert.c: move free-ing of "revs" to replay_opts_release()
Date:   Thu, 12 Jan 2023 13:45:56 +0100
Message-Id: <patch-v2-4.9-e83bdfab046-20230112T124201Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1205.g2ca064edc27
In-Reply-To: <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In [1] and [2] I added the code being moved here to cmd_revert() and
cmd_cherry_pick(), now that we've got a "replay_opts_release()" for
the "struct replay_opts" it should know how to free these "revs",
rather than having these users reach into the struct to free its
individual members.

As explained in earlier change we should be using FREE_AND_NULL() in
replay_opts_release() rather than free().

1. d1ec656d68f (cherry-pick: free "struct replay_opts" members,
   2022-11-08)
2. fd74ac95ac3 (revert: free "struct replay_opts" members, 2022-07-01)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/revert.c | 6 ------
 sequencer.c      | 3 +++
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 1cab16bf3ed..77d2035616e 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -248,9 +248,6 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	res = run_sequencer(argc, argv, &opts);
 	if (res < 0)
 		die(_("revert failed"));
-	if (opts.revs)
-		release_revisions(opts.revs);
-	free(opts.revs);
 	replay_opts_release(&opts);
 	return res;
 }
@@ -263,9 +260,6 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	opts.action = REPLAY_PICK;
 	sequencer_init_config(&opts);
 	res = run_sequencer(argc, argv, &opts);
-	if (opts.revs)
-		release_revisions(opts.revs);
-	free(opts.revs);
 	if (res < 0)
 		die(_("cherry-pick failed"));
 	replay_opts_release(&opts);
diff --git a/sequencer.c b/sequencer.c
index 5d8c68912a1..c729ce77260 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -362,6 +362,9 @@ void replay_opts_release(struct replay_opts *opts)
 	opts->xopts_nr = 0;
 	free(opts->xopts);
 	strbuf_release(&opts->current_fixups);
+	if (opts->revs)
+		release_revisions(opts->revs);
+	free(opts->revs);
 }
 
 int sequencer_remove_state(struct replay_opts *opts)
-- 
2.39.0.1205.g2ca064edc27

