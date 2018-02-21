Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27E701F404
	for <e@80x24.org>; Wed, 21 Feb 2018 01:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751517AbeBUBzW (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 20:55:22 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42454 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751484AbeBUBzS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 20:55:18 -0500
Received: by mail-pf0-f195.google.com with SMTP id t15so55176pfh.9
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 17:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hRYBAIqs91/gRw7AkdC8/7+EV7f8gvJzseJHd7tZx9s=;
        b=hNM4+sXdbNwrgz9RQLF9KJkEtA4MsMmX8mvRdJ8INwDy2v4Ye8NJnU9awQKS2xbpJV
         BUyEMclXoCu4FCyhkffeXdCQLslOlBQhbWoTT5oqDcw58FPKPVIcQdRjDBeY/wZIQq7G
         wTi9U+O76ANUPgsdzpjJRH28/iYUa+BjEjuAFwzyr/yAuFgTJSJ8FEUJrTuz3FVV0uKz
         01crYPjBoZxWqmesGSic4sDPzkxblaWxiUBQvJVENzf3twPXU/SOeuJvyKYOEZvx0DCP
         pAqIHndMoN2BzVs4x4LkhXMisTE1IFRMp2r9GhWsi4n9VAb4NpPHhPBJTR5geRAoKEB4
         ed4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hRYBAIqs91/gRw7AkdC8/7+EV7f8gvJzseJHd7tZx9s=;
        b=e5ziGngwQqMRJvVFaiCmKdAO6U5gkUCHZ0UL9XEIExhitbCkkOUaDK7gYJobylYN6A
         Lspzp6p1IY5TZKqrbRHJv1alKvM+FRHHe6EPgPXflI559StyF9/jXl/5CFFwLNEVmMBE
         DCcN5Z4TXWm8g8dJ9hAELrBXlg9gLuJSAzLTp8YicQNIdTWsj8crapEhMlZ280IGm4+j
         /+t3rWgb4B+0a5p5TB+2e8vPYgcsRfUk5eHisIwgaSd52rIXAlepSBPUaB4fytc0sP5J
         gqnIBwNFQHhcyOFx0cNwwer1xG+R15JBiAI0TDwxSeS5/hOo52LWj2d73BSkyMXlf9D4
         XsKA==
X-Gm-Message-State: APf1xPD7bzkqgr+dtJ52WB/b7LSYtIVAEpIVEelJiIHzehHwBKwdYXtM
        2atRIXjekJr15Pe1GpF1Rouh3swnJbc=
X-Google-Smtp-Source: AH8x227gijp5TL4uCqSAJ835cL49PzIGRME4MkNLHXb2n/qTngNC8+YCg5FcP8L8LYn7gK7qXG1njg==
X-Received: by 10.99.152.70 with SMTP id l6mr1270852pgo.87.1519178117428;
        Tue, 20 Feb 2018 17:55:17 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id n24sm73204262pfi.175.2018.02.20.17.55.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 17:55:16 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 23/27] sha1_file: allow stat_sha1_file to handle arbitrary repositories
Date:   Tue, 20 Feb 2018 17:54:26 -0800
Message-Id: <20180221015430.96054-24-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180221015430.96054-1-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 8fad523d85..6879af8993 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -874,23 +874,22 @@ int git_open_cloexec(const char *name, int flags)
  * Note that it may point to static storage and is only valid until another
  * call to sha1_file_name(), etc.
  */
-#define stat_sha1_file(r, s, st, p) stat_sha1_file_##r(s, st, p)
-static int stat_sha1_file_the_repository(const unsigned char *sha1,
-					 struct stat *st, const char **path)
+static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
+			  struct stat *st, const char **path)
 {
 	struct alternate_object_database *alt;
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
-	sha1_file_name(the_repository, &buf, sha1);
+	sha1_file_name(r, &buf, sha1);
 	*path = buf.buf;
 
 	if (!lstat(*path, st))
 		return 0;
 
-	prepare_alt_odb(the_repository);
+	prepare_alt_odb(r);
 	errno = ENOENT;
-	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
+	for (alt = r->objects.alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		if (!lstat(*path, st))
 			return 0;
-- 
2.16.1.291.g4437f3f132-goog

