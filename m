Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4AEC3F68F
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E8320643
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vBE+vpyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfLXLFz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:05:55 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37242 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfLXLFy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 06:05:54 -0500
Received: by mail-qt1-f193.google.com with SMTP id w47so17881917qtk.4
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 03:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WD/kT5LIQG0g26xmrzoO7BeLyh+1b/dMXYQFa6b2kaQ=;
        b=vBE+vpySSP259K+PugYPNW3G6g/d3m32pcRH6T+dpszUHfyfMXfLIs/HmOtqGvJF2p
         KcBagcBUun54xyTxxJtIvP2gPxbJ7KXd1zFU8tZwXroAZ7G5/K0l0nW53bUKyassp2Vz
         gqrox/stJdxvpCz+mDznPV1Kqyq8kBdoXVAhZ5koPmrefVI7SmaflH6fw1ZJV7Z7e973
         udGf6Ouy1Qz8T84zOOX42++TfBcAWkm3McGkWawuGwN9Yd9xueY3HQRb9t6fo/xUlmSd
         IGPdTMa7SV/LZ7QNnvLZoIz/61Pg+WbvOZSEcSUEvW8YGF2MKeBVyzMxmjVweBQXwbtd
         mb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WD/kT5LIQG0g26xmrzoO7BeLyh+1b/dMXYQFa6b2kaQ=;
        b=Opt5TBadQI5fvS1KQPAQnZcYsEgUiHYYrjMm4JboVg0kcbTZGQ9XJqWYG/78k7rO8z
         H5hW/wSCU6FJakC2WKOPReWoag0g9wGkWAgrLUKQEROPIDophgPXKPR1adggdAnpSlbQ
         EbG4OE5dUhUDaDbQeIEwiyH7eNty8jCXaJPy1chl5Wt/GXVbnwXpmGOF/c5BKvLyFHSk
         zYIpsO57pfa1mJ4u5ml9ImuVvmTC51RQFLuArGm/BbdprlpydLCi3dnQIAvoA05vEAa2
         WUnq/CguQ320JIo3jv/ltMdE8ZlFbdyPSm/6YtqMEsS191Hi7AqFvS3tTGDF+TQWVwEs
         H2Zg==
X-Gm-Message-State: APjAAAXPjZiXs4OzKp38mDhPjvqaPtwAvmELsHgbsP0+Uf5Nbj9Y+5u9
        atulF/ibJXd3Q8x4qBaayjNU6C6x
X-Google-Smtp-Source: APXvYqyGc31zvfUeDkFERgdRnnf/jHv/Hwhv8Eyh6EaIZArEkcM3pNE4xOABCG+o0azMscAj2p++/Q==
X-Received: by 2002:ac8:5205:: with SMTP id r5mr26928681qtn.230.1577185553320;
        Tue, 24 Dec 2019 03:05:53 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id o19sm7446944qtb.43.2019.12.24.03.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 03:05:52 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 07/17] sequencer: make apply_rebase() accept a path
Date:   Tue, 24 Dec 2019 06:05:04 -0500
Message-Id: <12c37d11babf2df496066d113328242584e405f0.1577185374.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1577185374.git.liu.denton@gmail.com>
References: <cover.1571246693.git.liu.denton@gmail.com> <cover.1577185374.git.liu.denton@gmail.com>
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
index 9ef9424f88..e1b7cb461c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3744,13 +3744,13 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
 	return -1;
 }
 
-static int apply_autostash(struct replay_opts *opts)
+static int apply_autostash(const char *path)
 {
 	struct strbuf stash_sha1 = STRBUF_INIT;
 	struct child_process child = CHILD_PROCESS_INIT;
 	int ret = 0;
 
-	if (!read_oneliner(&stash_sha1, rebase_path_autostash(), 1, 0)) {
+	if (!read_oneliner(&stash_sha1, path, 1, 0)) {
 		strbuf_release(&stash_sha1);
 		return 0;
 	}
@@ -3856,7 +3856,7 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
 		return error(_("%s: not a valid OID"), orig_head);
 
 	if (run_git_checkout(r, opts, oid_to_hex(onto), action)) {
-		apply_autostash(opts);
+		apply_autostash(rebase_path_autostash());
 		sequencer_remove_state(opts);
 		return error(_("could not detach HEAD"));
 	}
@@ -4172,7 +4172,7 @@ static int pick_commits(struct repository *r,
 				run_command(&hook);
 			}
 		}
-		apply_autostash(opts);
+		apply_autostash(rebase_path_autostash());
 
 		if (!opts->quiet) {
 			if (!opts->verbose)
@@ -5213,7 +5213,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		todo_list_add_exec_commands(todo_list, commands);
 
 	if (count_commands(todo_list) == 0) {
-		apply_autostash(opts);
+		apply_autostash(rebase_path_autostash());
 		sequencer_remove_state(opts);
 
 		return error(_("nothing to do"));
@@ -5224,12 +5224,12 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
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
2.24.1.810.g65a2f617f4

