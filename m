Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813EBC432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 14:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F7420706
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 14:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFQTzrPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfKWOrc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 09:47:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34610 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfKWOrc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 09:47:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id j18so12456061wmk.1
        for <git@vger.kernel.org>; Sat, 23 Nov 2019 06:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FLBc34Uz8vmA0g3wPA6jInm6SI34pchu74/TCjp84yI=;
        b=tFQTzrPQPY91Fr99W9oHePgVY2Pg/OLaOkbmwUOtwi25+G4rxCWyRAFLTOoWHI+u8E
         R8TAqL7mnMXC0Wvf3y1VedIFh1ZZLO7Jv2ZKm3wRxtMkp8OfGibJAoNubHQznV/iN9z5
         IssZxEyvpLn5X6C1bhFJCBIUJIkQDRlehG8fhg11rSChrYiBDyevBzd7kim09FTo83fQ
         WRUSd2fZGoybXOw8yajKjXdDENcNCsFSaqiRqPh6z+tz+IOk7nVUASLYX9+hlWzYF6+Z
         Ef0bynvnVK78ZH17PtV1mZK00vp+wGToUTyF7gs1PQzL7PthHlTUXfLOMBYPZuSYnxR7
         uZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FLBc34Uz8vmA0g3wPA6jInm6SI34pchu74/TCjp84yI=;
        b=UMC9DTlvuDWRX+YBvHH2U1GCwoeee5iw0YoMdzSpaZ5HtWZkAVDYAocJd1qfHvaU4q
         rVi9pzyX2igxJsXmpAGE/FzZwKp5lYz1lSaps/aLV4C+3dFZQkqU0nn/HaAoJtEheF2Y
         xrMSdY3723SywbDPCqcy9ZW1oHngvFG5Wamw7xgPoUMDjCoIm/5Z1z7dcL7leSwAaViO
         0/4uoH0r6JT1qyh+jK5AdB0QUm9GXVJTMhBcX9dLJdTY+gLtYPVzsTJQm3kyO9Z7fPSz
         VVP35QWEwgvq9+XUzBpHrdcoQn+9+izDLPGT13s0NPeomDzIkXwJftf04FLgdbdaeb59
         t9HQ==
X-Gm-Message-State: APjAAAWDZZ9YV53tKTqSC20xashcmEbwcaDH/vdl1Kos31ZmaraFhxfl
        zIcQu5K6bXcEPFmvv7wX5mwJDP8K
X-Google-Smtp-Source: APXvYqyGINuQv1ZaSlWuqTk5eArnCD8nNlPPx+dt0eXKLyXN40LrT5m29SnGQ8eem6/dn+lLptuLQQ==
X-Received: by 2002:a7b:c44c:: with SMTP id l12mr14860608wmi.71.1574520044043;
        Sat, 23 Nov 2019 06:40:44 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-110-106.w86-199.abo.wanadoo.fr. [86.199.33.106])
        by smtp.googlemail.com with ESMTPSA id b10sm2399298wrw.53.2019.11.23.06.40.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Nov 2019 06:40:43 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 5/5] sequencer: directly call pick_commits() from complete_action()
Date:   Sat, 23 Nov 2019 15:37:05 +0100
Message-Id: <20191123143705.17280-6-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191123143705.17280-1-alban.gruin@gmail.com>
References: <20191007092641.12661-1-alban.gruin@gmail.com>
 <20191123143705.17280-1-alban.gruin@gmail.com>
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

