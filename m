Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7893EC00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237492AbiHBPzK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbiHBPyz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:54:55 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15E11EADB
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:54:54 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j7so18432307wrh.3
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Ch9/wwLaJMTj0eNlDfPLGGpbcP3wq5k0UVNuxPGkCNU=;
        b=gLk9wVeSGGZKgCjjD/UVokw03X/lnRTuJH7ebrWY96vvIA8CvsZacw2dE9+uDOeStK
         Q8tDcAjP7+rZmP5pCbOM/7kgoj2wQYQP6jR+rwjm7cL/68GzlTqG/2zOOPDDaOHE+v9C
         /aPysvJSKhEJt9+FNEmWR3YcKUZRDhyYjMYx5Xs4m8au4QQON3X6bzQUZBeVAM26HqSR
         zR1x86PyR3pCSuwmStGW9YLpZruRzHTFFP7yyX384yKwL6Jj6pdmZBaSsR0YJI44yhb5
         BElcJC0L3p5ZHDoUKKGWVeybLan/Xp6l/lXZVbsru+/q7+v/dC5Cp6dk7/2wt3r7ulMP
         U+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Ch9/wwLaJMTj0eNlDfPLGGpbcP3wq5k0UVNuxPGkCNU=;
        b=Sq84QydO52vz78hEZV31bU+UCVvBPguVLWgY+0d4tL8i3FnTA7I/uyauuwx7p0TsFn
         xD0cnodGNzb10BKG6J7++pNkFLmZ3tnaCNB3yj6qVVsXFZMjSLfYovqec89nySqtNGnm
         VpspirpJ38FUjatmHIuKc94EQyxSZFoUrpQ8HIlmBbZFJ3X9aBff89bc9auAyHLOlWoA
         bNnsfpzBwRGMKiOcpL6FS/2p7xyLQ3P8It40Vhp3l4vWQdp9sFmxu+ey1C5tbEybVG5D
         iXBAWEZIP0CaGH4Th12mm7k4UciAbpCrhntTO/KHgwdDjdgl8geiKpoFNSOYk4w7X//i
         alyQ==
X-Gm-Message-State: ACgBeo0NNMc3x/KgmUkVv26HJL2V2lOd3ZDit26MJhdEXvgHYdSulpjB
        FJ1qq6IJO7U9wRLSO2WH+z+KK5oskjeuFw==
X-Google-Smtp-Source: AA6agR7J/d/hBC/8Nv4ZAu+ioKfKEgsYhFrK7rxTbH+gbywxnuU2QhIdPQ//L3M803K/CBLlPDKKhA==
X-Received: by 2002:adf:ebc5:0:b0:21d:640e:dc2f with SMTP id v5-20020adfebc5000000b0021d640edc2fmr13546893wrn.227.1659455693178;
        Tue, 02 Aug 2022 08:54:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg3-20020a05600c3c8300b003a327b98c0asm23562286wmb.22.2022.08.02.08.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:54:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 08/17] submodule--helper: fix "sm_path" and other "module_cb_list" leaks
Date:   Tue,  2 Aug 2022 17:54:32 +0200
Message-Id: <patch-v5-08.17-3c4f734e958-20220802T155002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com> <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix leaks in "struct module_cb_list" and the "struct module_cb" which
it contains, these fixes leaks in e83e3333b57 (submodule: port
submodule subcommand 'summary' from shell to C, 2020-08-13).

The "sm_path" should always have been a "char *", not a "const
char *", we always create it with xstrdup().

We can't mark any tests passing passing with SANITIZE=leak using
"TEST_PASSES_SANITIZE_LEAK=true" as a result of this change, but
"t7401-submodule-summary.sh" gets closer to passing as a result of
this change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 68bf0f9178f..f332627d19e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -755,16 +755,34 @@ struct module_cb {
 	struct object_id oid_src;
 	struct object_id oid_dst;
 	char status;
-	const char *sm_path;
+	char *sm_path;
 };
 #define MODULE_CB_INIT { 0 }
 
+static void module_cb_release(struct module_cb *mcb)
+{
+	free(mcb->sm_path);
+}
+
 struct module_cb_list {
 	struct module_cb **entries;
 	int alloc, nr;
 };
 #define MODULE_CB_LIST_INIT { 0 }
 
+static void module_cb_list_release(struct module_cb_list *mcbl)
+{
+	int i;
+
+	for (i = 0; i < mcbl->nr; i++) {
+		struct module_cb *mcb = mcbl->entries[i];
+
+		module_cb_release(mcb);
+		free(mcb);
+	}
+	free(mcbl->entries);
+}
+
 struct summary_cb {
 	int argc;
 	const char **argv;
@@ -1108,6 +1126,7 @@ static int compute_summary_module_list(struct object_id *head_oid,
 cleanup:
 	strvec_clear(&diff_args);
 	release_revisions(&rev);
+	module_cb_list_release(&list);
 	return ret;
 }
 
-- 
2.37.1.1233.ge8b09efaedc

