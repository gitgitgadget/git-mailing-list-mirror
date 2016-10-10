Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4473820989
	for <e@80x24.org>; Mon, 10 Oct 2016 17:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753196AbcJJRZQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:25:16 -0400
Received: from mout.gmx.net ([212.227.15.18]:60138 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753088AbcJJRZO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:25:14 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M3zT0-1b25rf1zec-00rWz0; Mon, 10 Oct 2016 19:25:05
 +0200
Date:   Mon, 10 Oct 2016 19:24:59 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 06/25] sequencer: future-proof read_populate_todo()
In-Reply-To: <cover.1476120229.git.johannes.schindelin@gmx.de>
Message-ID: <541259c114f37aac03bea5d8f0d63888bb5a69c6.1476120229.git.johannes.schindelin@gmx.de>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:sx8oEYF2CElvZj9HCI5U+NyFnmEVx4DjlwVU/mMq39X59wXZ8Sh
 J7hwwN2DsSKCtaHUIq2xl/w23kKpBzfPNx3aR8opy86ujcE1NOme2AEqODQqkLEpZ/xs7SN
 7SXHFqNl3r1IaEPKKDQe9kxLFMceWpfksUz2lBjqOFKp5+VuOVLFehu27INMDTuSbve21pN
 zYPTjp5Kd9xPjquEg+KNg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vOu4TNIPEMo=:HcJUFr2m9+hrsonZR5BvCn
 CeeSZmfM90xxs7nu2E1z6PuzKJqUoHPXnnboHcijmFfWSwR9Yf6x+HbGejGogu5dTKb5vTjWz
 2adlstFPo8mMSDfPTB1QU6KXc+rNGtB5ifNOS7wryFhyLvGwzAtJOs7OnItJ+/QcT67AkuvSK
 cIU/0pCegTgCOj80z1SONm2KXExucpaBhqBesv9R0hThutBM5i/eClQDgfFY2QW0Slrpp+Bp5
 IpjiJ/Ww3oIgv3ABmxf/G+yY9X0ELFjZbTLL9U2SK7Wb1qWSVvyuwKrjNtvk1jptm+olRUrPa
 tNK9Z3PpeEmY//7eOjeI0A4JIyzqOZ+obEn3ovzGjQC5+zyfsSsJJPMmf62yIOaTiec/J3HLU
 MDwDYsXyJIK613fhpr5skTcvBFriMj7GIduKBCfrfTaO0eF8lS+CJkAI0/C04pfAik3cQCCDL
 Bn9xkO7RRMHuFhd5kLxEehy6iVmaSe8LHKeiyo/HcaBvnr7AoYJuHN3VmKQKCc4ZREboxcomP
 ocSAVxfGBG3VL5J7u1IkakvortbPf99EUEaYctSZQkq3qFKJsffIOD4XTGp5V63BY6rqQaCEY
 iMlFEUccgarFxQj7dovxx3GYJO7eVcOiISza7ZR7bObYZ86ar+z9IbgvTtHhtvqykCSRbOE4e
 5Hz5MM1lj0GqY9htjFSLyh2ssAL34PvYcWr5q4dLA4avKvjCHJJ/IjdpDKwpsrvK4kLcuRqY7
 I+cciXmnDxKVhgwIE2ZSHdNuqFJ7A1rkVeYnarbiDQif3iKJniUfoJ1otR4aBf37im6EawFwF
 WQF6hqb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Over the next commits, we will work on improving the sequencer to the
point where it can process the todo script of an interactive rebase. To
that end, we will need to teach the sequencer to read interactive
rebase's todo file. In preparation, we consolidate all places where
that todo file is needed to call a function that we will later extend.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 22c31c8..4e00c5e 100644
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
@@ -769,25 +774,24 @@ static int parse_insn_buffer(char *buf, struct commit_list **todo_list,
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
 
@@ -1077,7 +1081,7 @@ static int sequencer_continue(struct replay_opts *opts)
 {
 	struct commit_list *todo_list = NULL;
 
-	if (!file_exists(git_path_todo_file()))
+	if (!file_exists(get_todo_path(opts)))
 		return continue_single_pick();
 	if (read_populate_opts(opts) ||
 			read_populate_todo(&todo_list, opts))
-- 
2.10.0.windows.1.325.ge6089c1


