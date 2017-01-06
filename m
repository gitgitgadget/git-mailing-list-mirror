Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A6B21FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 16:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967306AbdAFQXO (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 11:23:14 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:48251 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965034AbdAFQXK (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Jan 2017 11:23:10 -0500
X-AuditID: 12074414-773ff70000004a85-ad-586fc464f47e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id D0.EF.19077.464CF685; Fri,  6 Jan 2017 11:23:00 -0500 (EST)
Received: from bagpipes.fritz.box (p57906F4E.dip0.t-ipconnect.de [87.144.111.78])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v06GMmWt023262
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 6 Jan 2017 11:22:59 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 05/23] safe_create_leading_directories(): set errno on SCLD_EXISTS
Date:   Fri,  6 Jan 2017 17:22:25 +0100
Message-Id: <f8c5608152fb041e064268af001a986200bbd712.1483719289.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483719289.git.mhagger@alum.mit.edu>
References: <cover.1483719289.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsUixO6iqJt6JD/C4OhSRouuK91MFg29V5gt
        di/uZ7a4vWI+s8WSh6+ZLX609DBbdE6VdWD3+Pv+A5PHzll32T2WL13H6NHVfoTN41nvHkaP
        i5eUPT5vkgtgj+KySUnNySxLLdK3S+DKOPb7AFtBF0/F8ZdXmRoYD3J2MXJySAiYSPScusbW
        xcjFISRwmVHi7OYbzBDOCSaJjmsbmECq2AR0JRb1NIPZIgJqEhPbDrGAFDELfGCU+NU5ix0k
        ISwQKvGvby0LiM0ioCqxqm8WWAOvQJTExbl9zBDr5CQubfsCZnMKWEg07vrGCGILCZhLfJp4
        mHkCI88CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRboWermZJXqpKaWbGCEhJrKD8chJuUOM
        AhyMSjy8EV55EUKsiWXFlbmHGCU5mJREecMc8yOE+JLyUyozEosz4otKc1KLDzFKcDArifDa
        HQLK8aYkVlalFuXDpKQ5WJTEeb8tVvcTEkhPLEnNTk0tSC2CycpwcChJ8DYeBmoULEpNT61I
        y8wpQUgzcXCCDOcBGt4BUsNbXJCYW5yZDpE/xagoJc67BWSrAEgiozQPrheWAl4xigO9Iszb
        A9LOA0wfcN2vgAYzAQ0W9AQbXJKIkJJqYAytWKNUbdpgKB66r//6jPi2050Xd83w2P17jypn
        8t7qlXNZv/F9NJXTrrfd/sPx5ZXPc13Z2i1d3l/o3CH+8PLOF3FlS9XXTNZc/Ms/Rz+c87Bx
        1l4Dvjefgm8fvy+ifKbRZkKbNLfIbPkNOx+t8zSVEb37LDGDVVJo7qKps8oP6XHMUHX+9F2J
        pTgj0VCLuag4EQABMLc93AIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The exit path for SCLD_EXISTS wasn't setting errno, which some callers
use to generate error messages for the user. Fix the problem and
document that the function sets errno correctly to help avoid similar
regressions in the future.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h     | 5 +++--
 sha1_file.c | 4 +++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index a50a61a..8177c3a 100644
--- a/cache.h
+++ b/cache.h
@@ -1031,8 +1031,9 @@ int adjust_shared_perm(const char *path);
 
 /*
  * Create the directory containing the named path, using care to be
- * somewhat safe against races.  Return one of the scld_error values
- * to indicate success/failure.
+ * somewhat safe against races. Return one of the scld_error values to
+ * indicate success/failure. On error, set errno to describe the
+ * problem.
  *
  * SCLD_VANISHED indicates that one of the ancestor directories of the
  * path existed at one point during the function call and then
diff --git a/sha1_file.c b/sha1_file.c
index 10395e7..ae8f0b4 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -137,8 +137,10 @@ enum scld_error safe_create_leading_directories(char *path)
 		*slash = '\0';
 		if (!stat(path, &st)) {
 			/* path exists */
-			if (!S_ISDIR(st.st_mode))
+			if (!S_ISDIR(st.st_mode)) {
+				errno = ENOTDIR;
 				ret = SCLD_EXISTS;
+			}
 		} else if (mkdir(path, 0777)) {
 			if (errno == EEXIST &&
 			    !stat(path, &st) && S_ISDIR(st.st_mode))
-- 
2.9.3

