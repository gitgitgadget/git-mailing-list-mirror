Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33C7A20229
	for <e@80x24.org>; Fri, 21 Oct 2016 12:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755434AbcJUMYq (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 08:24:46 -0400
Received: from mout.gmx.net ([212.227.15.15]:49844 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755300AbcJUMYp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 08:24:45 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Me86g-1cHziB2u6Q-00Ptia; Fri, 21 Oct 2016 14:24:33
 +0200
Date:   Fri, 21 Oct 2016 14:24:32 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 06/27] sequencer: future-proof read_populate_todo()
In-Reply-To: <cover.1477052405.git.johannes.schindelin@gmx.de>
Message-ID: <59de82a36f93a38acaa72c59c794c59604b507d2.1477052405.git.johannes.schindelin@gmx.de>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:FijiE2UxfV32yxjS7HtYDKqGAk9hT3x+kyxz4hgJWSakLSL/bxf
 FVd5hcU8/EVblB08SXKy/IimC/95k49pjxwdz4lQlhhndbQeNxA+cyqKl8bbYuJnf75i2v3
 4PvtnTxoycxWic/Km9yoNRM5R+aWD2p2PfIHAnP8r7BTREyV2uQDnxVHPazwfrAVh47ndMz
 wUQ/8WdGsLjSvivkx6+9A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:K2DNFBOsMRE=:ZNZgyXC7jBlp1ckTczi9VW
 WaOwKfE7+yThHhWtUBsqsXrZOwFt4T9d2YFNRU0C/1xW18mmbjOoAW1lv2ZRkpOGUXQWUNoUs
 sgq6z+Z+cNpapib7ajaWfj2rWs6hKRo+H/me4xazy4C6T/cKUbsHn5a2Z8l6JsVWf7IPKmo5t
 W2Zhnt4Kk5+WgKwMEQGMbHIM/Znm4slTwxv0ZgrSlcNav2cy2l29jmEu8ukEHzI87bkU9+UWH
 snnr7SSANr/wGm5vOjLsSONe8o6UXxQPtIbTzWMaqPPMEhqitjZPg5FGuUin04+Fk3uic1tpJ
 0iaTX9Rml2G+KxDIaslivs0Spx2idcMc8IwbisxcRs//lUhQbWONWfLBo31DhxmvWCV8Od9M9
 4I2re2la/3wdRUZoAIG4D6Krt1RCeTvlTLYXkf39f2ui5/x8IcfLLP16QVxcs4HzObKjyxNVc
 XiJCkf2mq9WTlLwNUAKpzjjoADDZWXbZIaf+LTXtL8GJg9iIKvGwjOZV1/hZJkqRK/GdXTXIT
 5O3Hxpez99AYVLHUnS1+rN6yNQHAZJr6TMaLcbFVHceA5eHO+Mz/OcoYNMSaH/MA26xYoLer8
 CWwd64GRPH/ShLcMFgQGSLWw0zVfINjHYzD6F0LFem3YTtlA7o9DMDBZiayjJdqECwtR4NST/
 UpsrpJZ7ganwNyhOfJfwEGpywf3X2n89RwOpYlU7SdG4hlsq7hH9BjBgDJ0e181teVSzGv0Zf
 SCuVaznPOTv6Fqa/rMorZw7eFI3/UOrA4owAAXc+o0Z1RO25DUGZe84NVrccIMtKtiTxmtaGV
 /qalXG4
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
index 04c55f2..fb0b94b 100644
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
 
@@ -1075,7 +1079,7 @@ static int sequencer_continue(struct replay_opts *opts)
 {
 	struct commit_list *todo_list = NULL;
 
-	if (!file_exists(git_path_todo_file()))
+	if (!file_exists(get_todo_path(opts)))
 		return continue_single_pick();
 	if (read_populate_opts(opts) ||
 			read_populate_todo(&todo_list, opts))
-- 
2.10.1.583.g721a9e0


