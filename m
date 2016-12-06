Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED26C1FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 21:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752859AbcLFVxr (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 16:53:47 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36639 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751427AbcLFVxM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 16:53:12 -0500
Received: by mail-pg0-f46.google.com with SMTP id f188so153039919pgc.3
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 13:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I4Lf18rumm1AHZP9lwwNNNQN9GlFz5XyxeOiIC88LvY=;
        b=SOqv+2wg3GSw6XR7cnAsriMI433wBDpmd5SRLKwCMYMqbmYa493Tzh3EE9uGEjyf9i
         WNHeE614edYfF52UhVYOWxv1GKz0Vg3YxJZSNNCaQqZBhgRnrtb0NtircRvhZ683cm+R
         6exWw8dAw3DnmAfOXVSedA6XDvrRr6E42bOcoe4dyJBsie95S9UOG2BbzxV+nUQd1+23
         NaYOrnXQlHqbaL4EEm0hsgsVgVC9rxRYkYqADmJeyt82sX4UlteosTf6sH/m5Nr7hO3T
         CaABffUCy5pcr7R/k/0kOH4X3HegrKSjGQpZppmLldIlANNC09ctbS0ubt5PmYZ3r4L8
         u6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I4Lf18rumm1AHZP9lwwNNNQN9GlFz5XyxeOiIC88LvY=;
        b=P4ghhJO3PSs6/PkUd7h3W35LnbVTZFrjA+umCdpH8hgVbDLlsOX8nupCnmkQnIA9eE
         n1535WiFqIgIeg3UMw7oyHSF9WGdxkdDGE1ilWO0HZ+Qou97ikdxtPmcMj06p5710Iah
         TLhXHT3b51VZcxeyp5PumFjvFlCWBge/hbHizmKC2Kqa8k0JMlUnJlM23hSrkYt98Yea
         uPpXrTkeNr8SEInu1uhh5yyR0irtFG1x2Vxmadwxr2uoPkXYrZn6VlrC0CxnDMb6irJB
         +2X6B4KGPvvIfFuwED5KV+ShT8WjAkkadK7/veVYuZltQE7DqKfFUAiN+lH4ZbXs1nK9
         5vBQ==
X-Gm-Message-State: AKaTC01iCFwdieJEWmTt2nWDjZ2a5+rhDwyksff1p4SxBgUqwAWN5TcMQ8N8ChJu6ja17/Tu
X-Received: by 10.84.131.65 with SMTP id 59mr138509276pld.79.1481061142491;
        Tue, 06 Dec 2016 13:52:22 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id y89sm36940228pfk.83.2016.12.06.13.52.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Dec 2016 13:52:21 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 04/17] ls-tree: convert show_recursive to use the pathspec struct interface
Date:   Tue,  6 Dec 2016 13:51:33 -0800
Message-Id: <1481061106-117775-5-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481061106-117775-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'show_recursive()' to use the pathspec struct interface from
using the '_raw' entry in the pathspec struct.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-tree.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 0e30d86..e0f4307 100644
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
-- 
2.8.0.rc3.226.g39d4020

