Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BDBC636D4
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 19:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjBFTIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 14:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjBFTIr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 14:08:47 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462A82B094
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 11:08:46 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o36so9416297wms.1
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 11:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1Boab3tQ90QviUbBcNMfzxJFBdLe2EOs/pGboSeW5Y=;
        b=nzxreF+ukM56DDMQiCavgoQR4yq2ZGLxGNdzKJKdaigo9rKNZFnzlNW/lR4rvcVeWd
         Zn4C1ShGumQgrWQZGZfZDQWNFofagQh67jqYK4AeNpzkmK0PclCo9SPq9iqLBToc4mYT
         9LoFezzJoVUMvbD+MTU3eUYwMfYb9K8fSo/K45MWiCNz+HI+pKRCYBUp3iLyPZHdtVoX
         t46aOfGlKCiAKttGZFliMvR1m8ahVdamSPKt6zWsz3dkyZ4kXHuIjfWDL0KhvwDXuLBx
         +N8qFEB2UE6G2542wnHxl2dhvF1cQ2MeTUU4Lsh+SfbazHwrlXUdiyPzGt/GmNR3Z+K3
         cfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L1Boab3tQ90QviUbBcNMfzxJFBdLe2EOs/pGboSeW5Y=;
        b=yH6V2RkanfZP4UyozTD+CKa2rn8YbCNH4LMABC7waENStoajKz0gHCimuw05VCim3/
         VsNkRyb+wX/nIxxAib7Hz+cm38CER8MgSCHyskv4F3VOu4ycfTeugtgYSJmBvDk+vPx/
         rcMmLRU6wveUdEH1f1RdC9VbeVh9986fChDPw6+zqc4od6m9nZK98jqnLYyMyj1H9ZG+
         icHrH3PCoHyJZVgV2Nc/URr0ypuC5DRZmpV3DLw0QcqHUPn45wfGWrx6Nb30AvACqFI6
         A511Wir6g4t3fw6m5OFnfOg1vDbPSCNRvzJwbG8uA4H/PfY2kCeGEWDiXXJQGM8oXBqi
         t3IA==
X-Gm-Message-State: AO0yUKVYkpVVBpn6FFr4bqYuzMOYLm/V5E/YCpupTN37X9Ers4MLsTge
        E3jW8s2j4jSARpNZUaFsoU6SAcGsRWtMUrCq
X-Google-Smtp-Source: AK7set9V4F7jGeF5aMY8sHQDIpV0GdI2Sy7gD9TfopTpeHG+0Hs28byA9sGnzNmhvf0b9mmROjokuQ==
X-Received: by 2002:a05:600c:4910:b0:3e0:c97:f1d0 with SMTP id f16-20020a05600c491000b003e00c97f1d0mr738097wmp.20.1675710524577;
        Mon, 06 Feb 2023 11:08:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p2-20020a05600c358200b003dc4ecfc4d7sm12538595wmq.29.2023.02.06.11.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 11:08:43 -0800 (PST)
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
Subject: [PATCH v4 1/8] rebase: use "cleanup" pattern in do_interactive_rebase()
Date:   Mon,  6 Feb 2023 20:08:06 +0100
Message-Id: <patch-v4-1.8-029fc5f4b8c-20230206T190346Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.ge02fe682bd8
In-Reply-To: <cover-v4-0.8-00000000000-20230206T190346Z-avarab@gmail.com>
References: <patch-v3-7.8-ee8262ab22a-20230118T160600Z-avarab@gmail.com> <cover-v4-0.8-00000000000-20230206T190346Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use a "goto cleanup" pattern in do_interactive_rebase(). This
eliminates some duplicated free() code added in 53bbcfbde7c (rebase
-i: implement the main part of interactive rebase as a builtin,
2018-09-27), and sets us up for a subsequent commit which'll make
further use of the "cleanup" label.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rebase.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 7171be40eeb..c97ce642cf3 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -254,7 +254,7 @@ static int init_basic_state(struct replay_opts *opts, const char *head_name,
 
 static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 {
-	int ret;
+	int ret = -1;
 	char *revisions = NULL, *shortrevisions = NULL;
 	struct strvec make_script_args = STRVEC_INIT;
 	struct todo_list todo_list = TODO_LIST_INIT;
@@ -262,16 +262,12 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 
 	if (get_revision_ranges(opts->upstream, opts->onto, &opts->orig_head->object.oid,
 				&revisions, &shortrevisions))
-		return -1;
+		goto cleanup;
 
 	if (init_basic_state(&replay,
 			     opts->head_name ? opts->head_name : "detached HEAD",
-			     opts->onto, &opts->orig_head->object.oid)) {
-		free(revisions);
-		free(shortrevisions);
-
-		return -1;
-	}
+			     opts->onto, &opts->orig_head->object.oid))
+		goto cleanup;
 
 	if (!opts->upstream && opts->squash_onto)
 		write_file(path_squash_onto(), "%s\n",
@@ -300,6 +296,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 			opts->autosquash, opts->update_refs, &todo_list);
 	}
 
+cleanup:
 	free(revisions);
 	free(shortrevisions);
 	todo_list_release(&todo_list);
-- 
2.39.1.1425.ge02fe682bd8

