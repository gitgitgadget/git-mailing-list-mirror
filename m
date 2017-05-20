Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 104DB201CF
	for <e@80x24.org>; Sat, 20 May 2017 06:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbdETG3Y (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 02:29:24 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:53957 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751208AbdETG3X (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 02:29:23 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wVFPs5fhbz5tlB;
        Sat, 20 May 2017 08:29:21 +0200 (CEST)
Received: from dx.site (localhost [127.0.0.1])
        by dx.site (Postfix) with ESMTP id 4CA7C42E7;
        Sat, 20 May 2017 08:29:21 +0200 (CEST)
From:   Johannes Sixt <j6t@kdbg.org>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 1/2] mingw.h: permit arguments with side effects for is_dir_sep
Date:   Sat, 20 May 2017 08:28:38 +0200
Message-Id: <69bafb7c9e08ba837a9b92573bef165a62c5bf92.1495261020.git.j6t@kdbg.org>
X-Mailer: git-send-email 2.13.0.55.g17b7d13330
In-Reply-To: <cover.1495261020.git.j6t@kdbg.org>
References: <cover.1495261020.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The implementation of is_dir_sep in git-compat-util.h uses an inline
function. Use one also for the implementation in compat/mingw.h to support
non-trivial argument expressions.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 compat/mingw.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index cdc112526a..5e8447019b 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -398,7 +398,11 @@ HANDLE winansi_get_osfhandle(int fd);
 	(isalpha(*(path)) && (path)[1] == ':' ? 2 : 0)
 int mingw_skip_dos_drive_prefix(char **path);
 #define skip_dos_drive_prefix mingw_skip_dos_drive_prefix
-#define is_dir_sep(c) ((c) == '/' || (c) == '\\')
+static inline int mingw_is_dir_sep(int c)
+{
+	return c == '/' || c == '\\';
+}
+#define is_dir_sep mingw_is_dir_sep
 static inline char *mingw_find_last_dir_sep(const char *path)
 {
 	char *ret = NULL;
-- 
2.13.0.55.g17b7d13330

