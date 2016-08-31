Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFAFB1F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759521AbcHaI4M (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:56:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:61134 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759421AbcHaI4J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:56:09 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M2FhY-1an3iL3AFI-00s8El; Wed, 31 Aug 2016 10:56:05
 +0200
Date:   Wed, 31 Aug 2016 10:56:05 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 26/34] sequencer (rebase -i): implement the 'drop' command
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <34bb14c610acc230d55d41c440c5763768c51814.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:DxfvsMDeQhPAioOO0r95Y+fuAxxkbhQsl92UqxyxhzclglgnDHv
 sDCQkR89IR+xnrg07v/ma5g9FpVe6sVejs0hm8RBxb8yqhfach96cbyWVsP6q2UhFE4kzdY
 j6e8aXOkABa/flPvn3lw9ED+yTVZ+L7P2isFjELKjpGwlZjAB0b0Dpj4Ty8uCeWphBeSdl5
 y5gL8YMz1zbhq0RYfFajQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hCgMTkdu754=:Howu36vZzYCXzf3Svb3gFh
 piC+rolDmiZqhoVt6Z79pbddO6rQlID1+E5YjNo3p4s1l3CRlJyff0B1IKViHkikFhfe9Vw6X
 sMLKJNIng+C/8PjhYsp50ahvqaavTRaUr1Zk9DoWc7mQy6pJBpw8qUtNECFiZx+eXij8bg7px
 dRYhJSVFWg3YE4Vo+IG5+VEvya0W/199XjWrhAuogMvb8P/VNqS3LS8vJ9miBjkAOix+OrYMv
 dkK4GEWGOBbBf/LSTXNgYFQICzuoObbbl8cvBHfUYvS62pEU1olk/1Fb6VdaKiIP7P9Cpr3cH
 vjqspamaj5nI/jYrsPPT4ElAVBFCXaduDuWog9coNmBDA/5JN9O3bRc/XTUziQLXtysZm+W3s
 6n0o5X34qBUnxDqzL77vKAaAh45ibWWKrkpJ4OCv2ekV1s+8si00UkPpJowLD3/qTNJhSYS5B
 oCDUI6WTvFCOKYQTIwu3DmuIvr0a++/3DYKfLD+xtOtEFTGFN1ZyIWNSQwdACU8gADxPn7Ktp
 rouJrY6NSkVi4sp9427oiE9p/2KTyVvaYCISiPGVKG4sXdz/sztCN6+CdTs1OCnptTUCRUkL5
 ebG8lTMaG6Rylpy96HTggL3jDz3dV10IkCkj1Rc+PZO/VDHV0SqZyfoUClzpF00ZW5PDjoPSe
 88wnkksWqhz2A5FE2XKnW+i2JDDqvKZPJOYRYP1EfjnPVpNeXwp18bd+P8+jGOYuhBybC6Dob
 KjRr/wCKI2p7Wye1GW/r1vhmedoWjQ9pJvXQkGgw60EECpnCUnWyn0VPmhHML0hGI0nFWtTWw
 6sCqsxt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The parsing part of a 'drop' command is almost identical to parsing a
'pick', while the operation is the same as that of a 'noop'.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 366ee78..51c2f76 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -762,7 +762,8 @@ enum todo_command {
 	TODO_FIXUP,
 	TODO_SQUASH,
 	TODO_EXEC,
-	TODO_NOOP
+	TODO_NOOP,
+	TODO_DROP
 };
 
 static struct {
@@ -776,7 +777,8 @@ static struct {
 	{ 'f', "fixup" },
 	{ 's', "squash" },
 	{ 'x', "exec" },
-	{ 0,   "noop" }
+	{ 0,   "noop" },
+	{ 'd', "drop" }
 };
 
 static const char *command_to_string(const enum todo_command command)
@@ -1309,7 +1311,7 @@ static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
 		else if (is_fixup(item->command))
 			return error("Cannot '%s' without a previous commit",
 				command_to_string(item->command));
-		else if (item->command != TODO_NOOP)
+		else if (item->command < TODO_NOOP)
 			fixup_okay = 1;
 		p = *eol ? eol + 1 : eol;
 	}
@@ -1800,7 +1802,7 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
 	int i;
 
 	for (i = todo_list->current + offset; i < todo_list->nr; i++)
-		if (todo_list->items[i].command != TODO_NOOP)
+		if (todo_list->items[i].command < TODO_NOOP)
 			return todo_list->items[i].command;
 
 	return -1;
@@ -1933,7 +1935,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			res = do_exec(item->arg);
 			*end_of_arg = saved;
 		}
-		else if (item->command != TODO_NOOP)
+		else if (item->command < TODO_NOOP)
 			return error("Unknown command %d", item->command);
 
 		todo_list->current++;
-- 
2.10.0.rc2.102.g5c102ec


