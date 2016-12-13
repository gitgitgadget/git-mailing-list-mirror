Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97ECC2042F
	for <e@80x24.org>; Tue, 13 Dec 2016 15:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933362AbcLMPhM (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:37:12 -0500
Received: from mout.gmx.net ([212.227.17.22]:52548 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933224AbcLMPhL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:37:11 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ls7MZ-1clauE47CB-013zSK; Tue, 13
 Dec 2016 16:30:34 +0100
Date:   Tue, 13 Dec 2016 16:30:30 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 10/34] sequencer (rebase -i): allow continuing with staged
 changes
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <9978c32139c522c08d5a8f685011829cc830bfc0.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:YhVR3x4VgID1xwRA5TUpYkRMvNKMrf+pKRShOR889mpYSFgiWoH
 S+NYyJ7w7nGOV33OI9fB0WpRgr0D0VAzhKQK6zDePt/Z6qYr//u24ovRbCeOyz7el6Rh906
 ZpiEaWUUGRoT0cwyec8rILSou0pWKXq2rQGsHmXgmbJwnm+pnztnO7sD2l5bG5CHKVGGdIw
 TaW2VwXjbsH+O9j3iM2eg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZGmvPf3N/sY=:NyT5T3xmTQjhnlaF0MxrpS
 HzLnFXLFvTuVREcsu1VDUvwYt3c1FFIXsQBQ79HDFvBW6D95722tjZYaQxwlPmvv1CRwYDqhh
 +10XAT/7NTT5lzHnLAyjLTgpko74c48RJsR7eEX4OiTddksIg2KpM6boAvn/5Nn0kUXNLsdTd
 i38mGDvPXx1hQlaHVG3ap8QQeAWHUo5HGLLSfPinMSIgNtFVKBZU8XhN+V7+mnzGMiRFUJY4l
 UJhhTxM32tqS/eTGmJqHglJv5fw0A8zmb+DWi+c66eDQ/fLO1iDA9HR7Mviyn+ryPO3ZB+xC6
 6iUc+yPBTv0/5RWdizb/45Go4l4ioR07d1eHcbp8ifm6G3Oj4ODxvdgA+fGWWVwU9j0rz+S8V
 VHEZdZf1jo5qd5fKBs3c2xYCIfqqljow8t9TKrSk9jTnFo9syVqWH3Lly9lOZ8Ss0URZBxuW7
 QxWbiTAcJCx89j/4xx8UjEOZ9WBPp5qYVmrOcNcvtpmaFgZTqxEfLD4rZ0N4lJBpjjiGxH1NY
 RcD61sSt6CiBN8oOcIhYm3cNNIelc8SLdz33sQe9aSw2yFSwg5VFRNf3MoKPltvj46ct5r7oz
 XfkJoeGRn05W8Hu+L/HHfrtdXNkdwXmATZ5vZLD9ReSWBFkRvYcLSwA8mywNtPLycGwQ5fzBp
 sqW+DE2xlJv7NYO+UclqShaFO11HHO7NZuQr/7XbgS0KN41TtPQT5/ayf7Nt0w6ltybzM/gRw
 MJ6He4rAL9/VmGwZFXXmYW4ltfk6cgPwGDeCU/aXxHtqXDIreZkhaV8JqJxt8AsWIhMQi9ltr
 1E9eA+K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When an interactive rebase is interrupted, the user may stage changes
before continuing, and we need to commit those changes in that case.

Please note that the nested "if" added to the sequencer_continue() is
not combined into a single "if" because it will be extended with an
"else" clause in a later patch in this patch series.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 80469b6954..855d3ba503 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1829,6 +1829,42 @@ static int continue_single_pick(void)
 	return run_command_v_opt(argv, RUN_GIT_CMD);
 }
 
+static int commit_staged_changes(struct replay_opts *opts)
+{
+	int amend = 0;
+
+	if (has_unstaged_changes(1))
+		return error(_("cannot rebase: You have unstaged changes."));
+	if (!has_uncommitted_changes(0))
+		return 0;
+
+	if (file_exists(rebase_path_amend())) {
+		struct strbuf rev = STRBUF_INIT;
+		unsigned char head[20], to_amend[20];
+
+		if (get_sha1("HEAD", head))
+			return error(_("cannot amend non-existing commit"));
+		if (!read_oneliner(&rev, rebase_path_amend(), 0))
+			return error(_("invalid file: '%s'"), rebase_path_amend());
+		if (get_sha1_hex(rev.buf, to_amend))
+			return error(_("invalid contents: '%s'"),
+				rebase_path_amend());
+		if (hashcmp(head, to_amend))
+			return error(_("\nYou have uncommitted changes in your "
+				       "working tree. Please, commit them\n"
+				       "first and then run 'git rebase "
+				       "--continue' again."));
+
+		strbuf_release(&rev);
+		amend = 1;
+	}
+
+	if (run_git_commit(rebase_path_message(), opts, 1, 1, amend, 0))
+		return error(_("could not commit staged changes."));
+	unlink(rebase_path_amend());
+	return 0;
+}
+
 int sequencer_continue(struct replay_opts *opts)
 {
 	struct todo_list todo_list = TODO_LIST_INIT;
@@ -1837,6 +1873,10 @@ int sequencer_continue(struct replay_opts *opts)
 	if (read_and_refresh_cache(opts))
 		return -1;
 
+	if (is_rebase_i(opts)) {
+		if (commit_staged_changes(opts))
+			return -1;
+	}
 	if (!file_exists(get_todo_path(opts)))
 		return continue_single_pick();
 	if (read_populate_opts(opts))
-- 
2.11.0.rc3.windows.1


