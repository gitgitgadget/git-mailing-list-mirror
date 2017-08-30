Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A4C320285
	for <e@80x24.org>; Wed, 30 Aug 2017 17:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752119AbdH3RuO (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 13:50:14 -0400
Received: from mout.web.de ([212.227.17.12]:49814 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751742AbdH3RuH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 13:50:07 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MHY1o-1doD3K1psq-003MKL for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 19:50:06 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 06/34] clone: release strbuf after use in remove_junk()
Date:   Wed, 30 Aug 2017 19:49:37 +0200
Message-Id: <20170830175005.20756-7-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175005.20756-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
X-Provags-ID: V03:K0:WTqDkS/UrizodzPDluW5db6sMc8s+EWH2UjYxLtcqqylkYnbBoX
 jSp617YwRbZ2IqqWcSDoxmoKytZ5ft16SXW6AZWGZMxF5wpTf/Eq+Jepx8HDxC9wVjhj5VV
 IYSW6udwFxAOFtEY7GBW6tXFySCya1ObOBFpBW68S9ghbFuvPyvIOy1QIGux6eQur7UI/0l
 O4ss5b4Lcqgc3ER4x5BGw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zc3wwPFc48Y=:isdkEAigE5g78n4w+ycxae
 idmGbe6Z8yZYFPxKKiubB1NdhKVWwwNfIa/g4/1Asks+bVRS6f57kfdMUGu/PbvucL2gyXmUn
 qa6KEByFSXDhx2UjxO/sC0rKR6Xc3PaEyX9dtwvAjH458Bu39QGOQ4otL7ckl/TmDcf0orl+V
 aEF7zeW/YG+sYH6NbdnLBogqNJl3NBvK0RGKwlAPAY5hJz4aD33KvnFdgTj1ckgii01pQfSYo
 Ya0jNkBgKj7aZCl1DiEXWI66vMIsWCgOo4CpXeNPpPvlg0RnzbuLrt14Kp3VOLCY/EO83+1Ol
 n6RGXxxj42EHTKf4aQEVM1rXpoLb/T/soMMpHpEhbzIvUeMwRvrDR0FF71hAeQfWB/hTov3DT
 n2Uo11N3h8EhMIJMOhXq6q4BNI5IrssYeNXVXtcxBJS8bVCnI7ZpYa+7FRzY3uqf5cgUUPG68
 ykYDLThMXMPlVkkX5y+L94YkIqj7MVJhT0blkD4aU1TUhsTV/fGhc9CpL+tf6bdKqpUAGDWTQ
 tMb+GGwHsWlgPPUZ4p4eV5U4xQLFoZqCqTloTa9IWs8Pau/DuWHO+19Mf8eeyWNoZrCQqeqH+
 18vl9klqyZIzBVJNE3RSiFeEiswgvY4lt5k7gkH+ltQyLGD796kazxfzb1uHgbabfvq6zf6s/
 dB0QbhPVr2vtV/aJiOvtvNDIzYrGc8g8p330A00yax8yohJu7k7eLVV4xztf42yut9RgrRWwg
 qmZYvrUGqVEBsDKX2/pLTYSQEw/dHrtTA2AhPDb5OsEY+xrWmjs4CI168rlyYbj/qNq3N49In
 ThPT+oL6Sop8x9Rbl594bqvNc61VQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 8d11b570a1..dbddd98f80 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -487,28 +487,28 @@ N_("Clone succeeded, but checkout failed.\n"
 static void remove_junk(void)
 {
 	struct strbuf sb = STRBUF_INIT;
 
 	switch (junk_mode) {
 	case JUNK_LEAVE_REPO:
 		warning("%s", _(junk_leave_repo_msg));
 		/* fall-through */
 	case JUNK_LEAVE_ALL:
 		return;
 	default:
 		/* proceed to removal */
 		break;
 	}
 
 	if (junk_git_dir) {
 		strbuf_addstr(&sb, junk_git_dir);
 		remove_dir_recursively(&sb, 0);
 		strbuf_reset(&sb);
 	}
 	if (junk_work_tree) {
 		strbuf_addstr(&sb, junk_work_tree);
 		remove_dir_recursively(&sb, 0);
-		strbuf_reset(&sb);
 	}
+	strbuf_release(&sb);
 }
 
 static void remove_junk_on_signal(int signo)
-- 
2.14.1

