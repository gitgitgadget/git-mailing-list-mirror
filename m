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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D67C433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 173E9613B5
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbhEFQxm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 12:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbhEFQxm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 12:53:42 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8176C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 09:52:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t18so6358856wry.1
        for <git@vger.kernel.org>; Thu, 06 May 2021 09:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/QqPvbntNNm0mzRCQZCg49nN1oygxHKwZAuEutsaIqc=;
        b=q1Q3+k50MYieelGDgW77va4LR+qhJmcFCx2GmpQTwKO7FqtCTBMCNI/b9x2Yui8+wQ
         bBtbzEyHPwjyj2px14sLkldmV3POfHsHirgwa8l21CWIRnpDVoXTV3RxAl2wh4ZO9hAw
         E/NsiqIXPWbm1uNF42cCKH0jlXLfPPQczwvk2DeR+1cm+tGV2/GpbZPUweoSib7rpAG7
         8Riv2TW6V64HL7LoyqAB3ozwT2x5LcksQTD1pcRqnAiHX6iN/Xs5SIeMqCIRDzmOeGKS
         y7sQRxakl0xf4Fyg+mkcXUmvdJ4QadNh8Pa7MvCnGxg5Zlpf5niNJxYvzURlYidt8Y7p
         rGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/QqPvbntNNm0mzRCQZCg49nN1oygxHKwZAuEutsaIqc=;
        b=hihhWvpaG1IRHqfCV+4MWz4Zu9YNdmIkXAW+rRLwLHEce/qjQEIQ/XUvadoMvEiER/
         F8pECLioHEhABM3e2+HJnIisD/PceXh3+JZ1t3SLb85L5m6npzDl8NubX8+YplLR54Mv
         sJlnXt5IEJ0d1X1gLnNkzDSLxkkpAYe/YawbNSuEH5HGIsDV0vVExR+WYjfVuUeRrzPX
         CHtbEeqxwaCnOi7L/KepO76HQRe27vwRfKJpJcu406zDPYBJ7rugWNpdSu6MqMD+WgBX
         Hf7M95lge7F7DRowazdu1qfw3+ouVDMwsTYacNl0VO4DKr+0wE1CylIkNm/zA2uQEPzP
         PKrQ==
X-Gm-Message-State: AOAM532t1eJiSTX9D1Md+4ZP1/SoRKgaUMMxujtGIH7FCYFx/8n3vaqi
        yU77UbgFhGQ8PMYG9J0yB64=
X-Google-Smtp-Source: ABdhPJzwBuV/lNCxVCgyFUGa4p0hmG0/vYG9fzp1t7IIrdBpLOb8LoFhKEaHpnXxUpS4HScaqb8xng==
X-Received: by 2002:adf:e40f:: with SMTP id g15mr6457732wrm.392.1620319962388;
        Thu, 06 May 2021 09:52:42 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c42006d71140a7638f172.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:6d71:140a:7638:f172])
        by smtp.gmail.com with ESMTPSA id y14sm5354482wrr.82.2021.05.06.09.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 09:52:42 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: [PATCH v1 2/8] format-patch: confirmation whenever patches exist
Date:   Thu,  6 May 2021 18:50:56 +0200
Message-Id: <20210506165102.123739-3-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.450.g14fbf8793d
In-Reply-To: <20210506165102.123739-1-firminmartin24@gmail.com>
References: <20210506165102.123739-1-firminmartin24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, git-format-patch, along with the option --cover-letter,
unconditionaly overwrites a cover letter with the same name (if
present). Although this is a desired behaviour for patches which are
auto-generated from Git commits log, it might not be the case for a
cover letter whose the content is meticulously written manually.

Particulary, this behaviour could be awkward in the following
hypothetical situations:

* The user can easily erase a cover letter coming from prior versions or
  another patch series by reusing an old command line (e.g. autocompleted
  from the shell history).

* Assuming that the user is writing a cover letter and realizes that
  small changes should be made. They make the change, amend and
  format-patch again to regenerate patches. If it happens that they use
  the same command again (e.g. with --cover-letter), the cover letter
  being written is gone.

This patch addresses this issue by asking confirmation from the user
whenever a cover letter or a patch with the same name already exists.

Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
---
 builtin/log.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 6102893fcc..bada3db9eb 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -35,6 +35,7 @@
 #include "repository.h"
 #include "commit-reach.h"
 #include "range-diff.h"
+#include "prompt.h"
 
 #define MAIL_DEFAULT_WRAP 72
 #define COVER_FROM_AUTO_MAX_SUBJECT_LEN 100
@@ -959,6 +960,10 @@ static int open_next_file(struct commit *commit, const char *subject,
 			 struct rev_info *rev, int quiet)
 {
 	struct strbuf filename = STRBUF_INIT;
+	struct strbuf file_exists_prompt = STRBUF_INIT;
+	const char *yesno;
+	static int not_prompted = 1;
+	int res = 0;
 
 	if (output_directory) {
 		strbuf_addstr(&filename, output_directory);
@@ -972,17 +977,35 @@ static int open_next_file(struct commit *commit, const char *subject,
 	else
 		fmt_output_subject(&filename, subject, rev);
 
-	if (!quiet)
-		printf("%s\n", filename.buf + outdir_offset);
+	if (not_prompted && !access(filename.buf, F_OK)) {
+
+		/*
+		 * TRANSLATORS: Make sure to include [Y] and [n] in your
+		 * translation. The program will only accept English input
+		 * at this point.
+		 */
+		strbuf_addf(&file_exists_prompt, _("The file '%s' already exists.\n"
+			"Would you overwrite this file and subsequent ones [Y/n]? "), filename.buf);
+		yesno = git_prompt(file_exists_prompt.buf, PROMPT_ECHO);
+		not_prompted = 0;
+		if (tolower(*yesno) == 'n') {
+			res = -1;
+			goto done;
+		}
+	}
 
 	if ((rev->diffopt.file = fopen(filename.buf, "w")) == NULL) {
 		error_errno(_("cannot open patch file %s"), filename.buf);
-		strbuf_release(&filename);
-		return -1;
+		res = -1;
+		goto done;
 	}
 
+	if (!quiet)
+		printf("%s\n", filename.buf + outdir_offset);
+done:
 	strbuf_release(&filename);
-	return 0;
+	strbuf_release(&file_exists_prompt);
+	return res;
 }
 
 static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
-- 
2.31.1.449.g4a44fa8106

