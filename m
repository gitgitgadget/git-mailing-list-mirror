Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 185E5207EB
	for <e@80x24.org>; Fri, 28 Apr 2017 14:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034213AbdD1ODd (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 10:03:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:55282 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031528AbdD1OD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 10:03:29 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MVNDK-1dbd0H0N8o-00YiWa; Fri, 28
 Apr 2017 16:03:23 +0200
Date:   Fri, 28 Apr 2017 16:03:22 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v2 14/25] setup_discovered_git_dir(): help static analysis
In-Reply-To: <cover.1493387231.git.johannes.schindelin@gmx.de>
Message-ID: <cbd8e917f1318190d9f979f4cc9b62dcd838bbb0.1493387231.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <cover.1493387231.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:He1ZzGG0kwuG2evpNZC1xQhGfH5hcCQGMsDKtU4udaSF9r6sp/s
 SzKn34VS9urXyafkEuL90o8OFgXTAeTOLINqdMmspWU8s7l2JxVm9gXtjS74F0Ts5OCU+Uw
 5f1NKjDxj9L0YPlTJnrhJd0oQqTP5+kcGQgCg4YGbUvoGl5e/Y9dUJriOPGSRUfxT6zBOCH
 +YS1mkgGG3O/KJPmHoHGA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sKn8N2x7COQ=:KS9MTB8Z3KgOHyomkVnGUd
 zyE6gX36sEkByiP2ecvP5UtscCVJlBicZWoPSfPrH6F1vV8AuuBcBdL21jip943pFCMt4joia
 qqHU4Lwn08MKbHxr1lBluAIi6UMy5q0JQuxJxNFlSXI8xT1YFd+I86PtDOAU3l8zGw+1LgllD
 s69UGSojHfkZSUUTEEJ67rUvYAvSAbncVgHeYPq8ppqxnV1aIXsGmLpWxRX36/eVWAJ+d53hr
 V6ODQMZews/C2GVQtje5XvpmI4SVHxhJONVcPQwPNOPz/B/KLSOCdgYHZfTZyM7E5Uaq7/C7G
 HSzeWVDEF11m31vNZLlqvdEKYy1914JiAf4c8+e1XutqJmMJgKvtOznJqxWRVt2t3wP8BnK7Q
 LMYSxibpQlycUeQxGK8q4XYGRMJul2scEcdoP0KZw8VyjgxXiLAUWxLKY9f5Ea1WjvkJYZpeh
 8OkyXeD91+F2Q312nlYDhWxFKBF0dmAyILYMJYlUZMwzMAeeMiE0xzHb8FggsBVmuP2G7r7S6
 DZNyVagt6lRovbioNdSMGFX5YKXRxHM/nyIcgiuZB3vfRJ8rIjIVEKUNBZg/GmHG2xGfmrY3T
 Qd84X+Mw4xqKNkRLHjrkrAFIN9XHchXjgktaFTYz/koLVZ9HiFZh5jrtz6OTk8hATo4HQLncJ
 BZBsiJiwyicn4T0VY9sLXWOJEVEjeedDoEcPq4vo4EBqObC+N9v3yn6oMO890MNDYOF8A+JSh
 BrgrhYx/dksW33TCtBltF6QiN8OS7+qms5zYzsO9Tu47HO0r1UdLuMZeXpRmao2BXWJLFzBzu
 vnI7o0B
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Coverity reported a memory leak in this function. However, it can only
be called once, as setup_git_directory() changes global state and hence
is not reentrant.

Mark the variable as static to indicate that this is a singleton.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 setup.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index 0320a9ad14c..12efca85a41 100644
--- a/setup.c
+++ b/setup.c
@@ -703,11 +703,16 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 
 	/* --work-tree is set without --git-dir; use discovered one */
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
+		char *p = NULL;
+		const char *ret;
+
 		if (offset != cwd->len && !is_absolute_path(gitdir))
-			gitdir = real_pathdup(gitdir, 1);
+			gitdir = p = real_pathdup(gitdir, 1);
 		if (chdir(cwd->buf))
 			die_errno("Could not come back to cwd");
-		return setup_explicit_git_dir(gitdir, cwd, nongit_ok);
+		ret = setup_explicit_git_dir(gitdir, cwd, nongit_ok);
+		free(p);
+		return ret;
 	}
 
 	/* #16.2, #17.2, #20.2, #21.2, #24, #25, #28, #29 (see t1510) */
-- 
2.12.2.windows.2.800.gede8f145e06


