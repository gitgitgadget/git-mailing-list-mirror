Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00BBC433EF
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 17:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244066AbiDYRwt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 13:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244070AbiDYRwa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 13:52:30 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94C726AF2
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 10:49:25 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j15so8716920wrb.2
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 10:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l0GBE4Bw8UswNS7OaBN/M3WB04xhQh/eMswefjKAN3Q=;
        b=pqUPXhwO1GUAwyJ5Z60O5CwdFXOpOi6QtmWtEERrU+wPgnyBrmGqNRssYKs17PiXP3
         lgEWpcFiS4sX4m9A1ojJEXyOloPJj+uR2Px9X8tTEpo20UuhaxD6y7bksvwos0ReGcUv
         8u24Z+oZReNaykj2J8rd2xEzhuUxLsXy3nJ81FQAWoWJSB/e+DAsmNUV+M1+IJiRbQ60
         You7Q4ohRT0AgNYVDFDcrlKlRJ85gQFh4Fl0O99Lhpe+FZcCiruUI9lNQg2MIpFndQrh
         N2VbFn+mjipacdfm3ajZQCY1Ers1niFD+OFrribJAt8kKstYkvHGNJ6iJSekWiX5+QHM
         nR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=l0GBE4Bw8UswNS7OaBN/M3WB04xhQh/eMswefjKAN3Q=;
        b=XKthDtpJFiV08HivIpuvH0nm3aq23Igk0LJI8a5mcycJEVEFhva1JtOmc0AKEL9W5S
         9IwSoBgxSkxEgdxZ5LeoU/4jHOJHdY77gI4hhtfOL/AF2czOzaFqSSHCmvVlrEtQwySM
         +ofsEjl1AOPLj8BSHE05NsGgaxyNprbBthAoE1OzUHuEz4+wVjaHpFL4laBXgqYpwERI
         teFjS3xboDMlYzWideZr90B8ZKyA1JzoZsg9sxrh7z59n+zSRBUjPu4YEAFEWCMbVXz/
         3AWGnRRn59mNut/MyiW74AZ9QcsbI06s6xkzw5ulRUNkJLE699Cs0icdvdKbsd3iK+bL
         j7IA==
X-Gm-Message-State: AOAM5328aUdxleqziAnkbmWl5GWpSwkMQGWUirUyLTOI0pLf41IR09OC
        E1ieX9aZVaOO8fnYc/Xf4G9ak+XfTbQ=
X-Google-Smtp-Source: ABdhPJxJPEjJ8zToX06ccOsYMpil6lYJFhWhaUjcIvbibeUHMvlmZNXC7CgKoTO4fCp5CYblJNJ2xw==
X-Received: by 2002:adf:f8cf:0:b0:20a:dfae:aadd with SMTP id f15-20020adff8cf000000b0020adfaeaaddmr2832604wrq.429.1650908964084;
        Mon, 25 Apr 2022 10:49:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 20-20020a05600c22d400b0038c8dbdc1a3sm9165883wmg.38.2022.04.25.10.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 10:49:23 -0700 (PDT)
Message-Id: <27d9920366f35f06ab2572a894acb6d2a3cffcd0.1650908958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
References: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Apr 2022 17:49:13 +0000
Subject: [PATCH 3/7] sparse-index: expose 'is_sparse_index_allowed()'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Expose 'is_sparse_index_allowed()' publicly so that it may be used by
callers outside of 'sparse-index.c'. While no such callers exist yet, it
will be used in a subsequent commit.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 sparse-index.c | 2 +-
 sparse-index.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/sparse-index.c b/sparse-index.c
index 8636af72de5..ffbab7d35f1 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -118,7 +118,7 @@ static int index_has_unmerged_entries(struct index_state *istate)
 	return 0;
 }
 
-static int is_sparse_index_allowed(struct index_state *istate, int flags)
+int is_sparse_index_allowed(struct index_state *istate, int flags)
 {
 	if (!core_apply_sparse_checkout || !core_sparse_checkout_cone)
 		return 0;
diff --git a/sparse-index.h b/sparse-index.h
index 633d4fb7e31..f57c65d972f 100644
--- a/sparse-index.h
+++ b/sparse-index.h
@@ -3,6 +3,7 @@
 
 struct index_state;
 #define SPARSE_INDEX_MEMORY_ONLY (1 << 0)
+int is_sparse_index_allowed(struct index_state *istate, int flags);
 int convert_to_sparse(struct index_state *istate, int flags);
 void ensure_correct_sparsity(struct index_state *istate);
 void clear_skip_worktree_from_present_files(struct index_state *istate);
-- 
gitgitgadget

