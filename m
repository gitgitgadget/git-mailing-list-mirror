Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41215C433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAB1764F38
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhCQVWt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 17:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbhCQVW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 17:22:26 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AF5C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:22:26 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id d8-20020a1c1d080000b029010f15546281so1884150wmd.4
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QXXZ6PRSQKxTNeQUBO+QCyPzTHcNrIuHhP1pl77Aebg=;
        b=K3PQ8nzG/Yc4FXsEZQxQUH3Xu3FBFXTxHT7ZATlYbAeKWSzr0LEZE4AOejQ2sN4SYP
         N0lGabIE2rcDxwLsAFcmo3oYCPYM1bkm1XlY+Xk8MG9nz4/fPX8h4jJv3SZ0+CeigFIK
         cvFfh0Ih48HXMe8K+xirHmeiYvqGuR9yePN1loOddlnIWxVkajPRF4TrbVVHVOAD2kdY
         xIrc1+8dKnhbs4v0Ajd8YBNTbSwdnfBBplRgpmgQo64PkxMbarRXS4H2d14ukTUYjyI+
         pMJpGS3+v45tmJBnyp7afq7Gm2OZGU83lWayRlpfdr2kY+4YKGSfZhPMOiG2AGKly5+b
         PDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QXXZ6PRSQKxTNeQUBO+QCyPzTHcNrIuHhP1pl77Aebg=;
        b=VT4R3QhZOBUe409HTPqNFAW1CiHgpj66bq9e9vOD7kR5lLIy3paNe3++Qx1bV7RSgO
         cSV3pko9PPR0eLRB3BINnSDY/z0TSBB8EgVt/j6Dcz+XVxXw5A76j62Qv7WYOtVGPhaA
         QTRHOT9vY26oCdaka43KKfXC0sETvcC2uYoTdnP3PqA9DnbDJdeWsRhzts5+QA094rfb
         AD112Fp37zU7bRX1/BsxUA57hhxG3FX/vwL/YK2mirbld7CLu0ncJ01/2LK40PhKh1m+
         oEMoL3AnV+D6sB83hk0nawcv/OvSR7EGbveNuUKc4tqVJsSP9g0D7xPiTLzotlR+rlEj
         pFnw==
X-Gm-Message-State: AOAM532ij/WLJRVEHZ/W1LkFXpF2e7/EoDoApFHyFNGwsdMthCqVNiuV
        Xz2s+QQ1rheC6Foc9/B/gBygvJGsk+I=
X-Google-Smtp-Source: ABdhPJxwWFm7LdsJLoO70i/IncbwnJBVMrXLWuuWUy6Uu3aYJEGY3nKhhwKC7x5FBvC/KK3C7xL9mA==
X-Received: by 2002:a1c:e389:: with SMTP id a131mr670353wmh.78.1616016145075;
        Wed, 17 Mar 2021 14:22:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b15sm109656wmd.41.2021.03.17.14.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 14:22:24 -0700 (PDT)
Message-Id: <75a3c46c405549d1f5127097729c556a7e297587.1616016143.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.903.v2.git.1616016143.gitgitgadget@gmail.com>
References: <pull.903.git.1615760258.gitgitgadget@gmail.com>
        <pull.903.v2.git.1616016143.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Mar 2021 21:22:21 +0000
Subject: [PATCH v2 1/3] fsmonitor: skip lstat deletion check during git
 diff-index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nipunn Koorapati <nipunn@dropbox.com>

Teach git to honor fsmonitor rather than issuing an lstat
when checking for dirty local deletes. Eliminates O(files)
lstats during `git diff HEAD`

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 diff-lib.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/diff-lib.c b/diff-lib.c
index b73cc1859a49..3fb538ad18e9 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -30,7 +30,7 @@
  */
 static int check_removed(const struct cache_entry *ce, struct stat *st)
 {
-	if (lstat(ce->name, st) < 0) {
+	if (!(ce->ce_flags & CE_FSMONITOR_VALID) && lstat(ce->name, st) < 0) {
 		if (!is_missing_file_error(errno))
 			return -1;
 		return 1;
@@ -574,6 +574,7 @@ int run_diff_index(struct rev_info *revs, unsigned int option)
 	struct object_id oid;
 	const char *name;
 	char merge_base_hex[GIT_MAX_HEXSZ + 1];
+	struct index_state *istate = revs->diffopt.repo->index;
 
 	if (revs->pending.nr != 1)
 		BUG("run_diff_index must be passed exactly one tree");
@@ -581,6 +582,8 @@ int run_diff_index(struct rev_info *revs, unsigned int option)
 	trace_performance_enter();
 	ent = revs->pending.objects;
 
+	refresh_fsmonitor(istate);
+
 	if (merge_base) {
 		diff_get_merge_base(revs, &oid);
 		name = oid_to_hex_r(merge_base_hex, &oid);
-- 
gitgitgadget

