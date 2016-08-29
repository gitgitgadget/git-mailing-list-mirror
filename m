Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9BD41F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 08:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756616AbcH2IEX (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 04:04:23 -0400
Received: from mout.gmx.net ([212.227.17.21]:57876 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756404AbcH2IEP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 04:04:15 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M8mCe-1bqKlK2HCG-00C83B; Mon, 29 Aug 2016 10:04:10
 +0200
Date:   Mon, 29 Aug 2016 10:04:09 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 02/22] sequencer: use memoized sequencer directory path
In-Reply-To: <cover.1472457609.git.johannes.schindelin@gmx.de>
Message-ID: <d032a9d765aaca0655b1e363e67d9bf24864396c.1472457609.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wrBSlMkSxIcJ4dyuFt/Vi2rkhWtA7kBfwQl3SI0Vw4nRnJdf+8m
 RVHmH8RdaFl7+DmzORIP2qKy4fRO23mUufPrDEbtzCtP9Vpr1pKj+5G+BJZDfp7dmXiTgC3
 A70Tyx+rzGWNGBX3YAVWTJJkw71i7pyyjxijzvxktjB0vbSfPoD6hrutZ6b8yS+Qc/4ZB+9
 vpqswfszV3gcR+v5eKVlg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7qhSb03cW80=:kw1Yd7lZtOc5J/rVrDNAbS
 lnIqki8HQkBBszQb6iAF+Y/ZO2cGkNjRJujbjUtrDbPep2Zc2ggVy59zJ6ZAv0AWIxF0pMhUO
 WhB3XmvDldsQMQtKjewPu8s5jUw4dYUtcOxgqGYbpM0KDP42EGYaqXwQrR8BxuvvnyO7Hz0V9
 uFyundO2YcvOYAofbwA7HpwgXvJP/6jZoDoYP6JDP2c1ews+Rwq8EwLQc+QID7nO3wCG272k0
 CwGQNuNlXi/d499CgAvcm3jJbwu2Eygm2tOaQDrIG7jQ87YMuE+KThj+dPLo4N+MoVQQjYsAv
 zjvvWKE6sa9VuRUpOmvZ4PgzS0/HPPyMWPrK8ga/yGUhhHOOaX8WQyiG/7hY6inzD90l+6Ptv
 4TeDSSN2FDpk3HRp7r4VQaYsyljzr9KAiehOA5CMyodl2hucEOIxc6NB4e52+fPGesIElgEIf
 TMa5OePy3gNHkqFlDRqjQ2pHUGVnLqys7hl7zM185ZuaGZTIu0nHDUXDkHSTRHcufc9uhxiuD
 U+NAWllASegbhFXbbl9GGUxIYmTKdWYlzVPQStdyXxqApna5nK0jiIWrOKdDe+J34FV306wXx
 UMPEpmeOLamBhE+rqbM7Tlm5qBQYxGzaSGXe/DAFuzE9mc2YgpLpdfRAkl8vDrSCKI9F1fZJx
 3kU92ccwfucspeUoiyH50MJOcJ8tk53Rua9Fb8K5HLu9S5LfVFZW0lQlWlZUSlOvjCUFqXgAp
 FK4TRoYoP6t5um9BaZwi70N72ERaYDXh8E1Exs3SKhgHV/RopsImVSiMhxhfpCKpyqQX+auvn
 E47MHXw
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
index 77e3dc8..0221190 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -173,7 +173,7 @@ static void determine_whence(struct wt_status *s)
 		whence = FROM_MERGE;
 	else if (file_exists(git_path_cherry_pick_head())) {
 		whence = FROM_CHERRY_PICK;
-		if (file_exists(git_path(SEQ_DIR)))
+		if (file_exists(git_path_seq_dir()))
 			sequencer_in_use = 1;
 	}
 	else
diff --git a/sequencer.c b/sequencer.c
index b6481bb..4d2b4e3 100644
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
index 2ca096b..c955594 100644
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
2.10.0.rc1.114.g2bd6b38


