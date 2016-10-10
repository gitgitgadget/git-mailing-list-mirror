Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEB3720989
	for <e@80x24.org>; Mon, 10 Oct 2016 17:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753311AbcJJR0I (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:26:08 -0400
Received: from mout.gmx.net ([212.227.17.21]:57575 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753248AbcJJR0A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:26:00 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MgsVY-1bXbEb3cO0-00M1d9; Mon, 10 Oct 2016 19:25:42
 +0200
Date:   Mon, 10 Oct 2016 19:25:38 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 12/25] sequencer: remember the onelines when parsing the
 todo file
In-Reply-To: <cover.1476120229.git.johannes.schindelin@gmx.de>
Message-ID: <f22bdcda3f748813e6b9fd08dc65f11c6f9f4b1e.1476120229.git.johannes.schindelin@gmx.de>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7sXsw31saCWK8O/Cdt/w4Dv87JkX2xAXfI61HHvTR9f3z1TvN0W
 cjYJdQbF0rx3tYLHxXDuy6J5wsl+Kj2iPAXgm5lvv6qKsfSh2zDLfnzX1YA83am1s32+tGT
 UsuM2z7uRJ6UpniMboiTr7wJE1FLrj1gSphqad0dFiSGti/y8vJejvSQQcwkEMS52NL/gSh
 aoFz1Ohc09keMwwIuXpmg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xziCcsOfyyM=:VZ7DucEwSgp1CMYAQw71wg
 sBhp5aN5PsRExshI17WspPDMx53/84vFhjRZS0Bl3mhCnpWmzX1V1H9QhOLGrJMYBSOM104Or
 DRHOxkPsSXyQSQIZFKJaTTOt2ikByFcbDr15lp+LFKSjRM4S7ewcsEGGZYMKVWd0K4/GvsX9T
 FVNkw6oNlQq2L79PrO6oUmC95yp/HtrysUSSzQ/+Pli2F2r4dT7zTc799W2pXRPJWJVzIgrXt
 orjr8C4W2tQ0qYUWEGAIssPgaokuaCecxNQfUpeZ1TDbcni6tSBckWBz0zWaqP//tTUpQMboR
 cU8CPq7YzAu0IbolO4iDIaB6J6eSrzJnT4xnDppDbG5jk1tCH9g/8WWEkr24+FgsUNh8qdgqj
 NV+L9bZkN52BALjZ4iXysL1yn1gKJSk/pJTX999fY2yH9vKtUX+S4aIiE9I6kIIFJBtsTv3S8
 V/zqol+A+YtMEQDdx9Z47VkBDZ0I+OwtTZpYwuRjpH2dR7AUZ+s43zjgmiP43Hbt5gAiJ+Ae7
 03p8KP8RSIZBJ2ZO1b6XMu1iKrRiFNOG1CzcLQUDP/fhQ9z3g971t15Uk32rw0kLpUhMQhIBE
 euygAdXpe2DwfANzdKAfrW9EWu9neoOTWK+abt1jYEnpVZb2ZVx25EE8OXB+OCflVY4ssYvRJ
 weJrGFwlCqk7VOUwvlIOpCk3JaOZyx7jVGMM/rjhkDpvFih15nIdiK533bB6ZHgD+1QqTf5Z2
 V7IYMQL/P264txieSyBhu20Qgb8mfKi3YwU2ELzJdLYaFOUqGKOmZx7kvb1RLH0SHSU8L1FJs
 5JAk9vw
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
index afc494e..7ba5e07 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -708,6 +708,8 @@ static int read_and_refresh_cache(struct replay_opts *opts)
 struct todo_item {
 	enum todo_command command;
 	struct commit *commit;
+	const char *arg;
+	int arg_len;
 	size_t offset_in_buf;
 };
 
@@ -759,6 +761,9 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 	status = get_sha1(bol, commit_sha1);
 	*end_of_object_name = saved;
 
+	item->arg = end_of_object_name + strspn(end_of_object_name, " \t");
+	item->arg_len = (int)(eol - item->arg);
+
 	if (status < 0)
 		return -1;
 
@@ -911,6 +916,8 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 
 		item->command = command;
 		item->commit = commit;
+		item->arg = NULL;
+		item->arg_len = 0;
 		item->offset_in_buf = todo_list->buf.len;
 		subject_len = find_commit_subject(commit_buffer, &subject);
 		strbuf_addf(&todo_list->buf, "%s %s %.*s\n", command_string,
-- 
2.10.0.windows.1.325.ge6089c1


