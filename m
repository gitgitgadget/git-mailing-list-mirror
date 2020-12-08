Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0048C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98CEC23A04
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgLHA1k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbgLHA1i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:27:38 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5B2C0617B0
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:26:58 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id q25so9505305oij.10
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CIQP+pvUK3D2Gs8X4af48HlNAB2MlOCj8t5tszm79nM=;
        b=JtutgEb5ZgguMPNWSLWR1ksu6ofK2Mlxh6lnzi3XpNxlya+H/pUOx20Ds3R9XLBfGu
         kzeo1f5xJkxKiJA1Tq6lwsl9jIY3PO8rAylBTTEsdODemyPiVnfT+P3mw77AMqeTawQn
         nUx8RNg4XoPwSBv1WGKkzvtVezKl0swMkLDe/NVKIWSEZUE/UQvG67F966UDrtG24FwW
         cXiUGGsw2QXWt0Rv/HJMNgrFFagPfliFr20w5TjH7Nnv5I0qtHt8W93bBaJQvJ319ycN
         aQ0ppAvVOyd96WMNt5+0n3H69gND4FXiYkZzKPTHW3+F9Ii5kSyHkw+/u9iqHvaE3D+C
         9muQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CIQP+pvUK3D2Gs8X4af48HlNAB2MlOCj8t5tszm79nM=;
        b=dIEpXfCl/lAMihCM19d/h3g3NKzWLDBgoGKySPh1mH1Ywk/um78RjlyZlEG3lTrc4F
         wvz7j2hPG3a1LCmlHtPpGLe2jGdcfSA4h/lkyvvJuJX9A+rbkOvQWRNqZnN8dV4Eg87Y
         nMq9fU8Pjgs6Ac78926OkYam+91b9Qr7WrNFVzU/WMC0fKKtz2qfC2Z9UJUYa1wUjtpy
         IZewqi/xxdkhGetsNgbALb9vefnOGOKs3o0N1VPMbvkQRfKabk2YURDqYgRsYHzMBHja
         QBrlUTpuXo6jY37MWtA9rUj1gQv8V/UQ5blDt3nfgBuYFiECOKTITo+jkO8yYhbgWuTD
         Yt3g==
X-Gm-Message-State: AOAM530uplRilJ8dqEv8zK/qy59ciVllO9jOu0ulmLKOFlSFFEDlk8ev
        HYpQi62SPEDfgDmpkXc5j37E9njEol5W33wo
X-Google-Smtp-Source: ABdhPJzGaH5OBalHGpe3b/ohd3XcXiD43+PglVDprjHUrr1hErCPxloDS/NIKs6w8AyVfHP8PdtRMA==
X-Received: by 2002:aca:fd0d:: with SMTP id b13mr983340oii.27.1607387217276;
        Mon, 07 Dec 2020 16:26:57 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id n190sm2981525oob.11.2020.12.07.16.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:26:56 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 04/19] pull: cleanup autostash check
Date:   Mon,  7 Dec 2020 18:26:33 -0600
Message-Id: <20201208002648.1370414-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208002648.1370414-1-felipe.contreras@gmail.com>
References: <20201208002648.1370414-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently "git pull --rebase" takes a shortcut in the case a
fast-forward merge is possible; run_merge() is called with --ff-only.

However, "git merge" didn't have an --autostash option, so, when "git
pull --rebase --autostash" was called *and* the fast-forward merge
shortcut was taken, then the pull failed.

This was fixed in commit f15e7cf5cc (pull: ff --rebase --autostash
works in dirty repo, 2017-06-01) by simply skipping the fast-forward
merge shortcut.

Later on "git merge" learned the --autostash option [a03b55530a
(merge: teach --autostash option, 2020-04-07)], and so did "git pull"
[d9f15d37f1 (pull: pass --autostash to merge, 2020-04-07)].

Therefore it's not necessary to skip the fast-forward merge shortcut
anymore when called with --rebase --autostash.

Let's always take the fast-forward merge shortcut by essentially
reverting f15e7cf5cc.

Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index e2964a0b5f..d44ca2ffde 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -944,7 +944,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	struct oid_array merge_heads = OID_ARRAY_INIT;
 	struct object_id orig_head, curr_head;
 	struct object_id rebase_fork_point;
-	int autostash;
 
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
@@ -977,8 +976,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (get_oid("HEAD", &orig_head))
 		oidclr(&orig_head);
 
-	autostash = config_autostash;
 	if (opt_rebase) {
+		int autostash = config_autostash;
 		if (opt_autostash != -1)
 			autostash = opt_autostash;
 
@@ -1053,13 +1052,11 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) &&
 		    submodule_touches_in_range(the_repository, &upstream, &curr_head))
 			die(_("cannot rebase with locally recorded submodule modifications"));
-		if (!autostash) {
-			if (get_can_ff(&orig_head, &merge_heads.oid[0])) {
-				/* we can fast-forward this without invoking rebase */
-				opt_ff = "--ff-only";
-				ran_ff = 1;
-				ret = run_merge();
-			}
+		if (get_can_ff(&orig_head, &merge_heads.oid[0])) {
+			/* we can fast-forward this without invoking rebase */
+			opt_ff = "--ff-only";
+			ran_ff = 1;
+			ret = run_merge();
 		}
 		if (!ran_ff)
 			ret = run_rebase(&newbase, &upstream);
-- 
2.29.2

