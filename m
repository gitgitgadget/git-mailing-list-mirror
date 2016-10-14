Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA8D6209AB
	for <e@80x24.org>; Fri, 14 Oct 2016 13:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755912AbcJNNTP (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 09:19:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:55777 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755409AbcJNNSW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 09:18:22 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MXZbS-1cRR6R2Q8k-00WS7W; Fri, 14 Oct 2016 15:18:13
 +0200
Date:   Fri, 14 Oct 2016 15:18:12 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 12/25] sequencer: remember the onelines when parsing the
 todo file
In-Reply-To: <cover.1476450940.git.johannes.schindelin@gmx.de>
Message-ID: <e356ddc226718e496d11bd5de5670dcb9eb64c77.1476450940.git.johannes.schindelin@gmx.de>
References: <cover.1476120229.git.johannes.schindelin@gmx.de> <cover.1476450940.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:R3ByCD5pm6vqcDBSiv/QCKX4bUfn0+SKXrOgx0YclhTaD08KmR4
 jkMi6zFvVBP9VSb3wEHvKLviqHu460sJrCCfXPEfWXdLoHM9QTf/6FuSx4aGRTGBxNsbEbi
 id9E+JFy5n/l0AneR0sdzcwA/3BejRb98qfrIcDSmD0s7xNF8nIQtIAGhUB5WMtfygY9wGI
 GYXBvuiwhvRhvOLOKpLdA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wK0/N4170qw=:S0KI41U9/erzNoR5Wj2hxd
 vYki0xWW6DQwHLlLwkhLLRdSXSmB2bXAitSqHzryi01W4xv/QOXxLcL5l/hMxW9QpLhhenB75
 ig2YqtUVbCnIA+NJz3WkvefH4gsJonvBXFW+yvoPHJO107m9VDFUk6/3Pxi81/6Q+BgiGC1SR
 smKkiCJ01WGmp+7kCc4dqCYdGhA1yKXfFFqpLlsJEPwA4igk7c6lM/Az+CKw0X1jDwMvqox0H
 o7moI1NxNjDYTGNyX0rqiVzQs32d7np8J0S+vHLSHMBYU8HG46Qmf5ryzR/d0ZxDcc5AN2aqo
 LVgTM4A2cuBDidnQ5WZzClquE6oX2tBYrkBXR+ywVZmKeeoE4yaxmxw4tPmLTiOuXHc73Alfh
 ZyqbbSW1byucHqVlSEQoyVGEfkip1fyQJZ7IRdjCSpG/ocf9G+/s0zVmvyajU1dVSX7LJqvx0
 9X95T2IS0jKzhZ6QZqzWzrQrPYClthuCfx6lKJBDDIkt0XZsHaQg0TpT3ANM3OsQN4+KmJK2S
 o6FPTyvZMqDexRF0Z5EaqK4o+8YMYnAe2pUq/ByKoRpwbL6yLRqXtQwXCupyhtpfI7Hq2rV11
 G4oi4zcTkUwnCDC1qN4qTfLp40q++JtWEgT/oB6uzNJyNvOU0/COMaSqePicM8w4ZJcal9Be3
 Brwg+CJPyouPT4020H/99n4ym0mwkEifqX1XahIb2oa5dwmKxIg3X7XXmbaj8KzAv8NOLWs+t
 EnKZeVGjWr013ElIu/RfhP+3dtGCwgf0nzYB9tqS/a7xGOgMP//r1PuV/dM/dYSnFIG5xg8rM
 2eepOw6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `git-rebase-todo` file contains a list of commands. Most of those
commands have the form

	<verb> <sha1> <oneline>

The <oneline> is displayed primarily for the user's convenience, as
rebase -i really interprets only the <verb> <sha1> part. However, there
are *some* places in interactive rebase where the <oneline> is used to
display messages, e.g. for reporting at which commit we stopped.

So let's just remember it when parsing the todo file; we keep a copy of
the entire todo file anyway (to write out the new `done` and
`git-rebase-todo` file just before processing each command), so all we
need to do is remember the begin offsets and lengths.

As we will have to parse and remember the command-line for `exec` commands
later, we do not call the field "oneline" but rather "arg" (and will reuse
that for exec's command-line).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 5e4bf23..caef51e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -706,6 +706,8 @@ static int read_and_refresh_cache(struct replay_opts *opts)
 struct todo_item {
 	enum todo_command command;
 	struct commit *commit;
+	const char *arg;
+	int arg_len;
 	size_t offset_in_buf;
 };
 
@@ -757,6 +759,9 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 	status = get_sha1(bol, commit_sha1);
 	*end_of_object_name = saved;
 
+	item->arg = end_of_object_name + strspn(end_of_object_name, " \t");
+	item->arg_len = (int)(eol - item->arg);
+
 	if (status < 0)
 		return -1;
 
@@ -907,6 +912,8 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 
 		item->command = command;
 		item->commit = commit;
+		item->arg = NULL;
+		item->arg_len = 0;
 		item->offset_in_buf = todo_list->buf.len;
 		subject_len = find_commit_subject(commit_buffer, &subject);
 		strbuf_addf(&todo_list->buf, "%s %s %.*s\n", command_string,
-- 
2.10.1.513.g00ef6dd


