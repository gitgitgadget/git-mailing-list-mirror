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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FDBC2D0CF
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A8524658
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eie6R3hy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfLMIIa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:08:30 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53852 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfLMIIY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 03:08:24 -0500
Received: by mail-wm1-f68.google.com with SMTP id w8so2041571wmd.3
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 00:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+6YxCnqxGRVtpNgz0NtAVbo5UDhh4Edtk1YCNEAvYcg=;
        b=Eie6R3hycoe0qYQt1/VfhUEDit9U/ft4JQNcwui2iHxKDT9lK3RjpCb65rgg7jyrB4
         wutIQlNP8ZTeN43HYQykoflyThQTz5JAurNkor3p115yrzs9QMqrkXmHv+13EtTvMANt
         OhfOyTNWRLiD1L8KJrIHgbn0oasDmrwypK1jsUqjhILRoQ8Z4TrzgQ7tMlqbTJYx9BRy
         FOl49XxUUQFpNa+9vwL1jsMlrsiOY3yBu0KKBcTqFPVSmW/3+wtJX16lg7WacSNW3Spk
         w/TXutgoV3LqYuQ5jEFXbWIPeb7GP/+mVM0oBKUCrDHYs4V9Lt15+Nc78vSrV9xWh10e
         VXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+6YxCnqxGRVtpNgz0NtAVbo5UDhh4Edtk1YCNEAvYcg=;
        b=syaBwcx4g4lx6EGrNU3Y1vOU6j67XE+Kni5J/I0AnIS4t0XikT9IT78EwoZf9gBBEN
         F2ujPzKYkf73LavkcLdjr6y3G9xGOfvmIOG5CQe37IBV++V5OZB/rsAiQkNfnE2AVBgH
         2m2FuJ+DVuD2qhdPTi9I7XqUdIlPDXGY/032F21wmbi62T4kZRnxrkZdb9UVJZ7wEgN5
         Nk1meVKsmjLqoxkntd1kBWGA180aQC+RHd4LiPCVTHOWe6xIzMHvFkUz0fJkK5B6nJdx
         m4jAhKOWuVNUcRydHhaEn5GpHXcNoJDr84urKir1hN0jqAodLxPbacGhJSt2lPFGXbAu
         TbJA==
X-Gm-Message-State: APjAAAWfBMns1rRgku/PvbNwjXXvkcDwMx/jT1KqBeKwjFMaEQ+DW0bT
        uo1om8zYGm0R5kkg3x9em0U1O/VM
X-Google-Smtp-Source: APXvYqyAzA0ugcAEcKltry74VOQegqJExO/egV9s8TDEt8aXcjTQVCtzQwkjoeEJoQMbDGjhLEBtnw==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr11393153wmk.124.1576224502164;
        Fri, 13 Dec 2019 00:08:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f5sm9226206wmh.12.2019.12.13.00.08.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 00:08:21 -0800 (PST)
Message-Id: <0c95067fb3aba3c13afe0976d52cb092903d3a9f.1576224486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.173.git.1576224486.gitgitgadget@gmail.com>
References: <pull.173.git.1576224486.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Dec 2019 08:08:05 +0000
Subject: [PATCH 18/19] built-in add -p: only show the applicable parts of the
 help text
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

When displaying the only hunk in a file's diff, the prompt already
excludes the commands to navigate to the previous/next hunk.

Let's also let the `?` command show only the help lines corresponding to
the commands that are displayed in the prompt.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 5e9829a8b4..1eb0ab97bb 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1008,8 +1008,10 @@ N_("y - stage this hunk\n"
    "n - do not stage this hunk\n"
    "q - quit; do not stage this hunk or any of the remaining ones\n"
    "a - stage this and all the remaining hunks\n"
-   "d - do not stage this hunk nor any of the remaining hunks\n"
-   "j - leave this hunk undecided, see next undecided hunk\n"
+   "d - do not stage this hunk nor any of the remaining hunks\n");
+
+static const char help_patch_remainder[] =
+N_("j - leave this hunk undecided, see next undecided hunk\n"
    "J - leave this hunk undecided, see next hunk\n"
    "k - leave this hunk undecided, see previous undecided hunk\n"
    "K - leave this hunk undecided, see previous hunk\n"
@@ -1246,9 +1248,31 @@ static int patch_update_file(struct add_p_state *s,
 				hunk->use = USE_HUNK;
 				goto soft_increment;
 			}
-		} else
-			color_fprintf(stdout, s->s.help_color,
+		} else {
+			const char *p = _(help_patch_remainder), *eol = p;
+
+			color_fprintf(stdout, s->s.help_color, "%s",
 				      _(help_patch_text));
+
+			/*
+			 * Show only those lines of the remainder that are
+			 * actually applicable with the current hunk.
+			 */
+			for (; *p; p = eol + (*eol == '\n')) {
+				eol = strchrnul(p, '\n');
+
+				/*
+				 * `s->buf` still contains the part of the
+				 * commands shown in the prompt that are not
+				 * always available.
+				 */
+				if (*p != '?' && !strchr(s->buf.buf, *p))
+					continue;
+
+				color_fprintf_ln(stdout, s->s.help_color,
+						 "%.*s", (int)(eol - p), p);
+			}
+		}
 	}
 
 	/* Any hunk to be used? */
-- 
gitgitgadget

