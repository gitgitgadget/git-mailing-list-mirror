Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70ED0C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 00:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354264AbhLBAQM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 19:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354247AbhLBAQF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 19:16:05 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46BCC06175E
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 16:12:41 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 65534)
        id 21B715805951A; Thu,  2 Dec 2021 01:12:39 +0100 (CET)
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:10b:45d8::f8])
        by a3.inai.de (Postfix) with ESMTP id 9A6F058058C02
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 01:12:38 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] http-backend: give a hint that web browser access is not supported
Date:   Thu,  2 Dec 2021 01:12:38 +0100
Message-Id: <20211202001238.21808-2-jengelh@inai.de>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211202001238.21808-1-jengelh@inai.de>
References: <20211202001238.21808-1-jengelh@inai.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a paragraph that browsing to http-backend is not something
that should normally be done
 a webserver is configured to unconditionally pass requests
to git-http-backend, without any diversion to a gitweb frontend,
it is helpful to at least be told this.

Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---
 http-backend.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git http-backend.c http-backend.c
index 8f1b69d127..06e17d45a4 100644
--- http-backend.c
+++ http-backend.c
@@ -775,8 +775,15 @@ int cmd_main(int argc, const char **argv)
 		regfree(&re);
 	}
 
-	if (!cmd)
-		not_found(&hdr, "Request not supported: '%s'", dir);
+	if (!cmd) {
+		const char *hint = "";
+		if (strcmp(method, "GET") == 0)
+			hint = "You cannot use regular web browsing to access "
+			       "this URL. Only git operations like "
+			       "clone/ls-remote/etc. will work.\n";
+		not_found(&hdr, "%s request not supported on '%s'.\n%s",
+			  method, dir, hint);
+	}
 
 	setup_path();
 	if (!enter_repo(dir, 0))
-- 
2.34.0

