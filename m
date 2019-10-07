Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E31371F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 09:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfJGJ1I (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 05:27:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34061 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbfJGJ1H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 05:27:07 -0400
Received: by mail-wm1-f67.google.com with SMTP id y135so14370098wmc.1
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 02:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EapRB+cqHBsLUnlxapZpRQYyYFhUhGVFRRksoa5qV9w=;
        b=mAcfCpPI/wv6R8BLbYTcuqyGWFVyWJWOIgsv+zZot6XZ3irVGnHuj0KRtSpQ6IqiLC
         Zn/TYC3qXRwpBX8Z4qOLdbwi7psV1ikJeUC48TNe5MoaYaHABnwV575Ek0BSQHzz5ght
         FAsLri6fXTS5fHbJMzfNdMEtsUEJSg2u5s/kGvA316MMqc18hk7I3Dvoh3EY8UjMF81O
         9cEn9QQLpBBhmzSQzqInSX1/xg9YC+l483zhTAg3BlMHuT8J1H8cU83suGdiJaYw6SRI
         lfgmrGjNVBJx+MiCrO8SQAeFnZGDS7UBzRkp1BsSWYEY4QX9vkY2SH9X+hKte81G3C1q
         222Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EapRB+cqHBsLUnlxapZpRQYyYFhUhGVFRRksoa5qV9w=;
        b=fqR82l8NeFoONRXGOI4eQgEOrPBzFpXKY7Qw2B0FyY48QNeJ+NMOsYkFox1nGMWn0B
         pUnkWTlXQ3k4KZAVPwUIs+06Qw9qSjTUgJmaBWwUNKuwWXVFRqWHM2WkDS1AX/EKe7RJ
         ws8sFeBVnGgO0aSvO28n3mcZASa0O01FLddhW55V8dpQasnBOxPd+4x0y1ns1LSdz5rw
         duiZjjOknuTeFV4nZ9de2rWuQ4H1Ual125qtCFt02TacIYLeONNTkuJPvozrDieaw5Bg
         NiOH2K1g6mV5W7PPEsGfN8I2Z1WoI0V6OaiWjTcCvhGeVmwEhQBbQpW+tZsBxso/8+wp
         8XRg==
X-Gm-Message-State: APjAAAXzImNXO826IvY0Vs7ExeOCnuwvNnLteUyxwBXlqnm+8G8MQ96A
        SJTZu2xaHqYcyQrbm18W925QC6WL
X-Google-Smtp-Source: APXvYqw2g+3X2O3/1jRjFlTbk7WPjoLVAao4xK35WOgD831vYj8tU2HkOmBazRISgOg0VMA8bzQV4w==
X-Received: by 2002:a7b:cbd0:: with SMTP id n16mr18724458wmi.82.1570440425646;
        Mon, 07 Oct 2019 02:27:05 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-47-220.w86-221.abo.wanadoo.fr. [86.221.54.220])
        by smtp.googlemail.com with ESMTPSA id w125sm25250914wmg.32.2019.10.07.02.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 02:27:05 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 5/5] sequencer: directly call pick_commits() from complete_action()
Date:   Mon,  7 Oct 2019 11:26:41 +0200
Message-Id: <20191007092641.12661-6-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007092641.12661-1-alban.gruin@gmail.com>
References: <20190925201315.19722-1-alban.gruin@gmail.com>
 <20191007092641.12661-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, complete_action() calls sequencer_continue() to do the
rebase.  Before the former calls pick_commits(), it

 - calls read_and_refresh_cache() -- this is unnecessary here as we've
   just called require_clean_work_tree()
 - calls read_populate_opts() -- this is unnecessary as we're starting a
   new rebase, so opts is fully populated
 - loads the todo list -- this is unnecessary as we've just populated
   the todo list
 - commits any staged changes -- this is unnecessary as we're starting a
   new rebase, so there are no staged changes
 - calls record_in_rewritten() -- this is unnecessary as we're starting
   a new rebase.

This changes complete_action() to directly call pick_commits() to avoid
these unnecessary steps.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
Reworded commit.

sequencer.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ec7ea8d9e5..b395dd6e11 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5140,15 +5140,17 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		return error_errno(_("could not write '%s'"), todo_file);
 	}
 
-	todo_list_release(&new_todo);
-
 	if (checkout_onto(r, opts, onto_name, &oid, orig_head))
 		return -1;
 
 	if (require_clean_work_tree(r, "rebase", "", 1, 1))
 		return -1;
 
-	return sequencer_continue(r, opts);
+	todo_list_write_total_nr(&new_todo);
+	res = pick_commits(r, &new_todo, opts);
+	todo_list_release(&new_todo);
+
+	return res;
 }
 
 struct subject2item_entry {
-- 
2.23.0

