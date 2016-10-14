Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22C22209AB
	for <e@80x24.org>; Fri, 14 Oct 2016 13:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932871AbcJNNUV (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 09:20:21 -0400
Received: from mout.gmx.net ([212.227.15.18]:63205 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754527AbcJNNSK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 09:18:10 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MC4R6-1c3s4200TQ-008sjE; Fri, 14 Oct 2016 15:17:14
 +0200
Date:   Fri, 14 Oct 2016 15:17:12 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 02/25] sequencer: use memoized sequencer directory path
In-Reply-To: <cover.1476450940.git.johannes.schindelin@gmx.de>
Message-ID: <e2d2ec17acd459f2f52476604ea564ed87e44228.1476450940.git.johannes.schindelin@gmx.de>
References: <cover.1476120229.git.johannes.schindelin@gmx.de> <cover.1476450940.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:U4oZL/dcNzKA8xsI2CphcVlDkw4bGs6MN/wsmdKw4gx56ulAmS2
 aO5KEyRR+tloWSx5SpK/W+ntUJKi9IUdOkltikkGVDRbnpXyOf9DfvixiTmX8NCDp5HH0E7
 m+rsOvrC1X8sMbckQ6IbLq7qRz+xsviI9gU2Zrt+nmgP3c436Agovbb1xyjtn1Ma+GPAAOM
 La8IsjM14XLe76CaB8heQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AtvPY1+4b30=:CwLpUM6NeBWgvjj4Qz8j6u
 5+R/Bqfm/QrUMaurdW+DMTTSu3hJoAqQ1zn++SuamfKJKv4AOZRhga53h5bO6fLBiBNQDSgVz
 ntB5V/Hl+NFv1S9PsXwUSB7OfnvqUmUmHXEYyDgxTGwTaOgSwzoJp6hnQ38cM6HzQ86q/HuIA
 YlGYkq5TvpuX9ygzZkgMsGVM7aTC1EU83c23ykofxV7WLr3S8JC/yfpZXxsUgmZpybabhBzVm
 yw8dGW7HoiSWjujV92ndzNnHhpDJejeC7XOPxLi0hNvwG04+qThJ9ZPHzUME68f+YpmPUZNFS
 kePr53fTap9qEW/nvf4y+PWxkZ9L6tlNUkf28j2Egv1hywfCfXPelQ9xnF3N3/k3uyrwpjUrT
 StHM8Q+QQ/qMATl/hsiO5SRGAnsvXNsFGfW0hj5mfJXH4RLwVvzCL20l+7Zr3jcS4rXKgNhPb
 W+Jekh3rp7SM+Mm6AxqLY1CmEa/HX0/bcX/SkaoksVmWwkD3CxwM/DXxa+DfxSWBkBGhpjrd/
 1K5J9d5tQly9YwF2h15n2m91M5NjRVAaJHRipHCBhTWxxpMIRc5Q4q4YjUjjQxH+zJzIJdiyu
 KI6CsQIExMU0r9+tzkhbz8yD/zshU35pO7rFlJMi4nJxtg8cE/UxDGCnBhf8bYVmDXlCNGb4+
 8ZaOjF8OLc4e3fr2Tt1Ns7Sy3d/CyFkqRDEMXrKG3RzNHkFdsYzX/d4WAnQkp9YqPPUTCgk8q
 R0HP2y4CKoNso2WM/n4oFO6FwwBbtOWL4eXgwnhbUuofiis1So1P6f7JzAvCuMUGReUbC/eyz
 5x9JssQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/commit.c |  2 +-
 sequencer.c      | 11 ++++++-----
 sequencer.h      |  5 +----
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 1cba3b7..9fddb19 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -183,7 +183,7 @@ static void determine_whence(struct wt_status *s)
 		whence = FROM_MERGE;
 	else if (file_exists(git_path_cherry_pick_head())) {
 		whence = FROM_CHERRY_PICK;
-		if (file_exists(git_path(SEQ_DIR)))
+		if (file_exists(git_path_seq_dir()))
 			sequencer_in_use = 1;
 	}
 	else
diff --git a/sequencer.c b/sequencer.c
index eec8a60..cb16cbd 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -21,10 +21,11 @@
 const char sign_off_header[] = "Signed-off-by: ";
 static const char cherry_picked_prefix[] = "(cherry picked from commit ";
 
-static GIT_PATH_FUNC(git_path_todo_file, SEQ_TODO_FILE)
-static GIT_PATH_FUNC(git_path_opts_file, SEQ_OPTS_FILE)
-static GIT_PATH_FUNC(git_path_seq_dir, SEQ_DIR)
-static GIT_PATH_FUNC(git_path_head_file, SEQ_HEAD_FILE)
+GIT_PATH_FUNC(git_path_seq_dir, "sequencer")
+
+static GIT_PATH_FUNC(git_path_todo_file, "sequencer/todo")
+static GIT_PATH_FUNC(git_path_opts_file, "sequencer/opts")
+static GIT_PATH_FUNC(git_path_head_file, "sequencer/head")
 
 static int is_rfc2822_line(const char *buf, int len)
 {
@@ -112,7 +113,7 @@ static void remove_sequencer_state(void)
 {
 	struct strbuf seq_dir = STRBUF_INIT;
 
-	strbuf_addstr(&seq_dir, git_path(SEQ_DIR));
+	strbuf_addstr(&seq_dir, git_path_seq_dir());
 	remove_dir_recursively(&seq_dir, 0);
 	strbuf_release(&seq_dir);
 }
diff --git a/sequencer.h b/sequencer.h
index db425ad..dd4d33a 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -1,10 +1,7 @@
 #ifndef SEQUENCER_H
 #define SEQUENCER_H
 
-#define SEQ_DIR		"sequencer"
-#define SEQ_HEAD_FILE	"sequencer/head"
-#define SEQ_TODO_FILE	"sequencer/todo"
-#define SEQ_OPTS_FILE	"sequencer/opts"
+const char *git_path_seq_dir(void);
 
 #define APPEND_SIGNOFF_DEDUP (1u << 0)
 
-- 
2.10.1.513.g00ef6dd


