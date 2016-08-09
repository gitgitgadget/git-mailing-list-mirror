Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCBB91F859
	for <e@80x24.org>; Tue,  9 Aug 2016 14:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbcHIOQl (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 10:16:41 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:35009 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752449AbcHIOQk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 10:16:40 -0400
Received: from [77.117.29.131] (smtpout1.drei.com [109.126.64.1])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3s7xD536yYz5tlB;
	Tue,  9 Aug 2016 16:16:37 +0200 (CEST)
To:	Git Mailing List <git@vger.kernel.org>
From:	Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 1/2] config.c: avoid duplicated global static variables
Message-ID: <57A9E5C1.3030205@kdbg.org>
Date:	Tue, 9 Aug 2016 16:16:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Repeating the definition of a static variable seems to be valid in C.
Nevertheless, it is bad style because it can cause confusion, definitely
when it becomes necessary to change the type.

d64ec16 (git config: reorganize to use parseopt, 2009-02-21) added two
static variables near the top of the file config.c without removing the
definitions of the two variables that occurs later in the file.

The two variables were needed earlier in the file in the newly
introduced parseopt structure. These references were removed later in
d0e08d6 (config: fix parsing of "git config --get-color some.key -1",
2014-11-20).

Remove the redundant, younger, definitions near the top of the file and
keep the original definitions that occur later.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Why the heck are duplicated static variables not an error in C?
 Since they aren't (as it seems), this and the next patch are just
 a matter of taste.

 builtin/config.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index a991a53..6cbf733 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -25,7 +25,6 @@ static char term = '\n';
 static int use_global_config, use_system_config, use_local_config;
 static struct git_config_source given_config_source;
 static int actions, types;
-static const char *get_color_slot, *get_colorbool_slot;
 static int end_null;
 static int respect_includes = -1;
 static int show_origin;
-- 
2.9.2.935.gccae72a.dirty

