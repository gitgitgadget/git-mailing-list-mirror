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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61666C2D0D1
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379E322527
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+LDbozH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfLMIIh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:08:37 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34232 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfLMIIX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 03:08:23 -0500
Received: by mail-wm1-f66.google.com with SMTP id f4so5381320wmj.1
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 00:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9ZaireUYGoeKPqHNrCW7PIQGFdgOF8wXarhdIAoI8HY=;
        b=J+LDbozH1WJw6Q+qO+kgOsjfgmc30cuVSsUhmfqZG2RoUHYJOCHG/LGvFjgWOfs+od
         nbyw3Y0+a3ibluQFfkM14YRle1FWRqSkTRj+woK35kW96SY/ctyObFbd3buk81+/xnc8
         C/8aIkJeVV4HStrp7MeaCZ89y+JVBG1MQnO1bHKje8efLx0tq0zk1ALY25jSNGo4bwye
         9XRHVipaAnI9QXpcLs+2UTg99cLppp/ZSqQzXI406IxrlOatcgX9F+OjjbIYJbT/lNh4
         g1YaySBx9fB7zkg35FX36tJzROs8p1xbyzwZg5g/jlJPnsaxAjoI/qc6X19xtI23zRPw
         FV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9ZaireUYGoeKPqHNrCW7PIQGFdgOF8wXarhdIAoI8HY=;
        b=Dqt1Qecdc1MFPpDZJV64TJYbNbeUvQWaSkj/hgqDMAAaGSpZr946orLmCRfZX0Chd7
         k/nf4+SbqmRHa5CJBYQrdotqbLHp/NeEefVGzWFkaAbzeMBWFGicEmD14WTTVvhLK2jh
         ZzSwa1B9NNLWFAnQkHVzLBU63GbSCPYHff1X3pgTm0kAVPjAUTK1gmPcekLMszk+/zhN
         qQ3lsFi4JaOKnLhPQtpsEKQFo/7tgcY4VtH+yYRtM2SnC77YqKwC3zUQcJ67LknTvJv6
         hVVtRWTS1d3/nIFbRakHmBUrK1IY1JPuVgYPhsAjU6G0uRlfGS0HmA96r5lkLaEuddq7
         mE5Q==
X-Gm-Message-State: APjAAAX7K5NGiQLb9QzwHRL+oQcHFjt1QcIeY5rVjTbQu0UozJ4Fd/Vi
        s6gowW5X6dOKuDUuqhWUugYiEEeO
X-Google-Smtp-Source: APXvYqwTvQnoyQdYQo8TVe/HfUl6b3VQqNoI2KEdfaYsrS2sY9Isko8BWw1rogZzGOOeAuIpvPD68A==
X-Received: by 2002:a1c:cc11:: with SMTP id h17mr9151699wmb.19.1576224501478;
        Fri, 13 Dec 2019 00:08:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k16sm9461531wru.0.2019.12.13.00.08.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 00:08:20 -0800 (PST)
Message-Id: <6c33fbb68453707c874fde14347ce368b555c449.1576224486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.173.git.1576224486.gitgitgadget@gmail.com>
References: <pull.173.git.1576224486.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Dec 2019 08:08:04 +0000
Subject: [PATCH 17/19] built-in add -p: implement the 'q' ("quit") command
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

This command is actually very similar to the 'd' ("do not stage this
hunk or any of the later hunks in the file") command: it just does
something on top, namely leave the loop and return a value indicating
that we're quittin'.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index fd72850c65..5e9829a8b4 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -12,9 +12,9 @@ enum prompt_mode_type {
 };
 
 static const char *prompt_mode[] = {
-	N_("Stage mode change [y,n,a,d%s,?]? "),
-	N_("Stage deletion [y,n,a,d%s,?]? "),
-	N_("Stage this hunk [y,n,a,d%s,?]? ")
+	N_("Stage mode change [y,n,a,q,d%s,?]? "),
+	N_("Stage deletion [y,n,a,q,d%s,?]? "),
+	N_("Stage this hunk [y,n,a,q,d%s,?]? ")
 };
 
 struct hunk_header {
@@ -1006,6 +1006,7 @@ static size_t display_hunks(struct add_p_state *s,
 static const char help_patch_text[] =
 N_("y - stage this hunk\n"
    "n - do not stage this hunk\n"
+   "q - quit; do not stage this hunk or any of the remaining ones\n"
    "a - stage this and all the remaining hunks\n"
    "d - do not stage this hunk nor any of the remaining hunks\n"
    "j - leave this hunk undecided, see next undecided hunk\n"
@@ -1026,7 +1027,7 @@ static int patch_update_file(struct add_p_state *s,
 	struct hunk *hunk;
 	char ch;
 	struct child_process cp = CHILD_PROCESS_INIT;
-	int colored = !!s->colored.len;
+	int colored = !!s->colored.len, quit = 0;
 	enum prompt_mode_type prompt_mode_type;
 
 	if (!file_diff->hunk_nr)
@@ -1115,12 +1116,16 @@ static int patch_update_file(struct add_p_state *s,
 				if (hunk->use == UNDECIDED_HUNK)
 					hunk->use = USE_HUNK;
 			}
-		} else if (ch == 'd') {
+		} else if (ch == 'd' || ch == 'q') {
 			for (; hunk_index < file_diff->hunk_nr; hunk_index++) {
 				hunk = file_diff->hunk + hunk_index;
 				if (hunk->use == UNDECIDED_HUNK)
 					hunk->use = SKIP_HUNK;
 			}
+			if (ch == 'q') {
+				quit = 1;
+				break;
+			}
 		} else if (s->answer.buf[0] == 'K') {
 			if (hunk_index)
 				hunk_index--;
@@ -1267,7 +1272,7 @@ static int patch_update_file(struct add_p_state *s,
 	}
 
 	putchar('\n');
-	return 0;
+	return quit;
 }
 
 int run_add_p(struct repository *r, const struct pathspec *ps)
-- 
gitgitgadget

