Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3F7C00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 13:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiHUN7Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 09:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiHUN6z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:58:55 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347E72315C
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:43 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e20so9798867wri.13
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Fm9382WO8O47G+FM+UhOtgrneE9PPBtHqtMqreYeSPs=;
        b=aiq0i3gaOeqX/JDPD0MSTeBUN1/YyM9wF+Ea3L/bzQx7HvO2YRbXwCj7zxNKYU7zgv
         hvj2IB/26bCjmax1xniI7JuM3KrvVSTntZyeKe6S+cK2nsUaDVH6tkEajHBI0rKyg4MM
         bTMsTsdSqn9OHVhUTiwy1j7pULOIVMxgKInLrEwhVtVHzbtP5C9QcT8P9h/a1/zxZpq6
         BZfmuftO+KVzUQdQM/dy5cLhvaSDyPHpxtRjj6ViNSj/5sphn+ZNWRAdpa9svijAjJS8
         DE7j3RcHlL+jk5apGd2QPL/KE7ZBKDNuLEBTcPubdCFP/+sUA5Ba/cWND97q/tK4qpqL
         pGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Fm9382WO8O47G+FM+UhOtgrneE9PPBtHqtMqreYeSPs=;
        b=nOBw9B2UhJWFpUG8DS8I/fcZezXhPS/fzJhx7wV48OLJTemcZSPbwV1FDh6Hm4CUsg
         JnAB8yMtbP69qDa1vu3nzJyY9i7lfeGV9mX/0Vo5HRetBaBG/SMl9avg/Y0yNYzYbIZr
         4FdPKbRuTHBJsQz8IAOk82SGvieE8k8X6o9+8+nVYwNAz6W/AsIGlsbyvNdFA2PrcOYv
         iSruVbJInWRnEKiSUCmPxsXTYLYAaNxr6EGI4sCWu5+PhCuunTKOrsSqi4mTM4Wv0MKK
         Eu0T33jneR38337HFQATxopLl+mBLjWAPZn2ficEZ4J7RkHupUcY+kNx4Ph7mhOtnbqD
         dKig==
X-Gm-Message-State: ACgBeo1ANol5Um+lyHjVpG6U6vmvbNgRQStfCJSlQ9eJAaQdfhShEp4+
        fNOKxtGki0pSKpx1CddygFWF+fI+C/b2AyBC
X-Google-Smtp-Source: AA6agR5LiiipKcMhJGIRyIBaxbdhhE2Q6TuUCZDkmcJ+GmaxtSL9K3jDG5eUX5ljb5yPCQmOawjBaw==
X-Received: by 2002:a5d:6da5:0:b0:222:4634:6a4e with SMTP id u5-20020a5d6da5000000b0022246346a4emr8787348wrs.172.1661090321868;
        Sun, 21 Aug 2022 06:58:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 16/32] submodule--helper: refactor "errmsg_str" to be a "struct strbuf"
Date:   Sun, 21 Aug 2022 15:57:25 +0200
Message-Id: <patch-v3-16.32-ab0fd2c60f0-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
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
index 829a57ce8a9..a694b18b55e 100644
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
2.37.2.1279.g64dec4e13cf

