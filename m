Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25CC2211B4
	for <e@80x24.org>; Sun, 13 Jan 2019 20:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfAMU6H (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Jan 2019 15:58:07 -0500
Received: from avasout04.plus.net ([212.159.14.19]:58233 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfAMU6H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jan 2019 15:58:07 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id impZgA1KXAOoyimpag5e5X; Sun, 13 Jan 2019 20:58:06 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Rdm+9Wlv c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=6jlz4JeTYapmoQtmc5MA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     alban.gruin@gmail.com
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] sequencer: mark file local symbols as static
Message-ID: <5440ddf5-0b80-3d00-7daf-133a8611efa8@ramsayjones.plus.com>
Date:   Sun, 13 Jan 2019 20:58:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfO8pMs2fAeCrOikIJEt9mWvG4kAon2ngxtPUQMkVHXtEZJiZfLfdIWqbvwzEE4/vnfGJuhX/ud6+AuL9UychAVPY1Bm390smkSBdw3FsUYUvJWrWyTFC
 NhaWKfvabl5qehXLgX15Oy2zHfWQ6NMIpNGaYe1uNmsoF6VTRJAQ4T15RxJor/6zqW7hPGEoUZFTrQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Alban,

If you need to re-roll your 'ag/sequencer-reduce-rewriting-todo' branch,
could you please squash this into the relevant patch [commit 45f215c912
("rebase-interactive: use todo_list_write_to_file() in edit_todo_list()",
2018-12-29)].

I believe this commit removes the final calls to write_message() outside
of sequencer.c, so that this is now a file-local symbol.

Thanks!

[another patch for this branch is just coming up ...]

ATB,
Ramsay Jones

 sequencer.c | 4 ++--
 sequencer.h | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 60beeacdeb..64753af68e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -383,8 +383,8 @@ static void print_advice(struct repository *r, int show_hint,
 	}
 }
 
-int write_message(const void *buf, size_t len, const char *filename,
-		  int append_eol)
+static int write_message(const void *buf, size_t len, const char *filename,
+			 int append_eol)
 {
 	struct lock_file msg_file = LOCK_INIT;
 
diff --git a/sequencer.h b/sequencer.h
index 33a6070c64..0ccbe390b2 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -67,9 +67,6 @@ struct replay_opts {
 };
 #define REPLAY_OPTS_INIT { .action = -1, .current_fixups = STRBUF_INIT }
 
-int write_message(const void *buf, size_t len, const char *filename,
-		  int append_eol);
-
 /*
  * Note that ordering matters in this enum. Not only must it match the mapping
  * of todo_command_info (in sequencer.c), it is also divided into several
-- 
2.20.0
