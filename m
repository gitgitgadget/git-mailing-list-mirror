Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2EA81FCC7
	for <e@80x24.org>; Fri, 10 Feb 2017 01:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751356AbdBJBdK (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 20:33:10 -0500
Received: from tomabrafix.de ([37.120.189.133]:45917 "EHLO tomabrafix.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751059AbdBJBdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 20:33:09 -0500
Received: from [10.21.23.122] (nat-wlan2.rrze.uni-erlangen.de [131.188.6.21])
        by tomabrafix.de (Postfix) with ESMTPSA id 91F6C4187A3
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 01:16:04 +0100 (CET)
To:     git@vger.kernel.org
From:   Tom Kunze <mail@tom-kunze.de>
Subject: [PATCH] help: show help for aliases
Message-ID: <137f35a4-ec2e-b8aa-c6a5-b17688eca61a@tomabrafix.de>
Date:   Fri, 10 Feb 2017 01:17:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If an alias is a single git command show the man page of the
aliased git command with --help.

Signed-off-by: Tom Kunze <mail@tom-kunze.de>
---
Hi,

I noticed that when I pass --help to an alias which is only a git
command it tells me a information about the alias. But it would be
nice if it instead opens the corresponding man page of the command.

There is a memory leak but in my opinion it can be ignored because
the process will be replaced anyway.

Regards,
Tom Kunze

PS: Please add me to cc as I am not subscribed.

 builtin/help.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/help.c b/builtin/help.c
index 49f7a07..655ed49 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -437,6 +437,10 @@ static const char *check_git_cmd(const char* cmd)

 	alias = alias_lookup(cmd);
 	if (alias) {
+		if (alias[0] != '!') {
+			strtok(alias, " \t\n");
+			return alias;
+		}
 		printf_ln(_("`git %s' is aliased to `%s'"), cmd, alias);
 		free(alias);
 		exit(0);
-- 
2.1.4
