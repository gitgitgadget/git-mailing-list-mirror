Return-Path: <SRS0=rBju=ZV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79052C432C0
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 21:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C307217BC
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 21:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvlINT5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfK2VMB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Nov 2019 16:12:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44712 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfK2VL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Nov 2019 16:11:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id q10so520651wrm.11
        for <git@vger.kernel.org>; Fri, 29 Nov 2019 13:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=g87CF7/Qpre3A72OJO2s2/kIpf0ERgQ6D89szR27gjc=;
        b=kvlINT5eUTweoR2K3asOOVQYsilxkDqI/v6xmSB6s8gO4VK3rpO2l9nX361Zyyg9aX
         2ALiJPN9+CROXPEzdN5OhtOD8jd4PMaHAQkC7UMRUpO/pcebmdcJIgeTmkJGUL6mCT16
         H/plCW/JdBwfntwfG2+q2FL42huY0xVjBEY3GkHdDeABwsxy84XUWdS96NiMBk9tRXCV
         7KnU383GssFWxh+xvKrPOJ5rGQ50ZAexmO4VNwY16wf2BAEqhjeHt35x6SeA/fRzDDXz
         Pj1S2/fcRIEuZ7VE78s1MHTzGBIesMZ0IFw3i+0uBc/xaeUClkIMTDdi1CjH5apxjjJv
         DsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=g87CF7/Qpre3A72OJO2s2/kIpf0ERgQ6D89szR27gjc=;
        b=HSOhB+WkpcmxEdJyV2ghTIu4Lv3lpNXdXFo3CgxxaSiJzd9621eon6a9PC0DyymVvg
         2uuWUYN9J5va6anlSS+UXeJe3qVcXCVEW4d+Hlylgv8dCuPqYu8AAJ71CWhTwno/9QdX
         +1pyy8Z216Owvy0OyrgluQAGjJgAiw7eortvYhAZHIA751WU80wWKB86RblTYPKxJI8m
         3DcUZgrw2nInTaIzk9vFYbM4k/sIQxL8yy/O+4p5XIhe6DSV7tiCcffK41V0XEbNE6/P
         DKrbFDVPKQIhnNLkVovtV4NSebr1GoUPNbFiHkXdqzSNF34qj4l2tmV+zKIAHWsPVhgg
         iiyA==
X-Gm-Message-State: APjAAAXyySONMCfwwjQsf3q83xmspyohTkz+R2ui/KK0U5mAC34XIEcU
        NNqcB5A7dTSNuWbLlGmjopj94J5K
X-Google-Smtp-Source: APXvYqwTurzo1iBuutThEmPYr/4ep1n45QPUcp1Vrj19OrpFQMU6t4yQNNf2YPeMaHlLJ+u0ttfQEA==
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr3617885wrn.75.1575061917643;
        Fri, 29 Nov 2019 13:11:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm16219178wrw.36.2019.11.29.13.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Nov 2019 13:11:57 -0800 (PST)
Message-Id: <5ba6cd31ab5bba6828f4e195ebd17de9c0758ba7.1575061909.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.171.v2.git.1575061909.gitgitgadget@gmail.com>
References: <pull.171.git.1573821382.gitgitgadget@gmail.com>
        <pull.171.v2.git.1575061909.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Nov 2019 21:11:49 +0000
Subject: [PATCH v2 9/9] built-in add -i: offer the `quit` command
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

We do not really want to `exit()` here, of course, as this is safely
libified code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 4d7d44a917..f395d54c08 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -1071,6 +1071,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 		{ "add untracked", run_add_untracked },
 		{ "patch", run_patch },
 		{ "diff", run_diff },
+		{ "quit", NULL },
 		{ "help", run_help },
 	};
 	struct prefix_item_list commands = PREFIX_ITEM_LIST_INIT;
@@ -1122,17 +1123,22 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 	res = run_status(&s, ps, &files, &opts);
 
 	for (;;) {
+		struct command_item *util;
+
 		i = list_and_choose(&s, &commands, &main_loop_opts);
-		if (i == LIST_AND_CHOOSE_QUIT) {
+		if (i < 0 || i >= commands.items.nr)
+			util = NULL;
+		else
+			util = commands.items.items[i].util;
+
+		if (i == LIST_AND_CHOOSE_QUIT || (util && !util->command)) {
 			printf(_("Bye.\n"));
 			res = 0;
 			break;
 		}
-		if (i != LIST_AND_CHOOSE_ERROR) {
-			struct command_item *util =
-				commands.items.items[i].util;
+
+		if (util)
 			res = util->command(&s, ps, &files, &opts);
-		}
 	}
 
 	prefix_item_list_clear(&files);
-- 
gitgitgadget
