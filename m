Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A763C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 20:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240243AbiGSUrt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 16:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238833AbiGSUri (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 16:47:38 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4641752E40
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:35 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bk26so23336704wrb.11
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nQZimnuy0637xVpQ8BffPFqCk9VMSEeqOzu+nsC74TI=;
        b=Qhg9kYi3esSNqa8scb5jrCRXsIpgo7Iys0DHMJ7GxfVhpFX8BJuCKKyXiDFxCgZfLi
         HzJk85Xz4O1uPOPfCOyXxJsYdueVdIJAqxtq1C6bl9Y8c09QE1Xmv8kme+fgOrx3oxcD
         +r5D8ZluXVvZ1PxU6AhoxGlzU2wOTP+tl0ADb8DOn3D4InRN51kWnHx/Vy7NhQrEs/YS
         6hAAovSA/k/4ej2qAdd8oX2H24gTu06VhoJ035yGDkL3Fn36F26yitG3gD0vC/L8YSW2
         PY/VQJ3AKIjPQiCkF9APxngZ5qW7s29qCxQtcAqinMoOnxm/iX0PYKDlMB5YicKSG/PV
         QOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nQZimnuy0637xVpQ8BffPFqCk9VMSEeqOzu+nsC74TI=;
        b=U0XbimTb9xClgv6WxtCaTCQM6BOo4nVeVITvb5eN1n6RZ9L9EPdybeH7PrOeOlkvi5
         LrvBEhGBA/ifNlc730ayCh6uj6HkLi6HCqYOJ59F/0DDawnXFjlsyVa8Ij7+UysNQivS
         kaM7ShrkxDeyQWWl5e/XfxhJ3gck+A8+Xzda1r49hp47Oq7jv8o6fzO5dySRFPMyhwbl
         YSRZ1T8tSRL31U5fYljMf5WUFM+ZVpGITkrrbuKyXPZruxlhc7z/p+AZRo81zAdZh25Y
         d51SZywGcoBDQ/IAc8IsLOhbbnwOIH//9FZWfRkLpSUlOVn+tuvUt2FCvdK2ct78xjj/
         yHug==
X-Gm-Message-State: AJIora8sdZYLSGDWdkkb1mNiwy1ItS6w0To1v05XAWr/PYEY88wQOqJV
        9+BmQwIXpB0EH2OCBQi+oJ1MaHpslFFchA==
X-Google-Smtp-Source: AGRyM1skGqO81N/9NzAlSxTBtSx8gtMZMZhCUajeSr+8tZ6WCX4SFwZJBcxzXBZo/kayJmopyUBD5g==
X-Received: by 2002:adf:ed10:0:b0:21d:a9a1:3526 with SMTP id a16-20020adfed10000000b0021da9a13526mr28037058wro.403.1658263653545;
        Tue, 19 Jul 2022 13:47:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm4711348wms.3.2022.07.19.13.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:47:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/24] submodule--helper: refactor "errmsg_str" to be a "struct strbuf"
Date:   Tue, 19 Jul 2022 22:47:00 +0200
Message-Id: <patch-v2-09.24-92737916083-20220719T204458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1062.g385eac7fccf
In-Reply-To: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com> <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
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
index 5d26e188560..c5127c1d50e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -874,7 +874,7 @@ static char *verify_submodule_committish(const char *sm_path,
 	return strbuf_detach(&result, NULL);
 }
 
-static void print_submodule_summary(struct summary_cb *info, char *errmsg,
+static void print_submodule_summary(struct summary_cb *info, const char *errmsg,
 				    int total_commits, const char *displaypath,
 				    const char *src_abbrev, const char *dst_abbrev,
 				    struct module_cb *p)
@@ -932,7 +932,7 @@ static void generate_submodule_summary(struct summary_cb *info,
 {
 	char *displaypath, *src_abbrev = NULL, *dst_abbrev;
 	int missing_src = 0, missing_dst = 0;
-	char *errmsg = NULL;
+	struct strbuf errmsg = STRBUF_INIT;
 	int total_commits = -1;
 
 	if (!info->cached && oideq(&p->oid_dst, null_oid())) {
@@ -1032,23 +1032,21 @@ static void generate_submodule_summary(struct summary_cb *info,
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
2.37.1.1062.g385eac7fccf

