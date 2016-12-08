Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 107751FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 19:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753715AbcLHS7f (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 13:59:35 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:36283 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753017AbcLHS7b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 13:59:31 -0500
Received: by mail-pg0-f45.google.com with SMTP id f188so176158568pgc.3
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 10:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JcrjzCUYxF9imA8cG3BxSic9z8N+qd6wM1l7/aX3Acw=;
        b=SwibGub28DfbL4kHV7x/5OK9lxfPu4qEJxc9n2I2ooPUcb4a1Pv9bOOV7kpes3G1PY
         E8aOxUNbEBCLxqURrq5fudcuAZ1VvsVObjR+VlQYIOynF+bAQvtvqu3KBYpiLIjvp+51
         pElDHuB+Ne3UyRJit+af9kt/z7MCyP4FiWJS9SboF/m9x+La9W4cyZwebi9aYRsQqkRb
         cRL/IRkNOnE2NQmquLcu6tw8Ts8+UQouP9upZETPZ7mvYzq5uUEmzaN89ufzYZt8nVz9
         W+b2ZmaEWdcd7t7hkZCEFIABzIrGienIOrd6SXuOxB3RL1edrq+57aoUuZkCfTR1uUf3
         fOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JcrjzCUYxF9imA8cG3BxSic9z8N+qd6wM1l7/aX3Acw=;
        b=NpG1wXHhyux/aGUsjDc9eGEmosLALqnF5CdATFCFNMIUsOzUXc11Ciua8zKRMOpa1T
         qkKgr+h7a+qYLk+Y81fL0iO/DOLaEhKipq9QmcsobIx+/n6AqnWsxWfEwO2DlTOWJiNh
         sbuhoKNricFIpoYq7+3/hZPYXY4hKH1Yu8RzVB74U552/hpLMKyfHmZ68NWEoOSqnsQW
         WSCicGzeuQljRxE7SbdGOrwdclU6hxRNvlf1kGC7NYD/zIvDp5dPJ3zvwAIpzswTiVPc
         RbAkwg48HJVMAARDWgPdwIC+pE+gwuKXPulIjol+36eIN1VMqpqNHdBB/We+mcrCaRfy
         NcTw==
X-Gm-Message-State: AKaTC03N9Xh+ARGmzQxe8Y8m+R7tnSEUWqUMEReb6lLmGtC764F40nzeHI3kNP6t8gTMZQ8v
X-Received: by 10.99.4.213 with SMTP id 204mr134362868pge.77.1481223570739;
        Thu, 08 Dec 2016 10:59:30 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id p64sm51815634pfi.88.2016.12.08.10.59.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 10:59:29 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v2 04/16] ls-tree: convert show_recursive to use the pathspec struct interface
Date:   Thu,  8 Dec 2016 10:58:58 -0800
Message-Id: <1481223550-65277-5-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481223550-65277-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481223550-65277-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'show_recursive()' to use the pathspec struct interface from
using the '_raw' entry in the pathspec struct.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-tree.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 0e30d86..d7ebeb4 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -31,21 +31,18 @@ static const  char * const ls_tree_usage[] = {
 
 static int show_recursive(const char *base, int baselen, const char *pathname)
 {
-	const char **s;
+	int i;
 
 	if (ls_options & LS_RECURSIVE)
 		return 1;
 
-	s = pathspec._raw;
-	if (!s)
+	if (!pathspec.nr)
 		return 0;
 
-	for (;;) {
-		const char *spec = *s++;
+	for (i = 0; i < pathspec.nr; i++) {
+		const char *spec = pathspec.items[i].match;
 		int len, speclen;
 
-		if (!spec)
-			return 0;
 		if (strncmp(base, spec, baselen))
 			continue;
 		len = strlen(pathname);
@@ -59,6 +56,7 @@ static int show_recursive(const char *base, int baselen, const char *pathname)
 			continue;
 		return 1;
 	}
+	return 0;
 }
 
 static int show_tree(const unsigned char *sha1, struct strbuf *base,
@@ -175,8 +173,8 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	 * cannot be lifted until it is converted to use
 	 * match_pathspec() or tree_entry_interesting()
 	 */
-	parse_pathspec(&pathspec, PATHSPEC_GLOB | PATHSPEC_ICASE |
-				  PATHSPEC_EXCLUDE,
+	parse_pathspec(&pathspec, PATHSPEC_ALL_MAGIC &
+				  ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
 		       PATHSPEC_PREFER_CWD,
 		       prefix, argv + 1);
 	for (i = 0; i < pathspec.nr; i++)
-- 
2.8.0.rc3.226.g39d4020

