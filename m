Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F945C43215
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 17:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F412080D
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 17:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5+DSPYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKXRpp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 12:45:45 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50925 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfKXRpp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 12:45:45 -0500
Received: by mail-wm1-f66.google.com with SMTP id l17so12756722wmh.0
        for <git@vger.kernel.org>; Sun, 24 Nov 2019 09:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FLBc34Uz8vmA0g3wPA6jInm6SI34pchu74/TCjp84yI=;
        b=p5+DSPYNYzuv8eryLKYmhdxFHYhQQE7DKbfxYfYrQawP8QsLLuP+eAU2HVmF1QuSgq
         6yJALj1cmpsbT66VGtHA6aG4O4zVjp4IFUgjvBafbkE4hYyeP6PwZ/jXKGC4+acLtNj3
         Y/sqmKOQPEWCbw6U5ceG4Tzx0Vz+KYkqwPOVtVrgugURayRhSUOvwCM4MqC8J957ZvKu
         CRVXiQ7QwhHPP1jjgYOEUgVacZMdtsuNI18XU+qCZLVIFpHG5oFlqc9J8VB5V6YRWXyc
         kHiNK77ZvZN9I8zzWYbWadvniaEr2jdkZWVmteys04a10/9IyV5yUfOmUaN9GaITWphE
         7Z3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FLBc34Uz8vmA0g3wPA6jInm6SI34pchu74/TCjp84yI=;
        b=l8XhkrwU6LNl9peCYvR0aGpG3XjtVwE7sDbU0EawXZyUBoit11M23T33KfW8kj2yqz
         /fP0De6WBgIveHV1OBztt3zOw9Q+Z+QuSIQDvhDXI4hcn2oCNZxU1cxT31HSRvOlFGdm
         QI3yqU9R7iVJTn22ROps2qDx3khQ1eqp3+WMXnSzRzghrvIhiW8ag5AUgsKc4KNGvQzZ
         2ixfPu+TdVdgAFLjhFArcV3jQc53jK9zpPxNoAGaF7Yl1BmikGmGktiVhoJd0MANhAB2
         d2acjNraTpmle31SlAjcktUMP1302Zd+C3wjS3f5L3vPHDo3T3qC0v3J6JwRFLKnC37+
         bCPw==
X-Gm-Message-State: APjAAAV0K6iHWAVM7dkSeL43OuuE1gH2thOMs9ockQFRx+2+DuFjHBVN
        YWrdgpZI/RDIwqWzYCv4WuKkSpPy
X-Google-Smtp-Source: APXvYqxUaaJNzd3/knIAHluBIaVzTw/hrDQfFakYAd45O5AZRyNd5JLvIpMr4GmZloV8x9L/KlXTQA==
X-Received: by 2002:a1c:ca:: with SMTP id 193mr11521994wma.111.1574617543130;
        Sun, 24 Nov 2019 09:45:43 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-110-106.w86-199.abo.wanadoo.fr. [86.199.33.106])
        by smtp.googlemail.com with ESMTPSA id a2sm7171315wrt.79.2019.11.24.09.45.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Nov 2019 09:45:42 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v4 5/5] sequencer: directly call pick_commits() from complete_action()
Date:   Sun, 24 Nov 2019 18:43:32 +0100
Message-Id: <20191124174332.30887-6-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191124174332.30887-1-alban.gruin@gmail.com>
References: <20191123143705.17280-1-alban.gruin@gmail.com>
 <20191124174332.30887-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, complete_action(), used by builtin/rebase.c to start a new
rebase, calls sequencer_continue() to do it.  Before the former calls
pick_commits(), it

 - calls read_and_refresh_cache() -- this is unnecessary here as we've
   just called require_clean_work_tree() in complete_action()
 - calls read_populate_opts() -- this is unnecessary as we're starting a
   new rebase, so `opts' is fully populated
 - loads the todo list -- this is unnecessary as we've just populated
   the todo list in complete_action()
 - commits any staged changes -- this is unnecessary as we're starting a
   new rebase, so there are no staged changes
 - calls record_in_rewritten() -- this is unnecessary as we're starting
   a new rebase.

This changes complete_action() to directly call pick_commits() to avoid
these unnecessary steps.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ec7ea8d9e5..ec0b793fc5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5140,15 +5140,21 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		return error_errno(_("could not write '%s'"), todo_file);
 	}
 
-	todo_list_release(&new_todo);
+	res = -1;
 
 	if (checkout_onto(r, opts, onto_name, &oid, orig_head))
-		return -1;
+		goto cleanup;
 
 	if (require_clean_work_tree(r, "rebase", "", 1, 1))
-		return -1;
+		goto cleanup;
 
-	return sequencer_continue(r, opts);
+	todo_list_write_total_nr(&new_todo);
+	res = pick_commits(r, &new_todo, opts);
+
+cleanup:
+	todo_list_release(&new_todo);
+
+	return res;
 }
 
 struct subject2item_entry {
-- 
2.24.0

