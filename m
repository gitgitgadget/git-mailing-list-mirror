Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B710DC05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 19:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjBFTIx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 14:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjBFTIv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 14:08:51 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77C12B2A8
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 11:08:49 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id z13so1934618wmp.2
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 11:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96st8uUJULNn7PidqZM3pJY+/Zs5sHOjT2xbargMSv4=;
        b=ORO80ollm0P9PY1CAUhJXMAhfGYNlKyHYZHS767P0DJPnxNDy4YSZuNqdPnqSlvmTS
         b+zhMTKc+nVc2AcHsHmajpz3IqDNF6PvXNE/kaoN3IxwPzfwDKdPlH7TAtYptfDZenyk
         LAefnVB0v+VLvsmAUSfcIqLgiGFe3X68ID2oXjcH37eTq4aQ9K4edXegLgMoxYF73kLq
         D08IEMaU3PEgKG7Vrq7QjM+1mOrGSnPT6I66CmdbNmfWLij3hWExpRfm0Rl1K208pH98
         juKIAww+TIGGFNZne+m4Cabq+uQkr/ew3+bb88X+TZAaew/D3jvG+caACQFFA63N+0M3
         zeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96st8uUJULNn7PidqZM3pJY+/Zs5sHOjT2xbargMSv4=;
        b=hTudPg00OQUSmzGfbr8L44eB9XsyNgcJJo97J4XbUWzUh7n9dG6zYdieoT4zhSA5UO
         4psTHMjuy8bh6rB2gVUmzPdbtOTDCBireyFIoBLAlavdeuOwcHVFgkBSI85Ns1xYPu/6
         fLgZ7DSI+09MH55cumMRiwSB6tz8DmCqn6laB4BhCHRw5+l67kZSGh5B1bDSLkU991Lk
         mEPqhei5LG1KLYm3UlqBdTYPxskebjlpH7Ox/p4NE7aoHbPrzS94DTWW44z+cglN0OQY
         0TuC8m1DmEO0HT0k7fXJ6Paj/mnmXvgwqreGs6PUC7bOg6gPPpKcCPicKzLf0WqVNw3c
         bdAQ==
X-Gm-Message-State: AO0yUKX0bi/sI+jF4hd+BIFCGbOeiEtUGUGRmpRWDJPlYKSz7Nm5epRo
        LCdSbwgfzZr8x2qUbiwXcirVkXi0afT3lgBS
X-Google-Smtp-Source: AK7set/plAJerPPGdoJ45sMtioweGkd3ETiiI30j98faCDZs/7hdBuYWUtwoLrH632BtJgW6hXt2Sw==
X-Received: by 2002:a05:600c:a294:b0:3e0:10d:f1c with SMTP id hu20-20020a05600ca29400b003e0010d0f1cmr690338wmb.37.1675710528019;
        Mon, 06 Feb 2023 11:08:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p2-20020a05600c358200b003dc4ecfc4d7sm12538595wmq.29.2023.02.06.11.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 11:08:47 -0800 (PST)
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
Subject: [PATCH v4 4/8] builtin/revert.c: move free-ing of "revs" to replay_opts_release()
Date:   Mon,  6 Feb 2023 20:08:09 +0100
Message-Id: <patch-v4-4.8-6b29d7d00c2-20230206T190346Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.ge02fe682bd8
In-Reply-To: <cover-v4-0.8-00000000000-20230206T190346Z-avarab@gmail.com>
References: <patch-v3-7.8-ee8262ab22a-20230118T160600Z-avarab@gmail.com> <cover-v4-0.8-00000000000-20230206T190346Z-avarab@gmail.com>
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
index 1547fb98597..cb4b1ce062c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -361,6 +361,9 @@ void replay_opts_release(struct replay_opts *opts)
 		free(opts->xopts[i]);
 	free(opts->xopts);
 	strbuf_release(&opts->current_fixups);
+	if (opts->revs)
+		release_revisions(opts->revs);
+	free(opts->revs);
 }
 
 int sequencer_remove_state(struct replay_opts *opts)
-- 
2.39.1.1425.ge02fe682bd8

