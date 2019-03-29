Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAD3F20248
	for <e@80x24.org>; Fri, 29 Mar 2019 11:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbfC2LLH (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 07:11:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34842 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbfC2LLH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 07:11:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so2340602wmd.0
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 04:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=lpgwVujk1pO+3BaNzoKCTKr9CNQaCQiTOm+cALIjrys=;
        b=mxrdvh01QenyeFY/7mwWqdiTCPAwpQ4lbBnBNrD9yxROjnX5cdGZv/CE4PxEdwmuXN
         mIWjrviHt07UnErZpPg7gzyOioAModmmiTh930Y0ld1H36zdyiRYxxvZhMOTqjEpyH3O
         gybEIJyq7WLbgtJoiK0uIWIVWU7b3ADYauaUctrh0wGiU0h9LGC/09zk8Z1FC+W5/uo+
         FxOxQWnNqvZPH2YVWjiYlF+IJLbWuobn4gC2jsO2tvy89Prr0pckGSirEez//52nNhwI
         cO1ckDUhJ/l4yvMgHb9vIfrMB9+tWmmGT6lG/wNgR74cgtiPrdodVgLRNBY9gQKNNSPC
         Kywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=lpgwVujk1pO+3BaNzoKCTKr9CNQaCQiTOm+cALIjrys=;
        b=L8xuRR1c45iGNezbsm8KwIOh2VqRRrZ5wVvHWzUhEwbT+lIpNzUSSSA3Wnrxw2l2rV
         xIZ5T1W3Nc/exQZNKKJ6F/F401wB4wvO4Yuj1O9TU6Ib9INN6fRCOAiKAAErSl3v1EGE
         wVfCfOonXdEkXjv7ntzuU1dggcMEZztId2awUmqDI3UY5KBGOLvv1VwrdmC0RxtSw/YI
         4HNj6IgdmNCv517Ty+fH9BOrj/i2BfQ0Fxj6x2CChycEf6cJph7QOSPho/Y5+7a/hWGB
         WpgfBww8n6FoDiE259qf3v/j02NhBlRbd3mXHUld48Xoen/Yfkf3F/VIlp0H1/vGCsFq
         QLgQ==
X-Gm-Message-State: APjAAAUVe8fCE0AOQ7BRbqf9HWQCQxoOmvf9ksVe/GugTy0Zg2LZ0YvJ
        UfbdmDr1lDcvZi6kqKgXcJzQA8aiueM=
X-Google-Smtp-Source: APXvYqwhDhKHGMh0+skU7mF7O2VgmxOLhnM7/OcbU0v5XGC3f3Myg6k8QZbY0fqnoI6A1pnUrRw2Lw==
X-Received: by 2002:a1c:7008:: with SMTP id l8mr3112101wmc.63.1553857864417;
        Fri, 29 Mar 2019 04:11:04 -0700 (PDT)
Received: from localhost.localdomain (host-89-242-191-183.as13285.net. [89.242.191.183])
        by smtp.gmail.com with ESMTPSA id e9sm3516173wrp.35.2019.03.29.04.11.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 04:11:03 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH] sequencer: fix cleanup with --signoff and -x
Date:   Fri, 29 Mar 2019 11:08:42 +0000
Message-Id: <20190329110842.30604-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Before commit 356ee4659b ("sequencer: try to commit without forking 'git
commit'", 2017-11-24) when --signoff or -x were given on the command
line the commit message was cleaned up with --cleanup=space or
commit.cleanup if it was set. Unfortunately this behavior was lost when
I implemented committing without forking. Fix this and add some tests to
catch future regressions.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

This clashes with dl/merge-cleanup-scissors-fix, I've sent some
rebased patches to Denton and he's going to send a re-roll based on
those.

 sequencer.c              | 24 +++++++++++++++++-------
 sequencer.h              |  1 +
 t/t3511-cherry-pick-x.sh | 20 ++++++++++++++++++++
 3 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0db410d590..15457bbe71 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -172,17 +172,22 @@ static int git_sequencer_config(const char *k, const char *v, void *cb)
 		if (status)
 			return status;
 
-		if (!strcmp(s, "verbatim"))
+		if (!strcmp(s, "verbatim")) {
 			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_NONE;
-		else if (!strcmp(s, "whitespace"))
+			opts->explicit_cleanup = 1;
+		} else if (!strcmp(s, "whitespace")) {
 			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_SPACE;
-		else if (!strcmp(s, "strip"))
+			opts->explicit_cleanup = 1;
+		} else if (!strcmp(s, "strip")) {
 			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_ALL;
-		else if (!strcmp(s, "scissors"))
+			opts->explicit_cleanup = 1;
+		} else if (!strcmp(s, "scissors")) {
 			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_SPACE;
-		else
+			opts->explicit_cleanup = 1;
+		} else {
 			warning(_("invalid commit message cleanup mode '%s'"),
 				  s);
+		}
 
 		free((char *)s);
 		return status;
@@ -1382,8 +1387,13 @@ static int try_to_commit(struct repository *r,
 		msg = &commit_msg;
 	}
 
-	cleanup = (flags & CLEANUP_MSG) ? COMMIT_MSG_CLEANUP_ALL :
-					  opts->default_msg_cleanup;
+	if (flags & CLEANUP_MSG)
+		cleanup = COMMIT_MSG_CLEANUP_ALL;
+	else if ((opts->signoff || opts->record_origin) &&
+		 !opts->explicit_cleanup)
+		cleanup = COMMIT_MSG_CLEANUP_SPACE;
+	else
+		cleanup = opts->default_msg_cleanup;
 
 	if (cleanup != COMMIT_MSG_CLEANUP_NONE)
 		strbuf_stripspace(msg, cleanup == COMMIT_MSG_CLEANUP_ALL);
diff --git a/sequencer.h b/sequencer.h
index 4d505b3590..82bc7a48d5 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -47,6 +47,7 @@ struct replay_opts {
 
 	char *gpg_sign;
 	enum commit_msg_cleanup_mode default_msg_cleanup;
+	int explicit_cleanup;
 
 	/* Merge strategy */
 	char *strategy;
diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
index 9888bf34b9..84a587daf3 100755
--- a/t/t3511-cherry-pick-x.sh
+++ b/t/t3511-cherry-pick-x.sh
@@ -298,4 +298,24 @@ test_expect_success 'cherry-pick preserves commit message' '
 	test_cmp expect actual
 '
 
+test_expect_success 'cherry-pick -x cleans commit message' '
+	pristine_detach initial &&
+	git cherry-pick -x mesg-unclean &&
+	git log -1 --pretty=format:%B >actual &&
+	printf "%s\n(cherry picked from commit %s)\n" \
+		"$mesg_unclean" $(git rev-parse mesg-unclean) |
+			git stripspace >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'cherry-pick -x respects commit.cleanup' '
+	pristine_detach initial &&
+	git -c commit.cleanup=strip cherry-pick -x mesg-unclean &&
+	git log -1 --pretty=format:%B >actual &&
+	printf "%s\n(cherry picked from commit %s)\n" \
+		"$mesg_unclean" $(git rev-parse mesg-unclean) |
+			git stripspace -s >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.21.0

