Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75354C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 388162342C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbgLPSwD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732237AbgLPSwC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:52:02 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48A3C0611BB
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:48 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id o19so25351583lfo.1
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vquWka1FWhpJRpcBiqZaG2TJQIHaEDYg4BkMYIQn4ts=;
        b=YkP+G6Iz5G8UO5d/rcocneFx4Q6gXHlu7h/UIRB0OmvIIHAEYYzzvGHlYKEK7qbiAR
         XOTJtxiFdTg4XVJgSs0b2lQWd601F2oA7lCCxgraifJ9zQYxrrIANwDkD4w0+z+j0T3N
         QYZent/vovTX1tSaaQTOz+EYKkALNfTR/wP8DAdKAKjflmVoh2twgtO6BM+2lkG7JWAa
         o614pzSepwOfuc01S1aB+0OB/6QlFabhEwS9nE6LyuCCJLGyNEj9ZYhXAj2PiK2WiAmC
         LFxxRKfUCcbhwlqSOYIYzQVRjBjou2RTmlvQosZSyjT1lj3hubHrAkDagthUDequSjQZ
         YhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vquWka1FWhpJRpcBiqZaG2TJQIHaEDYg4BkMYIQn4ts=;
        b=cYOBUWPNug7yNGNS1KpFeKtxxINodSTvknGbwtsCCKiCtd6+7/r9pHWId6X2r/Y1Ln
         vMYbSaJkbgay4KH2TrM9WoHL9sR6c+V28x2vpg0zQOIATlh3iDhNDa1+zFuetCMA6Ahl
         B3R85zKDXuFPkzZ3z9UpS6DksewrzdY+YAg7YBz3LIcL9tFy2sVdEamY2ppqUj22eR4x
         bj/3Ylq+UByjbuW6fGp0bFxmtooqt3YACz2h+7rhT3HCkA6TfnOs+OjXFG1g3gXCSa6l
         wew2D/imz2wX3K5nKdmPZcFh/fNh7G7OI3n7p9hnT20TPsWyRN59cyeD0t+/xYDCZ3Xp
         h5QA==
X-Gm-Message-State: AOAM531l/j46SfsdaRcpe2fmWMtpqtUJKa9HMcqp7MAyiZOIBNvSeXj1
        M9pdq7Ws6Pz4TYmAgaY1RnI=
X-Google-Smtp-Source: ABdhPJwcpTHzMzdCVEt2u9eAy1i1oLlfbo2ypSHBpb3qtG130NTYgYIpWqVAWf/a8h7jagGORU9vbQ==
X-Received: by 2002:a2e:8297:: with SMTP id y23mr14240223ljg.177.1608144646326;
        Wed, 16 Dec 2020 10:50:46 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:50:45 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 19/33] diff-merges: get rid of now empty diff_merges_init_revs()
Date:   Wed, 16 Dec 2020 21:49:15 +0300
Message-Id: <20201216184929.3924-20-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After getting rid of 'ignore_merges' field, the diff_merges_init_revs()
function became empty. Get rid of it.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 3 ---
 diff-merges.h | 2 --
 revision.c    | 1 -
 3 files changed, 6 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index 711df9975dd5..9ff6ea02edb8 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -19,9 +19,6 @@ static void set_dense_combined(struct rev_info *revs) {
  * Public functions. They are in the order they are called.
  */
 
-void diff_merges_init_revs(struct rev_info *revs) {
-}
-
 int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
 	int argcount = 1;
 	const char *optarg;
diff --git a/diff-merges.h b/diff-merges.h
index f92de137d3a0..659467c99a4f 100644
--- a/diff-merges.h
+++ b/diff-merges.h
@@ -9,8 +9,6 @@
 
 struct rev_info;
 
-void diff_merges_init_revs(struct rev_info *revs);
-
 int diff_merges_parse_opts(struct rev_info *revs, const char **argv);
 
 void diff_merges_suppress(struct rev_info *revs);
diff --git a/revision.c b/revision.c
index 5a0e3d6ad542..46645ca0b6df 100644
--- a/revision.c
+++ b/revision.c
@@ -1814,7 +1814,6 @@ void repo_init_revisions(struct repository *r,
 
 	revs->repo = r;
 	revs->abbrev = DEFAULT_ABBREV;
-	diff_merges_init_revs(revs);
 	revs->simplify_history = 1;
 	revs->pruning.repo = r;
 	revs->pruning.flags.recursive = 1;
-- 
2.25.1

