Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F407A20229
	for <e@80x24.org>; Fri, 21 Oct 2016 12:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932773AbcJUM01 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 08:26:27 -0400
Received: from mout.gmx.net ([212.227.15.18]:60467 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754368AbcJUM00 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 08:26:26 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lbd9v-1cdFV30tNz-00lDcB; Fri, 21 Oct 2016 14:26:10
 +0200
Date:   Fri, 21 Oct 2016 14:26:09 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 22/27] sequencer: teach write_message() to append an
 optional LF
In-Reply-To: <cover.1477052405.git.johannes.schindelin@gmx.de>
Message-ID: <d858bd99a3ad3dea807f38b8bd42a221a9f7924c.1477052405.git.johannes.schindelin@gmx.de>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:p017XkXxFNBZnS/61nWIqCYCV4ePmKNRJFURHakrN45dDPX1AI/
 TXxjwWvPYpJgjvQgnT61Q/7X5fABuS6sj2xUtyuXoW6+/Rr7dBQUOzc+P5xVRZskOx4FPtZ
 N/ItGeqYhtx5M+szAZ4wrtlrOiEeUmq1sWpEu3CpBVN2MGysh4bd4xpz78hlKsH0YzngX5g
 fZeNb7FP0PV/2ghdbQ9tw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UZiBN2YkG08=:6Y7FZYphrHaUDcLoiQ02Ey
 UT29C+neUZr62M0wsyK6oAliQ08sDyq+ddV1W3W2uqvn9TX/2O3NLv3rXUFGc5EpOPHYEPWge
 9pVMCFDri1bYUiPI6EdgU09wGx+YuXSBTNginD1Rf4WRG8KY8rfMoNZWNJVB1voGVUnzOchbw
 QpYoG2spYbdQSG026szjxICnNSxHxjn5cT2+ccHmVIRYALlKZuRXvF804oJGydr9zt9t3svxN
 iU66AMfpCk8kR2dmY3unb4nivuCiFdUG/KOhcG4RmKiGoOTNaYMA+59OfmDkuWmdOF3ChOE67
 2kuEMXXFEcbpUI4Z1FN1nndqkRlU9WTZ4eyulYcGeA0daLdAcZuYRpSY7rHt2zVroVTISmEkT
 O4lqgsSSxy6O4y/ZOkDIrnBIAMAMYH0KDolAZe6vGgYDa80lDGbw1p6o7RXDyYqjRRp71qsFw
 j6Xzk6Hb+UYYrLC5ZcVmqu1yaI4vJUHPAmB/BKDjyOAjIzE659kz8isFcltOw83KPpTeUqNsg
 xE1C8XJKSif216QcBZsCFWbSaF0lmUI7phpVoQ7+51poz5Jy7fHwwntTjoWiMYjYdHM7ruyjI
 GTXGHbuiyJQ/HIO1vWlmNGd/qbueAcExhK1yu4QTNhzyCO5Vde/MDrcWWtlurFI93mBGueaEc
 Z0i7TysS28voAe051bZuwbWwZxUfCEu7Amh9zTebpLpCt6vt0quLOrRStHbrRXqFeVJd3ZF5v
 B0NFKjuTX3tAd9SAA79Z/BCoaoV9BF7gwepdw/gsj9mUuKuNI9YQaeyJsgI1JzDnnTpDg5/Rl
 QmMbufU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit prepares for future callers that will have a pointer/length
to some text to be written that lacks an LF, yet an LF is desired.
Instead of requiring the caller to append an LF to the buffer (and
potentially allocate memory to do so), the write_message() function
learns to append an LF at the end of the file.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 300952f..000ce3e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -234,7 +234,8 @@ static void print_advice(int show_hint, struct replay_opts *opts)
 	}
 }
 
-static int write_message(const void *buf, size_t len, const char *filename)
+static int write_message(const void *buf, size_t len, const char *filename,
+			 int append_eol)
 {
 	static struct lock_file msg_file;
 
@@ -245,6 +246,10 @@ static int write_message(const void *buf, size_t len, const char *filename)
 		rollback_lock_file(&msg_file);
 		return error_errno(_("Could not write to '%s'"), filename);
 	}
+	if (append_eol && write(msg_fd, "\n", 1) < 0) {
+		rollback_lock_file(&msg_file);
+		return error_errno(_("Could not write eol to '%s"), filename);
+	}
 	if (commit_lock_file(&msg_file) < 0) {
 		rollback_lock_file(&msg_file);
 		return error(_("Error wrapping up %s."), filename);
@@ -748,13 +753,13 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		if (res < 0)
 			return res;
 		res |= write_message(msgbuf.buf, msgbuf.len,
-				     git_path_merge_msg());
+				     git_path_merge_msg(), 0);
 	} else {
 		struct commit_list *common = NULL;
 		struct commit_list *remotes = NULL;
 
 		res = write_message(msgbuf.buf, msgbuf.len,
-				    git_path_merge_msg());
+				    git_path_merge_msg(), 0);
 
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
-- 
2.10.1.583.g721a9e0


