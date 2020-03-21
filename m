Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1479C4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D902070A
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViA0Pmw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgCUJW1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 05:22:27 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36985 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgCUJWY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 05:22:24 -0400
Received: by mail-qt1-f193.google.com with SMTP id d12so4848146qtj.4
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 02:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SrEUjfSMPCZuP6l6Bg3aCTF9UDmgU0T9O42moAZVIC8=;
        b=ViA0Pmw9oObQBtucuijLplMDUUzHQRyVfW36LKf6EyVpi4S1AeVGZ0p94AMHyxgj57
         INJMYW1dx2gK0pCvXQV3QKCoPAOgujy9ETkbjab9KvW187CvIP3BqjguhF1uBYK6jaOE
         OZsFNsDodu6ZsgGUscJepXZZ22vPiv4B8A8aJDz0DQ4yS7seN6hKyJF4O6sv9Y5Z7fJn
         DM44ztN+RnK5Hpocry6xAT2vSN7P5I2lzTVOqe5dAmkKx3JSL7r4Ztbo4sYlBpT+Xp4T
         m+x4Y/F5YtVsQlQRBTjBFpn5FhKOCXgNcn9bFYkdmRIGYHzMugl5KydURirmAUE2pKXS
         jygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SrEUjfSMPCZuP6l6Bg3aCTF9UDmgU0T9O42moAZVIC8=;
        b=Tvi1pRXnjAhAFy7qwvwTxvbQdc6SuQ57h/1OnrRpCvGTThCexqTfN1JXxuXLmFjzTQ
         aUOjWQ434G2y5ShoSIs9eSLE1Eoew/SsqlZNkF5Ervko0TAnOQOtD/diRodene49fwKB
         rOmdI5lMqmE8ZHdUEszl+5aAewudytZem2ftpRko+t7SHylmYEsc7+ffUto7WWy7GC2T
         NJH59rFb877vQ2BfJSNdsBg9B4mSPFaw7U/xQUE36xSdSt/cl1bu0av0Xv1rjmDZABGy
         txIgly1Qa+nTqWKtrVgmD9UyMVIC80WWsINYfXy1aBuPbK1qH+c9tYkIHIh6JmnQ6uk4
         zMuQ==
X-Gm-Message-State: ANhLgQ0PNvqaBgFImVfwHthnVFSmiOZizENq2yLqyhxoGtQEpMKI1vbS
        PqJ0RzFYwC3cCGKu6k0Qwmz19vI1
X-Google-Smtp-Source: ADFU+vsccqa1kmGgwKdFUuLjIlngJ1cVYVRclzi74YLCuToa3SMwArhk8MCg8kAYSE9LWJxH3xjWkg==
X-Received: by 2002:ac8:4e44:: with SMTP id e4mr12115648qtw.313.1584782543313;
        Sat, 21 Mar 2020 02:22:23 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id z23sm6579890qkg.21.2020.03.21.02.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 02:22:22 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 08/19] sequencer: make apply_rebase() accept a path
Date:   Sat, 21 Mar 2020 05:21:27 -0400
Message-Id: <5bce4aeb96f21d39677a735e6fbdd42f7405d28a.1584782450.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca878e0
In-Reply-To: <cover.1584782450.git.liu.denton@gmail.com>
References: <cover.1577185374.git.liu.denton@gmail.com> <cover.1584782450.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to make apply_rebase() more generic for future extraction, make
it accept a `path` argument so that the location from where to read the
reference to the autostash commit can be customized. Remove the `opts`
argument since it was unused before anyway.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index c2102cc2eb..ad40a8b3fc 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3655,13 +3655,13 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
 	return -1;
 }
 
-static int apply_autostash(struct replay_opts *opts)
+static int apply_autostash(const char *path)
 {
 	struct strbuf stash_sha1 = STRBUF_INIT;
 	struct child_process child = CHILD_PROCESS_INIT;
 	int ret = 0;
 
-	if (!read_oneliner(&stash_sha1, rebase_path_autostash(),
+	if (!read_oneliner(&stash_sha1, path,
 			   READ_ONELINER_SKIP_IF_EMPTY)) {
 		strbuf_release(&stash_sha1);
 		return 0;
@@ -3754,7 +3754,7 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
 		return error(_("%s: not a valid OID"), orig_head);
 
 	if (run_git_checkout(r, opts, oid_to_hex(onto), action)) {
-		apply_autostash(opts);
+		apply_autostash(rebase_path_autostash());
 		sequencer_remove_state(opts);
 		return error(_("could not detach HEAD"));
 	}
@@ -4068,7 +4068,7 @@ static int pick_commits(struct repository *r,
 				run_command(&hook);
 			}
 		}
-		apply_autostash(opts);
+		apply_autostash(rebase_path_autostash());
 
 		if (!opts->quiet) {
 			if (!opts->verbose)
@@ -5077,7 +5077,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		todo_list_add_exec_commands(todo_list, commands);
 
 	if (count_commands(todo_list) == 0) {
-		apply_autostash(opts);
+		apply_autostash(rebase_path_autostash());
 		sequencer_remove_state(opts);
 
 		return error(_("nothing to do"));
@@ -5088,12 +5088,12 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	if (res == -1)
 		return -1;
 	else if (res == -2) {
-		apply_autostash(opts);
+		apply_autostash(rebase_path_autostash());
 		sequencer_remove_state(opts);
 
 		return -1;
 	} else if (res == -3) {
-		apply_autostash(opts);
+		apply_autostash(rebase_path_autostash());
 		sequencer_remove_state(opts);
 		todo_list_release(&new_todo);
 
-- 
2.25.0.114.g5b0ca878e0

