Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D27E1F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 08:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756705AbcH2IEt (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 04:04:49 -0400
Received: from mout.gmx.net ([212.227.17.20]:51587 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756125AbcH2IEr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 04:04:47 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LiY3U-1b8EWk2zVc-00clh1; Mon, 29 Aug 2016 10:04:42
 +0200
Date:   Mon, 29 Aug 2016 10:04:42 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 07/22] sequencer: future-proof read_populate_todo()
In-Reply-To: <cover.1472457609.git.johannes.schindelin@gmx.de>
Message-ID: <4043fd4b955d6a3bed1b187d9529d5382db5b961.1472457609.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/dsbJzxAfxrf9hLYtKshqdaAzJRM1vFdY/z4AYrumU84O9SPPMx
 Lu6+9A3UECRC96KNwOmkSaxhZ+TMW+hWN5n62NjtnhTVBwXkhqQSY30d1nREhgg/YCrW0js
 NH4Zhnwf0BDPib+ZqMqqA0cxjAkVVFL5pJ0dbJp7g03loqUvyW2jgjuyyU7PmP2ao8LxiMR
 iHPezXiQg3zUddCOpI7pA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IeGRfqxxpxo=:0ItybADxxjJfUmPcuoWbDx
 N6xFzX/mlnhERx1DL4deeK52EKGhthvHD2drEiVCsho1bIykqf8oWPPQ6VWKUwOl8kj2hYsUO
 rofgtM0qI/zD9HtPAD6WRUjwGZhvuHqnGhEzm38dcTO3kpXVwFtYHSWilXQ0/1TSEN+tGiy21
 3Hkn6BLQ4r0TckDzratN7AvvlfxTDNoqoAoQfc9LEEFGdbzTP8xa+0SFuWHiQksGAQFNywvtv
 sX3K8+oUWkREMXRyj3+YrrksRZ2lyllyrzzgMSTIs9SXBTjFWtjO/xDfZl86Jlt905NUQ7Iqx
 9Hs3wi4zzX17yJZ7KTRhHGjyeHkTabTaIjKdYmkvCEMPd9zBnaes+9SbL9RvprNHz25Jd1h5J
 ai8Ff1+kGtOA8SfNZtbpbkstY0eAYWe2ofzIGEVEnSMcBKPQjZcuWCFEN1093Jfnr05tIuk2s
 9fWkEnJqkbkbK8DboLQCnnMo3RBMS6BBJVORAn+odvXa/CmezLy4MlnNG6y70K6jjZ5Xhc3Ox
 VK98uKbkk7g+SQUiDach72EJPuoXD7oNVlWmJcKEBtCBN3DOlHMDDpQ3q8npcjOi9N/F0VXFM
 J64HwrbGeFQL6zzUHUBpYfNbc4ybh/QMpogZO+4C5HyHZPznC8eauLbP3YR8o7cyfXZmFwUaT
 4Q6TM0Ua0dC0KYLOIPyzTNIWdshHD4wc7xzY7ugyc/e6AgVkz/21DkZOu9AOH7gDQSbifpkuH
 lrWJmQ7pEeI6soxgv5ib5x1BxL5j7fQCWz6+23MuetTskdZSsI9Br1fbb8DF163G7npFwpKL/
 IT4vRFQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Over the next commits, we will work on improving the sequencer to the
point where it can process the edit script of an interactive rebase. To
that end, we will need to teach the sequencer to read interactive
rebase's todo file. In preparation, we consolidate all places where
that todo file is needed to call a function that we will later extend.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8d79091..982b6e9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -32,6 +32,11 @@ static const char *get_dir(const struct replay_opts *opts)
 	return git_path_seq_dir();
 }
 
+static const char *get_todo_path(const struct replay_opts *opts)
+{
+	return git_path_todo_file();
+}
+
 static int is_rfc2822_line(const char *buf, int len)
 {
 	int i;
@@ -772,25 +777,24 @@ static int parse_insn_buffer(char *buf, struct commit_list **todo_list,
 static int read_populate_todo(struct commit_list **todo_list,
 			struct replay_opts *opts)
 {
+	const char *todo_file = get_todo_path(opts);
 	struct strbuf buf = STRBUF_INIT;
 	int fd, res;
 
-	fd = open(git_path_todo_file(), O_RDONLY);
+	fd = open(todo_file, O_RDONLY);
 	if (fd < 0)
-		return error_errno(_("Could not open %s"),
-				   git_path_todo_file());
+		return error_errno(_("Could not open %s"), todo_file);
 	if (strbuf_read(&buf, fd, 0) < 0) {
 		close(fd);
 		strbuf_release(&buf);
-		return error(_("Could not read %s."), git_path_todo_file());
+		return error(_("Could not read %s."), todo_file);
 	}
 	close(fd);
 
 	res = parse_insn_buffer(buf.buf, todo_list, opts);
 	strbuf_release(&buf);
 	if (res)
-		return error(_("Unusable instruction sheet: %s"),
-			git_path_todo_file());
+		return error(_("Unusable instruction sheet: %s"), todo_file);
 	return 0;
 }
 
@@ -1064,7 +1068,7 @@ static int sequencer_continue(struct replay_opts *opts)
 {
 	struct commit_list *todo_list = NULL;
 
-	if (!file_exists(git_path_todo_file()))
+	if (!file_exists(get_todo_path(opts)))
 		return continue_single_pick();
 	if (read_populate_opts(opts) ||
 			read_populate_todo(&todo_list, opts))
-- 
2.10.0.rc1.114.g2bd6b38


