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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55AAC4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 12:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6823123D57
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 12:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732048AbgLJMyU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 07:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbgLJMyU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 07:54:20 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E020EC0613CF
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 04:53:39 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id g185so5191427wmf.3
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 04:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=48lGBbObFRGKN4nTZYcg+Spo9THsI5se885GJiMmriQ=;
        b=E91bCqhEXFhblT+ChqGnnsNt0p2sWAqMqsj2wimzXBDfrELrMuT5lO6twRfiDAyYS9
         3gRLV/mVo2kCW1uUJwzTYkPTZJvCb/uOlnEGydFCcr9LFOzdFMomIuyNXGn9pdbsut0g
         TM+8sTvdNJE697ZmFxTJHHGtidvWMcoFHKGyVqreJHuIzlpMieOnM9hvWDxUzy8y4AUB
         7v5Rhat3g+m3kWj3vZR55MAHZ2S3ywTFl438JOQqvtv/axrpepFqM9rxk+ZZAVb+F7TT
         LwrJy9C4kJHhfs4xIu5Z1K9usMivtL5/J8jrgObN8Fuo3/pSj2YlEMeWslu3Q9n7qZsy
         THNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=48lGBbObFRGKN4nTZYcg+Spo9THsI5se885GJiMmriQ=;
        b=gOEBMfo+tpZPv0odBMhSbi+xqJu+orBY+teESTiMl9r3ylZ8/VVXc99dqlKINnB6B/
         UIKtUtcAUqjA1VgRNRGvzSNDKPdqRwnTGsUJROPHPMU+P95aAl37muExLcVFQbrIj2sK
         gXqFLWoOLdTiza6gl8xN71pgNQU+YuEJuZCK8WYU29k6foGtHzSv1cFVI3AC7MNpGKwc
         48IDAPN4b9AFgI/IoNrFjrur4j3JlOlDbNZuGov7HQtZCWEo4zxpJynrtMpx7bwPXOuI
         zoQ6AJFgEzmuRrAIYGUhgG8hlE1hCjDEmEYVDIwV4MEWc6InD2j/ZAaagFycr0FMhKFo
         OI/A==
X-Gm-Message-State: AOAM530sh+Rx0pRckyB8Z32MlCWeNRogs6v+wzwyZb3TAEgU9zxe/ImK
        HCVnrg7SqWB8DlBBwxegbq9WGYtAcwSiyg==
X-Google-Smtp-Source: ABdhPJyQ+dKyUQrFp/uPekyT84cdjeRX4HySwc/Z3wVyab2/++G8X2n1hy7PRvG1S3O6YuCuVccnbw==
X-Received: by 2002:a1c:23d5:: with SMTP id j204mr8119254wmj.130.1607604818644;
        Thu, 10 Dec 2020 04:53:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w17sm9387583wru.82.2020.12.10.04.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 04:53:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] refs: move is_pseudoref_syntax() earlier in the file
Date:   Thu, 10 Dec 2020 13:53:20 +0100
Message-Id: <20201210125321.19456-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This move is needed by a subsequent change to the expand_ref()
function, which will make use of these functions.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/refs.c b/refs.c
index 392f0bbf68b..3ec5dcba0be 100644
--- a/refs.c
+++ b/refs.c
@@ -630,6 +630,25 @@ int repo_dwim_ref(struct repository *r, const char *str, int len,
 	return refs_found;
 }
 
+static int is_pseudoref_syntax(const char *refname)
+{
+	const char *c;
+
+	for (c = refname; *c; c++) {
+		if (!isupper(*c) && *c != '-' && *c != '_')
+			return 0;
+	}
+
+	return 1;
+}
+
+static int is_main_pseudoref_syntax(const char *refname)
+{
+	return skip_prefix(refname, "main-worktree/", &refname) &&
+		*refname &&
+		is_pseudoref_syntax(refname);
+}
+
 int expand_ref(struct repository *repo, const char *str, int len,
 	       struct object_id *oid, char **ref)
 {
@@ -716,25 +735,6 @@ static int is_per_worktree_ref(const char *refname)
 	       starts_with(refname, "refs/rewritten/");
 }
 
-static int is_pseudoref_syntax(const char *refname)
-{
-	const char *c;
-
-	for (c = refname; *c; c++) {
-		if (!isupper(*c) && *c != '-' && *c != '_')
-			return 0;
-	}
-
-	return 1;
-}
-
-static int is_main_pseudoref_syntax(const char *refname)
-{
-	return skip_prefix(refname, "main-worktree/", &refname) &&
-		*refname &&
-		is_pseudoref_syntax(refname);
-}
-
 static int is_other_pseudoref_syntax(const char *refname)
 {
 	if (!skip_prefix(refname, "worktrees/", &refname))
-- 
2.29.2.222.g5d2a92d10f8

