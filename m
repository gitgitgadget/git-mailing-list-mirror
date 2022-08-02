Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61304C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237353AbiHBPrb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbiHBPq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:46:56 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4E518369
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:46:34 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z12so8295998wrs.9
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=SNemw1CHPXvRNtfpgXSs58w9pwqN0NS69vSx7kx33CM=;
        b=D29GAhil5B3o7TEd5CbSyylMiZnQCwVawZKmaB1mlnDNCDPNJPCGuZXujsuxO/7i+A
         NHT3R/ula+1IBVUJRe4JGfeAZyEw26xY684BYMgHpkKLUhQrpLDSWcVbbjNKlmYdrunQ
         PxYxQjZL3QykYwCjR37+f9JbCIcl/V8qR1fgWn2JYwRmIbLaU7MbZl63I5FCuphojrsk
         Wb6W8tras43ilF3/KVyjRkU/lqqdN67JEPfAOZIllFUJgMrR/Kv1D2NNbkUp6dNZ2j73
         +kgcThLDiWqqM+nSYeHggJ7XGUyrwmOSdtkXsGcu8P3OMxI54DhtKDWKvOWyNqv4Q5bv
         ETPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=SNemw1CHPXvRNtfpgXSs58w9pwqN0NS69vSx7kx33CM=;
        b=zURbSFjACJENZXwVvXb4329hrAIvlw95lZhZr2nP5d6+bPFjKn17xcfBAGM59H/dDM
         /4o64TxPkWgTwwAKyvPREs/nSPWd4YZQxW6vwTyyrMg4jxtrD2KMbg33Ml+K8VKRdn8d
         2vltSA+35yly0+2J3c4sfqflrO3jbJ5vbNzymS55T/1jciE30hzOQXJfKexqWnKlXFkW
         P/EzJ4y6rGCmRpPZWl/ll2ia0JvjdoT6V8HuOgb5rPo62vFa2c2qo95rH89ZThoSX3Ls
         oxVIqMc94FeHaPdatlqcIRgm/HdKL/t5XxPNtPCJaIV/U6rvljzNZIqP+1SxGlXOm1qm
         LEDQ==
X-Gm-Message-State: ACgBeo2l+0A1UOfg8b4Cjuu4rAOvzqcne7jWwC/6gXngBxyUcMg11IIx
        GDN+IRfyUoAxpeKWp8aJU+jp4YJlWHeI1g==
X-Google-Smtp-Source: AA6agR6rCU+0PnFyUrC7fpbsTGZWczKTwvWiLZ87uHJLl7Z9Gz7R5C0iDjw8Z30YDmMD5Ns2HzyoyA==
X-Received: by 2002:a5d:584f:0:b0:21d:bcd6:5c8e with SMTP id i15-20020a5d584f000000b0021dbcd65c8emr13305735wrf.60.1659455192893;
        Tue, 02 Aug 2022 08:46:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003a4c6e67f01sm10599260wmb.6.2022.08.02.08.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:46:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 16/28] submodule--helper: refactor "errmsg_str" to be a "struct strbuf"
Date:   Tue,  2 Aug 2022 17:46:00 +0200
Message-Id: <patch-v2-16.28-d3a7e646adc-20220802T154036Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Refactor code added in e83e3333b57 (submodule: port submodule
subcommand 'summary' from shell to C, 2020-08-13) so that "errmsg" and
"errmsg_str" are folded into one. The distinction between the empty
string and NULL is something that's tested for by
e.g. "t/t7401-submodule-summary.sh".

This is in preparation for fixing a memory leak the "struct strbuf" in
the pre-image.

Let's also pass a "const char *" to print_submodule_summary(), as it
should not be modifying the "errmsg".

Signed-off-by: Glen Choo <chooglen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1391316cde2..5ea308273f4 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -761,7 +761,7 @@ static char *verify_submodule_committish(const char *sm_path,
 	return strbuf_detach(&result, NULL);
 }
 
-static void print_submodule_summary(struct summary_cb *info, char *errmsg,
+static void print_submodule_summary(struct summary_cb *info, const char *errmsg,
 				    int total_commits, const char *displaypath,
 				    const char *src_abbrev, const char *dst_abbrev,
 				    struct module_cb *p)
@@ -819,7 +819,7 @@ static void generate_submodule_summary(struct summary_cb *info,
 {
 	char *displaypath, *src_abbrev = NULL, *dst_abbrev;
 	int missing_src = 0, missing_dst = 0;
-	char *errmsg = NULL;
+	struct strbuf errmsg = STRBUF_INIT;
 	int total_commits = -1;
 
 	if (!info->cached && oideq(&p->oid_dst, null_oid())) {
@@ -920,23 +920,21 @@ static void generate_submodule_summary(struct summary_cb *info,
 		 * submodule, i.e., deleted or changed to blob
 		 */
 		if (S_ISGITLINK(p->mod_dst)) {
-			struct strbuf errmsg_str = STRBUF_INIT;
 			if (missing_src && missing_dst) {
-				strbuf_addf(&errmsg_str, "  Warn: %s doesn't contain commits %s and %s\n",
+				strbuf_addf(&errmsg, "  Warn: %s doesn't contain commits %s and %s\n",
 					    displaypath, oid_to_hex(&p->oid_src),
 					    oid_to_hex(&p->oid_dst));
 			} else {
-				strbuf_addf(&errmsg_str, "  Warn: %s doesn't contain commit %s\n",
+				strbuf_addf(&errmsg, "  Warn: %s doesn't contain commit %s\n",
 					    displaypath, missing_src ?
 					    oid_to_hex(&p->oid_src) :
 					    oid_to_hex(&p->oid_dst));
 			}
-			errmsg = strbuf_detach(&errmsg_str, NULL);
 		}
 	}
 
-	print_submodule_summary(info, errmsg, total_commits,
-				displaypath, src_abbrev,
+	print_submodule_summary(info, errmsg.len ? errmsg.buf : NULL,
+				total_commits, displaypath, src_abbrev,
 				dst_abbrev, p);
 
 	free(displaypath);
-- 
2.37.1.1233.ge8b09efaedc

