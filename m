Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 949241F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 20:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbeJHDIo (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 23:08:44 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:52973 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbeJHDIo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 23:08:44 -0400
Received: by mail-wm1-f53.google.com with SMTP id 189-v6so6183853wmw.2
        for <git@vger.kernel.org>; Sun, 07 Oct 2018 13:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O6wO5pavF9klxU67lYTPbndM9g+hgqKRTQ1/QEALfVM=;
        b=pAVlPdDbLft4g44opYPt/B03vB1Ow7E8Sx/0vmNsEpQutDOvOkJ3kWM3cv/YGlCf2o
         8zumrHyd68GlqGDXAXNHeVh0b98E32bnJbtCH52rtX+FqzXYhGiO9by6293qfnrHont+
         YLkBpMSC9wCDCGxOyomorvIIcTKU/c36yftY68oo0lUOFIFLARWSVsAxRExRPTWdRLGF
         nv1wCkTyA25GKlvpUzAVNP+3JXbGo20M/fe1lrr+1iVI6ixlJXYytTcKHeukLH4MW6Bb
         pKBH9vVzRGIZwPPHXRNn8cV02XVF1MxI2RcYi+nzY6K35kNTwWpwrhn8P547u9MuW5Lb
         sfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O6wO5pavF9klxU67lYTPbndM9g+hgqKRTQ1/QEALfVM=;
        b=tFVkY1DeaCqoSBLsZ1QjeJ6bS7VBrJJUIgZieOZykjzH9ZiTkbdnJnJWBFnZmi9lIU
         RS+QxtSHhNTX1bcDvpw6vh2JlNVJ+pYTg0iwCkRPm8zsfh9CXAyEd1L1x9GnSJyZDmqw
         tre3MZOSCpMdSUu07IJfFbGc1jg1W0e/Y+zxXzj4k3xEs8a0krRhtb92+iToHzq3TsHA
         aka6zRfpHtSkkyO/nkcF/RISwxcQns4hqEbTvfEUdNkWT51g2pSwNNxwh8oYfjHeJxxw
         6edCdtnLjgE9otS3uDNBk05Nc6webWQdBF19i7diimw9rEeqQJcHELdVUuhc7A94Ffqv
         LnPg==
X-Gm-Message-State: ABuFfogml3oONeF+xD5AMuAIcm8hum4m2adG4uA6BGoOo469wr34FmD8
        QVeVFlro/iu2IKrab84sd7gywy6V
X-Google-Smtp-Source: ACcGV62F/es+K03FG+WE/96Es5yxTlsZJGfLzFbF9q4g4ga2Djt23A9/XfNXSqKFthr4QAXLievVuA==
X-Received: by 2002:a1c:8942:: with SMTP id l63-v6mr13939346wmd.66.1538942419270;
        Sun, 07 Oct 2018 13:00:19 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-60-162.w92-136.abo.wanadoo.fr. [92.136.157.162])
        by smtp.googlemail.com with ESMTPSA id u76-v6sm17082538wmd.10.2018.10.07.13.00.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 13:00:18 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH 10/15] rebase-interactive: use todo_list_transform() in edit_todo_list()
Date:   Sun,  7 Oct 2018 21:54:13 +0200
Message-Id: <20181007195418.25752-11-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181007195418.25752-1-alban.gruin@gmail.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just like complete_action(), edit_todo_list() used a
function (transform_todo_file()) that read the todo-list from the disk
and wrote it back, resulting in useless disk accesses.

This changes edit_todo_list() to call directly todo_list_transform()
instead.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 rebase-interactive.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index 7c7f720a3d..f42d48e192 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -78,39 +78,37 @@ void append_todo_help(unsigned edit_todo, unsigned keep_empty,
 
 int edit_todo_list(unsigned flags)
 {
-	struct strbuf buf = STRBUF_INIT;
 	const char *todo_file = rebase_path_todo();
+	struct todo_list todo_list = TODO_LIST_INIT;
+	int res = 0;
 
-	if (strbuf_read_file(&buf, todo_file, 0) < 0)
+	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
 		return error_errno(_("could not read '%s'."), todo_file);
 
-	strbuf_stripspace(&buf, 1);
-	if (write_message(buf.buf, buf.len, todo_file, 0)) {
-		strbuf_release(&buf);
-		return -1;
-	}
-
-	strbuf_release(&buf);
+	strbuf_stripspace(&todo_list.buf, 1);
+	if (!todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list))
+		todo_list_transform(&todo_list, flags | TODO_LIST_SHORTEN_IDS);
 
-	transform_todo_file(flags | TODO_LIST_SHORTEN_IDS);
-
-	if (strbuf_read_file(&buf, todo_file, 0) < 0)
-		return error_errno(_("could not read '%s'."), todo_file);
+	append_todo_help(1, 0, &todo_list.buf);
 
-	append_todo_help(1, 0, &buf);
-	if (write_message(buf.buf, buf.len, todo_file, 0)) {
-		strbuf_release(&buf);
+	if (write_message(todo_list.buf.buf, todo_list.buf.len, todo_file, 0)) {
+		todo_list_release(&todo_list);
 		return -1;
 	}
 
-	strbuf_release(&buf);
-
-	if (launch_sequence_editor(todo_file, NULL, NULL))
+	strbuf_reset(&todo_list.buf);
+	if (launch_sequence_editor(todo_file, &todo_list.buf, NULL)) {
+		todo_list_release(&todo_list);
 		return -1;
+	}
 
-	transform_todo_file(flags & ~(TODO_LIST_SHORTEN_IDS));
+	if (!todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
+		todo_list_transform(&todo_list, flags & ~(TODO_LIST_SHORTEN_IDS));
+		res = write_message(todo_list.buf.buf, todo_list.buf.len, todo_file, 0);
+	}
 
-	return 0;
+	todo_list_release(&todo_list);
+	return res;
 }
 
 define_commit_slab(commit_seen, unsigned char);
-- 
2.19.1

