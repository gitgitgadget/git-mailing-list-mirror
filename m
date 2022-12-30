Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBBEC4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 07:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbiL3H2o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 02:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbiL3H20 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 02:28:26 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9CB18E08
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 23:28:25 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso14685031wmp.3
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 23:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5IAFNj8WEn1g7arBzvenIlOV47hR/aLwavS/6SIC9c=;
        b=FdRFLLoQJ/UJq4gyRxYun9YTsjXYSwP96v8Em9wn9+Zo/NSp5gR9jW+NyaqQdFeRtg
         4igVY58U71yYY0gWGPgqa4/++7rIGLywsPPNF2dCcavxERtmADBceWBiZdyGbMgZ3bTX
         l7O5nBWck9AQzx5VERcnS2FNWLrcQsKoQOmr7kV9w2O66mRt0pcNnPX/D3/UzS1mERPW
         0qo1hYdY75YBaU30xnEXrNjcDJdIF2OOZ23MUhd5qV+/2XDpg1/kZnuhj9Hn0W9Jk/8j
         zrA5asM7Cev9/EBrRPP7ktmWf+r6e1qRVg017ZHSiag7AnVMefCJbOKNYOMDk23Bh8i1
         XWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5IAFNj8WEn1g7arBzvenIlOV47hR/aLwavS/6SIC9c=;
        b=snhPiGG8kDdeXc7tYfSKrP0I5M307e7bAgxCSIxdn1a4R+npIlR4KJ+QjtnlYc+kiS
         STeGkR5iXT/9yGKznY4ZI4/AZFazAykMnaDa4tevKUNbc/saO10RX4++7TEnr08u5Yvk
         esxV68y7OMlmrCJAHVQeyL6+LoQCNB1+zIZAd9qXX9GPvYSjCZwS6wsCR+KifVDzi07D
         S3p9d/g8M5A87s96/25I2kfEl/8GSqqEsAmVGlszrKHbDKNva0DzrrYCL+cU+8GCypF7
         3O1RJ2GXwPXlWIeXXwP4N1wtokxFWRMhC54FB5dqJUi7aqM0/1i+1NxmQz7XF2ekzElA
         qczg==
X-Gm-Message-State: AFqh2kqIZ9M3slegfOFtSyI1rLRhj/l64NGHmjuiK0RiwM1lzmjvfpn/
        Dr4Hq7EY2BYE6qzcbQ9XfPaTDcSvM5NAcg==
X-Google-Smtp-Source: AMrXdXsvVEPJqGvlXxtY4Q+CN2ie/Gs5CH+shPFQTPr1TyNTXtY+OeEwmwwXdkTSY6I1pcg/9BIY6Q==
X-Received: by 2002:a05:600c:4c21:b0:3cf:f18b:327e with SMTP id d33-20020a05600c4c2100b003cff18b327emr22361128wmp.4.1672385304069;
        Thu, 29 Dec 2022 23:28:24 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b003d998412db6sm6526449wmn.28.2022.12.29.23.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 23:28:23 -0800 (PST)
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
Subject: [PATCH 06/10] builtin/revert.c: move free-ing of "revs" to replay_opts_release()
Date:   Fri, 30 Dec 2022 08:28:11 +0100
Message-Id: <patch-06.10-21eea8eb802-20221230T071741Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
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
 builtin/revert.c | 8 ++------
 sequencer.c      | 3 +++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 2f656b25619..b9fb13c515a 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -254,9 +254,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	res = run_sequencer(argc, argv, &opts);
 	if (res < 0)
 		die(_("revert failed"));
-	if (opts.revs)
-		release_revisions(opts.revs);
-	free(opts.revs);
+	replay_opts_release(&opts);
 	return res;
 }
 
@@ -268,9 +266,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	opts.action = REPLAY_PICK;
 	sequencer_init_config(&opts);
 	res = run_sequencer(argc, argv, &opts);
-	if (opts.revs)
-		release_revisions(opts.revs);
-	free(opts.revs);
+	replay_opts_release(&opts);
 	if (res < 0)
 		die(_("cherry-pick failed"));
 	return res;
diff --git a/sequencer.c b/sequencer.c
index e29a97b6caa..47367e66842 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -362,6 +362,9 @@ void replay_opts_release(struct replay_opts *opts)
 	opts->xopts_nr = 0;
 	FREE_AND_NULL(opts->xopts);
 	strbuf_release(&opts->current_fixups);
+	if (opts->revs)
+		release_revisions(opts->revs);
+	FREE_AND_NULL(opts->revs);
 }
 
 int sequencer_remove_state(struct replay_opts *opts)
-- 
2.39.0.1153.g589e4efe9dc

