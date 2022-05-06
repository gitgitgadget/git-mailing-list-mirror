Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF7AC433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 18:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241768AbiEFSKb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 14:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiEFSK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 14:10:29 -0400
X-Greylist: delayed 140 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 May 2022 11:06:43 PDT
Received: from mailproxy01.manitu.net (mailproxy01.manitu.net [217.11.48.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DBE6A02C
        for <git@vger.kernel.org>; Fri,  6 May 2022 11:06:43 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a00:20:704b:4372:c7cc:d7c9:fd95:983d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy01.manitu.net (Postfix) with ESMTPSA id 75AD61260439;
        Fri,  6 May 2022 20:06:41 +0200 (CEST)
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] dir.c: avoid gcc warning
Date:   Fri,  6 May 2022 20:04:05 +0200
Message-Id: <cd50ec73ddafaaeba04298ae79cbf625cc0d7697.1651859773.git.git@grubix.eu>
X-Mailer: git-send-email 2.36.0.553.g068b50827d
In-Reply-To: <cover.1651859773.git.git@grubix.eu>
References: <cover.1651859773.git.git@grubix.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Related to -Wstringop-overread.

In fact, this may be a false positive, but reading until the correct end
is desirable here anyways.

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 26c4d141ab..32fcaae4c0 100644
--- a/dir.c
+++ b/dir.c
@@ -3145,7 +3145,7 @@ char *git_url_basename(const char *repo, int is_bundle, int is_bare)
 	 * result in a dir '2222' being guessed due to backwards
 	 * compatibility.
 	 */
-	if (memchr(start, '/', end - start) == NULL
+	if (memchr(start, '/', end - start + 1) == NULL
 	    && memchr(start, ':', end - start) != NULL) {
 		ptr = end;
 		while (start < ptr && isdigit(ptr[-1]) && ptr[-1] != ':')
-- 
2.36.0.553.g068b50827d

