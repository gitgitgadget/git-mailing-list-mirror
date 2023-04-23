Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3CDC77B76
	for <git@archiver.kernel.org>; Sun, 23 Apr 2023 09:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjDWJNH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Apr 2023 05:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjDWJNG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2023 05:13:06 -0400
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF4B1727
        for <git@vger.kernel.org>; Sun, 23 Apr 2023 02:13:04 -0700 (PDT)
Received: from [2400:4160:1877:2b00:1bad:b006:fd5f:b52b] (helo=glandium.org)
        by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <glandium@glandium.org>)
        id 1pqVmF-00DHWJ-0E;
        Sun, 23 Apr 2023 09:12:59 +0000
Received: from glandium by goemon.lan with local (Exim 4.94.2)
        (envelope-from <glandium@goemon>)
        id 1pqVmA-00As4m-0w; Sun, 23 Apr 2023 18:12:54 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Mike Hommey <mh@glandium.org>
Subject: [PATCH] Handle compiler versions containing a dash
Date:   Sun, 23 Apr 2023 18:12:49 +0900
Message-Id: <20230423091249.2591136-1-mh@glandium.org>
X-Mailer: git-send-email 2.40.0.1.gc689dad23e
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The version reported by e.g. x86_64-w64-mingw32-gcc on Debian bullseye
looks like:
  gcc version 10-win32 20210110 (GCC)

This ends up with detect-compiler failing with:
  ./detect-compiler: 30: test: Illegal number: 10-win32

This change removes the -win32 part by excluding the dash and everything
that follows from the version.
---
 detect-compiler | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/detect-compiler b/detect-compiler
index 50087f5670..d961df5fb5 100755
--- a/detect-compiler
+++ b/detect-compiler
@@ -17,7 +17,7 @@ get_family() {
 }
 
 get_version() {
-	get_version_line | sed 's/^.* version \([0-9][^ ]*\).*/\1/'
+	get_version_line | sed 's/^.* version \([0-9][^ -]*\).*/\1/'
 }
 
 print_flags() {
-- 
2.40.0.1.gc689dad23e

