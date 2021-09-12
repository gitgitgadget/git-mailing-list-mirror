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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7B9C433FE
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 00:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61CE26113E
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 00:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbhILARa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 20:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbhILARY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 20:17:24 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD592C061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 17:16:10 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso4170097wmb.2
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 17:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k67VARF2MF1egGhnxXp1DcLOi1n7kd1vRAHXLBoau1Q=;
        b=AI/Z5THUqEiLih+q9KbqQOuL10/5YGii6AV+169OfIZvkIElQ3dkCnNETkkC8NCF/2
         +TUm0rtJFgGJckDE/rTc3FNcb1dHnp1Z/km/JpBM4M1YX/H3YasV9Ltd8iX+9jUzrtqG
         cwLWV681CVwhIItiLiU6sAS7gHLuGZ+Fx1OnoXbIuLGLhfRB2gHa7Mjs/fMi09/7kPpP
         IJo+NZi6ooQoA9Aq13ToBcrv0/8irAuTxw2O/0HY7ZAyDMz4/xOYITa91smklsZyrO86
         Rqt6bIQOx+zBUsbUFR9aIQzaOiSNueuNB3rYNM/bJfD+mnlKJSj8yc9KdSrnzO71EDPU
         sc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k67VARF2MF1egGhnxXp1DcLOi1n7kd1vRAHXLBoau1Q=;
        b=n8lgEaFP5eflOkpDQdIaYYliKx2ApmBqN9+TsUg7TNR1z7qMqtqECIwes2R+d0Mnc8
         Tq0+mg4VeBSOHMht+6719Yd/Cc1AEATj00yy6C5zSYJ5a4XNQNu3VNhNmtATrC6ULX5E
         M58ymz9CKUqk9Y7VQyA6tUcKoRmvKgD3tXHHjNFsAO8ykLb6KfEnuxDhh8zpXlNtpHeg
         26D5KWtTJj+Nlp9p+md7dLhjktV5LqFrwx2hmkVjeD3aogf9NmCTCLSSpSo1bVhK2nV/
         tCRDhmxFm/ua3xQZDONZvV6m4gsm5sefwcK78auala/cTgN5S6iqRYjm9iVBc2N2XVRJ
         NBMA==
X-Gm-Message-State: AOAM533qp/kQXMBFO3GRrmDBl3xXyPBt/hNCJMxYzkYKIaxdN3JPNqlA
        5b7o8+Ac0lEEZETSXpndIPa+EQ/TlRQb0w==
X-Google-Smtp-Source: ABdhPJxv5gYk9zCtKtMvNUA8pDdoUvNun6jIErAxqGCsWE+nHVBPy68ZqWIjj683k9vYGWNq0u1SJw==
X-Received: by 2002:a1c:f314:: with SMTP id q20mr4361299wmq.154.1631405769076;
        Sat, 11 Sep 2021 17:16:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p5sm3301078wrd.25.2021.09.11.17.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 17:16:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/7] rebase: don't have loop over "struct strvec" depend on signed "nr"
Date:   Sun, 12 Sep 2021 02:15:53 +0200
Message-Id: <patch-v2-5.7-be85a0565ef-20210912T001420Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.998.ga4d44345d43
In-Reply-To: <cover-v2-0.7-00000000000-20210912T001420Z-avarab@gmail.com>
References: <5e5e7fd9-83d7-87f7-b1ef-1292912b6c00@iee.email> <cover-v2-0.7-00000000000-20210912T001420Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As in the preceding commit, prepare for the "nr" member of "struct
strvec" changing from an "int" to a "size_t".

Let's change this code added in f57696802c3 (rebase: really just
passthru the `git am` options, 2018-11-14) so that it won't cause a
bug if the "i" variable here is updated to be a "size_t" instead of an
"int".

The reason it would be buggy is because this for-loop relied on
"counting down" from nr-1 to 0, we'll then decrement the variable one
last time, so a value of -1 indicates that we've visited all
elements. Since we're looking for a needle in the haystack having
looked at all the hay means that the needle isn't there.

Let's replace this with simpler code that loops overthe "struct
strvec" and checks the current needle is "-q", if it isn't and we're
doing a merge we die, otherwise we do a "REBASE_APPLY".

We've been able to simplify this code since 8295ed690bf (rebase: make
the backend configurable via config setting, 2020-02-15) when we
stopped using this for anything except this one check, so let's do
that and move the check into the loop itself.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rebase.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 27669880918..dcd897fda9c 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1750,16 +1750,14 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	if (options.git_am_opts.nr || options.type == REBASE_APPLY) {
 		/* all am options except -q are compatible only with --apply */
-		for (i = options.git_am_opts.nr - 1; i >= 0; i--)
-			if (strcmp(options.git_am_opts.v[i], "-q"))
-				break;
-
-		if (i >= 0) {
-			if (is_merge(&options))
-				die(_("cannot combine apply options with "
-				      "merge options"));
-			else
+		for (i = 0; i < options.git_am_opts.nr; i++) {
+			if (strcmp(options.git_am_opts.v[i], "-q")) {
+				if (is_merge(&options))
+					die(_("cannot combine apply options with "
+					      "merge options"));
 				options.type = REBASE_APPLY;
+				break;
+			}
 		}
 	}
 
-- 
2.33.0.998.ga4d44345d43

