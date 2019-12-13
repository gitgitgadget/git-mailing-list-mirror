Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE19C2D0CC
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3333824658
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrQVCFhb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfLMIIV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:08:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40105 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfLMIIS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 03:08:18 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so5521963wmi.5
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 00:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JSOKuOixMMAiWFnOLJKv9BBGlVka3bCAxtf42Rkumss=;
        b=WrQVCFhbHsCzehdenZ/NGrogRjHjAZ27b+Cue/USRV1YhnlAe0/HvFSGg82jMI7R36
         PoHIjPFizgEAEuqvp0YsjI8g7ONNSGqdLJ/KkUXdwyPHd6fACXaAJQL1ryUSb0LmEfkq
         2rWxh9ovn9Uv/NC48DA9whSxlupDugiXFtVcvXmJgAaOn0Zu7y33tuqPHZvKF3yMMwGK
         a10TSUtKpSUk0bV61R4PrJpYo0Co5fWZK7YyNhPT/6qH8pQdLfRL/AFUvItovKOEuQCO
         z7M2I42N74RMHfuMlitb6N+Ua5kJUTeELbbiXVov8/Tvsp3QbPXV6e7YcA0mJMzSqpXo
         d3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JSOKuOixMMAiWFnOLJKv9BBGlVka3bCAxtf42Rkumss=;
        b=ckgLldynYhjMbV4G+S+6uAF7zkgSEwVBdFvZV2qg6f9dgqLUzNsURiwNEeaRWBB8Ma
         wFxoPIrO6ZbP0v879PC2uVAm6VbBR8PQ9rTpAtWbkqHhP82nD/cmkpX93Ddfr18pA1VF
         wBsuzPdil5VpP0fNwIAUvaMv4h+1AovvbnP2H6wPljT583JcO0PPWNmSCGiD46vH4XRt
         ruF4zyyOZnbwITa98f1qXjleDwlluue5ZwSus21W/HV0H4vfAwo72dHLiV7Czp0dCJI9
         yhl5elYw7Nhy4gB0cTa9N1xGrNdiyOX5KjzcAlYCVNDMMLZVDrK79X7EQ6QhEjAkxTHN
         ppOw==
X-Gm-Message-State: APjAAAWtK7n+Ccl27/htKV9IDY3IwRn0ab1AX6SWtWoepvGEgsczktl3
        j4OlexP2+bUKOXG9dFlw9yWT79sW
X-Google-Smtp-Source: APXvYqwTaBI4m8XMQEcp0Cv6oOZatOIs5v8PjzlCuhlprshU9QQRjV2D9oJcK0gOlQCpNcn8x5RmCQ==
X-Received: by 2002:a7b:c389:: with SMTP id s9mr11787174wmj.7.1576224495909;
        Fri, 13 Dec 2019 00:08:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e16sm8863503wrs.73.2019.12.13.00.08.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 00:08:15 -0800 (PST)
Message-Id: <8d588896603e560b82f37e1924dd012a63df6d95.1576224486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.173.git.1576224486.gitgitgadget@gmail.com>
References: <pull.173.git.1576224486.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Dec 2019 08:07:57 +0000
Subject: [PATCH 10/19] built-in add -p: show different prompts for mode
 changes and deletions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Just like the Perl version, we now helpfully ask the user whether they
want to stage a mode change, or a deletion.

Note that we define the prompts in an array, in preparation for a later
patch that changes those prompts to yet different versions for `git
reset -p`, `git stash -p` and `git checkout -p` (which all call the `git
add -p` machinery to do the actual work).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 2007f55e04..171025b08d 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -7,6 +7,16 @@
 #include "color.h"
 #include "diff.h"
 
+enum prompt_mode_type {
+	PROMPT_MODE_CHANGE = 0, PROMPT_DELETION, PROMPT_HUNK
+};
+
+static const char *prompt_mode[] = {
+	N_("Stage mode change [y,n,a,d%s,?]? "),
+	N_("Stage deletion [y,n,a,d%s,?]? "),
+	N_("Stage this hunk [y,n,a,d%s,?]? ")
+};
+
 struct hunk_header {
 	unsigned long old_offset, old_count, new_offset, new_count;
 	/*
@@ -422,6 +432,7 @@ static int patch_update_file(struct add_p_state *s,
 	char ch;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	int colored = !!s->colored.len;
+	enum prompt_mode_type prompt_mode_type;
 
 	if (!file_diff->hunk_nr)
 		return 0;
@@ -466,13 +477,20 @@ static int patch_update_file(struct add_p_state *s,
 			strbuf_addstr(&s->buf, ",j");
 		if (hunk_index + 1 < file_diff->hunk_nr)
 			strbuf_addstr(&s->buf, ",J");
+
+		if (file_diff->deleted)
+			prompt_mode_type = PROMPT_DELETION;
+		else if (file_diff->mode_change && !hunk_index)
+			prompt_mode_type = PROMPT_MODE_CHANGE;
+		else
+			prompt_mode_type = PROMPT_HUNK;
+
 		color_fprintf(stdout, s->s.prompt_color,
 			      "(%"PRIuMAX"/%"PRIuMAX") ",
 			      (uintmax_t)hunk_index + 1,
 			      (uintmax_t)file_diff->hunk_nr);
 		color_fprintf(stdout, s->s.prompt_color,
-			      _("Stage this hunk [y,n,a,d%s,?]? "),
-			      s->buf.buf);
+			      _(prompt_mode[prompt_mode_type]), s->buf.buf);
 		fflush(stdout);
 		if (strbuf_getline(&s->answer, stdin) == EOF)
 			break;
-- 
gitgitgadget

