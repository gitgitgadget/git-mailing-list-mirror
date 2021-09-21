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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12143C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 13:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0D9F6115A
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 13:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbhIUNbw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 09:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbhIUNbt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 09:31:49 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3760C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 06:30:20 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u15so39206618wru.6
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 06:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0lTujGClX5MD6i5VCQld4pCb+Gtw7PyT3DmtQXIneos=;
        b=Tud9bBKidMEXhNer1RlYlDskgiOxI25kfr67UjSP35LwBRxSsQBEF1zKrgQ87BIxNN
         RDh8Dco1ifPEXNfVayGQuUFkZmoAztw2FNhBDfHmI2x0OGui3FkGA1P+oy/g9QScXxgS
         Wn18I63NX4S7FYWC+JZreBOdXBniyUE/ic9Ev6CjJi8DWyu6TZKIsxQ1g8L9fVWePQe+
         BCS/ojWAcx1KZ5g16tNYhitozPmdty83ocG2Zakcn0RLAlBkz5kUfl8asOx2ri3KZpSQ
         yNk96QeH8b4KNNurGEaJearn78QJlS/WoiECwvjQ0eY5ogBCbyT9s1qirzRgsffEu9dB
         RnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0lTujGClX5MD6i5VCQld4pCb+Gtw7PyT3DmtQXIneos=;
        b=c1/C7S6Yilhl+5Fk1y+1mBUuLfTG4vwVb6plC4tsaDs4+UjfpdxqU+jDnlqhfh9vAO
         0yasDBjOTS1kkdmMjDY7JORa602ObV5lVMBlLxFcxOc9xNjGVIcgYBYBvVTyLpLvV/Fn
         FiiC7wOB8snzkQEL91hySqzQ0io1OOZmGuLAFdJ6Hn+ZaIWGsAIX9VBqwO2IzZ13GPyP
         TNo8AjD69tFy+Bi2AuSqJElPko8cnGgyqcCA5R5UDqmvdEKIPzmYfLlgz9o+R9LUfOoC
         vAvy2Mmg7J0KjfCVgFtbEMIf84CDcVAI3A1UmIwm2G4ZWNkhLPztfwyxBvkJjoLphdTD
         hzJw==
X-Gm-Message-State: AOAM530VruXnLTCZGis0l1S0maG19C9MaiBQHGA/BlcWKItSBV9a0Se4
        GZ/P4QnDdylWDej67WiPyKI2x/Fo5kr6JA==
X-Google-Smtp-Source: ABdhPJybgWIhSCqbSw6W8hJ2Il2wfAyLtUSGIEi2T5MDZnAWY6T3sHihfwYfrP+ZVtJTQD6KA3sSsQ==
X-Received: by 2002:a7b:c242:: with SMTP id b2mr4685882wmj.182.1632231018530;
        Tue, 21 Sep 2021 06:30:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 135sm2926891wma.32.2021.09.21.06.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 06:30:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 2/4] send-pack: properly use parse_options() API for usage string
Date:   Tue, 21 Sep 2021 15:30:09 +0200
Message-Id: <patch-v5-2.4-d3767214d22-20210921T132350Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <cover-v5-0.4-00000000000-20210921T132350Z-avarab@gmail.com>
References: <cover-v4-0.4-00000000000-20210912T235347Z-avarab@gmail.com> <cover-v5-0.4-00000000000-20210921T132350Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "send-pack" was changed to use the parse_options() API in
068c77a5189 (builtin/send-pack.c: use parse_options API, 2015-08-19)
it was made to use one very long line, instead it should split them up
with newlines.

Furthermore we were including an inline explanation that you couldn't
combine "--all" and "<ref>", but unlike in the "blame" case this was
not preceded by an empty string.

Let's instead show that --all and <ref> can't be combined in the the
usual language of the usage syntax instead. We can make it clear that
one of the two options "--foo" and "--bar" is mandatory, but that the
two are mutually exclusive by referring to them as "( --foo | --bar
)".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-send-pack.txt | 4 ++--
 builtin/send-pack.c             | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 44fd146b912..be41f119740 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -9,10 +9,10 @@ git-send-pack - Push objects over Git protocol to another repository
 SYNOPSIS
 --------
 [verse]
-'git send-pack' [--all] [--dry-run] [--force] [--receive-pack=<git-receive-pack>]
+'git send-pack' [--dry-run] [--force] [--receive-pack=<git-receive-pack>]
 		[--verbose] [--thin] [--atomic]
 		[--[no-]signed|--signed=(true|false|if-asked)]
-		[<host>:]<directory> [<ref>...]
+		[<host>:]<directory> (--all | <ref>...)
 
 DESCRIPTION
 -----------
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 729dea1d255..89321423125 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -17,10 +17,10 @@
 #include "protocol.h"
 
 static const char * const send_pack_usage[] = {
-	N_("git send-pack [--all | --mirror] [--dry-run] [--force] "
-	  "[--receive-pack=<git-receive-pack>] [--verbose] [--thin] [--atomic] "
-	  "[<host>:]<directory> [<ref>...]\n"
-	  "  --all and explicit <ref> specification are mutually exclusive."),
+	N_("git send-pack [--mirror] [--dry-run] [--force]\n"
+	   "              [--receive-pack=<git-receive-pack>]\n"
+	   "              [--verbose] [--thin] [--atomic]\n"
+	   "              [<host>:]<directory> (--all | <ref>...)"),
 	NULL,
 };
 
-- 
2.33.0.1098.gf02a64c1a2d

