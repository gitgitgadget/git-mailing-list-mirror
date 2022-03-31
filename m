Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96875C433FE
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346685AbiCaBOH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352238AbiCaBN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:13:56 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DE666220
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:10 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id h16so13320771wmd.0
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kdaBhXXMkGF4KMt6oVj28aT+7rSY2zHjm+X2Dn8mF88=;
        b=HHH/f3Da4fH3riAjrySCqAjkmlZtH7Q5jJT1ly279fTfmyiYwxMpo/10x+9TPB67ty
         tpUxQfbzBQjgnGzNNayQYChtXeDmhLloW+APJ0t2k3yj2UVpsp4nq55cd6AcyeeFrkxV
         UimBb6CCvmecdbDOsWvatSKfjKSlHEZbE8j6rSbQ115lq7VGev3/HRW4uWRM46AcARav
         ohqvDr/HH+fg/mLWZc2I9hc4LkO4/23LcC+2wo/8aUPsSWYFOidk8s5mgotViyWs/mot
         /4vMchPtIHxsvn3ZHKziC2U3Wq19eZzqCEec7C3kTHWORH2Y8JG+Menwlwm/5OP8ituh
         kKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kdaBhXXMkGF4KMt6oVj28aT+7rSY2zHjm+X2Dn8mF88=;
        b=Fp1xEKB4rjljN2lsgq5VsSPfm5toqRDcwwmh/iG92nsrCVAkf1eG09ClZggh6tnQ7v
         42t18XaYpibTTPnnM5p7aVhywpKZa21CI4iwNoxTDqTSxxosmdg9EFAYEqQmSR1xVmCb
         QBujGID57QbP6V9L2+nhojSNKUAXRJO7JWA02DzhIBjCWQJox16QOFIolpd6k7UYABOS
         4MPrAxG28LZwS6XRFPS3FVe8jVZrm4Z1UzPxzC7bSUPTQ1e8lbdrmWvCpDNhGGmcb6P1
         8idk7k4mtX/ogyiKOI0Q1jkrZXkjRmabqrbWvbERjzlEc6KXXWU4fLnznWNOUXj0hVkp
         mkcA==
X-Gm-Message-State: AOAM532A3xHLTBe7sFpFVMaFAF2dWmCPs8NHHoaipW85H0k3T9loBiFT
        Vec08G0VXU+fwc5ez+hDV2+R6kN0A5JnvA==
X-Google-Smtp-Source: ABdhPJzjcyKmdYKXpLanig3StvvfarizbBynPMzbdqOdpPxR0wKN7HQR97MYu1wSN7vqfviPcM113g==
X-Received: by 2002:a1c:7219:0:b0:38c:a4f8:484f with SMTP id n25-20020a1c7219000000b0038ca4f8484fmr2340250wmc.99.1648689129036;
        Wed, 30 Mar 2022 18:12:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm5789218wmv.31.2022.03.30.18.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:12:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 04/27] format-patch: don't leak "extra_headers" or "ref_message_ids"
Date:   Thu, 31 Mar 2022 03:11:09 +0200
Message-Id: <patch-v4-04.27-69f0aabe38f-20220331T005325Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1557.g4e3e9cdb5e0
In-Reply-To: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com> <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix two memory leaks in "struct rev_info" by freeing that memory in
cmd_format_patch(). These two are unusual special-cases in being in
the "struct rev_info", but not being "owned" by the code in
revision.c. I.e. they're members of the struct so that this code in
"builtin/log.c" can pass information code in log-tree.c.

See 20ff06805c6 (format-patch: resurrect extra headers from config,
2006-06-02) and d1566f7883f (git-format-patch: Make the second and
subsequent mails replies to the first, 2006-07-14) for the initial
introduction of "extra_headers" and "ref_message_ids".

We can count on repo_init_revisions() memset()-ing this data to 0
however, so we can count on it being either NULL or something we
allocated. In the case of "extra_headers" let's add a local "char *"
variable to hold it, to avoid the eventual cast from "const char *"
when we free() it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/log.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 634dc782cce..6f9928fabfe 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1747,6 +1747,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct commit *commit;
 	struct commit **list = NULL;
 	struct rev_info rev;
+	char *to_free = NULL;
 	struct setup_revision_opt s_r_opt;
 	int nr = 0, total, i;
 	int use_stdout = 0;
@@ -1947,7 +1948,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		strbuf_addch(&buf, '\n');
 	}
 
-	rev.extra_headers = strbuf_detach(&buf, NULL);
+	rev.extra_headers = to_free = strbuf_detach(&buf, NULL);
 
 	if (from) {
 		if (split_ident_line(&rev.from_ident, from, strlen(from)))
@@ -2284,6 +2285,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	strbuf_release(&rdiff1);
 	strbuf_release(&rdiff2);
 	strbuf_release(&rdiff_title);
+	free(to_free);
+	if (rev.ref_message_ids)
+		string_list_clear(rev.ref_message_ids, 0);
+	free(rev.ref_message_ids);
 	UNLEAK(rev);
 	return 0;
 }
-- 
2.35.1.1557.g4e3e9cdb5e0

