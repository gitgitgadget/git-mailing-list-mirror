Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F738C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 13:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbiGMNQn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbiGMNQg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 09:16:36 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50958A191
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:16:34 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r127-20020a1c4485000000b003a2fb7c1274so739084wma.1
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tQmzShT7Je3PaWIUEp8jdQdwVx8CAAGRUYVGVw/PTrE=;
        b=IIRCOJyMismLL5jBn5TKRaKlKkvstLsz+JTwqW4pPYgp4pGiC+4WnkwA6itZ+rAr82
         ie6m+NXrUzE2ZTRnxABUk15JoUt39VdlD/qo8d4v3QFsw6l8NXOM1yhFPM8xFo6y++yg
         z7Zq91aAza02fXNeYgBoIDD92GH4ezPYRVaEFb8iVzDc84CcPFvHSQNBY1B4c9XHnv0o
         Ls25kMO+5oQa8yLUnqsaSnw7vIasyGfs4c64kqH0RYWr6ugW23iHQOtSB0/efzASKi7G
         OnZrloGttF1A6wkUM1WYFDLqp+7SUHTu7ieuCgSHBtgTWMNRguv6cBCqF7FJbvHUJ6yS
         or/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tQmzShT7Je3PaWIUEp8jdQdwVx8CAAGRUYVGVw/PTrE=;
        b=q7eROYLJM8Qz7/s5+Q/zdnUMt6brVsNJjmZOF4w6t+inKthWU55qCshlJH8Aq3hQsv
         qvsJcduwN3gp49M5rL+wq8KgCKkIGVCrDOWxkqZ7WcxuEg37r0B2NmIpvg75rU0IOw/J
         D0vvxyD786VNmetG+9Mch4p5nRmlIeXlxm9cLqqoWcpDgwmy570/49KhMTTTDFL7xG1/
         kFPJ6ie1O1L1Z8cPB+cmU9XwmwcTFlV+yyc1rv2wcMrGGOqI+YVJpoxIpdGvyJYbXGYe
         DqgBhxItyF3HPkJKHmAj1IK0XypFHRNCBr0nZjOQE5dt+7gg8JG6cfBpAwf5HnRP5+Eu
         9Yyg==
X-Gm-Message-State: AJIora9wUwPgZusYLSniLyrxJIu7o4dU1O3BlZRXIthpyBxCSX7qjqma
        crDqrFofGKSyLzJ383txvOmk2dVXBZXRlw==
X-Google-Smtp-Source: AGRyM1u37LBI8LZIIW3v7uBUdx2chRfAesbBQ0ujO1CY6wrQALAU6cz//dkwkb5M5TXieEPOTDVfwA==
X-Received: by 2002:a7b:cc82:0:b0:3a2:f0c8:c5d4 with SMTP id p2-20020a7bcc82000000b003a2f0c8c5d4mr3673467wma.86.1657718192377;
        Wed, 13 Jul 2022 06:16:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t63-20020a1c4642000000b003a2e05a81b3sm2216352wma.8.2022.07.13.06.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:16:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/11] submodule--helper: fix "errmsg_str" memory leak
Date:   Wed, 13 Jul 2022 15:16:12 +0200
Message-Id: <patch-07.11-f8c20bbf266-20220713T131601Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.932.g7b7031e73bc
In-Reply-To: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak introduced in e83e3333b57 (submodule: port submodule
subcommand 'summary' from shell to C, 2020-08-13), to do that stop
juggling around the "errmsg" and "struct strbuf", let's instead move
the "struct strbuf errmsg" to the top-level.

Now we don't need to strbuf_detach() it anymore, but we do need to
ensure that we pass NULL to print_submodule_summary() when we have no
error message.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a964dbeec38..a05578a7382 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -932,7 +932,8 @@ static void generate_submodule_summary(struct summary_cb *info,
 {
 	char *displaypath, *src_abbrev = NULL, *dst_abbrev;
 	int missing_src = 0, missing_dst = 0;
-	char *errmsg = NULL;
+	char *errmsg;
+	struct strbuf errmsg_str = STRBUF_INIT;
 	int total_commits = -1;
 
 	if (!info->cached && oideq(&p->oid_dst, null_oid())) {
@@ -1032,7 +1033,6 @@ static void generate_submodule_summary(struct summary_cb *info,
 		 * submodule, i.e., deleted or changed to blob
 		 */
 		if (S_ISGITLINK(p->mod_dst)) {
-			struct strbuf errmsg_str = STRBUF_INIT;
 			if (missing_src && missing_dst) {
 				strbuf_addf(&errmsg_str, "  Warn: %s doesn't contain commits %s and %s\n",
 					    displaypath, oid_to_hex(&p->oid_src),
@@ -1043,10 +1043,10 @@ static void generate_submodule_summary(struct summary_cb *info,
 					    oid_to_hex(&p->oid_src) :
 					    oid_to_hex(&p->oid_dst));
 			}
-			errmsg = strbuf_detach(&errmsg_str, NULL);
 		}
 	}
 
+	errmsg = errmsg_str.len ? errmsg_str.buf : NULL;
 	print_submodule_summary(info, errmsg, total_commits,
 				displaypath, src_abbrev,
 				dst_abbrev, p);
@@ -1054,6 +1054,7 @@ static void generate_submodule_summary(struct summary_cb *info,
 	free(displaypath);
 	free(src_abbrev);
 	free(dst_abbrev);
+	strbuf_release(&errmsg_str);
 }
 
 static void prepare_submodule_summary(struct summary_cb *info,
-- 
2.37.0.932.g7b7031e73bc

